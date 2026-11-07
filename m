Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335E606A333
	for <kexec@archiver.kernel.org>; Sat,  7 Nov 2026 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IZ1HU9de;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQ3H3g6M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ShVD0/lFnfCk9+NOZh/vGjWFTDGdc/JlM5VbuhQviNc=; b=IZ1HU9deiueiJ8
	CzoqYifTvPztpBtIRRgkyfKSESmOL36BOt9dC0nhHwOQo+uejWUDVaVzH2qDLuneRam5/Q87ipLKk
	uzmZGUf86eHTqXnxRxmPdaKhZGkwOKsCh0GT1fI8K5NLE8ydrutJ9QvsNmqp8j2oXIZwtXBtHCZ8X
	qTrQPeEPikrIWYlaFPg/fieyzzULRYaTwtNzqoYh/OqNmu5Lsm4kxjMb1wU/XZy8lIqAFl2ZiKSEo
	Rn/R8CTUH4Ri0gNIbcRzCNnEeKsxIExU2FYZkJ6okbjGoyh5FXnXb+ze/3s5zpTAtF7W+ARetbUdB
	7oBx8RvBBsnECMXYSBRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPe7j-0000000EaAl-17XQ;
	Sat, 07 Nov 2026 10:58:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPe7h-0000000EaAb-3dQJ
	for kexec@lists.infradead.org;
	Sat, 07 Nov 2026 10:58:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 18B6860F4D;
	Sat,  7 Nov 2026 10:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4831F0089F;
	Sat,  7 Nov 2026 10:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049092;
	bh=ShVD0/lFnfCk9+NOZh/vGjWFTDGdc/JlM5VbuhQviNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EQ3H3g6MXx4JGlDF6JwT31Va+JkSFnKMBVWKYAd5bJSjzveCS+TEwtfvgYXLFNpUt
	 Xre38xeRz3BfrZ2v3DJtfGLBzu0t9kZzfzKedtLshaYxyXFbJMioYAtJ433HDOdiYJ
	 NqFGK6QGXqKxzBSecaWejwzkphBsLWBB7CLxaFw5VFPiQeuLz3FSHouMZl0IOZLhNL
	 xX1+o3OL1mVqwYl7zx+6I5exqVjgITeQ2crXF5hlKNQM8YfYlsJVm9x1B6GCPN8VsH
	 N1b6xgrAACbxLqvhAA0sTqWKFLSxixgaXFAlqK3NPYQtJ1Igp1e+QnBri8fESMuYCE
	 e7cUotrSiRDJQ==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mukesh Pilaniya <mpilaniy@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: fix restore order for NUMA-split preservations
Date: Sat,  7 Nov 2026 12:58:00 +0200
Message-ID: <179404894583.1473879.11936948088388939869.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105-kho-numa-v1-1-e807879644cc@redhat.com>
References: <20261105-kho-numa-v1-1-e807879644cc@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Thu, 05 Nov 2026 18:51:33 +0530, Mukesh Pilaniya wrote:
> kho_preserve_pages() uses __kho_preserve_pages_order() to reduce the
> order of a preservation so that it does not span multiple NUMA nodes.
> kho_restore_pages() does not use that helper; it recomputes the order
> from the pfn alignment and the remaining length only.
> 
> When a preservation was split at a NUMA boundary, restore picks a larger
> order than preserve did and jumps over the next key. Those pages never
> get restored: they stay memblock-reserved and keep the KHOP magic in
> page->private, while kho_restore_pages() returns success for the pages
> that were restored. The consumer has no way to notice that part of its
> buffer was not restored.
> 
> [...]

Applied to next branch of liveupdate/linux.git tree, thanks!

[1/1] kho: fix restore order for NUMA-split preservations
      commit: 825c63a0056cbc94cc57779e83440ffb9c5103f8

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: next

--
Sincerely yours,
Mike.


