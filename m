Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF491C5AD49
	for <kexec@archiver.kernel.org>; Wed, 28 May 2025 21:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TIs9A9vynPLs13u2u2i15iIW1/Si1viQD6ntfsowOjM=; b=EKg3jCNpTHhm9EP6D2vxk8GkqE
	pDCqxvVAhSEFM0Gh1CqFjJszLM0xkkJrFMjcpn1E1igEF9Mo8bc+1wmswNnSxNGpDiyTkcj+b674J
	juu3AV5Mgggncm06d9ny/LWrLCpiMHOJiw3/4BdU8i2ufpQYiFLlftlVfWf/j3RdxFcollinlWx4e
	DQhHwyRI6QRK8PtshD4BFgjvZvTljLwSVeBzmawKLc5BK/g1zW1h9nJErcTRWw0HD4khaCrhqSv8/
	grVLSUiY490NiO4IpdILOpTDiSzclews6IkytOw/cvK+ScLncS8ePXCd0oFGMyoipAdQw7+/U6Vyb
	w1K2FMzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKNtm-0000000E79l-20tG;
	Wed, 28 May 2025 21:01:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKNtf-0000000E79O-2rsu
	for kexec@lists.infradead.org;
	Wed, 28 May 2025 21:01:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748466070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TIs9A9vynPLs13u2u2i15iIW1/Si1viQD6ntfsowOjM=;
	b=Y0e2GwMgWZRoyDaKPF7vNBto2Odp7UVDM+trGdC4Srs5Z+UYO5zp3s7t/0Ozdcg21Ipu4Y
	NocKHSK4aiUMJuv98yGbLyC6f7oOCvKf+4ACSu1tCHVmlACL++QwlwVjjDSXcEkZlQaLo2
	gu4NcQhuZXpSibb7cvjmOaaheDJ6wEU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-uzLeFpj2N7iwI_0jN-AwCg-1; Wed, 28 May 2025 17:01:08 -0400
X-MC-Unique: uzLeFpj2N7iwI_0jN-AwCg-1
X-Mimecast-MFC-AGG-ID: uzLeFpj2N7iwI_0jN-AwCg_1748466067
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a360d01518so149579f8f.2
        for <kexec@lists.infradead.org>; Wed, 28 May 2025 14:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748466067; x=1749070867;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TIs9A9vynPLs13u2u2i15iIW1/Si1viQD6ntfsowOjM=;
        b=mtUOFfbP3qCLz6TeMgcz05qHa1RpDpxBy8dy0TG0H8wb7/F39fperpBydB9x9iLFRD
         nSFF74wnhIZQjwRbjdAXqiZ2FHi0eXihxC9bSqFVxk92G6FEUwagp/0NnfmRhahWvCHI
         VjK3aXiAMlBIMoFnv9OHcwEtuN5pGIeUgnLfgvXFE0Mxilv2wY+0sj5y8fzrDyHINL45
         /SSA3xtUnGGgSdh+Fwypc5fgcyAJjXgaE9WIQQOglWny3LcaLYopvGfDEOWQlwsZgC40
         3aebT2e8CgOoPlHkGbBkBgvqOtoxNKbjuB2UKuafmTGnhpic2zIxrh9xUzq1Aitcj/tf
         neHA==
X-Forwarded-Encrypted: i=1; AJvYcCVsK+lS7TcBl2WluiOCzUdIFoDzEr1oJT9nTUExXKQAxDcprFaCP02TflHQT4UY+xoIgZJypg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxrpB98zapDuvNMioiWaTdxOrGTBzpyFEYEV1FvcrPhbDJgeHXN
	y1F/LEo/htC7oPJbTRC7c3V9Gn+OOXmA4TSCysDTYSo6hu1FbQW4+sYmvdIgjUKF3el9V7cj6pt
	0BUN9piAWAe1aC83ldI6dBNNVVIs72mZQKH8HTFrssdzGiM0zvCJwrp4V3Yz45g==
X-Gm-Gg: ASbGnctxzNfVxxWDirLGmtsQ04/s1z8o4lVRFwIn07iuMlhPuPBhurGwwyFRj8hs97P
	THqCp3wfAklY5f1LySqTsMsoDCiIgqhcbhmq2R1DYWa0fAOfdj1tmbHFw3RoDqh4PURpQW4mcza
	bHFw2ckIDgdHLg55fjxwi1pN8ZRIDTRu5mCZ3c/STok0TiHanQ3c0V0m142RO3tZO/zHsps7QPV
	ILErWY3qeUX3kHYIVmrsvHRqSzoRKXcvwb8nqXioyOf2z8hH1Q5hl+G8MIGfPJ4/deEEJ6ct3s3
	ijSFBdjEyfh8nHvFER02aD8KyEiaFe3HAtvRFcQX44H29+vBoHDE
X-Received: by 2002:a05:6000:2387:b0:3a4:dc0a:5c03 with SMTP id ffacd0b85a97d-3a4dc0a6165mr9475839f8f.39.1748466067110;
        Wed, 28 May 2025 14:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2aSzMv+587qfcit7qgAR0ifeKexVR32zWh2tQ8kfWF2L5PbKACsL68zv6XZf17ToPcyld3g==
X-Received: by 2002:a05:6000:2387:b0:3a4:dc0a:5c03 with SMTP id ffacd0b85a97d-3a4dc0a6165mr9475783f8f.39.1748466066631;
        Wed, 28 May 2025 14:01:06 -0700 (PDT)
Received: from [192.168.3.141] (p57a1aa11.dip0.t-ipconnect.de. [87.161.170.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eacd7cb0sm2474818f8f.67.2025.05.28.14.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 14:01:06 -0700 (PDT)
Message-ID: <e9c5c247-85fb-43f1-9aa8-47d62321f37b@redhat.com>
Date: Wed, 28 May 2025 23:01:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
To: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Jiri Bohac <jbohac@suse.cz>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
 Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <dhildenb@redhat.com>,
 Michal Hocko <mhocko@suse.cz>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
 <427fec88-2a74-471e-aeb6-a108ca8c4336@redhat.com>
 <Z8Z/gnbtiXT9QAZr@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z8Z/gnbtiXT9QAZr@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -UmaQ1EaIKdKpYyBxxAsoK9LXZNliZdgwtRjWeLAy6s_1748466067
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_140111_817291_8D569243 
X-CRM114-Status: GOOD (  25.03  )
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

On 04.03.25 05:20, Baoquan He wrote:
> On 03/03/25 at 09:17am, Donald Dutile wrote:
>>
>>
>> On 3/3/25 3:25 AM, David Hildenbrand wrote:
>>> On 20.02.25 17:48, Jiri Bohac wrote:
>>>> Hi,
>>>>
>>>> this series implements a way to reserve additional crash kernel
>>>> memory using CMA.
>>>>
>>>> Link to the v1 discussion:
>>>> https://lore.kernel.org/lkml/ZWD_fAPqEWkFlEkM@dwarf.suse.cz/
>>>> See below for the changes since v1 and how concerns from the
>>>> discussion have been addressed.
>>>>
>>>> Currently, all the memory for the crash kernel is not usable by
>>>> the 1st (production) kernel. It is also unmapped so that it can't
>>>> be corrupted by the fault that will eventually trigger the crash.
>>>> This makes sense for the memory actually used by the kexec-loaded
>>>> crash kernel image and initrd and the data prepared during the
>>>> load (vmcoreinfo, ...). However, the reserved space needs to be
>>>> much larger than that to provide enough run-time memory for the
>>>> crash kernel and the kdump userspace. Estimating the amount of
>>>> memory to reserve is difficult. Being too careful makes kdump
>>>> likely to end in OOM, being too generous takes even more memory
>>>> from the production system. Also, the reservation only allows
>>>> reserving a single contiguous block (or two with the "low"
>>>> suffix). I've seen systems where this fails because the physical
>>>> memory is fragmented.
>>>>
>>>> By reserving additional crashkernel memory from CMA, the main
>>>> crashkernel reservation can be just large enough to fit the
>>>> kernel and initrd image, minimizing the memory taken away from
>>>> the production system. Most of the run-time memory for the crash
>>>> kernel will be memory previously available to userspace in the
>>>> production system. As this memory is no longer wasted, the
>>>> reservation can be done with a generous margin, making kdump more
>>>> reliable. Kernel memory that we need to preserve for dumping is
>>>> never allocated from CMA. User data is typically not dumped by
>>>> makedumpfile. When dumping of user data is intended this new CMA
>>>> reservation cannot be used.
>>>
>>>
>>> Hi,
>>>
>>> I'll note that your comment about "user space" is currently the case, but will likely not hold in the long run. The assumption you are making is that only user-space memory will be allocated from MIGRATE_CMA, which is not necessarily the case. Any movable allocation will end up in there.
>>>
>>> Besides LRU folios (user space memory and the pagecache), we already support migration of some kernel allocations using the non-lru migration framework. Such allocations (which use __GFP_MOVABLE, see __SetPageMovable()) currently only include
>>> * memory balloon: pages we never want to dump either way
>>> * zsmalloc (->zpool): only used by zswap (-> compressed LRU pages)
>>> * z3fold (->zpool): only used by zswap (-> compressed LRU pages)
>>>
>>> Just imagine if we support migration of other kernel allocations, such as user page tables. The dump would be missing important information.
>>>
>> IOMMUFD is a near-term candidate for user page tables with multi-stage iommu support with going through upstream review atm.
>> Just saying, that David's case will be a norm in high-end VMs with performance-enhanced guest-driven iommu support (for GPUs).
> 
> Thank both for valuable inputs, David and Don. I agree that we may argue
> not every system have ballon or enabling swap for now, while future
> extending of migration on other kernel allocation could become obstacle
> we can't detour.
> 
> If we have known for sure this feature could be a bad code, we may need
> to stop it in advance.

Sorry for the late reply.

I think we just have to be careful to document it properly -- especially 
the shortcomings and that this feature might become a problem in the 
future. Movable user-space page tables getting placed on CMA memory 
would probably not be a problem if we don't care about ... user-space 
data either way.

The whole "Direct I/O takes max 1s" part is a bit shaky. Maybe it could 
be configurable how long to wait? 10s is certainly "safer".

But maybe, in the target use case: VMs, direct I/O will not be that common.

-- 
Cheers,

David / dhildenb


