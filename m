Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6A3C021AA
	for <kexec@archiver.kernel.org>; Tue, 18 Feb 2025 14:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oAIrJ/LjqF3PZx6DSjpQeC5ZYl3v6fqCgyrURh3Pa9A=; b=cmX4pTZUH7fBBRQWIhIfBlmFlA
	jGdAjcDjqI+xUJ4M1fLVjOUdK9VV7dUL9rjwGTm5bRRhc6M37YlZvuQbzN10JR4+g3tnOpwXNNn3Q
	dg79jKkAKFABpk/Wixq2lbOwl+ABjDlyh/xGwocs6h08teTQysmHYrdYt9/mZLoyOgQqPYp9cyTLP
	L+q4TeiPvoXLOcF3OPaAah6NUQIrrqgAeYlXsYenxOCY9rOcO32EcqLAFI9nCurSykJr7DweoNO3S
	w44mUroTjGBHj8l+/a8UxKs9QDzpyLQxQ1sdkOT7yx1ljvGvx/K0vljFSLaCIulFMm/+LGjXPCRqi
	XmgxXKEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkP4S-00000008f6r-1n3d;
	Tue, 18 Feb 2025 14:59:36 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkP3z-00000008evX-2utR;
	Tue, 18 Feb 2025 14:59:09 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-abb892fe379so373960566b.0;
        Tue, 18 Feb 2025 06:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739890745; x=1740495545; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAIrJ/LjqF3PZx6DSjpQeC5ZYl3v6fqCgyrURh3Pa9A=;
        b=mVvh/nUGwtUTm+7Bh0gMlDlHGlY7+5QVswX0+GjoPnWHdDB3nSxHpEtdqp2oj33AOP
         qnycwIwniV8jFBm601MKSCNAYVxLL/Zby2tmU6VqUfl5yhlG4FIVQ4tcZ7eFNOQxAtFX
         YuzRPfLfqhgTXamdHcPkG+BpsZpaD8LOruL9Z/JjfCkBjfcvSBWafRq027/KMGWgC7DJ
         IizFG4/c86blbcRix3Nhc+m/rHG5GKkl+XRMOLg4pnKQ2SNbT8TJCnogEeuxJDUzy9d7
         DgrcJ8PhCBZr5CvTynOzm3Yo5C0BOikVF7ROQdq2PiHqqvgwsOvUPZ2AgcjAxuRlAVUA
         UXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739890745; x=1740495545;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oAIrJ/LjqF3PZx6DSjpQeC5ZYl3v6fqCgyrURh3Pa9A=;
        b=UCnHeLbZpuwhUoKZUs0Hd9cy70ZrbTFiVWTlJd/lUAWcwxDxdzwiCqrVpTgx+wW+iT
         TGDC/dkZ7epKm0oyb0JcDJFbwj1B3+3wJqJau84KLTxRy33l4rJBTYA7QskNWN020aoC
         ycfsh13lwiDwkHj2a8tL8kSJV6TvQ6GKCEed6OZYbUkui7ITzREhbzg+WN7DWxy6ndj2
         7H+TRbwhTDA6uq3n9vemIs83NhkBh5v/CtK77x9PlrJlQ4IWAQ7D9JIBCYn9ETUeSAz3
         6UuGljjgiJwxFr1PtOMjmFlcWmEYdC2LPniqYFCIFtEr+UfsYxmguOXGwyghKE7sc0mb
         YMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXZ7YpjuQiAyy+YFgSwfkNnJf4Jukr7JaNkSJxVj4BiAJP1TOHVjL1rTUZbufpgHgy0F9zGg==@lists.infradead.org, AJvYcCXW+GIKjglHCB6DK9eFo8BNQtYN7Oa81WDbiGpiSZrWNVazXJg2NmqIiWgru/329BF7Nk3bxw4j16wVoMYbledcUw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6QVsye/Kl9qn+lD8sVs/6S+StZCwYAc2OymObLoekMtAREDR0
	uGKTF37gJbm1BfZTQCSyZbuqkNGibUoJNFaLwWLGsJtMHkGDk98t
X-Gm-Gg: ASbGncsYJd6hV9YakPnGKV4UDI46PvImSejs64zg1g7nrutpMSDB60YVqswZLubnB44
	bY/sSGXRWp/NgN59jXLkrKl/+u7GLdu4MG1Rm1E7RJcG8jQZXWAzTIVe3dAyNj4lU+GOfO2JWbs
	H/E3Hnv31b2dlMVEY6opLX2zIw9n8MNm/EgOV9kzuDAIgaMi6UykEfR2rvYdPqcRQOVB5DYfASD
	7fmVOH7FeX7eGKzOMAXu2BW9nxm4WbO1kezhcgHtRBdrDSSbORKeSwu8Xalp9rSKDAvih/5qNX3
	DQFM+3y+HcwJxIw=
X-Google-Smtp-Source: AGHT+IHfGUb6DAP5PY1vAqYBMMTlEpLIKDLmvPxJw/HfikZVPdieC7mOeVaDwsd2Oi5vIHAKZzcd1g==
X-Received: by 2002:a05:6402:2386:b0:5dc:6e27:e6e8 with SMTP id 4fb4d7f45d1cf-5e036139cb5mr24069087a12.24.1739890745271;
        Tue, 18 Feb 2025 06:59:05 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbbc841eb0sm121224966b.128.2025.02.18.06.59.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2025 06:59:04 -0800 (PST)
Date: Tue, 18 Feb 2025 14:59:04 +0000
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
Subject: Re: [PATCH v4 01/14] mm/mm_init: rename init_reserved_page to
 init_deferred_page
Message-ID: <20250218145904.x57chhz3whvckzu3@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-2-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_065907_734787_839F1D08 
X-CRM114-Status: GOOD (  13.23  )
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

On Thu, Feb 06, 2025 at 03:27:41PM +0200, Mike Rapoport wrote:
>From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
>When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, init_reserved_page()
>function performs initialization of a struct page that would have been
>deferred normally.
>
>Rename it to init_deferred_page() to better reflect what the function does.

Would it be confused with deferred_init_pages()?

And it still calls __init_reserved_page_zone(), even we __SetPageReserved()
after it. Current logic looks not clear.


-- 
Wei Yang
Help you, Help me

