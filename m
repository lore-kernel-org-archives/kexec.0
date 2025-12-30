Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8DBE94121
	for <kexec@archiver.kernel.org>; Tue, 30 Dec 2025 14:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mLK1D9aqGISPxdXLsfOEkDLEGBqoig1fU8f2AHbKcKI=; b=CPWKDFq+gKN+OAiHFpPGsR6jm5
	AmG0RmiZ5ptfjcOJ4crMmqv8NhOTl7j5QmIyo+C6Yv//P3Rt1kdAs613YsR6mI/FYcKhJ/BHZSLoL
	ZXLgcce+eJUR8BD/Gn74D5g0dkniNfbtKkfwC0BM6FnzTzfCfrISCMMCARFWTV432BUqFCFKG8BSG
	rena90zTq/E9PsRQx/c+3kgA93gk1Xy7Sf2qVAZjAylg9JlVlO7vKu1BzTljPLpeNSnyfrac5eOME
	U4FU/vcLX3bHwpM3W5IqziIY8Vp7BeCBq3gkl2LfiGoTR6enIjp7EQ5mx8uynKbPW4B1z7PGLUS1t
	ndBTRdwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaaTo-00000004vBL-1fFV;
	Tue, 30 Dec 2025 14:13:44 +0000
Received: from mail-oo1-f43.google.com ([209.85.161.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaaTl-00000004vAc-3HSk
	for kexec@lists.infradead.org;
	Tue, 30 Dec 2025 14:13:42 +0000
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-657523b5db0so2138402eaf.2
        for <kexec@lists.infradead.org>; Tue, 30 Dec 2025 06:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767104020; x=1767708820;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLK1D9aqGISPxdXLsfOEkDLEGBqoig1fU8f2AHbKcKI=;
        b=CIYZxOelJ5RDtpalmj5+9roGzEN482Luc7B5k6bEe6BQBT6gJMbp2oMV4vPK1FKtC/
         RhktDF/DDa0i3fPyJ87KNTIJQXBiy3xEh2B2hOWgE1J1kIXAeXu+1qUhaGJpvHZ8NR+0
         JtF0KtCbCwQf0evTetjh9qHJNSMSbwbCD4P23lUHGFXnbQ56lMx+SpNK0JAUps+dnFhX
         +1RgNpKBrlE/D/MlFxNMIbilpHRpKXUkfOUfy+bEH3HOtKowYjul++Vznrtr935ofQdJ
         DU19KKBJ2XD2K3Pq6Sq8rY4M45FPwmWjZIEK1lnCmTjwn7kOUrDQdMhJZWD6GgbUK4WL
         yzzw==
X-Forwarded-Encrypted: i=1; AJvYcCVKwTQxRyDlQBnMj8Ns3XsjGN69k/PUaQ8XFL5lW7QGGdoVOfVCy86zLkF+ofrPQfdv+7DJZA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyDQ6kFuZooEoM8W2hleWD2TBa8OMelT62A9p5T5Vyryuwv1EAi
	MtGo+BTLHAWc3/q5EB2gO3NheMJvy+6zN58Eiop6wYbUjIgj6Y3ZZ5cV
X-Gm-Gg: AY/fxX4m80Y5HFHbrDyPLSm2W/xQA9UzvQ198zFtDHHVLH/5Re6JjVpsnxLA0+bKryq
	8ArAsYFMHQhgI8yilmK0Bd3GyNIr6BrpVxVDRZmHIo0X78WxrbDCm7HTuXOiMvJGKMwrnHEQJ4K
	8bzKbI0rRNFtwG4REffrQN0FjOxGhUglOdIEKzmSaV9x+IL4VPFKEInVp4zMUGqMzPu/JooDPDp
	yWS/qt9cuCSJt8Iqv1m9IgEpWiOideQSlCTqiIrEBI4J9F9RqZVXNUohxAblDSrSPR0MiI8JPv6
	9mRAVIoRdfihZjCotmOQiEpPx08DoJPbAO/tZZqBGu8KqWS7qzKe1wdSu5LITPNyCGyR0nBMHiR
	k5purlzLzeOVQjHVgqW4A9Ve/nl+0Elc9RlrXqVHbkE6OX3REo8BK8LjVX4h5fJWpyObOnBWNlb
	IMCp2Vimey1ag1gw==
X-Google-Smtp-Source: AGHT+IGv4hgA4RK+/hAqnWuIzxUEbkxk7UI7cZze7GMuRgrBPu7eHE9ZgTQA0cPeHSPZAv5YDbYeLg==
X-Received: by 2002:a05:6820:267:b0:65c:fc36:4a6d with SMTP id 006d021491bc7-65d0ea4be60mr10400519eaf.28.1767104020021;
        Tue, 30 Dec 2025 06:13:40 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4a::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f4b7c42sm19071790eaf.6.2025.12.30.06.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 06:13:39 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 30 Dec 2025 06:13:23 -0800
Subject: [PATCH RFC] kexec: add option to print previous kernel release
 after kexec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251230-kho-v1-1-4d795a24da9e@debian.org>
X-B4-Tracking: v=1; b=H4sIAAPeU2kC/6tWKk4tykwtVrJSqFYqSi3LLM7Mz1OyUjDUUVBKz
 kjMS0/VzUxRslJQMjIwMjU0MjbQzc7I1zU3NzBPtUg0Sk0zTFXSUVAqKEpNy6wAmxKtFOTmrBQ
 LESwuTcpKTS4B6VeqrQUALnl+n2wAAAA=
X-Change-ID: 20251230-kho-7707e8a2ef1e
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
 riel@surriel.com, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5289; i=leitao@debian.org;
 h=from:subject:message-id; bh=gK8KJEjlEAfBqObb/slM/LZJZuItTQI6xDseBucP/Xg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpU94SxD28tleBbvF+TLi4wjE43Uo4k3nzDqek3
 Fv/zPpwjAGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaVPeEgAKCRA1o5Of/Hh3
 ba4YD/wI9BraF2/4xSe6rqirbLk4zVpwJGQ2RcsjWPrxVDHiKcj3e0uyeGj5kdNnx+FFsXA3pqa
 SUnhvSCMrm7vR3FqxrTyeb77jRLtWRSxQiohSjMyu8pqQAGCGL4Wv9dztVb5y/IcWcBtR0J1o+m
 pt1uzfl4le4JR0LZRllCDBexg+A57AByhm5wXOCT+xxHoMMCzBxWkBBDvM9fy42pgQwdaYsJzTh
 20B/OVWtDJ/QQrTfBBPIE9DF9Q+ipIsaAhR99jDObV3L9h/rGnqFb05IIqCdoivDdA0V0smIi6c
 7xfpCZSIRAboZdxhscYDxScngYQhSt0kaN2Oeo8/fXJRFo+homluJE2VUrFbC4tayop3th9C9fq
 aIT9fWMUHse6s9HTsBJuaXuhrgc1m7Cyo1TaHWlOaX/cYjzi8I4yxNNAlSu4zMqwqcIimljF3io
 DYXtHfaEskHUMd3G5nlxiyRDR1AiOV2434HQIrTf/bfaK7TEKTvaBlt+voftPyhQENAkurkrRiB
 /Vg7vzd72AUkGAwssxxjSqQOLoTs+1DCUlqQ5lYQIPlR3u++sKPlVAzwLbZAEzacQ/jZAPG4KcL
 Q2f691EiEYQmosm42BofSABJctYq8o18hGfdgvBGa7JLsV/cwdmNdxyRZgcwmej9VCxdkHOD2GF
 yH5pXsXX4QlW+Bw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_061341_837072_12B0EFCF 
X-CRM114-Status: GOOD (  19.17  )
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

Introduce a new Kconfig option, CONFIG_KEXEC_SHOW_PREVIOUS_RELEASE,
which enables the storage and display of the previous kernel's release
version across kexec boots when using Kexec Handover (KHO).

Motivation
==========

Kernel bugs that depend on the version of the previously running kernel
are not uncommon, especially in scenarios where a buggy kernel kexecs
into a new one and the issue only manifests in the subsequent kernel.

Recent examples include:

 * eb2266312507 ("x86/boot: Fix page table access in 5-level to 4-level paging transition")
 * 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption")
 * 64b45dd46e15 ("x86/efi: skip memattr table on kexec boot")

As kexec-based reboots become more widespread among Linux users, these
issues are becoming increasingly prominent.

When such crashes occur, correlating them to the previous kernel version
is challenging, especially at scale, where the problem may only appear in
specific cases and it is hard to correlate.

With the introduction of Kexec Handover (KHO), we now have a reliable
mechanism to pass information between kernels. This presents an
opportunity to address the problem by carrying the previous kernel's
release version to the next kernel and printing it at boot time.

Implementation Details
======================

The feature is controlled by a new Kconfig option,
CONFIG_KEXEC_SHOW_PREVIOUS_RELEASE.

When enabled, the previous kernel's release version is stored and
printed during boot after a kexec. The option is disabled by default to
avoid unnecessary overhead for users who do not require this
information.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/Kconfig.kexec               | 13 +++++++++++++
 kernel/liveupdate/kexec_handover.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 15632358bcf7..9f2a669e13aa 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -94,6 +94,19 @@ config KEXEC_JUMP
 	  Jump between original kernel and kexeced kernel and invoke
 	  code in physical address mode via KEXEC
 
+config KEXEC_SHOW_PREVIOUS_RELEASE
+	bool "Print previous kernel version on kexec boot"
+	depends on KEXEC_HANDOVER
+	help
+	  When enabled, the kernel will store its release version in the
+	  KHO FDT before kexec, and the newly booted kernel will read and
+	  print this information during early boot.
+
+	  This is useful for debugging and auditing to know which kernel
+	  version performed the kexec that booted the current kernel.
+
+	  If unsure, say N.
+
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	default ARCH_DEFAULT_CRASH_DUMP
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 73da00aeaa99..9e90c8445864 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -21,6 +21,7 @@
 #include <linux/page-isolation.h>
 #include <linux/unaligned.h>
 #include <linux/vmalloc.h>
+#include <linux/utsname.h>
 
 #include <asm/early_ioremap.h>
 
@@ -36,6 +37,7 @@
 #define KHO_FDT_COMPATIBLE "kho-v1"
 #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
 #define PROP_SUB_FDT "fdt"
+#define PROP_PREVIOUS_RELEASE "previous-release"
 
 #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
 
@@ -1253,6 +1255,9 @@ bool kho_finalized(void)
 struct kho_in {
 	phys_addr_t fdt_phys;
 	phys_addr_t scratch_phys;
+#ifdef CONFIG_KEXEC_SHOW_PREVIOUS_RELEASE
+	char previous_release[__NEW_UTS_LEN + 1];
+#endif
 	struct kho_debugfs dbg;
 };
 
@@ -1332,6 +1337,10 @@ static __init int kho_out_fdt_setup(void)
 	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
 	err |= fdt_property(root, PROP_PRESERVED_MEMORY_MAP, &empty_mem_map,
 			    sizeof(empty_mem_map));
+#ifdef CONFIG_KEXEC_SHOW_PREVIOUS_RELEASE
+	err |= fdt_property_string(root, PROP_PREVIOUS_RELEASE,
+				   init_uts_ns.name.release);
+#endif
 	err |= fdt_end_node(root);
 	err |= fdt_finish(root);
 
@@ -1455,6 +1464,25 @@ void __init kho_memory_init(void)
 	}
 }
 
+#ifdef CONFIG_KEXEC_SHOW_PREVIOUS_RELEASE
+static void __init kho_print_previous_kernel(const void *fdt)
+{
+	const char *prev_release;
+	int len;
+
+	prev_release = fdt_getprop(fdt, 0, PROP_PREVIOUS_RELEASE, &len);
+	if (!prev_release || len <= 0)
+		return;
+
+	strscpy(kho_in.previous_release, prev_release,
+		sizeof(kho_in.previous_release));
+	pr_info("This kernel was kexec'ed from kernel release: %s\n",
+		kho_in.previous_release);
+}
+#else
+static void __init kho_print_previous_kernel(const void *fdt) { }
+#endif
+
 void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 			 phys_addr_t scratch_phys, u64 scratch_len)
 {
@@ -1526,6 +1554,8 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	kho_in.fdt_phys = fdt_phys;
 	kho_in.scratch_phys = scratch_phys;
 	kho_scratch_cnt = scratch_cnt;
+
+	kho_print_previous_kernel(fdt);
 	pr_info("found kexec handover data.\n");
 
 out:

---
base-commit: 7620f9ccfabbdaf07620381264d8b8d91412542f
change-id: 20251230-kho-7707e8a2ef1e

Best regards,
--  
Breno Leitao <leitao@debian.org>


