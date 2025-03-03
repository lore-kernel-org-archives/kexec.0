Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4172C282CD
	for <kexec@archiver.kernel.org>; Mon,  3 Mar 2025 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wpjej3MTc3XOacT0vWjYbsIvrY+TVNTNDbp8vW97joQ=; b=U6wVjBxQnTV82TEncCYprNvIWJ
	ZG34dVxVQ+FL3sQ42pp4HsJTcKJ9NW7bxmL9rORRv1ivQs5ib1qr0Mysb7wyi+Y+scBsJRBxDcgth
	FMaP2AACKX+Fdk2zfYdzZkVG2jXWe96dVPt8HIfuVWPnH6Nbg33uJ0tCnDtJBIPuHJXQj5CnqTO36
	6HGnu9AJMeCCaFWggvb9RbJVcRdoccTOKiX60eyaTNpsv7ojVrXRuhS7MwiyfRaf+W9hDk1VW/Vac
	Lilie5eDHEEAFD4SUBi4zpLmsW5yeDkIelqgIJirLG64J1CC9JhsP6q3Z+WE4A73qIIulMdE4i5db
	Gd0PRW5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp6qQ-0000000178w-3V43;
	Mon, 03 Mar 2025 14:32:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tp6dn-000000014dE-31e7
	for kexec@lists.infradead.org;
	Mon, 03 Mar 2025 14:19:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741011569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wpjej3MTc3XOacT0vWjYbsIvrY+TVNTNDbp8vW97joQ=;
	b=S7R0GmTEapAvMsBqXi/Q8CNhMYJB1h4Cjt1hwsid2wSLzVgqpqdLO2HQXviiT61r6f2CKc
	Czdx5aKSV5nnYeYdzg6uMcZqTbhxL0EVXAxB2qCRkE7IYXdVS56mp1Ba6NST8cLB2JTrYV
	1b15UYMi528ldR+ZnJUj6g+ixRTUIgQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-vtBZvPF0Oy21NswMonRmqg-1; Mon, 03 Mar 2025 09:17:56 -0500
X-MC-Unique: vtBZvPF0Oy21NswMonRmqg-1
X-Mimecast-MFC-AGG-ID: vtBZvPF0Oy21NswMonRmqg_1741011476
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8a1eb7148so65359416d6.1
        for <kexec@lists.infradead.org>; Mon, 03 Mar 2025 06:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741011476; x=1741616276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpjej3MTc3XOacT0vWjYbsIvrY+TVNTNDbp8vW97joQ=;
        b=tK510QEjC56Vq6tbNqzjUksoBDuoHW0lIF/NhHZV1xDh0guhZoKM12u6I16/Jes9cV
         GgVbleT04NjPDg6QvXxDH57Rol/wgzPpeS0QMqE9v8bu3GbZdFKy6zqX2hWu/ZzJYMc5
         Co0Me5YWgR6hgSn9Rg1HoAcUVJ/u3KWNdv6WIiDX5cfinCDYkOveN7iZMVpUzzpSZgW0
         Zc9ktRe4LCaLTIOozqD5HBLgmuWHZ0K6S7ZgHBzfvS94pp1K/ueF0Awckz60VhhzhXwy
         /hGLExw7ijHY4urKhDFMFIS46YxOiguzShUVtJA5g6EH+a93r4ZxZ0xlr+THvT5xVoRg
         LCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBmSfimdGHyuaFtdw3TRK44EdBlNt2Q7Ucz0w39lKVV+xHVX1zw1/AYNf52GqoSwMDGLqbqQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzJ9piONkP37kggiJKzSnSAqqM+8IFVw7vAiYANmOsK5R0dLasM
	KQv8Xzdo2Cvf16QjRClJQyFYB0Y5QVo7h3aeqKw7u3OQw/I0vjaxFzkDJKlWpDHHGF2RGiyldcV
	x5JJydLmbdG2olJHgi6BiGC1Es8DV8S8+3l6PxzLv+GAuWU74c/h4JzyOSg==
X-Gm-Gg: ASbGncv/WCTpGlfWlglwEfce3EFK1YoRKlJw0cDVByT+upxVKtSGql+R8x/7mVSsCM4
	fPFKJo0m9u3UlEXote4i7TujURuUKhcrPESoLfYtznvqyig+AqcYvPbNPMRNESSePluMQT/w7jZ
	Mg6l71q14dp11oRqpKEi85jDnuDvzAGyQOP01gygvuwIWvaJ/f9ylmy/X583FQcodGL7FPzvZHa
	mRVpmN3T9bo+lcEOz3r12QrIOh9qZmadOzj6+JY0POhvkMbIWaW6q7cq3ElCIto6oQp03ZxBZpe
	oogo9dRdodbqq4j4
X-Received: by 2002:ad4:596c:0:b0:6e4:4012:b6f1 with SMTP id 6a1803df08f44-6e8a0c87aadmr199731326d6.3.1741011475931;
        Mon, 03 Mar 2025 06:17:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmuW2YklpwiY35WaKDpDsU1ARThxbZZn04wnIPZGm7kflmoV5fmkgK0Cghft8CcoGbqMJqGg==
X-Received: by 2002:ad4:596c:0:b0:6e4:4012:b6f1 with SMTP id 6a1803df08f44-6e8a0c87aadmr199730956d6.3.1741011475548;
        Mon, 03 Mar 2025 06:17:55 -0800 (PST)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897661633sm53378136d6.58.2025.03.03.06.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:17:55 -0800 (PST)
Message-ID: <427fec88-2a74-471e-aeb6-a108ca8c4336@redhat.com>
Date: Mon, 3 Mar 2025 09:17:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
To: David Hildenbrand <david@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Pingfan Liu <piliu@redhat.com>,
 Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <dhildenb@redhat.com>, Michal Hocko <mhocko@suse.cz>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5TPCXOkdybbk6MvrMOFMsSBge1N3eQ2dl0AQoXs_clc_1741011476
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_061931_842365_896947E4 
X-CRM114-Status: GOOD (  34.89  )
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



On 3/3/25 3:25 AM, David Hildenbrand wrote:
> On 20.02.25 17:48, Jiri Bohac wrote:
>> Hi,
>>
>> this series implements a way to reserve additional crash kernel
>> memory using CMA.
>>
>> Link to the v1 discussion:
>> https://lore.kernel.org/lkml/ZWD_fAPqEWkFlEkM@dwarf.suse.cz/
>> See below for the changes since v1 and how concerns from the
>> discussion have been addressed.
>>
>> Currently, all the memory for the crash kernel is not usable by
>> the 1st (production) kernel. It is also unmapped so that it can't
>> be corrupted by the fault that will eventually trigger the crash.
>> This makes sense for the memory actually used by the kexec-loaded
>> crash kernel image and initrd and the data prepared during the
>> load (vmcoreinfo, ...). However, the reserved space needs to be
>> much larger than that to provide enough run-time memory for the
>> crash kernel and the kdump userspace. Estimating the amount of
>> memory to reserve is difficult. Being too careful makes kdump
>> likely to end in OOM, being too generous takes even more memory
>> from the production system. Also, the reservation only allows
>> reserving a single contiguous block (or two with the "low"
>> suffix). I've seen systems where this fails because the physical
>> memory is fragmented.
>>
>> By reserving additional crashkernel memory from CMA, the main
>> crashkernel reservation can be just large enough to fit the
>> kernel and initrd image, minimizing the memory taken away from
>> the production system. Most of the run-time memory for the crash
>> kernel will be memory previously available to userspace in the
>> production system. As this memory is no longer wasted, the
>> reservation can be done with a generous margin, making kdump more
>> reliable. Kernel memory that we need to preserve for dumping is
>> never allocated from CMA. User data is typically not dumped by
>> makedumpfile. When dumping of user data is intended this new CMA
>> reservation cannot be used.
> 
> 
> Hi,
> 
> I'll note that your comment about "user space" is currently the case, but will likely not hold in the long run. The assumption you are making is that only user-space memory will be allocated from MIGRATE_CMA, which is not necessarily the case. Any movable allocation will end up in there.
> 
> Besides LRU folios (user space memory and the pagecache), we already support migration of some kernel allocations using the non-lru migration framework. Such allocations (which use __GFP_MOVABLE, see __SetPageMovable()) currently only include
> * memory balloon: pages we never want to dump either way
> * zsmalloc (->zpool): only used by zswap (-> compressed LRU pages)
> * z3fold (->zpool): only used by zswap (-> compressed LRU pages)
> 
> Just imagine if we support migration of other kernel allocations, such as user page tables. The dump would be missing important information.
> 
IOMMUFD is a near-term candidate for user page tables with multi-stage iommu support with going through upstream review atm.
Just saying, that David's case will be a norm in high-end VMs with performance-enhanced guest-driven iommu support (for GPUs).

> Once that happens, it will become a lot harder to judge whether CMA can be used or not. At least, the kernel could bail out/warn for these kernel configs.
> 
I don't think the aforementioned focus is to use CMA, but given its performance benefits, it won't take long to be the next perf improvement step taken.

>>
>> There are five patches in this series:
>>
>> The first adds a new ",cma" suffix to the recenly introduced generic
>> crashkernel parsing code. parse_crashkernel() takes one more
>> argument to store the cma reservation size.
>>
>> The second patch implements reserve_crashkernel_cma() which
>> performs the reservation. If the requested size is not available
>> in a single range, multiple smaller ranges will be reserved.
>>
>> The third patch updates Documentation/, explicitly mentioning the
>> potential DMA corruption of the CMA-reserved memory.
>>
>> The fourth patch adds a short delay before booting the kdump
>> kernel, allowing pending DMA transfers to finish.
> 
> 
> What does "short" mean? At least in theory, long-term pinning is forbidden for MIGRATE_CMA, so we should not have such pages mapped into an iommu where DMA can happily keep going on for quite a while.
> 
Hmmm, in the case I mentioned above, should there be a kexec hook in multi-stage IOMMU support for the hypervisor/VMM to invalidate/shut-off stage 2 mappings asap (a multi-microsecond process) so
DMA termination from VMs is stunted ?  is that already done today (due to 'simple', single-stage, device assignment in a VM)?

> But that assumes that our old kernel is not buggy, and doesn't end up mapping these pages into an IOMMU where DMA will just continue. I recall that DRM might currently be a problem, described here [1].
> 
> If kdump starts not working as expected in case our old kernel is buggy, doesn't that partially destroy the purpose of kdump (-> debug bugs in the old kernel)?
> 
> 
> [1] https://lore.kernel.org/all/Z6MV_Y9WRdlBYeRs@phenom.ffwll.local/T/#u
> 


