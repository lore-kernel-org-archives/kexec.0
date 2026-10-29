Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1337606A31C
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JoZnubln;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=cgKIiYmE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CDgUtS6BmV52eDuX4xnh+bC+kNpwLNlhCSGJQEIkHH8=; b=JoZnubln/qXC2M
	1bWvhJfsaCEgSO+J355/Tve9fTIZb0mU6fGEVMuPYS7erPVHrNdGW5xnIz1eS4wvnU/TJ0ieU4W5N
	3r+iizYKPsKdcVSAmtXSc1dMoky863fztHedpRedt/S1je9F0vhBECllfooJwF9XbkvqmcFApoC1a
	v0NKQcguGNnmQ50KTw8BkjDQq/Y8Oue8+1e144Mgd7wKKoeZvh7StZ3CjS6tQPsGZL5M4SUGBVej7
	jk2/veptIZv0D1u3zkT2EuibF7QB6KGDI/S1/XB058x4qVQTlHTHyA0qABpEy2Wys2MXEKCli2KVV
	sjSKNLYHGTSs9Z+fGp6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMEvP-000000088mA-0Eqt;
	Thu, 29 Oct 2026 01:27:27 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMEvM-000000088lp-2s4b
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 01:27:26 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-c4682977f9aso203663766b.1
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 18:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793237242; x=1793842042; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CDgUtS6BmV52eDuX4xnh+bC+kNpwLNlhCSGJQEIkHH8=;
        b=cgKIiYmEbNYtMge0VyLgB6aF0zJdD3B8F4OanG1YYY1bQoYf5b6LNANq0pxKXUbKvX
         TD9OGqIlyFUbza/ovotLtNwBuurKp6VFHgOyU72wOJc3IGMQv1JVGwaQM6ihm+7jAinK
         aLfjyHgRxNDPJ9I1O5TdEzAM0i+kQIHPoiKnWb+yRlsDUHiYuMSc/v0UZBWsRR5qsPA6
         LKWf5iLyFwV7XAxCpTCGThvXVILUwmizcP1wBbHTNduirO6NiUFHr6cwvt7y0q7exA7f
         l67DEIUGpYPXSxmwLHun4/Uxomb1G8j3paOig6LrH1e0NqswLgCeoe1LX8oCnu937r+C
         HtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793237242; x=1793842042;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CDgUtS6BmV52eDuX4xnh+bC+kNpwLNlhCSGJQEIkHH8=;
        b=vFtfMKFblPLaJ7lOS64JLMqrXGzqKiFI08wxHe6Z6LaP9eiEov4NlWsaPqn7OBi05x
         X3Mf8k40c77QJAzorOMuTcwfz/qtqxNAbZomDFgQb2692EKDckHR64yoM/qlGo9Nqhva
         JMo8jXoIc0MJnakCBiagHJrU2nJDCIPzBYC999mwv2xQIoYcIihdDYWIr0RvFT3hGE1Z
         i7mn1PCfA2iateMvfUIF0pxI6ZS8j/e2IMUA/CDfzupMN+ggl5xImmbrYWU1ep/y3ldi
         Uo12PBLK342yk8ssCaG8iL4TUM/2Wm3gHPrwgx6CWxnz6OOxJyj/PoVLUyECfInMxZij
         eE0A==
X-Forwarded-Encrypted: i=1; AKwUvByjDiB09NAdN1da3EMjUXV5VyUOFw4/V5OMawh9G8FEsVKLel2Kl+yHzFvQqY6Eed0bKGtNBw==@lists.infradead.org
X-Gm-Message-State: AFq9FYIWl152yncgkbZWaa53DEiT1PcSsKeOUjDkD8KmdRu2SNr3NpO7
	oMRMgW3kKs9mm/OeV1SJJjiwfYvwABJdgy2yxvEkdOXBATnMpol32JtKR4fHcm+d7W8=
X-Gm-Gg: AYBFou1KDZv5HmxvO5G9943Jbo5br67cANmejEP3Y+B8VnYVLXT5KmZxS7WPf/qKL7e
	H8GNizT65d+tpbbqJnZloZtX+OM0SgcHjRSKlLmnYiOqlyKuYpoFirp5IM7CsAIMkU9Tku4usNa
	IVmVuICFmGQ9gPyKYzjcW57RKjdDP8F4Y0bAw8XJsg8K6x7lRO5yBnix+xPWmXEFALbb/5dNq1Q
	hc5jMRNJaqhtz7jkmZAMDhTSp/OseUZ4ccHaeDZ8ch86AzIUcOmvaog1JuL4+/QI2nc4IRZ/SAH
	Qyxlf6UVqBfPwl/M6Cfxm1smpiDt063CCVYRd4sjLCgUHjXEKjUg8cGm3g0up6RNaGiuwVsFjgV
	0zKTaLe2JzcqMiYD4s/kHQLZEJif53Tq3b/WW65/oLesUXy0I/0NsD23Vwxp3TqH6VwRFJWrsOv
	HXfcXvSDD+vb8IIZfke4FwkA1b1uf+KDJSxuEJPtOPyITuc9IUt4UBQj8JT6QwRh7tnwnUeWlqS
	Kq4LgqCAT2MOMFQKxzRav5lA08htTEG1LkQPcswIST4MMyITC7k9qn2MXWarXVFU5RjF5hwoB7a
	mt0BTmhSCThIKR+ElrBf
X-Received: by 2002:a17:907:97d5:b0:c29:c079:676d with SMTP id a640c23a62f3a-c49bdd744a5mr330020866b.3.1793237242153;
        Wed, 28 Oct 2026 18:27:22 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4964488e8sm2081290a12.31.2026.10.28.18.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:27:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 17/46] mm/khugepaged: preserve dirty bits when
 collapsing PTE-mapped THPs
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
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-17-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-17-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 18:27:18 -0700
Message-Id: <179323723859.453251.1630776487784216917.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_182724_763896_BE7652DA 
X-CRM114-Status: GOOD (  14.48  )
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> try_collapse_pte_mapped_thp() clears PTEs without transferring their dirty
> bits to the folio. A shmem read fault can map a clean folio writable, so
> a later store only dirties the PTE. Losing that dirty bit allows reclaim
> to discard modified data.
> 
> The assumption that regular files are read-only is also obsolete since
> commit 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse
> for writable files"). In any case, transferring PTE dirty bits to the folio
> when removing mappings (and while the folio is still mapped) is the right
> thing to do.
> 
> Use get_and_clear_ptes() to collect the dirty bits and mark the folio
> dirty before unmapping it. Update the comment.
> 
> This was reproduced with shmem using MADV_COLLAPSE followed by
> MADV_PAGEOUT.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
> Fixes: 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: adjust comment; simplify description; cover file-thp as well ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>

