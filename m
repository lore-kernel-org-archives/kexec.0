Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB260A2604
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rZp/NljF;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=DJw3Inm2;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dNl8kU2Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rlYYUg5m282yLIStEKkIHTozLzxeQHV9wO/ECVNrg9o=; b=rZp/NljFao7PCX
	89B2R5SLGF16meB3FuVxrSjr7p4TYzTqjfkwh+fYfLGsVqY7kqMapG5zOBruZpuA7/T+Zl8xhxFV0
	YkejRCjPlz/EJZXoPH0vGB0LVUS7OiF8Ylk6SpaSfjnaRPnmD7o1F2exsgph1snsnTn4oXlMGtF4I
	CnvJO1uu82ZY0cZgohpzlyMMPkB7b2r57rnGlO5RWQsE0xda0hqxgGHc5NzBogLSX97K4nYSx8OWT
	ij+1HE1uwzhMBOKKetpYBam2j3g5qXPnsObN8Vq5wr7ZHhtyCME2NDkPq0YC71uqKygmz2RQ8e8rX
	6bE3C46sGHq0ShA7yyhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNq7e-0000000GJ8f-3h5s;
	Mon, 02 Nov 2026 11:22:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNq7d-0000000GJ6L-3NbN
	for kexec@bombadil.infradead.org;
	Mon, 02 Nov 2026 11:22:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rlYYUg5m282yLIStEKkIHTozLzxeQHV9wO/ECVNrg9o=; b=DJw3Inm2nNE1MOuvbwqdZdYZTX
	uVQgjmE5iMfpcPVSphTIltSa37ymgOATRxYYnqI9JC/hqyZMbgJ/k77h0JQxigHjh6a46+R/4k8Q6
	+V/XHf6cI2m4uQz6YwvS1Wwx4e/0Y7upxHVX/C8SWj55ZGl1mcrYgeOCLx7BQAEJvSK22h95Mc+kk
	AP1p466iCxDvMUirzVSjjUEja9HjgQ3phy6X3gKyJ7TkCxJ19aaii8R0VGWav4mVMoRu0sMQKQhXd
	Qwgmu1lzN4wsW/JDRbhOMZ8meEKGLeA4SfzUrFZH4RRLWq6j8IiTtT/XIPPEKH/wMS+Qcd8rUhsui
	nIwncnVg==;
Received: from out-217.mta1.migadu.com ([2001:41d0:203:375::d9] helo=mta1.migadu.com)
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNq7X-00000002QTs-1ept
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 11:22:40 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=rlYYUg5m282yLIStEKkIHTozLzxeQHV9wO/ECVNrg9o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793618553; v=1; x=1794223353;
 b=dNl8kU2ZZnY7p+1AZb5FkPRPxnYNE0pNnRkYzfMXhsQ6nzU8z5o/GWyH69JI2jndGu8pOXov
 iCXfD2V18rj7VtN0dm54SEJgnoT8r9LSk12pObDE1JIpBZph6bgTHoxZAQEPzv45DOvyDH48795
 PK/VAB0uVps+jfwrxgnpYmZo=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 0a735c2090dc6b54;
	Mon, 02 Nov 2026 11:22:32 +0000
X-Mizu-Trace-ID: 0a735c2090dc6b54
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
	stable@vger.kernel.org,
	skhawaja@google.com,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 20/47] mm/gup: fix clearing folios in memfd_pin_folios()
Date: Mon,  2 Nov 2026 19:22:27 +0800
Message-ID: <20261102112227.62593-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-20-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-20-d6437171ecc3@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_112236_454055_5CB604AF 
X-CRM114-Status: UNSURE (   7.70  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -0.2 (/)
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


On Sat, Oct 31, 2026 at 10:39:49AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>memfd_pin_folios() pins folios obtained directly from the page cache
>without checking whether they are uptodate. However, shmem fallocate()
>can leave newly allocated folios uncleared and not uptodate. Callers
>such as udmabuf can then expose uninitialized memory to userspace.

Right, just make sure the folios are initialized before handing them to
callers. They shouldn't have to care whether shmem deferred the clearing ;)

>Clear non-uptodate folios and mark them uptodate under the folio lock
>before returning them to the caller.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>[ david: simplify description and comment ]
>Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
>Tested-by: Samiullah Khawaja <skhawaja@google.com>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

