Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031C606B2C6
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e/T8MaId;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pq20fc31
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Zy3RXc1tcA1988kqstuh2d2K+SulFtJvQ4wEaNytXWM=; b=e/T8MaIdukwra7
	KS46nXwYdc/NM0UjJZIyrbhjt91IYsLwl2Bz4AdFvjhSEQGzjM4JA4lI58ag0NMY0H3oN2JOTRw1t
	XU3EfOycEiitoqOydSUCITFeGdxG3rZx0sdvBV3qXIAbJA+tzaSxXUd6pt6hQPEUCZOQDQ+++VJcl
	3fABZwukB7yyeyy4gtPfpCxSoWfNE0Y40eiLfKSxi4YrF+asaQGDT6hN82UufDGMdghGzHXavcp4C
	UZimno4cdLVdGmSD0345nQTmwl+69G+OK6T66jIy6cQA4DV1HiZAUAX9ZavsGqEHpuo0ePk4hV8g1
	Q+mIugQDmFth1nyTIxNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjIg-000000078ix-3Zjt;
	Wed, 04 Nov 2026 22:17:46 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjIc-000000078iW-0OHf
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 22:17:43 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso8442825e9.1
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 14:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830660; x=1794435460; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zy3RXc1tcA1988kqstuh2d2K+SulFtJvQ4wEaNytXWM=;
        b=Pq20fc31H23yLxGlbPWRdLjVzf9BQrlGgS1ZVsaN6O47x7XDdCqsyG99JdsiHwy75N
         HvJar0QSDbT8cVl5NalEfFtc5kYt3rsAF6ZIa+vLzvglNq4dUVOQ9z4Re6hO58uPFsRb
         sZZklKpdSExR2d/3RWJ6uiRYjwmCZA4S1CeZ7BfS2qW/u2+6SzYwMjBL641frx/4GPj+
         Ib32FqsVLyOaegtQdsagEseDnKkXyao5PI164qtKabTUenn2gQ+R4yUmRmaelzmopVa6
         WLcuFrALzf64wcDhQ8N/gx4RptNY7n15aAECoLZi+KUUtwbiZFAgp9HCKLBGEstvO4Zd
         5G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830660; x=1794435460;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zy3RXc1tcA1988kqstuh2d2K+SulFtJvQ4wEaNytXWM=;
        b=Swk3p3CggV1pcqnGpEsQ9rYCh11yyoCqmtjKd3LE9CNnwHWudQUx4/ROErqsjR/tPp
         6XzW2tg5UMGIbKmLRsrBEaycFC5wE4cQ1M5e173uZBBj0S8SjwV3dJ2n6my3YHwKFAsO
         iPnAqMNuFCmoqn6lrSS42mu0bVI6PafiGk3SpFi/rAEdQWbL1unLH2xD0TDjWt6BrilV
         KCxLZ+wClDbkvbnps1ujqFOWtBl0VexoKfpGCEo6CC32tt6iD/1mvKBeRAyMd17NZadR
         DPoMXel4fHDLzXBsQwlaRheOygsgeu8EufbN4E494E+CVTe+8Lz6n33bZOM96G7rReZA
         5fIg==
X-Forwarded-Encrypted: i=1; AKwUvBzPQEjX9qGJ3vRGxc+I5oUGjWvBM0Xe765AxxLAYm80bH8fJIIUxDfbHpEtjjN2KJ8eE0Kl1A==@lists.infradead.org
X-Gm-Message-State: APuU4Z+yC4PNYlkUA0woqHtaE8cNLelmKZxsMRLdWG8JBfGt89VkuBbC
	8sTJl+NwheWCB4MYBfSvmH/U3heISE9UT9i0jnxfbaeqwMuwgUxFm8Tl
X-Gm-Gg: AYBFou0KG6M7dOaLkuC1jq7q/Xf1h4ly0M5PbePMBNPwEMUR/1B/OlThT7JeOKhY8Et
	/WZ9jgz5dhHUqKCy0395MB5tdN+t3WGpaH1xGyzcNUJxyPNb41nouXvNI61qE8sQm4OhCtOwV8E
	VM2D1EWjt8chc7EhQvIbw+7suUITsRE6fc/cmtVCNH1gr9WPaAFQvXQeYfyQxhuWxSllN6da5iZ
	SpXaQZBJx/wX8vHwgutpbDhJELuF7hknSbP+AbxEneDQes1wyl/WXEDYFcmaVS95uEhoPU5oiV1
	tRGa7SCSGwwGhz9wR5FAYjzzrsLpAFr9jZ9AatBJN3zMctIwTQngUiPSuYzKUfUWzZmWrOwxrEU
	GoSbYy+5DR3Qbn2K19DVIdA1y7qHe1tLcKDNp7/VrWpk6+NDP1xqAT5Bx+yJ5ShfqRheriEeYQJ
	TdRXikh+mFzn7S3XYvzrWgk0HrQnlHuxGkQAY6evaSPLFd/ryzmkiDQ2TX9K8QHqCFLyyAfUA8J
	FWIoPPesRFyUe5Z/AXiHRMlrvRrn68hSJ75FVfKa3gispEdcF11H/zkVLUZ6St0b1OTPLYDGWxN
	GBfZ1cVaMfG/g0E/k4tctnQE
X-Received: by 2002:a05:600c:1f93:b0:4a3:2f35:38b6 with SMTP id 5b1f17b1804b1-4ac180f1e69mr370561825e9.24.1793830660020;
        Wed, 04 Nov 2026 14:17:40 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56b78d656sm16661715e9.0.2026.11.04.14.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 14:17:39 -0800 (PST)
Message-ID: <7b3388a4-31c1-4966-af92-367e1219cb42@gmail.com>
Date: Wed, 4 Nov 2026 23:17:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] kho: fix bootmem sizing
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>,
 Kexin Liu <liukexin@kylinos.cn>, Sourabh Jain <sourabhjain@linux.ibm.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
 <20261104-kho-bootmem-sizing-v2-3-b0d1a834780f@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-kho-bootmem-sizing-v2-3-b0d1a834780f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_141742_175021_0EC10D4E 
X-CRM114-Status: GOOD (  16.48  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 5:50 PM, Mike Rapoport (Microsoft) wrote:
> Bootmem areas are sized from overlapping views of the memory reserved in
> memblock:
> 
> * the global area is sized from all reserved memory, including memory
>   allocated on specific nodes, so on NUMA systems everything allocated
>   on a node is accounted in both the global area and the area of that
>   node.
> * per-node sizes are calculated after the lowmem and the global areas
>   are reserved. With CONFIG_NUMA=n all memblock regions belong to node 0,
>   so the lowmem and the global areas are accounted in the size of node 0
>   area and scaled once again.
> 
> As a result, bootmem is about twice bigger than it should be on NUMA
> systems and about four times bigger with CONFIG_NUMA=n. On small systems
> reservation of the bootmem may fail and then KHO gets disabled.
> 
> Make the areas cover separate parts of the reserved memory: the lowmem
> area covers allocations below ARCH_LOW_ADDRESS_LIMIT, per-node areas
> cover allocations above it on each node and the global area covers
> allocations that are not bound to any node. Calculate all sizes before
> reserving any of the areas.
> 
> With CONFIG_NUMA=n the global area becomes empty and it is not reserved.
> 
> If ARCH_LOW_ADDRESS_LIMIT covers all memory, as may happen on arm64, any
> area can serve lowmem allocations, so don't reserve the lowmem area.
> 
> Bootmem sizes in MiB in x86 QEMU VMs, before -> after:
> 
>                      CONFIG_NUMA=y     CONFIG_NUMA=n
>   1G,  1 node         176 ->   92       320 ->   80
>   4G,  1 node         508 ->  332      1264 ->  316
>   16G, 2 nodes       1268 ->  704      2944 ->  736
>   32G, 4 nodes       2296 -> 1224      5196 -> 1300
>   64G, 4 nodes       4344 -> 2248      9664 -> 2420
> 
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Reported-by: Kexin Liu <liukexin@kylinos.cn>
> Reported-by: George Guo <guodongtai@kylinos.cn>
> Closes: https://lore.kernel.org/all/20260904025101.9959-1-dongtai.guo@linux.dev
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Closes: https://lore.kernel.org/all/20260922131217.698809-1-sourabhjain@linux.ibm.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a

