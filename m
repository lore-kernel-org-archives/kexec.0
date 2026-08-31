Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C991DC624A4
	for <kexec@archiver.kernel.org>; Mon, 31 Aug 2026 12:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rvMGQZrptl4rbELAmb9clWsM5sJH3hKzq91dfV8VKLo=; b=MAZP3ayYdftc5fQoqqe+c59DEy
	NCaEJcq5DEYNv8RuFyXhg11G7jCjjR0Ipebv4a3Pw8hp+/qVxLSmh4oOV1QQp4JGJ/TXMABFqFv1N
	rydEWr3Hz/0rYUQNNNBqO5OIlnY8UyCs1xaTbSfaoxuzs2HG0Z0bXUaJvSRPwwX3SxNTQTV+wHVxT
	xctS7+n2vS1AESWTuCpd7b1OQXfGCgg3G84HyWj4P5O/yBwS1zbxvy1JbuFnjbg3cXjoC8Ypw0eeo
	WVf/JOWalccaf6/vTtoC4f0xqz/jsftUMOb/7KVWWtmWO4+qDqoyekQrsWgjs5dWitKM772Necehj
	XX9dugdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x11bQ-00000009Lpm-0XXT;
	Mon, 31 Aug 2026 12:59:08 +0000
Received: from mx2.mythic-beasts.com ([2a00:1098:0:82:1000:0:2:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x11bN-00000009Lp6-3qrv
	for kexec@lists.infradead.org;
	Mon, 31 Aug 2026 12:59:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
	bh=rvMGQZrptl4rbELAmb9clWsM5sJH3hKzq91dfV8VKLo=; b=jb/rHHv6FvD3QpfnYRkMdza6di
	yiN6unUDw2ly4RCvUHemFl9Crm4B7aWT9+49ighEkN69vOd9SB5vc6JeyOuURdEV3pJWXdJ3IXABI
	K2sFjLBXyLUzhSIf4dYqiFboorDdeii9LKULOmMWKFAGRsRFIZ730wCg6Ejm40O9UIaiGcy2PJ14U
	tmANac/YqHKtwGjezZgbceSthND+Br+v5R1UneEjxCk7lKioIODLNjCSExFg7aDL8aFzKv14g3Kvb
	8LaDLM5hbRtx8OM1L2NPDNVTygWUNkhiwMdNoy50V/vqiQn72XURzAX2DdpIu1lI+mCvKx3MKGxlW
	4LacJG4w==;
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <tom@tom-fitzhenry.me.uk>)
	id 1x11bL-002Htd-1j;
	Mon, 31 Aug 2026 13:59:04 +0100
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To: kexec@lists.infradead.org
Cc: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH] arm: use the zImage tag's real TEXT_OFFSET for kernel placement
Date: Mon, 31 Aug 2026 12:58:27 +0000
Message-ID: <20260831125828.1524463-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BlackCat-Spam-Score: 14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_055906_208048_1A336CCF 
X-CRM114-Status: GOOD (  15.00  )
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

The zImage loader assumes TEXT_OFFSET is 0x8000 and sizes the kernel
reservation as if the decompressed kernel lands at RAM base + 0x8000.
Multiplatform armv7 kernels, however, are built with a per-platform
TEXT_OFFSET: arch/arm/Makefile warns that "this offset is critical to
the functioning of kexec-tools", and e.g. ARCH_MESON uses 0x00208000.

With such a kernel the decompressor places the inflated kernel ~2 MB
higher than kexec-tools assumed, so the initrd placed at the estimated
end of the kernel image lands inside the decompressor's scratch area
or the new kernel's own reservation. The kexec'd kernel then fails
with "RAMDISK: Couldn't find valid RAM disk image" or "INITRD: ...
overlaps in-use memory region", as seen kexec'ing an armv7 NixOS
kernel on a Netgear RN102 (its multiplatform config selects
ARCH_MESON).

The zImage extension tag has recorded TEXT_OFFSET since v5.10 (commit
83dfeedb6663, "ARM: add TEXT_OFFSET to decompressor kexec image
structure"), but the loader only reads size_ptr and bss_size from it.
Read the real value and place the zImage there. Older kernels do not
carry it and keep the historical 0x8000 default, just as the arm64
loader falls back to 0x80000 for older kernels (commit 522df5f7217f,
"arm64: Add arm64 kexec support").

Note on tooling: this patch was developed with assistance from
DeepSeek LLM, which helped diagnose the failure and draft the fix.
Tested by kexec'ing arm zImages with non-default TEXT_OFFSET under
QEMU with both a synthetic config and the affected RN102's config,
asserting the kexec'd initrd runs.

Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Link: https://git.kernel.org/torvalds/c/83dfeedb6663
Link: https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=522df5f7217fda01ece3f6ac3e9987b0320c2bb0
---
 kexec/arch/arm/kexec-zImage-arm.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 8b474dd..892fca0 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -131,6 +131,7 @@ struct zimage_tag {
 		struct zimage_krnl_size {
 			uint32_t size_ptr;
 			uint32_t bss_size;
+			uint32_t text_offset;
 		} krnl_size;
 	} u;
 };
@@ -478,7 +479,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	unsigned long page_size = getpagesize();
 	unsigned long base, kernel_base;
 	unsigned int atag_offset = 0x1000; /* 4k offset from memory start */
-	unsigned int extra_size = 0x8000; /* TEXT_OFFSET */
+	unsigned int text_offset;
 	uint32_t address_cells, size_cells;
 	const struct zimage_tag *tag;
 	size_t kernel_buf_size;
@@ -661,6 +662,21 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	 */
 	tag = find_extension_tag(buf, len, ZIMAGE_TAG_KRNL_SIZE);
 
+	/*
+	 * The decompressor places the inflated kernel at
+	 * (zImage address & 0xf8000000) + TEXT_OFFSET, so load the
+	 * zImage at a 128 MiB-aligned base + TEXT_OFFSET.  The tag
+	 * table records the real value since v5.10 (commit
+	 * 83dfeedb6663, "ARM: add TEXT_OFFSET to decompressor kexec
+	 * image structure"); TEXT_OFFSET is the third payload word,
+	 * so a tag size of at least 5 means it is present.  Older
+	 * kernels keep the historical 0x8000 default.
+	 */
+	if (tag && le32_to_cpu(tag->hdr.size) >= 5)
+		text_offset = le32_to_cpu(tag->u.krnl_size.text_offset);
+	else
+		text_offset = 0x8000;
+
 	/*
 	 * The zImage length does not include its stack (4k) or its
 	 * malloc space (64k).  Include this.
@@ -748,14 +764,14 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		}
 		base = start;
 	} else {
-		base = locate_hole(info, len + extra_size, 0, 0,
+		base = locate_hole(info, len + text_offset, 0, 0,
 				   ULONG_MAX, INT_MAX);
 	}
 
 	if (base == ULONG_MAX)
 		return -1;
 
-	kernel_base = base + extra_size;
+	kernel_base = base + text_offset;
 
 	/*
 	 * Calculate the minimum address of the initrd, which must be

base-commit: 43c5cba85ad23cc69c423527d9587c59b89fa437
-- 
2.55.0


