Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC50F606A321
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JMULakXj;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=gx3NBXs9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WpPpjm9qqTzsBHBWliVMSUioS6+fsJ4niawtYuOMrWQ=; b=JMULakXjmAF+nl
	0qL0eqjNB/oB5+To0j0srxfC3qyH+P0kB9XrP4Ph+a0ry8S6OQarzzFIF0ZYcb+F5J/2MKPaAIfzN
	jm9GwO/674/kSkIlbg8xrr3fcYXIPdQOvH4GinioCfeh5RUDeayzZrbxuVVyUM6geMOZ030n1pD+K
	wBSqu1UcX6jgIleVujicOxgiSfIw6Mv0cq2ZPkG7q7lib7JqOnVvxoR+shsseUggpqUGfxERCAM1H
	7ZsODOwU0UVkaRJoZfcMIl323y6QdbcuhYAlySdlPK0YKl8NBSrISAG5z+kILtCXlm3+q+pt1enuR
	IOvYkuBxwfZRIOrG5X5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMFGG-000000089pQ-2O0K;
	Thu, 29 Oct 2026 01:49:00 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMFGD-000000089p3-3iBv
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 01:48:59 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-c46822eefb6so206590066b.2
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 18:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793238535; x=1793843335; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WpPpjm9qqTzsBHBWliVMSUioS6+fsJ4niawtYuOMrWQ=;
        b=gx3NBXs9kwI7UKEjiVqO9pFie9GJQHftOTICCXAlZi9EsWxRvkvA+kgiMzm7OoxcOI
         kgF3kgjQhB9nINmQbY0cRUK7s+DBfDln/Tftm43DrVcKGmWAfacODjvHjXzNV9+1GCvu
         1VcQP3Fi2bloAHPslGu6l2Bc0hvlBIo5o4VEJ652NEP9iAIx1ohU/j8MTKyqO5Po4xMB
         1Y3Xj45Pvfjzfv2CoRU/wJnLrkt+JratkTPL5h/QHp3lb48Il+H+yakCknaUXSO/LFZ8
         MhOY9bsmSyY2adtvgp1Z0auKGS+ikbuY6Jz4tcrBCFMdctOGXjhgNfRGnDoG32bKdz18
         mYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793238535; x=1793843335;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WpPpjm9qqTzsBHBWliVMSUioS6+fsJ4niawtYuOMrWQ=;
        b=Bh3/2KbuVfHrgGutQIw0R254LD7p3527ivE9nyST/UAVqG0qDkcoDkOel1RGhUuMfh
         nMWxRQM03rtBdkQzIOpZ6XWvEkxgmap92lpyO47fVRnKBRm803L2efiG3Jyc/07wRv7f
         AkSn9tu8WVNRQx34xv0udD9WCPkH+h4warPPtOlfkqiphLUVRm1a1TyUi5dmWYeCaAeW
         PUhxJ14XZUYCmaoFQf8heEN8G0PHkLhop0t7f9BvAuy4d4KtaiITezDe0XgAu9HTGrF0
         ooE6Wa1oZryv9rUHa68Qc8AB/hrvGTBtK/UBqkFPzrPnm/4M4wFCeANS8heD75ZpKDbw
         tH/g==
X-Forwarded-Encrypted: i=1; AKwUvBwrWvfxQtbuodhVCiCMxMBuA21y6dx/AScQzyYx0PsNePXJzqusxVGDxfN0zy5YmKGnmGh0bg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ4pJuIBIVF9thYDIM6qwV3yOQVXZ1u3c5WJ49C4ZvH5vAcAeLW
	jdENbjEYyh8ala/p6FVMrvxBR/lle01BuLkF7eNAIgpswXSMOebLdrzWbgADQEJTarU=
X-Gm-Gg: AYBFou2sZGMD38hWa+2cUMP1xPIogMURde3NbncPcg86LIR3C9KtDnAX77ViIvYGW2f
	9BeqSt6qq7PTZ60ykqzR2p0Q6yx3iKzkXNLJQ4WV+iLErh2d4ul7KkmKyNh++cpuuzsriY2XCQM
	nvscQA+VZ+DwrZRuTQqLMi5YTSPs0KFBlSVXotFyr4GiPMcXT3JM8gRpSxaM+bibPPPBjB1jqjq
	WS53SEamvEoQKbYGq26ScuV9RXiPlyjqYOYxjcKPe7Easeo5GlOrJK88PhHA4uwdv2chBT3/hAX
	T0B9lYym+dIIocMFolBRL6kPgrw5LkIP+Fz7viu/xiHoPq2n/75rZvuqkSM9SIofPaE5gvWeHMk
	czN5UDkAnY+Yq5ECk+UhX/yffkm4wfPlMlnxeY6lPfX9Byu4P8y25NVp0dK4uLXaDdIUzr3/TVE
	DONGAw0GDmw94qZ2kpAj6UsNQrIpqf+DhgwGDMh1S6Nx9D6eO/ajnRsGxD36MG1mk7QN66sKITy
	VRKBe/BamWT+gEa5Dg3cXRUUVrF/rp9uLU3p8AA8m3J8k+I8uRAeV0+RQ4dOf1jE4xZXd2uAu+w
	9BB1yIJdlFht0QO0CKPx
X-Received: by 2002:a17:906:ef0b:b0:c41:b94c:4539 with SMTP id a640c23a62f3a-c49bddac7b0mr353178966b.6.1793238535200;
        Wed, 28 Oct 2026 18:48:55 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4e::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b495ac454fsm2147232a12.1.2026.10.28.18.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:48:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 18/46] mm/khugepaged: check if PTE table is empty in
 try_collapse_pte_mapped_thp()
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-18-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-18-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 18:48:51 -0700
Message-Id: <179323853182.453251.8510731747954180380.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_184857_961575_9F597E6A 
X-CRM114-Status: GOOD (  17.07  )
X-Spam-Score: -2.1 (--)
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> The existing code is rather horrible and already resulted in bugs in the
> past: we special-case UFFD inserting anonymous folios by grabbing the PMD
> lock early, but ignore any other markers (guard, poison through uffd) that
> could have been inserted into the page table in the meantime, effectively
> dropping them.
> 
> Let's just unify and simplify the locking: try to grab the PMD table
> lock and if that fails, flush the TLB, drop the PTE lock, take PT locks in
> the right order and check if the page table is still empty.
> 
> We still perform the heavy lifting (zapping the folio ptes) under PTE table
> lock only.
> 
> Include <linux/hugetlb.h> for now, as x86's flush_tlb_range() macro
> depends on hugetlb helpers. This dependency needs a separate cleanup.
> 
> Both issues this fixes are rather corner cases. Let's not CC stable for
> now.
> 
> Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only mappings")
> Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

This patch is painful. It's taking me a bit to wrap my head around.

I get that you want to avoid taking both locks while zapping, but
wouldn't it be simpler?  I suppose we don't know what kind of
regressions might pop up with that though, bah.

I can say that I've reproduced and tested the before/after state,
and it looks stable.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>

