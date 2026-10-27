Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A32606A31D
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FI34TO8u;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGI8e3OM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=S908WbS6sl8a+ccaT1hu8oFrTY/8mXQRTyc6SNjkEfE=; b=FI34TO8urrQLMh
	bF3s3Pr3F54TskRGRNPlvRuoqx+pvqyU3wr1r1z4/k8rLE1OKAc88nfvFaQE/hEd/pO6PHbFrJGVV
	soryJWyY3pzt5qopx3fIMvvKufoDwVVZC5mXcvN9JdqpKysjq4DeD37ZzO2DTCEuRUySvUHekswyO
	4sjgJyaavXvreKxHYraAQK+qCFJMaDfuZrFlFJ7RgO0dmKP9pGcFvO4jYJLepPbvMYlwq+rhNGPHQ
	iq0HtVer6FGSw6IMDRtf7FMOk5+VDMXqVan7WGayc3kQm2RSaBu5REh1OGZXDLcbdMbv0EqOmPJrc
	9mdGV1Ohh+99n6MKI6xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLom8-00000005njF-321X;
	Tue, 27 Oct 2026 21:32:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLom6-00000005niB-3Kcg
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 21:32:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 196A144095
	for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 21:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A5C1F031EC
	for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 21:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793136725;
	bh=S908WbS6sl8a+ccaT1hu8oFrTY/8mXQRTyc6SNjkEfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EGI8e3OMSj8oudPsWvxnIieFF6gTtab2PYp1pWyo2hMoHwm9k9vSCCBUrRG6xC8MH
	 0KGkcd0cCIQIKtaEwW9h9u/ChT04cEjChqjY1CDO6ZnF5ZAGMZXsI/3+Hd+Q5LXBkS
	 tstKAH5wHNK3/OGFItDDgQcCGMMsJehCZKVi5x688GOJAnc5FMB9Yl2vm4YMrbJS8z
	 GH6396g8Z26BXcomQK7YLP1JeyvPWoPTLaXD4wMHyikZsuZfVkFw4ACyB8DThiSEpJ
	 8mEUpcgXD7tk/pPGlMJZHaXf0LVXktt2gvyJsjPwxg15Yv9qrjFy1MJTjCjDoHGfaX
	 kdeNE1WPuUlqw==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93ead211f14so34640485a.1
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 14:32:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx9iSG7hS9g1URrXrD3D9UxHIfzKHjKmdZXBDJD/Iyi0/wh0tXpZRD2+gJhyBo3EufRUlqnow==@lists.infradead.org
X-Gm-Message-State: AFq9FYJWGJ/ZbdGHcw6N0jbng6bzJIYRlKuCfQoYdvZZEbLV7PYssj1U
	vhatD7S+TUUa3P3BIm1+A7xkl7wUADti2qz0ptudbQk2aMemQrfDHAG8ERlBsolRwGDI1Fxf/vH
	UggIDVyiNS6ism/n2Eo+o8cLKNmDLdhE=
X-Received: by 2002:a05:620a:6013:b0:93e:7156:f814 with SMTP id
 af79cd13be357-94408a65be4mr32182585a.11.1793136724949; Tue, 27 Oct 2026
 14:32:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org> <20261027-fixes_core-v1-22-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-22-6f74bec9a5bb@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Wed, 28 Oct 2026 05:31:53 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wPwBz8OB5opbuKsVh-ceKqyqi4d1aB8Emx4ChqDe4qzQ@mail.gmail.com>
X-Gm-Features: AclHuK_Qzkd3NBrrAvAlcTVmJZ8ovWd4rfeoh503KU3yWFCYVC_zuTNZmwxW4A4
Message-ID: <CAGsJ_4wPwBz8OB5opbuKsVh-ceKqyqi4d1aB8Emx4ChqDe4qzQ@mail.gmail.com>
Subject: Re: [PATCH 22/46] mm/gup: check for overflow when converting nr_pages
 to bytes in GUP-fast
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
	linux-cxl@vger.kernel.org, stable@vger.kernel.org
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

On Tue, Oct 27, 2026 at 7:24=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> The overflow check in gup_fast_fallback() only covers the addition to
> start. The preceding nr_pages << PAGE_SHIFT can already have truncated
> the length on 32bit.
>
> Users such as RapidIO's rio_dma_transfer() can derive such page counts
> from a 64-bit userspace length.
>
> Let's just check_shl_overflow() to reject any such overflow with
> -EOVERFLOW early.
>
> Fixes: c28b1fc70390 ("mm/gup: reorganize internal_get_user_pages_fast()")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>

