Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E78E7719D
	for <kexec@archiver.kernel.org>; Sat, 11 Jan 2025 05:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=He/FF4mW6z63rm6Ez1fm+hLtPmYbF/A35f1xOajKz/c=; b=C4oTZqbXTd5Fb6uwPihEAIPOZ2
	4YESoN1tMM8m93K9DvKaD6V5wq46CKOMgBS8pEOJz+KP9zIFy5C6eQd/wXsklp6on6wfDFGnawaKz
	hI19wuv3T9CyvrKmVqQDS0hVMVjjiEGyoRkrC3gkSQQ2mnvxqThqvTBLNWFTo78ddOUuIkCF4z1Xj
	YAoD6hJelNQrUGU/bslkxUT1P2hzof4QnSw6lTpog9DJqoEZ7xMLaP0FPbBP3Sss8RoaVZ0eAMXNa
	dCnyN1zOBognQG8h+JYNZ+RtcPjx3Iel/sEgx277VqS85M4ihl3fDIjqm6BNIYkduKE+XveQSvsgw
	79t45lVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUMr-00000000EbF-1qBy;
	Sat, 11 Jan 2025 05:49:05 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUMo-00000000EaO-0hXr
	for kexec@lists.infradead.org;
	Sat, 11 Jan 2025 05:49:03 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-21661be2c2dso44739405ad.1
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 21:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736574541; x=1737179341; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=He/FF4mW6z63rm6Ez1fm+hLtPmYbF/A35f1xOajKz/c=;
        b=PbBA+UoUYMv2Q/fZXdMJ33HY6Cl9bQv8BVk95SvYnVZZzpx67Tx0B5Qr8ezNAYzyY2
         /2puVEzi2PTkddJlSwtt2L0M9oPXz8vqTImKD+SACBeCf8Wz/WpVuE2glqlJweBPxz0B
         CfHRuUP5Zc2CvlKxIZbh/y62luP2dmzkIJRFSgLzj6tmmNZJg2iZHvHXn2TMOJp7RGOi
         ImPZs6lC6OYvomBGKwz19ASHdRu+iLMijDQ9khd9QVEfMwGRTdOwLXsXnTAXkK9OwFeX
         gLFBgpBwik+QmLlpLwTGuUXvO8IjZGKlrWL5WMc/sFQait/MnGGe1PHSgtQRWjwfvHuD
         4z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736574541; x=1737179341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=He/FF4mW6z63rm6Ez1fm+hLtPmYbF/A35f1xOajKz/c=;
        b=JjzIRIGB6f0Ga08cfTvn2eEcYTBcXogeVoeGAbLzXcG8yphS7TaUaRvK1ByGX8gH/K
         nNPMbFlx2fq7FSNT8Qwcz32ndPjH2NcZOpSrjBz/BoODmTqUZpdLsgiMuWIZwJvp3TpR
         uHtyLc3z1kd3QbsnO0AyQZclHCfhzZV1HypKHvIAH8VUBFAD2ywH7He+ZAD6zSGlLPxr
         +yXu4uUatB/qvrfzfxda16vwYWvhQcqyQkOpsniih1hDYivwvJjaikIyv1Crw6jJlXeM
         0iaqLFHrlfTGLEqeuxc1JK00p/L8oK6aCukf7yuEWAt06ITgeWHE0i5Tm2ExG4zpW49z
         x9bw==
X-Forwarded-Encrypted: i=1; AJvYcCXLHJk+OJqAI3u0exLewN1IgGC5XzWSrKA/8Zz9jlByGTlIjQDQSFUPfM4rSLl8dpslDARatA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzWHCxMrEwS1IDK3OOTcIuYPyGoa2e55WEXs1EghBM6j++E0Mq2
	y6DznqftYUL79QAKAMt0nz5CyZpKGlbDIjOGQOdOfouO8TNfGOpupf/pRAtaY1U=
X-Gm-Gg: ASbGncv2MTy04abNghWJAgfPRGb3oqJooglg3lVWhSDYEjKTTCmPYAaYkNO/R+ts39L
	WOjeEj38Zo1EZNvJkJkD1ffcv7k8NxU2ccs3WZm39QCIWbmcvdpAA95+D/De+wNEkCedV8l09sW
	oG33Va2q77rLTo9aZWYx8eLrjLuXAgrHS78qO28dW1ay6jLKOfr3IzytNRlrj0CWb0J7Knyvc7f
	CS+a7cCOX8AN4bRFaD4ReE1KCfHqHwLgO5SWKM6BM6R06lgUzsyVl5Fxwo=
X-Google-Smtp-Source: AGHT+IHcpmdtla8m811pOhOWUKKg3mt5D2YgMgKQAi/FtxQToiO3ZEw9yK9yhc6mlxAM0lTabpo8Kw==
X-Received: by 2002:a05:6a00:cd6:b0:729:9f1:69bc with SMTP id d2e1a72fcca58-72d21f45b2fmr19552247b3a.12.1736574541182;
        Fri, 10 Jan 2025 21:49:01 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72d405489e2sm2380384b3a.32.2025.01.10.21.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 21:49:00 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 11 Jan 2025 14:48:44 +0900
Subject: [PATCH v4 1/6] elf: Define note name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-elf-v4-1-b3841fa0dcd9@daynix.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
In-Reply-To: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
 LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_214902_214556_434BB894 
X-CRM114-Status: GOOD (  15.05  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

elf.h had a comment saying:
> Notes used in ET_CORE. Architectures export some of the arch register
> sets using the corresponding note types via the PTRACE_GETREGSET and
> PTRACE_SETREGSET requests.
> The note name for these types is "LINUX", except NT_PRFPREG that is
> named "CORE".

However, NT_PRSTATUS is also named "CORE". It is also unclear what
"these types" refers to.

To fix these problems, define a name for each note type. The added
definitions are macros so the kernel and userspace can directly refer to
them.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/uapi/linux/elf.h | 86 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b44069d29cec..343f5c40d03a 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -368,99 +368,179 @@ typedef struct elf64_shdr {
 #define ELF_OSABI ELFOSABI_NONE
 #endif
 
+/* Note definitions: NN_ defines names. NT_ defines types. */
+
 /*
  * Notes used in ET_CORE. Architectures export some of the arch register sets
  * using the corresponding note types via the PTRACE_GETREGSET and
  * PTRACE_SETREGSET requests.
- * The note name for these types is "LINUX", except NT_PRFPREG that is named
- * "CORE".
  */
+#define NN_PRSTATUS	"CORE"
 #define NT_PRSTATUS	1
+#define NN_PRFPREG	"CORE"
 #define NT_PRFPREG	2
+#define NN_PRPSINFO	"CORE"
 #define NT_PRPSINFO	3
+#define NN_TASKSTRUCT	"CORE"
 #define NT_TASKSTRUCT	4
+#define NN_AUXV		"CORE"
 #define NT_AUXV		6
 /*
  * Note to userspace developers: size of NT_SIGINFO note may increase
  * in the future to accomodate more fields, don't assume it is fixed!
  */
+#define NN_SIGINFO      "CORE"
 #define NT_SIGINFO      0x53494749
+#define NN_FILE         "CORE"
 #define NT_FILE         0x46494c45
+#define NN_PRXFPREG     "LINUX"
 #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */
+#define NN_PPC_VMX	"LINUX"
 #define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
+#define NN_PPC_SPE	"LINUX"
 #define NT_PPC_SPE	0x101		/* PowerPC SPE/EVR registers */
+#define NN_PPC_VSX	"LINUX"
 #define NT_PPC_VSX	0x102		/* PowerPC VSX registers */
+#define NN_PPC_TAR	"LINUX"
 #define NT_PPC_TAR	0x103		/* Target Address Register */
+#define NN_PPC_PPR	"LINUX"
 #define NT_PPC_PPR	0x104		/* Program Priority Register */
+#define NN_PPC_DSCR	"LINUX"
 #define NT_PPC_DSCR	0x105		/* Data Stream Control Register */
+#define NN_PPC_EBB	"LINUX"
 #define NT_PPC_EBB	0x106		/* Event Based Branch Registers */
+#define NN_PPC_PMU	"LINUX"
 #define NT_PPC_PMU	0x107		/* Performance Monitor Registers */
+#define NN_PPC_TM_CGPR	"LINUX"
 #define NT_PPC_TM_CGPR	0x108		/* TM checkpointed GPR Registers */
+#define NN_PPC_TM_CFPR	"LINUX"
 #define NT_PPC_TM_CFPR	0x109		/* TM checkpointed FPR Registers */
+#define NN_PPC_TM_CVMX	"LINUX"
 #define NT_PPC_TM_CVMX	0x10a		/* TM checkpointed VMX Registers */
+#define NN_PPC_TM_CVSX	"LINUX"
 #define NT_PPC_TM_CVSX	0x10b		/* TM checkpointed VSX Registers */
+#define NN_PPC_TM_SPR	"LINUX"
 #define NT_PPC_TM_SPR	0x10c		/* TM Special Purpose Registers */
+#define NN_PPC_TM_CTAR	"LINUX"
 #define NT_PPC_TM_CTAR	0x10d		/* TM checkpointed Target Address Register */
+#define NN_PPC_TM_CPPR	"LINUX"
 #define NT_PPC_TM_CPPR	0x10e		/* TM checkpointed Program Priority Register */
+#define NN_PPC_TM_CDSCR	"LINUX"
 #define NT_PPC_TM_CDSCR	0x10f		/* TM checkpointed Data Stream Control Register */
+#define NN_PPC_PKEY	"LINUX"
 #define NT_PPC_PKEY	0x110		/* Memory Protection Keys registers */
+#define NN_PPC_DEXCR	"LINUX"
 #define NT_PPC_DEXCR	0x111		/* PowerPC DEXCR registers */
+#define NN_PPC_HASHKEYR	"LINUX"
 #define NT_PPC_HASHKEYR	0x112		/* PowerPC HASHKEYR register */
+#define NN_386_TLS	"LINUX"
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
+#define NN_386_IOPERM	"LINUX"
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
+#define NN_X86_XSTATE	"LINUX"
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
 /* Old binutils treats 0x203 as a CET state */
+#define NN_X86_SHSTK	"LINUX"
 #define NT_X86_SHSTK	0x204		/* x86 SHSTK state */
+#define NN_X86_XSAVE_LAYOUT	"LINUX"
 #define NT_X86_XSAVE_LAYOUT	0x205	/* XSAVE layout description */
+#define NN_S390_HIGH_GPRS	"LINUX"
 #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
+#define NN_S390_TIMER	"LINUX"
 #define NT_S390_TIMER	0x301		/* s390 timer register */
+#define NN_S390_TODCMP	"LINUX"
 #define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
+#define NN_S390_TODPREG	"LINUX"
 #define NT_S390_TODPREG	0x303		/* s390 TOD programmable register */
+#define NN_S390_CTRS	"LINUX"
 #define NT_S390_CTRS	0x304		/* s390 control registers */
+#define NN_S390_PREFIX	"LINUX"
 #define NT_S390_PREFIX	0x305		/* s390 prefix register */
+#define NN_S390_LAST_BREAK	"LINUX"
 #define NT_S390_LAST_BREAK	0x306	/* s390 breaking event address */
+#define NN_S390_SYSTEM_CALL	"LINUX"
 #define NT_S390_SYSTEM_CALL	0x307	/* s390 system call restart data */
+#define NN_S390_TDB	"LINUX"
 #define NT_S390_TDB	0x308		/* s390 transaction diagnostic block */
+#define NN_S390_VXRS_LOW	"LINUX"
 #define NT_S390_VXRS_LOW	0x309	/* s390 vector registers 0-15 upper half */
+#define NN_S390_VXRS_HIGH	"LINUX"
 #define NT_S390_VXRS_HIGH	0x30a	/* s390 vector registers 16-31 */
+#define NN_S390_GS_CB	"LINUX"
 #define NT_S390_GS_CB	0x30b		/* s390 guarded storage registers */
+#define NN_S390_GS_BC	"LINUX"
 #define NT_S390_GS_BC	0x30c		/* s390 guarded storage broadcast control block */
+#define NN_S390_RI_CB	"LINUX"
 #define NT_S390_RI_CB	0x30d		/* s390 runtime instrumentation */
+#define NN_S390_PV_CPU_DATA	"LINUX"
 #define NT_S390_PV_CPU_DATA	0x30e	/* s390 protvirt cpu dump data */
+#define NN_ARM_VFP	"LINUX"
 #define NT_ARM_VFP	0x400		/* ARM VFP/NEON registers */
+#define NN_ARM_TLS	"LINUX"
 #define NT_ARM_TLS	0x401		/* ARM TLS register */
+#define NN_ARM_HW_BREAK	"LINUX"
 #define NT_ARM_HW_BREAK	0x402		/* ARM hardware breakpoint registers */
+#define NN_ARM_HW_WATCH	"LINUX"
 #define NT_ARM_HW_WATCH	0x403		/* ARM hardware watchpoint registers */
+#define NN_ARM_SYSTEM_CALL	"LINUX"
 #define NT_ARM_SYSTEM_CALL	0x404	/* ARM system call number */
+#define NN_ARM_SVE	"LINUX"
 #define NT_ARM_SVE	0x405		/* ARM Scalable Vector Extension registers */
+#define NN_ARM_PAC_MASK		"LINUX"
 #define NT_ARM_PAC_MASK		0x406	/* ARM pointer authentication code masks */
+#define NN_ARM_PACA_KEYS	"LINUX"
 #define NT_ARM_PACA_KEYS	0x407	/* ARM pointer authentication address keys */
+#define NN_ARM_PACG_KEYS	"LINUX"
 #define NT_ARM_PACG_KEYS	0x408	/* ARM pointer authentication generic key */
+#define NN_ARM_TAGGED_ADDR_CTRL	"LINUX"
 #define NT_ARM_TAGGED_ADDR_CTRL	0x409	/* arm64 tagged address control (prctl()) */
+#define NN_ARM_PAC_ENABLED_KEYS	"LINUX"
 #define NT_ARM_PAC_ENABLED_KEYS	0x40a	/* arm64 ptr auth enabled keys (prctl()) */
+#define NN_ARM_SSVE	"LINUX"
 #define NT_ARM_SSVE	0x40b		/* ARM Streaming SVE registers */
+#define NN_ARM_ZA	"LINUX"
 #define NT_ARM_ZA	0x40c		/* ARM SME ZA registers */
+#define NN_ARM_ZT	"LINUX"
 #define NT_ARM_ZT	0x40d		/* ARM SME ZT registers */
+#define NN_ARM_FPMR	"LINUX"
 #define NT_ARM_FPMR	0x40e		/* ARM floating point mode register */
+#define NN_ARM_POE	"LINUX"
 #define NT_ARM_POE	0x40f		/* ARM POE registers */
+#define NN_ARM_GCS	"LINUX"
 #define NT_ARM_GCS	0x410		/* ARM GCS state */
+#define NN_ARC_V2	"LINUX"
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
+#define NN_VMCOREDD	"LINUX"
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
+#define NN_MIPS_DSP	"LINUX"
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
+#define NN_MIPS_FP_MODE	"LINUX"
 #define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
+#define NN_MIPS_MSA	"LINUX"
 #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
+#define NN_RISCV_CSR	"LINUX"
 #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
+#define NN_RISCV_VECTOR	"LINUX"
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
+#define NN_RISCV_TAGGED_ADDR_CTRL "LINUX"
 #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
+#define NN_LOONGARCH_CPUCFG	"LINUX"
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
+#define NN_LOONGARCH_CSR	"LINUX"
 #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
+#define NN_LOONGARCH_LSX	"LINUX"
 #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
+#define NN_LOONGARCH_LASX	"LINUX"
 #define NT_LOONGARCH_LASX	0xa03	/* LoongArch Loongson Advanced SIMD Extension registers */
+#define NN_LOONGARCH_LBT	"LINUX"
 #define NT_LOONGARCH_LBT	0xa04	/* LoongArch Loongson Binary Translation registers */
+#define NN_LOONGARCH_HW_BREAK	"LINUX"
 #define NT_LOONGARCH_HW_BREAK	0xa05   /* LoongArch hardware breakpoint registers */
+#define NN_LOONGARCH_HW_WATCH	"LINUX"
 #define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint registers */
 
-/* Note types with note name "GNU" */
+/* Note used in other file types. */
+#define NN_GNU_PROPERTY_TYPE_0	"GNU"
 #define NT_GNU_PROPERTY_TYPE_0	5
 
 /* Note header in a PT_NOTE section */

-- 
2.47.1


