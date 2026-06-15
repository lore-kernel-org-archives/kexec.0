Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15962CD98C5
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zhn4u/RwBJCsFuRZh4UxfYwkjfJ/s+9iZ2A4f5NGClw=; b=KVHeTAk/OIZJxtMTdf1r3cfmvy
	Vlk1DhzoSP6J1KwfPmzg/3MTXze4JHs+kmTUyx89PpbCQLgz6NmHqpGD2iGIq7CL7tWu7+7J6HXba
	AR1KLC8kcGpesfA57XUGOkXPMtOxnJgRAcej8czB6P5Hi63qu+Yt5qzft16Q6B7Plnpwe6oFjRX5E
	gSiCNApogK8feTqDe7QUenOZff2FPdeo+Ocw0qH7CGc16FHA/iw4eJ5DQo1rbuyIKobnA3LV5urB2
	WovCewCQo3NDuPg5xt3Eq45WKfFR+a1N8ytHo7t7gEXvdHHQT+ipRs0+GbISRgA3aq3OcDrTmFDf0
	SNdDe1Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ759-0000000EGRd-0JET;
	Mon, 15 Jun 2026 13:10:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ757-0000000EGRV-1XvI
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 13:10:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6BA1F440DD;
	Mon, 15 Jun 2026 13:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C801F00A3A;
	Mon, 15 Jun 2026 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781529024;
	bh=zhn4u/RwBJCsFuRZh4UxfYwkjfJ/s+9iZ2A4f5NGClw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=OTp+cZD6od+PGRGK3BsiGmIDrbHRl9RqcfqylKucq9Rr173WM+mKyKehY0QuC7R5L
	 zCITEeW5dzVI/I0u9S/xPs8Zuu6PEHHzV9M7aFVptWQiNENNU5UKSUESbAGJ181TLm
	 1w6ghvd2FznDE21Q1264xHJya8xsrgZy9zl9hV3GiKV/VAMhGhNzl5c29eahM1tOfM
	 Qlh2CqHFhkwNR0EQVI2BPme2DpIJYkChENsjJ7hWYYsax8I/p2zKdBFGfPF6GgWuIg
	 ntkW1H7q54VD4TEVOQT/BXiCSJS0BeG5SKdbmkMvr5QZOnU1dwYFOqUCNDT2d/7Rhg
	 A9cdSxqH1UH1Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/18] kho: return virtual address of mem_map
In-Reply-To: <178143855111.2123877.6067087545413454825.b4-review@b4> (Mike
	Rapoport's message of "Sun, 14 Jun 2026 15:02:31 +0300")
References: <20260605183501.3884950-1-pratyush@kernel.org>
	<20260605183501.3884950-4-pratyush@kernel.org>
	<178143855111.2123877.6067087545413454825.b4-review@b4>
Date: Mon, 15 Jun 2026 15:10:21 +0200
Message-ID: <2vxz7bo0q79e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Sun, Jun 14 2026, Mike Rapoport wrote:

> On Fri, 05 Jun 2026 20:34:36 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index e8454dc5b489..d8dd0ede4f87 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -521,7 +522,11 @@ static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
>>  		return 0;
>
> sashiko:
>
>   Does this error path need to be updated to return NULL?
>   Since the function signature was changed to return a void pointer
>   instead of phys_addr_t, returning a plain integer 0 instead of NULL
>   might trigger static analysis warnings.

Good catch, will fix.

>
>> @@ -1668,8 +1672,8 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>>  		goto unmap_fdt;
>>  	}
>>  
>> -	mem_map_phys = kho_get_mem_map_phys(fdt);
>> -	if (!mem_map_phys)
>> +	mem_map = kho_get_mem_map(fdt);
>> +	if (!mem_map)
>
> Here we can't use mem_map as an actual pointer because phys_to_virt()
> returns pre-KASLR addres.

Ugh, yeah. It also won't work on ARM64 because memstart_addr is not set
at this point.

>
> Since we only call get_mem_map() here to verify that it's available in
> the FDT and don't care about the actual virtual address, let's add a
> comment about that, drop the mem_map varialble and directly check
>
> 	if (!kho_get_mem_map_phys())

Makes sense. Will do.

-- 
Regards,
Pratyush Yadav

