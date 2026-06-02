Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8E6CD6E5D
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 20:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AXf/DhYEKv4KfJHG3trdQ5N+MNYdsl2DFczEDRjtzB8=; b=beJlCS48VKEvDH+aa1HpzyTMMk
	tasOGBAL4ePIt/nU+79AeLbeqHu8ianMjuCdtxzkZMbNe6GKgLYOOjRVMijivZk860zKIidjQU3Ov
	g0/bNJznqN+jxRCB+nCMVrD/cQfefQ4wYtL9syxmelfVQ7nWxBGCkXWmedV/1KBq7Ac0Z8/cQRiWE
	80xxkoAEQufeKwkYSwcO9ng5YWxb8dS+MCDy5wnVxRPr8+5FptjEkuSBnPAx0DnmKTC+Vcbty9OjY
	FYbZWsJZgkfooi/um4Zsp0s6AuAtwRgZB7ACDRlniqunvGKAMm1IOsYS83hcLQgo7PFt7EwLR240o
	NJyxEjoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUVVi-0000000DjM6-0nbB;
	Tue, 02 Jun 2026 20:14:50 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUVVc-0000000DjLi-3kbQ
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 20:14:46 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2c0b1a48855so6335ad.0
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780431283; x=1781036083; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXf/DhYEKv4KfJHG3trdQ5N+MNYdsl2DFczEDRjtzB8=;
        b=cycGTSTIxiWDT2CDb0atnO4Cg+LrQbBqkEhWjwuvuKHeAh7SVIQTaHGDMb9Vidb5tW
         Z0+t6oEee57Q6/eWe4gRLgsMo0pbLpvg0+UvlCe73qHxR+X1koJ8UxGEzsw7FwwYp0YA
         EFT5DN6i+EXnC3Z3q6Z0GXfQfzvSW+h0PwO+ClGwrf/czW+rJL4v7avidfAYTWF0ow8R
         oaIhjuX4eJe6Thx5o67pCsF1Q+Qtzs31Vmm5qYjVpF5AqnPQCtRxsAjKmX0DLRJD8EJV
         VLzn4oArcwMk3vy2d+Z/Kv8koC/CxAUKCqovAv8DJMSppxwI3HaK8CqJCRAwByotrBvj
         ucBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431283; x=1781036083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXf/DhYEKv4KfJHG3trdQ5N+MNYdsl2DFczEDRjtzB8=;
        b=cmrUO6alFs8vxO7/EbEXUgiZSpK1XQNZyOILwhHNLLkukXQ+3cFWjKSyvQUPYvfAZi
         JFewrB0LJ9MB3w3xnfCSsrfIW4TnsVZcVViWAOWLki702HTuJwU+3gx19ICa9JdVDpBc
         bWqzLc7x90v8M31VBCOx8DWceXFW6hK2TSZJSeT9BJxFJfB9SQsrV2e2OaSzyLF6KNIb
         MgWdvGyjyqp2x7Hec7nJj7Z6E5o/pXWgGs/78Ay/BcC+VrV4QFhVG0P4JTqq16WzGzkr
         THBHhlSLsy4SEnZboZRn7d4aecf4KfsBwaRmejT5fBX5kWHqmoolat4tawux/juYwzht
         LU7g==
X-Forwarded-Encrypted: i=1; AFNElJ/iO5qf7u6LhwXAcd89F6OPLcT/O9HH40lV2fopdRUJNEjZHmNcmayTArB1K3E8gAlKFWPLFQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyDbfaEjJ0YTOPFZKnFCNMRMADHUCpp5m6QZGNsYdGIQgEtkPvC
	ZuDAx/h6dtKvwhf7d4y/kTyiNvEAePLTjdhHXmN4WcnCrpEHUgsXoNb9mUnbF+lYpQ==
X-Gm-Gg: Acq92OHYCspFsFx5bO6YO6dyIqqWIAD2bQGVGvVJSwcEfS1Iq3wbLfv1IwvoQ8tXcrU
	DNE3KQT4F4tGnktWWiu1PMgcOQaZkF7+s9airoKyW087uVhnNpa84cRGrUheKvFpjZK57xaOj95
	mmc5nW7kJuSVnwTALybzagbVcnk3HHHwP5if31hyQi79x8yNC9r3s1DFlDcZBg1nWDhPTVwBLZp
	JaTm5faIb0YDaU02C98pClq772t42eowcqo1arW+ndA3qEllM0SdLyMQ8t2xWROv8xfchOKHdnF
	oyCkI9FGQST4PGGWTW+P8BWg+7LwE4K/p9+qC7daKTGtmQ7DZm9O/4l6HGO4fWREINH+jcjwSq0
	9Mfwfr7wCplBMA9XNfD+CkK7/TtrSSmj4Q4MxE6nFk0OUZoRBUPWPufbp0HKOulVzkDpTmPgF1S
	2e/4cDsWHN+T2kAXhtFX82YZ0QdPIjCn2U2fxQX8YW7InJ+sSLEOD5q/E7yqV2xSbb4fAjvxkXT
	cOG4tHBbKboRA43VztwKaklY1rNag==
X-Received: by 2002:a17:902:f70c:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2c10e8606b5mr4060495ad.10.1780431282360;
        Tue, 02 Jun 2026 13:14:42 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a63b3sm90737a12.21.2026.06.02.13.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:14:41 -0700 (PDT)
Date: Tue, 2 Jun 2026 20:14:37 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 3/4] dma-direct: Add API to preserve/restore
 allocations
Message-ID: <ah8srv7dvO4OIii8@google.com>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-4-skhawaja@google.com>
 <ah18hDhjSLxIvb-Y@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ah18hDhjSLxIvb-Y@willie-the-truck>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_131444_933612_EE2E434D 
X-CRM114-Status: GOOD (  14.46  )
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

On Mon, Jun 01, 2026 at 01:35:16PM +0100, Will Deacon wrote:
>On Tue, May 05, 2026 at 12:27:36AM +0000, Samiullah Khawaja wrote:
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index ec887f443741..c2b98f91900a 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -6,6 +6,8 @@
>>   */
>>  #include <linux/memblock.h> /* for max_pfn */
>>  #include <linux/export.h>
>> +#include <linux/kexec_handover.h>
>> +#include <linux/kho/abi/dma_alloc.h>
>>  #include <linux/mm.h>
>>  #include <linux/dma-map-ops.h>
>>  #include <linux/scatterlist.h>
>> @@ -307,6 +309,167 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>  	return NULL;
>>  }
>>
>> +#ifdef CONFIG_DMA_LIVEUPDATE
>> +int dma_direct_preserve_allocation(struct device *dev, void *cpu_addr,
>> +				   size_t size, dma_addr_t dma_handle,
>> +				   unsigned long attrs, u64 *state)
>> +{
>> +	struct dma_alloc_ser *ser;
>> +	int ret;
>> +
>> +	if (!kho_is_enabled())
>> +		return -EOPNOTSUPP;
>> +
>> +	if (IS_ENABLED(CONFIG_DMA_CMA))
>> +		return -EOPNOTSUPP;
>
>Hmm, it seems a bit overkill to do this just because CMA is compiled
>in, especially as it's user-selectable in kconfig.
>
>Maybe you need to iterate over the CMA areas using cma_for_each_area(),
>similarly to how you do with the pools?

Agreed. So basically return error if the range belongs to one of the
CMAs. I will update this.
>
>Will

