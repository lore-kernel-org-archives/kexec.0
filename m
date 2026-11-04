Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3BB606A328
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=f2ryisbC;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MC8VPNm7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BFKdbCnvgEnPUCR+piUdwFlucy5SNy4ZmkD3FremwV0=; b=f2ryisbCpyfBam
	oPgGKXmwYaMncHs02iNLc452ydq51LsyFW7B3ljleIjnJfGfFSLjq0VqSvtpOU84ZlFC+EIwvHMAz
	au4jNPHQLiagBl23VvJ6fNdgT3YiyduR62JgRQOAx+aktnl7+Mn30CPmHbKaDXRd6ThPYN7hWM80Z
	LKYL9Jw8Ss80JopJQ1+K+I+hREofQb+Qk55whnVw2aW2tOKRhiKYi4oq/OwK/WcAYpT7nIfDK90Dk
	3Qe237Ft37NytPmgWRKHhN+aH6N1DkKe0Qp1jSsy2AyCfkgOtkw0PQuOoxuiCok1mqNCJRFaqalDO
	2sHw/yJ+Njd37szs4Q3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xORQo-00000004FLr-2R9q;
	Wed, 04 Nov 2026 03:12:58 +0000
Received: from out-183.mta0.migadu.com ([2001:41d0:1004:224b::b7] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xORQk-00000004FLM-3yI1
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 03:12:56 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=BFKdbCnvgEnPUCR+piUdwFlucy5SNy4ZmkD3FremwV0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793761972; v=1; x=1794366772;
 b=MC8VPNm74Ok18sfdmxnpsI6xRh7R0Zk5W//KSoh4oQqgT/S/C7qdI564Yzn9q9U82YW5fQUa
 bHEVLCzq9Vqzf9FcDE7exA0+xlnDu1bTQ6V7pBzRG57qh+3OeK8awrDIx3MWDyYkXpPcFBKY+AD
 RqEEVje7E40Z3XH7oOIjjkYY=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 888f0105953f8a83;
	Wed, 04 Nov 2026 03:12:52 +0000
X-Mizu-Trace-ID: 888f0105953f8a83
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 43/47] mm/huge_memory: split huge PUDs when adjusting VMA boundaries
Date: Wed,  4 Nov 2026 11:12:45 +0800
Message-ID: <20261104031245.9524-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-43-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-43-d6437171ecc3@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_191255_119176_495695A6 
X-CRM114-Status: UNSURE (   5.22  )
X-CRM114-Notice: Please train this message.
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


On Sat, Oct 31, 2026 at 10:40:12AM +0100, David Hildenbrand (Arm) wrote:
>PFN mappings such as VFIO PCI BAR mappings can use PUD leaves while
>allowing VMA splits at page granularity. However, vma_adjust_trans_huge()
>only handles PMDs.
>
>After faulting a writable PUD-sized VFIO BAR mapping, changing its first
>page to read-only with mprotect() makes the PMD walk treat the PUD leaf
>as a PMD table. Applying MADV_DONTFORK to the first PMD-sized chunk leaves
>the PUD spanning two VMAs: the PMD-aligned boundary skips splitting.
>
>Walk the page tables once at each adjusted boundary and split a huge
>PUD or PMD leaf as needed. Handle PUD leaves even when the boundary is
>PMD-aligned.
>
>Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
>Cc: stable@vger.kernel.org
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice work!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

