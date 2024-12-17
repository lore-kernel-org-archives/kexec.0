Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AF8E7717F
	for <kexec@archiver.kernel.org>; Tue, 17 Dec 2024 16:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iH70s4kN1OmYyU7l5ZxBv++8EBPGyuzfTKRoG/MitJE=; b=1RKDNIISR6JYUqVx80QTItn+cj
	Izob7a2uppwaGbdsXggSwKY9rQTVEAmr+Lk9wAYEZqmnZzQTYYZOv73cocfJSV7seVe5xHAD6NIDh
	jXb0JYZTnOjktNScv4tRBq88Nzg/EvX6z5WZOqRVhAacyck2laB/YbqccG6NqqiqPXkhrzt1i2zRK
	1PiWBEe0+59sGOFdQwPK18ezbLWhwtjm1/1e8jeNC02VWcnbdh9f650ROaRUBSo80I/PZiCDxoIhi
	lz1cLpOsoeiqE0ilU9AgTnATIwfaf0WBrjSjRLIEDqmhLUR2k/b+G3SHqbo4PqQt6xeCn4Z/V+4lv
	zcI2F6uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNafo-0000000EEjP-311r;
	Tue, 17 Dec 2024 16:43:52 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNaaH-0000000EDfL-2aTG
	for kexec@lists.infradead.org;
	Tue, 17 Dec 2024 16:38:11 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-aa670ffe302so1020169166b.2
        for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 08:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734453487; x=1735058287; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iH70s4kN1OmYyU7l5ZxBv++8EBPGyuzfTKRoG/MitJE=;
        b=GlNqXKoNGlIWHoR97fngDhX/KMxOgcS2nThlhrPOn4z+2kyaK2/hVcN5utMW9OZlSY
         Z88VTeFFbjhQnX7DN4edNUWuSMctK22o2/x+tJJ7wtN2bTOMxBYIShwzg6u/N9dKa/RP
         chufaa0SzfQZ3y82mN0eq3Vn6MHqjdMWrQSOlPYmwhhOwBM/A8joxkGsZQrcQUSMm4Um
         HVumQqS6gI+eNePFSkL8JwbzQoegYWPixmHEU/kN65BLdMup685PTLrAGMiSxL8t6IRD
         oMv1WDH05fryStFbRp8rLge1OuN1ZF8RqAsm436UbEoYyl+kRzyQAs7/WoXtTdol3ZXl
         Jwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734453487; x=1735058287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iH70s4kN1OmYyU7l5ZxBv++8EBPGyuzfTKRoG/MitJE=;
        b=F6BiK540A7vsTWsUymZROJRW8kJkp2gXd8+MLB2IT0tKN0ePONKBloqNl469IEF+4m
         K8WNIkusK0k/ARA/ljwCJeOttfkGTIMH1p31TYUXiwymFhrjobFD6/hmaw4zvPCbRsst
         XrUBuly+iISskP6MYLU9zIa3+vIt7fYLoXQYei2snsvF98ixlguDJ0XaSMoT8gUCP/YT
         YpSpHOMXyQ+vfVTqho5QO7jAKmrDjhQFe38taWj/AM2i1+vOfSbXo2CjYLXPdoacq2qn
         FgPK3cYrZhSFV92TDsLT0NwwKJwaLHRB3bYomJws8NSsywwUDt4KdlGluTZql0/SXE6G
         Wydg==
X-Forwarded-Encrypted: i=1; AJvYcCWXFJbNM1yi4s98uyS8X9c7k1JKmbEDbpnsEivHPnqNpvubRto9tpHuc2uc18Mn6k7XWlcgqw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyUtR0aIbUprLsNBBybUokgIYPupLx8KuZRDg+sfK3prhh/8aWy
	MdyF2yG0Sg/HqJy3HlTwPlkplBqkWkZIQndUqnl49GP9+IYiKH/q
X-Gm-Gg: ASbGncvowi+w0VT7NIoX5p8M4ozzNZ9b4QtmT+b3b6iQYxuUE7kSZ39EFHQ36ZkjzPa
	wRZ0da77ejisLS8Z5vxxcQJXVz4joocz56rWxzSKuAG+6xdVRUEltBOyuEhMFUPTjAuk4pSygk0
	tkrtqe5a6y2W5MTLbZ1VcrbU77zagC+2YTdRELsrnG0Bwqz3W27S7/gpzaHQvHY/2LFNlybtM7b
	MsvBrrsKYwkWzK7W9PgNUA3h3so4g1fOGA8I6zgJ1z6y5OdKNZLVTv+9A==
X-Google-Smtp-Source: AGHT+IFdOTWlQ3XGT9Bbtyc5hUf6TLwfRJLJZcM8KJ/JAayRtZbKneHKECG4frLOlCSEzCF6vLj9aw==
X-Received: by 2002:a17:906:dc92:b0:aab:736c:558 with SMTP id a640c23a62f3a-aab77ebcacdmr2066488266b.55.1734453486800;
        Tue, 17 Dec 2024 08:38:06 -0800 (PST)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963595ffsm463142266b.94.2024.12.17.08.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 08:38:06 -0800 (PST)
Message-ID: <05bde41f-9f2a-18e9-05ef-c5b29a66caf8@gmail.com>
Date: Tue, 17 Dec 2024 17:38:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/9] x86/kexec: Ensure preserve_context flag is set on
 return to kernel
To: David Woodhouse <dwmw2@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>,
 Tao Liu <ltao@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 Wei Yang <richard.weiyang@gmail.com>, Rong Xu <xur@google.com>,
 =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas.weissschuh@linutronix.de>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
References: <20241216233704.3208607-1-dwmw2@infradead.org>
 <20241216233704.3208607-3-dwmw2@infradead.org>
Content-Language: en-US
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20241216233704.3208607-3-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_083809_660794_A094836C 
X-CRM114-Status: GOOD (  19.16  )
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



On 17. 12. 24 00:24, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The swap_pages function will only actually *swap*, as its name implies,
> if the preserve_context flag in the %r11 register is non-zero. On the
> way back from a ::preserve_context kexec, ensure that the %r11 register
> is non-zero so that the pages get swapped back.
> 
> Fixes: 9e5683e2d0b5 ("x86/kexec: Only swap pages for ::preserve_context mode")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kernel/relocate_kernel_64.S | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 9bd601dd8659..1a52e4339c1d 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -220,6 +220,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	movq	kexec_pa_table_page(%rip), %rax
>   	movq	%rax, %cr3
>   	lea	PAGE_SIZE(%r8), %rsp
> +	movq	$1, %r11	/* Ensure preserve_context flag is set */

You can save a byte here by using "movl $1, %r11d".

>   	call	swap_pages
>   	movq	kexec_va_control_page(%rip), %rax
>   	addq	$(virtual_mapped - relocate_kernel), %rax

Uros.

