Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C3606A31A
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JiXALqCr;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DOaintvD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=77xhCh2ORMf6NIfM90rhR5yS555x+O+M+p2I+XHyw1I=; b=JiXALqCr5lf6tp
	2uFKUxbiXvu1GI0MztLP8MbA055WJyTKvSI425M+gUrLxSqEhsXK+FaymYzhY8nIi4l+zugqnn2EG
	RBAXiFwa/yXj9LEZFfPw8blMwaF4c3ZeEqBVlN4IsJDrML0xhmL1qddHb7c96NtUgycsvDgOq/1k1
	gBMu4cd1HVjPjvIdhaC/ttpccxcZkKEoqkrkaEaKYqZt+8Q03bFWEbGr1leWQ8kOI6pAWFOFsogW8
	sADpJXmnhXXwAID5CcXri5bjBWEdw93gev5IGtJcxvvOmAxZrf+0RwH7xCzH//PqryOrT0qEaiJPz
	3PDS9l4Lb/czdQLkDvmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5CR-00000007IPG-28LQ;
	Wed, 28 Oct 2026 15:04:23 +0000
Received: from out-16.mta1.migadu.com ([95.215.58.16] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5CO-00000007IMC-3GQJ
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 15:04:22 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=77xhCh2ORMf6NIfM90rhR5yS555x+O+M+p2I+XHyw1I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793199857; v=1; x=1793804657;
 b=DOaintvDCkIU/aM4mbDkTUbB7KXdOwz/1W14lJYmnPjR1UglE6lkfhl7iisk2fyDHg/P6GP3
 5jciE740/d15e8va8jnQE3dPdseWY1LxdNQxUpMbCZtLmWnGJY0gb3M1wALTIAly7eJpWAaE9h7
 sOj/QiLSS8wumYpDbu7phDXs=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id d7967b914a90b8c6;
	Wed, 28 Oct 2026 15:04:16 +0000
X-Mizu-Trace-ID: d7967b914a90b8c6
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
	josef@toxicpanda.com
Subject: Re: [PATCH 12/46] mm/huge_memory: fix livelock on device private folio
Date: Wed, 28 Oct 2026 23:04:10 +0800
Message-ID: <20261028150410.47065-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261027-fixes_core-v1-12-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-12-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_080421_027906_DC3BD594 
X-CRM114-Status: UNSURE (   7.39  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.8 (--)
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


On Tue, Oct 27, 2026 at 12:17:32AM +0100, David Hildenbrand (Arm) wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>If do_huge_pmd_device_private() cannot lock the folio, it simply returns
>to try again on the next fault.
>
>Just like we did in commit b570f37a2ce4 ("mm: Fix a hmm_range_fault()
>livelock / starvation problem"), let's wait for the softleaf entry,
>which will drop the PTL and wait until the folio was unlocked. This is
>precisely what we do in do_swap_page() with device-private folios. This
>avoids possibly livelocking.
>
>Update softleaf_entry_wait_on_locked() documentation to clarify that
>device-private entries wait until the folio is unlocked.
>
>There seems to be no compelling reason to backport this to stable
>kernels unless we actually see problems there.
>
>Fix generated by an LLM and sent by Josef Bacik in private.
>
>Fixes: 4964099163d0 ("mm/memory/fault: add THP fault handling for zone device private pages")
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>[ david: simplify patch description, fixup softleaf_entry_wait_on_locked description]
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice work!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

