Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53AEE83EF9
	for <kexec@archiver.kernel.org>; Wed,  4 Feb 2026 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ISqGUnQFSfIzubIcjbsXKszPgBVvuBlocAkcpVEeiY=; b=KK2MywAQ7sSg5p5AHihI4dvib2
	AfhcCmkhV3keHIRi+SKW0S1O4WPdItvl3/LrJo7t8XEWpq9Py67m7jOpZpSLhUCif/BST27PbG3eR
	zvvk1X910iHoMoiJweaTiE9CeJAIHsCO1gYusKT82b0F/2Efsk/UpiJ1Yiqs6SHbscCKYQ52YKlcS
	/hHzK1DcGjjfvzQSBETg1nIE61NLBju2aSO7zaLx37IuYzqXOzjIshi2NXf63UHrtD03SBE+n2zEX
	/IbZ4l3y4lK2NMDdIxGzjOq4X0IhdMv6X3ko0BUnhsxw2wkJ/aAdDwCRkO5ywYNYSH+i8ZGp641gs
	DyBehLxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vndL8-00000008YMR-1c3G;
	Wed, 04 Feb 2026 13:54:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vndL6-00000008YMJ-3iCf
	for kexec@lists.infradead.org;
	Wed, 04 Feb 2026 13:54:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D36166012A;
	Wed,  4 Feb 2026 13:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AD6C4CEF7;
	Wed,  4 Feb 2026 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770213279;
	bh=Nx3mqv3VEYct46j5DWoW2n7667uX/NJxIPI+yS3dkOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gNU9RLmFxfnm6eHDaKsUmyEzRm88xgRGG3z8Trre1GxyWc7Fx/DsdvJRZnc+GaKLh
	 kIV422HC993Ly9Zi4BYu9qPfXZ/5mc4XUhxPIglAtKhmp5Ehy+iG6ThT/lvo8AlkpB
	 NP2xWCzTK2KQ8Gy7NqpD5A36R0edc/XwGtHEpDF9B9Z/5zHbZSnd1O606ndNcSfkwr
	 K1wSITGJbN4y/tR1LB3US+oeYoz5vBwwMc1HAVEFTt2uVHjZoUl5CR2Ydc/pcMft6C
	 jTvemJt8nPqu6eiOa6Y0vvQA5a2zaWnyKzA76KK41VbdGzzUxCxwfrTUu1+Bux9/h3
	 vC2/P+qzC4H7w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  rmikey@meta.com,  clm@fb.com,  riel@surriel.com,  SeongJae Park
 <sj@kernel.org>,  kernel-team@meta.com
Subject: Re: [PATCH v6 1/4] kho: add size parameter to kho_add_subtree()
In-Reply-To: <20260127-kho-v6-1-56f9396681c2@debian.org> (Breno Leitao's
	message of "Tue, 27 Jan 2026 06:37:36 -0800")
References: <20260127-kho-v6-0-56f9396681c2@debian.org>
	<20260127-kho-v6-1-56f9396681c2@debian.org>
Date: Wed, 04 Feb 2026 14:54:35 +0100
Message-ID: <2vxzjywszk9w.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Breno,

On Tue, Jan 27 2026, Breno Leitao wrote:

> kho_add_subtree() assumes the fdt argument is always an FDT and calls
> fdt_totalsize() on it in the debugfs code path. This assumption will
> break if a caller passes arbitrary data instead of an FDT.
>
> When CONFIG_KEXEC_HANDOVER_DEBUGFS is enabled, kho_debugfs_fdt_add()
> calls __kho_debugfs_fdt_add(), which executes:
>
>     f->wrapper.size = fdt_totalsize(fdt);
>
> Fix this by adding an explicit size parameter to kho_add_subtree() so
> callers specify the blob size. This allows subtrees to contain
> arbitrary data formats, not just FDTs. Update all callers:
>
>   - memblock.c: use fdt_totalsize(fdt)
>   - luo_core.c: use fdt_totalsize(fdt_out)
>   - test_kho.c: use fdt_totalsize()
>   - kexec_handover.c (root fdt): use fdt_totalsize(kho_out.fdt)
>
> Also update kho_in_debugfs_init() to compute sizes using fdt_totalsize()
> for the root and sub-FDTs it processes, since these are known to be
> actual FDT blobs.

No, this doesn't seem right. The "fdt" field that kho_in_debugfs_init()
uses is the same "fdt" field where we put our non-FDT blobs. So I don't
see how these can be known to be actual FDTs. All this happened to work
because so far all users were FDT, but I bet it will break if you use
your blob here. Perhaps give it a try and see if I am understanding this
correctly?

To be honest, I didn't think of this when I suggested you use the size
parameter. We have lost the size information, and it is hard for
kho_in_debugfs_init() to find out since it has no idea what the
underlying format is.

One option is to have it in the KHO FDT, but I am not sure that is a
good idea. Adding to ABI for debug feature sounds odd (not that I am
completely against it, it just feels off).

Another would be to give users a hook to populate the blobs when they
call kho_retrieve_subtree(), so they can figure out how large the blob
needs to be. This has another benefit: once we move away from FDT, it
makes little sense to dump the blob since userspace won't have a way to
parse it. Even with FDT, userspace still can't parse everything. For
example, say the FDT has a reference to a struct kho_vmalloc. You'd get
a pointer to the head of the list, but you would have no way of knowing
what is inside the vmalloc buffer. This has the downside of not being
able to show anything if the subsystem never calls
kho_retrieve_subtree().

Unfortunately I don't have much time this week to dive deeper into this.
These are only things off the top of my head and I haven't thought too
deeply, so please don't take them as strong suggestions. It would be
great if you can think a bit more about the problem and come up with a
recommendation?

I will try to get back to this series in the next 1-2 weeks and
hopefully find some way to make progress.

I skimmed the rest of the patches and they all LGTM at a high level.

[...]

-- 
Regards,
Pratyush Yadav

