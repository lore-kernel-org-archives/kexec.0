Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B42CAC58C
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 07:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3P5EwsaOJG0kp/tyGnSgePetI5hCYz4arKjA4KqYxlA=; b=QYJ8R7LNlRh6yfJn+bLxX4XfoI
	vvWYFGs/UviynAorI6eahQgyIW9VHQZnqNxgEa513xTlafDUOFJzunkesqggZGpQSU5yABtWdhM7E
	c1BI1OXc7XxvND+W2+lFyU6maKBio0EbaTTlQgeQe9rDAv0mpKqJu//BV3TOQ3N002hPtvID0PYm2
	3d8N9IzU3ZXxBFybkRegmcRQeIS6Y385SGo4GbHntfI3zCWnJnIBa7pbklTzobOMAmwYu1+0AU00U
	MpcrRo08/u8Dx3Mgyz6QfVGafVkPgjeo68LZlsu1Xln6FtHvVzvihLpacXoMIcJMiSrSufFw6YrcS
	/irlEktA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvsyX-00000005HCm-2tUJ;
	Tue, 09 Sep 2025 07:41:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvfpe-00000001GJd-0zVU
	for kexec@bombadil.infradead.org;
	Mon, 08 Sep 2025 17:39:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3P5EwsaOJG0kp/tyGnSgePetI5hCYz4arKjA4KqYxlA=; b=MJBjTY9WCCTDA3/fxM6LkKwHsF
	8p4U1tgQo1TCjaGqj87znys08vXoEG25yEA9PsVob7BybGuSKa7xZrrdXMuN3luBK5e/NslaHr+Qr
	WVZuN9vHYC7MX7ufIxlz4Jjt+ZDl/WSOuTRq1xodJMkQxZXa9gwAJpT77z0GQ1BaLLBKW+AafOMs8
	dteOWPWiy6iKl6pq59jK3zVQmDj3xSXgJAfgQLYhbbWGx6OI69fPwYYEF8v4EgojJPr4JuvTrElN8
	XhI14JfE9ne3rYdu8kdZjapzJ/WOg5mYE7ME/Kjk9NavIX5JNqpFBsJ0XkY4+xq7UcJGnMFHgcKqk
	LdDup5+A==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvfpa-000000056xC-37tb
	for kexec@lists.infradead.org;
	Mon, 08 Sep 2025 17:39:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757353145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3P5EwsaOJG0kp/tyGnSgePetI5hCYz4arKjA4KqYxlA=;
	b=fK27Frs3jNDX3CUNJBBWnF4svULr6POATQe6N1DLBcKq8K8XoROwuDAjPEmropqHxvVjcK
	otn9B6hRQB3Fxs+B+EBeS8m1fNgsGGPqmL40blu/TECwcQQCT0qd0CO/w+pPsUmqSljDk8
	Xf/2MclGuBAzgOSCqZKUVuzWB/pqXOI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757353145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3P5EwsaOJG0kp/tyGnSgePetI5hCYz4arKjA4KqYxlA=;
	b=fK27Frs3jNDX3CUNJBBWnF4svULr6POATQe6N1DLBcKq8K8XoROwuDAjPEmropqHxvVjcK
	otn9B6hRQB3Fxs+B+EBeS8m1fNgsGGPqmL40blu/TECwcQQCT0qd0CO/w+pPsUmqSljDk8
	Xf/2MclGuBAzgOSCqZKUVuzWB/pqXOI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-n7nzEv5IO66DNKoGtozybg-1; Mon, 08 Sep 2025 13:39:03 -0400
X-MC-Unique: n7nzEv5IO66DNKoGtozybg-1
X-Mimecast-MFC-AGG-ID: n7nzEv5IO66DNKoGtozybg_1757353143
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45dd66e1971so31516475e9.2
        for <kexec@lists.infradead.org>; Mon, 08 Sep 2025 10:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757353143; x=1757957943;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3P5EwsaOJG0kp/tyGnSgePetI5hCYz4arKjA4KqYxlA=;
        b=nHKCwkNXAINFeYewLQxwo08xWuZX6rSCOTr32VO3kujgc38kp0VQIBDfdFq/XZw9Gm
         CwtF0FV6tef6I232au9zjN9CQx8Yq1+or1vJO78Lrmsi6s1MQZ74hbwf835wrRg4YvAE
         OPMpvA5WMaiQWXntX+euhQYj3F6qy4l3QvlQbF2kAfy2963GiOmyns7+Ok3HlX2t5vg5
         fP2WV1w143v4hMoO6qISPSXDet9tq7pu1LTrQO7UnminrFU5dL1ZEYAVzQrL/QA4LYSQ
         VQy7/b/sG9kOBGxdkpHld2r5s5dcUtkFDxstg7gnqxW1jOqiNw+/SO5+nnKwzG4tAXL+
         ffMg==
X-Forwarded-Encrypted: i=1; AJvYcCWmkQ0WA9RQUtqiXPGtuRuUrWHKYbM4Ku6+NkA+4XiTC+B6NVDJxuYU474LNMEXdlKPx1t59g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzdWCiiDxzBC8nU9EswOGnX65c3uwOIPj3o4f/1CATIFldNe/pn
	mG5tqusaQAkK+YOeZP258N4htZSG4EQzi9zUd4poZ6VL4+YyaLixV2XngYCbaEFm4voGfZo9bNu
	U0FVFZx2XLFSk3HMeAGo7be1KiJ9BkIJhygl1nAWU2SFTpw4FZg1VNhTuz0F/tA==
X-Gm-Gg: ASbGncuxZjF8HA5OfBWTrgkB7SmepzSa1EqwSk1ngPGa8cWkM1N/s3r7pGUwYkZcthn
	qsq+wRLkQDaf5IOWDLGy77h0VJFnZ5uq4h3uG4roYAEmQof0mqG0FTu6lkONX+qls2fnZlunrOH
	bXMq0//L6ZDU48+ieCAMSzvqrk+YCENu96vPi1aHI0Xsaixzs8FsMLPwO2Tsz/NhUnQr/JBjE6K
	xuXZ14An7Hrx5YB8Klj5fK1rS9I/m23fDS4O97/LhnO6VTjVgGHKhA//Fc8B0oFier36Kt1Guva
	HeVZwwfynXarvCuVyunAwRFMoEtYypstUwMm/GXNlz0aPTyn/a8oXh0dT0h/koGpXyhcfZBRYiU
	FfRRR2SFIJz0SbaurBalDwLZ83F2c89qUpBgTj1Q8NBYl+64tCorXRmv0RNThNTKy
X-Received: by 2002:a05:600c:1c9f:b0:459:d3d0:650e with SMTP id 5b1f17b1804b1-45de870ac82mr30366605e9.13.1757353142603;
        Mon, 08 Sep 2025 10:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt8ktxg4j7+rHzwwJQeZDohdWogsGJakCqu7C8BDn8f2aNE74iKc5paKrXN3SjMzlRF+4VLA==
X-Received: by 2002:a05:600c:1c9f:b0:459:d3d0:650e with SMTP id 5b1f17b1804b1-45de870ac82mr30365735e9.13.1757353142034;
        Mon, 08 Sep 2025 10:39:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e92a42asm450957385e9.20.2025.09.08.10.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 10:39:01 -0700 (PDT)
Message-ID: <225a3143-93de-4968-bfc5-6794c70f3f82@redhat.com>
Date: Mon, 8 Sep 2025 19:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] mm/vma: rename mmap internal functions to avoid
 confusion
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
 <626763f17440bd69a70391b2676e5719c4c6e35f.1757329751.git.lorenzo.stoakes@oracle.com>
 <07ea2397-bec1-4420-8ee2-b1ca2d7c30e5@redhat.com>
 <a8fe7ef8-07e5-45af-b930-ce5deda226d9@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <a8fe7ef8-07e5-45af-b930-ce5deda226d9@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nhQvVR26goVrV1ZIXS-EHqEpEed9xVbrQwAuJH2pK_s_1757353143
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_183907_098428_3514A7CB 
X-CRM114-Status: GOOD (  17.94  )
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

On 08.09.25 17:31, Lorenzo Stoakes wrote:
> On Mon, Sep 08, 2025 at 05:19:18PM +0200, David Hildenbrand wrote:
>> On 08.09.25 13:10, Lorenzo Stoakes wrote:
>>> Now we have the f_op->mmap_prepare() hook, having a static function called
>>> __mmap_prepare() that has nothing to do with it is confusing, so rename the
>>> function.
>>>
>>> Additionally rename __mmap_complete() to __mmap_epilogue(), as we intend to
>>> provide a f_op->mmap_complete() callback.
>>
>> Isn't prologue the opposite of epilogue? :)
> 
> :) well indeed, the prologue comes _first_ and epilogue comes _last_. So we
> rename the bit that comes first
> 
>>
>> I guess I would just have done a
>>
>> __mmap_prepare -> __mmap_setup()
> 
> Sure will rename to __mmap_setup().
> 
>>
>> and left the __mmap_complete() as is.
> 
> But we are adding a 'mmap_complete' hook :)'
> 
> I can think of another sensible name here then if I'm being too abstract here...
> 
> __mmap_finish() or something.

LGTM. I guess it would all be clearer if we could just describe less 
abstract what is happening. But that would likely imply a bigger rework. 
So setup/finish sounds good.

-- 
Cheers

David / dhildenb


