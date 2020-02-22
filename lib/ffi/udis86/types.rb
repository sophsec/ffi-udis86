require 'ffi'

module FFI
  module UDis86
    extend FFI::Library

    # Disassembly modes
    MODES = Set[
      16,
      32,
      64
    ]

    # Supported vendors
    VENDORS = [:amd, :intel]

    # From udis86-1.7.2/libudis86/itab.h
    enum :ud_mnemonic_code, [
      :ud_iinvalid,
      :ud_i3dnow,
      :ud_inone,
      :ud_idb,
      :ud_ipause,
      :ud_iaaa,
      :ud_iaad,
      :ud_iaam,
      :ud_iaas,
      :ud_iadc,
      :ud_iadd,
      :ud_iaddpd,
      :ud_iaddps,
      :ud_iaddsd,
      :ud_iaddss,
      :ud_iand,
      :ud_iandpd,
      :ud_iandps,
      :ud_iandnpd,
      :ud_iandnps,
      :ud_iarpl,
      :ud_imovsxd,
      :ud_ibound,
      :ud_ibsf,
      :ud_ibsr,
      :ud_ibswap,
      :ud_ibt,
      :ud_ibtc,
      :ud_ibtr,
      :ud_ibts,
      :ud_icall,
      :ud_icbw,
      :ud_icwde,
      :ud_icdqe,
      :ud_iclc,
      :ud_icld,
      :ud_iclflush,
      :ud_iclgi,
      :ud_icli,
      :ud_iclts,
      :ud_icmc,
      :ud_icmovo,
      :ud_icmovno,
      :ud_icmovb,
      :ud_icmovae,
      :ud_icmovz,
      :ud_icmovnz,
      :ud_icmovbe,
      :ud_icmova,
      :ud_icmovs,
      :ud_icmovns,
      :ud_icmovp,
      :ud_icmovnp,
      :ud_icmovl,
      :ud_icmovge,
      :ud_icmovle,
      :ud_icmovg,
      :ud_icmp,
      :ud_icmppd,
      :ud_icmpps,
      :ud_icmpsb,
      :ud_icmpsw,
      :ud_icmpsd,
      :ud_icmpsq,
      :ud_icmpss,
      :ud_icmpxchg,
      :ud_icmpxchg8b,
      :ud_icmpxchg16b,
      :ud_icomisd,
      :ud_icomiss,
      :ud_icpuid,
      :ud_icvtdq2pd,
      :ud_icvtdq2ps,
      :ud_icvtpd2dq,
      :ud_icvtpd2pi,
      :ud_icvtpd2ps,
      :ud_icvtpi2ps,
      :ud_icvtpi2pd,
      :ud_icvtps2dq,
      :ud_icvtps2pi,
      :ud_icvtps2pd,
      :ud_icvtsd2si,
      :ud_icvtsd2ss,
      :ud_icvtsi2ss,
      :ud_icvtss2si,
      :ud_icvtss2sd,
      :ud_icvttpd2pi,
      :ud_icvttpd2dq,
      :ud_icvttps2dq,
      :ud_icvttps2pi,
      :ud_icvttsd2si,
      :ud_icvtsi2sd,
      :ud_icvttss2si,
      :ud_icwd,
      :ud_icdq,
      :ud_icqo,
      :ud_idaa,
      :ud_idas,
      :ud_idec,
      :ud_idiv,
      :ud_idivpd,
      :ud_idivps,
      :ud_idivsd,
      :ud_idivss,
      :ud_iemms,
      :ud_ienter,
      :ud_if2xm1,
      :ud_ifabs,
      :ud_ifadd,
      :ud_ifaddp,
      :ud_ifbld,
      :ud_ifbstp,
      :ud_ifchs,
      :ud_ifclex,
      :ud_ifcmovb,
      :ud_ifcmove,
      :ud_ifcmovbe,
      :ud_ifcmovu,
      :ud_ifcmovnb,
      :ud_ifcmovne,
      :ud_ifcmovnbe,
      :ud_ifcmovnu,
      :ud_ifucomi,
      :ud_ifcom,
      :ud_ifcom2,
      :ud_ifcomp3,
      :ud_ifcomi,
      :ud_ifucomip,
      :ud_ifcomip,
      :ud_ifcomp,
      :ud_ifcomp5,
      :ud_ifcompp,
      :ud_ifcos,
      :ud_ifdecstp,
      :ud_ifdiv,
      :ud_ifdivp,
      :ud_ifdivr,
      :ud_ifdivrp,
      :ud_ifemms,
      :ud_iffree,
      :ud_iffreep,
      :ud_ificom,
      :ud_ificomp,
      :ud_ifild,
      :ud_ifincstp,
      :ud_ifninit,
      :ud_ifiadd,
      :ud_ifidivr,
      :ud_ifidiv,
      :ud_ifisub,
      :ud_ifisubr,
      :ud_ifist,
      :ud_ifistp,
      :ud_ifisttp,
      :ud_ifld,
      :ud_ifld1,
      :ud_ifldl2t,
      :ud_ifldl2e,
      :ud_ifldpi,
      :ud_ifldlg2,
      :ud_ifldln2,
      :ud_ifldz,
      :ud_ifldcw,
      :ud_ifldenv,
      :ud_ifmul,
      :ud_ifmulp,
      :ud_ifimul,
      :ud_ifnop,
      :ud_ifpatan,
      :ud_ifprem,
      :ud_ifprem1,
      :ud_ifptan,
      :ud_ifrndint,
      :ud_ifrstor,
      :ud_ifnsave,
      :ud_ifscale,
      :ud_ifsin,
      :ud_ifsincos,
      :ud_ifsqrt,
      :ud_ifstp,
      :ud_ifstp1,
      :ud_ifstp8,
      :ud_ifstp9,
      :ud_ifst,
      :ud_ifnstcw,
      :ud_ifnstenv,
      :ud_ifnstsw,
      :ud_ifsub,
      :ud_ifsubp,
      :ud_ifsubr,
      :ud_ifsubrp,
      :ud_iftst,
      :ud_ifucom,
      :ud_ifucomp,
      :ud_ifucompp,
      :ud_ifxam,
      :ud_ifxch,
      :ud_ifxch4,
      :ud_ifxch7,
      :ud_ifxrstor,
      :ud_ifxsave,
      :ud_ifxtract,
      :ud_ifyl2x,
      :ud_ifyl2xp1,
      :ud_ihlt,
      :ud_iidiv,
      :ud_iin,
      :ud_iimul,
      :ud_iinc,
      :ud_iinsb,
      :ud_iinsw,
      :ud_iinsd,
      :ud_iint1,
      :ud_iint3,
      :ud_iint,
      :ud_iinto,
      :ud_iinvd,
      :ud_iinvept,
      :ud_iinvlpg,
      :ud_iinvlpga,
      :ud_iinvvpid,
      :ud_iiretw,
      :ud_iiretd,
      :ud_iiretq,
      :ud_ijo,
      :ud_ijno,
      :ud_ijb,
      :ud_ijae,
      :ud_ijz,
      :ud_ijnz,
      :ud_ijbe,
      :ud_ija,
      :ud_ijs,
      :ud_ijns,
      :ud_ijp,
      :ud_ijnp,
      :ud_ijl,
      :ud_ijge,
      :ud_ijle,
      :ud_ijg,
      :ud_ijcxz,
      :ud_ijecxz,
      :ud_ijrcxz,
      :ud_ijmp,
      :ud_ilahf,
      :ud_ilar,
      :ud_ilddqu,
      :ud_ildmxcsr,
      :ud_ilds,
      :ud_ilea,
      :ud_iles,
      :ud_ilfs,
      :ud_ilgs,
      :ud_ilidt,
      :ud_ilss,
      :ud_ileave,
      :ud_ilfence,
      :ud_ilgdt,
      :ud_illdt,
      :ud_ilmsw,
      :ud_ilock,
      :ud_ilodsb,
      :ud_ilodsw,
      :ud_ilodsd,
      :ud_ilodsq,
      :ud_iloopne,
      :ud_iloope,
      :ud_iloop,
      :ud_ilsl,
      :ud_iltr,
      :ud_imaskmovq,
      :ud_imaxpd,
      :ud_imaxps,
      :ud_imaxsd,
      :ud_imaxss,
      :ud_imfence,
      :ud_iminpd,
      :ud_iminps,
      :ud_iminsd,
      :ud_iminss,
      :ud_imonitor,
      :ud_imontmul,
      :ud_imov,
      :ud_imovapd,
      :ud_imovaps,
      :ud_imovd,
      :ud_imovhpd,
      :ud_imovhps,
      :ud_imovlhps,
      :ud_imovlpd,
      :ud_imovlps,
      :ud_imovhlps,
      :ud_imovmskpd,
      :ud_imovmskps,
      :ud_imovntdq,
      :ud_imovnti,
      :ud_imovntpd,
      :ud_imovntps,
      :ud_imovntq,
      :ud_imovq,
      :ud_imovsb,
      :ud_imovsw,
      :ud_imovsd,
      :ud_imovsq,
      :ud_imovss,
      :ud_imovsx,
      :ud_imovupd,
      :ud_imovups,
      :ud_imovzx,
      :ud_imul,
      :ud_imulpd,
      :ud_imulps,
      :ud_imulsd,
      :ud_imulss,
      :ud_imwait,
      :ud_ineg,
      :ud_inop,
      :ud_inot,
      :ud_ior,
      :ud_iorpd,
      :ud_iorps,
      :ud_iout,
      :ud_ioutsb,
      :ud_ioutsw,
      :ud_ioutsd,
      :ud_ipacksswb,
      :ud_ipackssdw,
      :ud_ipackuswb,
      :ud_ipaddb,
      :ud_ipaddw,
      :ud_ipaddd,
      :ud_ipaddsb,
      :ud_ipaddsw,
      :ud_ipaddusb,
      :ud_ipaddusw,
      :ud_ipand,
      :ud_ipandn,
      :ud_ipavgb,
      :ud_ipavgw,
      :ud_ipcmpeqb,
      :ud_ipcmpeqw,
      :ud_ipcmpeqd,
      :ud_ipcmpgtb,
      :ud_ipcmpgtw,
      :ud_ipcmpgtd,
      :ud_ipextrb,
      :ud_ipextrd,
      :ud_ipextrq,
      :ud_ipextrw,
      :ud_ipinsrb,
      :ud_ipinsrw,
      :ud_ipinsrd,
      :ud_ipinsrq,
      :ud_ipmaddwd,
      :ud_ipmaxsw,
      :ud_ipmaxub,
      :ud_ipminsw,
      :ud_ipminub,
      :ud_ipmovmskb,
      :ud_ipmulhuw,
      :ud_ipmulhw,
      :ud_ipmullw,
      :ud_ipop,
      :ud_ipopa,
      :ud_ipopad,
      :ud_ipopfw,
      :ud_ipopfd,
      :ud_ipopfq,
      :ud_ipor,
      :ud_iprefetch,
      :ud_iprefetchnta,
      :ud_iprefetcht0,
      :ud_iprefetcht1,
      :ud_iprefetcht2,
      :ud_ipsadbw,
      :ud_ipshufw,
      :ud_ipsllw,
      :ud_ipslld,
      :ud_ipsllq,
      :ud_ipsraw,
      :ud_ipsrad,
      :ud_ipsrlw,
      :ud_ipsrld,
      :ud_ipsrlq,
      :ud_ipsubb,
      :ud_ipsubw,
      :ud_ipsubd,
      :ud_ipsubsb,
      :ud_ipsubsw,
      :ud_ipsubusb,
      :ud_ipsubusw,
      :ud_ipunpckhbw,
      :ud_ipunpckhwd,
      :ud_ipunpckhdq,
      :ud_ipunpcklbw,
      :ud_ipunpcklwd,
      :ud_ipunpckldq,
      :ud_ipi2fw,
      :ud_ipi2fd,
      :ud_ipf2iw,
      :ud_ipf2id,
      :ud_ipfnacc,
      :ud_ipfpnacc,
      :ud_ipfcmpge,
      :ud_ipfmin,
      :ud_ipfrcp,
      :ud_ipfrsqrt,
      :ud_ipfsub,
      :ud_ipfadd,
      :ud_ipfcmpgt,
      :ud_ipfmax,
      :ud_ipfrcpit1,
      :ud_ipfrsqit1,
      :ud_ipfsubr,
      :ud_ipfacc,
      :ud_ipfcmpeq,
      :ud_ipfmul,
      :ud_ipfrcpit2,
      :ud_ipmulhrw,
      :ud_ipswapd,
      :ud_ipavgusb,
      :ud_ipush,
      :ud_ipusha,
      :ud_ipushad,
      :ud_ipushfw,
      :ud_ipushfd,
      :ud_ipushfq,
      :ud_ipxor,
      :ud_ircl,
      :ud_ircr,
      :ud_irol,
      :ud_iror,
      :ud_ircpps,
      :ud_ircpss,
      :ud_irdmsr,
      :ud_irdpmc,
      :ud_irdtsc,
      :ud_irdtscp,
      :ud_irepne,
      :ud_irep,
      :ud_iret,
      :ud_iretf,
      :ud_irsm,
      :ud_irsqrtps,
      :ud_irsqrtss,
      :ud_isahf,
      :ud_isalc,
      :ud_isar,
      :ud_ishl,
      :ud_ishr,
      :ud_isbb,
      :ud_iscasb,
      :ud_iscasw,
      :ud_iscasd,
      :ud_iscasq,
      :ud_iseto,
      :ud_isetno,
      :ud_isetb,
      :ud_isetae,
      :ud_isetz,
      :ud_isetnz,
      :ud_isetbe,
      :ud_iseta,
      :ud_isets,
      :ud_isetns,
      :ud_isetp,
      :ud_isetnp,
      :ud_isetl,
      :ud_isetge,
      :ud_isetle,
      :ud_isetg,
      :ud_isfence,
      :ud_isgdt,
      :ud_ishld,
      :ud_ishrd,
      :ud_ishufpd,
      :ud_ishufps,
      :ud_isidt,
      :ud_isldt,
      :ud_ismsw,
      :ud_isqrtps,
      :ud_isqrtpd,
      :ud_isqrtsd,
      :ud_isqrtss,
      :ud_istc,
      :ud_istd,
      :ud_istgi,
      :ud_isti,
      :ud_iskinit,
      :ud_istmxcsr,
      :ud_istosb,
      :ud_istosw,
      :ud_istosd,
      :ud_istosq,
      :ud_istr,
      :ud_isub,
      :ud_isubpd,
      :ud_isubps,
      :ud_isubsd,
      :ud_isubss,
      :ud_iswapgs,
      :ud_isyscall,
      :ud_isysenter,
      :ud_isysexit,
      :ud_isysret,
      :ud_itest,
      :ud_iucomisd,
      :ud_iucomiss,
      :ud_iud2,
      :ud_iunpckhpd,
      :ud_iunpckhps,
      :ud_iunpcklps,
      :ud_iunpcklpd,
      :ud_iverr,
      :ud_iverw,
      :ud_ivmcall,
      :ud_ivmclear,
      :ud_ivmxon,
      :ud_ivmptrld,
      :ud_ivmptrst,
      :ud_ivmlaunch,
      :ud_ivmresume,
      :ud_ivmxoff,
      :ud_ivmread,
      :ud_ivmwrite,
      :ud_ivmrun,
      :ud_ivmmcall,
      :ud_ivmload,
      :ud_ivmsave,
      :ud_iwait,
      :ud_iwbinvd,
      :ud_iwrmsr,
      :ud_ixadd,
      :ud_ixchg,
      :ud_ixgetbv,
      :ud_ixlatb,
      :ud_ixor,
      :ud_ixorpd,
      :ud_ixorps,
      :ud_ixcryptecb,
      :ud_ixcryptcbc,
      :ud_ixcryptctr,
      :ud_ixcryptcfb,
      :ud_ixcryptofb,
      :ud_ixrstor,
      :ud_ixsave,
      :ud_ixsetbv,
      :ud_ixsha1,
      :ud_ixsha256,
      :ud_ixstore,
      :ud_iaesdec,
      :ud_iaesdeclast,
      :ud_iaesenc,
      :ud_iaesenclast,
      :ud_iaesimc,
      :ud_iaeskeygenassist,
      :ud_ipclmulqdq,
      :ud_igetsec,
      :ud_imovdqa,
      :ud_imaskmovdqu,
      :ud_imovdq2q,
      :ud_imovdqu,
      :ud_imovq2dq,
      :ud_ipaddq,
      :ud_ipsubq,
      :ud_ipmuludq,
      :ud_ipshufhw,
      :ud_ipshuflw,
      :ud_ipshufd,
      :ud_ipslldq,
      :ud_ipsrldq,
      :ud_ipunpckhqdq,
      :ud_ipunpcklqdq,
      :ud_iaddsubpd,
      :ud_iaddsubps,
      :ud_ihaddpd,
      :ud_ihaddps,
      :ud_ihsubpd,
      :ud_ihsubps,
      :ud_imovddup,
      :ud_imovshdup,
      :ud_imovsldup,
      :ud_ipabsb,
      :ud_ipabsw,
      :ud_ipabsd,
      :ud_ipshufb,
      :ud_iphaddw,
      :ud_iphaddd,
      :ud_iphaddsw,
      :ud_ipmaddubsw,
      :ud_iphsubw,
      :ud_iphsubd,
      :ud_iphsubsw,
      :ud_ipsignb,
      :ud_ipsignd,
      :ud_ipsignw,
      :ud_ipmulhrsw,
      :ud_ipalignr,
      :ud_ipblendvb,
      :ud_ipmuldq,
      :ud_ipminsb,
      :ud_ipminsd,
      :ud_ipminuw,
      :ud_ipminud,
      :ud_ipmaxsb,
      :ud_ipmaxsd,
      :ud_ipmaxud,
      :ud_ipmaxuw,
      :ud_ipmulld,
      :ud_iphminposuw,
      :ud_iroundps,
      :ud_iroundpd,
      :ud_iroundss,
      :ud_iroundsd,
      :ud_iblendpd,
      :ud_ipblendw,
      :ud_iblendps,
      :ud_iblendvpd,
      :ud_iblendvps,
      :ud_idpps,
      :ud_idppd,
      :ud_impsadbw,
      :ud_iextractps,
      :ud_iinsertps,
      :ud_imovntdqa,
      :ud_ipackusdw,
      :ud_ipmovsxbw,
      :ud_ipmovsxbd,
      :ud_ipmovsxbq,
      :ud_ipmovsxwd,
      :ud_ipmovsxwq,
      :ud_ipmovsxdq,
      :ud_ipmovzxbw,
      :ud_ipmovzxbd,
      :ud_ipmovzxbq,
      :ud_ipmovzxwd,
      :ud_ipmovzxwq,
      :ud_ipmovzxdq,
      :ud_ipcmpeqq,
      :ud_ipopcnt,
      :ud_iptest,
      :ud_ipcmpestri,
      :ud_ipcmpestrm,
      :ud_ipcmpgtq,
      :ud_ipcmpistri,
      :ud_ipcmpistrm,
      :ud_imovbe,
      :ud_icrc32,
      :ud_max_mnemonic_code
    ]

    # From libudis86/types.h
    enum :ud_type, [
      :ud_none,

      # 8 bit GPRs
      :ud_r_al,  :ud_r_cl,  :ud_r_dl,  :ud_r_bl,
      :ud_r_ah,  :ud_r_ch,  :ud_r_dh,  :ud_r_bh,
      :ud_r_spl, :ud_r_bpl, :ud_r_sil, :ud_r_dil,
      :ud_r_r8b, :ud_r_r9b, :ud_r_r10b,  :ud_r_r11b,
      :ud_r_r12b,  :ud_r_r13b,  :ud_r_r14b,  :ud_r_r15b,

      # 16 bit GPRs
      :ud_r_ax,  :ud_r_cx,  :ud_r_dx,  :ud_r_bx,
      :ud_r_sp,  :ud_r_bp,  :ud_r_si,  :ud_r_di,
      :ud_r_r8w, :ud_r_r9w, :ud_r_r10w,  :ud_r_r11w,
      :ud_r_r12w,  :ud_r_r13w,  :ud_r_r14w,  :ud_r_r15w,

      # 32 bit GPRs
      :ud_r_eax, :ud_r_ecx, :ud_r_edx, :ud_r_ebx,
      :ud_r_esp, :ud_r_ebp, :ud_r_esi, :ud_r_edi,
      :ud_r_r8d, :ud_r_r9d, :ud_r_r10d,  :ud_r_r11d,
      :ud_r_r12d,  :ud_r_r13d,  :ud_r_r14d,  :ud_r_r15d,

      # 64 bit GPRs
      :ud_r_rax, :ud_r_rcx, :ud_r_rdx, :ud_r_rbx,
      :ud_r_rsp, :ud_r_rbp, :ud_r_rsi, :ud_r_rdi,
      :ud_r_r8,  :ud_r_r9,  :ud_r_r10, :ud_r_r11,
      :ud_r_r12, :ud_r_r13, :ud_r_r14, :ud_r_r15,

      # segment registers
      :ud_r_es,  :ud_r_cs,  :ud_r_ss,  :ud_r_ds,
      :ud_r_fs,  :ud_r_gs,

      # control registers
      :ud_r_cr0, :ud_r_cr1, :ud_r_cr2, :ud_r_cr3,
      :ud_r_cr4, :ud_r_cr5, :ud_r_cr6, :ud_r_cr7,
      :ud_r_cr8, :ud_r_cr9, :ud_r_cr10,  :ud_r_cr11,
      :ud_r_cr12,  :ud_r_cr13,  :ud_r_cr14,  :ud_r_cr15,

      # debug registers
      :ud_r_dr0, :ud_r_dr1, :ud_r_dr2, :ud_r_dr3,
      :ud_r_dr4, :ud_r_dr5, :ud_r_dr6, :ud_r_dr7,
      :ud_r_dr8, :ud_r_dr9, :ud_r_dr10,  :ud_r_dr11,
      :ud_r_dr12,  :ud_r_dr13,  :ud_r_dr14,  :ud_r_dr15,

      # mmx registers
      :ud_r_mm0, :ud_r_mm1, :ud_r_mm2, :ud_r_mm3,
      :ud_r_mm4, :ud_r_mm5, :ud_r_mm6, :ud_r_mm7,

      # x87 registers
      :ud_r_st0, :ud_r_st1, :ud_r_st2, :ud_r_st3,
      :ud_r_st4, :ud_r_st5, :ud_r_st6, :ud_r_st7,

      # extended multimedia registers
      :ud_r_xmm0,  :ud_r_xmm1,  :ud_r_xmm2,  :ud_r_xmm3,
      :ud_r_xmm4,  :ud_r_xmm5,  :ud_r_xmm6,  :ud_r_xmm7,
      :ud_r_xmm8,  :ud_r_xmm9,  :ud_r_xmm10, :ud_r_xmm11,
      :ud_r_xmm12, :ud_r_xmm13, :ud_r_xmm14, :ud_r_xmm15,

      # 256B multimedia registers
      :ud_r_ymm0,  :ud_r_ymm1,  :ud_r_ymm2,  :ud_r_ymm3,
      :ud_r_ymm4,  :ud_r_ymm5,  :ud_r_ymm6,  :ud_r_ymm7,
      :ud_r_ymm8,  :ud_r_ymm9,  :ud_r_ymm10, :ud_r_ymm11,
      :ud_r_ymm12, :ud_r_ymm13, :ud_r_ymm14, :ud_r_ymm15,

      :ud_r_rip,

      # Operand Types
      :ud_op_reg,  :ud_op_mem,  :ud_op_ptr,  :ud_op_imm,
      :ud_op_jimm, :ud_op_const
    ]

    # Acceptable operand types
    OPERAND_TYPES = Set[
      :ud_op_reg,  :ud_op_mem,  :ud_op_ptr,  :ud_op_imm,
      :ud_op_jimm, :ud_op_const
    ]

    callback :ud_input_callback, [:pointer], :int
    callback :ud_sym_resolver_callback, [:pointer, :uint64, :pointer], :string
    callback :ud_translator_callback, [:pointer], :void
  end
end
