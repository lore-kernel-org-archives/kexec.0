Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199AFC79FB6
	for <kexec@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IahBN7S9tUIFeWRuphP+Us/5cL/r7Hrj0lCqfy0ubeg=; b=kE7nH5FVtYP2cXScn5jHH3jEob
	F82KQqE6D/AGbcuRjMwW75PrvoIo1NPwoYCtn++oYNxC95JJUwf9ufJbxCM7/GipvarUXf+aGJXmm
	CzRVLTltIB1IHjikKlCTU3gVHMUtWsvyedRMXEppFDowTG0dRFz1jUUG4uOwXBVe7OI+T0MWqKymq
	rIrgMMISEjBGJLOjMmdkYAWELl+q8Mh5Tx7jTh9YkXzA2pdOaNa7cwWSXDl51O0FlB/PBuXA6mfwK
	c0vpKJME4z0PXmmxY44/TPUyqwEorQ0bQw0dZ6ocpKpPOyTEd7fw1mI4J1pVYx3T6Zc0Y0EDTtp8o
	kSkQByuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5L5M-00000000myz-0xZ3;
	Sat, 12 Sep 2026 10:35:52 +0000
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5L5F-00000000mxt-1HU4
	for kexec@lists.infradead.org;
	Sat, 12 Sep 2026 10:35:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=IahBN7S9tUIFeWRuphP+Us/5cL/r7Hrj0lCqfy0ubeg=; t=1789209345; x=1790418945; 
	b=jeff+Tk+TseS6+nYaug0qU8tKfM0HgxSNBvXZWqFc1jyfGlSkt1Bb4dV+ilAxp65/oN1FUUEPP2
	uFvFRf83r8Ekeg59Dk+zHdSpMHBYQ5I+qI8KJbOBwA7grnnhIno6o1XdiD8XuVXPma7x4QQChb3hm
	ZVeYBFN1PJyqTkJumYA3ygove9yOlZNggCBCQDEKN690oi14mL10zbRRd4oZoDF8d1vgxSXkrW4y3
	zOtXcTeiP8oLbs4mSAEfT9zJXYWveR0wbosLcyQQOL7uR8mruCZqT8cIRjZsoapkC1pPkMQvkv6SS
	c3jhssJCxl8Vm+sEklktKuHeBg7j8xlM+bSQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Sat, 12 Sep 2026 12:35:14 +0200
Subject: [PATCH kexec-tools v2] arm-zImage: prepare for more malloc
 requirements of zstd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-malloc-fix-v2-1-eb0c3ca681cd@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAOEqpWoC/yWNSw6DIBRFt9K8cTGAqNBR99E4QHxWqkID1tgY9
 160w/s9G0QMFiPcLhsEXGy03iXBrxcwvXZPJLZNGjjlJVWMk0mPozeksyvJmWZ5UQnTSAFp8A6
 Y7PPsAQOuaMjs/Rih/ofx07zQzMfdUe9tnH34nuiFnaOTIrmiSpS0ykqphCwII9q1AXW8Dzg53
 WJmXeeh3vf9B7zT1I7AAAAA
X-Change-ID: 20260912-malloc-fix-31a13574cb84
To: Simon Horman <horms@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
 "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Pratyush Yadav <pratyush@kernel.org>, j.neuschaefer@gmx.net
Cc: Andreas Kemnade <andreas@kemnade.info>, kexec@lists.infradead.org, 
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
X-Mailer: b4 0.16.1-dev-17221
X-Developer-Signature: v=1; a=openpgp-sha256; l=3045; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=+Z95fLrLDTT/ZzQeSm/QPfOmG6gs95Gid8H3majLT+U=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFlLtR6Jx+w8n5k2mbkq4NhWsQuNfWlcWmeni7M8Yq5ep
 3+Mi+l0RykLgxgXg6yYIssvawW3TyrPcoOnRtjDzGFlAhnCwMUpABNZs5bhf9pnVqVli++Uz17A
 Ixu59829pIcdP1c8q+78e39HtgDjAl6Gf8ZWf6wrEn3bGzyE9r23UUhjk12d+dv5rvdmpe/2ed7
 h/AA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260912_033545_358758_E3D17107 
X-CRM114-Status: GOOD (  13.10  )
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

As there are plans for zstd in zImage for ARM, which requires more malloc
size fo, decompression, look at the header for the required size.

References:
https://lore.kernel.org/lkml/ZFDMRst2O+RJUYuu@shell.armlinux.org.uk/#t
https://lore.kernel.org/lkml/20260828-zstd2-v2-0-4d9ce7150877@kemnade.info/

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
To: kexec@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <baoquan.he@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: j.neuschaefer@gmx.net
---
Changes in v2:
- extract malloc size from zImage header
- Link to v1: https://patch.msgid.link/20260829094607.689485-1-andreas@kemnade.info
---
 kexec/arch/arm/kexec-zImage-arm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 8b474dd..1e682db 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -131,6 +131,8 @@ struct zimage_tag {
 		struct zimage_krnl_size {
 			uint32_t size_ptr;
 			uint32_t bss_size;
+			uint32_t text_offset;
+			uint32_t malloc_size;
 		} krnl_size;
 	} u;
 };
@@ -663,18 +665,21 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 
 	/*
 	 * The zImage length does not include its stack (4k) or its
-	 * malloc space (64k).  Include this.
+	 * malloc space (128k).  Include this.
 	 */
-	len += 0x11000;
+	len += 0x1000;
 
-	dbgprintf("zImage requires 0x%08llx bytes\n", (unsigned long long)len);
 
 	if (tag) {
 		uint32_t *p = (void *)buf + le32_to_cpu(tag->u.krnl_size.size_ptr);
 		uint32_t edata_size = le32_to_cpu(get_unaligned(p));
 		uint32_t bss_size = le32_to_cpu(tag->u.krnl_size.bss_size);
+		uint32_t malloc_size = tag->hdr.size >= 6 ? tag->u.krnl_size.malloc_size : 65536;
 		uint32_t kernel_size = edata_size + bss_size;
 
+		len += malloc_size;
+		dbgprintf("malloc size: 0x%lx\n", (unsigned long)malloc_size);
+
 		dbgprintf("Decompressed kernel sizes:\n");
 		dbgprintf(" text+data 0x%08lx bss 0x%08lx total 0x%08lx\n",
 			  (unsigned long)edata_size,
@@ -699,8 +704,13 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 				(unsigned long)kernel_size);
 			kexec_arm_image_size = kernel_size;
 		}
+	} else {
+		/* add default malloc size */
+		len += 0x10000;
 	}
 
+	dbgprintf("zImage requires 0x%08llx bytes\n", (unsigned long long)len);
+
 	/*
 	 * If the user didn't specify the size of the image, and we don't
 	 * have the extension tables, assume the maximum kernel compression

---
base-commit: 43c5cba85ad23cc69c423527d9587c59b89fa437
change-id: 20260912-malloc-fix-31a13574cb84

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>


