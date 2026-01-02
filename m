Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E02FA3752
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4jFm0T13XSPTZvu12KUE1F2bt+65MnaHKDG0zzV+nX8=; b=FHwbZPGi+sXgyutIiweAX4hcNw
	lxEGWQ2HVfFYU5A/yXQmYB0ev7cdV9eDkVe7h2fjIUHLFOtaMnXdW9F/LPfqr2i6OyK3hKDLtrYC5
	8mc9W8OHon0o1x3QnKxXs0lMmESqU+Ot3RKKWYPhm7UHjfG0Ax1vfGHS4nhnEcytYIHOLVgW+NyDx
	gOBtRrIOw6iewX4nSb6hxpSs3sjzhzOHovmlpItKg6k1fPyJdCH0vv/c8AHKtYfzBnl1WuYxc11H/
	9frWCtot6kqWXLmTl8eomQbi35mOrQcB5G1ZIGFQKqtKHTuNV89/HKu7uX0rjVMJoLNlVYDL5badf
	J7k7Ch4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbgXF-00000008OJN-0G1r;
	Fri, 02 Jan 2026 14:53:49 +0000
Received: from mail-oi1-f169.google.com ([209.85.167.169])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbgXC-00000008OIU-2gT1
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 14:53:47 +0000
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45392215f74so4225743b6e.3
        for <kexec@lists.infradead.org>; Fri, 02 Jan 2026 06:53:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767365625; x=1767970425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4jFm0T13XSPTZvu12KUE1F2bt+65MnaHKDG0zzV+nX8=;
        b=l4MN6CkQaSsCKZnaVxHQnE+y6UNkZ+wodT031jktujnZCQq2EUGQv5iUvvmrAmK/vk
         UpSGA6MCy3rigT2sC32Moh006gTd+5yTa1IJT09cwwciww8CwJM6l+/QpEYYN6ULbsTE
         a20Rf5wAQ4326PfazuPar8C2SP/FfoS1K8ZSF8Ov1/bbUQmZq5dLj56cmKt+XhklISCu
         ER7Y5XdAnKN6GvsyatOr4tnb4/MVdBEpldnIOQOpd4XNTkGv5HQfO0EmeOR9qH9zPquU
         McjEeJ7qDk1+dOIT9Vf77QxtOepLYaR66OT36R1OIlxpYdi1LlshBtH6JUX+Wce+GwYW
         Szyw==
X-Forwarded-Encrypted: i=1; AJvYcCWOQGvqwBB3wgWb6QPGVBR6tnzwgTKCKGJXvKS6nOPOmjD9oQ/csRpBor72E8FVc/MixsJR3Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxu3nK2zP+7SOLAPR07yjBNflpzQXO5CO9SXEb804Zeoatp7i0E
	Vv5L6MctARghL+oC5gx+5dO7YT2rU/0uXNT8k0EuV+LuD60D7IvbXC67aEwSYQ==
X-Gm-Gg: AY/fxX7JvqlS/7My+edeNLpAAfvvyt+T0xKTS6wttgNhF+fBjdtc7TzGp4EmAn78bS3
	k+keAwX3n8ZsXYUPeTI6H7PhFvDEoMN4FAetKA7D0OosnQ97VMgJVaMnIaYAjENepHxT3HsY0mp
	lncCfSAX9Z6TNFinAGSylrQI62BoqVhsq7BDtXu9M7Jv5OEWzNIO84h6HgUoFGz5R01XkNZiXKe
	iUu+/O52zFHPrbBUbcmvQwKrSVQ6kvfmDY8Bcuw9rQ5KdnvXHckOoAemj5HPhPdek8AP5XeVGpf
	g5fACO9bRY7YfQCo7zV9pdWcCwA7Ji3bE9jMbvfP/SO+RWdc8uMMANow029zmLwyiNfJ22NVIae
	FGOrsDODwZcQRAJwMq4x+oDDbXX/+zYdJKm2GTG3mry1hTF9Z3MYNPrUEFnnekkgzYpX73K79QB
	H9FJ7D5nbRNnBxqg==
X-Google-Smtp-Source: AGHT+IGmJX/gWScL9DW7qlBrngJY3793niWXqd+psddu0novXBDKwZolnXT6vOxbAgd6Px9WJeU2HA==
X-Received: by 2002:a05:6808:1247:b0:450:b3a:539e with SMTP id 5614622812f47-457b1f09e02mr17787125b6e.28.1767365625515;
        Fri, 02 Jan 2026 06:53:45 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457b3cc0928sm19854424b6e.10.2026.01.02.06.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 06:53:45 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 02 Jan 2026 06:53:24 -0800
Subject: [PATCH v2 2/2] kexec: history: track kexec boot counter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-kho-v2-2-1747b1a3a1d6@debian.org>
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
In-Reply-To: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
 riel@surriel.com, Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3495; i=leitao@debian.org;
 h=from:subject:message-id; bh=1J/J5ij0+LfyJIZQr+aeQQR9ouWDsomWRVfj1KaYkEk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpV9v1LR8K2jVcyo0Xngo00G/NBInYvKssHASJN
 f9h88ed14OJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaVfb9QAKCRA1o5Of/Hh3
 bUQtD/0brf946ihzUuvEQ6ksdzQPT41UQBAtTG3YPKf+kVRegfC4XfpErJI7CFo0Kwa6aI99E64
 QeEd8RMWgVejsfvhMBPHudOp3prj7N6bM9a23ZykDNrIOlo5wTuBKLu/lfFTdOsfC72nVYRdmMM
 fqm2+ze34QevvPttBHCnFk4vAm0SaZ/szA8A83eg0FCPqVpUl+Ap5e3iCdzH4SWElMiP8+KAUnD
 ByzlQDuSUkVgwEFzeMrQ7qqzOiGJj2ckyLkgOLrHQSEVUiG36OXaUVbRINc0pc9wpAkLth+JSZC
 T4F0eU3f9WbrDTK/2xbI4XhvKiNelMCLSrQfS6SjA+ETWtiOYfDv9uIGhrx8lEBnYHKu70E7PQr
 4DcCoxOCBmYGv/Ig4U77BW/lR5iieC28cSQST8GNaI1v1lELkHGEHZsQHOm2nQ+h+7hs8JYW5tI
 DsjmCSqVe+Ckfp3ZzQ7nfgSKb7quOJ+zrvrlFpwoEVsKns3QWmZES6NYw2pyAVTTiPvpTLn+UGP
 YqG6RQTd0oZinBTrFfcGALM7M4W8wmnBWi1a0DZXYYO6nskdklOAUVBT9knmR1QOZ0qVmpCuLat
 HS/3LWKSyvzIjC6id9lKy8HKxhfEj9+Br2oWjqXim0XVLEN560iWsilfAyty3cw8KvrBZG9pOu1
 MJl+dUxNnXe2YAQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_065346_686121_1BF7AC16 
X-CRM114-Status: GOOD (  16.54  )
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

Track and display the number of kexec boots since the last cold reboot
when CONFIG_KEXEC_HISTORY is enabled.

This extends the previous kernel release tracking feature by adding
a counter that increments with each kexec boot. The counter provides
visibility into the kexec chain depth, which is useful for understanding
boot history in production environments.

Add a new property, "kexec-count" in KHO FDT alongside the existing
"previous-release" property. The counter is:

 - Initialized to 0 when kho_in is instantiated.
 - Incremented by 1 on each subsequent kexec.
 - Printed alongside the previous kernel release version.

The counter is stored as a 32-bit unsigned integer in FDT format and is
only active when CONFIG_KEXEC_HISTORY is enabled.

Signed-off-by: Breno Leitao <leitao@debian.org>
Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 06d99627bb3c..fe5a2c5c4c86 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -38,6 +38,7 @@
 #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
 #define PROP_SUB_FDT "fdt"
 #define PROP_PREVIOUS_RELEASE "previous-release"
+#define PROP_KEXEC_COUNT "kexec-count"
 
 #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
 
@@ -1257,6 +1258,7 @@ struct kho_in {
 	phys_addr_t scratch_phys;
 #ifdef CONFIG_KEXEC_HISTORY
 	char previous_release[__NEW_UTS_LEN + 1];
+	u32 kexec_count;
 #endif
 	struct kho_debugfs dbg;
 };
@@ -1330,6 +1332,9 @@ static __init int kho_out_fdt_setup(void)
 	void *root = kho_out.fdt;
 	u64 empty_mem_map = 0;
 	int err;
+#ifdef CONFIG_KEXEC_HISTORY
+	u32 kexec_count;
+#endif
 
 	err = fdt_create(root, PAGE_SIZE);
 	err |= fdt_finish_reservemap(root);
@@ -1340,6 +1345,10 @@ static __init int kho_out_fdt_setup(void)
 #ifdef CONFIG_KEXEC_HISTORY
 	err |= fdt_property_string(root, PROP_PREVIOUS_RELEASE,
 				   init_uts_ns.name.release);
+	/* kho_in.kexec_count is set to 0 on cold boot */
+	kexec_count = cpu_to_fdt32(kho_in.kexec_count + 1);
+	err |= fdt_property(root, PROP_KEXEC_COUNT, &kexec_count,
+			    sizeof(kexec_count));
 #endif
 	err |= fdt_end_node(root);
 	err |= fdt_finish(root);
@@ -1468,6 +1477,7 @@ void __init kho_memory_init(void)
 static void __init kho_print_previous_kernel(const void *fdt)
 {
 	const char *prev_release;
+	const u32 *count_ptr;
 	int len;
 
 	prev_release = fdt_getprop(fdt, 0, PROP_PREVIOUS_RELEASE, &len);
@@ -1476,8 +1486,19 @@ static void __init kho_print_previous_kernel(const void *fdt)
 
 	strscpy(kho_in.previous_release, prev_release,
 		sizeof(kho_in.previous_release));
-	pr_info("This kernel was kexec'ed from kernel release: %s\n",
-		kho_in.previous_release);
+
+	/* Read the kexec count from the previous kernel */
+	count_ptr = fdt_getprop(fdt, 0, PROP_KEXEC_COUNT, &len);
+	if (WARN_ON_ONCE(!count_ptr || len <= 0))
+		/*
+		 * PROP_KEXEC_COUNT should exist if PROP_PREVIOUS_RELEASE
+		 * exists.
+		 */
+		return;
+	kho_in.kexec_count = fdt32_to_cpu(*count_ptr);
+
+	pr_info("This kernel was kexec'ed from kernel release: %s (kexec count: %u)\n",
+		kho_in.previous_release, kho_in.kexec_count);
 }
 #else
 static void __init kho_print_previous_kernel(const void *fdt) { }

-- 
2.47.3


