Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581E606A890
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MnaoWzGx;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXVr4/I2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AgVuF8ZXFRiJrZlfw+yYm3jlF5vIF5HJW2x7P71O+Ac=; b=MnaoWzGxIHHLjG
	4RXD1/SHfX+SPSBzNtohyim1u6VAQos7rxG3nCkMsRKSg6QoRQpM62e9E/31yl7sh9tlSEAD+VFE7
	9Yrw0SdDxP7RHuZ6bJPgFWU4J59JFk5PJ/4FdJeHmd+06PNew4/LhG7ibslkkKW0pHAAARSiON3Ju
	sYL6JOQl9uNtMHMEkaA2muxiNpb3a8fy+YBJiZtezikMOfkmRM1b+8f3OKs41MmZyD8t5oOHgz4Ua
	OIfvENa4BsiEOzYbBUttEecj0VIlRLaqEFflhb7fIH57E9b5Kl+aEwMhsQtzSVwzdeMOUOcz8WPju
	u9GHCNQ42gNKf6e9fv/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXoU-0000000AchJ-2CHn;
	Thu, 12 Nov 2026 16:38:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXoF-0000000AcX8-38Fb;
	Thu, 12 Nov 2026 16:38:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1DC6762313;
	Thu, 12 Nov 2026 16:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBEF1F000CC;
	Thu, 12 Nov 2026 16:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501478;
	bh=AgVuF8ZXFRiJrZlfw+yYm3jlF5vIF5HJW2x7P71O+Ac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GXVr4/I21EXRfq59LPVJh+GmLyWYGYkNNqjQsKf3zPXFlW0NWJtf5rPpcYS7KOSdX
	 cuvsiMR6wRMGlfXHs45dfh/aiyCJKPpwkJ7InATFRZtni627BvP/NEfYa5Ri9Wl7Zm
	 MbwX+2ixCbawrFxG2m/qE3K5amQhVt9WGB8GswGm5IwnOCODWz265MPKp37n2GQi2l
	 M1bo6PXczS1it8gll8U/oh+d1dTFskrjXYWMy/I7fMgUryBIBX8Q1mPirE6GGU5+RQ
	 WyRFjq2bSV9lTVbdhV9MZsFaflA7hPleW9EzEyCV0hrkShXp4EzDcRquIE/QuL/MiG
	 4H11/+PoqQmwA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Nov 2026 17:37:07 +0100
Subject: [PATCH RFC 1/4] powerpc/crash_dump: check ioremap_cache() in
 copy_oldmem_page()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ok0CVH0NZbW9pFZQURYCmgK7NHT0tqdpELAezILCuX8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9fR1hPytaT0Fg3571WX5Pc49l9Ljm5hpfSjOaFKiXc
 /+Nd/DXjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksrWFk2DblYlb2+wtcAm9f
 9Urw2pVlH9jjtld/qn2aTOpzlZI/+owM3+QcSm04dq2PmNo4h83lzbOWLSZyi39PsZWtrdseFlz
 CAAA=
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

copy_oldmem_page() maps a page of the old kernel that isn't in the
linear mapping with ioremap_cache() and copies from it without checking
whether the mapping worked. If it didn't, the copy reads from an offset
into the NULL page. That oopses unless the copy happens to be a user
copy, whose exception table entries turn the fault into a short copy.

Return -ENOMEM like the other architectures do. read_from_oldmem()
turns that into -EFAULT like any other short copy.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page")
Cc: stable@vger.kernel.org
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/kernel/crash_dump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 103b6605dd68f..1543917bd3e1d 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -86,6 +86,8 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 		csize = copy_to_iter(vaddr + offset, csize, iter);
 	} else {
 		vaddr = ioremap_cache(paddr, PAGE_SIZE);
+		if (!vaddr)
+			return -ENOMEM;
 		csize = copy_to_iter(vaddr + offset, csize, iter);
 		iounmap(vaddr);
 	}

-- 
2.53.0


