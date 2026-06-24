Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365EBCDE002
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 19:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2aGwSxMPCxEakwoSKIAkNM8dD8i9uBjtEeqjT8n3zZc=; b=zcjngRmZNU9vkgJNj1l2TaZfqW
	zgG7TmMSwzeDHQUrXz3UIZataaAgI+T2iu1g9nvUu3YV982x+T0rl+qsysXt/WqF9WBITnLU4bonB
	L4Wvx7t2cd2MmOWQQJChsK6nvB/My7Xmq4HkzoMELNpXSlc20URiBAFk2ZLrNHYQi5etRuXTzM6J6
	xbe7AIOcGmS0qjQcqp05IsT8f3WjXo34PyDgTtCXI8cdjauW6YOu0MUc+/KIGVqenbOmUh9E5KFIg
	8RQho9g2FHLVfrVN7uoJilJpEav/HL/otUnWLIM4lt0Qk8G36z7sF4o7ttzV6pLjNrlvjTGPemR2j
	eIU3JA9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcTYv-00000008I20-3bEu;
	Wed, 24 Jun 2026 19:47:05 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcTYt-00000008I1H-0QCg
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 19:47:04 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2c73cefe192so775ad.1
        for <kexec@lists.infradead.org>; Wed, 24 Jun 2026 12:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782330422; x=1782935222; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2aGwSxMPCxEakwoSKIAkNM8dD8i9uBjtEeqjT8n3zZc=;
        b=nlFNHLwLj1beoVefeMnMupaBL0cleOgOwR5bhrJzBJ/D123slxE4A/6iUScSmxaHI2
         dFCBej9wtUtw6POzW3uCbp+yuVl24Tnp0sBpCxjIe1/qfC1D5RnJdtblG783crfoQSeY
         c9FZdbKHjHE8uWdptf54F8Um1/th9l6cJgU7G/pr4bpz04zkqxAPmoX8Dlpmtq6Zvg/K
         6DS8uSxBvvryO2dX8EcjRRopefFdP4xY7sz9YA2zRNMXUI/3uNvAhLXVBiCJ9hXsehR0
         3PWOIxIaO/PfQSv4r76qv/THOfXgojMQWypf3EDNuX5H8UOO44CG3U9UOmQagBKiQiCf
         augA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782330422; x=1782935222;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2aGwSxMPCxEakwoSKIAkNM8dD8i9uBjtEeqjT8n3zZc=;
        b=h0gFAct/AfxAyhSq4rScRYyqfTR7lmm8GG0z81Q+TNwVnVthOagTj6bKnsClNIsOze
         PSTTu1HjD8ry8irpOXRH9TmCKbQpC0q30GuU7CXi0ao8s0C3jSIJKS6JhzKli9okDacB
         XiIFAZP642QBIfIiKjpRTxuxC39tGKHbBEravoupk/ywqgkkKyrYtoh9y//G1rkyXgjx
         bIhRe5qC9wivM9+FyME96ql82LY19LiIOk40OaIJkMAp0ymLrM0RRmQNsrCSZlX3WAwU
         EpCAjfWLmOUaK9n+y4hpMn4rSkEeG16GMY4wFNHvwxKKJrvraAKrW5MZ0BeoHtxxdwBv
         Cofw==
X-Forwarded-Encrypted: i=1; AHgh+RrbRrwY/tro1qjT3S4oLq81UQbgXWhzP8nK6uUNrbKIfHjk7dK2NPlEc90QQ/yXjKcgnKd9eg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwCFO3lI2YgihuZjBRTAhKHIVYCIX7GrESLNVdJ/JTXLojl1MXc
	appmaEz8yp9oFJNtftl5RBFK6Htr3oj/Jc3J+M8FheqUyD3TsqNb6XzHbDSwNUHqXQ==
X-Gm-Gg: AfdE7clHmjKJU8V7TzDZ8jI7nB9yuLSS2s8FvgC3WgOF+1M3NIoTqYk2iYg3tSdFUKb
	QVMNwlkyXieP/AB9bR64Um9ZU/u6TcBF4+WbgaAtgxR68YgQrDRL37zfsoJbWIRY0rvmgb56WCP
	YkLZW2Qi7BSdSd8+20tD5MYqUwA080K8RBTyn8hpQOXNylcSsQWvkiCQYPkLSVoRDkhlTFLgkY+
	2Pk8mz/UP30SU4zyF/9DYMxWdQNj+Seq36HX7qLeVTmVSAim9vR2kdsoxyeKITZibpMnsRUbI/X
	Ur7H5ZycEn8ABPx4fhOi1/7kcGSbJpFLaufTGBuWHXHFPdeyldlhxPUId+nx+Hv32KHlwAT5Uoe
	pIjpeogwYDWdx92Zx4YMlZkedU0eRxwduVhtG+tl0AlRat+kwxl9YRH+cBvbM93qIXX+ZryKUML
	I3vOLToDw8lxBfTQFZE32AaNiL+d1vXibQO9BmMM+uQ3gCizmupzwlqWZ+sUnSJnE3KK0TPgpTu
	RN6JvLn
X-Received: by 2002:a17:902:eccc:b0:2c7:f348:2110 with SMTP id d9443c01a7336-2c7fada6dcfmr14055ad.5.1782330421347;
        Wed, 24 Jun 2026 12:47:01 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5b07bdbsm4752985ad.36.2026.06.24.12.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:47:00 -0700 (PDT)
Date: Wed, 24 Jun 2026 19:46:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 1/4] dma: Add DMA allocation preservation KHO ABI
Message-ID: <ajwvUwWo7j2Bsx6f@google.com>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-2-skhawaja@google.com>
 <aicBp4tSyzyYBnzn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aicBp4tSyzyYBnzn@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_124703_147310_10A7CEDC 
X-CRM114-Status: GOOD (  17.80  )
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

On Mon, Jun 08, 2026 at 05:53:43PM +0000, Pranjal Shrivastava wrote:
>On Tue, May 05, 2026 at 12:27:34AM +0000, Samiullah Khawaja wrote:
>> The DMA allocations can be backed by a variety of allocators. Add KHO
>> ABI for the preservation of contiguous allocations that are done through
>> dma-direct.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  include/linux/kho/abi/dma_alloc.h | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>  create mode 100644 include/linux/kho/abi/dma_alloc.h
>>
>> diff --git a/include/linux/kho/abi/dma_alloc.h b/include/linux/kho/abi/dma_alloc.h
>> new file mode 100644
>> index 000000000000..46e61db81abe
>> --- /dev/null
>> +++ b/include/linux/kho/abi/dma_alloc.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_KHO_ABI_DMA_ALLOC_H
>> +#define _LINUX_KHO_ABI_DMA_ALLOC_H
>> +
>> +#include <linux/types.h>
>> +
>> +/**
>> + * DOC: DMA Alloc ABI
>> + *
>> + * This header defines the structures used to serialize the state of DMA
>> + * allocations, done by device driver, across a Live Update.
>> + *
>> + * Only DMA allocations done through dma-direct that are contiguous and
>> + * allocated using alloc_page are supported.
>> + */
>> +
>> +/**
>> + * struct dma_alloc_ser - Serialized state of a single DMA allocation
>> + * @page_phys: Physical address of the preserved pages
>> + * @size: Size of the DMA allocation
>> + * @force_decrypted: Whether the memory is force decrypted in previous kernel
>> + */
>> +struct dma_alloc_ser {
>> +	u64 page_phys;
>> +	u64 size;
>> +	u8 force_decrypted;
>
>Should we also stope attrs in this ser state here? There might be flags
>like DMA_ATTR_NO_KERNEL_MAPPING which would need to be preserved across
>a kexec?
>

Agree, as replied on the other patch.
>> +	u8 padding[7];
>> +} __packed;
>> +
>> +#endif /* _LINUX_KHO_ABI_DMA_ALLOC_H */
>> --
>> 2.54.0.545.g6539524ca2-goog
>>
>
>Thanks,
>Praan

Thanks,
Sami

