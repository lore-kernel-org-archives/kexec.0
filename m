Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A33BCA0ECF
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 07:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+PgtGMxnucPeAXIBku4dQufKzGH/DYMkdojQAkRr1Mk=; b=kEn3GLX9ouU1xW
	1fRqBBUPSL3MGa1TjauidfWP7VTiovYMOfVzjGYbPONoeZWNYm6vzkumoAyh8ileQmN9sZULpSTNg
	gfLojBd9pG8k03+wa4O6ffsuItfuRTsj3bkL8TKtPwdXtFja9pk9WE60eTN8Q9S4RpG/253ZQWfAH
	Yr1j80pibiRI29c5jNwU6lrt8yrkPOnngnlLZelD2t2ofp6eXycG0mWQlzANsH9hw8UzSRqtd23gE
	zW01N/lDAvtD+7e8lxe1Hk46/5GkIu0nrYP8fhqj+l52NyWYDNKLCaFgmsHAW0z5F0bN8BLvwJFK4
	Uvc6RT4KKnlZ16t5HfDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfyAE-002RxQ-38;
	Tue, 12 Sep 2023 07:50:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfyAC-002Rwo-1X
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 07:50:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694505023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mzVy3Mc/7bAQAhf4c1iHjdctfZReLCkKlOdBdE9Gi0=;
	b=ODluy26FsB9pO/LFtbOO9QaIk1zPPZMVy9NUTkcmhEs3S6wqIiqkG5tHqeZ0hQFxpbubfb
	dUB8y8UeYIWwkS7j3bHJps9Li43lBN/Iwg6T72o6gsuVIF0ZTNK/dkzblTw1g0tljmMew+
	Mhu2FkZDnGZu0f8Dar7IS47PRW/fAts=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-yYf63DUUOVWBcUEgVtSTiw-1; Tue, 12 Sep 2023 03:50:21 -0400
X-MC-Unique: yYf63DUUOVWBcUEgVtSTiw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so40540905e9.2
        for <kexec@lists.infradead.org>; Tue, 12 Sep 2023 00:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694505020; x=1695109820;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mzVy3Mc/7bAQAhf4c1iHjdctfZReLCkKlOdBdE9Gi0=;
        b=XO+6RMvRn30CxeS6SveIAx0k4WPGy/Y2kBg97yCdlzT0rDPwQvEG50DXM2/EOw6yQG
         xqsEODSRFRG+8t1LuHn3pf5DN9e89luvr7KNgqlxuuZG5taTvrM+/ZjPmH/EK4YVnc7S
         lL8eeigmEbLeN3vl7lKUSJ9dy/N8vB/RBAgLS8w85Yt+inJhwbytftMXppplkesP4Cr2
         l2qamNEvXxHtRxNtNBqkLfpSiw7er5mP1C5yB5mSHTiOgrkT/otMCemRxcQLhstWAxiU
         r2ZiLVsHDDjPYECwMdKQw5Tmi77d8q35bHEmsAvD13liFw4Nh0aS95TAeQBZ1ST2YGYl
         UgDg==
X-Gm-Message-State: AOJu0YxitGju4o6rdeO62eSg7k5b4ieD/0ugRyJHQb4H1QQW1Rlup9t5
	GC/kqUOc+5YDHjTQUMm8aczfWD8Tdpvf9Yb3N2XwC4yzmF0efRYeDn1UpXijJ7HmYzlKsGrH6et
	IYTf7UHUy6ZvscQ52SRuI
X-Received: by 2002:a05:600c:b59:b0:402:8896:bb7b with SMTP id k25-20020a05600c0b5900b004028896bb7bmr10597662wmr.6.1694505020033;
        Tue, 12 Sep 2023 00:50:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWb5KPPue011J3X0eD1sW7gLSQXGBULtIBQ0OCAIfXnbwUsDGLY2yVip/HeBg+JEeYAy53ww==
X-Received: by 2002:a05:600c:b59:b0:402:8896:bb7b with SMTP id k25-20020a05600c0b5900b004028896bb7bmr10597627wmr.6.1694505019623;
        Tue, 12 Sep 2023 00:50:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9? (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de. [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
        by smtp.gmail.com with ESMTPSA id ay7-20020a05600c1e0700b0040303a9965asm9212894wmb.40.2023.09.12.00.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:50:19 -0700 (PDT)
Message-ID: <ea1bc666-69ca-9ae4-36cf-cb3d852a0558@redhat.com>
Date: Tue, 12 Sep 2023 09:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/2] efi/unaccepted: Do not let /proc/vmcore try to
 access unaccepted memory
To: Adrian Hunter <adrian.hunter@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@linux.ibm.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org
References: <20230911112114.91323-1-adrian.hunter@intel.com>
 <20230911112114.91323-2-adrian.hunter@intel.com>
 <96f124d6-c1f2-adb3-1d3b-8329e85ff099@redhat.com>
 <1c736ca3-36e2-3225-2f98-e51149c468ef@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1c736ca3-36e2-3225-2f98-e51149c468ef@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_005024_591566_6F615D6F 
X-CRM114-Status: GOOD (  12.83  )
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

On 12.09.23 09:47, Adrian Hunter wrote:
> On 12/09/23 10:19, David Hildenbrand wrote:
>> On 11.09.23 13:21, Adrian Hunter wrote:
>>> Support for unaccepted memory was added recently, refer commit dcdfdd40fa82
>>> ("mm: Add support for unaccepted memory"), whereby a virtual machine may
>>> need to accept memory before it can be used.
>>>
>>> Do not let /proc/vmcore try to access unaccepted memory because it can
>>> cause the guest to fail.
>>
>> Oh, hold on. What are the actual side effects of this?
>>
>> Once we're in the kdump kernel, any guest is already dead. So failing a guest doesn't apply, no?
>>
> Unaccepted Memory is used by virtual machines.  In this case the guest
> has kexec'ed to a dump-capture kernel, so the virtual machine is still
> alive and running the dump-capture kernel.

Ah, I got lost in TDX host semantics. So what you're saying, if we 
(guest) are reading unnaccepted memory we will get zapped. Makes sense.

-- 
Cheers,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
