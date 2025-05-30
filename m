Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64265C5B552
	for <kexec@archiver.kernel.org>; Fri, 30 May 2025 09:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MaatFJjQ8egE/8VtOwBSoT6wLagg2lOTiOnjBKEO9pM=; b=kCsgWgM9Ao3Rk5o/4DHdLJF9rM
	aQjC0ylvSr7EJfbZA78+Z17Yte5SZq4zy4UAD47d4rsURKKgtrW/nKGJSahkGI52EBQ1WOeXBA6Qx
	1gobfafP+jVGIJQXxpVpiLgOltDgjxR6Hn7D5RWY5fgVFsqi70hd33g77klHIlK7GaqaJKamZDW4z
	Mv9TGFxqJ2Ioac4wwf9KKbc+RpAXbotbV0TXaClSeOUUpzZZf/JlwFZxHLc2vbyvgF3hrkuCGmkd6
	5+RicOmqh0eXfoZjp8W0powVhU4ORvsdkIO/58Oqrj/ZkQBqveFGl3eAbY7ztyX6TNCVGMSmFrLi+
	IEByHI+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKwBd-00000000ALY-46lH;
	Fri, 30 May 2025 09:38:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKw23-000000007Kk-17k1
	for kexec@lists.infradead.org;
	Fri, 30 May 2025 09:28:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748597286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MaatFJjQ8egE/8VtOwBSoT6wLagg2lOTiOnjBKEO9pM=;
	b=SGjcQHCL9TkEtLRHNl1uYHuBajy8I7QMy0k7jldx/EUuNotLiKKZe15QROdVuAiUg/zl89
	EZeU9q1uOKAq9SOB2HHMdDyyXfYshegixlT4mqrJPQfg+2iS7SLBULou1Squom94N0IHe0
	Gh5DygbopDp43FJ+9kEfR2W7r8HXZP0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-HigEib4_M7SydLdkhmavjw-1; Fri, 30 May 2025 05:28:05 -0400
X-MC-Unique: HigEib4_M7SydLdkhmavjw-1
X-Mimecast-MFC-AGG-ID: HigEib4_M7SydLdkhmavjw_1748597284
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a364394fa8so695841f8f.0
        for <kexec@lists.infradead.org>; Fri, 30 May 2025 02:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597284; x=1749202084;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MaatFJjQ8egE/8VtOwBSoT6wLagg2lOTiOnjBKEO9pM=;
        b=jjkDrNj2ikFBIwNF8W7FXBvIAkFnIUlotVgwHOZUjO9b1iMOgk/rNv6mMfLXYVBL72
         /QxbKepZWZmrsuSlgROwJgKpx5yavVefg511hH9OSzvO5bTDiK8eTFf4taxSTgpHx4eE
         f9ACuNVZxkp/M2ElqwkMWiJldaLC4g3J2wqjLr5QxrBZKTncoX5mcxqaHSc484WIMaBH
         pYhrKBETtgHT/CXKYZpp0JGWwwb28hJ2AR5ok0i/M7l9KAq22DSLsvCSMjcEwa9E8NQS
         CU1mT8t8w2dEeg3rXV9kpagyYx69za4ExYSAtWSsfQo/UvoHlFtYeZq2o6hwwO5Ndk/k
         Nqjg==
X-Forwarded-Encrypted: i=1; AJvYcCVHhLt3GjpwCa+RFHCbMgUvYdk992u6IZrO5jHAztTQWZd8DIg8onpksk6fRryr+iAHAmEI9w==@lists.infradead.org
X-Gm-Message-State: AOJu0YyGnAtWuT13ShrI4XdJ71sUELoPFo3wnVqf9WnHYmPgBZwuuqPg
	EZ+bWvAgiJCPb47HGnDnMvVuF9KyGtvL7TFtH0Ex8rqfQSSB9mTe2Od6EcwgrQRzRKpBtSQ2wCA
	MicnEdU07itzMCGIrfKvi7lBVMKw8vIv8evLpS/j7VussTdGasfovBrIFqjQBPw==
X-Gm-Gg: ASbGncuDDIqQ9IQkOPtCNl0MopVcaHjmo0htHhtqTGmql9Mwf931o/VuCyWkjfotrMs
	ndR22wwuJHwXR2wosiQLhK6y9AlbEXgBjuw3PnA+4DTcLHBTQYEIKyx4DzyqUhqyFuKEnZ4m8nm
	5sS76qFNUHeZ6AD6fTVT4ex6a9Oq7txCAMVhyzdgP3nSwAacrE5rWB5IIGCB/QZIPXms6dLxx1a
	RpiPJwAB+A3qcSC6dQsIiwbCoDdUduTxfQzEKHwuYZ18W2RGEMyEB0nBbc3yRvpqKGmKNqTaJ5c
	1kzhuVqnynrEyXLrp9JKG6avRTt0EahyM0w4f9jTU/ljFDnHU6sNUnKPwo5wy5ItdTDvi2c+GkG
	Jv3ctjvfd6RgTYnpWwH4uqjnheOVst7VauALgHVKK/NNx0SiQhA==
X-Received: by 2002:a05:6000:230b:b0:3a4:e318:1aa9 with SMTP id ffacd0b85a97d-3a4f89ead67mr1079179f8f.59.1748597283680;
        Fri, 30 May 2025 02:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSN415fVjodgeAGej8jr3DGQGkFoBTJfuX+0MivXSEcmg1XYg2YU3IQl5r7q4efo/bqIG2xA==
X-Received: by 2002:a05:6000:230b:b0:3a4:e318:1aa9 with SMTP id ffacd0b85a97d-3a4f89ead67mr1079154f8f.59.1748597283295;
        Fri, 30 May 2025 02:28:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f03:5b00:f549:a879:b2d3:73ee? (p200300d82f035b00f549a879b2d373ee.dip0.t-ipconnect.de. [2003:d8:2f03:5b00:f549:a879:b2d3:73ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009757fsm4336476f8f.78.2025.05.30.02.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 02:28:02 -0700 (PDT)
Message-ID: <2fb04e1b-8ce0-4216-9255-fc09c04e860b@redhat.com>
Date: Fri, 30 May 2025 11:28:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
To: Michal Hocko <mhocko@suse.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Jiri Bohac <jbohac@suse.cz>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
 Philipp Rudo <prudo@redhat.com>, Pingfan Liu <piliu@redhat.com>,
 Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <dhildenb@redhat.com>
References: <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
 <427fec88-2a74-471e-aeb6-a108ca8c4336@redhat.com>
 <Z8Z/gnbtiXT9QAZr@MiWiFi-R3L-srv>
 <e9c5c247-85fb-43f1-9aa8-47d62321f37b@redhat.com>
 <aDgQ0lbt1h5v0lgE@tiehlicka>
 <a1a5af90-bc8a-448a-81fa-485624d592f3@redhat.com>
 <aDlsF5tAcUxo4VgT@tiehlicka>
 <e0f7fc1e-2227-4c6b-985a-34a697a52679@redhat.com>
 <aDl1ViMpK_6q_z06@tiehlicka>
 <04a49de5-eb79-431b-ba5b-eae2536781c6@redhat.com>
 <aDl5rpqCUyf7nX2M@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aDl5rpqCUyf7nX2M@tiehlicka>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mLqOnonx9tEHO2yLaX78n8qpXt2Fk_X8aoguzPu9_Bg_1748597284
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250530_022807_389514_C629140C 
X-CRM114-Status: GOOD (  14.07  )
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

On 30.05.25 11:26, Michal Hocko wrote:
> On Fri 30-05-25 11:11:40, David Hildenbrand wrote:
>> On 30.05.25 11:07, Michal Hocko wrote:
>>> On Fri 30-05-25 10:39:39, David Hildenbrand wrote:
>>>> On 30.05.25 10:28, Michal Hocko wrote:
>>> [...]
>>>>> All that being said I would go with an additional parameter to the
>>>>> kdump cma setup - e.g. cma_sane_dma that would skip waiting and use 10s
>>>>> otherwise. That would make the optimized behavior opt in, we do not need
>>>>> to support all sorts of timeouts and also learn if this is not
>>>>> sufficient.
>>>>>
>>>>> Makes sense?
>>>>
>>>> Just so I understand correctly, you mean extending the "crashkernel=" option
>>>> with a boolean parameter? If set, e.g., wait 1s, otherwise magic number 10?
>>>
>>> crashkernel=1G,cma,cma_sane_dma # no wait on transition
>>
>> But is no wait ok? I mean, any O_DIRECT with any device would at least take
>> a bit, no?
>>
>> Of course, there is a short time between the crash and actually triggerying
>> kdump.
> 
> This is something we can test for and if we need a short timeout in this
> case as well then it is just trivial to add it. I am much more
> concerned about those potentially unpredictable DMA transfers that could
> take too long and it is impossible to test for those and therefore we
> need to overshoot.

Agreed.

-- 
Cheers,

David / dhildenb


