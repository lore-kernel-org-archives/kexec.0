Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47DFD3C53F
	for <kexec@archiver.kernel.org>; Fri, 18 Oct 2024 03:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ObKOR6Iqaxc7in9bK0wu5G/boJvB09a159NsUivmab4=; b=Hb8zWkLWsAS/AY
	eodUakId465A1UKhMXCSY3bueSq6Yadeajpj5pKKBqXj9ds0AVnuCJo37+SGdtBnJ16EElcizMo2P
	kg+vNsw5JN1pkCV7WfZxLWgY1+ZnCGSO+TOD1tb+4Y+PZgr0k2+o0poFMAyFbOovB37Hdab9d3uN8
	QHN5bSVSfUMLQ8KeY7xHPU+ilNk84iCTLAjFL2nUaOP7aNeoBmN9b8JQQfTuCa5QzxkvUMe5vJlxh
	hGEmhvfZ/2DBaUtXrPn+HLTkSXTvB0UDXXkgw75gd8YmY4rjkXPaPtOyQaO/neh9PEYSxUd5n33kM
	Zpyli06NNh41gfecfIcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1dEK-0000000GjhT-3v8q;
	Fri, 18 Oct 2024 03:00:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1dEH-0000000Gjfp-0rug
	for kexec@lists.infradead.org;
	Fri, 18 Oct 2024 03:00:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729220440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+PqcdpWNS4u7ZHFgo8/hLkbYu5t2LAmdihHzmnrPdo=;
	b=Ycs27AlHHtHvM8ZfaiMiczYrGKD5hMS0/PN5Od2G42D4fbCU/etx175ysntQDhvGBdRKtQ
	WnroIgfN/ZoRyU2FQAvnX0N08fsXnheuC0cp1e+guIalEl16/FlEPxSk27meLAW2jK4Xqo
	lzV+nH67QWUA2LpKIY/tJqCypB0t0kk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-15MAYLMPP6OTtrhbesPwiw-1; Thu,
 17 Oct 2024 23:00:36 -0400
X-MC-Unique: 15MAYLMPP6OTtrhbesPwiw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5F2C195608B;
	Fri, 18 Oct 2024 03:00:32 +0000 (UTC)
Received: from localhost (unknown [10.72.112.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08F5A19560A3;
	Fri, 18 Oct 2024 03:00:29 +0000 (UTC)
Date: Fri, 18 Oct 2024 11:00:23 +0800
From: Baoquan He <bhe@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 19/57] crash: Remove PAGE_SIZE compile-time
 constant assumption
Message-ID: <ZxHPR+Et8VyeD8uI@MiWiFi-R3L-srv>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-19-ryan.roberts@arm.com>
 <Zw3luHGG3LqHge2m@MiWiFi-R3L-srv>
 <2e561511-ab20-4aa9-9b92-bd6ac6678087@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2e561511-ab20-4aa9-9b92-bd6ac6678087@arm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_200041_348874_8F18979C 
X-CRM114-Status: GOOD (  28.06  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 10/15/24 at 12:13pm, Ryan Roberts wrote:
> On 15/10/2024 04:47, Baoquan He wrote:
> > On 10/14/24 at 11:58am, Ryan Roberts wrote:
> >> To prepare for supporting boot-time page size selection, refactor code
> >> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> >> intended to be equivalent when compile-time page size is active.
> >>
> >> Updated BUILD_BUG_ON() to test against limit.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>
> >> ***NOTE***
> >> Any confused maintainers may want to read the cover note here for context:
> >> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> >>
> >>  kernel/crash_core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> >> index 63cf89393c6eb..978c600a47ac8 100644
> >> --- a/kernel/crash_core.c
> >> +++ b/kernel/crash_core.c
> >> @@ -465,7 +465,7 @@ static int __init crash_notes_memory_init(void)
> >>  	 * Break compile if size is bigger than PAGE_SIZE since crash_notes
> >>  	 * definitely will be in 2 pages with that.
> >>  	 */
> >> -	BUILD_BUG_ON(size > PAGE_SIZE);
> >> +	BUILD_BUG_ON(size > PAGE_SIZE_MIN);
> > 
> > This should be OK. While one thing which could happen is if selected size
> > is 64K, PAGE_SIZE_MIN is 4K, it will issue a false-positive warning when
> > compiling while actual it's not a problem during running. 
> 
> PAGE_SIZE can only ever be bigger than PAGE_SIZE_MIN if compiling a "boot-time
> page size" build. And in this case, you need to know that size is small enough
> to work with any of the boot-time selectable page sizes. Since size
> (=sizeof(note_buf_t)) is invariant to PAGE_SIZE, we can do this by checking
> against PAGE_SIZE_MIN.
> 
> So I don't think this could ever lead to a false-positive.

Makes sense, thanks for your explanation.
> 
> 
> Not sure if
> > that could happen on arm64. Anyway, we can check the crash_notes to get
> > why it's so big when it really happens. So,
> > 
> > Acked-by: Baoquan He <bhe@redhat.com>
> 
> Thanks!
> 
> > 
> >>  
> >>  	crash_notes = __alloc_percpu(size, align);
> >>  	if (!crash_notes) {
> >> -- 
> >> 2.43.0
> >>
> >>
> > 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
