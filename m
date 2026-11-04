Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B16606A32D
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F0GkTrBd;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oO5llueb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8fU8AEGdDcjq9JBv57injpYEq2ySiH6tspHTe3WsEnE=; b=F0GkTrBdBS+UGo
	PYUcXCEA6fQCzyxea8JKpsGoNYXmsoGPvPh6FFmhKtaz/nd2Fs48GFSh4VidTImXq3IvBoBrKu7y2
	BQ4Rc6EbegMG29S48zfdXyts0K3pQNpTAMKRt3ZW8KfJEolwMrMrtyHLiF1diqw0WYHKMURnrPqCz
	yiFvhnb+0ppIjcaHmlgXDTVYJwH8KuhF2BApb44r0iFLpcY3niOS1Q6e98pHF1mvOYVHrKNVlF9MR
	+pXRmBiNISnG+EpGNNzQPVipcJWeYUlWb7wJ2aUzbWiRGOIhR9UqtZIJJOuLCm+XniJPxDfHgR//d
	APnyIoAwQkr+lN0mhTlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdeV-00000005uhA-2CTf;
	Wed, 04 Nov 2026 16:15:55 +0000
Received: from out-52.mta0.migadu.com ([2001:41d0:1004:224b::34] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdeS-00000005ueO-03ox
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:15:54 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=QhoInTD0Xt4NBSuls0AgRrgTJDXjCSOPGY4pmRsoD08=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793808948; v=1; x=1794413748;
 b=oO5llueb2uLLHAIztGoWQ9k0aJwHtRxomO9r6ciLu/m9aaoJCGqWBQobUJ4/gK0SNhXJ97nr
 ElLpG14EwNXY8YlLuxiBnZE31ra/RtD3OJcdO8OVaX39YfomEKzpN1x2NQniWCLhSg/wVqkFKSJ
 jiEDYnwTN7uWGrVGtczbdmrY=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id c6ae390f292ebaa1;
	Wed, 04 Nov 2026 16:15:48 +0000
X-Mizu-Trace-ID: c6ae390f292ebaa1
X-Migadu-Flow: FLOW_OUT
Message-ID: <81096741-0e14-4469-bdbb-497aba541fbb@linux.dev>
Date: Wed, 4 Nov 2026 16:15:46 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: allow crashkernel to reuse hugetlb CMA memory
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, baoquan.he@linux.dev,
 rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 ruirui.yang@linux.dev, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, muchun.song@linux.dev, osalvador@suse.de,
 david@kernel.org, jbohac@suse.cz, sourabhjain@linux.ibm.com,
 ruanjinjie@huawei.com, leitao@debian.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 kernel-team@meta.com
References: <20261104142727.2894800-1-usama.arif@linux.dev>
 <autMHwldMudQOO3j@thinkstation>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <autMHwldMudQOO3j@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_081552_394025_14443A82 
X-CRM114-Status: GOOD (  15.03  )
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 04/11/2026 15:20, Kiryl Shutsemau wrote:
> On Wed, Nov 04, 2026 at 06:27:27AM -0800, Usama Arif wrote:
>> Use a separate suffix to make the exclusion of existing HugeTLB
>> allocations from the vmcore an explicit choice.
> 
> The crashkernel=size,cma documentation already says that pages allocated
> from the range are not in the vmcore and that it should not be used if
> dumping of userspace memory is intended. HugeTLB pages are userspace
> memory. I don't see what a new suffix makes explicit that ",cma" does
> not already.
> 
> Why not let crashkernel=size,cma take hugetlb CMA first and reserve a
> dedicated area only for what hugetlb CMA does not cover? With
> hugetlb_cma=6G crashkernel=2G,cma there would be no extra CMA at all.
> With hugetlb_cma=2G crashkernel=4G,cma the crash kernel would reuse the
> 2G and a dedicated 2G area would be reserved for the rest. Either way,
> nobody has to learn a new option.
> 
> The catch is ordering. reserve_crashkernel_cma() runs from setup_arch(),
> but hugetlb_cma_reserve() runs later, from mm_core_init_early(). The arch
> code could record the size and leave the reservation to generic code
> right after hugetlb_cma_reserve(). That is still memblock time, so the
> remainder can be declared there. An early_initcall is too late for that.
> 

Makes sense to me, I will rewrite it in the above way and send v2.

Thanks for the review!
Usama


