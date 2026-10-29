Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EAA60A2603
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iTG4XzTe;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBWpMU/K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=x05fCxndf1hYykwEJ06qD0sbC4EVKTE/sZRMpUPdEQc=; b=iTG4XzTeqkD1Q/JBS1ga+iwq+h
	p5S8sQLlWyxCRy8dExy8l3K9Dd8pYHNshs7e5DcwZRy0H3FSXWL5FJXwvOm1xMc6C7+vl++5yLkK+
	bmP99EPii/NxCVaGCEXq0IMsd5C5DDNXFmJqFWo8SqT+KQ3JD7ZOLzcJjlty2UURNJrkSRs2+VIft
	ZNmQuJTgFG3H2teOxrxRUo2cea6+sKKtlTrvFmCUko/5b1Ru+igSeauA+AZJ2G/MFXULQfEmmPccc
	Ti7qnSif2N/zS+fXFSYDpstWGUZLAX5aeszfzA7yjKMOAI0q1wKvF4tHSmCmHhdji4cVDGRegA8lh
	SJk151Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSHK-00000009elz-13vF;
	Thu, 29 Oct 2026 15:42:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSHI-00000009elX-3TRR
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 15:42:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 471E643F1A;
	Thu, 29 Oct 2026 15:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22651F01824;
	Thu, 29 Oct 2026 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793288576;
	bh=x05fCxndf1hYykwEJ06qD0sbC4EVKTE/sZRMpUPdEQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VBWpMU/KLAu7f/e/8Noc5/ky4m6uYCqrAnbDe7B1Eiyf3YKYYuSJu9S6rMUBwAHRq
	 rxdNuSkxQyc4TOUMzaXdWdtkkmG4SSedqSFbH+UiVGUvDBhSbF5ps5Rj1N4WC5Z+1M
	 nVg6ipTCrheIKd6OSnlqmCHY40aY5JuHQMktjBDTz0bNGDllpKtBpr67h+uTjX/02/
	 BPVwPJ/jrEhMjy1lbZssZEiGQ47CW+eoOvd7LM9X+gXcm1M/wx1zx2VQ/uyO8q67C5
	 n6t0zAffCO2JyYnGumXddDp++ELqcS68IiiH0skAk3Y++ZmqpXAGKI8OP//9xNZw14
	 KXjSab75N39jg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 55D60198003A;
	Thu, 29 Oct 2026 11:42:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 11:42:51 -0400
X-ME-Sender: <xms:cGnjatNYCDeDF49taWGwFnFA6DTBtqFjLkJEWyZ2h7-8tO1hYgeSTw>
    <xme:cGnjalcGilwgpzywEq5-9_Uax-LoiciY26Hr9Dx2NdLZKDVOeYHxJNoKbsqoyc0HV
    fMpRhpRtFCi6EkHPOqVKO7Qgcsf8k8JabM2EeZbLZYt0LPRJSrAX1Uy>
X-ME-Received: <xmr:cGnjam3XDA41P6ZfG4_oZPjd4RhksmXGacPPo4PHNrL9WQIkvxQOdIUOlic>
X-ME-Proxy-Cause: dmFkZTGrojcwHOYNV1R27yGMmE+sn2SpgiwFqzTWix470caHvIOH90SafujrsKt+HTJD90
    SN5SPP69uNBPn1MxWH6/eaMHHTJo/SvRT/z0Ju39Z9YfjzvKYsDYrFhgheSCBdJ9b5YIFp
    cIdIwys365LDAngvB6UcUIm3AGzNccSf4yN/FZLQr8sexIPFzUStpfInmWS9yXmQgvCx5c
    fmpZ7EbFXEWylssnvmmDQCnrMMUW1jHsUhf/jrVErtMG2Lbffr1bqxM2P6gj7ypN5ZdyZj
    TgAYvrVjfWikwB2MTrnw3YjFYjeMV0UDDQUTP/dXoAy/YlzoJiJh64//IR8g0ZuUVQCpel
    PcjjoB9Q6Jx3knI5olrCUi4hirBEGQQT+oSeGTeh25/h09KblyE6Vl7jNLQSnQit4V+35z
    J17GU/oPzC0n+oCMVsG/dfInPKVCtLZBd5z2d7pFm7kIyajC91WW0fXwTIMOKy3y+R1okp
    ekcKGTudIOrHnEZRx1GDJKalnfGvVV/PnxC4Qbu/41RL8DRLjWQuiSHsfiURJwHwuxhasY
    GYMOJsxXNzU8cnNcXtdtzJIfeYba/tJgBPi2qhRcbC1kxMhMglGWVDH8uH+rSsnay/vQnw
    D3Mh5eiVtNV6r+viH4MNCT1TzsAFldnQpQurl7rb5p9gSfzssla1/AAmhpLw
X-ME-Proxy: <xmx:cGnjalwWU8W_LTwkSDS4FwlbRvlMAxVh616uhleGcP8DWlPfaYmGzw>
    <xmx:cGnjaj53Pt7V4Vu7bIXzZKdpvSrEym3BIg-jYhLqD8PxloGEbD1BjA>
    <xmx:cGnjampN953BOAPY-iT_PyL1bwsUDnSFFEZwFhBzoi8zawrViQ6drg>
    <xmx:cGnjaqnZb_SLLcbp0PPUsQOS2wLwEGRm-QsuvZlsn1hfIsEUvsIcMQ>
    <xmx:cGnjaqQ6rvy28ek_52FnLx0f5zjRtsChWHkRCTWZP2DTXANVWLWIhapi>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 11:42:39 -0400 (EDT)
Date: Thu, 29 Oct 2026 15:42:38 +0000
From: Kiryl Shutsemau <kas@kernel.org>
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
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 42/46] mm/huge_memory: split huge PUDs when adjusting VMA
 boundaries
Message-ID: <auNpU-7hPtUZeTGs@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-42-6f74bec9a5bb@kernel.org>
 <auMxQPze5cOvGbCe@thinkstation>
 <9f4128a4-85fc-4f4b-ac41-b9d348f56e37@kernel.org>
 <auNYPPlCnLdN88t_@thinkstation>
 <d5d077fe-4695-453a-a2cd-40ef30abd61d@kernel.org>
 <e796dace-06c6-43b8-83f0-594e7f1e7380@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e796dace-06c6-43b8-83f0-594e7f1e7380@kernel.org>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 04:35:46PM +0100, David Hildenbrand (Arm) wrote:
> On 10/29/26 15:40, David Hildenbrand (Arm) wrote:
> > On 10/29/26 15:31, Kiryl Shutsemau wrote:
> >> On Thu, Oct 29, 2026 at 03:24:29PM +0100, David Hildenbrand (Arm) wrote:
> >>>
> >>> __split_huge_pud() must split a leave. Either by zapping it (what we do right
> >>> now) or by populating page tables (as in Usama's PoC).
> >>
> >> No, meant the situation when pud_leaf() is true, but split_pud is false,
> >> so __split_huge_pud() is never hit. pud_present() is true so we proceed
> >> to pmd_offset()
> > 
> > Oh, yeah, I can add a WARN_ON_ONCE() for that, it would be a bug in the software.
> 
> Ah, or I can just drop the split_pud check. Let me do that.

Yeah, looks good.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

