Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6102EC5B549
	for <kexec@archiver.kernel.org>; Fri, 30 May 2025 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LYjEslniOeni4abE+UsHa0UZTcNVVAzwzXeh5mikH2Y=; b=hcHHsDUyQSJ8GGI3R7uxG7wrZm
	CB6WWAB51npZsmmOCBoBacz7b7mWmtdGLqbilccXIQRH3lfajr2gad7LFqdZ9Y1TLknrpLQLJBSwz
	h84/Ko4qG04Klydo975P1wigTa046GYWmyHFtzP5sB6N8pq+dzUcQLVYn91Y2O0b/3qE/GE948+u4
	vQ5Fsjzo0p4YKkw3uDi24sbKYU4xvD22vorq3ctUOZmNBuq8M9wZVxovL+Ze1/6QDlPMMFr6Q4WFv
	RspFHhJpcdS8oQp9yrAxri7JctuVoJcGYuZWJIaamRjTY3SxmnSkVdcuLh/LYAN5EBFYbcYa3geqm
	xDjNgAJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKvHQ-000000001ho-3Jbb;
	Fri, 30 May 2025 08:39:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKvHH-000000001hA-21xv
	for kexec@lists.infradead.org;
	Fri, 30 May 2025 08:39:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748594386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LYjEslniOeni4abE+UsHa0UZTcNVVAzwzXeh5mikH2Y=;
	b=VVFB0pFJGtz7+lsrEY6WoAY7kGA00wopmN5oXJYGTSN+B7R3hv5XYIylh8BbQJfot2bWn6
	P3VB8KpC+1cM2ZVUqDgIBGcy69sDT3Jspmq0X7VrSO5McQLcjXSJas/4o6iORQlVhkyfJK
	ekpPElKl6VHPTt5SiExR3jelcA/tzhQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-XbrULVNQMlWq1_O85-mfyQ-1; Fri, 30 May 2025 04:39:42 -0400
X-MC-Unique: XbrULVNQMlWq1_O85-mfyQ-1
X-Mimecast-MFC-AGG-ID: XbrULVNQMlWq1_O85-mfyQ_1748594381
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so11637215e9.3
        for <kexec@lists.infradead.org>; Fri, 30 May 2025 01:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748594381; x=1749199181;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LYjEslniOeni4abE+UsHa0UZTcNVVAzwzXeh5mikH2Y=;
        b=gas88vALjmiVoyqYrMe1aL7qcJXmRaC2DsowZNjy7Sf4S1n/4D3gZ/4Z6fRHb0+qKQ
         dTdv3+guSoeJK8eh6h41bf3RJF3CaYVnY95h2oL/skQ3DjZtvlCkrs/+F0CkwUWAdBrd
         FR7aKSEgrPub6Uh3LgQFovggrsy2uQ86lz2Su1zslbBEMfhlnuXihZC+tsUGx7ci+wm8
         Xf3CQebgQbuEOhPMhjDNu/v6KB4pGB7zhweFHeDxZjwI2/XXf9OL449aCs4bK3i5zrnb
         2PLGsGLau7LRunqG2F3Lkrb5CcwxOg/mkPveIePU9o67c2TbsUPciLeH+cfEgCmG+vKd
         fdhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDL+pIa7ZA9cRLmm44rMCveOO+jqZZ5nTA7bl6ti5R30WMPxyYo1zSlkYCUV58C5GYUQ3wEQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzPENPhtrK+cnK2jK6aCzA4YkWCpgWgOfBb5vz6MGyzHbRa6+mj
	d1aHA2Ne0oBkwK36XfhGMO/c2JhtOnIdjkydu8gRFpKYyNuKD8n8ukOpFF+1mcoUj/M8QMhFjhZ
	ir5P/leT5afTvC+1MYmpRoba2nkUu0z3fRxzsLPFkY1Q4YFbaW3nOGiE6HK9Kyw==
X-Gm-Gg: ASbGncu3wIAf4O0yL73T2TbbURazEvjLNB73bO3Km3O1F+zYNUpTSTDvX4Obiqui1T5
	0Dw8Ze0jmUPK83jyGqGuugrE9XPphDJp7HnHZgaqJm/PbB9Sbp0fZlBiUKstUvXrlba/WC3Uuep
	TAOVnlQo6qr8QQICNnpYGsmzvmky9vNaew8tROL0r15mJaGI9NFdL7ePTxWzjvUcl0bMuOLX1Oa
	ozlSOhPBA/FsgFdZdFGMPWqJf07GW6B0yV/OUkMD9Kwh7sb2E6LJP9W6DhjPFJiIo1QwPig2/Hg
	7023lfa8SppbdyGf+CvNOKJHDjGWY51E6gGtaIgVW+3D3xI9hnyFbP33sNze+16eehCUqk8zyCt
	zu5EZPadSz0MRMaNFILSXS65KlBTswS4dRqZiQHs=
X-Received: by 2002:a05:600c:5248:b0:43d:ac5:11ed with SMTP id 5b1f17b1804b1-450d654fd80mr23207625e9.24.1748594381473;
        Fri, 30 May 2025 01:39:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLznW91MGwFXiEUDCSFpEg0/1xmiD0avrK6gzN2jVg47uZp4IbwOpwG2qxrhw1ng6HInkPNw==
X-Received: by 2002:a05:600c:5248:b0:43d:ac5:11ed with SMTP id 5b1f17b1804b1-450d654fd80mr23207475e9.24.1748594381061;
        Fri, 30 May 2025 01:39:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f03:5b00:f549:a879:b2d3:73ee? (p200300d82f035b00f549a879b2d373ee.dip0.t-ipconnect.de. [2003:d8:2f03:5b00:f549:a879:b2d3:73ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe73f22sm4155072f8f.43.2025.05.30.01.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 01:39:40 -0700 (PDT)
Message-ID: <e0f7fc1e-2227-4c6b-985a-34a697a52679@redhat.com>
Date: Fri, 30 May 2025 10:39:39 +0200
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
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
 <427fec88-2a74-471e-aeb6-a108ca8c4336@redhat.com>
 <Z8Z/gnbtiXT9QAZr@MiWiFi-R3L-srv>
 <e9c5c247-85fb-43f1-9aa8-47d62321f37b@redhat.com>
 <aDgQ0lbt1h5v0lgE@tiehlicka>
 <a1a5af90-bc8a-448a-81fa-485624d592f3@redhat.com>
 <aDlsF5tAcUxo4VgT@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aDlsF5tAcUxo4VgT@tiehlicka>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m2Zt6C9R-_MU69yJaDloY7PECyqC0p83F9lMa1ywjzM_1748594381
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250530_013947_618158_9CE391C8 
X-CRM114-Status: GOOD (  25.72  )
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

On 30.05.25 10:28, Michal Hocko wrote:
> On Fri 30-05-25 10:06:52, David Hildenbrand wrote:
>> On 29.05.25 09:46, Michal Hocko wrote:
>>> On Wed 28-05-25 23:01:04, David Hildenbrand wrote:
>>> [...]
>>>> I think we just have to be careful to document it properly -- especially the
>>>> shortcomings and that this feature might become a problem in the future.
>>>> Movable user-space page tables getting placed on CMA memory would probably
>>>> not be a problem if we don't care about ... user-space data either way.
>>>
>>> I think makedumpfile could refuse to capture a dump if userspace memory
>>> is requested to enforce this.
>>
>> Yeah, it will be tricky once we support placing other memory on CMA regions.
>> E.g., there was the discussion of making some slab allocations movable.
>>
>> But probably, in such a configuration, we would later simply refuse to
>> active CMA kdump.
> 
> Or we can make the kdump CMA region more special and only allow
> GFP_HIGHUSER_MOVABLE allocations from that. Anyaway I think we should
> deal with this once we get there.

Might be doable. When migrating (e.g., compacting) pages we'd have to 
make sure to also not migrate these pages into the CMA regions. Might be 
a bit more tricky, but likely solvable.

>   
>>>> The whole "Direct I/O takes max 1s" part is a bit shaky. Maybe it could be
>>>> configurable how long to wait? 10s is certainly "safer".
>>>
>>> Quite honestly we will never know and rather than making this
>>> configurable I would go with reasonably large. Couple of seconds
>>> certainly do not matter for the kdump situations but I would go as far
>>> as minutes.
>>
>> I recall that somebody raised that kdump downtime might be problematic
>> (might affect service downtime?).
>>
>> So I would just add a kconfig option with a default of 10s.
> 
> kconfig option usually doesn't really work for distro kernels. I am
> personally not really keen on having a tuning knob because there is a
> risk of cargo cult based tuning we have seen in other areas. That might
> make it hard to remove the knob later on. Fundamentally we should have 2
> situations though. Either we know that the HW is sane and then we
> shouldn't really need any sleep or the HW might misbehave and then we
> need to wait _some_ time. If our initial guess is incorrect then we can
> always increase it and we would learn about that through bug reports.

kconfigs are usually much easier to alter/remove than other tunables in 
my experience.

But yeah, it would have to go for the setting that works for all 
supported hw (iow, conservative timeout).

> 
> All that being said I would go with an additional parameter to the
> kdump cma setup - e.g. cma_sane_dma that would skip waiting and use 10s
> otherwise. That would make the optimized behavior opt in, we do not need
> to support all sorts of timeouts and also learn if this is not
> sufficient.
> 
> Makes sense?

Just so I understand correctly, you mean extending the "crashkernel=" 
option with a boolean parameter? If set, e.g., wait 1s, otherwise magic 
number 10?

-- 
Cheers,

David / dhildenb


