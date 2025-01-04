Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D13E77188
	for <kexec@archiver.kernel.org>; Sat,  4 Jan 2025 14:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3DDRJB8oNZeq6N6MlMy+rUGIqaIntb5QA28c12Ptyck=; b=QmZ9bqGYK5SSx19QVyW0Zu30aG
	Xu9g4DIBzj8Q4Dr92uMjNWPsKwJDODxxhbfY+VbSidZ+jn7bYR9rm1h+Y9mxyDp6Vb2O+NGVAGoVb
	x3kQQvEGf6MAt+xNbjdQWqfA6EuHRXhauJhBQoGCY7/XhJVSPTP5DDasKGyHbS1ynPIPJ9L9Kxovi
	wyeCd0Qj2PBT5wc3+EFlBogsUDwZL6DeaKXLoINULjDQCkD2wKG2Zv/WzSAHUsPYl+6+1WEpLVVyB
	7Ra8WGM2ldD7F6gxysXa6CKx207Hatd4fJQ6383B5xuLar9/pVEasc1ht3uJTV5GjZkAJh2qcCVoE
	UvzC9rdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tU5Ii-0000000F7cb-1uwe;
	Sat, 04 Jan 2025 14:38:52 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tU5If-0000000F7bi-3NIb
	for kexec@lists.infradead.org;
	Sat, 04 Jan 2025 14:38:50 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-21636268e43so103648315ad.2
        for <kexec@lists.infradead.org>; Sat, 04 Jan 2025 06:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736001529; x=1736606329; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DDRJB8oNZeq6N6MlMy+rUGIqaIntb5QA28c12Ptyck=;
        b=Wy9kjwpmviRch0xnAlC8t8qrr/GBvViUjtWyNm3P5kvME6+wbSTft96z2Ix/f56ZcE
         JTX3g/41t9e9wGYo9Js69LdaHnYXVXsbHQ5iM1LEnUFySWpfOlRBx8mFPkWdln9Z39TX
         0ziGyGZ+8nRmAu3rLcmBwzcR1MiP4icAt/aYTH7Uirqq+9iX/VVZrSmUFqfmsRCZdXwC
         k/TiZzdJYCJyiPL5QT2MGbUqtdx8uoNVU52bhJ7/8f/Ghynmv6vCSrwfIJMR8qUrmA6M
         74UQNH5uGA6llPWnBV662XfBaBy8V6EVLFcRF3HCCD/dsND6CRP1ZkUKp0OuTe+krgKr
         FihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736001529; x=1736606329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DDRJB8oNZeq6N6MlMy+rUGIqaIntb5QA28c12Ptyck=;
        b=ldPZHpPbhvp1EpNRMJkmyuIznxL+kTyAL+9oeIyNuHzREphLaFNJvEktSyBT+Romyf
         qhtVkBS84lH2vyO4c1gklIaoxE9VkG6zWHqGqatyrlHLE8CJBNxOisZnsAIeYa1U090A
         BnBeAK01THkHBpj9Z/poMKa4p+zrWlT6c6F01iBNZkA2/ebs0FW3haEQAS1eI6wj8oOw
         TiR0nOjhlCgbJhzVmy52YdF+cOUgx/IHiyE8ngmjUawCWxcLgytHCXBOV1BhOnb8oxLb
         xs27fAIOIqnQEWg5f5gC39AJ/hYA740MWp6k884h3U89nZidlPpdd53GqTgBOnLLkKvm
         TCOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8SFDSArqRUE3UHUBBA9a3AYZU2Wbc0Po7NZiVUrFkdfvBV+zMYDDvi41xf1kmyT32JraM/A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1eRpzpsTv9E6vlk46xNWXewFwR1vNaxzKT6Ca82Bhn+OdPuwz
	XJKlFPlUyE+boiOkyg3XgESV2PxSYAKpzijVy1ZfX9qVtqdqZsI8eRjyPrqdvY0MMRbjPjeGn2F
	tMqM=
X-Gm-Gg: ASbGncvtjGvaAoJRsoZ3zru2vEZz2Av2kl0k6jpBrtVVJdtEyYrx342La0RV67j645V
	nkRNI2KvcYruAj44Rmwm7esUgnEJOe4YRBDFBhrPQnSItlH4GNCFlTGByJch0zKDp2WigjQm6Cv
	rxUQHlALx8gbPcr6yI8jhZUbNl4Mr3XJgN35uL9SS7iPOU5PuvYa/wt9QFeFS8QkarykpH1LnFQ
	VQX11B7BNqT14JXrVmWQGaZOBg7RRz+6mvizXsUbF/WX+3J2ZOY+ajN7tfbbsE=
X-Google-Smtp-Source: AGHT+IHXNTPwYGpyoF2oIO9YtYeoBNZ9bkHyASDQWStwZpuI0NOPrSg1SLgfLCaPbrvbr04vYZJzgg==
X-Received: by 2002:a17:902:e5c7:b0:215:bf1b:a894 with SMTP id d9443c01a7336-219e6eb5bffmr760628135ad.24.1736001528912;
        Sat, 04 Jan 2025 06:38:48 -0800 (PST)
Received: from localhost ([2400:4050:b783:b00:4952:3c52:120a:27e9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dc962c5esm260927675ad.12.2025.01.04.06.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 06:38:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 23:38:34 +0900
Subject: [PATCH v2 1/5] elf: Define note name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-elf-v2-1-77dc2e06db4e@daynix.com>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
In-Reply-To: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_063849_853309_334F9272 
X-CRM114-Status: GOOD (  14.20  )
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
---
 include/uapi/linux/elf.h | 86 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b44069d29cec..014b705b97d7 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -372,8 +372,6 @@ typedef struct elf64_shdr {
  * Notes used in ET_CORE. Architectures export some of the arch register sets
  * using the corresponding note types via the PTRACE_GETREGSET and
  * PTRACE_SETREGSET requests.
- * The note name for these types is "LINUX", except NT_PRFPREG that is named
- * "CORE".
  */
 #define NT_PRSTATUS	1
 #define NT_PRFPREG	2
@@ -460,9 +458,91 @@ typedef struct elf64_shdr {
 #define NT_LOONGARCH_HW_BREAK	0xa05   /* LoongArch hardware breakpoint registers */
 #define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint registers */
 
-/* Note types with note name "GNU" */
+/* Note used in ET_EXEC and ET_DYN. */
 #define NT_GNU_PROPERTY_TYPE_0	5
 
+/* Note names */
+#define NN_PRSTATUS	"CORE"
+#define NN_PRFPREG	"CORE"
+#define NN_PRPSINFO	"CORE"
+#define NN_TASKSTRUCT	"CORE"
+#define NN_AUXV	"CORE"
+#define NN_SIGINFO	"CORE"
+#define NN_FILE	"CORE"
+#define NN_PRXFPREG	"LINUX"
+#define NN_PPC_VMX	"LINUX"
+#define NN_PPC_SPE	"LINUX"
+#define NN_PPC_VSX	"LINUX"
+#define NN_PPC_TAR	"LINUX"
+#define NN_PPC_PPR	"LINUX"
+#define NN_PPC_DSCR	"LINUX"
+#define NN_PPC_EBB	"LINUX"
+#define NN_PPC_PMU	"LINUX"
+#define NN_PPC_TM_CGPR	"LINUX"
+#define NN_PPC_TM_CFPR	"LINUX"
+#define NN_PPC_TM_CVMX	"LINUX"
+#define NN_PPC_TM_CVSX	"LINUX"
+#define NN_PPC_TM_SPR	"LINUX"
+#define NN_PPC_TM_CTAR	"LINUX"
+#define NN_PPC_TM_CPPR	"LINUX"
+#define NN_PPC_TM_CDSCR	"LINUX"
+#define NN_PPC_PKEY	"LINUX"
+#define NN_PPC_DEXCR	"LINUX"
+#define NN_PPC_HASHKEYR	"LINUX"
+#define NN_386_TLS	"LINUX"
+#define NN_386_IOPERM	"LINUX"
+#define NN_X86_XSTATE	"LINUX"
+#define NN_X86_SHSTK	"LINUX"
+#define NN_X86_XSAVE_LAYOUT	"LINUX"
+#define NN_S390_HIGH_GPRS	"LINUX"
+#define NN_S390_TIMER	"LINUX"
+#define NN_S390_TODCMP	"LINUX"
+#define NN_S390_TODPREG	"LINUX"
+#define NN_S390_CTRS	"LINUX"
+#define NN_S390_PREFIX	"LINUX"
+#define NN_S390_LAST_BREAK	"LINUX"
+#define NN_S390_SYSTEM_CALL	"LINUX"
+#define NN_S390_TDB	"LINUX"
+#define NN_S390_VXRS_LOW	"LINUX"
+#define NN_S390_VXRS_HIGH	"LINUX"
+#define NN_S390_GS_CB	"LINUX"
+#define NN_S390_GS_BC	"LINUX"
+#define NN_S390_RI_CB	"LINUX"
+#define NN_S390_PV_CPU_DATA	"LINUX"
+#define NN_ARM_VFP	"LINUX"
+#define NN_ARM_TLS	"LINUX"
+#define NN_ARM_HW_BREAK	"LINUX"
+#define NN_ARM_HW_WATCH	"LINUX"
+#define NN_ARM_SYSTEM_CALL	"LINUX"
+#define NN_ARM_SVE	"LINUX"
+#define NN_ARM_PAC_MASK	"LINUX"
+#define NN_ARM_PACA_KEYS	"LINUX"
+#define NN_ARM_PACG_KEYS	"LINUX"
+#define NN_ARM_TAGGED_ADDR_CTRL	"LINUX"
+#define NN_ARM_PAC_ENABLED_KEYS	"LINUX"
+#define NN_ARM_SSVE	"LINUX"
+#define NN_ARM_ZA	"LINUX"
+#define NN_ARM_ZT	"LINUX"
+#define NN_ARM_FPMR	"LINUX"
+#define NN_ARM_POE	"LINUX"
+#define NN_ARM_GCS	"LINUX"
+#define NN_ARC_V2	"LINUX"
+#define NN_VMCOREDD	"LINUX"
+#define NN_MIPS_DSP	"LINUX"
+#define NN_MIPS_FP_MODE	"LINUX"
+#define NN_MIPS_MSA	"LINUX"
+#define NN_RISCV_CSR	"LINUX"
+#define NN_RISCV_VECTOR	"LINUX"
+#define NN_RISCV_TAGGED_ADDR_CTRL	"LINUX"
+#define NN_LOONGARCH_CPUCFG	"LINUX"
+#define NN_LOONGARCH_CSR	"LINUX"
+#define NN_LOONGARCH_LSX	"LINUX"
+#define NN_LOONGARCH_LASX	"LINUX"
+#define NN_LOONGARCH_LBT	"LINUX"
+#define NN_LOONGARCH_HW_BREAK	"LINUX"
+#define NN_LOONGARCH_HW_WATCH	"LINUX"
+#define NN_GNU_PROPERTY_TYPE_0	"GNU"
+
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
   Elf32_Word	n_namesz;	/* Name size */

-- 
2.47.1


