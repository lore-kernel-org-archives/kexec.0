Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A7AC36009
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zwmz29OaB4anSC3HDaaMnvvDxasPenPirxVhby3n1zg=; b=RSO10eALglKD0G0yxaz2STkYMR
	e6izdVMYl7fKFbjlH5qvfKDqC8iV+xVFuZkn6vz/9k+72hK8gRPRG44MLlZTltOVC6O56muiWKG/j
	QPxohqwRUYwNEuZ2N27nQzyC3t5RLgoxvgkkPr5YuXfjcHFFvAPYfbAyTSU4MI/DlxkoGKqnBcuIC
	HpTRoxJzvORHbXa7P1b+ptjcx5kZHz3ZtKHqVOylEy1RNhPnPSarztFhQDMIgRWE1xhFk+51Hx+d+
	s1KbDx43K0dbx3ttIxbfRKh7P3Jl/LhIykNCv7sZO01LGadrL3MYzAPMvnFijIvR3HgutgX3x+Noz
	/mlWLmKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHRz-0000000CU2a-39DK;
	Thu, 20 Mar 2025 15:04:51 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmiNY-0000000FZUL-04hm;
	Tue, 25 Feb 2025 00:00:54 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-abec8c122e4so129552566b.1;
        Mon, 24 Feb 2025 16:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740441650; x=1741046450; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zwmz29OaB4anSC3HDaaMnvvDxasPenPirxVhby3n1zg=;
        b=lt+EILZhEKRI/ojsIYkVjvXVTRocAhVdoNXzeTPlbkOvH/w+4UoaFuWR4W9He1qzQb
         lFenVWYyXm37Hsqw2o51+0pqnm9Z3lcrv2TTQVjSb46i1Cl+2HwiskOr5RZMSBNyX22c
         f9Je9uq3ZmfxA/asQ64bzC+HKzVKRqUQd/qlEwd6R3d5WRReZLc4AxRnOEv05PYDViWW
         OZMZzYlXFCID5dODtLUOVDI1aO8uKObV3QynGlm4vPC6yeoNIRlUjmjz9rOTwfZGMRmS
         TWh1XcGbwwpGsGLEE1JPf65UD6dSwj629CcSS9Lv482iO7LbuZcpclkr8zG8PvmsQPyu
         gPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740441650; x=1741046450;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zwmz29OaB4anSC3HDaaMnvvDxasPenPirxVhby3n1zg=;
        b=tkncSqHE5zyxuvJcLgn/fETLT7+vDe5oi9QpCRIB3VRjcmEwoKDo93B7b2BJ7c2Xw0
         A3tXdZQJ1dL5CLiCbCvWb6TMMxgIFIeD69oVIkQmJPrvPFwNqu9zfDQwNrjhHqqsDnr+
         n4TCas/vUPpzyLsOAJh1Htej0zKMWu+1EH2efawZ9wXznPYTmMW3as4aDvgS0imVMcgu
         vzdgiKBcYcKWLXBvkmsyjK+T9tYRfKUCHbwyogXOjqy+9yYVw67AkyEickKZXXrvUwhM
         9738CgNkwzqG+1zVbSOZK8NR2+omjqQHY/NTXzrKkieVy33ncZZnzjC1WtGPeKrMfkNL
         SOxg==
X-Forwarded-Encrypted: i=1; AJvYcCXJn5EDyJ0cJBsEHiKIHe5QVW/MM8cARySg+W9InQ5R1JhGghSHUJWHX7ZYjaqZNUfCeupOk88U5XIFgsbKUwZuQg==@lists.infradead.org, AJvYcCXiJaHqEUNqD45t6XW45mT+Ji7RSly01DouFA794KbkBQq/71D0cqM+XZWlq9gklPo4wwmPvA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxSyQYZyvMuUJdF0lseHhVEVBzT5nO2KGS/slwgexRVClxMruCK
	eBvfMEP0966mM8PtTn3KdVv7ihk8hzTharYK3r7Q5GxGKUsPpXaK
X-Gm-Gg: ASbGncse6j6OjASOmE+O8vUxUGz7fR70gr1rZZozVV2stsYbNRr9pY7C/xSHuP6KGXK
	B5oBSV+LwUMcrbg2UpXxHtCgs8IwrynBbwa4b8elCzycse6wsUcuZnHE//iASnq+Ar94uB3OWr/
	Ni4TAJUnxsIpHNLGi5rZm72L01M86bAqoPuczF6/Ra7V7njedRqibTHk/xsdB14gxro2xaXlQUH
	xbqDwb8e6KW7i/8Yc+yJze4hxB9xgCyNSj8FtjmPA0ivQqHBAforZxYay0iJ8vug5T+nUq0r6QN
	DTm/AQSI9NpIvB4Ypea6qzP2NQ==
X-Google-Smtp-Source: AGHT+IHCiDeg8iTtlMHBTT+8rsM3bDbDCpBQksJY/HtiteE5vEuZdMawubgKL7nC7L+KAJkK6uv0bg==
X-Received: by 2002:a17:906:2c4b:b0:abe:bfdd:e68c with SMTP id a640c23a62f3a-abebfdde8f5mr390505766b.4.1740441650101;
        Mon, 24 Feb 2025 16:00:50 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1da4892sm42880766b.82.2025.02.24.16.00.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2025 16:00:49 -0800 (PST)
Date: Tue, 25 Feb 2025 00:00:48 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
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
Message-ID: <20250225000048.f2nmfn5isuh3fn6s@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-13-rppt@kernel.org>
 <20250224071355.xsl2dbupda4dhfzl@master>
 <Z7yD9g1AgtUUfKr0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7yD9g1AgtUUfKr0@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_160052_073047_27DB573C 
X-CRM114-Status: GOOD (  20.19  )
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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

On Mon, Feb 24, 2025 at 04:36:38PM +0200, Mike Rapoport wrote:
>On Mon, Feb 24, 2025 at 07:13:55AM +0000, Wei Yang wrote:
>> On Thu, Feb 06, 2025 at 03:27:52PM +0200, Mike Rapoport wrote:
>> >From: Alexander Graf <graf@amazon.com>
>> [...]
>> >diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> >index 82b96ed9890a..0b81cd70b02a 100644
>> >--- a/arch/x86/kernel/e820.c
>> >+++ b/arch/x86/kernel/e820.c
>> >@@ -1329,6 +1329,24 @@ void __init e820__memblock_setup(void)
>> > 		memblock_add(entry->addr, entry->size);
>> > 	}
>> > 
>> >+	/*
>> >+	 * At this point with KHO we only allocate from scratch memory.
>> >+	 * At the same time, we configure memblock to only allow
>> >+	 * allocations from memory below ISA_END_ADDRESS which is not
>> >+	 * a natural scratch region, because Linux ignores memory below
>> >+	 * ISA_END_ADDRESS at runtime. Beside very few (if any) early
>> >+	 * allocations, we must allocate real-mode trapoline below
>> >+	 * ISA_END_ADDRESS.
>> >+	 *
>> >+	 * To make sure that we can actually perform allocations during
>> >+	 * this phase, let's mark memory below ISA_END_ADDRESS as scratch
>> >+	 * so we can allocate from there in a scratch-only world.
>> >+	 *
>> >+	 * After real mode trampoline is allocated, we clear scratch
>> >+	 * marking from the memory below ISA_END_ADDRESS
>> >+	 */
>> >+	memblock_mark_kho_scratch(0, ISA_END_ADDRESS);
>> >+
>> 
>> At the beginning of e820__memblock_setup() we call memblock_allow_resize(),
>> which means during adding memory region it could double the array. And the
>> memory used here is from some region just added.
>
>There are large KHO scratch areas that will be used for most allocations.
>Marking the memory below ISA_END_ADDRESS as KHO scratch is required to
>satisfy allocations that explicitly limit the allocation to ISA_END_ADDRESS,
>e.g the real time trampoline.
> 

Thanks, I see you point. We would add memory region during kho_populate() and
mark it scratch.

>> But with KHO, I am afraid it would fail?
>> 
>> > 	/* Throw away partial pages: */
>> > 	memblock_trim_memory(PAGE_SIZE);
>> > 
>> 
>> -- 
>> Wei Yang
>> Help you, Help me
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

