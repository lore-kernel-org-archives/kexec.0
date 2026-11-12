Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F460A260D
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eKcWJuw1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2ksWvqT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=jCZcwaVbEXSO6fmP+AQbtigP75VIYTb9aAjDi7oBhe8=; b=eKcWJuw18X+70d6xq68cgrrQaf
	/y5sAPTbuPvAsTPjfiRRG3SWlhIx+auDTfwsdqOoBN36l5D/ZUfI8xHnxfQZWywwcrcfcBT7sxEey
	lbYH4aRww47t6gYROoie+3soahBDBi7a+7Tps+kKvh70JuzVkn64Nsl2HLWtT4jyY/xJpCmAut0Ar
	YlEOBH2FRr8Z/Q+oYt3VahEpQBhOVsWUQGI65zE9pZcF1oRW/pdKI2o6WL4QvwzTjgtheX5+BzIZ4
	mmbO/S6NVFmbbTKSr16B1fwLJhFj6ciqQ/Mfn7t86FJCvphSxRRPUDvIzT4E4kewugDhLbXiCZsNH
	HzYKLGiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXoJ-0000000AcaJ-0nqR;
	Thu, 12 Nov 2026 16:38:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXoB-0000000AcVt-3aZK;
	Thu, 12 Nov 2026 16:37:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 055C861D33;
	Thu, 12 Nov 2026 16:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527B61F000C5;
	Thu, 12 Nov 2026 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501474;
	bh=jCZcwaVbEXSO6fmP+AQbtigP75VIYTb9aAjDi7oBhe8=;
	h=From:Subject:Date:To:Cc;
	b=j2ksWvqTjSpZRpEsyTzmS8gn1fYVO4+77jjtVD2TTFlIgfkVQlOk4zXryc2kB9+JC
	 T3OtQ+rN/tMSqHZomvQ/G5Cx/WXIMv3mMEYGQ4qvgX8LiABhA8sQK0N6QYHi7Fsp4e
	 Hk2pUwIxYgFmsDpRsRCOCGb79e9HTkdNFz9F9ThBcu/ofn6qdF/vOYMyi0NhEk2ePx
	 zyjSDNgbA4HYZWd2NgF4NUeouIylYH4zt8BRnBbYz8tK66jZQcBHuvxyulHFFfvNoQ
	 HvYmM4CcWOgiMGC6XGwj7KPtbncI/6XyGlUbOREprjSfMgxNUVuKQRC+//pxEYh94L
	 81/mSZ987PGpA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/4] crash_dump: recover from machine checks in
 copy_oldmem_page()
Date: Thu, 12 Nov 2026 17:37:06 +0100
Message-Id: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSw7CMAxEr1J5jasmC35bJA7AFrGIU5cGaFLZ/
 KSqdyehy3kz8yZQlsAK+2oC4XfQkGIOZlWB7128MoY2Z7CNXRtjLH6S3HGU5DvF9GgHHnDH28Z
 bJkcbgnwchbvw/UvPcDoe4LJAfdGN/bPoyoycMpK46PuCirhexHWpYJ5/L4zYOZ4AAAA=
X-Change-ID: 20261112-work-procfs-oldmem-9e80c2ebab7b
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Breno Leitao <leitao@debian.org>, Chris Mason <mason@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sqtljLIH8KoO+/k7KE1Gt/hrphFZnwIFPTrrlrdZ//8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9fR2u/02Pnzf6SneSIY/3/COb93oukuRYOudztZZ0u
 oHTlZwPHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5G8jwP0xmhXO+VVRl/K9S
 y+eKH67dmLyl77jre1aL/4d5T4k1eDIyXFQTW+N5kUUj5zrH27dnf60ybtdbuU7Bn/07Y+aJqU7
 lTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A capture kernel reads the memory of the crashed kernel. That memory
may have uncorrectable errors in it. Which is likely also what murdered
the first kernel.

On x86 a machine check in the copy that /proc/vmcore does out of an old
page panics the capture kernel. On book3s64 the read() comes up short
and splice() panics. Breno has observed that on a fleet iiuc. The first
kernel dies of a machine check and then there's no vmcore either.

I had the powerpc half of this as a fix in part 1 of the procfs series
because Chris ran into it there. Breno pointed out that x86 has the same
hole.

I think that likely makes this a kdump problem and not a procfs problem.
So I moved this out together with the ioremap_cache() fix.

The first two patches make powerpc's and sh's copy_oldmem_page() check
whether mapping the old page worked.

Every architecture that maps a page of the old kernel copies it out with
copy_to_iter(). The third patch puts that copy into a new
copy_oldmem_to_iter() helper. It's just copy_to_iter() with
_copy_mc_to_iter() underneath.

On x86_64 (and book3s64 - whatever that is) that's the machine check
safe copy and the machine check turns into a short read and -EFAULT.
Everywhere else it's copy_to_iter() under another name.

I then convert the remaining architectures so the copy lives in one
place and any new architecture with ARCH_HAS_COPY_MC later gets this for
free.

I reproduced the x86 panic in a kdump VM by injecting a machine check
into the copy. Without it the capture kernel is gone, with it the read()
fails with EFAULT and the kernel logs the event and keeps going.

The helper is a static inline in crash_dump.h and that pulls uio.h into
it. If people would rather have it out of line it can go into
kernel/crash_core.c, which builds for CRASH_DUMP just like the arch
crash_dump.c files do.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (4):
      powerpc/crash_dump: check ioremap_cache() in copy_oldmem_page()
      sh/crash_dump: check ioremap() in copy_oldmem_page()
      crash_dump: recover from a machine check in copy_oldmem_page()
      crash_dump: use copy_oldmem_to_iter() everywhere

 arch/arm/kernel/crash_dump.c       |  2 +-
 arch/arm64/kernel/crash_dump.c     |  2 +-
 arch/loongarch/kernel/crash_dump.c |  2 +-
 arch/mips/kernel/crash_dump.c      |  2 +-
 arch/powerpc/kernel/crash_dump.c   |  6 ++++--
 arch/riscv/kernel/crash_dump.c     |  2 +-
 arch/sh/kernel/crash_dump.c        |  5 ++++-
 arch/x86/kernel/crash_dump_32.c    |  2 +-
 arch/x86/kernel/crash_dump_64.c    |  2 +-
 include/linux/crash_dump.h         | 22 ++++++++++++++++++++++
 10 files changed, 37 insertions(+), 10 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261112-work-procfs-oldmem-9e80c2ebab7b


