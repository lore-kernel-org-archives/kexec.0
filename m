Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB690C88E66
	for <kexec@archiver.kernel.org>; Mon, 14 Sep 2026 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2tDaQC5rOBMjovUfpSgyJBpDCsNvHvjcik21L72/Adk=; b=HVri/zkXLuNatC0r30yibT3cNL
	Halamufr8gxubrq1pPtPzQ32wkA0pYzdfQ1jAyfTQRMXBctpqvyQruEgbNw8myQfoqs1XUYdFA4Xn
	lVYmwyCE7Lp1/ewVI96pJCEtKNmk6AtjHHcddmbZRtkPrcIpAkXOJXNUNEnOaHevNM4uPLUAmkXo2
	5B3L7Pb7zZJ7LMG18q+EAv8CQQVl1y7uBwQjmpJZNm3Ct8luz5gFxo/wvquYZnmzI/nZtSGzHzEFW
	+IdPtxd3Zu9yigI04niN9Y4J7wDDJQAeUoXFIeYbPf0oMw0dx2VeCitE9JEJS26ojLM26CCafSCi+
	/1qPUVyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x65YZ-00000003VAA-1WyT;
	Mon, 14 Sep 2026 12:13:07 +0000
Received: from mx1.mythic-beasts.com ([2a00:1098:0:86:1000:0:2:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x65YW-00000003V9U-3kdN
	for kexec@lists.infradead.org;
	Mon, 14 Sep 2026 12:13:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=From:To:Subject:Date;
	bh=2tDaQC5rOBMjovUfpSgyJBpDCsNvHvjcik21L72/Adk=; b=jm7f/oCVxiIfetYVHDNgcnxH9o
	tXOkWuRYmy8FuLg2dTrXhG+BhgNhd3W1obqYE08mSW9aJ6hvs3loOIs4TLbMeMoIJO/QTbaMSuSxh
	q/tkAA7FcT7Ejb9Rqx+0CzMixxPLpWj8TmbeF05uxFLBv7xhvmSxckzQxD3s1xpFl4Xf8d0jv79XA
	YGdH/0geVEaHaw6v0ELqOngFqzKjLn5wN63yuoEpZ8wiw8Ct1DNveH0aJfJzqSCDCmBEcZhNP/bFV
	vZmqiPUuy9nNlb3BI0p9BK+WrnY6qMhPulCSMsrK7dR/9X5Wv/RzEjQcWQe48/+P1XVbVM/pdGNFw
	qmKDuymQ==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <tom@tom-fitzhenry.me.uk>)
	id 1x65YP-008v4s-04;
	Mon, 14 Sep 2026 13:12:57 +0100
Message-ID: <46e6b39b-062e-44c4-a1d4-b74aa24e170e@tom-fitzhenry.me.uk>
Date: Mon, 14 Sep 2026 22:12:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kexec-tools v2] arm-zImage: prepare for more malloc
 requirements of zstd
To: Andreas Kemnade <andreas@kemnade.info>, Simon Horman <horms@kernel.org>,
 Baoquan He <baoquan.he@linux.dev>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pratyush Yadav <pratyush@kernel.org>, j.neuschaefer@gmx.net
Cc: kexec@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20260912-malloc-fix-v2-1-eb0c3ca681cd@kemnade.info>
Content-Language: en-US
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <20260912-malloc-fix-v2-1-eb0c3ca681cd@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_051305_480884_A24D1B4D 
X-CRM114-Status: GOOD (  14.49  )
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

Hi Andreas,

I'm glad to see improvements to kexec-tools on arm.

For context, I recently posted "arm: use the zImage tag's real 
TEXT_OFFSET for kernel placement"[0] to add support for text_offset.

I hadn't seen your v1 at the time, and will happily rebase my patch 
after your patch is merged. (Or, feel free to add support for 
text_offset, instead.)

I'll leave some comments, since I have a tiny bit of state on this code.

On 9/12/26 20:35, Andreas Kemnade wrote:
> @@ -663,18 +665,21 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>   
>   	/*
>   	 * The zImage length does not include its stack (4k) or its
> -	 * malloc space (64k).  Include this.
> +	 * malloc space (128k).  Include this.

This line no longer adds the malloc space (and nor is it necessarily 
128k), so maybe remove the mention of malloc space in this comment.

>   	 */
> -	len += 0x11000;
> +	len += 0x1000;
>   
> -	dbgprintf("zImage requires 0x%08llx bytes\n", (unsigned long long)len);
>   
>   	if (tag) {
>   		uint32_t *p = (void *)buf + le32_to_cpu(tag->u.krnl_size.size_ptr);
>   		uint32_t edata_size = le32_to_cpu(get_unaligned(p));
>   		uint32_t bss_size = le32_to_cpu(tag->u.krnl_size.bss_size);
> +		uint32_t malloc_size = tag->hdr.size >= 6 ? tag->u.krnl_size.malloc_size : 65536;

There is support for big endian arm[1], so use le32_to_cpu to convert, 
similar to the other fields.

Also, consider replacing "65536" with "0x10000" to be consistent with 
the else-clause in your patch below.

>   		uint32_t kernel_size = edata_size + bss_size;
>   
> +		len += malloc_size;
> +		dbgprintf("malloc size: 0x%lx\n", (unsigned long)malloc_size);
> +
>   		dbgprintf("Decompressed kernel sizes:\n");
>   		dbgprintf(" text+data 0x%08lx bss 0x%08lx total 0x%08lx\n",
>   			  (unsigned long)edata_size,
> @@ -699,8 +704,13 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>   				(unsigned long)kernel_size);
>   			kexec_arm_image_size = kernel_size;
>   		}
> +	} else {
> +		/* add default malloc size */
> +		len += 0x10000;

It's a bit awkward that this fallback case is far from the happy-case 
where the header defines a malloc size.

Consider adding a "if (tag && le32_to_cpu(tag->hdr.size) >= 6)" block 
before the "if (tag)" block to handle this.

This allows us to remove the two fallback cases (!tag, and 
tag&&tag->hdr.size >=6), in favour of just one fallback case.

Something like:

```
if (tag && le32_to_cpu(tag->hdr.size) >= 6)
	len += le32_to_cpu(tag->u.krnl_size.malloc_size);
else
	len += 0x10000;

if (tag) {
[...]
```

Regards,
Tom Fitzhenry

0. https://lists.infradead.org/pipermail/kexec/2026-August/038363.html
1. 
https://github.com/torvalds/linux/blob/704340f1cd0dcef829eb62f5b48ae95a2ce17bdf/arch/arm/mm/Kconfig#L780


