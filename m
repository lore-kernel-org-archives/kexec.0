Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7033DEE57DF
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 09:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a4dSnWgrg0j0Z9MBsMrUZehc8NvsQbAqElqK/Va/cX8=; b=x7ECOV9BGfMsIk
	3HBc2ua4T7hx3WMEfvd75yqhg7LJKBPCxf34t33W8Z9NWkNvG7NwnCIj0nFV2irycCrZNkJWtAwfM
	vOkVhUJbwBZv7GDlQ+mA0/LHqAY5pv+SSZKZOphSORbFzmJeE5CZIp6dhSgqp1SZEZlX2ZWyhfeZO
	iIbKv8PW5wURYd8PZbpRgFIFcl/WDH0XXWCux4gOxGz8wHquB3MQaT6sJkU6pxjviqWq7+T9lu5uH
	GbD7YrB2D1z9gQC1o/kdjgo3erfXKZdGBsecH49SzT2Zhrl2DOVOjR/rE3s/0/aa6g+yF4B0UXlfh
	t8SS2sAQWkNIDJOMmQAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfdZ2-0004Y8-17;
	Mon, 11 Sep 2023 09:50:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfdYz-0004W4-0q
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 09:50:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694425836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hI7Q7HmJLGnvJ6TWSuqo/D2NRHYvfG0p6wZ2y0ko6s=;
	b=YhXu0nK7mwCQWzxiDBSHYtg/wYz8g1lg0Y/2s8KiClw7tmLXhGjjfnqUNK/DX5jAsAVGOW
	awea7Jh4vWhSRqOFbWDSr3esL6mQXwsDbWtZ6vhfn7wjrWdavx/331kRQTk+JW0DgQs1Ut
	Tv0Sl6oXAo1DiMLsuz7ngxuA+yBTjXM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-fH75yBMpNxGKYl9Yem1HsA-1; Mon, 11 Sep 2023 05:50:34 -0400
X-MC-Unique: fH75yBMpNxGKYl9Yem1HsA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-402ccac9b1eso31053665e9.0
        for <kexec@lists.infradead.org>; Mon, 11 Sep 2023 02:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425833; x=1695030633;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hI7Q7HmJLGnvJ6TWSuqo/D2NRHYvfG0p6wZ2y0ko6s=;
        b=SJfsupSENgqwLSZPbcXoV+CW+gf2qchB+MqKewy+CaJyb3npzLM8s7nbz6bR7d+AjY
         pfN8f1EldlFpcL6iNGf4P3JV/rWecQGn/tBXQMnVNi9s5JOad3zxMmcjBnSPt5x3PwoX
         WPpXHDEEGlVC8fgQzijqsQqF/OMDYwz0s6Mwb0m3B6QKYgBgUp6kB4zQVXMsG9Jj9utj
         rZi1YXeDutm2+tsBJrYv05lAfVliO+EcQ97WsKKhnlbC7BljKCt+USAyzzRGtPA2FG0r
         aqCmIm0i9TJhfr0ZmkI/BIa9gusWJuJ5hGGh6EVUCHzRK3Fre8JnfXXUMuRTzxU3vQzp
         d54g==
X-Gm-Message-State: AOJu0YzJv98LYHGmWsuT/GF0EGdwti4nVYBhQUSydhHgWnIigmb3I7+W
	4nwvM/03tKJiRzHYUEWstUMz4xNVVE3dHgFAkDI2rqqxWdZZar8jWjNQd6imO8iDW1JuqK0kFOU
	xUKeTO+76i2ZCIwxf8H7b
X-Received: by 2002:a05:600c:ad2:b0:3fe:1871:1826 with SMTP id c18-20020a05600c0ad200b003fe18711826mr8233502wmr.27.1694425833710;
        Mon, 11 Sep 2023 02:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj8YJrIUf0UCqWXG8KH6oM4Y88u3/pmtlr2wHp0tLZ2zrPuhEBzJbkMb9F1qoq/xPMcrqORA==
X-Received: by 2002:a05:600c:ad2:b0:3fe:1871:1826 with SMTP id c18-20020a05600c0ad200b003fe18711826mr8233473wmr.27.1694425833313;
        Mon, 11 Sep 2023 02:50:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5500:a9bd:94ab:74e9:782f? (p200300cbc7435500a9bd94ab74e9782f.dip0.t-ipconnect.de. [2003:cb:c743:5500:a9bd:94ab:74e9:782f])
        by smtp.gmail.com with ESMTPSA id n8-20020a7bcbc8000000b003fe29f6b61bsm9506299wmi.46.2023.09.11.02.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 02:50:32 -0700 (PDT)
Message-ID: <476456e1-ac50-8e48-260d-5cbe5e8b085e@redhat.com>
Date: Mon, 11 Sep 2023 11:50:31 +0200
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
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230911092712.2ps55mylf7elfqp6@box.shutemov.name>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_025037_369565_3ADA0753 
X-CRM114-Status: GOOD (  17.81  )
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

On 11.09.23 11:27, Kirill A. Shutemov wrote:
> On Mon, Sep 11, 2023 at 10:42:51AM +0200, David Hildenbrand wrote:
>> On 11.09.23 10:41, Kirill A. Shutemov wrote:
>>> On Mon, Sep 11, 2023 at 10:03:36AM +0200, David Hildenbrand wrote:
>>>> On 06.09.23 09:39, Adrian Hunter wrote:
>>>>> Support for unaccepted memory was added recently, refer commit
>>>>> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
>>>>> a virtual machine may need to accept memory before it can be used.
>>>>>
>>>>> Do not map unaccepted memory because it can cause the guest to fail.
>>>>>
>>>>> For /proc/vmcore, which is read-only, this means a read or mmap of
>>>>> unaccepted memory will return zeros.
>>>>
>>>> Does a second (kdump) kernel that exposes /proc/vmcore reliably get access
>>>> to the information whether memory of the first kernel is unaccepted (IOW,
>>>> not its memory, but the memory of the first kernel it is supposed to expose
>>>> via /proc/vmcore)?
>>>
>>> There are few patches in my queue to few related issue, but generally,
>>> yes, the information is available to the target kernel via EFI
>>> configuration table.
>>
>> I assume that table provided by the first kernel, and not read directly from
>> HW, correct?
> 
> The table is constructed by the EFI stub in the first kernel based on EFI
> memory map.
> 

Okay, should work then once that's done by the first kernel.

Maybe include this patch in your series?

-- 
Cheers,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
