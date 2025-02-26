Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4555EC021B2
	for <kexec@archiver.kernel.org>; Wed, 26 Feb 2025 01:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=WEgQbAyN812Od1PLDKL03NyhRQA8kQhgcIrLRcSGxlQ=; b=Hj0u1VMMWdAdp/
	63QBO8yyYK4BWTV/514uieAf+wq1wxZTD9c/VCM8VTRvtwpdobJSzmuCDYkYk1J3eWg/0zVtYTTie
	hUS2+Sf+ua8YTZmhAEkDC+YVEPP+TptzC7PsW7Wbt53ftn6ZZFowTavvw3XEhXPh651T2K0o5Wv4X
	Is9HesVpMgwHb1YpKTUR7XhNTSXsPkePXDzd/dGU1Hla85DHXGKsMrhzCWoqsYZDElrGoc7XUSG1t
	tHb021+tnObOw1keM2Wz91MtoMqFVt1ksjovKpeB4ti31t/cwSJ6dongXGiizg1hiLv148zTaOP8+
	MojvogQPU4viiMnlab7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn6e9-000000023SO-0Q2d;
	Wed, 26 Feb 2025 01:55:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn6cm-000000023Hw-23Xx
	for kexec@bombadil.infradead.org;
	Wed, 26 Feb 2025 01:54:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:References;
	bh=WEgQbAyN812Od1PLDKL03NyhRQA8kQhgcIrLRcSGxlQ=; b=natpDd/F/x76C2h8QD1zMR3zsk
	6YTlDGz020X/QE+hh/EasA5Av/IHdra9kupjT+DqKn92FMtaVBb4x01GitN+/RteKqYA2OOi1jcG+
	yhO1hyqiS/VS9LgTlUmRIqzIOuyNnBLBUOoiBGnu71FRpWN8vxuMgd7MzLJytanedya13C4BByBt8
	TPNUy/XH7R74/JKorWwmyaJ3CiWPyy9zr+kKIVz9jKSTSts9hwwfmY4xvMWa+I3PrxdrVsxFLy3t9
	9SD+PZjVNW7D7lHQTqEtt7lzsHyucKh6hAAknXpqCS8dk8yxZw74P4GVdBNhpplaUvW05ZMaBiqB8
	Jpa+Sxfg==;
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn6cg-00000003UDE-2Uty
	for kexec@lists.infradead.org;
	Wed, 26 Feb 2025 01:54:09 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-22101351b1dso127446505ad.3
        for <kexec@lists.infradead.org>; Tue, 25 Feb 2025 17:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740534840; x=1741139640; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WEgQbAyN812Od1PLDKL03NyhRQA8kQhgcIrLRcSGxlQ=;
        b=byxFdDOxZwJWNimAgp5tisBHznaFweaX2B+5Sc2jD8pn/2a9DHyoF3Y6W5+YZcG9Z9
         RPQ52/Px9K/1NTDIWFcMQ9Yvea4T1zC32l0lxDBONVpMRLFJoS3hmRTHdA4BdaDJipwp
         8mUG7rKP5+N9Xjs+NHC/A0dVcApKBemIol7++C7oA3KFWDYZmANPxkuQjR6sk4tOJ5hM
         yxcKUD/Skl2HMWW96NDrQF5PYorO/HrUzY7Z2uCsXy4KeXQrTYv+8XFywQXvlzL5njBo
         l/QQ4WR30n7SWdl8rYXv9zo8HXdsxvjLvz+O6Pa+CuPYx0hskEBH45Rx7sdAhrVCFeNH
         RxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740534840; x=1741139640;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WEgQbAyN812Od1PLDKL03NyhRQA8kQhgcIrLRcSGxlQ=;
        b=Zg5Zz1uiCWlabM0XtpvCVmpcVmawyfaNixZUagRr3aSV0qhHBCrmIOKHBUrGpeKIb5
         SsuoQVnOkzMXeWS3JZJi6r03o3W0CL4/elmrLe34TRiplcZknxhA0zOlA/V/CYllN656
         qfseCWCb5sweV0qGy9SUUWfnIMW29/DybQrLieT287ejx5ylgsUNhgOwE8OIyxWdtlYl
         mBmeXT5tuRmc6hmPEj+giQ8Qj4v58+uX4Yo+hSAu2U8b1IH/STd7A5byRCfuV/gfGJKP
         9B0G36NDQa8cmCUk3NFQq9ayNm/gKB33qINQl41JsRRgs+VkzfPUN2YAhb3GgZ8NcZQS
         5jWw==
X-Forwarded-Encrypted: i=1; AJvYcCWTyR//LrooE2AEHwYczP8YVp1vPQZqFTShX5jhnD6SyHWMT9xCvm9r/GvUlcAKXW28TvtIbQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyPd2XRE/Kmx7iT6rq6BAyzHhrMKsO3arzwPGk+57+o6WddiGrX
	MUEFzf/nUw16lCLWoM5jhhvyB7O4Y6PV6xeq+YBJzesn4Lx8QN97ZmelGG+sf6d5YZbogqrEi+5
	X/SGsCBSRN+NifcTMtw==
X-Google-Smtp-Source: AGHT+IFkznZMkNBk5de2vOfANCIGfGmFUq4ZoIai/G7n3JkeCyYN8XDtQ2NLIWeTlmgvn0M2N7vBP6JVrlIIeeRX
X-Received: from pfbna17.prod.google.com ([2002:a05:6a00:3e11:b0:732:502c:4a0f])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e1e:b0:725:df1a:285 with SMTP id d2e1a72fcca58-7348bdd003bmr2703166b3a.12.1740534840070;
 Tue, 25 Feb 2025 17:54:00 -0800 (PST)
Date: Tue, 25 Feb 2025 17:53:39 -0800
In-Reply-To: <20250206132754.2596694-3-rppt@kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250226015342.2136669-1-changyuanl@google.com>
Subject: Re: [PATCH v4 02/14] memblock: add MEMBLOCK_RSRV_KERN flag
From: Changyuan Lyu <changyuanl@google.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Changyuan Lyu <changyuanl@google.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ashish Kalra <ashish.kalra@amd.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@redhat.com>, 
	James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Usama Arif <usama.arif@bytedance.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_015407_936597_57AAD485 
X-CRM114-Status: GOOD (  17.23  )
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

Hi Mike,

On Thu,  6 Feb 2025 15:27:42 +0200, Mike Rapoport <rppt@kernel.org> wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> to denote areas that were reserved for kernel use either directly with
> memblock_reserve_kern() or via memblock allocations.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/memblock.h | 16 +++++++++++++++-
>  mm/memblock.c            | 32 ++++++++++++++++++++++++--------
>  2 files changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index e79eb6ac516f..65e274550f5d 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> ......
> @@ -116,7 +117,19 @@ int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid,
>  int memblock_add(phys_addr_t base, phys_addr_t size);
>  int memblock_remove(phys_addr_t base, phys_addr_t size);
>  int memblock_phys_free(phys_addr_t base, phys_addr_t size);
> -int memblock_reserve(phys_addr_t base, phys_addr_t size);
> +int __memblock_reserve(phys_addr_t base, phys_addr_t size, int nid,
> +		       enum memblock_flags flags);
> +
> +static __always_inline int memblock_reserve(phys_addr_t base, phys_addr_t size)
> +{
> +	return __memblock_reserve(base, size, NUMA_NO_NODE, 0);

Without this patch `memblock_reserve` eventually calls `memblock_add_range`
with `MAX_NUMNODES`, but with this patch, `memblock_reserve` calls
`memblock_add_range` with `NUMA_NO_NODE`. Is it intended or an
accidental typo? Thanks!

> ......
>
> -int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
> +int __init_memblock __memblock_reserve(phys_addr_t base, phys_addr_t size,
> +				       int nid, enum memblock_flags flags)
>  {
>  	phys_addr_t end = base + size - 1;
>
> -	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> -		     &base, &end, (void *)_RET_IP_);
> +	memblock_dbg("%s: [%pa-%pa] nid=%d flags=%x %pS\n", __func__,
> +		     &base, &end, nid, flags, (void *)_RET_IP_);
>
> -	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);

Originally `memblock_reserve` calls `memblock_add_range` with `MAX_NUMNODES`,
See my comments above.

Best,
Changyuan

