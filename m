Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AB2EEAA42
	for <kexec@archiver.kernel.org>; Fri, 15 Sep 2023 03:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=keBI05r+sB4dqcVVVfb5I3TzSwdVsGbUxfln9BK9t7Y=; b=oCooi6z7M+REaW
	RrR+f/PPc40VuA6QDromL58ZQ4Jb0Uv+cH5qTlfhjgseOx3kpTlUQ3/C8U0mj96+yXA4Qu0PRx00r
	s8qY7NkPV4VlUE+1390cUTwm88wPo0gogmkzwGLBRnh6mt+BZXFs76uRflGu6+ikd45yWPxxGLOsG
	7oDvk3qHKmCY24J6dXOftK1TX9gM3Jrj8DL9oFM4wGsRPeH2cj49fnED7qsJBgkj/aMgStcVFm88k
	uAZXKhU1l+14N56l5b5IYU5riNgcqESebcTwXaYcKboxW4ur8CicFSvBpdpcrKXjUKIRNiUE0sTnD
	c4a7GcMinNnnWxmfajwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgzsn-009hTd-1n;
	Fri, 15 Sep 2023 03:52:41 +0000
Received: from bg4.exmail.qq.com ([43.155.67.158])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgzsk-009hSq-0d
	for kexec@lists.infradead.org;
	Fri, 15 Sep 2023 03:52:40 +0000
X-QQ-mid: bizesmtp63t1694749935ta7g1mwz
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Sep 2023 11:52:13 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: So52AfFW6n+89qnhveQ80+yrpNkvcNc9Iw+FPH/r/qIvS107qtito6r4M3nLW
	dfTzzXmDt33ewC8743Y3DJC+YWfpEW2u11hshj7qOBnwS/G3IN0goXnXGDztyIO31cZ6z0F
	mOB+7Pxv2pIU50pqX7U+yJb+FCeckKRA9FejErur1QRYBhoEUM8nrdaQukBGjiTw0owmEBy
	7T93QrAWVomQ+ty6EhXFuxpVyfC1m7wF/FLOor7PvBZEpsaPEIYvOPiIX6O9QwyDQ+uwZJy
	pE02io2K+kR4ABCGbP4kP/Yicbu4gaRRew9I5IWhAEqent491UusT+UDvkYWjfP1sdvJ/HA
	O6Fsd+W3T2W9g7hKcR4CoMGq6rvST31o4P6Kv6RcbtrRNYGDgJuwAEE7szkqeEIDPJ3TgWL
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16680766145375676915
From: Song Shuai <songshuaishuai@tinylab.org>
To: lizhengyu3@huawei.com,
	liaochang1@huawei.com,
	xianting.tian@linux.alibaba.com,
	guoren@kernel.org,
	horms@kernel.org,
	horms@verge.net.au,
	huanyi.xj@alibaba-inc.com,
	mick@ics.forth.gr,
	yixun.lan@gmail.com
Cc: kexec@lists.infradead.org,
	Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH 1/7] RISC-V: Use linux,usable-memory-range for crash kernel
Date: Fri, 15 Sep 2023 11:50:07 +0800
Message-Id: <20230915035013.1582679-2-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_205238_557380_00C41C83 
X-CRM114-Status: GOOD (  10.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Now we use "memeory::linux,usable-memory" to indicate the available
memory for the crash kernel.

While booting with UEFI, the crash kernel would use efi.memmap to
re-populate memblock and then first kernel's memory would be corrputed.
Consequently, the /proc/vmcore file failed to create in my local test.

And according to "chosen" dtschema [1], the available memory for the
crash kernel should be held via "chosen::linux,usable-memory-range"
property which will re-cap memblock even after UEFI's re-population.

[1]:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/chosen.yaml

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 kexec/arch/riscv/kexec-riscv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/riscv/kexec-riscv.c b/kexec/arch/riscv/kexec-riscv.c
index fe5dd2d..5aea035 100644
--- a/kexec/arch/riscv/kexec-riscv.c
+++ b/kexec/arch/riscv/kexec-riscv.c
@@ -79,20 +79,20 @@ int load_extra_segments(struct kexec_info *info, uint64_t kernel_base,
 		}
 
 		ret = dtb_add_range_property(&fdt->buf, &fdt->size, start, end,
-					     "memory", "linux,usable-memory");
+					     "chosen", "linux,usable-memory-range");
 		if (ret) {
-			fprintf(stderr, "Couldn't add usable-memory to fdt\n");
+			fprintf(stderr, "Couldn't add usable-memory-range to fdt\n");
 			return ret;
 		}
 
 		max_usable = end;
 	} else {
 		/*
-		 * Make sure we remove elfcorehdr and usable-memory
+		 * Make sure we remove elfcorehdr and usable-memory-range
 		 * when switching from crash kernel to a normal one.
 		 */
 		dtb_delete_property(fdt->buf, "chosen", "linux,elfcorehdr");
-		dtb_delete_property(fdt->buf, "memory", "linux,usable-memory");
+		dtb_delete_property(fdt->buf, "chosen", "linux,usable-memory-range");
 	}
 
 	/* Do we need to include an initrd image ? */
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
