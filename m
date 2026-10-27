Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB0606A322
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MYtmBaIH;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U/v3JqQ2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Kt3m2QX4pRtZBRcLH3IFIQTcdgR87dlcnUp5/WDyAss=; b=MYtmBaIHWSmyTm8UzlXEXDZG/i
	ZmtNVZh+K7Xnf88yBtXSMuAQVAIeSJExNPFHS9JH29aKAq+EkK6COY+ltrQyqsOVYAac6oQhdmUw1
	dcLvd+U3412YsFPp+bldCZawcQ8EVh8kKN1kTkytpwuQXrrMawwudccElEeLyYzpMDlmg2x+uGGAR
	nNhnHe0R2W3WYuVSjMjs5i7wGkSlNHbntEDCHKZYzEG2jptGmaFlvu9YplY5L1+Pa8ZBa23QWmFom
	qGo+Zyannnva3FLSHgWhIuj0SrMBdVkEU1A8tvUZm75uA3p9eziBN94W9eS06W20SpCbo4Z5w8by3
	PtfeTs3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLn57-00000005faU-1gRB;
	Tue, 27 Oct 2026 19:43:37 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLn54-00000005fa4-03xU
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 19:43:35 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2db33db4de9so14905ad.0
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793130212; x=1793735012; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kt3m2QX4pRtZBRcLH3IFIQTcdgR87dlcnUp5/WDyAss=;
        b=U/v3JqQ2q7FxKxsHLNr72OsqgKR+QKJqGx63OEx9Bxs1a/h25l3+4BbBUNt0IKpV04
         YnQ+fX3h05SwT/1ZlqOUN45Wmp5LvxjmtaK+3dBhtxN1F6/hFbKwtdhnOT30SM0no95y
         ikKjVCffr0UlrGHuZxyX90QkJB51WSLmzjorap65Z0deQFNsPWeKn/wx4o3acMuUMZB0
         toRPFABLfwWZJrgqNyLixHzMmYwiMhrCF8++AsXhie9cbFLqQP20nu2hQEofvnq/pT+w
         8RqvjBG67bkH6dxdWQfCQQKpTL/OD7jaAIFDJbMrPq2kyRQ920y6g1Rsf/Nw6fTPrJrs
         GkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130212; x=1793735012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kt3m2QX4pRtZBRcLH3IFIQTcdgR87dlcnUp5/WDyAss=;
        b=xCGYi9K/qfA+x3+bWL7MQUb2d72QxOmvDILLkihUG3sOgkIhittuU1Qsjppsz3VTf5
         Ke9/6c1xMdHqy7EnlRJzmwJYTYYln+slxN4N7ofjN+9nRRrQTKT+g15DXE9m5CfTYIwI
         COpaCpcaIxa8RdVPA4bMb6TFgvogIFDdmbS+XxOtbEuHWhUhl0923SRltXpbraoXVEF1
         uyfD7kdHGSvQKVzyJ6GzpTI66cK1Zfj/wtMva2Tf0rSeco9f1PBe+eWepe/sRsoOj8v9
         RIhdoNmXjb+CF5hphWJTo5RCLlsInjHCVE5grGw4ofoad+8Mr00b7gAiWexE6u0ahCbE
         8F2w==
X-Forwarded-Encrypted: i=1; AKwUvBwT95dMJhc0hfIYO109OJ7CeTmAN6Vwcp+b5NH30HpIG8moZ1CVftbm4vpZ6qKrcCn60n7Orw==@lists.infradead.org
X-Gm-Message-State: AFq9FYI2RnfcJR7QzwRg1Oxr0oMgO/7yEnCox+Rcwng/Ez51EMrr5nxu
	puTtyanODsmjlwkNuHqSSST5fLTs1mXceatnjH7QGFUigN9KB+mu8glsE7y9ogZBlg==
X-Gm-Gg: AYBFou0hzdaxKjegfyPqX9Y5txpBFG97Qk+cJn2VZK0vzCbr0GNuuOSbYthyyYWGdbt
	oEcsVIT8Bhy4wyPWZZcgVcwVSf8JlPM6ng8heyCYRcjALYIDbROzDNV8uoaPibAz0Krgt7z/EWs
	Zn/4tg1wqtDpATNcXzMkGlfE1s8uO56/f4w5x+XoUpxsJJ0QjXNvSFJQ9iszzHMgZyNPga91MsO
	/xSOk+QAk0mVcfzZU4sunwmFaqePnXXxdoDKNNymkvI1kRgLeGJ284kR8XOEKN2difdrUFD1W3D
	JKVPy5DGrfk0/IW4yr5MNvGx3/qNl82HOJP+cow/PtLiN5paMfA2nDcvcJMeTa3ImX8VDU1kbxw
	PjfDSTZ1CSk4n8F6sF/KeibkV+8HteNpOo+5y8wduA985Vqy2VznVqB8f5thYeXBt1uyDCGk46k
	ADV+lRxXNOoI35Dr61n4DKy6iiWPdMD3Pt539lZ0stG8q4ENPWu9FwX/TwQE0diYC1/qYyWb/d2
	BLBpoppJLpTvwRscCXOxKYv2ghoFnDuao18pgC5ZO7vX67YMxc+Cfr22MfoiIHDsxumGr1RA8Nu
	uQvRElrueZS3Yx8C6D2QpKg5aUBZg5PMkOS8dlEKWHnFFo4T
X-Received: by 2002:a17:902:d550:b0:2ea:4a1:e8a4 with SMTP id d9443c01a7336-2eb01986bddmr124955ad.13.1793130211108;
        Tue, 27 Oct 2026 12:43:31 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae578f19b3sm251941a91.17.2026.10.27.12.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:43:30 -0700 (PDT)
Date: Tue, 27 Oct 2026 19:43:26 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 20/46] mm/gup: fix clearing folios in memfd_pin_folios()
Message-ID: <auD-r_lTZ71vbSKu@google.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-20-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-20-6f74bec9a5bb@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_124334_061406_C7E846FF 
X-CRM114-Status: GOOD (  11.00  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 12:17:40AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>memfd_pin_folios() pins folios obtained directly from the page cache
>without checking whether they are uptodate. However, shmem fallocate()
>can leave newly allocated folios uncleared and not uptodate. Callers
>such as udmabuf can then expose uninitialized memory to userspace.
>
>Clear non-uptodate folios and mark them uptodate under the folio lock
>before returning them to the caller.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>[ david: simplify description and comment ]
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/gup.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Samiullah Khawaja <skhawaja@google.com>

Thanks,
Sami

