Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DFC606B5C1
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TK78LnyX;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzDseVK9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pDrzL4ldTnZQIT/GAoRY8qgOJKT6dHcsc7F2wuy5Kmk=; b=TK78LnyXqvXoJp
	Msh1cDPPwadVR/f4TWeW+Ac2pSpypfidokLRrPLNi+dfXsgYU4XIVFZdZyNqagx9GAYanwbHGy5v2
	ZVTs5v3VYkCCAZoVnsLgXaGy3DuQoB+gyIk/iJmecZie1jrEEF9NZ9LbSSpujiepwxShaKGbb162/
	yg+BELioPYal5uAFp6VVzA6Y5ebuZS02waiSf4umb2Y7JNcoUSGazXUjsbRnhHgBLqrEsFp8wc7K6
	bSSXqEYrCtkF9UPYafyvB/pbrPZ0YRBzIxNTsxcUQap75q0qvm8wtH88VkWKzDIDov+953ODipYSC
	rW35yVAMhAP7ZPCkI2Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLniq-00000005ikI-24ZM;
	Tue, 27 Oct 2026 20:24:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLnip-00000005ijM-0BW1
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 20:24:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5FE1343DF1
	for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 20:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D98A1F0134E
	for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 20:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132678;
	bh=pDrzL4ldTnZQIT/GAoRY8qgOJKT6dHcsc7F2wuy5Kmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FzDseVK9Ysko91Rkuq+QlEaFb2aAO095E8N7yIyvvONeohFAvEsNuXL/t50nDF4QA
	 dB5RS0qSQDyYKaQaQWzOLKiy8bN7OzmckzsSTJ0jnH1Qw/2x2YaVSN6GxSjIbbxDx8
	 6YPifMscpbIXjfoVMUUATqDBadzckblpHh5eoBXFbwrjvTULXKrPFYypotdKpK58DR
	 T3W5/x+BLgYO/uqSgOwbx0psff5ZkS+yXOS1sCDyFfPieQMn9gqqd1jDYw169JcsjM
	 H4Tthi6yhRiV7WxwtKCJQJaKm6v8skUAG5+0ZkEJfKUFputM9fxnc7vdLjTMxWwDOl
	 m4R1HwtIFSlZg==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f269e335eso18238085a.3
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 13:24:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwIuhvbJD8uUzxdEKy6Lcn4kdIpyWYf+FNmKAezJqieB5ugdoC3Y9mqdGdDEFFO1XfGOvigyg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJuVdhFBAqeN2+epdQkuFO8H3rRMdXGTbTU6jiE9YikQYiVmDtU
	sNx4hef4fTwn0arqQzuW2NqleSfPjRModHOld3z5Z5wUegX0w5BwItTciWaGs1jpoJpHi4DUDls
	wXJFKUvI/jQpzSKr7uO2jdMt/v+4iv+4=
X-Received: by 2002:a05:620a:2a03:b0:93f:611d:a18e with SMTP id
 af79cd13be357-94408cfc2b6mr7042985a.55.1793132677465; Tue, 27 Oct 2026
 13:24:37 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org> <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Wed, 28 Oct 2026 04:24:25 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4ytMqpLJ7wQe_gUz6Fo+BBK6ym-T6kjwgrHi7HNM0LiZQ@mail.gmail.com>
X-Gm-Features: AclHuK-1Qeuu3Mu9aA1DkXbl4G55KJdsUzpEs7vpxIgxIJbJWhUve_AqW65AwOY
Message-ID: <CAGsJ_4ytMqpLJ7wQe_gUz6Fo+BBK6ym-T6kjwgrHi7HNM0LiZQ@mail.gmail.com>
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking PUD
 and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
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
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
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

On Tue, Oct 27, 2026 at 7:18=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> From: Josef Bacik <josef@toxicpanda.com>
>
> MGLRU passes stack copies of page-table entries in walk_pud_range() and
> walk_pmd_range() when walking to the next level. These copies can become
> stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a PTE
> table concurrently.
>
> This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
> support page table walks"). Likely, earlier locking masked the latent
> bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
> retract_page_tables() without mmap or vma lock") allowed concurrent
> retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg locking
> for MGLRU") dropped the walker's outer RCU protection.
>
> The fix is simple, so just fix the original commit so we don't have to
> speculate. To fix it, pass the actual PMD/PUD pointers. This restores the
> RCU-protected lookup and validation against the live PMD. Note that the P=
UD
> handling is required as well to handle folded page tables correctly in al=
l
> cases.
>
> Fix generated by an LLM and sent by Josef Bacik in private.
>
> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: handle walk_pud_range() as well, clarify+simplify description,
>          adjust Fixes: ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>

