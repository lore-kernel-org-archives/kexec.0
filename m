Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88222D1D483
	for <kexec@archiver.kernel.org>; Thu,  8 Jan 2026 16:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eEKbCl6eHGkX3T8z34Ba8e5S/FDTyu14lC4qmzFFHFA=; b=hlfWHcC6hBTAwaROjAi4KwJsKY
	UaZRDOxQik/eaXaOGUYMIBS1IJDTuXw5M7WVG9Mz7QasmvcrTt1XEo0kfMiZtghfhcCm21JseIG7H
	to6KsftOmVbcxnYDkOIJbT5aiP+/PQLx2yk423HgdxA3PvL3q7i350P/8iv+Echy6MI0abhsdKl4d
	zHHr47SEBzbMV3mKdZbG14Ny1tNHpn9atA4HFwz5hwgUHqiLjDhajg4coHujCZkPDsXbi2gWyJHM1
	mWj2hOPWl8/SeSs6eCfds9JyPNvUe9rN7tCBYrMlrr0AdC7mml1nRmlFQrTvyu2yinax5v1WmQbML
	gWf+ltDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdt4f-00000000BBD-2c8Y;
	Thu, 08 Jan 2026 16:41:25 +0000
Received: from mail-oi1-f175.google.com ([209.85.167.175])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdt4d-00000000B94-071m
	for kexec@lists.infradead.org;
	Thu, 08 Jan 2026 16:41:24 +0000
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-455ddb90934so1121990b6e.0
        for <kexec@lists.infradead.org>; Thu, 08 Jan 2026 08:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767890482; x=1768495282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eEKbCl6eHGkX3T8z34Ba8e5S/FDTyu14lC4qmzFFHFA=;
        b=F0YcdXmkQiWr9RoAisynShLounjmThkXcS60x7lXUFtc4fOw6XuFEw3I7qQdCiO2+/
         evUSGKrtRltnbknvV5Va/xRH7aRUi2t9tV1oPBJV2MNmKBQM0fMeNKoheokOeiBDiBX/
         SByuG8Y+EK1SZYWSNGqsE2P+Zotx2WKGetpkNe00JW9opkS7EsaGODnwmZiTJYL8m1+9
         NQl2dd29wDk16OE8kjS3sufza3ekh1ndWdKL7nwiZyvBW5gKmd7eIcDniAsBcKL6SRRa
         kDkoPS5AUoU8+FapseZS6mv9iakpwtfCf4DIuBd/7MSzzQckoVF6trBLPVdqBol3OnLp
         6EOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT4onNVxAXPdAexdjeMweTfkAwDRpb2I21fvBoSPpiQzm5bQDhefHbq9jc7lXu03+DzYFthw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzpCqub4Kehqt+vNa3RtyQ4JAolS8Ecao74CICzx7CqZ7vCUMDX
	0/az+zLSFoCzVFsenwECmGLiDtF46TxHf0E2X7jrs8HC2qKW/cDtw0Bt
X-Gm-Gg: AY/fxX71solK8HUMFaqx6AxBr11OiPb9yz65jnJUHb4n/RRmtagRdLG5ZYyQq7EQ1IN
	M7D4VnQ13O9nJIPr7/PBGe2zhsPhb/QSy953vxpQP/BNhco9FO3F1YxW6tN9YQJpuKMeYR52Uz9
	RwHYk58xMUw//z+weShq3SntHDN5qjmSSZwAK2ZJdtdAlNKHyX9h2H3vtRDvXpWWNKoVMhrSYb9
	51f+EXVL4D4wDVo/ISU8Q1F0o3pqim5y6Hq5bambyVKo+oAQ5svbu4PiFJ0MTdCDqrIACeHxL8W
	1olvsmL+RadiGVaiHZMr1jaeQgCQxNN+3As+JrQRxkvNGLkClzwjVrEI2Jxwcg1h4nRfUtU5KbF
	W1SAjr8sxihQ9DxjTTu2ajLUDXj/KJFhDBz3PNGltQMrC46uVdq4GaClFYoNuyJXoI2+tElld/t
	jTJA==
X-Google-Smtp-Source: AGHT+IHwg85rGQHbkPrcqt1aBeanOarcVUdF/YJuRLIGyTivBFmbrsvMl5+YqDe216QHSew4Eycetw==
X-Received: by 2002:a05:6808:1188:b0:455:7da6:44d5 with SMTP id 5614622812f47-45a6bdaf691mr2406341b6e.27.1767890481759;
        Thu, 08 Jan 2026 08:41:21 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa5161468sm5298579fac.22.2026.01.08.08.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:41:21 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 08 Jan 2026 08:40:58 -0800
Subject: [PATCH v3 1/2] kho: history: track previous kernel version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-kho-v3-1-b1d6b7a89342@debian.org>
References: <20260108-kho-v3-0-b1d6b7a89342@debian.org>
In-Reply-To: <20260108-kho-v3-0-b1d6b7a89342@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
 riel@surriel.com, Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3243; i=leitao@debian.org;
 h=from:subject:message-id; bh=lVq1FcOCQMqfHOK5DcXTIKEzb9rwsZ/ITwXUKRT+mew=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpX94v0uvNnwH22s6hbp7/tiFmZZwZTGwvXKop4
 GrcufIuHBmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaV/eLwAKCRA1o5Of/Hh3
 bYjfD/4q44IGNvMydiP1wiCUgQyjvqTCiWLge5E7NW/ndXZiqkKPAyOKxtqhbRpe3c4oYG93YXX
 hY1pBWYWitOmAEIXiasAf7f/hD7fCvP3WLdm+BV+gHCkPrEBOny3qIUyZg2srW6xhWOMsnGMXuY
 qG5+RTcUmpRnD6HISAobniQawTfwhu85aUGn8ip5IUZ0YNvAGX/bVHCIqnhPSmItE7H/F7uuenO
 xoXJhbw4VkkHdtk1ybE9RSKp3K0lOV3aqNgwUD3K/yLWx+jibQ2XyLRYDyCYMEaQjToqlSe+NMN
 aBaWk66cmepQT1SWPJqAxVe2DgTJ0bJvcFPCRvnJabEIIrCZCZ3uH0AFNaSJnNsDDjocfjxNwX4
 Tq2CC+Dffe67p72GupDlMCgZBT/Dy4oK3gj2FEZkfgaF0ydlnL5m+E6b9akv0RLs1gaQlXWZ4j1
 xeW6PoYuOwmnzxkN64Wa7WKVg+Uh0LRfqU+a/NJgpJwybc4apdsa3iCTRKx3vXqANCwwctaGjbi
 nK8CZoIV+z5kL8EpHAIKd7NnO7XLIvJOCCfaDyAlIS3gmHIMegwdKiWFlGCZUA5lel0kIgshnLS
 34ZfVxSXBK7smuJX22xF2pphNI9HjIPTgiyH52WyWLw3Ov9QQuyvAj2xn8u4jB8MV8oEOAY2S3C
 wIxZp7CPi87gccw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_084123_072486_CE3FAD5C 
X-CRM114-Status: GOOD (  17.40  )
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

Store and display the kernel version from the previous kexec boot.

The current kernel's release string is saved to the "previous-release"
property in the KHO FDT before kexec. On the next boot, if this property
exists, the previous kernel version is retrieved and printed during
early boot.

This helps diagnose bugs that only manifest when kexecing from specific
kernel versions, making it easier to correlate crashes with the kernel
that initiated the kexec.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/kho/abi/kexec_handover.h |  3 +++
 kernel/liveupdate/kexec_handover.c     | 25 ++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 285eda8a36e4..f4f31e8f575b 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -84,6 +84,9 @@
 /* The FDT property for sub-FDTs. */
 #define KHO_FDT_SUB_TREE_PROP_NAME "fdt"
 
+/* The FDT property to track previous kernel (kexec caller) */
+#define KHO_PROP_PREVIOUS_RELEASE "previous-release"
+
 /**
  * DOC: Kexec Handover ABI for vmalloc Preservation
  *
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 3cf2dc6840c9..b2d57868d22f 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -22,6 +22,7 @@
 #include <linux/page-isolation.h>
 #include <linux/unaligned.h>
 #include <linux/vmalloc.h>
+#include <linux/utsname.h>
 
 #include <asm/early_ioremap.h>
 
@@ -1246,6 +1247,7 @@ struct kho_in {
 	phys_addr_t fdt_phys;
 	phys_addr_t scratch_phys;
 	phys_addr_t mem_map_phys;
+	char previous_release[__NEW_UTS_LEN + 1];
 	struct kho_debugfs dbg;
 };
 
@@ -1325,6 +1327,8 @@ static __init int kho_out_fdt_setup(void)
 	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
 	err |= fdt_property(root, KHO_FDT_MEMORY_MAP_PROP_NAME, &empty_mem_map,
 			    sizeof(empty_mem_map));
+	err |= fdt_property_string(root, KHO_PROP_PREVIOUS_RELEASE,
+				   init_uts_ns.name.release);
 	err |= fdt_end_node(root);
 	err |= fdt_finish(root);
 
@@ -1436,6 +1440,22 @@ void __init kho_memory_init(void)
 	}
 }
 
+static int __init kho_print_previous_kernel(const void *fdt)
+{
+	const char *prev_release;
+	int len;
+
+	prev_release = fdt_getprop(fdt, 0, KHO_PROP_PREVIOUS_RELEASE, &len);
+	if (!prev_release || len <= 0)
+		return -ENOENT;
+
+	strscpy(kho_in.previous_release, prev_release,
+		sizeof(kho_in.previous_release));
+	pr_info("exec from: %s\n", kho_in.previous_release);
+
+	return 0;
+}
+
 void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 			 phys_addr_t scratch_phys, u64 scratch_len)
 {
@@ -1513,7 +1533,10 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	kho_in.scratch_phys = scratch_phys;
 	kho_in.mem_map_phys = mem_map_phys;
 	kho_scratch_cnt = scratch_cnt;
-	pr_info("found kexec handover data.\n");
+
+	if (kho_print_previous_kernel(fdt))
+		/* Fallback message when previous kernel info unavailable */
+		pr_info("found kexec handover data.\n");
 
 out:
 	if (fdt)

-- 
2.47.3


