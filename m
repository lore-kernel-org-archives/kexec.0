Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821D606A326
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0QiQtkbu;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LVdL5OTg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PuZSxoPIfBuBWYT5kGfR/wiii4e+fymaeZzVU1jtsaI=; b=0QiQtkbukAXXEU
	8H8rwaeLxj80AxKXYD23cml7KUUfV+MupTxjJfODmz2J6ktYN7YCXMFiQdiB7f7kItl47ynhznfi3
	VgVRaRBHfN6KpKg6LXMWZPCBoteXfjIFXTb3PobD9n/ggibNvjBtm/ao9Mp3W0oPax0iJTP+ZJYpw
	OLe3sIvLwbo0NSSWf8nxYrrEZhgksZWSSr6jlZTdbJ4cySeHhVCJojVJECGET2Ohccravho0XKJ9I
	NR/v7DZXef/OkaLK1XFJSqX2u42ho2B7zzxs56u9i1nryj9evdOP2Q+xOjlZ7s90nc/ebAospMAo/
	0FLcqDFYICr7PjUxyqyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKZx-0000000CbFM-2OAc;
	Fri, 06 Nov 2026 14:06:05 +0000
Received: from out-164.mta0.migadu.com ([2001:41d0:1004:224b::a4] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKZt-0000000CbEw-2RJw
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 14:06:03 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=KdFDOOwfZpllsNIG61lzpXhrUDjzYe3zHf7j2d/rM0w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793973959; v=1; x=1794578759;
 b=LVdL5OTgDLMIMrDfJNp3W6jbpvLzebf6/nHzDbVsgTI0/F2WoQhDR4vMHHY/shEStctNJS22
 dd7IxwlftsFazxu7/U6NZrUo2Y07ny27+rcGp8oRXvl5hSd/nIpV9I9I0S59iRX/LC+xgzdwdnv
 ibgHVLBtX3zy2134lTvrWdOs=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id 5b86ef43620373c7;
	Fri, 06 Nov 2026 14:05:59 +0000
X-Mizu-Trace-ID: 5b86ef43620373c7
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	jbohac@suse.cz,
	david@kernel.org,
	hbathini@linux.ibm.com,
	leitao@debian.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH] crash: keep crashkernel CMA pages reserved if activation fails
Date: Fri,  6 Nov 2026 06:05:54 -0800
Message-ID: <20261106140556.1667159-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <0a3c64d1-2b8f-4e0b-87ca-5397d1aaa3ee@linux.ibm.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_060602_454086_166483EA 
X-CRM114-Status: GOOD (  20.96  )
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

On Fri, 6 Nov 2026 12:21:12 +0100 Mikhail Zaslonko <zaslonko@linux.ibm.com> wrote:

> 
> 
> On 04-Nov-26 15:56, Usama Arif wrote:
> > reserve_crashkernel_cma() adds each crashkernel CMA area to
> > crashk_cma_ranges[] as soon as it is declared. If the area later fails
> > activation, e.g. because movablecore= put the ZONE_MOVABLE boundary
> > inside it, cma_activate_area() releases the pages to the buddy allocator
> > as ordinary memory. The range is still handed to the crash kernel and
> > excluded from the vmcore, so kernel data that lands there is overwritten
> > by the crash kernel and missing from the dump.
> > 
> > Mark the areas with cma_reserve_pages_on_error(), so that a failed
> > activation leaves the pages reserved: lost to the first kernel, but safe
> > for the crash kernel to use.
> > 
> > Fixes: ab475510e042 ("kdump: implement reserve_crashkernel_cma")
> > Signed-off-by: Usama Arif <usama.arif@linux.dev>
> > ---
> s390 hits this without movablecore= (adding the s390 maintainers and
> linux-s390) since ZONE_DMA ends at 2G here.
> CMA tries to reserve areas above 4G first, but falls back to lower
> memory when it doesn't fit, so a cma area can end up across the 2G boundary.
> I ran into this while adding crashkernel=,cma support for s390, which I
> will post soon, and came up with the same fix.
> 
> About dropping the range instead, as you offered for v2: I'd keep this
> version. With the range dropped, the kdump kernel gets less memory than
> configured, and that only shows at crash time. With this patch, the
> the first kernel 'loses' the memory as with a regular crashkernel= reservation
> of the same size.

Yes, I do agree with this. Losing memory in first kernel is preferrable
and it will then force someone to fix whatever is broken rather than
finding out when their kernel crashes.

> 
> There is a second problem in the same loop: all areas are named
> "crashkernel", which breaks the CMA sysfs and debugfs entries when
> there are several. I've sent a separate fix for that:
> 
> https://lore.kernel.org/r/20261106104309.3669583-1-zaslonko@linux.ibm.com
> 

Thanks! I reviewed this now.

> Reviewed-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Tested-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> 

Thanks for testing and reviewing!

Usama

