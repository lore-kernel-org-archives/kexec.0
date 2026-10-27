Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D76606A32A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=piLivfS6;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6z+kAm0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9d3CjGk4IyINuQoAlcYK4HfriQfpoCwO3FN0Jov9T4c=; b=piLivfS6NJcaZU
	sFTsjpMHvZG3WD5Lrf3LN8vT6UfjER6M4fub+NpA4Un5TI53CszdPmWghHTTkr37+J7HcI2Hb5XHA
	Bx6TPlEyhbY4VHQYmRTj8+dTFyDxPZIIG7lSUMuXjH6FPw6SjWfT6E6DEbvw0m5Z3/yqMEYCjKENV
	l49HwQ3ZSK1yht4WU4LKMIe7risvJkYRO/3jpSRHzTnxsh+y2wuFpjTsArhMP5VUKSWWSwH8mAZt9
	LZ8k0TL5t4uNYPdQvi0rvHzxIx8Bhis35erz45tE5VwqDTBSHOpg9FVo/ULLzxAQTO0JkQCUs3H+7
	ILlwA28gU3IVILYrNuMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLodS-00000005mn8-1rYj;
	Tue, 27 Oct 2026 21:23:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLodR-00000005mn0-1jBU
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 21:23:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BF5FC43D91
	for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 21:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68E31F01280
	for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 21:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793136188;
	bh=9d3CjGk4IyINuQoAlcYK4HfriQfpoCwO3FN0Jov9T4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=R6z+kAm0PuJyWoP1wDpeDsMLfxEdKmvEBBNq9ncNVSENbCX0QB2ik5uDEOmNLgJ2P
	 VjQn8CTRH1BrUxIyQVAonsw5zEoLGAz9Mo+1iV1QE4yWhK65BlHE2meFhE3PxIgA8g
	 /w44e+ZyxOFykN7XZDiFYDvmvxGU4dH81q/05iLJklEIVVEHQ1lomD5FIRAh3Mz+zg
	 L+keYsUOFf+gHec1Kcsndv1zeAUtqDN7WkbVKUcnNs52DNFvLoGFNR87W2E5YFEqGp
	 YGLXO/1Xh5JYSqvvFMXmATv4ECYgilcVloUirDQAQjuUbZ4s0DrO6SctrHKceD5mJV
	 XmNhaeI0DoOGg==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-930c0f9c1b1so21393985a.1
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 14:23:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxNq2Kq/a2Zl6w4p5CMQqCbebjB+6g/NP+bmxN0vSIzkl9HPi6kLTXnsuDRZVshqmaq6Xs8Vw==@lists.infradead.org
X-Gm-Message-State: AFq9FYITqBwHEUOvd2/z9jEZ0JDFtDxRzgUEZxNPecdumzWMO2tjHo5t
	uFvPhPtrwF2lguTAV1xj2IZQCmg7NmHOAMsexb3b0ZvMK5Zfi1/gb9SSon+lm9bUrvc5PoNdACh
	/n4NVr2+PFp/sBkBL3bB5kzCMDLc+DtU=
X-Received: by 2002:a05:620a:17a9:b0:93e:9934:d179 with SMTP id
 af79cd13be357-94408cf6b61mr29933485a.56.1793136187480; Tue, 27 Oct 2026
 14:23:07 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org> <20261027-fixes_core-v1-9-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-9-6f74bec9a5bb@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Wed, 28 Oct 2026 05:22:56 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xy0mbje=iWGNkaGKOS9BzZdu=oEhZK6zokUV5=5-sANg@mail.gmail.com>
X-Gm-Features: AclHuK-0yMwUgshVkFS8VwS5_y6OqXYnXUcZ3OjIhbezUk0HJVn0mGZCE7K7epg
Message-ID: <CAGsJ_4xy0mbje=iWGNkaGKOS9BzZdu=oEhZK6zokUV5=5-sANg@mail.gmail.com>
Subject: Re: [PATCH 09/46] mm/rmap: handle device-exclusive entries in folio_referenced_one()
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
	SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 7:20=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> page_vma_mapped_walk() can return non-present device-exclusive entries,
> but folio_referenced_one() passes them to PTE young-bit accessors that
> require present PTEs.
>
> We must neither call clear_flush_young_ptes_notify() nor
> folio_pte_batch() with non-present entries. For example, clearing the
> young bit on non-present PTEs can corrupt the entry: on arm64
> PTE_AF overlaps the swap type, so clearing it turns a device-exclusive
> entry into an ordinary swap entry.
>
> folio_pte_batch() will VM_WARN_ON_FOLIO.
>
> Apply the same approach as the previous fixes to e.g., damon_ptep_mkold()=
:
> treat these entries as old from the CPU's perspective and obtain their
> young state through the MMU notifier.
>
> Skip PTE batching and MGLRU look-around for non-present entries, and
> don't modify non-present PTEs.
>
> Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>

[...]
> -               if (lru_gen_enabled() && !lru_gen_switching() && pvmw.pte=
) {
> +               if (lru_gen_enabled() && !lru_gen_switching() && pvmw.pte=
 &&
> +                   pte_present(pteval)) {
>                         if (lru_gen_look_around(&pvmw, nr))

I was also a little concerned about the internals of
lru_gen_look_around(), since it visits a few neighboring
PTEs. But after checking, I found it is fine, by checking
get_pte_pfn() =3D=3D -1:

bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw, unsigned int nr=
)
{
        ...
        for (i =3D 0, addr =3D start; addr !=3D end;
             i +=3D nr, pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
                unsigned long pfn;
                pte_t ptent =3D ptep_get(pte);

                nr =3D 1;
                pfn =3D get_pte_pfn(ptent, vma, addr, pgdat);
                if (pfn =3D=3D -1)
                        continue;
                ...
                if (!test_and_clear_young_ptes_notify(vma, addr, pte, nr))
                        continue;
                ...
        }
        ...
}

Thanks
Barry

