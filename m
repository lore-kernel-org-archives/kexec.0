Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44710E6400C
	for <kexec@archiver.kernel.org>; Thu, 21 Nov 2024 19:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9vPjFHjh3yXhS4HZP/mZR+2x681KUbGOAjt5WUat2I0=; b=lvuk3HGbo41N3+9Px42Ve+fZgE
	KWBWyDNyCWka+MGD41G4Hap34vVRucwI3CoZSG6HbDW3L+4ejQoPowQAoNbLyG1vBRr6fadZKcsd+
	4qA6D8hTNGXVpeRO1IqxqEwxVosNB3jQoHnNUj+smLdVfYKpvNZNyxuJDHe4tHjP+cq83VSeOXxnn
	0SaC7EhagALKRefeQDeLV+d99m7BESqVxz50PBZV71isb7NAn2PMSLynPg0iWa7BRa4Ftx0g6MphQ
	CImqW1sE7ABPxmg7+EAsmI5im+cLjwUSOW1Hc5oSBzWtoGnRbQMCkwKqeXR9wTcc+Tt1DsqETfzWD
	PL+uDMSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tED8x-00000000nKS-37Aa;
	Thu, 21 Nov 2024 19:47:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tED8u-00000000nJy-2JJz
	for kexec@lists.infradead.org;
	Thu, 21 Nov 2024 19:47:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732218427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9vPjFHjh3yXhS4HZP/mZR+2x681KUbGOAjt5WUat2I0=;
	b=BSTGR7iBPI7Nc6Nd/9TeYxMoZDEmBd3apEUFVOqHZ6HNRErLvYhceF1y1q+z/Mkm3yE9Yz
	t9wJlDTmyFMo9+NxhIYMM4RLBVG7kdYJBV6Nq1uH6zGdYk2FeZz+i52QunGqnI9Uwz3kg7
	8mZ5QVslPcZPAFVDFKTFHsaieamgk3Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-Fz3Fiyv0OkK-2hSCQ8lhrQ-1; Thu, 21 Nov 2024 14:47:06 -0500
X-MC-Unique: Fz3Fiyv0OkK-2hSCQ8lhrQ-1
X-Mimecast-MFC-AGG-ID: Fz3Fiyv0OkK-2hSCQ8lhrQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3825a721afaso714874f8f.0
        for <kexec@lists.infradead.org>; Thu, 21 Nov 2024 11:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732218425; x=1732823225;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9vPjFHjh3yXhS4HZP/mZR+2x681KUbGOAjt5WUat2I0=;
        b=UHnA9AwoMWSHnBRd5eVNHuWMPAxrS3rsDU0bT/0CUyrr0vemDWSabXangNmBXyTDcz
         4YRRDcPJP80nTE5Xf6AE5kBRQj8tsvMLWMeVVwtjdDIroKTyOE/HHXCBja1MRcH4rHqQ
         +eMSCZCIYCO9uxGToh/NRLLMNKfXK67UoLosUjWhZyUUEkljJyy57yzWiF8e4mn6gtKH
         kycWy0QAV/varg+RY9Y3r+UpHoZUSykyFMZZf01FIG+zLnzhzmRSHRwMrJC32KEWmSIH
         GTOWJLzcFN1Yk+fRPQz/EP+5r3yRzvz6jC6UaTuUE7T6ktPRd+hiM+Pj0CeMtf8WHWGe
         daeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6QF18kPELSIsTSCE8ksTgLWtissdZmg0dXCo6k7+T/Cc4TNRM6ESttognuB9oOF6HT3ryzg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyKk7P1f6xWs7S/E6OnUkqrgyt0O/G2qbfVDvETREftk/ivoVVj
	wfEUNZjzLweQKEJxoz1OYZXZCuiRGR0xfPU/xgRmV7JPFRYbKTnNZSVVrXsvQohZxa6TlaQ6UGO
	yY3t48WBfczx39f9rtYA9ApoTsSg8f/sar2kUTBsL+kvTuWX3zMhuLlFxdA==
X-Gm-Gg: ASbGncuUyVtY1nr0HMNMHsP2x1Q5EB9/A346k0Jd83r+fanc4zJqhECOI09de82f80E
	BYC6MyQbi+yK4GKZKrNXirXsRZ+mD9uIv3b9CZGm2ElGaFrFXfR/QD7wn73CkojllLuDoOneQGx
	/IcnrcfqZnq6uyAOjDGtzUC+eIN1QTcrAdNfnSabRgjwyEOwHQo60rwQ8P9RLk3VlpC9QfbKx1j
	J3ZK3bd1VOr0HeorJyTbdJr+7RthhfncWlupStHa4xqX2Saq8AaMifxlMyEFIaXSmRcR4wv+qPS
	zOTml8Hbv9z29EPClc70MM5tCGcLKWmLmuERPmqzAVa6wUP2OG+cdEZMek04lxyyC5bqOwYscZc
	=
X-Received: by 2002:a5d:64a4:0:b0:382:4978:2ab9 with SMTP id ffacd0b85a97d-38260b50178mr280900f8f.5.1732218425149;
        Thu, 21 Nov 2024 11:47:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwjpMyfPMDn7yzJZGj2fN3hdUzm6pJror1oFSbaD9p3e5FF3gpDG0hGN0f8NMCUBM9HBDVYw==
X-Received: by 2002:a5d:64a4:0:b0:382:4978:2ab9 with SMTP id ffacd0b85a97d-38260b50178mr280863f8f.5.1732218424718;
        Thu, 21 Nov 2024 11:47:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:de00:1200:8636:b63b:f43? (p200300cbc70cde0012008636b63b0f43.dip0.t-ipconnect.de. [2003:cb:c70c:de00:1200:8636:b63b:f43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb537d4sm390281f8f.61.2024.11.21.11.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 11:47:03 -0800 (PST)
Message-ID: <c353466b-6860-4ca2-a4fa-490648246ddc@redhat.com>
Date: Thu, 21 Nov 2024 20:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM
 to detect device RAM ranges in 2nd kernel
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-8-david@redhat.com> <Zz22ZidsMqkafYeg@MiWiFi-R3L-srv>
 <4b07a3eb-aad6-4436-9591-289c6504bb92@redhat.com>
 <Zz3sm+BhCrTO3bId@MiWiFi-R3L-srv>
 <3ed18ba1-e4b1-461e-a3a7-5de2df59ca60@redhat.com>
 <Zz63aGL7NcrONk+p@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zz63aGL7NcrONk+p@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iNPH2c_NexGC9RYznKSzB1G7ZvEiNaxKuEfEZgnt-rg_1732218425
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_114708_669519_4B7308A4 
X-CRM114-Status: GOOD (  26.26  )
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

>>
>> That would work, but I don't completely like it.
>>
>> (a) I want s390x to select NEED_PROC_VMCORE_DEVICE_RAM instead. Staring at a
>> bunch of similar cases (git grep "config NEED" | grep Kconfig, git grep
>> "config ARCH_WANTS" | grep Kconfig), "select" is the common way to do it.
>>
>> So unless there is a pretty good reason, I'll keep
>> NEED_PROC_VMCORE_DEVICE_RAM as is.
> 
> That's easy to satify, see below:

Yes, this is mostly what I have right now, except

> 
> ============simple version=====
> fs/proc/Kconfig:
> config NEED_PROC_VMCORE_DEVICE_RAM
>          def n

using "bool" here like other code. (I assume you meant "def_bool n", 
"bool" seems to achieve the same thing)

> 
> config PROC_VMCORE_DEVICE_RAM
>          def_bool y
>          depends on PROC_VMCORE && VIRTIO_MEM
>          depends on NEED_PROC_VMCORE_DEVICE_RAM
> 
> arch/s390/Kconfig:
> config S390
>          select NEED_PROC_VMCORE_DEVICE_RAM
> ==============================
> 
>>
>> (b) In the context of this patch, "depends on VIRTIO_MEM" does not make
>> sense. We could have an intermediate:
>>
>> config PROC_VMCORE_DEVICE_RAM
>>           def_bool n
>>           depends on PROC_VMCORE
>>           depends on NEED_PROC_VMCORE_DEVICE_RAM
>>
>> And change that with VIRTIO_MEM support in the relevant patch.
> 
> Oh, it's not comment for this patch, I made the simple version based on
> the whole patchset. When I had a glance at this patch, I also took
> several iterations to get it after I applied the whole patchset and
> tried to understand the whole code.

Makes sense, I'm figuring out how I can split that up.

If we can avoid the PROVIDE_* thing for now, great. Not a big fan of 
that myself.

> 
>>
>>
>> I faintly remember that we try avoiding such dependencies and prefer
>> selecting Kconfigs instead. Just look at the SPLIT_PTE_PTLOCKS mess we still
>> have to clean up. But as we don't expect that many providers for now, I
>> don't care.
> 
> With the simple version, Kconfig learner as me can easily understand what
> they are doing. If it took you a couple of iterations to make them as
> you had mentioned earlier, and it took me several iterations to
> understand them, I believe there must be room to improve the presented
> ones in this patchset. These are only my humble opinion, and I am not
> aware of virtio-mem at all, I'll leave this to you and other virtio-mem
> dev to decide what should be taken. Thanks for your patience and
> provided information, I learned a lot from this discussion.

I hope I didn't express myself poorly: thanks a lot for the review and 
the discussion! It helped to make the Kconfig stuff better. I'll get rid 
of the PROVIDE_* thing for now and just depend on virtio-mem.

> 
> ===================
> fs/proc/Kconfig:
> config PROVIDE_PROC_VMCORE_DEVICE_RAM
>          def_bool n
> 
> config NEED_PROC_VMCORE_DEVICE_RAM
>          def_bool n
> 
> config PROC_VMCORE_DEVICE_RAM
>          def_bool y
>          depends on PROC_VMCORE
>          depends on NEED_PROC_VMCORE_DEVICE_RAM
>          depends on PROVIDE_PROC_VMCORE_DEVICE_RAM
> 
> drivers/virtio/Kconfig:
> config VIRTIO_MEM
>          select PROVIDE_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
>                                                ~~~~~~~~~~~~~~
> 
> arch/s390/Kconfig:
> config S390
>          select NEED_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
>                                             ~~~~~~~~~~~~~~
> ========================
> 
> One last thing I haven't got well, If PROC_VMCORE_DEVICE_RAM has had
> dependency on PROC_VMCORE, can we take off the ' if PROC_VMCORE' when
> select PROVIDE_PROC_VMCORE_DEVICE_RAM and NEED_PROC_VMCORE_DEVICE_RAM?

We could; it would mean that in a .config file you would end up with
"NEED_PROC_VMCORE_DEVICE_RAM=y" with "#PROC_VMCORE" and no notion of 
"PROC_VMCORE_DEVICE_RAM".

I don't particularly like that -- needing something that apparently does 
not exist. Not sure if there is a best practice here, staring at some 
examples I don't seem to find a consistent rule. I can just drop it, not 
the end of the world.


Did you get to look at the other code changes in this patch set? Your 
feedback would be highly appreciated!

-- 
Cheers,

David / dhildenb


