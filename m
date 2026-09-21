Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38172C982EA
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 02:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GcU0QGmFueS0jwckkv0xg7O1qozQrpTGoV36hRGJ0SM=; b=cKqd1/0UBOBPiC7AvE/lfMZOKx
	xFk0k17+CFpxnjEhjfKAiTL4TCRgU43pOi0UbEz6r6s7R0qtpfJZbstlutywlj0SGF5KlXExzezit
	UXc1UM0qV4JC32+Ycam5pDeA2l6HeiE4YV5XCVbgbcgqTIeaj31dYdqB7XOI1dnmWRs9V7klebHNm
	PB6XmpxHXnpWq7cbtLSsMKpmdD7qQRU6KBiuKE17pEyEItaoku53dY4zn+YZctmhSPAw4arObZSoW
	HmLBfCGLctYlTI1KdbNQjSqKZuYqsJzi67n3Xv294Fcd31Aci30aq+JCl9PuE2xgESg3vFOLQcdqx
	0chA/ldA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8UBh-00000000kT4-1FBX;
	Mon, 21 Sep 2026 02:55:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8UBf-00000000kSv-42ZE
	for kexec@lists.infradead.org;
	Mon, 21 Sep 2026 02:55:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2257A600C8;
	Mon, 21 Sep 2026 02:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628971F000FF;
	Mon, 21 Sep 2026 02:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789959321;
	bh=GcU0QGmFueS0jwckkv0xg7O1qozQrpTGoV36hRGJ0SM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZX+R7ln5PpzgQjzjbLK5PtfF1EYpKw2srgRLcWDJ8MfkeuoE59zPv6evJeebMCr3g
	 jI/2p5UQhtDBXT98Vjf/uTXfig7pI+U94YppfWZFxlotwxw4kbLYA0YEblbSy/8d6V
	 akuH+gWTL3mEgdZygbKovtZ8XFvv5gHnmkCKqaq35xTUJbZ5DboVs7VlVMV8MpRRX/
	 8bNDdN92BhACbS3jr/V8IVlCdKhS3seF8ly10JcNwZbKMN7/C/wfJwm/1h0PoVyJXv
	 e8I+Lc8sKw8s96/y1036pNEO9ZnGxlEDIfdrrG2Qh1ZIqJR32d3uNwSKXLNZ447Rqe
	 K46dK1YgZSELQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/17] mm/page-flags: remove PG_private
To: "Shakeel Butt" <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>, "Liam
 R. Howlett" <liam@infradead.org>, =?utf-8?b?TWF0dGhldyBXaWxjb3ggKE9yYWNs?=
 =?utf-8?b?ZSk=?= <willy@infradead.org>, "Suren Baghdasaryan" <surenb@google.com>, "Nico
 Pache" <nico.pache@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Gregory
 Price" <gourry@gourry.net>, "Kairui Song" <kasong@tencent.com>, "David
 Hildenbrand" <david@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Zi Yan" <ziy@nvidia.com>, "Lance Yang" <lance.yang@linux.dev>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Barry
 Song" <baohua@kernel.org>, "Ryan Roberts" <ryan.roberts@arm.com>, "Qi Zheng" <qi.zheng@linux.dev>, "Dev
 Jain" <dev.jain@arm.com>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Usama
 Arif" <usama.arif@linux.dev>, "Mike Rapoport" <rppt@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, linux-mm@kvack.org, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, kexec@lists.infradead.org, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Baoquan
 He" <baoquan.he@linux.dev>, linux-kernel@vger.kernel.org, "Dave Young" <ruirui.yang@linux.dev>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Shuah Khan" <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260920-remove-pg_private-v5-17-bb68b6a21869@nvidia.com>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
 <20260920-remove-pg_private-v5-17-bb68b6a21869@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 02:55:20 +0000
Message-Id: <20260921025520.628971F000FF@smtp.kernel.org>
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
- [Medium] mm: silent memory leak masking due to PG_private removal
--

commit aee12ed3446e69cb6eee57384ca09e768dab36dd
Author: Zi Yan <ziy@nvidia.com>

mm/page-flags: remove PG_private

This commit removes the PG_private page flag and replaces its usage with
checking if folio->private !=3D NULL. The space left by PG_private is
reserved as PG_folio for future use.

> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 7080a6a1a79e7..b0ddc652e76cc 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
[ ... ]
> @@ -1169,7 +1175,7 @@ static __always_inline void __ClearPageAnonExclusiv=
e(struct page *page)
>   */
>  #define PAGE_FLAGS_CHECK_AT_FREE				\
>  	(1UL << PG_lru		| 1UL << PG_locked	|	\
> -	 1UL << PG_private	| 1UL << PG_private_2	|	\
> +	 1UL << PG_private_2	|				\

[Severity: Medium]
Since PG_private is removed from PAGE_FLAGS_CHECK_AT_FREE, does this bypass
the safety check that ensures a page doesn't have uncleared private data?

Looking at __free_pages_prepare() in mm/page_alloc.c:

	page_cpupid_reset_last(page);
	page->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
	page->private =3D 0;
	reset_page_owner(page, order);

The head page's private field is silently zeroed here without any prior
verification that it was NULL. Previously, free_page_is_bad() would catch
and report leaked data via a bad_page() warning using
PAGE_FLAGS_CHECK_AT_FREE.

Now, if a buggy filesystem fails to detach and free folio->private data
before freeing the page, will this result in silent memory leaks?

>  	 1UL << PG_writeback	| 1UL << PG_reserved	|	\
>  	 1UL << PG_active 	|				\
>  	 1UL << PG_unevictable	| __PG_MLOCKED | LRU_GEN_MASK)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920-remove-pg_=
private-v5-0-bb68b6a21869@nvidia.com?part=3D17

