Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B02CAC5B8
	for <kexec@archiver.kernel.org>; Mon,  6 Oct 2025 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S1zkgvROQPB9KO98BQ/Xir7j7NOcJi9fySuExxZFR9I=; b=OkyEfh+LH3/fGZhVqYXM6mKJwe
	Lo8xdEhA/lHhslqjNgIKM5sbkqXXIFCFG9esWA05LJyEAikcOu1tR7p4DRgxySv8ltIUt5nXxrYCd
	mSIe8JMrjVK/UPyQDyCQu83KLdt0QpSBmIANGRkORwHULzc5zueXhHpz5oXZ+xSquMUlyvAiWfqs7
	VPB67yDZg9CsoReJSM/OarPhp5Cg6SaQaw3ZJpedGhDJkmfz0ylh88d+fB7YnJqv8/xnKPL51NB0L
	rvBNpM/06mY4v/+5Odfjfc0vY0CY6O4g2K3EIdNPBcTCT6wzmx7mZ/XAlIsrkiI9/MabzIXkN+I9v
	bc3XhatQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5oKx-00000000RUg-3zV0;
	Mon, 06 Oct 2025 16:45:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5oKt-00000000RT8-3pFZ
	for kexec@lists.infradead.org;
	Mon, 06 Oct 2025 16:45:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759769118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1zkgvROQPB9KO98BQ/Xir7j7NOcJi9fySuExxZFR9I=;
	b=FGDBjT2Ye2bJJVe4PO42DRPAaeeR9hHK2USVyiB314p6pmL1ZVOmylFpiZbo4ZJMPQ/LTw
	sVWqaOCyooH9j0poFro+LGufULHSJPcDnPtoSEZiYrgn94ZyaOxG3Dpg8mZUHofNIRg/ms
	bUopLm6FAW930wXxA3rEpGscicr5H8Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-YQ7pvw3-Mx6Ilae7l2K-Pg-1; Mon, 06 Oct 2025 12:45:16 -0400
X-MC-Unique: YQ7pvw3-Mx6Ilae7l2K-Pg-1
X-Mimecast-MFC-AGG-ID: YQ7pvw3-Mx6Ilae7l2K-Pg_1759769115
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3ef2dd66so26505655e9.1
        for <kexec@lists.infradead.org>; Mon, 06 Oct 2025 09:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769115; x=1760373915;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1zkgvROQPB9KO98BQ/Xir7j7NOcJi9fySuExxZFR9I=;
        b=XLOkErEKZ2lwhO2HRvRbmsCrCqxFiXE25Y0htSBUXXaX8lgkAPDxA+Hdp4c77BbgFS
         h5j9OBxYIEccDHxmzr6ypNl8EFNYyQKvP6ZS8kallh4DsJ2wgkhR8+3AjGrvvt+V/fj5
         YW3/d9Nj5iJC3II9pLjS8ILw7zJSkCQnnoUuUfE+fD/syYuK52vL9eN0iIhgrXx95FHp
         s/wEnV04mhylt5CSH/V2n9Xzw6v9eKb4/5vtb5g/atTXrys4Xc4pJjpdvXAZbV0bPD6h
         Vl+RqBNoUBvZHvcQkfFSvmVNFCDp7/n672Q1qgtHa11dltT0nMqJ07U2H2HpekSHDGmF
         0Ljg==
X-Forwarded-Encrypted: i=1; AJvYcCXAr8zz251ddZTjGcnxk1Pc/a/3DHRTj2EAD5GmjURO3L4F5+LtFM/ETgZ9UNaT5A6YpsORoQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwhrIAOPjxEvheIyqyCjoVY+WcMLaCuf1kyAGpDocNpq1z/mZRm
	1cUyd08myi2KALy9VsMiIjc7i9vsM6AS4U65KLVOtOIF6mGccV2ef1Q6D7LVDGp8ndPAA4dN7EW
	bwuhluhfYMpdxfpNjVq+/gIctqYF8+ri5VE6OVe5XJN1TUieTc3W4Vy/nkMyfYA==
X-Gm-Gg: ASbGncu5qs/zfCuCAMYPGPQ6du4jqqmIQzv5fO8Hj8JaNnB0QRgHNgKm4FcyGCT1uL5
	XgXZPBxW4UNrac6QthYPZH3X13t/ebr0fO5pmDA4XPhTbLlVHcRvJPyfEhH3OE+DeKUCVMCvL6g
	tUJ9xvCGhUEtC70wIybCY9HM1Wf5rqej91DUFf69u6Zo73RUNgt1xlAzzd4v/s+3/K8XhLLCTC7
	YLF/jmFwAeXessj+HbISEzVifv8WTLxPw5pc2FHUqUljzQ8E12BUM8fKotXBqV6deXMt2amjKhh
	nxtqOU7jyow3QTilBlSGV0JDbVRgBxZZPUJkYxNc4ZB6NuRji2wAw4WcUhud53UcdZxtsw+JIV5
	I1pg+bXPEZLBu
X-Received: by 2002:a05:600c:6610:b0:46e:711c:efe9 with SMTP id 5b1f17b1804b1-46fa29c82f3mr2420385e9.13.1759769115287;
        Mon, 06 Oct 2025 09:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtCTJxXouzehZZZSHbIIjnOfoG74tnDFyVirErdt4lQ1cDyHjbGNh4RIvx+jcKsiY2ad2sLA==
X-Received: by 2002:a05:600c:6610:b0:46e:711c:efe9 with SMTP id 5b1f17b1804b1-46fa29c82f3mr2420135e9.13.1759769114734;
        Mon, 06 Oct 2025 09:45:14 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72374b8dsm184375445e9.19.2025.10.06.09.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 09:45:14 -0700 (PDT)
Message-ID: <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com>
Date: Mon, 6 Oct 2025 18:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
To: Breno Leitao <leitao@debian.org>, kas@kernel.org
Cc: Jiri Bohac <jbohac@suse.cz>, riel@surriel.com, vbabka@suse.cz,
 nphamcs@gmail.com, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, akpm@linux-foundation.org,
 Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>
 <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
From: David Hildenbrand <dhildenb@redhat.com>
In-Reply-To: <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zl0bTQDs6vRKjDEN4EW9Jc2hXvTK27TdraJ92AO-1cc_1759769115
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_094520_025970_B7049BEB 
X-CRM114-Status: GOOD (  27.92  )
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

On 06.10.25 18:25, Breno Leitao wrote:
> On Mon, Oct 06, 2025 at 10:16:26AM +0200, David Hildenbrand wrote:
>> On 03.10.25 17:51, Breno Leitao wrote:
>>> Hello Jiri,
>>>
>>> On Thu, Jun 12, 2025 at 12:11:19PM +0200, Jiri Bohac wrote:
>>>
>>>> Currently this is only the case for memory ballooning and zswap. Such movable
>>>> memory will be missing from the vmcore. User data is typically not dumped by
>>>> makedumpfile.
>>>
>>> For zswap and zsmalloc pages, I'm wondering whether these pages will be missing
>>> from the vmcore, or if there's a possibility they might be present but
>>> corrupted—especially since they could reside in the CMA region, which may be
>>> overwritten by the kdump environment.
>>
>> That's not different to ordinary user pages residing on these areas, right?
> 
> Will zsmalloc on CMA pages be marked as "userpages"?

No, but they should have the zsmalloc page type set.

> 
> makedump file iterates over the pfns and check for a few flags before
> "copying" them to disk.
> 
> In makedumpfile, userpages are basically discarded if they are anonymous
> pages:
> 	#define isAnon(mapping, flags, _mapcount) \
> 		(((unsigned long)mapping & PAGE_MAPPING_ANON) != 0 && !isSlab(flags,
> 		_mapcount))
> 
> 	https://github.com/makedumpfile/makedumpfile/blob/master/makedumpfile.h#L164
> 
> 	called from:
> 	https://github.com/makedumpfile/makedumpfile/blob/master/makedumpfile.c#L6671
> 
> For zsmalloc pages in the CMA, The page struct (pfn)) is marked with old
> page struct (from the first kernel), but, the content has changed
> (replaced by kdump environment - 2nd kernel).
> 
> So, whatever decision makedumpfile does based on the PFN, it will dump
> incorrect data, given that the page content does not match the data
> anymore.

Right.

> 
> If my understanding is valid, we don't want to dump any page that points
> to the PFN, because they will probably have garbage.

My theory is that barely anybody will go ahead and check compressed page 
content, but I agree. We should filter them out.

> 
> That said, I see two options:
> 
>   1) Ignore the CMA area completely in makedump.
>      - I don't think there is any way to find that area today. The kernel
>        might need to print the CMA region somewhere (/proc/iomem?)

/proc/iomem in the newkernel should indicate the memory region as System 
RAM (for the new kernel). That can just be filtered out in any case: 
dumping memory of the new kernel does not make sense in any case.

> 
>   2) Given that most of the memory in CMA will be anonymous memory, and
>      already discard by other rules, just add an additional entry for
>      zsmalloc pages.
> 
>      Talking to Kirill offline, it seems we can piggy back on MovableOps
>      page flag.

We should likely check the page type instead if we go down that path.

-- 
Cheers

David / dhildenb


