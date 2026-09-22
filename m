Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22C9C982FA
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 10:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9LxrGinRLkj4HWz1b9dKyeGYk/UWrTJ93ug5Vj/SdGY=; b=zgGHATqvw9QmHAZKiEqAnc9tHu
	O+X9Fu6CS9TPgjkswHji6iC/5AUKBlXF1WIER6QxU9FeWHmPaff2cceg2D2gc3wcTXUaN6SSIYRPW
	rM4fuIWs7efOmDe0DQyBqN5Ofa3A7A7SpSSfxyzlQLbL8h6PNJfnE69kJ2Si1UD6s1Gn0dI/4eOHE
	VTbCsLLo1LzpRi1fNmQ7srhMFw+WRq/xlWTGPK9lXuPa+zhElr/+os+NfB/LdvVI6H+RALDTCuAeJ
	TWmIuRgpWEmB3Vksn+T8fi3whhQjpks4sAcbzEo2HMND7GC1Y59HTuwSxCMZ68OZ7xfxpXQCibvHD
	Uw2xFeWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8xiC-000000052hn-2gtO;
	Tue, 22 Sep 2026 10:26:56 +0000
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8xiA-000000052gJ-1V1m
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 10:26:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=9LxrGinRLkj4HWz1b9dKyeGYk/UWrTJ93ug5Vj/SdGY=; t=1790072814; x=1791282414; 
	b=rzU01d7lgZD7M3jH08n9cO3hkj/6dFrOZr2CTYsbDk6zzBmC5XPDZ1owu0yMXMcDNW76RTmFjd3
	DEXqMkqLonXE06oj2D4phWCMNp6JYQxBpQOmQm5glzEPflIJcxxaOSXSt7Fz4ehCgX6bpVSSz9ndx
	RTrzmNR9vgEzvnJjEBuyzqCHaj/ixz+yzLVdDwYVmEGNpKGUoIZ8oEL4Ivs0V/+E6pSAFM/dx5GZl
	gWg0JhJil5yEL4i4TLgM5rXm4I0r0E3ZiM5FoVBCtH68fTcyqIXouH8ZaBiWYDmM+47r2MgLtXZmb
	Vhe/C6U/gdhXZ9df239PrDFvCjLArY4xjtOw==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 12:25:59 +0200
Subject: [PATCH kexec-tools v3] arm-zImage: prepare for more malloc
 requirements of zstd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-malloc-fix-v3-1-1d61286bde65@kemnade.info>
X-B4-Tracking: v=1; b=H4sIALZXsmoC/12Oyw6CMBBFf8V0bUkfPIor/8O4KGWQCrSmxQZD+
 HdLXZiwvDNzzp0VeXAaPLqcVuQgaK+tiYGfT0j10jwA6zZmxAgrSU0ZnuQ4WoU7vWBOJeVFlat
 G5CgCLwdxnGQ3NMACCs/Wjh7df0v/bp6g5l23n/faz9Z9UnWgCUotgtWkzktSZaWoc1FgiqVpH
 Uh/HWAysoVMm84ma2B/7vBdYBGEhiiuZCmoag/0tm1fCqLiZ/4AAAA=
X-Change-ID: 20260912-malloc-fix-31a13574cb84
To: Russell King <linux@armlinux.org.uk>, kexec@lists.infradead.org, 
 j.neuschaefer@gmx.net, Mike Rapoport <rppt@kernel.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Simon Horman <horms@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.16.1-dev-53874
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=NGcqsH3iRGYA3Zl4ShcY1KAGqf1tnv7UyUf1CiFee+c=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbwh/zH7ZbF5/bk+059fof7zi56Xce1DvdsuH5xGr6f
 XnuTtWcjlIWBjEuBlkxRZZf1gpun1Se5QZPjbCHmcPKBDKEgYtTACaSv5PhfybHPG+Wax6XM1/4
 G3z/f87Oca/EwQ335sRwJfq1OjmcesfwPyKm7lRq8c4X90z3r/M4oVIixHfh747aHRx8+5ZfPD6
 fnxUA
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_032654_409254_78569461 
X-CRM114-Status: GOOD (  12.42  )
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
Changes in v3:
- calculate zImage size requirement before the if (tag) to simplify code
- Link to v2: https://patch.msgid.link/20260912-malloc-fix-v2-1-eb0c3ca681cd@kemnade.info

Changes in v2:
- extract malloc size from zImage header
- Link to v1: https://patch.msgid.link/20260829094607.689485-1-andreas@kemnade.info
---
 kexec/arch/arm/kexec-zImage-arm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 8b474dd..6c3bf27 100644
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
@@ -663,9 +665,15 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 
 	/*
 	 * The zImage length does not include its stack (4k) or its
-	 * malloc space (64k).  Include this.
+	 * malloc space.
 	 */
-	len += 0x11000;
+	len += 0x1000;
+
+	/* include malloc space */
+	if (tag && le32_to_cpu(tag->hdr.size) >= 6)
+		len += le32_to_cpu(tag->u.krnl_size.malloc_size);
+	else
+		len += 0x10000;
 
 	dbgprintf("zImage requires 0x%08llx bytes\n", (unsigned long long)len);
 

---
base-commit: 43c5cba85ad23cc69c423527d9587c59b89fa437
change-id: 20260912-malloc-fix-31a13574cb84

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>


