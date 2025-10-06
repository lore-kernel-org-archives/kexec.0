Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE0DCCA471
	for <kexec@archiver.kernel.org>; Mon,  6 Oct 2025 08:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ozKbjZymvzxaFGC1L+Ulki1LLDfgmV+JknWAMRxxmQ=; b=NgaENBIUr8VJ7FDAmH0kTXPSoV
	OwCFtzc3oUVeOtkF7aTKgH8xhO2dE7ymN2tIIO4hs+AJ+dAIo2IsfcpbkWZ2qU5eGt8I8oVQ8/SRz
	J+JL43wEzR7ZOjvHZ7e/99t1JUnmdTkbDkIopjC9mqzlAkVp6QqxCkpcA/m2/VgyE0JZfzsWyvUIC
	+wykv7AmlCrBzoEKdmJp63CXqVpitjTzZcbwsH64ndTpf6RM6XdmZZQi770vHAgOM+U0hx9BRhwv2
	r2j/zODXYUUbB0orDZrwsrja6+K91TDIq5IpDwp0ULBkxqdpsXaQlk22b9tXQV1Q4dakQo0z4C+yw
	0yv46/rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5gOg-0000000HAhk-3nsY;
	Mon, 06 Oct 2025 08:16:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5gOb-0000000HAhH-3vZU
	for kexec@lists.infradead.org;
	Mon, 06 Oct 2025 08:16:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759738595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ozKbjZymvzxaFGC1L+Ulki1LLDfgmV+JknWAMRxxmQ=;
	b=hxGp3PkwimCD3mPmKBJvaYpe8/GmcSbZEDcXPLmfgrr4oOYgo0UVPsEcqeVJHuzdc+7pQB
	ndSw9TFZdCH7uQep8NYaXNAsKJAM+VQ5L30Bda3HBrrZK+YepyoIR9b6+aGoibAEw+XU6A
	McsricHOZnV8std/SqHwGL7aNU7wD7M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417--UYmFUzAMVGH_NyYwZMN5g-1; Mon, 06 Oct 2025 04:16:31 -0400
X-MC-Unique: -UYmFUzAMVGH_NyYwZMN5g-1
X-Mimecast-MFC-AGG-ID: -UYmFUzAMVGH_NyYwZMN5g_1759738590
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e502a37cdso31680635e9.0
        for <kexec@lists.infradead.org>; Mon, 06 Oct 2025 01:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759738590; x=1760343390;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ozKbjZymvzxaFGC1L+Ulki1LLDfgmV+JknWAMRxxmQ=;
        b=iSjwOHghTkquEWQpBs6wHPvI+1UnZJyOIK5tPZ++J76DqZSrdGg2C//2Aq+Bldt5RR
         w6uJpWDT0kcF+OXaM5vPgquYG231YOfns9Cv3sfqDScsVLzLeLSoCpTKJ5T5Md8CU5RF
         RclzPBq/KPyqacSks9Mpc4zInph2EIfQ7JHdPjdJc8QeIFnXyWLi7XjnQ52foUWqx59X
         OFH9y2aBBnxrlNzTKkEDfPiKxeeB6feppyqEuFXjmmP5Yw31rShQn6nfBBOYRaLnkIxa
         dvWy1HarcTbUd9bOHXTGAVdQ6jv2MlGSSqe2NrX9wCSGqety8Jm4l0LY8ocS4xv9wNNH
         CSag==
X-Forwarded-Encrypted: i=1; AJvYcCUzNRRgNMx/Yd52RO73OqVWd6V2CGpwez6QDfee6Z2jghlEWlRGPRCfM9Buw0ZVhYK2Qy02tw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5Cw8r3qCJ+54LMyBEF2p+RELJ4prkKrn601m/FOTBRo0qLNrR
	uvxOCIIlhxzxhy6+53loSnkpQkwS2uowDqzB1HoDaPpaWJj0+Ss4z/X8gF4zqleRAIfHx5isVMT
	+XbUgX/sngFPdX/0gAk2i5um6lMS9f57nYcIJlCGn6v8F9NjPDx7ioWbuoeCfsw==
X-Gm-Gg: ASbGnctiwn7qHRO4yMQJm+voXd8hnK5bqa/kNKtejOKtcIwIBrgSra79m4N28lw0pDt
	c8pPsae7z3WfFU323aP26nECesjT6JjcJkArVaFh5LWzXlMYizKHSs3NiPTbFWvl/PokeSTmiyD
	MBOP5hA+sahyFQevASFOMIdHLjuksXpCDNXWIGTMJu2lbfiWFJkzwdab52UfAQFDuaLWWIrVNWj
	QbzqYEQP1RkZ0KfGgdZIQ/2lK8RTOo/Z2/UODCuojx6B76sxjxpoBO8Z1msYRnumOkQIzsZHi7k
	+KgMS/JRHbbYgyret+oRlJ+DrAh81ZXnIC1CVnxiQaI4E3XH5aKqOF0F/pwmkQThbDmdyp9f1kD
	4X2/o1N/ZhHgO
X-Received: by 2002:a05:6000:2dc3:b0:3ec:e285:546b with SMTP id ffacd0b85a97d-425671be366mr5916413f8f.50.1759738590278;
        Mon, 06 Oct 2025 01:16:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0t5/ZRi3WB5iBQu5PY93ByrOhPhQLYlFTkpyWdF95wKH+yZsK2Dv4pSCdzUgOdT6JtNIidA==
X-Received: by 2002:a05:6000:2dc3:b0:3ec:e285:546b with SMTP id ffacd0b85a97d-425671be366mr5916389f8f.50.1759738589875;
        Mon, 06 Oct 2025 01:16:29 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4ab0sm19684661f8f.52.2025.10.06.01.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 01:16:29 -0700 (PDT)
Message-ID: <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>
Date: Mon, 6 Oct 2025 10:16:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
To: Breno Leitao <leitao@debian.org>, Jiri Bohac <jbohac@suse.cz>
Cc: riel@surriel.com, vbabka@suse.cz, nphamcs@gmail.com,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
 akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>,
 Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
 Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@suse.cz>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
From: David Hildenbrand <dhildenb@redhat.com>
In-Reply-To: <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7kay5CuXTvHkHJEo8guaa9Zsdbv6iu2pttmJN8Ifc7Y_1759738590
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_011638_049202_E4FAE35F 
X-CRM114-Status: GOOD (  12.06  )
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

On 03.10.25 17:51, Breno Leitao wrote:
> Hello Jiri,
> 
> On Thu, Jun 12, 2025 at 12:11:19PM +0200, Jiri Bohac wrote:
> 
>> Currently this is only the case for memory ballooning and zswap. Such movable
>> memory will be missing from the vmcore. User data is typically not dumped by
>> makedumpfile.
> 
> For zswap and zsmalloc pages, I'm wondering whether these pages will be missing
> from the vmcore, or if there's a possibility they might be present but
> corrupted—especially since they could reside in the CMA region, which may be
> overwritten by the kdump environment.

That's not different to ordinary user pages residing on these areas, right?

-- 
Cheers

David / dhildenb


