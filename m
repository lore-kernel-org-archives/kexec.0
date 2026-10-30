Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44DC606A335
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Jfz7KstC;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUzBhmPJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=s4lfKj1K0mW/s2L7Sgy/qf7fmtgSr6raq1ricsBA8ac=; b=Jfz7KstCcUrhSwa19KtenGa2Ec
	Mmbnp4vcwUGbVjFfNFHeHZArTGizKkEsuKuG1LDxVJx14ePv/fV4HXpegjUnvhSm+k87RSB+f9gsm
	pRzOxkAJw2vYA1m0vLCFnFr2vf7kQdsZBFWIB/SI+QFUJUlspIHXC61HHIW9GiTQk3LSARTFh+LUr
	SsBq+9ztJIyM3vg1oxpoidB2jdykRW/jNxpiso+aA1KGHEuqphFugrcywD7CUkiCMLlICuhAtqXrN
	Vu9Ym8SJJ9T5443t5L0xVmd+7uiXG+pyeMPjKUi5+BzGxztprJD77vSGOfYNosAK2DW28AdhNb3S1
	ItVjeHlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMqCK-0000000CDFO-13OW;
	Fri, 30 Oct 2026 17:15:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMqCE-0000000CDEn-2OVP
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 17:15:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8B5C060617;
	Fri, 30 Oct 2026 17:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006CE1F00A02;
	Fri, 30 Oct 2026 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793380517;
	bh=s4lfKj1K0mW/s2L7Sgy/qf7fmtgSr6raq1ricsBA8ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CUzBhmPJr9eAYRositKVhICwE3c28ZkAAjS0KumWeYbRW0XPkQdPfFpUmhNzkduGf
	 eNK8cJBXkm1LcRxdgz8pbim++vUwl3Qo2Wi2u67IFCwGpc0KJW1hJgM4PL9wsWPFQ8
	 n2vgJajN9/JgJBDSNkCRUr3Ps+lLziGRn4KfYlKDlQ+Q2dM0AgRuVN0AeKmwNjLoou
	 DBKAoVd3hAzzeWjNRcM9745yIRlDvqdgJ1NKYsy5PmzcCycLrZcqyW3ha8Da9RfdED
	 qQmoCBUP0/65hIin82cHE3MyoSUOhm5iJV/Lgwvzixtexx6EGf7oiA8FZISupkzNi3
	 4d5D02eDjfIYA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 40599198003A;
	Fri, 30 Oct 2026 13:15:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 30 Oct 2026 13:15:11 -0400
X-ME-Sender: <xms:lNDkamuImIsjl-Hb9Y5yPVbFGJUSJ2YkTbfduoFzzyBJU9zxFetHMw>
    <xme:lNDkavExiGJ-vgkdZfzFxhLNhTdhym7QicbGj1KOQOxfDjsmOaza50LntODZuYjuW
    oTCuZvAWjDptGh2dRPl_hiHmmfAylPPS6hxAHR1NhFysI-fJLS0NG4>
X-ME-Received: <xmr:lNDkapA423pMVrTnw-aFqjww79eVY1slYYooZoVKAUZ_5j2dE890Pbgd3c8>
X-ME-Proxy-Cause: dmFkZTGMRFW6wwkHRR3YT/ZEaqGEmM3s/XdACkapu3EoKr46FLACqjR7K3Thpw4JePzMmg
    efUKMlli7l4jKADcUqysPC7rXWTo3hsYHN95q7KQKBB0hS2BIQ4ReFIX5pJg46qGnZeHIj
    bAM5c7zHLm1wlrOFZO/hvF/gM1Hi3h2fg4ArYsNqb9BHlobWTRKUbrfNiAlALH4kz/HLFT
    22veRLEf/VUYXdArHteMiDkSfTJI5lxN84Jbw5/XkTUVbHRwfdNMh6O9KPIRhA16SYy/2h
    VplmIiPi0J6XsEMZXbvYp0xNB16fhKfQeo5VIG13ZPS1nPnH3WXL1vFmZPgI5a43gwebLd
    1QCkS61BanvTvpCFk5Uba1eb3YhkPf89SQKfmvmtUPhoWRI0oksjeXpevdv7fyK7pYk6z3
    sPwgoOguaX7V4NETkGOzkJxhRVtfa1iYoBV17bKhJ3JKBGkENt7Bb9rtwzX9X48TpJ3FMg
    RiTgTIyy6IUPbP+cOSc8nQLp6znFG9wAxt3tjXwoNsVUC2MaYAd9ZvSb0k2qO8ooUcjvko
    wP+8NiCmzXNvb1kihY7Cb6icraE0ycDmt27hE6CQuqXQZU1PY9+6OTefhgwvPq9ACoV2Ct
    c26sah+C6kmiElOI+lSyNoY0Ql0YWwX+drZljpEOs/SRovpQukfpjYQvAMZg
X-ME-Proxy: <xmx:lNDkamK_3xdLFI2j9ne9t6fJjXYd1OjImERMgH0j8v-jsitvEKrnMg>
    <xmx:lNDkar5co8fUMQE80BkdKKzbpQ1N_HMq8FlD5AjWBbVyDf9BktqaSA>
    <xmx:lNDkam3Y50Gp444UM859DwrQVODdGKeCxEz7XRaENTsldtzUtBTtWQ>
    <xmx:lNDkahjMWZx2j4GxFA2FoF0_jnQTMClJIpXa8dWSQs69ovj50BHgTQ>
    <xmx:lNDkajPJKjKzhIorpxlSxBCSjnEddyKszhFHgdWuKDKxBwVhcGC3Hw_s>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 13:14:58 -0400 (EDT)
Date: Fri, 30 Oct 2026 17:14:57 +0000
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
Subject: Re: [PATCH v2 43/47] mm/huge_memory: split huge PUDs when adjusting
 VMA boundaries
Message-ID: <auTQhAuyokuSPX-D@thinkstation>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-43-a64ce7f83abb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-fixes_core-v2-43-a64ce7f83abb@kernel.org>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 09:33:38PM +0100, David Hildenbrand (Arm) wrote:
> PFN mappings such as VFIO PCI BAR mappings can use PUD leaves while
> allowing VMA splits at page granularity. However, vma_adjust_trans_huge()
> only handles PMDs.
> 
> After faulting a writable PUD-sized VFIO BAR mapping, changing its first
> page to read-only with mprotect() makes the PMD walk treat the PUD leaf
> as a PMD table. Applying MADV_DONTFORK to the first PMD-sized chunk leaves
> the PUD spanning two VMAs: the PMD-aligned boundary skips splitting.
> 
> Walk the page tables once at each adjusted boundary and split a huge
> PUD or PMD leaf as needed. Handle PUD leaves even when the boundary is
> PMD-aligned.
> 
> Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

