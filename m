Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC962C021B6
	for <kexec@archiver.kernel.org>; Mon, 24 Feb 2025 02:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iOnUhudnk/ghJ69v1pIjycejO9QGM71BCF3/L9nVTWg=; b=UB7Lggqa0cLXZbcXRfUaeNcHIY
	oglWyBrVG1FT4NVKJcqll34VjFLlKr/DS6f2Q+92qJbOOy65cKgHghIBGkN5BCqyMA4vVVp64WXL6
	KIMKawqsEdOYzRPsnoWebnMnWcDNKoY/JPtdWleH4i8vb/n5QMC23yK3pkTOvqoDRNQAYryrVimwh
	mKrJjbfUWB0fcO7kVjAISsee64/DvlvzAnyJaN0sYItpJM0lidBKoUgdBUgyYgjln3Xl4ck1LfAxt
	WhxKmBRIshQvrjCCivhh66qF67KHbOoKFWgG4L7p8SlUh2m2L9da0lJA9HObRdKtZOoufyHziBQWK
	rkQLdjkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmOYK-0000000CBQX-3INg;
	Mon, 24 Feb 2025 02:50:40 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmOYI-0000000CBPf-1LeZ;
	Mon, 24 Feb 2025 02:50:39 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-abba1b74586so585351266b.2;
        Sun, 23 Feb 2025 18:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740365437; x=1740970237; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOnUhudnk/ghJ69v1pIjycejO9QGM71BCF3/L9nVTWg=;
        b=Obzzggsl1BOjThUKgSsPO3TVHRlX4PFtYA89zypqjLYEL/xkFF8r7MZkLPWS0aqjge
         If5VdqfsbqI+0HyKMN+ddSPM7GOBnfO+ovIH+fUW53Aw0yZd+Lf2B9BoHQOyymNCi1QN
         ivEMJihtR/NQOfdbXuHlGfrQsafvmB7oahUC4WlVQxrEpu5aCZZ6venAJO3FBokzQCfg
         4qSuuwbFCHwhmVQKjDk3cHnvTNVQGxLwp+EJVdpNA3VFH78+XAmwZilC7kGemMu/S+NV
         1qxzJw7ew2KsJH3gXvpVFzwQn2vlFNp0UCOwvO/GWcJ525p8CvPpX+cFVGh5i2IG356A
         ryXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740365437; x=1740970237;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iOnUhudnk/ghJ69v1pIjycejO9QGM71BCF3/L9nVTWg=;
        b=kG5kEgNlWGH7wUgbzgGj3LGsvG0G0LwnxlKMn393FgIxH3KQMycVXybfu06KQcATcP
         EUG2SNooPKXIPZSfA20Sm5wdUet9gKE9GBMMHynKPpoISAzKUwDtlap65BA5FGNwTBqy
         cfsG4whtgNiTaOuYLneGTsrRWMP6EKfEDlysQFMFA/c/Xx06FKbLpccLVDCxkkXSk//q
         0/oa4JEOVbDyonIvyMMaw9hGxY0jnhejGonj/g5Kk169A9wq2JqBY8F5zTCenehXh7xR
         1LQSBNhc0KsE/svf3aYdNEBgQ5vqwei9Z847q8SvbkFS0jkkOhyZJKPTyK15T6vUxiN3
         lEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/yYcgB//5bbglmKz7NUo0GLoPt4pDldzlg9WJzhG4shCqz6B4wVj9afELvK52weV3JknWdQ==@lists.infradead.org, AJvYcCXmTqyi0tU5ZvrIgQvpUMA97cF5eIdRcMteurddc58AOdA28UrHqeiAd5KsKSZ8aPW02ZVPTVQ7nBh7hSvt8tV8yA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/VG8+tdq1LSNn5TLZFxVuZUzNwploLbDioNVjbn94o+KqDZj2
	LtGLhjbfZ63hbgJzFr6ZXtXB3hWqHfeBDGQVqPHzeZaDl0smHQkC
X-Gm-Gg: ASbGncsqDyL+OavmsbzDXCWVo1hyt85J8drXL6nmHsKh3HJ5o5kx2Kc5+rYtf2s5rBc
	DQwtrciWDZGljRNzaC6S0Lk903f85tKrCdsMnfKriC9Y37pUeNUYL1hC1r/4h7JIRmcZV3zSze4
	D9a4ppPUecbU2SbApxHmTq12ApMqQ+Qe9YQuqP/a9pORluuf5lWvyZ8z6IgxJ2zMOOxRzKmB3rK
	sLSxhmiGoBCsV4was/zq2Hr+HOIN4HaIJYyHeVo0bf5GZrIS8feRUOF5zOf5mX67qS1+xYp3P7q
	HVVvYmxLhsAzKq0ZFqD/WREQEA==
X-Google-Smtp-Source: AGHT+IEiyHF/bof5atxJYJ1aq+nUThhjZS2+A2L49uqXPzE/BpL2M9HK5ZwzhlgRX2ZUqUt6sCy6Hw==
X-Received: by 2002:a17:907:72c8:b0:abb:eec3:3930 with SMTP id a640c23a62f3a-abc09aed093mr1341918666b.31.1740365436292;
        Sun, 23 Feb 2025 18:50:36 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abec0324d4bsm13923266b.108.2025.02.23.18.50.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2025 18:50:35 -0800 (PST)
Date: Mon, 24 Feb 2025 02:50:34 +0000
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
Subject: Re: [PATCH v4 03/14] memblock: Add support for scratch memory
Message-ID: <20250224025034.g4htzqgm3r3ja4yy@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-4-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-4-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250223_185038_370026_B83E5E2E 
X-CRM114-Status: GOOD (  18.91  )
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

On Thu, Feb 06, 2025 at 03:27:43PM +0200, Mike Rapoport wrote:
>From: Alexander Graf <graf@amazon.com>
>
>With KHO (Kexec HandOver), we need a way to ensure that the new kernel
>does not allocate memory on top of any memory regions that the previous
>kernel was handing over. But to know where those are, we need to include
>them in the memblock.reserved array which may not be big enough to hold
>all ranges that need to be persisted across kexec. To resize the array,
>we need to allocate memory. That brings us into a catch 22 situation.
>
>The solution to that is limit memblock allocations to the scratch regions:
>safe regions to operate in the case when there is memory that should remain
>intact across kexec.
>
>KHO provides several "scratch regions" as part of its metadata. These
>scratch regions are contiguous memory blocks that known not to contain any
>memory that should be persisted across kexec. These regions should be large
>enough to accommodate all memblock allocations done by the kexeced kernel.
>
>We introduce a new memblock_set_scratch_only() function that allows KHO to

memblock_set_kho_scratch_only?

>indicate that any memblock allocation must happen from the scratch regions.
>
>Later, we may want to perform another KHO kexec. For that, we reuse the
>same scratch regions. To ensure that no eventually handed over data gets
>allocated inside a scratch region, we flip the semantics of the scratch
>region with memblock_clear_scratch_only(): After that call, no allocations

memblock_clear_kho_scratch_only?

>may happen from scratch memblock regions. We will lift that restriction
>in the next patch.
>

-- 
Wei Yang
Help you, Help me

