Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DE6EEB57D
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 14:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8kAd5yQUacam/o5kWIvBch+1rT+Q5KRpSHixZ5ftewM=; b=imhcMlF/tuCDGF
	SiNHBDNY6bIJNsegIGRYQgRn2+VtpzIZFQG4LFrZXBs/UkZ5+F+BeY0prCUIwRr9zQLKoi+zemXVj
	vJhU8XBc981lzr/5lhYH5K/+rW7uJKD85ctRbm6XtvVX43zyulsk4jsye44kDH/wo8qmtIc/gn7QS
	bsdWPiRxbWcZ9SmdwQHu3kvyut6NumiZ7daISMea+Oiggpal1zauOaKcd1kChkXutVySfu78QvSxY
	XIAHHCOn/LQzezrpBOSxupHV16QfqIXd+UinWqTpncNU9bWW9KXZpxRYNSgBEmyfd1Qpdrvo/Ydlm
	qxGg8DgiElr6EQkQDeRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfhzB-000iP6-1J;
	Mon, 11 Sep 2023 14:33:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfhz9-000iOO-08
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 14:33:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694442833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6fgHbS8D+uTD08GSlTthpp2bLqas6LD5jQg3oM+vXs=;
	b=XuG8yRgOLuHKZ7uMVPBxl2NfhEulcpA6jT87jpGC9q8EoqYKf62L86l6S6ClEL88A2mot5
	W3rflnSKT2C7E7//Q5dqlz8GM28QuvgfHVizcbJwm1IYejZg0fLIiYEFzy6HmyaNduGBWW
	33mJK55g2uLZ9jgRLXS0hIdjyaAwqok=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-pZtqh8RaPmG3vQjaw3TdXA-1; Mon, 11 Sep 2023 10:33:52 -0400
X-MC-Unique: pZtqh8RaPmG3vQjaw3TdXA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-401d8873904so36428625e9.0
        for <kexec@lists.infradead.org>; Mon, 11 Sep 2023 07:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694442831; x=1695047631;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6fgHbS8D+uTD08GSlTthpp2bLqas6LD5jQg3oM+vXs=;
        b=FVS0tzVZxtSyjvay5Jb7FM+JjqpEE4gUOBo42ysx0o+FR5SYrJuEObOgATGu/AR0fk
         /p4gX05YovvMjBJY8apQTG733OyZeSyK098j1du8ntcNDSFv8nVtKP+GQRFEd+cUaIp/
         ek6ZLSGZxA7PNAD8WiTJQdPFHIff4Xj7aAIYbGcyxACfqAQ5SELwg5TLBh9m28ddH67f
         ZxHjfoX9M6HXIGhHvyURzxKIq8wsxTEDHVVMnMlakmjCMyeQr11MM6sAdPOu3waLqZnc
         IjzEOxbCMTYQoCth1aIBFRAM6WRH50w65K2+VN1uKMJ6LcNBzOmCBdRci7moPU5MQ4D0
         IYUQ==
X-Gm-Message-State: AOJu0YyBY8dEdeI1gD/9SL+hFkHGyf06O4rVRIpOcGZoXzfCQjJkBIjW
	gTRHlmSN0ypF6uiTWLF1TMQMqVzxRaUxN2p/OJyQ40Rmz5pkEbs1KTq4GxG0Ed9bFdNb3WG8j89
	c0HdpRRG4+DIXy2kGCowk
X-Received: by 2002:a05:600c:5120:b0:402:f517:9c07 with SMTP id o32-20020a05600c512000b00402f5179c07mr7985435wms.0.1694442831137;
        Mon, 11 Sep 2023 07:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5pMvmXX0+VW9KHCfmQiDyHsdxBecmD9teUi0kfSkwDsZ1VNAU+o/EeDi3ry3+F0HnO2KLxQ==
X-Received: by 2002:a05:600c:5120:b0:402:f517:9c07 with SMTP id o32-20020a05600c512000b00402f5179c07mr7985407wms.0.1694442830722;
        Mon, 11 Sep 2023 07:33:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5500:a9bd:94ab:74e9:782f? (p200300cbc7435500a9bd94ab74e9782f.dip0.t-ipconnect.de. [2003:cb:c743:5500:a9bd:94ab:74e9:782f])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d634d000000b0031c5e9c2ed7sm10238812wrw.92.2023.09.11.07.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 07:33:50 -0700 (PDT)
Message-ID: <f05056e6-77a7-d0f5-615e-36efaab3ff05@redhat.com>
Date: Mon, 11 Sep 2023 16:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] proc/vmcore: Do not map unaccepted memory
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dave Hansen <dave.hansen@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@linux.ibm.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-2-adrian.hunter@intel.com>
 <ef97f466-b27a-a883-7131-c2051480dd87@redhat.com>
 <20230911084148.l6han7jxob42rdvm@box.shutemov.name>
 <49ab74c8-553b-b3d0-6a72-2d259a2b5bdf@redhat.com>
 <20230911092712.2ps55mylf7elfqp6@box.shutemov.name>
 <476456e1-ac50-8e48-260d-5cbe5e8b085e@redhat.com>
 <20230911100555.mjjnx3ujnjlaxgsy@box.shutemov.name>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230911100555.mjjnx3ujnjlaxgsy@box.shutemov.name>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_073355_209361_B3189CF0 
X-CRM114-Status: GOOD (  19.21  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 11.09.23 12:05, Kirill A. Shutemov wrote:
> On Mon, Sep 11, 2023 at 11:50:31AM +0200, David Hildenbrand wrote:
>> On 11.09.23 11:27, Kirill A. Shutemov wrote:
>>> On Mon, Sep 11, 2023 at 10:42:51AM +0200, David Hildenbrand wrote:
>>>> On 11.09.23 10:41, Kirill A. Shutemov wrote:
>>>>> On Mon, Sep 11, 2023 at 10:03:36AM +0200, David Hildenbrand wrote:
>>>>>> On 06.09.23 09:39, Adrian Hunter wrote:
>>>>>>> Support for unaccepted memory was added recently, refer commit
>>>>>>> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
>>>>>>> a virtual machine may need to accept memory before it can be used.
>>>>>>>
>>>>>>> Do not map unaccepted memory because it can cause the guest to fail.
>>>>>>>
>>>>>>> For /proc/vmcore, which is read-only, this means a read or mmap of
>>>>>>> unaccepted memory will return zeros.
>>>>>>
>>>>>> Does a second (kdump) kernel that exposes /proc/vmcore reliably get access
>>>>>> to the information whether memory of the first kernel is unaccepted (IOW,
>>>>>> not its memory, but the memory of the first kernel it is supposed to expose
>>>>>> via /proc/vmcore)?
>>>>>
>>>>> There are few patches in my queue to few related issue, but generally,
>>>>> yes, the information is available to the target kernel via EFI
>>>>> configuration table.
>>>>
>>>> I assume that table provided by the first kernel, and not read directly from
>>>> HW, correct?
>>>
>>> The table is constructed by the EFI stub in the first kernel based on EFI
>>> memory map.
>>>
>>
>> Okay, should work then once that's done by the first kernel.
>>
>> Maybe include this patch in your series?
> 
> Can do. But the other two patches are not related to kexec. Hm.

Yes, the others can go in separately. But this here really needs other 
kexec/kdump changes.

-- 
Cheers,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
