Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31619C36005
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QmV5BWqKnlxPhrRMqlARz/TZT0WTjCpLvcGNlHyxpKs=; b=r6dcJ/Zhm9H0C/aGNmAKexEz+S
	geKtBr0DcqC9DUlEsGUtDiiPAFsuewVoFFif0haffPswo3yzI1/eBxEm+l/Q6BvJCNaNI7yg9LHm8
	FueTk3iIM4ToHTj2wCdDxE240wGgcWEES2wYS/82+K8QXCys1fmXIXXyrx32tq3oh35E4ksI42ELN
	EirAzlPOJDF0hQ1C5m+TYG7+vxZ4zPPKli3Am9R9jiRjuh/7uug5WFPQxmf3zD+QkJDDU+ma6NG/N
	yoZa+5CJBXG0W6eHlmD3QAQJdbNhdMPOZf+YPuf94L9R096bXwdv0+i72tQjljciBHZuJZoWNbtai
	98e5UqFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHS7-0000000CUHQ-3FIP;
	Thu, 20 Mar 2025 15:04:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv594-0000000Akpq-0p6M
	for kexec@bombadil.infradead.org;
	Thu, 20 Mar 2025 01:56:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QmV5BWqKnlxPhrRMqlARz/TZT0WTjCpLvcGNlHyxpKs=; b=ja1+QRRozLG5BCp1m6+y3tZFc3
	iiXdNaf1oHtGaRMx9IQbaMZR2W8riuyMlCShADzW8r+TLOb4mzL43Vk/FteElJGXciqk2YqixwFTC
	AYuI6sIz1dnd1OOeVLHY+fkynGSeLpbpMt5otUfqMEayPV6OTJe59Mp0coes8PJMWgFVaslI5NlhB
	3966ZOnX4Js/SZy9nO8S/HZIxRTAH1Cf5NJ/pK/UACt2cNmIAPvAixtdEjThjHUN046O9PFpwbCBb
	bFX7EvaHDngaZc5kTHUa+IBqAyJXWGIu/VdjvD+CkOd9rLQIJZ/ld7d0oBWUD+o/au1EgzdtpxKrX
	8s1oizKw==;
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv58z-000000043fL-3wzb
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 01:56:29 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso701836a91.1
        for <kexec@lists.infradead.org>; Wed, 19 Mar 2025 18:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435783; x=1743040583; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QmV5BWqKnlxPhrRMqlARz/TZT0WTjCpLvcGNlHyxpKs=;
        b=hOyv9f8XTCn45SUhcuSKTgnPbHFtQ7waOjvb5DQs+lF1hsWY2OwSeQIRz5ScUqWfQy
         Z1tJkw1WU8TpJVX9wRX/xEdRSwF9N3U4yT/m+cRWNGaTePaqAX0dqONHSxm3twIkgIJN
         /AJverV4JpHbrn1kBNzPOu5Sx9Hog+mFHxoa5pi8i6nUYLLHaDv/QrFRu9LYfQcDNrPE
         BNtc6LMWhMwrDqLQ63Qj1iChFpQmConO07DlzuCHT1VvaWUXRy+550U3BBhn+l+drE4g
         W2c0pQy1sLzlAm9qRXrnToifwLG1KofUsP8sSfGf/YtxZ+pja8glGK2hR15Jywb3/68I
         EWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435783; x=1743040583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QmV5BWqKnlxPhrRMqlARz/TZT0WTjCpLvcGNlHyxpKs=;
        b=UaxIcTxF05ZW5Bt7t4l6slG+j9/tonNlqBZpJUMF6HCAaarwOoHqGdvWHDkK0cpjlk
         UDaOakb+HTYmDRmq06oivil5Y7H3CBehvEj7NPRdF49CCFe3zvYv2nNaoqBH8hfSowl0
         UkaNbgabGSJohHps31+dRdfYjJQ489BVbs3944Wa1vK50XPZ/9kTGLEAVLmbWpFcaXU/
         e2LC8EY7wsyVHzlFVj1mvtzerP0kYngZV79LxwgOAq9WHAeeQkoeTRKhHqVFB2/lFamQ
         43lp+tGA3Z7LOz9xYImFo1DpHEQtXarEB5fguSuLhq0j8cHygEXaUKYAa8ia5y6EkJdJ
         Njyw==
X-Forwarded-Encrypted: i=1; AJvYcCV4BAb+dFQO2Yejg4tZtXUAkLlesYX2kMMWTmiLBzOFsfz2hH9lvBMYnaE/UJdvtIW1Zw86FA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/6RAO4ryFMyPpAN8MK1JulktuZyvN/4pWs56NogIvJbSXd7lo
	vFUMzzzxHBA2yc0WicuvcC2mYf8oQOuxr9AMPz5hOX/GZLGf3jjOHjaQxixzbkU5G+zizLYK57V
	ZLqr1CAW5sM4FwTEh3g==
X-Google-Smtp-Source: AGHT+IFcz6xgCpsdaGMV/lA4NVDUFar/eMRSs8b1l17t60oWu+KTL3OhVFDVjETsYQaFDiZdylma2/Q1A+VwCJiL
X-Received: from pjbrr14.prod.google.com ([2002:a17:90b:2b4e:b0:2ef:82c0:cb8d])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f86:b0:301:6343:1626 with SMTP id 98e67ed59e1d1-301d507fab7mr2148203a91.1.1742435782874;
 Wed, 19 Mar 2025 18:56:22 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:49 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-15-changyuanl@google.com>
Subject: [PATCH v5 14/16] x86: add KHO support
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_015626_077301_41888301 
X-CRM114-Status: GOOD (  27.57  )
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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

From: Alexander Graf <graf@amazon.com>

We now have all bits in place to support KHO kexecs. This patch adds
awareness of KHO in the kexec file as well as boot path for x86 and
adds the respective kconfig option to the architecture so that it can
use KHO successfully.

In addition, it enlightens it decompression code with KHO so that its
KASLR location finder only considers memory regions that are not already
occupied by KHO memory.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 arch/x86/Kconfig                       |  3 ++
 arch/x86/boot/compressed/kaslr.c       | 52 +++++++++++++++++++++++++-
 arch/x86/include/asm/setup.h           |  4 ++
 arch/x86/include/uapi/asm/setup_data.h | 13 ++++++-
 arch/x86/kernel/e820.c                 | 18 +++++++++
 arch/x86/kernel/kexec-bzimage64.c      | 36 ++++++++++++++++++
 arch/x86/kernel/setup.c                | 25 +++++++++++++
 arch/x86/realmode/init.c               |  2 +
 include/linux/kexec_handover.h         | 13 +++++--
 9 files changed, 161 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0e27ebd7e36a..acd180e3002f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2091,6 +2091,9 @@ config ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG
 config ARCH_SUPPORTS_KEXEC_JUMP
 	def_bool y
 
+config ARCH_SUPPORTS_KEXEC_HANDOVER
+	def_bool y
+
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool X86_64 || (X86_32 && HIGHMEM)
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index f03d59ea6e40..ff1168881016 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -760,6 +760,55 @@ static void process_e820_entries(unsigned long minimum,
 	}
 }
 
+/*
+ * If KHO is active, only process its scratch areas to ensure we are not
+ * stepping onto preserved memory.
+ */
+#ifdef CONFIG_KEXEC_HANDOVER
+static bool process_kho_entries(unsigned long minimum, unsigned long image_size)
+{
+	struct kho_scratch *kho_scratch;
+	struct setup_data *ptr;
+	int i, nr_areas = 0;
+
+	ptr = (struct setup_data *)(unsigned long)boot_params_ptr->hdr.setup_data;
+	while (ptr) {
+		if (ptr->type == SETUP_KEXEC_KHO) {
+			struct kho_data *kho = (struct kho_data *)ptr->data;
+
+			kho_scratch = (void *)kho->scratch_addr;
+			nr_areas = kho->scratch_size / sizeof(*kho_scratch);
+
+			break;
+		}
+
+		ptr = (struct setup_data *)(unsigned long)ptr->next;
+	}
+
+	if (!nr_areas)
+		return false;
+
+	for (i = 0; i < nr_areas; i++) {
+		struct kho_scratch *area = &kho_scratch[i];
+		struct mem_vector region = {
+			.start = area->addr,
+			.size = area->size,
+		};
+
+		if (process_mem_region(&region, minimum, image_size))
+			break;
+	}
+
+	return true;
+}
+#else
+static inline bool process_kho_entries(unsigned long minimum,
+				       unsigned long image_size)
+{
+	return false;
+}
+#endif
+
 static unsigned long find_random_phys_addr(unsigned long minimum,
 					   unsigned long image_size)
 {
@@ -775,7 +824,8 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
 		return 0;
 	}
 
-	if (!process_efi_entries(minimum, image_size))
+	if (!process_kho_entries(minimum, image_size) &&
+	    !process_efi_entries(minimum, image_size))
 		process_e820_entries(minimum, image_size);
 
 	phys_addr = slots_fetch_random();
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 85f4fde3515c..70e045321d4b 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -66,6 +66,10 @@ extern void x86_ce4100_early_setup(void);
 static inline void x86_ce4100_early_setup(void) { }
 #endif
 
+#ifdef CONFIG_KEXEC_HANDOVER
+#include <linux/kexec_handover.h>
+#endif
+
 #ifndef _SETUP
 
 #include <asm/espfix.h>
diff --git a/arch/x86/include/uapi/asm/setup_data.h b/arch/x86/include/uapi/asm/setup_data.h
index b111b0c18544..c258c37768ee 100644
--- a/arch/x86/include/uapi/asm/setup_data.h
+++ b/arch/x86/include/uapi/asm/setup_data.h
@@ -13,7 +13,8 @@
 #define SETUP_CC_BLOB			7
 #define SETUP_IMA			8
 #define SETUP_RNG_SEED			9
-#define SETUP_ENUM_MAX			SETUP_RNG_SEED
+#define SETUP_KEXEC_KHO			10
+#define SETUP_ENUM_MAX			SETUP_KEXEC_KHO
 
 #define SETUP_INDIRECT			(1<<31)
 #define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
@@ -78,6 +79,16 @@ struct ima_setup_data {
 	__u64 size;
 } __attribute__((packed));
 
+/*
+ * Locations of kexec handover metadata
+ */
+struct kho_data {
+	__u64 dt_addr;
+	__u64 dt_size;
+	__u64 scratch_addr;
+	__u64 scratch_size;
+} __attribute__((packed));
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI_ASM_X86_SETUP_DATA_H */
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 82b96ed9890a..0b81cd70b02a 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1329,6 +1329,24 @@ void __init e820__memblock_setup(void)
 		memblock_add(entry->addr, entry->size);
 	}
 
+	/*
+	 * At this point with KHO we only allocate from scratch memory.
+	 * At the same time, we configure memblock to only allow
+	 * allocations from memory below ISA_END_ADDRESS which is not
+	 * a natural scratch region, because Linux ignores memory below
+	 * ISA_END_ADDRESS at runtime. Beside very few (if any) early
+	 * allocations, we must allocate real-mode trapoline below
+	 * ISA_END_ADDRESS.
+	 *
+	 * To make sure that we can actually perform allocations during
+	 * this phase, let's mark memory below ISA_END_ADDRESS as scratch
+	 * so we can allocate from there in a scratch-only world.
+	 *
+	 * After real mode trampoline is allocated, we clear scratch
+	 * marking from the memory below ISA_END_ADDRESS
+	 */
+	memblock_mark_kho_scratch(0, ISA_END_ADDRESS);
+
 	/* Throw away partial pages: */
 	memblock_trim_memory(PAGE_SIZE);
 
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 68530fad05f7..09d6a068b14c 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -233,6 +233,31 @@ setup_ima_state(const struct kimage *image, struct boot_params *params,
 #endif /* CONFIG_IMA_KEXEC */
 }
 
+static void setup_kho(const struct kimage *image, struct boot_params *params,
+		      unsigned long params_load_addr,
+		      unsigned int setup_data_offset)
+{
+#ifdef CONFIG_KEXEC_HANDOVER
+	struct setup_data *sd = (void *)params + setup_data_offset;
+	struct kho_data *kho = (void *)sd + sizeof(*sd);
+
+	sd->type = SETUP_KEXEC_KHO;
+	sd->len = sizeof(struct kho_data);
+
+	/* Only add if we have all KHO images in place */
+	if (!image->kho.fdt || !image->kho.scratch)
+		return;
+
+	/* Add setup data */
+	kho->dt_addr = image->kho.fdt->mem;
+	kho->dt_size = image->kho.fdt->memsz;
+	kho->scratch_addr = image->kho.scratch->mem;
+	kho->scratch_size = image->kho.scratch->bufsz;
+	sd->next = params->hdr.setup_data;
+	params->hdr.setup_data = params_load_addr + setup_data_offset;
+#endif /* CONFIG_KEXEC_HANDOVER */
+}
+
 static int
 setup_boot_parameters(struct kimage *image, struct boot_params *params,
 		      unsigned long params_load_addr,
@@ -312,6 +337,13 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 				     sizeof(struct ima_setup_data);
 	}
 
+	if (IS_ENABLED(CONFIG_KEXEC_HANDOVER)) {
+		/* Setup space to store preservation metadata */
+		setup_kho(image, params, params_load_addr, setup_data_offset);
+		setup_data_offset += sizeof(struct setup_data) +
+				     sizeof(struct kho_data);
+	}
+
 	/* Setup RNG seed */
 	setup_rng_seed(params, params_load_addr, setup_data_offset);
 
@@ -479,6 +511,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		kbuf.bufsz += sizeof(struct setup_data) +
 			      sizeof(struct ima_setup_data);
 
+	if (IS_ENABLED(CONFIG_KEXEC_HANDOVER))
+		kbuf.bufsz += sizeof(struct setup_data) +
+			      sizeof(struct kho_data);
+
 	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
 	if (!params)
 		return ERR_PTR(-ENOMEM);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index ead370570eb2..e2c54181405b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -385,6 +385,28 @@ int __init ima_get_kexec_buffer(void **addr, size_t *size)
 }
 #endif
 
+static void __init add_kho(u64 phys_addr, u32 data_len)
+{
+#ifdef CONFIG_KEXEC_HANDOVER
+	struct kho_data *kho;
+	u64 addr = phys_addr + sizeof(struct setup_data);
+	u64 size = data_len - sizeof(struct setup_data);
+
+	kho = early_memremap(addr, size);
+	if (!kho) {
+		pr_warn("setup: failed to memremap kho data (0x%llx, 0x%llx)\n",
+			addr, size);
+		return;
+	}
+
+	kho_populate(kho->dt_addr, kho->scratch_addr, kho->scratch_size);
+
+	early_memunmap(kho, size);
+#else
+	pr_warn("Passed KHO data, but CONFIG_KEXEC_HANDOVER not set. Ignoring.\n");
+#endif
+}
+
 static void __init parse_setup_data(void)
 {
 	struct setup_data *data;
@@ -413,6 +435,9 @@ static void __init parse_setup_data(void)
 		case SETUP_IMA:
 			add_early_ima_buffer(pa_data);
 			break;
+		case SETUP_KEXEC_KHO:
+			add_kho(pa_data, data_len);
+			break;
 		case SETUP_RNG_SEED:
 			data = early_memremap(pa_data, data_len);
 			add_bootloader_randomness(data->data, data->len);
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index f9bc444a3064..9b9f4534086d 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -65,6 +65,8 @@ void __init reserve_real_mode(void)
 	 * setup_arch().
 	 */
 	memblock_reserve(0, SZ_1M);
+
+	memblock_clear_kho_scratch(0, SZ_1M);
 }
 
 static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index d52a7b500f4c..2dd51a77d56c 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -3,9 +3,6 @@
 #define LINUX_KEXEC_HANDOVER_H
 
 #include <linux/types.h>
-#include <linux/hashtable.h>
-#include <linux/notifier.h>
-#include <linux/mm_types.h>
 
 struct kho_scratch {
 	phys_addr_t addr;
@@ -18,6 +15,15 @@ enum kho_event {
 	KEXEC_KHO_UNFREEZE = 1,
 };
 
+#ifdef _SETUP
+struct notifier_block;
+struct kho_node;
+struct folio;
+#else
+#include <linux/notifier.h>
+#include <linux/hashtable.h>
+#include <linux/mm_types.h>
+
 #define KHO_HASHTABLE_BITS 3
 #define KHO_NODE_INIT                                        \
 	{                                                    \
@@ -35,6 +41,7 @@ struct kho_node {
 	struct list_head list;
 	bool visited;
 };
+#endif /* _SETUP */
 
 struct kho_in_node {
 	int offset;
-- 
2.48.1.711.g2feabab25a-goog


