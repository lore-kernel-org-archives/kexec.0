Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991EFC282C5
	for <kexec@archiver.kernel.org>; Mon,  3 Mar 2025 08:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xQJa5hq33EwCeIlC6ZAKrgfFf28o5I5tCi+O9hYDtj8=; b=RwuzhZy0ufKLb4mNr7KQK8zZD5
	BNXT60304o/nfYhYB4pnt3DebQcQGJk8oldPtlY6fQkvKQKC5/rdQnF7DuJqZuKrE3FM1WD7XGz42
	3DkZtdtlRrsu1bI1dZ+wmAEyE2aMLlb3eEVkXehrSE5JNEKWAjDlCWOqNy2A8Xid1S2joIj6P3UTv
	ndJmoZH9dleMaOuSQAAJP15v7aa6ZUo1xMKDnfL3OxtrWyn9Xl7sqwSiYa7Hwb71SR9ixOBA/cgzP
	b+JItND++i9YW/whj5F/rgoUHhkHsdvZoVZ08MuMSWAdKu5tyjPz9IjEFez3p0AAfzkemSNyeJiC2
	Qq9gjw9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp17N-0000000HWCO-17nk;
	Mon, 03 Mar 2025 08:25:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tp17J-0000000HWAj-43Jz
	for kexec@lists.infradead.org;
	Mon, 03 Mar 2025 08:25:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740990335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xQJa5hq33EwCeIlC6ZAKrgfFf28o5I5tCi+O9hYDtj8=;
	b=DRW5vrPuxJTN95DsFn1J3EBPFczCRyAxI7FHZympQWhhmyVMHMgd8H2bKn3+moLcHuvhiR
	NzwmPYjYXC+m1Dso1IUCc6HcWP1uYuF1xtXInUHzDrxuySYdUsKN+Ffh+SXh4iDEtZ9qwS
	t3AYVgs54znJVtHWtDPb6Hg9JVoeixQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-2MTNxbEaP9Se4KjVLTW-LQ-1; Mon, 03 Mar 2025 03:25:33 -0500
X-MC-Unique: 2MTNxbEaP9Se4KjVLTW-LQ-1
X-Mimecast-MFC-AGG-ID: 2MTNxbEaP9Se4KjVLTW-LQ_1740990332
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4399c32efb4so21635995e9.1
        for <kexec@lists.infradead.org>; Mon, 03 Mar 2025 00:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990332; x=1741595132;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xQJa5hq33EwCeIlC6ZAKrgfFf28o5I5tCi+O9hYDtj8=;
        b=W6jIAM4rtkFrS9YFiDPWGt6B8SABlHJln2SLVG9EZnODB6nrdN6l2bMPxixCee2h4R
         obiau+RQWHgKY0yswimWMvDATmKLKRlSYntZm3ZNvBiDcnwLViI9n4y7T0aOsVZ9pcVo
         gjOOmcB10ypSc+DWP2MSzPX1hywjEr2tX64JBG9Nbx5bXCWddZ+aSxHYGluUMt05YTTC
         fwDr6o4l4yfSzxV5wRBPzmrwjPjA9djW+hHQRL5MnomQtSvNSOSDxNXBwKgzu4aBue+5
         xREpl1Yj0uX56sMFmih+PObnCHNdsNWO8G+ST6C3bYQS5A3Rf5kaO+ke2yvbqmdrrkny
         lLaw==
X-Forwarded-Encrypted: i=1; AJvYcCUuTE8inkiWlTUtOmN1vfVtQsJz531Nhq4UZ5P+pfscMqrbGaxy/zWQLHdAlMC/MunRxrz3IQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywyw+x+DRPSTC2sUEE7xO1/Ag78FMtu273g5zE7YWI3eHimsYq+
	YNLLUGH9fdeHIV6pMOcET+g9kv3SUPiHImzXL0jVizhuVoEaDiHBJwWNY/I5OpbTAx3lU2NJyXB
	qCrXHQ3NnlmOMPK4be4NterZQJEFhnbil6PI3irvKiVCRjuOOZ1qX9FaZ9g==
X-Gm-Gg: ASbGncuc2zgj8KzCndCEn4bbVUog8e6HLpzbxKxMS9qqAswZRbuCes+my8nNNHLQJVr
	VkOPOq86VCRUaMj8ZLF46qwK4BGwPWfMcVmckQQ9dI79yUUVROlN51mrdvB/xd9uoJwN3HAc/ff
	hNzW5Gh51rPBMNErKgngbhJhvhlVaq455NNJ5SjktmcSMzziURpEsyuLN8MCr4/yLSmgaTCGr4i
	sl4lABpHSBaSifystx80sEEyH+d5NxPnrDDRtbmbgj7xhI3umkJZbD6gXnwhsTtnR13gypIv8QS
	wSqIOthw2IvzGlksowAPo1vPA9YseMrwR56IRnQK7TK/dVDJUpU2kiVn29uD6UN2wDAGB3sWb93
	dNyHEZH+cC/FJkdsy8BxGq5HsxA47w+DltaWCX+e3BL8=
X-Received: by 2002:a5d:5f96:0:b0:38d:afc8:954e with SMTP id ffacd0b85a97d-390e168d26amr12598022f8f.11.1740990332282;
        Mon, 03 Mar 2025 00:25:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHXdEcK466k9cymsnu6lkTJiaTmjAeBQ+6arxNNNOBmOvsqU6SoLHa6hs0wN1owqcbaCRBJg==
X-Received: by 2002:a5d:5f96:0:b0:38d:afc8:954e with SMTP id ffacd0b85a97d-390e168d26amr12597996f8f.11.1740990331870;
        Mon, 03 Mar 2025 00:25:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bad347823sm96630265e9.0.2025.03.03.00.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:25:31 -0800 (PST)
Message-ID: <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
Date: Mon, 3 Mar 2025 09:25:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
To: Jiri Bohac <jbohac@suse.cz>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <dhildenb@redhat.com>,
 Michal Hocko <mhocko@suse.cz>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -xINJxnWBMcRsIN7U7WPJS_b7L-_CMqpvaTi3qsGh1k_1740990332
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_002538_097262_CF902A73 
X-CRM114-Status: GOOD (  33.44  )
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

On 20.02.25 17:48, Jiri Bohac wrote:
> Hi,
> 
> this series implements a way to reserve additional crash kernel
> memory using CMA.
> 
> Link to the v1 discussion:
> https://lore.kernel.org/lkml/ZWD_fAPqEWkFlEkM@dwarf.suse.cz/
> See below for the changes since v1 and how concerns from the
> discussion have been addressed.
> 
> Currently, all the memory for the crash kernel is not usable by
> the 1st (production) kernel. It is also unmapped so that it can't
> be corrupted by the fault that will eventually trigger the crash.
> This makes sense for the memory actually used by the kexec-loaded
> crash kernel image and initrd and the data prepared during the
> load (vmcoreinfo, ...). However, the reserved space needs to be
> much larger than that to provide enough run-time memory for the
> crash kernel and the kdump userspace. Estimating the amount of
> memory to reserve is difficult. Being too careful makes kdump
> likely to end in OOM, being too generous takes even more memory
> from the production system. Also, the reservation only allows
> reserving a single contiguous block (or two with the "low"
> suffix). I've seen systems where this fails because the physical
> memory is fragmented.
> 
> By reserving additional crashkernel memory from CMA, the main
> crashkernel reservation can be just large enough to fit the
> kernel and initrd image, minimizing the memory taken away from
> the production system. Most of the run-time memory for the crash
> kernel will be memory previously available to userspace in the
> production system. As this memory is no longer wasted, the
> reservation can be done with a generous margin, making kdump more
> reliable. Kernel memory that we need to preserve for dumping is
> never allocated from CMA. User data is typically not dumped by
> makedumpfile. When dumping of user data is intended this new CMA
> reservation cannot be used.


Hi,

I'll note that your comment about "user space" is currently the case, 
but will likely not hold in the long run. The assumption you are making 
is that only user-space memory will be allocated from MIGRATE_CMA, which 
is not necessarily the case. Any movable allocation will end up in there.

Besides LRU folios (user space memory and the pagecache), we already 
support migration of some kernel allocations using the non-lru migration 
framework. Such allocations (which use __GFP_MOVABLE, see 
__SetPageMovable()) currently only include
* memory balloon: pages we never want to dump either way
* zsmalloc (->zpool): only used by zswap (-> compressed LRU pages)
* z3fold (->zpool): only used by zswap (-> compressed LRU pages)

Just imagine if we support migration of other kernel allocations, such 
as user page tables. The dump would be missing important information.

Once that happens, it will become a lot harder to judge whether CMA can 
be used or not. At least, the kernel could bail out/warn for these 
kernel configs.

> 
> There are five patches in this series:
> 
> The first adds a new ",cma" suffix to the recenly introduced generic
> crashkernel parsing code. parse_crashkernel() takes one more
> argument to store the cma reservation size.
> 
> The second patch implements reserve_crashkernel_cma() which
> performs the reservation. If the requested size is not available
> in a single range, multiple smaller ranges will be reserved.
> 
> The third patch updates Documentation/, explicitly mentioning the
> potential DMA corruption of the CMA-reserved memory.
> 
> The fourth patch adds a short delay before booting the kdump
> kernel, allowing pending DMA transfers to finish.


What does "short" mean? At least in theory, long-term pinning is 
forbidden for MIGRATE_CMA, so we should not have such pages mapped into 
an iommu where DMA can happily keep going on for quite a while.

But that assumes that our old kernel is not buggy, and doesn't end up 
mapping these pages into an IOMMU where DMA will just continue. I recall 
that DRM might currently be a problem, described here [1].

If kdump starts not working as expected in case our old kernel is buggy, 
doesn't that partially destroy the purpose of kdump (-> debug bugs in 
the old kernel)?


[1] https://lore.kernel.org/all/Z6MV_Y9WRdlBYeRs@phenom.ffwll.local/T/#u

-- 
Cheers,

David / dhildenb


