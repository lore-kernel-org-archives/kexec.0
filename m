Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885C7C44507
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 19:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IV+eVU/BHEvjC83dTcoXEiFif2QrI2TpFVMZfUeCzig=; b=4GuhRwKlldy6u6JsJyzkCcloti
	YWoIqV5ftoPSJaHrtjyN8o1z0nIiR4VJvnuIT5YsJrxMff9JunvQb7QARLe3XebzpYwfOGPhU9UGH
	qrf0eLg9fmYA5o8eq5vx94vwT4PLMHpmtyB9s7n0BNkLAa2ty73kU1ElXzdad4JlyE5ebdtxoNdsU
	fHUqVlLitmFwDSsv1R7uWkwf9ghyah/ZeGFtiC0SJUmCqWs5/7aOJkriMRkWMtQ/FgqGz4afc52Hm
	rnFVZXlBdzW4X3WumxLmlFYMPIz/hf2xVsAoa9VxjbhzBIl98Q4yrz9aJN0y28POS/VpM2JRJZOBc
	Y6jQDujg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk5l5-0000000FqDF-2KST;
	Wed, 15 Jul 2026 19:59:07 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk5l3-0000000FqCf-1JoP
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 19:59:06 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2cacef7d299so2755ad.1
        for <kexec@lists.infradead.org>; Wed, 15 Jul 2026 12:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784145543; x=1784750343; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IV+eVU/BHEvjC83dTcoXEiFif2QrI2TpFVMZfUeCzig=;
        b=mYcxZ5MzwU+EHkC4h4T0TRwYMJExlEjgTi+qGBSW5HLIiiiAvIoKyos3Vhn1msgACh
         9hn/SX7FZhiI6R/jdWuL67bXoEgvysmPziVFi8HcAhYhV+Miol0JtAZltIW4cBhAHsd4
         9uMu+Ck4XS0ZbYSCa+yJiRodJ4nkJrV1BbpMNRA6SgwXYKRnyPvKvBQou2LuQDh5OKj5
         EQUoW8AzP2MB6rj6iURdKpTHQY6C2/N7pz1fZoJSVA3To0knLgRFTyGMi+6y8D/hSNa0
         euMOODCPz7TRXRw0H0ek38Ba5OAjRVeGq1mT3GeOMrkUcqC9iF/HmSdd5GT7SCwNw51z
         SutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784145543; x=1784750343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IV+eVU/BHEvjC83dTcoXEiFif2QrI2TpFVMZfUeCzig=;
        b=qoo/2P6PUZM22HkxW4b/IySyyy2YaLbDK158Hn/dyCoK7kQQxu6A/mFO2lqOktG5UG
         uOkMj0IfBl66ijMFYRC1D01PPWhdUjaVFqQoOxB1NXvQWDuCXlxrWf1T1aa9LJE4rhUS
         el26PkUjpKabVxH3JS9MsgTtMJpBepVl92+Z7VRn75yYlZSviMsqXVmLsxEotdpz2cbq
         4OGfVfWdof8wWpp4iLaAwSpMr7GUyYtBGoep8XzPx8ZWbYSKfmqSi6uDofXClrPv3NuJ
         gSJbqEYuBadtb82FIUu//PU6pD/89ysjkzWj1n5TEgJlRzRYEdY6H2biAQfEZJDeioxt
         +p9w==
X-Forwarded-Encrypted: i=1; AHgh+Rp53kcH2mQ2EsBW6QY850mL8byZ/RfHgqzNQWxFMoi6ybRhAOSAKPjiHypljolodenvFVbJIg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxZ3pEw0/obh7Lmldj5uyn/5Lm0/K6Nb821H/d2yr+pAQOfeodP
	64NYEVKdfPK6nx8C/M2cyt0lsk2nlST67rphxeQcmLhdgYDzKtkJqMX7PqgtXrojcQ==
X-Gm-Gg: AfdE7cn3FULLiwY01hlQNrXnwc5En+sky3YKJsE5yRxzh5TD0RQDukmXLKHJp6JcZaO
	u3g7yc4p7zhMlJrP88FvUE4tnx+s2aAtvZBKb6T6tgI4Qu7ZkwG9fJIZf4LNZhMqB/sO98/zYQ8
	tCc/hW0kdyZgbeQ4rCTJ1y7iZkg9MWDH/FQRXB8i3yCh515VYUls7vdXDJLCBWAf76ooAtNqe0k
	EMb8s9PlPcloCjritTXFwF9U0GAIMW8LI0aNAO5S7cfHudcd+Q16TYOAuuWXgNRgEb5vDUe1DZp
	t88h1F2ou69m6nr3yEJyxd2GJ20BqSyivuL9GKA5RHh1RHD3WcsAfeVv+OVpuQ3yoLANBQE/wCw
	Ou1tRqiH0BPYX7EBBc/4AO2hBrjYEGXFUeMi8r6yLkUOeb0/MXlafFyA9Wa0LALMLnCbxmHkUwU
	yNc1lnkXnIy3IzPXJpchH3fZF1YXYRst9lFZFy1bUhUknCQuGgGaPwN1gx8ZbPsJK78u3FjFbqd
	reMAs3sD5I=
X-Received: by 2002:a17:903:2b0d:b0:2c6:cbcb:bc72 with SMTP id d9443c01a7336-2cf1abf6570mr468465ad.23.1784145542863;
        Wed, 15 Jul 2026 12:59:02 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e2a06182csm807385a91.0.2026.07.15.12.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:59:02 -0700 (PDT)
Date: Wed, 15 Jul 2026 19:58:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH v2 03/10] dma: contiguous: Add API to check if an
 allocation is from CMA
Message-ID: <alfmVTYNgoP1GHQY@google.com>
References: <20260708234854.4044652-1-skhawaja@google.com>
 <20260708234854.4044652-4-skhawaja@google.com>
 <20260715062116.GA21348@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260715062116.GA21348@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_125905_366007_91E73D4D 
X-CRM114-Status: GOOD (  13.63  )
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

On Wed, Jul 15, 2026 at 09:21:16AM +0300, Leon Romanovsky wrote:
>On Wed, Jul 08, 2026 at 11:48:47PM +0000, Samiullah Khawaja wrote:
>> Add an API that uses cma_for_each() to check whether a DMA allocation is
>> from a CMA region.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  include/linux/dma-map-ops.h |  6 ++++++
>>  kernel/dma/contiguous.c     | 24 ++++++++++++++++++++++++
>>  2 files changed, 30 insertions(+)
>
><...>
>
>>  #ifdef CONFIG_DMA_DECLARE_COHERENT
>> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
>> index 03f52bd17120..0b1702bf39ca 100644
>> --- a/kernel/dma/contiguous.c
>> +++ b/kernel/dma/contiguous.c
>> @@ -130,6 +130,30 @@ struct cma *dev_get_cma_area(struct device *dev)
>>  }
>>  EXPORT_SYMBOL_GPL(dev_get_cma_area);
>>
>> +struct dma_cma_check_data {
>> +	phys_addr_t start;
>> +	phys_addr_t end;
>> +};
>
>If this series is retried, use "struct phys_vec" here instead of
>declaring a new structure:
>https://elixir.bootlin.com/linux/v7.1.3/source/include/linux/types.h#L173

Sure this sounds great.
>
>Thanks.

Sami

