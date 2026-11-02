Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBD7606A32C
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hzwaB/jU;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Z6X9Wt1f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7aamrL1eeNrbIdMSN+jaXpW6b7pg64KUgg9/NR7r4M8=; b=hzwaB/jU1ohQnp
	p6xiS/gfSFBW9bhR1Bln/IJ+m7Yn+2f+draS+aRvwj7LaqJ4rPw8X0NHZ6catdeVsJ0DMO63wcDnX
	O1Js8S7hT6uzU2NnvEhp7CT5iFC72zBsIcBbW73wRQVAdNZdaRFEYOaDOrzUsreXqMrUtPg/qQ2eN
	+l7fnp3Cc/hA6mDdjweptCiEdQzPJg4SneuXEhGWGHsCNUNrPwNVWuuhe22JGd5DNsXB+UwXFoxKa
	l0QqFPxeIjqi2/3ekBfe6oRxvpDjlcsTj7iHk69OTgD1eQBL3KLdJQUUhH+VkX1Z0QJetNWcEl4XE
	bBIRYRDkzDHRTDe5dPBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNr0a-0000000GS7F-3Dvz;
	Mon, 02 Nov 2026 12:19:28 +0000
Received: from out-93.mta0.migadu.com ([2001:41d0:1004:224b::5d] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNr0X-0000000GS6S-284C
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 12:19:26 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=r/y28Pr8KNBr61CZIB3z7msn3ARAQOG25oOo8bDyEqs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793621962; v=1; x=1794226762;
 b=Z6X9Wt1f2OM0mk9Cvw5ZsBYTsSsI5PkwaBYJjVaRrHKRsTE9x/ymuRWOcLnrF28+pJweuNV7
 6EzFPwGVjc92CRJwXYeA37ONO25xqpbqAElMy37M/9RJ7oZUyP837HGQFBUQd7QRrP3u8yb4+GD
 5HLS9jSoxykzaPBgfV1a8xbo=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id c966688054ce713b;
	Mon, 02 Nov 2026 12:19:21 +0000
X-Mizu-Trace-ID: c966688054ce713b
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
Subject: Re: [PATCH v3 31/47] mm/mremap: recheck PUDs under the page table lock
Date: Mon,  2 Nov 2026 20:19:14 +0800
Message-ID: <20261102121914.69229-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-31-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-31-d6437171ecc3@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_041925_747606_73EF00CA 
X-CRM114-Status: UNSURE (   8.96  )
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sat, Oct 31, 2026 at 10:40:00AM +0100, David Hildenbrand (Arm) wrote:
>Once get_old_pud() is fixed to accept PUD leaves, unmap_mapping_range() can
>clear a leaf between the lookup and the move. Holding mmap_lock in write
>mode does not prevent this.
>
>If the zap happens before move_page_tables() tests the entry, an empty
>PUD can reach move_normal_pud(), where pud_populate() turns it into a
>present page table entry. If it happens after the test, move_huge_pud()
>can instead try to move an empty entry, triggering CONFIG_DEBUG_VM
>warnings on powerpc.
>
>Recheck the source under the page table lock in both helpers. Treat an
>empty source in move_normal_pud() as a completed move, and use
>__pud_trans_huge_lock() in move_huge_pud().
>
>In the future we should likely have the code lookup a PUD/PMD lockless
>once, instead of multiple times, because one of the problematic bits
>here is the:
>
>	pud_trans_huge(*old_pud)
>
>Fixes: 0881ace292b6 ("mm/mremap: use pmd/pud_poplulate to update page table entries")
>Cc: stable@vger.kernel.org
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>

