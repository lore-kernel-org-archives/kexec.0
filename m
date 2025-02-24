Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF54BC021B3
	for <kexec@archiver.kernel.org>; Mon, 24 Feb 2025 07:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AhJ1T/fwWWXZEiEbcn+HPev6I/zpx52m+r3y5yvwxno=; b=qI5yaxOFxGJNA4nrEN/XiSOKbA
	4PpVW+g80+hh6X0orsF4OIoOk7qJoIUVGsnpjP0/i+DHPeqJ0RSbyNgZBr8Z1pAxyxdD+THB1Ve4O
	/Y9Wu2NKGenZ9TyXdEm/gLvo14xwmN/ZxHPbKwzH5/lU9LEQ2Oe6RNVniofqmjH57fchVmHgN/odp
	ZwTUr4iSpLErVvdoRzzSpO85UvF2kEtP99X15k459N4BFNP5KTCT/xr0xfUUGYIp+eJSv5hplOHOf
	Axb7V/FM9VlvUIB3kPU2x2Y1QaLHUqYCJ0utcrP3I9TJ494k0F6z0wiz03LVb5Be5QYl0daXRRQrv
	XKFI9XoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmSfA-0000000CXGS-0mB3;
	Mon, 24 Feb 2025 07:14:00 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmSf7-0000000CXEI-3X7I;
	Mon, 24 Feb 2025 07:13:58 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso650225766b.2;
        Sun, 23 Feb 2025 23:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740381236; x=1740986036; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhJ1T/fwWWXZEiEbcn+HPev6I/zpx52m+r3y5yvwxno=;
        b=aVmgzbo8fekZKCBRFlXQhOvpRj5FJ1eM5Onbx486hQjBZOPvgiTTwhsLg1pYoq/MvB
         k6Nu6nmNmD79Y7G/8YGP+HWMMzx6eWd39gSzWtzw9p3l7kSR/D67gh0DTp9mu460LnCV
         g2tCichulZBpwFv2Nunku5gmp40SFKbtUogkJmnh7uwrUoK6BM9Acb5R1jfXNDAXASP7
         4nnLBrulYpo6yRURyfZRTchThsYBL55/8/ugTaRVVkb19y9+on4X2QUwR8PeR+WVXthT
         Q75hwP7gee1ZEQ47qpEk+akd6jGk5XhJaUk0pa36IXB7ycsA7EpD1ecawQTqFgG9BJ5Y
         64Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740381236; x=1740986036;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AhJ1T/fwWWXZEiEbcn+HPev6I/zpx52m+r3y5yvwxno=;
        b=RTTHTo9U/epDEPMqx7Cqgt3OgJOXxGoFbYbSs5HQu+ev1fDUX/CITHE3akkfTG7Av4
         +HTFTWTTVKg/j01AtJHKrpyixLfk0AA+iheeNwd5/5pOpIM0BNnYdZtvL1A9zlO4EIiR
         p+lsQFpf28XmzbP565FjczM1pXlbRefjdz4O6AOvzgPwJrG8X1KOEzjloo3NNexuSNFG
         l81gI4NlrlfSZWh5OWMUUw4SXOj+9Gm7YLGxK1YLlVGcXya8YiwPpPU7rD+tkeVhsKFZ
         uRQ36r8DxEb1uBrBsXFj7NT1gEsF6A6G3mjjTtZkrE07yrNkM6kZRaU0Ukm219O9/OTC
         Oz7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7uJ56gPyxOFv5FKCYtZppscGr7Z2HVNQEL9pfw8A5ATuausIVP8Y/BhEIkOIsPJEek2MB6g==@lists.infradead.org, AJvYcCWLD/XUZpOSQ+fi6gGLLr8K0fz+wlLAxFDmZctjn6bL9TRWeCFjMneEmNbom6Sa9UzmY/Q/OQ+Ruq2tGGXqTBpxgw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyuah2hxBtNXXrLp9S751YRLATr1Ps2/4186v8PQCxAbv7TH/q/
	88F/x1Xze6/f5sUW35Va/zzzgd6WLr4Cke8GNO5Pp08A4KgAv2+B
X-Gm-Gg: ASbGnctDBUK5k3CBtFKBbvojxKv+3LTMCQTYaBABwAGwUUStj4bz++GB0RzVeUprUew
	DS2KAmrr93bWySgThXrDW+41+bu+Zyy+0L6mFm2mJL3SfXQVEGgd9JA6JZNie1hMsORPLqSPDTj
	a09VQLZzfub5LZIZxJEomnOCoIMSEXfVleKhBd7GmvuNxhGbRcOZOEnKFCz++wB5XgDsukfB3ae
	3GPkiE8xqCfpPUo9ZFhZkQXblwk0/QvX+Wdu4jPzqJ7qLmDs5pcjScO/B0N1kGgUpa6sIwZ2wO0
	c4cqZnHKfdSMYoYuu3UrCSZqvA==
X-Google-Smtp-Source: AGHT+IFTl/OJwiOMCrQwp/6jVuRvgGddWSjPDFK5GMI5evFJFlBu1ePwDd5puvr/8TxFgsTqVzZxSQ==
X-Received: by 2002:a17:907:7ea0:b0:ab7:d361:11b4 with SMTP id a640c23a62f3a-abc099b7f3fmr1362031766b.7.1740381235930;
        Sun, 23 Feb 2025 23:13:55 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbda707e3dsm1034964866b.106.2025.02.23.23.13.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2025 23:13:55 -0800 (PST)
Date: Mon, 24 Feb 2025 07:13:55 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 12/14] x86: Add KHO support
Message-ID: <20250224071355.xsl2dbupda4dhfzl@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-13-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-13-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250223_231357_882554_3C38B44F 
X-CRM114-Status: GOOD (  16.01  )
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Feb 06, 2025 at 03:27:52PM +0200, Mike Rapoport wrote:
>From: Alexander Graf <graf@amazon.com>
[...]
>diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>index 82b96ed9890a..0b81cd70b02a 100644
>--- a/arch/x86/kernel/e820.c
>+++ b/arch/x86/kernel/e820.c
>@@ -1329,6 +1329,24 @@ void __init e820__memblock_setup(void)
> 		memblock_add(entry->addr, entry->size);
> 	}
> 
>+	/*
>+	 * At this point with KHO we only allocate from scratch memory.
>+	 * At the same time, we configure memblock to only allow
>+	 * allocations from memory below ISA_END_ADDRESS which is not
>+	 * a natural scratch region, because Linux ignores memory below
>+	 * ISA_END_ADDRESS at runtime. Beside very few (if any) early
>+	 * allocations, we must allocate real-mode trapoline below
>+	 * ISA_END_ADDRESS.
>+	 *
>+	 * To make sure that we can actually perform allocations during
>+	 * this phase, let's mark memory below ISA_END_ADDRESS as scratch
>+	 * so we can allocate from there in a scratch-only world.
>+	 *
>+	 * After real mode trampoline is allocated, we clear scratch
>+	 * marking from the memory below ISA_END_ADDRESS
>+	 */
>+	memblock_mark_kho_scratch(0, ISA_END_ADDRESS);
>+

At the beginning of e820__memblock_setup() we call memblock_allow_resize(),
which means during adding memory region it could double the array. And the
memory used here is from some region just added.

But with KHO, I am afraid it would fail?

> 	/* Throw away partial pages: */
> 	memblock_trim_memory(PAGE_SIZE);
> 

-- 
Wei Yang
Help you, Help me

