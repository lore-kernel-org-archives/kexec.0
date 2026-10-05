Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CC9CA5FCE
	for <kexec@archiver.kernel.org>; Mon,  5 Oct 2026 08:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRaXk+S12K7x3NMabS8DPPJO0Wv8bNYTMQ4A8Z1FcI4=; b=h3+asXghZQWhz3yVyPnrssEGSV
	bbuDHD4VMutWPNpkf5QIp+NgUzHjFWZirCl84TX6yFKI6m/awG2vbLvZEv+m1wVm+Tvcupg9dQKRM
	J82EhaGeKmXFZkFKCxajmM0kwevsGZNSzAzYCx3l9Mx8i2m2i6ZdVUGI5kBRZEZnu2VFD0ci/1MOG
	/u/tWozZI98U4YXH6r7lOxX8yGiDdKL82cnIvILv7czpftf63YC0ou+3mUcJrkaR9lKVp50xBE0FV
	ErMohW1qC0VQ7Uishilgb1zSrrU+JtaQlKWTJis7ZKCaRqIN8jIat6gf5uTD4oGxCFkGVS6ab3D0J
	7jC7FkFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDeY6-0000000FvHW-1p7k;
	Mon, 05 Oct 2026 08:59:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDeY4-0000000FvHO-43su
	for kexec@lists.infradead.org;
	Mon, 05 Oct 2026 08:59:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6D9C243A13;
	Mon,  5 Oct 2026 08:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FEE1F000FF;
	Mon,  5 Oct 2026 08:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791190792;
	bh=BRaXk+S12K7x3NMabS8DPPJO0Wv8bNYTMQ4A8Z1FcI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NtqZE+b4onBp4uktzmeki8LVBH+lWPkT1aWdXuni0IcbwKxMNRO5a3g7buvWFLwC9
	 5J832sIqE4o/WTG9f8Qpm6wKCGpYAOhCnMWXdiMdAfhsFpD77YKhyhnNYNAAcmxRNn
	 xB/T8Zspn1s/Mt6cYsdRW4TT2fw+sz2RvEUqlP2/3POS8/PgiWAA3B6PCV2u1Wkvgb
	 QP0sdi2STT/Y3fusz/4ZURbAtckh3JpeILD0yCfrz2ZT4EpsaC/3S5O+FuLgwOP7e+
	 epjLvJbV8zUzDozZGg/yx9y+TxVjdFwNIkyfQOq1axGY3Baf/fUaUc5Q014nGOivZl
	 JB5k0wdJgU58w==
Date: Mon, 5 Oct 2026 09:59:48 +0100
From: Simon Horman <horms@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Russell King <linux@armlinux.org.uk>, kexec@lists.infradead.org,
	j.neuschaefer@gmx.net, Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH kexec-tools v3] arm-zImage: prepare for more malloc
 requirements of zstd
Message-ID: <20261005085948.GC184916@horms.kernel.org>
References: <20260922-malloc-fix-v3-1-1d61286bde65@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-malloc-fix-v3-1-1d61286bde65@kemnade.info>
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

On Tue, Sep 22, 2026 at 12:25:59PM +0200, Andreas Kemnade wrote:
> As there are plans for zstd in zImage for ARM, which requires more malloc
> size fo, decompression, look at the header for the required size.
> 
> References:
> https://lore.kernel.org/lkml/ZFDMRst2O+RJUYuu@shell.armlinux.org.uk/#t
> https://lore.kernel.org/lkml/20260828-zstd2-v2-0-4d9ce7150877@kemnade.info/
> 
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> To: kexec@lists.infradead.org
> To: Andrew Morton <akpm@linux-foundation.org>
> To: Baoquan He <baoquan.he@linux.dev>
> To: Mike Rapoport <rppt@kernel.org>
> To: Pasha Tatashin <pasha.tatashin@soleen.com>
> To: Pratyush Yadav <pratyush@kernel.org>
> To: Simon Horman <horms@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: j.neuschaefer@gmx.net
> ---
> Changes in v3:
> - calculate zImage size requirement before the if (tag) to simplify code
> - Link to v2: https://patch.msgid.link/20260912-malloc-fix-v2-1-eb0c3ca681cd@kemnade.info
> 
> Changes in v2:
> - extract malloc size from zImage header
> - Link to v1: https://patch.msgid.link/20260829094607.689485-1-andreas@kemnade.info

Thanks, and sorry for the delay.

I have applied this as:

[1] arm-zImage: prepare for more malloc requirements of zstd
    https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=e128675241fa


This required a manual merge due to conflicts with the following,
which I had applied just beforehand.

[2] arm: use the zImage tag's real TEXT_OFFSET for kernel placement
    https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=c1a526c87eb1

In particular:

a. The text_offset member no longer needs to be added to struct zimage_tag
   by [1] as it was added by [2].

b. There is some fuzz in the 2nd hunk of [2] as [1] adds some
   logic earlier on in zImage_arm_load().

FTR, the patch I applied is as follows.
If I've messed something up, please let me know.


From e128675241fa7777dcce613a2df191458c320f5b Mon Sep 17 00:00:00 2001
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 12:25:59 +0200
Subject: [PATCH] arm-zImage: prepare for more malloc requirements of zstd

As there are plans for zstd in zImage for ARM, which requires more malloc
size fo, decompression, look at the header for the required size.

References:
https://lore.kernel.org/lkml/ZFDMRst2O+RJUYuu@shell.armlinux.org.uk/#t
https://lore.kernel.org/lkml/20260828-zstd2-v2-0-4d9ce7150877@kemnade.info/

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Tested-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 kexec/arch/arm/kexec-zImage-arm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 892fca0cf09c..b1ee6ca2158b 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -132,6 +132,7 @@ struct zimage_tag {
 			uint32_t size_ptr;
 			uint32_t bss_size;
 			uint32_t text_offset;
+			uint32_t malloc_size;
 		} krnl_size;
 	} u;
 };
@@ -679,9 +680,15 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 
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
 
-- 
2.47.3



