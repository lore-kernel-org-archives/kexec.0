Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDEECA0FED
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 07:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3/AmiyqDL9vHReNzfhyWcNWwH+eng+cyq2XKxF08kzk=; b=fB/hUSiXVZe4+NQVEwrVAAarcn
	ZXW8r7fH127QP8gc2tKnGCTpjzTcRdzCS5h5K2rObuMvxuoSaHqeajdcf6ibyJUABX7KbKmeO9eqv
	4ebfmaCQT8lZ6UGfFC6yrtOdUUiEY4jYM3c4ErYUNm9BkOMBE0WQvUGxl4OzQ13y2Do2UCMh/4cv+
	2O1EpyYBIEqX3eLJ19D0jLqNrjeS3X6kdgXR3s9vOL0GcQy0jnbWwwhVN6X+eqhBAa+P2Md2f6trE
	9fpLqszYSTq2XMTdw9gTuOvL98zcZsJ2x94ce0VgPmoYNOMxIB88JU0k1psdnGHosFCMyTYh4lQqe
	tfu97l4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvsxx-00000005Gep-0HRz;
	Tue, 09 Sep 2025 07:40:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvdqX-00000000Rzi-3KoW
	for kexec@lists.infradead.org;
	Mon, 08 Sep 2025 15:31:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757345516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3/AmiyqDL9vHReNzfhyWcNWwH+eng+cyq2XKxF08kzk=;
	b=ASKuLYOU6aoW4zKaeKkXKaD5taHMkyDwtR5wn+bDA8EmCgYtdfUONliPsGYWa6EZzOtDTn
	XZFh2pOXH6hmdrPGzL+iBPEhHUyDfHsBSI+HdAXcXkEKWwtP+JYT9TE8CbplyR/Uro4tdb
	RAfb+O7axgZL7TufhIFxQ4iP/OpEcIE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-IGurNVEtMrOdXr2qqnji-Q-1; Mon, 08 Sep 2025 11:31:55 -0400
X-MC-Unique: IGurNVEtMrOdXr2qqnji-Q-1
X-Mimecast-MFC-AGG-ID: IGurNVEtMrOdXr2qqnji-Q_1757345514
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b99c18484so19384895e9.1
        for <kexec@lists.infradead.org>; Mon, 08 Sep 2025 08:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757345514; x=1757950314;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/AmiyqDL9vHReNzfhyWcNWwH+eng+cyq2XKxF08kzk=;
        b=Af/rQY62pshExwqwVh8QZfFFvjAKNl9ArtPo+8y4dkOKZNxEUqOtFCf8GOaLS1jjDr
         p8S6yLjL10EoIycr4NOUIHMdD5T4/Bn3HehU1mKCfkjMzYaA1qy2RudTi4JD8CpXQbQ/
         mxCd6/XiRM41G19x02Q/esQW3fbSkK3tAO3N6xIVX2ysftvsZQIW8L1kWXdYQ4ZPgpSW
         E1hQzXJBgpZovVRPGAJ+M8664ecp8DTO+aBtV4Sdex4bzgIgWtuMmTgPx6xM1G9iaFEC
         iDixTl++DPzI+3ilvylClGfq8cmLA9emh95BTej+y0uEaMGLMOTddPpiw6TwyGgNvL5G
         z3zA==
X-Forwarded-Encrypted: i=1; AJvYcCUNLg1oqOgHUGPre2JO08BY/07Pt1h9g6Jyq14ew8ttvV2W6kDVvboN8CEvdS+EDkGP8Sgifg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyjeyfjoOyCGm5YUetSKZfb/o2MwgH1anYSOAwQURSf0jfBQ0Ry
	GprvnId3rqmVNiV6g7hlQKLpFGPnTgroCRNSHNPlFBXfmymkvnl/Rh+wpCViOI7uywgrt10BGh4
	XSngIq0r+e4yuOZte1XkRtr61jwQehOOnL8Px7b7vRB02tki5XxXum9cjZvtrnw==
X-Gm-Gg: ASbGncsB6YjFuTWhJNmvcuBm8ALJH6iwfeLi3MFNNuwhVB5AQlv0Z3pM0FKikqOZBss
	KpVpL1X6QFS8BBdvk3ZGnDEeHuP0Nu2t3I54Qno1Q1ezwAMbe4wtaKrfU2DzfI2e/Nkk7jkq591
	MmAfoJMPzWLrp+3ni08Y0axmrujmYGTQ2j+ZCH4Ks2S6KaKQwh2Q6jHf3TLtPIcwX4E8RZmcEAa
	2KbkSY/Q3C6kvSYdVriPx4tx6oH9lXC4k93+lFYj/7ZMJ8hWlsYG/rVRc8pNUKZcQydTjiJW5G7
	lsmYorSSpvby45uxJOUXGLAvjU/ANiFTeS4GvTupGo2ZlwDi4Tma1wp34tBeHKdro45PoleGt7c
	L/shjsBdwOmxSyGHPq/10cbLQ7wS6TvC7QIllEQHepot9C9L3SCgCC3ZCPLRLjyD2
X-Received: by 2002:a05:600c:468a:b0:45d:d19c:32fc with SMTP id 5b1f17b1804b1-45dddeb7e1cmr77122655e9.10.1757345514029;
        Mon, 08 Sep 2025 08:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9rpy3InIS+5sr81R5XgCQln42twosPUaVcPgtYPShPoeqkbUoM5WXvKiqBYV5iWkxlAlPFA==
X-Received: by 2002:a05:600c:468a:b0:45d:d19c:32fc with SMTP id 5b1f17b1804b1-45dddeb7e1cmr77121535e9.10.1757345513379;
        Mon, 08 Sep 2025 08:31:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d7ac825b88sm28792480f8f.7.2025.09.08.08.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:31:52 -0700 (PDT)
Message-ID: <cb2f3d85-928f-4a48-9f14-0628c189f10d@redhat.com>
Date: Mon, 8 Sep 2025 17:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] device/dax: update devdax to use mmap_prepare
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Guo Ren <guoren@kernel.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
 kexec@lists.infradead.org, kasan-dev@googlegroups.com,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <85681b9c085ee723f6ad228543c300b029d49cbc.1757329751.git.lorenzo.stoakes@oracle.com>
 <e9f2a694-29b0-4761-ad7a-88c4b24b90b7@redhat.com>
 <a97321dd-d8a4-4658-8894-14b854661d34@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <a97321dd-d8a4-4658-8894-14b854661d34@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zdHPhxccuc2Q_2ICGjxX8vP1C69ZNJzKoIx8MllLJTI_1757345514
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_083157_901650_D5840B06 
X-CRM114-Status: GOOD (  17.01  )
X-Mailman-Approved-At: Mon, 08 Sep 2025 23:53:50 -0700
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

On 08.09.25 17:28, Lorenzo Stoakes wrote:
> On Mon, Sep 08, 2025 at 05:03:54PM +0200, David Hildenbrand wrote:
>> On 08.09.25 13:10, Lorenzo Stoakes wrote:
>>> The devdax driver does nothing special in its f_op->mmap hook, so
>>> straightforwardly update it to use the mmap_prepare hook instead.
>>>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>>    drivers/dax/device.c | 32 +++++++++++++++++++++-----------
>>>    1 file changed, 21 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
>>> index 2bb40a6060af..c2181439f925 100644
>>> --- a/drivers/dax/device.c
>>> +++ b/drivers/dax/device.c
>>> @@ -13,8 +13,9 @@
>>>    #include "dax-private.h"
>>>    #include "bus.h"
>>> -static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
>>> -		const char *func)
>>> +static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
>>> +		       unsigned long start, unsigned long end, struct file *file,
>>> +		       const char *func)
>>
>> In general
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thanks!
> 
>>
>> The only thing that bugs me is __check_vma() that does not check a vma.
> 
> Ah yeah, you're right.
> 
>>
>> Maybe something along the lines of
>>
>> "check_vma_properties"
> 
> maybe check_vma_desc()?

Would also work, although it might imply that we are passing in a vma desc.

Well, you could let check_vma() construct a vma_desc and pass that to 
check_vma_desc() ...

-- 
Cheers

David / dhildenb


