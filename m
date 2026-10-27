Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB67606A327
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mtnPvYPB;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KgPV/gmY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=dBXyCpRHgO+MYx+nOUuoDTL78tUn9LIeQ2aFxfEucBY=; b=mtnPvYPBeD73ct
	Ng/oVWDHmfRyGjoYhaiAXevRDGwEmzkKcR7PpkHrBcvM8MPt3FqSnBI6p1ZFmxWrcb6LZJXsllK+T
	RZV65kYEa+EHTISY1/HZJQCinWdPP+cu6O/A9Z8sBPg3AAVVQFRKEPCv1IlBZ9y6NrHmvfGBzDhSS
	jz3GVovAGtPXgkp/w3A8y+fhZH5uazpz8LjVjqlrQPb/5dc4IeaZHczObfDSpW9/QnG5/jif2MIU0
	vlqqsrJns1eMeEJPyRNhW6vfeOFp7LmVK+LN+vPQgsD9VDi7CtVY3zPXvkSGA4KGhM8eLOGgTsAN4
	6D36sFbpBOlrJW8UGgmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLn9j-00000005gCj-1aY2;
	Tue, 27 Oct 2026 19:48:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLn9h-00000005gCI-2nRv
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 19:48:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 14C1A4408A
	for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 19:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F036A1F031E1
	for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 19:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793130501;
	bh=dBXyCpRHgO+MYx+nOUuoDTL78tUn9LIeQ2aFxfEucBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KgPV/gmYvgO1jtxfDh5WvpuFr2cvb9AIuladgsy/hQGHGaWPA2esBzeZlHN2aToLw
	 2K0uOldFjx9tM+dM5e2SKVF06mcEi2WyVXVhRApA2EMBMUgeI9hX7nFdhZqesWPIpj
	 ZGhQiDkqwyx2QGo970t2fjeH2kkH+5xH0meBD1BjBgK4rN0/ip1r9Jp/FZNRiAK10o
	 XA8ePK61boeqRTc2bgILvoW/Ka8lRVYWgJ3XPga6QlJ/C8p6TQzTxreKUtta/Ky/kx
	 B2F6kBvXeRNWW4gezQAuXp31oPSY5oUkaMGeE7yMYBAFDPN83phxcGae1P2clM27so
	 uBXMsvQDj9bRg==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f079a63b8so14233685a.3
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 12:48:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByvS/vfpWj8i6AXvRrJ9DNKus3Y2PVU30Nn7PqwY4/Dp48CKvln17ehz6E1WpBskjT9Cmn+HA==@lists.infradead.org
X-Gm-Message-State: AFq9FYLnPJNoJa+oXPUxZmXEx4Ql/yzTsLa1iTS7kIPxp8duxgZIPcZv
	noiqiMB9nU3rT7vEX6pa9iEwao5a7ktJvqaOtn4BnmTBs753ADfOMcrRys4aOz6pX67qzJNK9AC
	5iNUg0aU0XsQ6IjEN8Wmv5BJWBPoj6+A=
X-Received: by 2002:a05:620a:171e:b0:93e:c12c:4409 with SMTP id
 af79cd13be357-940ef99a3dbmr1852566585a.69.1793130499936; Tue, 27 Oct 2026
 12:48:19 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-2-6f74bec9a5bb@kernel.org> <auB-3BQn_rR6IfY8@pedro-suse.tail5790ac.ts.net>
 <22b819a2-631d-468e-b724-770caf9f94e4@kernel.org>
In-Reply-To: <22b819a2-631d-468e-b724-770caf9f94e4@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Wed, 28 Oct 2026 03:48:09 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z3qgCPBpCDitVTq+xiGsS=-yEhKSbEO4Lbdn9MVAHK0g@mail.gmail.com>
X-Gm-Features: AclHuK-TztIwEQBE6javSaaaoybdbPKwOAcVqEYuGwGbjltsm1heJMFfzyWkRwA
Message-ID: <CAGsJ_4z3qgCPBpCDitVTq+xiGsS=-yEhKSbEO4Lbdn9MVAHK0g@mail.gmail.com>
Subject: Re: [PATCH 02/46] fork: take mmap_lock before copying mm_struct
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 3:07=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/27/26 11:38, Pedro Falcato wrote:
> > On Tue, Oct 27, 2026 at 12:17:22AM +0100, David Hildenbrand (Arm) wrote=
:
> >> dup_mm() copies the parent's mm_struct before dup_mmap() takes the
> >> mmap_lock. A concurrent brk() can leave the child with a stale mm->brk
> >> and newer heap mappings, causing later brk() requests to fail.
> >>
> >> Other operations (e.g., PR_SET_MM) on the parent's mm_struct can simil=
arly
> >> cause inconsistencies.
> >>
> >> As a simple and robust fix, grab the parent's mmap_lock earlier. This
> >> way we don't need to update individual mm fields in dup_mmap() and
> >> keep missing ones. Stop updating the 4 existing members (total_vm, dat=
a_vm,
> >> exec_vm, stack_vm), as that is now no longer required.
> >>
> >> Keep releasing the parent's mmap_lock in dup_mmap(), before
> >> userfaultfd completion, to avoid moving the userfaultfd handling into =
the
> >> caller. This should get cleaned up later.
> >>
> >> Move uprobe_start_dup_mmap() to preserve the lock ordering.
> >>
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Josef Bacik <josef@toxicpanda.com>
> >> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> >
> > FWIW, strictly speaking malloc() isn't usable in a forked
> > (multi-threaded) child, but glibc/musl provide this in a best-effort wa=
y.
>
> Yeah, I'm more concerned about other things that can race ... :)

Regarding the race with memcpy(mm, oldmm, sizeof(*mm)), we
still have one [1] even after this patch.

That is, copying mm_struct can happen concurrently with
lru_gen_del_mm(). However, this race doesn't seem harmful.
I might be missing something here though.

[1] https://lore.kernel.org/linux-mm/6ab08265.71f81b7d.15fa6d.001d.GAE@goog=
le.com/

Thanks
Barry

