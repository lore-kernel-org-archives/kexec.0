Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12242E77188
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i7q07UpxqItN5/CbDvEBg89xcdarz8dNPCMF232L7BQ=; b=Nn5v1/oDlLKcIOWiKZG4849m9+
	mAfkbgkes5cmdWDVV1CYcV65gTijAdb3uxPStqqsy4mNd/o1b7vtS6nD6yvbNRlKRca5yf+lYOmbK
	o7RrVoWxveDlu55nfcLEDTosBBvWoZZFLEc3j1RdXC9xDAR0q9Siy++KeluUuPp8+B8QSGtFPHNJ1
	IIcMP5+z8f0Yx3UTDx3M46ZHAi8YiMVFFJwjgAZzOAAyR2V/KjDD/K3vpa2UPdvLj67KaJ/EL9Nk1
	x2c4+yYm07zZE9PYnPDT6pMNl/MKyrOUjHMZhN8HqBA+VL+3gp4F96MB5D0KpVCl7e5p7BJ9h4SEO
	2WaAvLUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVVf3-00000008WcU-3O0w;
	Wed, 08 Jan 2025 12:59:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVUxC-00000008Ncu-0707
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 12:14:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736338468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i7q07UpxqItN5/CbDvEBg89xcdarz8dNPCMF232L7BQ=;
	b=VTYGgtYNkjtVkX1M2XXzrHmCoeet/o9oiZEGGmVY/lR3QgG7m5YHdkJXYfbuCbryVmHjfQ
	kKZwsLAVGzBscN78t1MkgBeoye5hjMhqz/VmEA0x6lsGkjZFuXhZK7jV3qieLxbpasJUH2
	CKhhiEeVvgRwswhYc+8+hoAScDzK0/8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-8qqBxAmuMe-XGLRlCArjQw-1; Wed, 08 Jan 2025 07:14:27 -0500
X-MC-Unique: 8qqBxAmuMe-XGLRlCArjQw-1
X-Mimecast-MFC-AGG-ID: 8qqBxAmuMe-XGLRlCArjQw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38a684a0971so2294029f8f.2
        for <kexec@lists.infradead.org>; Wed, 08 Jan 2025 04:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736338466; x=1736943266;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i7q07UpxqItN5/CbDvEBg89xcdarz8dNPCMF232L7BQ=;
        b=sKiuju72FfIpqUB2Wm5x2Aiy1LWjuAwTNqjVbNCuYATDduBo0pV1InSaurqlJLDMlK
         K2LeqIqoaG2+s8HjiuFefNV+Sa71ypeZJt+f/8YQnN4BDUuCCCZ7mcO6n6w2HNB3IttS
         LhO/P/XtjDVQ+3nN0egs+R0nkwmYNIm6VcEs1kBPfLk+g4BkAqsAexXCysbOywGwd3sT
         fnIesNof9luVRycpY0X6lwKk+KEAq8TWrxGp6zvdyQUQxgvZ4un9R1Sh/sCY+mh1L1jT
         4Wu0hkKbkJkYxR2CqE7P/lPRWiYMbpjxDjoOJ7s0wZadwDYgu/+wEXvKqEsMMLRvH4Oa
         myhA==
X-Forwarded-Encrypted: i=1; AJvYcCXJUcAMubK+pK9jzHUuboiPwvwC3IrdZLm0MaR10UxGa+8I81qc4WlTL4LpZJ/LXjhUQWSDGA==@lists.infradead.org
X-Gm-Message-State: AOJu0YybazMXx+onVBRxa3HoB9BQO+Nu0ntfw1PsE6aBIry5Pb+mlzf9
	ttfriar8TtrLBsUy7AHfLA5pIGoTd2L/59rGyHzMkIZ0X5D4TGXDvna1FOppp38bIkJ+vOYzZSB
	I1amujv1jAXfvydtqPOcmOgyj74eBmln5K8eDDtM6HdR7mVO7/3s1YfhSiA==
X-Gm-Gg: ASbGncuqwfpTpqXjcjU62Go1Quu9vZhcNlFBj1w0lSsqeLqebGnxtQV7GxKNwbS4YEi
	/fwMq6CpJlM80aFmWLTiWe3rbXZgVTacraGhmsULHzNX61TDxmH04NUw8vlxZI6nyIMOfQzZXhK
	Fv+B3JdKpH2sCqpnCwIi2EWHyi9RuU45vnGItZVhTRndqUyhaCd4b6k5DYdpQVFc1XE9yGgiykY
	bQ99IHJmcurCcb1I6ZJGz2rvk5mUgHBiJilktrllNE8g1mFbTd2jwRB7Nhzab8owIAmZ5l2JD6U
	5xZvV6qR7FHdGzqZOtAs9Uvtx+6TvDWQSSde06TiuDFY3EKh17KyzxZRZyFtolWpehVQRwOaEh5
	29C8oqA==
X-Received: by 2002:a05:6000:1567:b0:386:3cfa:62ad with SMTP id ffacd0b85a97d-38a872f6970mr2227390f8f.1.1736338466434;
        Wed, 08 Jan 2025 04:14:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7arOIchse9o494js1Tab5nOKasKdGhG0D/75m9o3epafPGRuC3YbVQ6l4Ror1ppOwwQPlTw==
X-Received: by 2002:a05:6000:1567:b0:386:3cfa:62ad with SMTP id ffacd0b85a97d-38a872f6970mr2227363f8f.1.1736338466073;
        Wed, 08 Jan 2025 04:14:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7? (p200300cbc70d3a00d73c06a8ca9f1df7.dip0.t-ipconnect.de. [2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828a8dsm53157942f8f.2.2025.01.08.04.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 04:14:24 -0800 (PST)
Message-ID: <29278ec5-a7ec-4935-94e2-0b56e601f385@redhat.com>
Date: Wed, 8 Jan 2025 13:14:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] fs/proc/vmcore: kdump support for virtio-mem on
 s390
To: Heiko Carstens <hca@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kexec@lists.infradead.org, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20241204125444.1734652-1-david@redhat.com>
 <20250108070407-mutt-send-email-mst@kernel.org>
 <20250108121043.7704-I-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250108121043.7704-I-hca@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -JGxOBgwtuZBpGPUoquW9YT-i1SpyzTn7js9zlzvfR0_1736338466
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_041430_145697_9A141CE1 
X-CRM114-Status: GOOD (  20.16  )
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

On 08.01.25 13:10, Heiko Carstens wrote:
> On Wed, Jan 08, 2025 at 07:04:23AM -0500, Michael S. Tsirkin wrote:
>> On Wed, Dec 04, 2024 at 01:54:31PM +0100, David Hildenbrand wrote:
>>> The only "different than everything else" thing about virtio-mem on s390
>>> is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
>>> during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
>>> kdump kernel must detect memory ranges of the crashed kernel to
>>> include via PT_LOAD in the vmcore.
>>>
>>> On other architectures, all RAM regions (boot + hotplugged) can easily be
>>> observed on the old (to crash) kernel (e.g., using /proc/iomem) to create
>>> the elfcore hdr.
>>>
>>> On s390, information about "ordinary" memory (heh, "storage") can be
>>> obtained by querying the hypervisor/ultravisor via SCLP/diag260, and
>>> that information is stored early during boot in the "physmem" memblock
>>> data structure.
>>>
>>> But virtio-mem memory is always detected by as device driver, which is
>>> usually build as a module. So in the crash kernel, this memory can only be
>>> properly detected once the virtio-mem driver started up.
>>>
>>> The virtio-mem driver already supports the "kdump mode", where it won't
>>> hotplug any memory but instead queries the device to implement the
>>> pfn_is_ram() callback, to avoid reading unplugged memory holes when reading
>>> the vmcore.
>>>
>>> With this series, if the virtio-mem driver is included in the kdump
>>> initrd -- which dracut already takes care of under Fedora/RHEL -- it will
>>> now detect the device RAM ranges on s390 once it probes the devices, to add
>>> them to the vmcore using the same callback mechanism we already have for
>>> pfn_is_ram().
>>>
>>> To add these device RAM ranges to the vmcore ("patch the vmcore"), we will
>>> add new PT_LOAD entries that describe these memory ranges, and update
>>> all offsets vmcore size so it is all consistent.
>>>
>>> My testing when creating+analyzing crash dumps with hotplugged virtio-mem
>>> memory (incl. holes) did not reveal any surprises.
>>>
>>> Patch #1 -- #7 are vmcore preparations and cleanups
>>> Patch #8 adds the infrastructure for drivers to report device RAM
>>> Patch #9 + #10 are virtio-mem preparations
>>> Patch #11 implements virtio-mem support to report device RAM
>>> Patch #12 activates it for s390, implementing a new function to fill
>>>            PT_LOAD entry for device RAM
>>
>> Who is merging this?
>> virtio parts:
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I guess this series should go via Andrew Morton. Andrew?
> 
> Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
> 

Yes, it's in mm-unstable already for quite a while.

Thanks for the acks!

-- 
Cheers,

David / dhildenb


