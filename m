Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF015E69EA6
	for <kexec@archiver.kernel.org>; Tue,  3 Dec 2024 11:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GqDYXPSGry8fvFKf3Y6FQQzvxwwFWyLPiSnjxx0zMng=; b=pe66k2O87sDAezQ2HueOa80l9f
	9jEVU2LxNAULvAXCnlDWBWK76qtR+vuqpBC+OqUErzcINZQZIREOb6C6hlLEnGDHTtUAg2lRx8bft
	JYyEfRJq8I+lQxqGJkkeVTGOo1kA9sUEX/RYG4hUVXyXTKSk8XjA+M6gAmIjrSgCgv7Q7to8xWCVf
	+A6XO9rZwEr7kxKFffLhHU1hNCTmcsHqPYrDBAvAj/omEUo1pgAn/mCAG1e0A58nFzl6B+3BMoVaf
	mEV2i+oY1M9v5Pxj3nlYffmR2BQpVsMe7ykhhH/PVEeoh3/cHGSiGZXzj3AtlxJfWh26EkZPtcR8q
	+zd8eMGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIQk3-00000009CMp-0Viu;
	Tue, 03 Dec 2024 11:06:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIQVP-0000000990C-2UoX
	for kexec@lists.infradead.org;
	Tue, 03 Dec 2024 10:51:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733223106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GqDYXPSGry8fvFKf3Y6FQQzvxwwFWyLPiSnjxx0zMng=;
	b=H5T4d0YPjlBR+0aOaMQFqcUvC5N/pFQ3Lr4++baPRE41EdodejH8DO9c8Ky/xtRggMw5+M
	TJ6KYULrhr/qDgynd9pmIPaRbwDC1eM7PqzJuRT8rHnz+QJiCa54y6zqGb+pZEmOVrw8Op
	c9LA8aexSgWN1i8N9m5542RYamaMI88=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-nW-4NyzeNYaabe5TetHVqA-1; Tue, 03 Dec 2024 05:51:43 -0500
X-MC-Unique: nW-4NyzeNYaabe5TetHVqA-1
X-Mimecast-MFC-AGG-ID: nW-4NyzeNYaabe5TetHVqA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d735965bso2579287f8f.1
        for <kexec@lists.infradead.org>; Tue, 03 Dec 2024 02:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733223102; x=1733827902;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GqDYXPSGry8fvFKf3Y6FQQzvxwwFWyLPiSnjxx0zMng=;
        b=D3J7mmvMUWRkJMZihuEB4q+yttu6xVqdbyUkN6C95psVua2Cskovkjf/xcMePLk8sO
         GWeV8edknG/i0K9Q/5dhSXyyUavPsEHHkPfjElkSyOh/8h7+iZM3Ki9CAj/c5r3kNeUI
         Z9fM5I1J+Z+3rcxRAnebTLCRd53bGwsdnSgsf08LnH2Ec4+dMVR3gyEPTwk2iLZJzt3s
         d6HwqPsAwf23cNmXZiyJD84zyfmSckujJIxpfNqrI5cu5ygz84okq9mWNNcnFFC4PeYW
         Qtk/CUFVoEniGzKaDZLgQJOWoPXCVPMSxIHR0sselfBqs8mTH+O8Sx3+FcDlikfeoLpp
         xSGg==
X-Forwarded-Encrypted: i=1; AJvYcCUaZJZzGQaeQVmib5pUj8Ntfb+uzDV5tNYBl8NY/4xxGAlEY/RhhFPF28j1aqFDikjuN6IA9A==@lists.infradead.org
X-Gm-Message-State: AOJu0YydX8j+nERuL56o5IKg5GqpFU4GsQwGunEi1CP4OiRx2t5Ui1SW
	yTxrcJlixp3R1N6pKdlWbPVuGuJSYFQC6M+ahvl+nRwYhoPmtRmlHBV/or/JD210a62gtu2h76H
	PwGGdVd4y/bhVfXZf9ql2x+EXvfCf1Jjvv2O2UPFWvm+uqarKRfFRXKGDXw==
X-Gm-Gg: ASbGnctMiEC8h87i5E3dz2jjyqortW3BYQQaP8jFF8KJ676akYpeTvi3W696f+BhcJM
	xHt/DaRiPt7AWuHZrv506qj+ob7r6D/zCoYbgQ3A93/MlfJniU9VLvaic4txDfTeK5Id7o02r1e
	J0/5c9/wE/jSfmOfe3d4FxuVlKDEW5XLMhPcKuVmxHGvHMfErxGsZP9MHiWZWWS28yY7AHVfdAe
	L9bPdmlGx9kLGtSaljoR+OWTLA0WAbUaNy5euqVr3A1abFaGaIfiVTVvdbU64bkf4saH02ZqXcR
	l2jRojINChF78hK252YpFpe8S+Gu/Qafnaf5yKJYLoM2ldYTj+/ig9nHmCLlctJJFBAwJ2Y3obf
	xtg==
X-Received: by 2002:a05:6000:698:b0:385:de8d:c0f5 with SMTP id ffacd0b85a97d-385fd3ce003mr1805488f8f.16.1733223102024;
        Tue, 03 Dec 2024 02:51:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsiHmkxMqZNYBRMic15i3J+xhBUi5IkfKnDUhcGUpt0ArEviRKcEDiXtnq3XnP9doeeDQT1Q==
X-Received: by 2002:a05:6000:698:b0:385:de8d:c0f5 with SMTP id ffacd0b85a97d-385fd3ce003mr1805453f8f.16.1733223101624;
        Tue, 03 Dec 2024 02:51:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c746:1b00:fd9e:c26c:c552:1de7? (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2e1bdsm15556376f8f.9.2024.12.03.02.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 02:51:40 -0800 (PST)
Message-ID: <29dfdbf6-e356-4555-a421-e4926610c32b@redhat.com>
Date: Tue, 3 Dec 2024 11:51:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] fs/proc/vmcore: disallow vmcore modifications
 after the vmcore was opened
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
 <20241025151134.1275575-4-david@redhat.com> <Z0BL/UopaH5Xg5jS@MiWiFi-R3L-srv>
 <d29d7816-a3e5-4f34-bb0c-dd427931efb4@redhat.com>
 <Z0SMqYX8gMvdiU4T@MiWiFi-R3L-srv>
 <a7ccbd86-2a62-4191-8742-ce45b6e8f73c@redhat.com>
 <Z07gkXQDrNfL10hu@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z07gkXQDrNfL10hu@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rQ2aROIEPeiiMQYM7NkeN5aHdXY2CurllmxbepFYbeA_1733223102
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_025147_714947_16184C52 
X-CRM114-Status: GOOD (  22.87  )
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

On 03.12.24 11:42, Baoquan He wrote:
> On 11/29/24 at 11:38am, David Hildenbrand wrote:
>> On 25.11.24 15:41, Baoquan He wrote:
>>> On 11/22/24 at 10:30am, David Hildenbrand wrote:
>>>> On 22.11.24 10:16, Baoquan He wrote:
>>>>> On 10/25/24 at 05:11pm, David Hildenbrand wrote:
>>>>> ......snip...
>>>>>> @@ -1482,6 +1470,10 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>>>>>>     		return -EINVAL;
>>>>>>     	}
>>>>>> +	/* We'll recheck under lock later. */
>>>>>> +	if (data_race(vmcore_opened))
>>>>>> +		return -EBUSY;
>>>>>
>>>>
>>>> Hi,
>>>>
>>>>> As I commented to patch 7, if vmcore is opened and closed after
>>>>> checking, do we need to give up any chance to add device dumping
>>>>> as below?
>>>>>
>>>>> fd = open(/proc/vmcore);
>>>>> ...do checking;
>>>>> close(fd);
>>>>>
>>>>> quit any device dump adding;
>>>>>
>>>>> run makedumpfile on s390;
>>>>>      ->fd = open(/proc/vmcore);
>>>>>        -> try to dump;
>>>>>      ->close(fd);
>>>>
>>>> The only reasonable case where this could happen (with virtio_mem) would be
>>>> when you hotplug a virtio-mem device into a VM that is currently in the
>>>> kdump kernel. However, in this case, the device would not provide any memory
>>>> we want to dump:
>>>>
>>>> (1) The memory was not available to the 1st (crashed) kernel, because
>>>>       the device got hotplugged later.
>>>> (2) Hotplugged virtio-mem devices show up with "no plugged memory",
>>>>       meaning there wouldn't be even something to dump.
>>>>
>>>> Drivers will be loaded (as part of the kernel or as part of the initrd)
>>>> before any kdump action is happening. Similarly, just imagine your NIC
>>>> driver not being loaded when you start dumping to a network share ...
>>>>
>>>> This should similarly apply to vmcoredd providers.
>>>>
>>>> There is another concern I had at some point with changing the effective
>>>> /proc/vmcore size after someone already opened it, and might assume the size
>>>> will stay unmodified (IOW, the file was completely static before vmcoredd
>>>> showed up).
>>>>
>>>> So unless there is a real use case that requires tracking whether the file
>>>> is no longer open, to support modifying the vmcore afterwards, we should
>>>> keep it simple.
>>>>
>>>> I am not aware of any such cases, and my experiments with virtio_mem showed
>>>> that the driver get loaded extremely early from the initrd, compared to when
>>>> we actually start messing with /proc/vmcore from user space.
> 
> It's OK, David, I don't have strong opinion about the current
> implementation. I raised this concern because
> 
> 1) I saw the original vmcoredd only warn when doing register if
> vmcore_opened is true;
> 
> 2) in patch 1, it says vmcore_mutex is introduced to protect vmcore
> modifications from concurrent opening. If we are confident, the old
> vmcoredd_mutex can guarantee it, I could be wrong here.

I don't see how. We're protecting the list, but not the 
vmcoredd_update_size(), which modifies sizes, offsets and all that.

> 
> Anyway, it's just a tiny concern, I believe it won't cause issue at
> present. So it's up to you.

I can keep allowing to add stuff after the vmcore was opened and closed 
again (but not while it is open). It doesn't make any sense IMHO, but it 
seems to be easy to add.

Thanks!

-- 
Cheers,

David / dhildenb


