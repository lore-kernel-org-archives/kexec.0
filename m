Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2898FC87FCF
	for <kexec@archiver.kernel.org>; Wed, 13 Aug 2025 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EtnmbZJ2E4MnFZ5JyBATuJlPVIa5kF959pZ9xSlJ/bY=; b=ygDg0M8HoqEIjzB0vASAFNsWvW
	9sitZ06iGKj5PYJTDO9hGBmfLr9tPbFO3OlzSN9w00ZcMVUcgr3+k0VTn3PLRVshOHZwKevmIra2o
	+IwhsU41IAFYc0i48hivaDFQeN7cGOLtQ16zr3/8H/N25TQY6Mdc47vaVBIoEbJpfRw2aLKXUdn7A
	rXeIi4ZMNWy5h74BnmPyef4bo/b5cwe4Fk0uxzLqHI4mJ8LhqgDWPziYdtv9q2mFg/tvBSscn8W2C
	070LT3NbOthALOwSLDZL1dCoRlFW7B9ae97vHJERifPKEA7igaXQrGEQ7r1CFLRUnDpS3boybpr1x
	91eL/v5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umCMM-0000000DtYx-3U91;
	Wed, 13 Aug 2025 14:21:46 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umBnJ-0000000Do4c-03v7
	for kexec@lists.infradead.org;
	Wed, 13 Aug 2025 13:45:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 41D1CA5760D;
	Wed, 13 Aug 2025 13:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E37C4CEEB;
	Wed, 13 Aug 2025 13:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755092731;
	bh=D0xx7031UZevoMdpdp6ryj7WTHkAul4ivyREJrKlUK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lZX7OAEO4iV5S1+YXwOnpNeXysrLeSryC2YE5VkGmWFuQ1wIf+WHQIRsPfY64kEvv
	 QzcQMAowqKlFIJSrHE1eEuBK6vW1P1AekwkoCcjrd4HOlzlC6jenE3ECVGpLYdDivk
	 qyjpj02i46dkWEnCNEDjQSNs/9x6Jd21DB4k9HTMhz5nsiU0DfPOYMHteLZ1wJLASP
	 qpUPUOOVkMdmZ1Z9ow7qaMytrTTWQK6SBmBQ51D/RRDYYx10iAwqrguOIiiU8j9v8N
	 4iS480IBHW3v/cY6/gPBGGopu5lpSm9aIIhXlxXD27EoChcg/w8dp4NObDJYFg5pZk
	 akcmTCNvjNGFA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Shuah Khan <shuah@kernel.org>,
  Thomas Weischuh <linux@weissschuh.net>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 1/3] kho: allow scratch areas with zero size
In-Reply-To: <20250811082510.4154080-2-rppt@kernel.org>
References: <20250811082510.4154080-1-rppt@kernel.org>
	<20250811082510.4154080-2-rppt@kernel.org>
Date: Wed, 13 Aug 2025 15:45:29 +0200
Message-ID: <mafs0349vwd1i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_064533_123180_36CE6E92 
X-CRM114-Status: GOOD (  19.50  )
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

On Mon, Aug 11 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Parsing of kho_scratch parameter treats zero size as an invalid value,
> although it should be fine for user to request zero sized scratch area
> for some types if scratch memory, when for example there is no need to
> create scratch area in the low memory.

Can the system boot with 0 per-node memory? If not, then perhaps we
should only allow lowmem scratch to be zero?

>
> Treat zero as a valid value for a scratch area size but reject
> kho_scratch parameter that defines no scratch memory at all.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  kernel/kexec_handover.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index e49743ae52c5..c6ac5a5e51cb 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -385,6 +385,7 @@ static int __init kho_parse_scratch_size(char *p)
>  {
>  	size_t len;
>  	unsigned long sizes[3];
> +	size_t total_size = 0;
>  	int i;
>  
>  	if (!p)
> @@ -421,11 +422,15 @@ static int __init kho_parse_scratch_size(char *p)
>  		}
>  
>  		sizes[i] = memparse(p, &endp);
> -		if (!sizes[i] || endp == p)
> +		if (endp == p)
>  			return -EINVAL;
>  		p = endp;
> +		total_size += sizes[i];
>  	}
>  
> +	if (!total_size)
> +		return -EINVAL;
> +

Looks good. BTW, unrelated to this patch, but should we also check that
p == '\0' here to make sure the whole argument was consumed?


>  	scratch_size_lowmem = sizes[0];
>  	scratch_size_global = sizes[1];
>  	scratch_size_pernode = sizes[2];

-- 
Regards,
Pratyush Yadav

