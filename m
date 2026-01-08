Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E161ED1D484
	for <kexec@archiver.kernel.org>; Thu,  8 Jan 2026 16:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iZ8umbGJ/p+Drr1QM9elVdtntyBO93C2g1yduoenlV8=; b=Da5FkLTfxT+yzl/XTsEe0+e+Qy
	ncccNSgLG0DD/YAlGLC/H3OnnZANQKSCEw2h3TuU/blnyM5SF9Y0smEdrpdIZVtfhcftEbR0sBrYm
	OxnE8EhNO8EmdfTf/SHS71+KHApwuhUvrvBuJGOocV/NmPkIzvMKkXXVCh35/TO3qOndKtzrBjiG4
	lr4Tbrj1QkvhhXAC/p5c2/06F2NL2pq5xQlMvRz1RXyFH08GEzyMb6O2cgrl4KBVrOZEts9C1xIbU
	bBQXRFhEkZtOwitnv5HmuGP0CsRkii1gkGNfObM42l+PMJX+VtNS5A4dvMhac4ik1r13LC/mQruLl
	GObhXyrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdt4g-00000000BBh-0Vf7;
	Thu, 08 Jan 2026 16:41:26 +0000
Received: from mail-ot1-f43.google.com ([209.85.210.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdt4e-00000000B9d-0CKt
	for kexec@lists.infradead.org;
	Thu, 08 Jan 2026 16:41:25 +0000
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c95936e43cso1324418a34.0
        for <kexec@lists.infradead.org>; Thu, 08 Jan 2026 08:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767890483; x=1768495283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iZ8umbGJ/p+Drr1QM9elVdtntyBO93C2g1yduoenlV8=;
        b=YyMRNttjRz+Y/06UP53D35HLqHPp1cGU3Tl6yy2q7H1ePMmfze8SQxnUFnM2/N0P1M
         96aoxrt5rNfqfxUQoWz9JBk5KYyFSvdB4+0gpB7rCpiGR8NBVy6XDZfsxS1F4CYIcyEX
         80Y/JN34+wkm+nfmsSDg1XpxQ0cI+MucWiIn8oCsTwH+cz/UUH9K8w5gYERE0tlVpBJM
         jQ/MO0u5bT9XZ5vGUpS750cgIIR7AIcO+JHgDB+pFwNCj352jBsQQqTeoDlp1R6nDDFM
         /7AoEMhBPV0vc3LdDuShdexKiAxOxy0+EIqySybFaeYTyQYiicgTag07hCLY/ViAlLWV
         cBBg==
X-Forwarded-Encrypted: i=1; AJvYcCWt0nUqgIBzt1NQdQppt0g6jDO54PlXXTk787GPMDQC9HSSZFNHvniuif44BpBXakubKkah0w==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQMXHm8vQxIhpgT/0NZ5tfkb+YXnGPQiVgRXio0mJGYffQOTXB
	tjWpwXe4cRfzIqZH6yb8rrx2KPlKm6t2Z0e8rzHx+3ihtQP/GKK4FtmGPeTbnA==
X-Gm-Gg: AY/fxX776qtHy1xMl0hp78hXN0jeWmhxTCF5A4qcYWj/ddscJZ/Esq/33HuLmRjP+uD
	jWbN0ZF3nsLFBpqDB98KTEp339ZuD4QJ9kYyFEUZ36dMzR9GQpSlFfETmGNRc0MT/lbfIRXs7vI
	sIQXotind9k5UPxjtAUI79s/rYEkoVQmPb4udqIr4mKprY0rKJK7tW5zOtMS97beYAVSCnsURNi
	xajDyM6yZ6POji0gNKfNVedxCE42E9fmOhw9iheJy+P2IB4FRrgmXgqdC9idbTn1GVEMoeATh7e
	DhJTKPRQs5wT+rb+rSO1w49TcLmwEk5g8M4sU7TGigoDqvPmaZsJM/mPxkHIKOXjr49lrqIYIo9
	ErHYtz2lOzIFmH7rzBnKGhWGRuuymXyyUu0T/ZTKv7mTaZIR23FuKxF6QfOGsyYLqIvicRmXAds
	9U6A==
X-Google-Smtp-Source: AGHT+IHCIuadUBoGbDl8lPNAk2Neo0/wiZHMcJrJn3lIxd7Vxi/rrb+Y2bIjsKx5NXNgYjuC3j6EEw==
X-Received: by 2002:a05:6830:1cc2:b0:7c5:3045:6c6f with SMTP id 46e09a7af769-7ce50a28c93mr3497087a34.20.1767890482801;
        Thu, 08 Jan 2026 08:41:22 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af8besm5595632a34.14.2026.01.08.08.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:41:22 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 08 Jan 2026 08:40:59 -0800
Subject: [PATCH v3 2/2] kho: history: track kexec boot counter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-kho-v3-2-b1d6b7a89342@debian.org>
References: <20260108-kho-v3-0-b1d6b7a89342@debian.org>
In-Reply-To: <20260108-kho-v3-0-b1d6b7a89342@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
 riel@surriel.com, Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3603; i=leitao@debian.org;
 h=from:subject:message-id; bh=EGjW1NDVm9NCUZnt/TocKG3VnYx6DZQuPLEer3uoR8g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpX94vFhyv1+q5nq7d3U4aG09l2a2v9OVLjM38M
 Alw0viiRZ2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaV/eLwAKCRA1o5Of/Hh3
 bYQwD/9eHb6ErCrxXzsTuDNHlKgULxd03DOyrKRfmQu7kTOUtZlqSCyZ4P2EeLCfbluUpJnnESG
 UAVFWIxNs7YXzhUNd7cWqmoZH+mBLVOby7T8HD+MeG+8z6VuUQXpE9mQVEsS0N5g0L6+FWWFgAd
 VqezYtxXpJeV32vXCpcmBEcZpUE3od+8MAIK1LqWcUbsCKLy/0kXXemulGMzLks31aLqX86ni/i
 X+9lZpg99/gVXF8Jz3lqX+hNi9TIRsXWGaU281XTD1tF3BgTcXXCyHE8m15DjbelamQimU3chBg
 DMteI6JOK4sjOWjTLtutUHeHuUwcuuUpiTc2Zk+pvF6X4ij24/VQcoCVl9QLiHL4EjTlbYaXGMK
 eh6yLVMjs32YEVhnOxY850v6dWpXovo5PFQUd3ECljjlvTmrD6aLrQh1g92CX7sPIoJYTOEIl8x
 81RtpCzW+Gky6ezAfpzbZfnGAJrQi2XvgB6Y7xvZEiDsGTKtnNKeHZ4uZDf2xt0EBZmbk8aP4Rd
 IQ/tPzLyEsBSAJTjlPDAIaeEFRFmBwoI1s/vu1zCB0DiRnm6/tnremV8GX/ewBSbiyaDWX2+8zH
 AzQ0hXXhX98UteCdW/+vC7v/59qftT+spmlGWRF8WqkY9v/ZZwZ3kMESQjBGioYQXj3Q3+SR7BB
 FQswweva+CDz0Zg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_084124_092194_04C2D28E 
X-CRM114-Status: GOOD (  17.68  )
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

Track and display the number of kexec boots since the last cold reboot.

This extends the previous kernel release tracking by adding a counter
that increments with each kexec boot. The counter provides visibility
into the kexec chain depth, which is useful for understanding boot
history in production environments.

Add a new property "kexec-count" in KHO FDT alongside the existing
"previous-release" property. The counter is:

 - Initialized to 0 on cold boot (when kho_in is first instantiated)
 - Incremented by 1 on each subsequent kexec
 - Printed alongside the previous kernel release version

The counter is stored as a 32-bit unsigned integer in FDT format.

This is different than counter for LUO, given KHO can be used
independently from LUO.

Also WARN() if KHO_PROP_PREVIOUS_RELEASE doesn't exist, because it
must exist if KHO_PROP_PREVIOUS_RELEASE exists.

Signed-off-by: Breno Leitao <leitao@debian.org>
Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho/abi/kexec_handover.h |  3 +++
 kernel/liveupdate/kexec_handover.c     | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index f4f31e8f575b..9c4fc4c6a212 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -87,6 +87,9 @@
 /* The FDT property to track previous kernel (kexec caller) */
 #define KHO_PROP_PREVIOUS_RELEASE "previous-release"
 
+/* The FDT property to track number of kexec counts so far */
+#define KHO_PROP_KEXEC_COUNT "kexec-count"
+
 /**
  * DOC: Kexec Handover ABI for vmalloc Preservation
  *
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index b2d57868d22f..34cfc98076b8 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1248,6 +1248,7 @@ struct kho_in {
 	phys_addr_t scratch_phys;
 	phys_addr_t mem_map_phys;
 	char previous_release[__NEW_UTS_LEN + 1];
+	u32 kexec_count;
 	struct kho_debugfs dbg;
 };
 
@@ -1319,6 +1320,7 @@ static __init int kho_out_fdt_setup(void)
 {
 	void *root = kho_out.fdt;
 	u64 empty_mem_map = 0;
+	u32 kexec_count;
 	int err;
 
 	err = fdt_create(root, PAGE_SIZE);
@@ -1329,6 +1331,10 @@ static __init int kho_out_fdt_setup(void)
 			    sizeof(empty_mem_map));
 	err |= fdt_property_string(root, KHO_PROP_PREVIOUS_RELEASE,
 				   init_uts_ns.name.release);
+	/* kho_in.kexec_count is set to 0 on cold boot */
+	kexec_count = kho_in.kexec_count + 1;
+	err |= fdt_property(root, KHO_PROP_KEXEC_COUNT, &kexec_count,
+			    sizeof(kexec_count));
 	err |= fdt_end_node(root);
 	err |= fdt_finish(root);
 
@@ -1443,15 +1449,23 @@ void __init kho_memory_init(void)
 static int __init kho_print_previous_kernel(const void *fdt)
 {
 	const char *prev_release;
+	const u32 *count_ptr;
 	int len;
 
 	prev_release = fdt_getprop(fdt, 0, KHO_PROP_PREVIOUS_RELEASE, &len);
 	if (!prev_release || len <= 0)
 		return -ENOENT;
 
+	/* Read the kexec count from the previous kernel */
+	count_ptr = fdt_getprop(fdt, 0, KHO_PROP_KEXEC_COUNT, &len);
+	if (WARN_ON(!count_ptr || len != sizeof(u32)))
+		return -ENOENT;
+	kho_in.kexec_count = *count_ptr;
+
 	strscpy(kho_in.previous_release, prev_release,
 		sizeof(kho_in.previous_release));
-	pr_info("exec from: %s\n", kho_in.previous_release);
+	pr_info("exec from: %s (count %u)\n", kho_in.previous_release,
+					      kho_in.kexec_count);
 
 	return 0;
 }

-- 
2.47.3


