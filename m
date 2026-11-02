Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F88606A32D
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 04:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=S+blVAlx;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ou5yWqPu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pRumD9wLinzEvAPlvHgnbog+/WM1mG1VlBridWjM71Y=; b=S+blVAlxUG+JYd
	LXkFVBUFziW0hRU0oMCrhmdbmOI3DH/OqS6SBZHH+WJA5jjC9mh3gMPITEREitkhKYM/VxbW/n7UW
	4Lxb4fGfcikkATkPYKUh6sC2TDsDXGzaq726SekYjgjP/nTeoslCGogngmpLNT4cLdl9fBHc7k9b6
	tuWGzNLDeenpUwdRZRhC8eZ3W2XDO/K2UPbTZwq2V9UBJU6DvI2Bt7ygr3f6fgq5RQwPEel/rusFK
	nNvhIX6dR44dFY/c+ThW6/wuRx1wdYt92CM7A6iPyWRywBJ4+UcMgEqhwEyJKmyaMh9C4ME7C3saL
	A4PwUsAfgdkuj0+V8GMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNjwi-0000000FX5C-1GZj;
	Mon, 02 Nov 2026 04:47:00 +0000
Received: from out-125.mta0.migadu.com ([2001:41d0:1004:224b::7d] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNjwf-0000000FX4i-2642
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 04:46:59 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=pRumD9wLinzEvAPlvHgnbog+/WM1mG1VlBridWjM71Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793594814; v=1; x=1794199614;
 b=ou5yWqPuqDPK9MoS2gwOxtV0nJaHNjRepasuddqg99TIMooIrdJvtjgGZKpTZcF/gB3K4dzf
 F83dASp54zTsXmk8of1QtTgg8faFGLmsE3OBvH51el7fLTUHVJbVcULFotuBADSOIQMJ/xS1kDf
 fz+DlXYolSLhCfSHBhCNDdtk=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id eb600a511e081679;
	Mon, 02 Nov 2026 04:46:53 +0000
X-Mizu-Trace-ID: eb600a511e081679
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
	mason@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 14/47] mm/huge_memory: fix zapping migration entries for device-private THPs
Date: Mon,  2 Nov 2026 12:46:43 +0800
Message-ID: <20261102044643.33636-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-14-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-14-d6437171ecc3@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261101_204657_855051_B3BF4526 
X-CRM114-Status: UNSURE (   8.05  )
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


On Sat, Oct 31, 2026 at 10:39:43AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>A PMD migration entry can refer to a device-private folio.
>zap_huge_pmd_folio() checks the folio type instead of the entry type,
>so it treats such a migration entry as a device-private entry.
>
>Installing the migration entry already removed the reverse mapping and
>dropped the mapping reference. Zapping it must not repeat those
>operations. Concurrent MADV_DONTNEED during migration back to system
>memory can trigger this.
>
>Check the PMD entry type using pmd_is_device_private_entry().
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>[ david: simplify description ]
>Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>

