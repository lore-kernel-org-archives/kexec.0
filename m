Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9191EDB7F6
	for <kexec@archiver.kernel.org>; Tue,  7 Apr 2026 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XhI2ZtNaa3WGy+PoC0/JjFHL9yU5zThKY4urO3lDB84=; b=mpt/CSTPMYhEYzmYL9IllOMeIB
	yxmNLs0J1DwOxelk4wzhIIqbF+JDo9p95saTNbL2DpmJyAEB+u5aQ14YpHFi6eQsPMeok2gu5YF9t
	7Xe1Wby+1V+GVmplAJDsqQSb0eXKEtxK8cTBs6Z1rp+eLfGg+ru27o6m+4Jb3nJX86Yl4ea8qLhj2
	rykss1zRYmcqw1KqGKkq3Sn5tzwjOD2jEJmk9MoWjq8FheZ1MryWQUq9mbxiYsvH7Ymu4pQwudgI9
	OQVROA2f7OABZK8nFHdbQXCxUNWUyFCMiMOCUMb5WoXiekEV1rZZgbSRBg+S3yFtD2NLttg9qvR+l
	uv4t7BbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA465-00000006LPf-0j5E;
	Tue, 07 Apr 2026 10:55:53 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA462-00000006LPG-1Tvb
	for kexec@lists.infradead.org;
	Tue, 07 Apr 2026 10:55:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 37E1C43775;
	Tue,  7 Apr 2026 10:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AC4C116C6;
	Tue,  7 Apr 2026 10:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775559349;
	bh=DxuZSc3v1tSfQiDDs//E7vQOyQAhy+CLZFc51VXzKJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XechboWmrDEra1UKD/89mEc9VgqVKZx3trOiVrC2/tPXI8bAdnlaWYBhgZLst0KcG
	 pv/reEJAnUvUsgWWsJ5FcBt0hpoLloMwlvhP366kBM3swg2PNDA1w5sJPF0hV0grIA
	 1LmTg9zM+dEjCq/zebv3ikJrelbboAOUtySOSIE9p8LrHLrQ/So4OkLKg6DzcCBWtN
	 FcMrcMKD64JBsZztcunV4e1hnvpWSrYrlccRqXGQKx/lpvat9sFX+KHRBqcotVpE57
	 dt2LuTyKYFxNonlTsFkFkTZmeMEOZE6p91pZ6k+IweMUdSTBBpY/FjTzHtMryDjPES
	 fK5xLlehLs90A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Michal Clapinski <mclapinski@google.com>,  Evangelos Petrongonas
 <epetron@amazon.de>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Samiullah Khawaja <skhawaja@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 1/3] kho: make kho_scratch_overlap usable outside
 debugging
In-Reply-To: <abptg2AObfxkkxKf@kernel.org> (Mike Rapoport's message of "Wed,
	18 Mar 2026 11:16:51 +0200")
References: <20260317141534.815634-1-mclapinski@google.com>
	<20260317141534.815634-2-mclapinski@google.com>
	<abptg2AObfxkkxKf@kernel.org>
Date: Tue, 07 Apr 2026 10:55:45 +0000
Message-ID: <2vxz1pgravke.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_035550_487950_2E7365E6 
X-CRM114-Status: GOOD (  11.77  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Mar 18 2026, Mike Rapoport wrote:

> Hi Michal,
>
> On Tue, Mar 17, 2026 at 03:15:32PM +0100, Michal Clapinski wrote:
>> Also return false if kho_scratch is NULL.
>> 
[...]
>> diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
>> index d2f779cbe279..dc352839ccf0 100644
>> --- a/kernel/liveupdate/Makefile
>> +++ b/kernel/liveupdate/Makefile
>> @@ -7,7 +7,6 @@ luo-y :=								\
>>  		luo_session.o
>>  
>>  obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
>> -obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
>>  obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
>>  
>>  obj-$(CONFIG_LIVEUPDATE)		+= luo.o
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index 532f455c5d4f..c9b982372d6e 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -820,7 +820,8 @@ int kho_preserve_folio(struct folio *folio)
>>  	const unsigned long pfn = folio_pfn(folio);
>>  	const unsigned int order = folio_order(folio);
>>  
>> -	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
>> +	if (WARN_ON(kho_scratch_overlap_debug(pfn << PAGE_SHIFT,
>> +					      PAGE_SIZE << order)))
>
> Can't say I'm fond of kho_scratch_overlap_debug(). How about we make it
>
> 	if (IS_ENABLED(CONFIG_KEXEC_HANDOVER_DEBUG) &&
> 	    WARN_ON(kho_scratch_overlap(...)) 

+1. And we can get rid of kexec_handover_debug.c, for now at least. We
can add it back when we have something else to put in there.

>
>>  		return -EINVAL;
>>  
>>  	return kho_radix_add_page(tree, pfn, order);
[...]

-- 
Regards,
Pratyush Yadav

