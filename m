Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACAFC369DC
	for <kexec@archiver.kernel.org>; Thu,  1 May 2025 23:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9tR6KSaINrSgKjMPUX02kTLoAnxRQKWJgAy6kmPfqzc=; b=cFqY3yhRf65IQLqYbUPqs5Xydw
	NL/fJpP3hgSRYdgvvcjoCdR/66qT+Aj8lsl2MZ6pOh+TFCDZEJA00vUmZMWdmVqkf1weHQTADL1Z5
	5PnVU7cWALodPZUWaninjAeoissn+DteBI12wZwh+dgrdj1X4zXR2R8TvpuZVOTtTGtfTe2H7V1YL
	ZMdmaTaxCTReFjtVsMa3ir8HCDy+VjtWMyP3hM3GH+Wey4BDsnLVdt3aHNFAYvHu4xdSwh8ILBKL7
	unKXm4uWR4O3yall9Fpi0NbsldZIPoQG3EGTiavBRZjqeyAK0ql8hJxUz6mpMIeL/lQ9DYsnTTfin
	YnGGlBIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAdKM-00000000Gu8-0k2u;
	Thu, 01 May 2025 23:28:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAcpA-000000007oS-0cum
	for kexec@bombadil.infradead.org;
	Thu, 01 May 2025 22:56:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9tR6KSaINrSgKjMPUX02kTLoAnxRQKWJgAy6kmPfqzc=; b=SpROi2vDnQVOljqpC6C1n/i/U5
	wnpPzHJnlccAXflpZ2/LYDe24bCk7MDAF7M2kzcG+mRLI3hr/TTKglHeRYr+7f5Hspcf/hLAhAcTk
	imecCzIsbBbwIsrQTrztKq3jEpUtN4dBaJRBZ6ee+2ONz/bClhEEOXhTGocYfFsg1XMqb4Gh80vSv
	5xZ2aKfdaHngH2F8+dTrXSZIe2xX+st4sY1J35hiqWIRGDukU6Fwf7IcZYpFE70APNophviNzZlSj
	TSYIifIG4ybpiO85tpjl1El+Vzw3ZAognBc/BOArMl8oR3ComI6mjNNf1sFSbFnGk8KhHOum94v5w
	+ZF37L/A==;
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uAcoa-0000000EC8R-49HX
	for kexec@lists.infradead.org;
	Thu, 01 May 2025 22:56:10 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-b1b2fa98c39so1464147a12.2
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746140133; x=1746744933; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9tR6KSaINrSgKjMPUX02kTLoAnxRQKWJgAy6kmPfqzc=;
        b=T2DsLnQzqhySnoyDNlB1a4WHl2IKiKk9oMz/t2XtQrnDPkJDfzLtbA0iOl6nivN3IQ
         ygksaa5p5m0wf1BJErDc9GBXT8A+IPofdYF3RhaRlSmPEPYhiI5WO3kQmoCA47xIY956
         qEKgmoCXvkjJ0jvdg3W+Zd/hNcUN8LnZtf5tVScteLl7UnfXm/DBeKF0mSjfmAHiVUQa
         2KYBOF0jcEVhVnBjMs7dwCHuvr+UA1JS3qgoZ9aMu/91eUrZplSXQRP1wagV47gdvDBp
         zChPFHOsp/YODunVyI/aFIzOnk9/0RfSzIlqbr3Y7NSUcwIInxnJZSihLvvTqreHbO5U
         7KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746140133; x=1746744933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tR6KSaINrSgKjMPUX02kTLoAnxRQKWJgAy6kmPfqzc=;
        b=o0WdYdmQMqylZ53xpLFhLKmgOQPZFV+zOTBBzeHl0wDf3FnrjnbdDqEk+vku7pSXc4
         H5nEtfdDH9JpHNjP7Zjq0xYHVbdNT4vyCrKNBA24N+F2j/v7BYSzU+4wvf0VaH0sMDIE
         qL+E9EC9X14+CdsMoS1R3tc0EOzFBOBXEbRIDlCfydX84CZ3Bmv/akBUrP/OXIOTSdMm
         oKFoZ1EjVAT91wGsPY/WsVW4t8qbxQDMcsUfI/rEPBopMMp6mH2O3cjQGQEz+Ef6ajJ3
         WWpsAS3LNisYnFfR6JtGwV3YQHWUlYXuHMG3ZzJPGzbKWAJpsttRJLBgRAExZxST3E+R
         OvKA==
X-Forwarded-Encrypted: i=1; AJvYcCX7Irx2vInAO3n1jIX8w9462Th8W/C2RoOjqGM877+QJf72frhFeYXrpRPeYtsO2oDEZzbDJw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzfptHyN5ZTpvAhNfq+1MOFdq/RA4OAAl46YkuhUfQniA0r6udb
	iE+8NT4V9bHzm7QWLaoyv+iSaE1Pyd2HlVkSMfSOcDe8hKjXH1eCUS3bWLAIbwWW0hwnddXFoaS
	2V47osTUw2kVu3pKHGg==
X-Google-Smtp-Source: AGHT+IErNLm5q49Y+gF9KR931i043ZTBU+yktXpy37UrZ25yAfY7bgNNHH0I0TSqRbLeXIHGP0OK8nPcEJ7Tt5BA
X-Received: from pfbim4.prod.google.com ([2002:a05:6a00:8d84:b0:732:2279:bc82])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:350d:b0:1f5:a05b:c741 with SMTP id adf61e73a8af0-20cde75bf29mr1013805637.18.1746140132864;
 Thu, 01 May 2025 15:55:32 -0700 (PDT)
Date: Thu,  1 May 2025 15:54:19 -0700
In-Reply-To: <20250501225425.635167-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250501225425.635167-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250501225425.635167-13-changyuanl@google.com>
Subject: [PATCH v7 12/18] x86/kexec: add support for passing kexec handover
 (KHO) data
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: changyuanl@google.com, akpm@linux-foundation.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_235556_902538_2BDC615D 
X-CRM114-Status: GOOD (  19.45  )
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

kexec handover (KHO) creates a metadata that the kernels pass between each
other during kexec. This metadata is stored in memory and kexec image
contains a (physical) pointer to that memory.

In addition, KHO keeps "scratch regions" available for kexec: physically
contiguous memory regions that are guaranteed to not have any memory that
KHO would preserve. The new kernel bootstraps itself using the scratch
regions and sets all handed over memory as in use. When subsystems that
support KHO initialize, they introspect the KHO metadata, restore preserved
memory regions, and retrieve their state stored in the preserved memory.

Enlighten x86 kexec-file and boot path about the KHO metadata and make sure
it gets passed along to the next kernel.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 arch/x86/include/asm/setup.h           |  2 ++
 arch/x86/include/uapi/asm/setup_data.h | 13 ++++++++-
 arch/x86/kernel/kexec-bzimage64.c      | 37 ++++++++++++++++++++++++++
 arch/x86/kernel/setup.c                | 26 ++++++++++++++++++
 4 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ad9212df0ec0c..3b37571911f4c 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -67,6 +67,8 @@ extern void x86_ce4100_early_setup(void);
 static inline void x86_ce4100_early_setup(void) { }
 #endif
 
+#include <linux/kexec_handover.h>
+
 #ifndef _SETUP
 
 #include <asm/espfix.h>
diff --git a/arch/x86/include/uapi/asm/setup_data.h b/arch/x86/include/uapi/asm/setup_data.h
index 50c45ead4e7c9..2671c4e1b3a0b 100644
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
+	__u64 fdt_addr;
+	__u64 fdt_size;
+	__u64 scratch_addr;
+	__u64 scratch_size;
+} __attribute__((packed));
+
 #endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI_ASM_X86_SETUP_DATA_H */
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 68530fad05f74..dad174e3bed0d 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -233,6 +233,32 @@ setup_ima_state(const struct kimage *image, struct boot_params *params,
 #endif /* CONFIG_IMA_KEXEC */
 }
 
+static void setup_kho(const struct kimage *image, struct boot_params *params,
+		      unsigned long params_load_addr,
+		      unsigned int setup_data_offset)
+{
+	struct setup_data *sd = (void *)params + setup_data_offset;
+	struct kho_data *kho = (void *)sd + sizeof(*sd);
+
+	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER))
+		return;
+
+	sd->type = SETUP_KEXEC_KHO;
+	sd->len = sizeof(struct kho_data);
+
+	/* Only add if we have all KHO images in place */
+	if (!image->kho.fdt || !image->kho.scratch)
+		return;
+
+	/* Add setup data */
+	kho->fdt_addr = image->kho.fdt;
+	kho->fdt_size = PAGE_SIZE;
+	kho->scratch_addr = image->kho.scratch->mem;
+	kho->scratch_size = image->kho.scratch->bufsz;
+	sd->next = params->hdr.setup_data;
+	params->hdr.setup_data = params_load_addr + setup_data_offset;
+}
+
 static int
 setup_boot_parameters(struct kimage *image, struct boot_params *params,
 		      unsigned long params_load_addr,
@@ -312,6 +338,13 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
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
 
@@ -479,6 +512,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
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
index 766176c4f5ee8..664cd21b85329 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -451,6 +451,29 @@ int __init ima_get_kexec_buffer(void **addr, size_t *size)
 }
 #endif
 
+static void __init add_kho(u64 phys_addr, u32 data_len)
+{
+	struct kho_data *kho;
+	u64 addr = phys_addr + sizeof(struct setup_data);
+	u64 size = data_len - sizeof(struct setup_data);
+
+	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER)) {
+		pr_warn("Passed KHO data, but CONFIG_KEXEC_HANDOVER not set. Ignoring.\n");
+		return;
+	}
+
+	kho = early_memremap(addr, size);
+	if (!kho) {
+		pr_warn("setup: failed to memremap kho data (0x%llx, 0x%llx)\n",
+			addr, size);
+		return;
+	}
+
+	kho_populate(kho->fdt_addr, kho->fdt_size, kho->scratch_addr, kho->scratch_size);
+
+	early_memunmap(kho, size);
+}
+
 static void __init parse_setup_data(void)
 {
 	struct setup_data *data;
@@ -479,6 +502,9 @@ static void __init parse_setup_data(void)
 		case SETUP_IMA:
 			add_early_ima_buffer(pa_data);
 			break;
+		case SETUP_KEXEC_KHO:
+			add_kho(pa_data, data_len);
+			break;
 		case SETUP_RNG_SEED:
 			data = early_memremap(pa_data, data_len);
 			add_bootloader_randomness(data->data, data->len);
-- 
2.49.0.906.g1f30a19c02-goog


