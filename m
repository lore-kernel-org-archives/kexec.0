Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFC9C5AE59
	for <kexec@archiver.kernel.org>; Tue,  3 Jun 2025 16:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I0elFj4iCpU3Q37dfy3qczDfEot5ZH9J+BNq48Sc/WI=; b=jVvUfdiAwm0c0NvYjYtLtU8Axa
	UfBMDndjG+kBp0HLBrbH2ZrPnTzJJ7fyBWsRHxMCfjCO9knYkdC1x9oxotyy2n7LUDsgsXp6pyVTw
	nYOxelp6dmStYaZ6it8KF8Z++mpchfznx6kEHaIVwlZpOy0KtFMHuvFXR7AiuGEz1idG41iTSxNTe
	ZvjuxK+W//a28RlAsSTqPlBRyz4FOUA7TcUrqjYspzPEpKWlrZMMovqG7s/AU7uevVNTPar3ih08+
	PMqGjjlHKdUgvl4J0peCCbUIwOAWUnwKOphPHy3wdDQ0L/FbuEnGu81QXocEAbqJQDnHqTPU8hnuf
	24ewp/+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMUTC-0000000BOWN-0OBq;
	Tue, 03 Jun 2025 16:26:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMUSl-0000000BOQN-0juX
	for kexec@lists.infradead.org;
	Tue, 03 Jun 2025 16:26:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748967965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I0elFj4iCpU3Q37dfy3qczDfEot5ZH9J+BNq48Sc/WI=;
	b=FdFeV+QUlM1cVDvhDSqY2ThLcHWNvAsP7sFN886QihDnUTWWIju0cC1qdzNv16AIeYUjaj
	6hGE7Qb8/IZiWmSB8zi06rZLkEYePcRycNUV8LqGHPqBVdvbuG5RPyXGGoR20+E/T0YjYp
	Si6k2oL9XV2D1usA20l83JDQoduiXgM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-pI7lFtfoO9CoL1QLGJetEQ-1; Tue, 03 Jun 2025 12:26:04 -0400
X-MC-Unique: pI7lFtfoO9CoL1QLGJetEQ-1
X-Mimecast-MFC-AGG-ID: pI7lFtfoO9CoL1QLGJetEQ_1748967961
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a37a0d1005so3658615f8f.3
        for <kexec@lists.infradead.org>; Tue, 03 Jun 2025 09:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748967961; x=1749572761;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I0elFj4iCpU3Q37dfy3qczDfEot5ZH9J+BNq48Sc/WI=;
        b=GNIXgjiNGzag4sGxoaNBlRuzAj6ccCCRQnEqDD/oBiIQgM7KpFQ2IiQq9UyJ05fh4n
         lZKhtEAAuB/GL6cYz+VO6TjZsbUPVdjQVwDifCoV67BiLf+1/gJuXWEA9Z63P7/cPYF7
         D2yI7I6JGjCp5tqzEsVm30AVfZo802yT3G/buEsq4WBbDNRfcpEnMOZKRpVLW+UUBdsA
         /xGWDC8+Xdv8jgiAruHxL+8s4JgraQf0olMBRE4I3JlXNbaKDrmPqoZyoWAn7jeq03T3
         XsvQYCD1ZVkcQF5+PHsjPNMxNOfRJkwV66FBANe9yC0lZcITNZ2z2trQX9wcmTGk3Gld
         VbMA==
X-Forwarded-Encrypted: i=1; AJvYcCVeXpVPDzo0GSW/ON4r6JEtNJZQ+5k+/FAEzSSYF8USAP4N5Y0gdeydB5GtQ0lTnz7pHj+9bA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxEdk6nSslb+RCSKSpX0WvjY68vMDNiT0CNJ7KkWsLLj77zEyzE
	nHaSh7uOJz23Dsbj2ZuIIdfgJLiTdqfoWzq+7gypFC87kMdWNN53daf6JzBCYFNsD8JQKegyH4f
	1/8B0oDpLyhv8q4/FCNeEmz7ffI6zUGdhGgVAX8BTvBlRwpQXC/rWiXXpOonW8/FH5XlGLjsS
X-Gm-Gg: ASbGncsqDqCnqGcQ3n2PVlsQeDz1wGMYJC0ku7G29j51LAy0egiGYE4G+cN+LFsH4sV
	rhthZR9KSRH4jsGiGVCPNJM3JzNlLcodV5ME6mH9R6tREXWRH/fTz4VApgj+WxsRY3AbkUOnXOG
	+uSD9S3lm5zeK0J6nDjSdT/fW06u8f/Um1sHYrFcUtHiXysE08BH8cL0Hy3VLAHnREOarQwxnAZ
	AEeLD1auoOe3un++3Ka/btD7hXOGz2ZFx29AuU/fiz9XgV7TsZFvhASCBo4DKNTDMrszmbbXt+9
	BcmNqXiAa68ZkLjb3grgSuJA3x+IJoRZKUZcYFxnguqYvqfg0IQ/u30p58aJQyDMf7eaNV/y7Wo
	JrRi9RTk6OJgsTyvgEscsJIPA2kEC5BzPAddIps4=
X-Received: by 2002:a5d:5f47:0:b0:3a3:7749:9783 with SMTP id ffacd0b85a97d-3a4fe3a6c35mr10417219f8f.51.1748967960858;
        Tue, 03 Jun 2025 09:26:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvQhQSejc4TxEAgYHYCI3h3d2YF9MKT2tL4RJ+lf40ORcTkjO3BavM3f1f2E8GMn64ILzM3g==
X-Received: by 2002:a5d:5f47:0:b0:3a3:7749:9783 with SMTP id ffacd0b85a97d-3a4fe3a6c35mr10417186f8f.51.1748967960393;
        Tue, 03 Jun 2025 09:26:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:f000:eec9:2b8d:4913:f32a? (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009fd9bsm18456031f8f.82.2025.06.03.09.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 09:25:59 -0700 (PDT)
Message-ID: <d7cbbab2-8fe0-4a10-8b06-e47da955865e@redhat.com>
Date: Tue, 3 Jun 2025 18:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] kdump: wait for DMA to finish when using CMA
To: Jiri Bohac <jbohac@suse.cz>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
 Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <dhildenb@redhat.com>,
 Michal Hocko <mhocko@suse.cz>
References: <aDoT08LfXUEkS9E4@dwarf.suse.cz> <aDoVO4H4CpXPjAdI@dwarf.suse.cz>
 <da52a835-6a4b-4f11-acac-f4ef995da7e1@redhat.com>
 <aD8b7Q8Z9sC8meGU@dwarf.suse.cz>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aD8b7Q8Z9sC8meGU@dwarf.suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tK0LzaTZRhpoXMnL8uwPEshDx32ZZHtgOgZxF2qdYIM_1748967961
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250603_092607_301163_6938AF35 
X-CRM114-Status: GOOD (  19.63  )
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

On 03.06.25 17:59, Jiri Bohac wrote:
> On Tue, Jun 03, 2025 at 03:15:03PM +0200, David Hildenbrand wrote:
>> On 30.05.25 22:29, Jiri Bohac wrote:
>>> When re-using the CMA area for kdump there is a risk of pending DMA into
>>> pinned user pages in the CMA area.
>>>
>>> Pages that are pinned long-term are migrated away from CMA, so these are
>>> not a concern. Pages pinned without FOLL_LONGTERM remain in the CMA and may
>>> possibly be the source or destination of a pending DMA transfer.
>>
>> I'll note that we right now do have an upstream BUG where that is sometimes
>> not the case. I mentioned it previously that such bugs will be a problem :(
>>
>> https://lkml.kernel.org/r/20250523023709epcms1p236d4f55b79adb9366ec1cf6d5792b06b@epcms1p2
> 
> I'll just reitarate the whole purpose of this patchset, as
> added to Documentation:

I know, but stating "these are not a concern", when they are currently a 
concern upstream is a bit suboptimal. :)

I'd phrase it more like "Pages residing in CMA areas can usually not get 
long-term pinned, so long-term pinning is typically not a concern. BUGs 
in the kernel might still lead to long-term pinning of such pages if 
everything goes wrong."

Or sth like that.

>>> +static void crash_cma_clear_pending_dma(void)
>>> +{
>>> +	unsigned int s = cma_dma_timeout_sec;
>>> +
>>> +	if (!crashk_cma_cnt)
>>> +		return;
>>> +
>>> +	while (s--)
>>> +		mdelay(1000);
>>
>> Any reason we cannot do it in a single mdelay() invocation?
>>
>> mdelay() already is a loop around udelay on larger values IIUC.
> 
> No good reasons ;)
> I just wanted to prevent a totally theoretical overflow (if cma_dma_timeout_sec was made configurable;
> I also anticipated someone might want to add some progress printks into the cycle (without verifying if
> that's even possible in this context).
> 
> If you want, I have no problem changing this to:
> +	mdelay(cma_dma_timeout_sec * 1000);

Probably good enough. Or just hard-code 10s and call it a day. :)

-- 
Cheers,

David / dhildenb


