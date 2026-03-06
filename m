Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A83AF01828
	for <kexec@archiver.kernel.org>; Fri,  6 Mar 2026 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Q1sENRTqUjIhGZLXP/WQo59Q+Ah+AXrTPRNuwNNsmU=; b=4jCMaxkRYYIinC85AoKeqMjPD8
	U6jQiubtKYDhFIHU4lw52HgbRNuQ2nU7sxPnfo0PKy49OegpeczNkQcG9E5YripMLNeKdQkto7udc
	7Ks0LjPg6SQg17TeLWgVqioxAsxSRTHSY8R5NwnzLQB4k76VGqMiWaT+eLN5OwmRLL00BHJcJ9xBX
	gd74ikOspXN+M7pWOFf+gmf439jGxNqWReVyaepiMPNJFBE+X/cA5LnsyicyQEHHtBSmAu2ZzI5ZC
	a4OmGKI4f9YfUgbhdoIUWJXjrEsXftD9nv8ZZtsSGS48HiVOPwj/OJyiqiom3NGSUk1WKHqlhCfvS
	pqxB63dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyTf1-00000003aCf-32jT;
	Fri, 06 Mar 2026 11:48:03 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyTey-00000003aC9-41bS
	for kexec@lists.infradead.org;
	Fri, 06 Mar 2026 11:48:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=9Q1sENRTqUjIhGZLXP/WQo59Q+Ah+AXrTPRNuwNNsmU=; b=EoYBbDmKpVh+CjgoUIt8Rpho2l
	4sGdjLo/aGg1MHTH6/SmjJhxkRewYGq3Dl3/cXpGpkNZD1YxLOCaYEIxHahM1P9urnzKFJf+exqkr
	bhBl2USUdXusi2Bd9XCwwskxouubnUxoNBPAJcsaNY9AEIXt4f5oYF83K0aSrabU5Yf1/7pP4wmCI
	I9L8YyrdxfCpJny4znGpkhhJtkMdAiuSN9gCQ+djogo/jEEp64NXyL7fpVj4Qs1BzE8PyELP1tvBy
	FDh3F6te+9zVOVPep/sP5jlrDusNYXT1U1PXh1nAuxVsktDssOLT0ZZw8kwhu7Uh+RWAZ+uWuQ0qX
	wO2OkXDA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vyTen-00HTjc-2w; Fri, 06 Mar 2026 11:47:49 +0000
Date: Fri, 6 Mar 2026 03:47:43 -0800
From: Breno Leitao <leitao@debian.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
	riel@surriel.com, SeongJae Park <sj@kernel.org>, kernel-team@meta.com
Subject: Re: [PATCH v6 1/4] kho: add size parameter to kho_add_subtree()
Message-ID: <aaq9J_rJXNiWzlXY@gmail.com>
References: <20260127-kho-v6-0-56f9396681c2@debian.org>
 <20260127-kho-v6-1-56f9396681c2@debian.org>
 <2vxzjywszk9w.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2vxzjywszk9w.fsf@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260306_034801_007295_6CCE64F4 
X-CRM114-Status: GOOD (  38.98  )
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

Hello Pratyush,

Apologies for the delayed response — I was on vacation and just got back.

On Wed, Feb 04, 2026 at 02:54:35PM +0100, Pratyush Yadav wrote:
> Hi Breno,
>
> On Tue, Jan 27 2026, Breno Leitao wrote:
>
> > kho_add_subtree() assumes the fdt argument is always an FDT and calls
> > fdt_totalsize() on it in the debugfs code path. This assumption will
> > break if a caller passes arbitrary data instead of an FDT.
> >
> > When CONFIG_KEXEC_HANDOVER_DEBUGFS is enabled, kho_debugfs_fdt_add()
> > calls __kho_debugfs_fdt_add(), which executes:
> >
> >     f->wrapper.size = fdt_totalsize(fdt);
> >
> > Fix this by adding an explicit size parameter to kho_add_subtree() so
> > callers specify the blob size. This allows subtrees to contain
> > arbitrary data formats, not just FDTs. Update all callers:
> >
> >   - memblock.c: use fdt_totalsize(fdt)
> >   - luo_core.c: use fdt_totalsize(fdt_out)
> >   - test_kho.c: use fdt_totalsize()
> >   - kexec_handover.c (root fdt): use fdt_totalsize(kho_out.fdt)
> >
> > Also update kho_in_debugfs_init() to compute sizes using fdt_totalsize()
> > for the root and sub-FDTs it processes, since these are known to be
> > actual FDT blobs.
>
> No, this doesn't seem right. The "fdt" field that kho_in_debugfs_init()
> uses is the same "fdt" field where we put our non-FDT blobs. So I don't
> see how these can be known to be actual FDTs. All this happened to work
> because so far all users were FDT, but I bet it will break if you use
> your blob here. Perhaps give it a try and see if I am understanding this
> correctly?
>
> To be honest, I didn't think of this when I suggested you use the size
> parameter. We have lost the size information, and it is hard for
> kho_in_debugfs_init() to find out since it has no idea what the
> underlying format is.
>
> One option is to have it in the KHO FDT, but I am not sure that is a
> good idea. Adding to ABI for debug feature sounds odd (not that I am
> completely against it, it just feels off).
>
> Another would be to give users a hook to populate the blobs when they
> call kho_retrieve_subtree(), so they can figure out how large the blob
> needs to be. This has another benefit: once we move away from FDT, it
> makes little sense to dump the blob since userspace won't have a way to
> parse it. Even with FDT, userspace still can't parse everything. For
> example, say the FDT has a reference to a struct kho_vmalloc. You'd get
> a pointer to the head of the list, but you would have no way of knowing
> what is inside the vmalloc buffer. This has the downside of not being
> able to show anything if the subsystem never calls
> kho_retrieve_subtree().
>
> Unfortunately I don't have much time this week to dive deeper into this.
> These are only things off the top of my head and I haven't thought too
> deeply, so please don't take them as strong suggestions. It would be
> great if you can think a bit more about the problem and come up with a
> recommendation?
>
> I will try to get back to this series in the next 1-2 weeks and
> hopefully find some way to make progress.
>
> I skimmed the rest of the patches and they all LGTM at a high level.

I went with storing the size in the KHO FDT. The addition is small — a
"blob-size" u64 property per subnode — and I think it's warranted: this is
intrinsic metadata about the blob rather than a purely debug-specific artifact.

It also rounds out the API nicely. I extended kho_retrieve_subtree() with an
optional size_t *size output parameter so callers can retrieve the blob size
without needing to understand the underlying format.

I'll send a new version soon. That said, the patchset has been growing
considerably, so if necessary I can defer reworking this infrastructure to
follow-up patches and get the kexec-metadata patches later.

Thanks for the review,
--breno

