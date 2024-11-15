Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F912D6DDEE
	for <kexec@archiver.kernel.org>; Fri, 15 Nov 2024 10:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EZnDRZ71uyzvr2+dGgO534gfg5ta2KTMQyX5WiGwzMw=; b=NgyiXKJuiJts+lqMzHsA3LjzJ/
	dV4RiYcBcA8miFNE3z8Ak0c9TrcXS4lxhP1dEg1X8tXBQb81874MoZj3b7JxyLxwFhJbNyBl5mkjS
	DzX7TrhNt2oWlP4WSfQDRFjgTBGdsCU145T45JfCHSGbHcjytN7ILV4wq0FscuIdfkAs5Sp6xJBtP
	h2kExaQCJgtwY0reIKE6RuMBEmSpXhu8eiHm+rl7tVmcZoEiRJqEV0fwv8w0wflytJ6qfi1Zm9uIg
	dT6ebqR4aiAWyDZi6bss5FrBeGhEa1xs077J9oFGCvXPd1cSC13BotsmYo59DxNHVz+G/wL0MBez8
	a/OLPzWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBtB9-00000002Hxm-0COt;
	Fri, 15 Nov 2024 10:03:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBtB6-00000002HxF-0Mcs
	for kexec@lists.infradead.org;
	Fri, 15 Nov 2024 10:03:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731665027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EZnDRZ71uyzvr2+dGgO534gfg5ta2KTMQyX5WiGwzMw=;
	b=VfMT+Jp/U3m8qFStuidohr3PG2CMEsVDDO/K4I2eRk8kLgTTHN5i/3WIkxHuvaG2UeV144
	V11cNRlmbsBax9HQA7yv08ubGLphNoV5U8Zb/QPUamyxVDwvTqyh9z7Wf+4TGY3VcHxEOw
	WeT+F42v7gyJBZaPg8FWVwe9jgl72TQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-fRqaElWoPc2104YmsyqrhQ-1; Fri, 15 Nov 2024 05:03:45 -0500
X-MC-Unique: fRqaElWoPc2104YmsyqrhQ-1
X-Mimecast-MFC-AGG-ID: fRqaElWoPc2104YmsyqrhQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-382172035ecso952035f8f.1
        for <kexec@lists.infradead.org>; Fri, 15 Nov 2024 02:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731665024; x=1732269824;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EZnDRZ71uyzvr2+dGgO534gfg5ta2KTMQyX5WiGwzMw=;
        b=OIM+1DTzT1f/fKYOGPhMQR7PUKR3VM8uR2LNonAMfMON0CDAdrVyl/KXTVIKGBRUow
         Cjv5sT5SCWy2hUo0LKWG0PkZX/bP58wezsP0N3eLJRHVdNpDAgMPMmzNrL6HOm0e3F8O
         TH2uhoQBa45oRlvnl15MnRt1BSe1bsFbbF+G8//wGzuujIJmSUTmKXJHy7wcAybsL2Ty
         N2fFkUgGowKFub9mAhbLqSIMiU31a1Q+pds9ZuUgWkIygmH2WKDjeoqFFNIqKDJOF//E
         tbSkRaAvNBEqHrGBJioSe1zVZTBWAOCKYoVrJxfqx8/wGyOVAyBlfxs3QTMTX8j/zrao
         elXA==
X-Forwarded-Encrypted: i=1; AJvYcCUBJuqCieHG4kd1oUwTztBi6gtjUwK1l0DBu/00WpJ4s9wjMublytN/iyGJyk5UQJWv2q7C9Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YziXvBeqmKsrTF/IroUe0PUhW/UyQ/YWPNO48kKpHh/TpV0OrAe
	nP313H51Y7OVykoyS5/MpykBlNckNnC5Hq9j9W/9l4wCBcVyCVRA9eCvO9p0kqYJiKtA0mNQkRr
	ASgM+ehu2h69vyAqAGPisTXsta1BGGhUcJs3+wGJj+oIisFDzKUYIKDD9jg==
X-Received: by 2002:a05:6000:1865:b0:37d:443b:7ca4 with SMTP id ffacd0b85a97d-38214022068mr6154306f8f.14.1731665023913;
        Fri, 15 Nov 2024 02:03:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcalZaTTsWSZU/E4ZgekugNGYKtIjPxdb5azK2RW63irWlZEd/lURJaTLrMsANb0/rcEU5NA==
X-Received: by 2002:a05:6000:1865:b0:37d:443b:7ca4 with SMTP id ffacd0b85a97d-38214022068mr6154132f8f.14.1731665023249;
        Fri, 15 Nov 2024 02:03:43 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:8100:177e:1983:5478:64ec? (p200300cbc7218100177e1983547864ec.dip0.t-ipconnect.de. [2003:cb:c721:8100:177e:1983:5478:64ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac21a15sm48656425e9.38.2024.11.15.02.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 02:03:42 -0800 (PST)
Message-ID: <2b5c2b71-d31b-406d-abc5-d9a0a67712f5@redhat.com>
Date: Fri, 15 Nov 2024 11:03:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] fs/proc/vmcore: convert vmcore_cb_lock into
 vmcore_mutex
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
 <20241025151134.1275575-2-david@redhat.com> <ZzcUpoDJ2xPc3FzF@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZzcUpoDJ2xPc3FzF@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DmXuAYLjuTv_JO-6KU3klGFvxBapz4K1eiH-3tlM4mE_1731665024
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_020348_220070_D370709F 
X-CRM114-Status: GOOD (  14.67  )
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

On 15.11.24 10:30, Baoquan He wrote:
> On 10/25/24 at 05:11pm, David Hildenbrand wrote:
>> We want to protect vmcore modifications from concurrent opening of
>> the vmcore, and also serialize vmcore modiciations. Let's convert the
> 
> 
>> spinlock into a mutex, because some of the operations we'll be
>> protecting might sleep (e.g., memory allocations) and might take a bit
>> longer.
> 
> Could you elaborate this a little further. E.g the concurrent opening of
> vmcore is spot before this patchset or have been seen, and in which place
> the memory allocation is spot. Asking this becasue I'd like to learn and
> make clear if this is a existing issue and need be back ported into our
> old RHEL distros. Thanks in advance.

It's a preparation for the other patches, that do what is described here:

a) We can currently modify the vmcore after it was opened. This can 
happen if the vmcoredd is added after the vmcore was loaded. Similar 
things will happen with the PROC_VMCORE_DEVICE_RAM extension.

b) To handle it cleanly we need to protect the modifications against 
concurrent opening. And the modifcations end up allocating memory and 
cannot easily take the spinlock.

So far a spinlock was sufficient, now a mutex is required.

Maybe we'd want to backport 1,2,3, but not sure if we consider this 
critical enough.

-- 
Cheers,

David / dhildenb


