Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BE3C88E64
	for <kexec@archiver.kernel.org>; Mon, 14 Sep 2026 02:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AXLI3k9/pMTK/BtsjTVMEyDksi2gFy8I9idpjBEt+8w=; b=bN0Kth/ZubW+B2P+K0q46ehO9X
	BNM7zlRNlt2DxKwmBmZIW3Gd4tJiELrDXr9162U8UGjQK6FXoui423unR8ZI0AdeDLiLU29/pOIXN
	CByjZw78J3IqKS1GzCKlcKsaK6EsOV28SYQzD+bWd/7IhdpN5kkn1PbCWouTgtyKaiQTrqZgCBJ93
	x7Ln3zGl4bAwToTFPWQ3n3cAS0PdxjT274w8mIcncDW2SbWU6SozJRba2kqDbcl0H/lmnbPP6J5S9
	7P8E3ZGsqqK9xCTlaIXq2QNkZK+fKGkphf3U3UgyQhYzx3AEtIeppUaaGk83TcALB/7apuwqiQPAm
	eOkCuU/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5wjj-00000002C96-3KfH;
	Mon, 14 Sep 2026 02:48:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5wji-00000002C8x-1gsz
	for kexec@lists.infradead.org;
	Mon, 14 Sep 2026 02:48:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B302B413B8;
	Mon, 14 Sep 2026 02:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087EF1F000FF;
	Mon, 14 Sep 2026 02:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789354081;
	bh=AXLI3k9/pMTK/BtsjTVMEyDksi2gFy8I9idpjBEt+8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aUYWUEkwRAc/MPD1E8wD6u4bTIsbzSq0kvntl9FVDaEATIYAy4I4sIHXFRhg9t4Yz
	 04T63Uk3AKoDRg5NkaKSEjHUhOI2lbC8ikAkEKvl4oLWjLlij9tg1sMybkHau92g4w
	 i3lIV7y5nDKFszslBx9YR0befexyZn9Vr1fRxtdL1d8YPb2I927c60O5OWDxlgwQWC
	 iLso1LRAbVRq0e23KFOTaH+/kqOtLqBi3rSyUQuZVP+dNpzy+Hg3aD3BwD7OI5jIoU
	 CW38fNAoU1X6qNgr88GSJx29l8IxFbmBXdbF6TD/ns1HI3wJQltPrXO1+RIlLwDk4I
	 VHxM1iKtfDtGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/16] mm/page-flags: remove PG_private
To: "Qi Zheng" <qi.zheng@linux.dev>, "Lorenzo Stoakes" <ljs@kernel.org>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Kairui
 Song" <kasong@tencent.com>, "Alistair Popple" <apopple@nvidia.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Gregory Price" <gourry@gourry.net>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "David Hildenbrand" <david@kernel.org>,
 =?utf-8?b?TWF0dGhldyBXaWxjb3ggKE9yYWNsZSk=?= <willy@infradead.org>, "Dev
 Jain" <dev.jain@arm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Liam
 R. Howlett" <liam@infradead.org>, "Michal Hocko" <mhocko@suse.com>, "Lance
 Yang" <lance.yang@linux.dev>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Zi
 Yan" <ziy@nvidia.com>, "Muchun Song" <muchun.song@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Barry Song" <baohua@kernel.org>, "Nico Pache" <nico.pache@linux.dev>, "Usama
 Arif" <usama.arif@linux.dev>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Jan Kara" <jack@suse.cz>, "Baoquan
 He" <baoquan.he@linux.dev>, linux-mm@kvack.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Masami
 Hiramatsu" <mhiramat@kernel.org>, linux-fsdevel@vger.kernel.org, "Pratyush
 Yadav" <pratyush@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Dave Young" <ruirui.yang@linux.dev>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20260913-remove-pg_private-v4-16-848550f7574e@nvidia.com>
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
 <20260913-remove-pg_private-v4-16-848550f7574e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 02:47:59 +0000
Message-Id: <20260914024800.087EF1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Silent memory leak of folio private data due to missing check for =
leaked `folio->private` data when a head page is freed.
--

commit ebe4dd474a496c46897e3f790e03a43cc0508eaf
Author: Zi Yan <ziy@nvidia.com>

mm/page-flags: remove PG_private

folio->private !=3D NULL indicates a folio carries private data, replacing
PG_private. All PG_private users are converted. Remove PG_private and
reserve the space as PG_folio for future use. Unused PG_private functions
are removed too.

> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 08988877331ba..10f4ad075ea48 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h

[ ... ]

> @@ -105,7 +101,7 @@ enum pageflags {
>  	PG_owner_2,		/* Owner use. If pagecache, fs may use */
>  	PG_arch_1,
>  	PG_reserved,
> -	PG_private,		/* If pagecache, has fs-private data */
> +	PG_folio,		/* Do not use: reserved for folio identification */

[Severity: High]
With the removal of PG_private, does the free path for head pages fail to
validate whether private data is leaked?

Previously, the memory management subsystem checked for PG_private during p=
age
freeing (via PAGE_FLAGS_CHECK_AT_FREE) to catch filesystem leaks, and issue=
d a
bad_page() warning if it was still set.=20

While tail pages are explicitly checked for leaked private data in the free
path:

	if (tail_page->private) {
		bad_page(tail_page, "nonzero private");
		...

The head page's private field appears to be unconditionally zeroed without
validation in __free_pages_prepare() in mm/page_alloc.c:

	page_cpupid_reset_last(page);
	page->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
	page->private =3D 0;
	reset_page_owner(page, order);

Can this silently mask bugs where filesystems leak private data (like an
un-detached buffer_head)? Should we add a check for page->private !=3D NULL
for head pages before unconditionally zeroing it?

>  	PG_private_2,		/* If pagecache, has fs aux data */
>  	PG_reclaim,		/* To be reclaimed asap */
>  	PG_swapbacked,		/* Page is backed by RAM/swap */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-remove-pg_=
private-v4-0-848550f7574e@nvidia.com?part=3D16

