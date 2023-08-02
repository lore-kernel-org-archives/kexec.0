Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A18C001E0
	for <kexec@archiver.kernel.org>; Wed,  2 Aug 2023 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e2qjnyMsSZuGO3ODx9ZfI6vJuMe5zRTTc1z4kmessf8=; b=HsC8noKdfPIgUm
	WFe1jg2XeOvao22gJAHHsLBFOGglfHbf+ZFuN40GZk9L9Q3wzJBbxxBz0ZU/cC1cylnaBetdw3nrc
	rb87xZdi6kOnB+Azf3EG5YgN3dKX/Q07tcrwV5DSoV8MW5VRd4TpJIwNyODTKb+U13IpWmUgzYARR
	fegPtsWGo6VV45Y+1/U9tphHs5AOd1lEjGqMPN7MA/lKoKywwsj46jdG90U9uyjq8IbiftZqSe2pR
	NdxmRVKVF8kVpDH8iooQAGYxLy4RbKV1e84hhLTz7Y4DAeNql5wj4a7cdk80e01yfg3hRKr0l/jAi
	ivfh+89Su8WvtswFwzeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRE9N-005HSV-03;
	Wed, 02 Aug 2023 15:52:37 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRE9J-005HRI-1X
	for kexec@lists.infradead.org;
	Wed, 02 Aug 2023 15:52:35 +0000
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57C621EC0178;
	Wed,  2 Aug 2023 17:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1690991548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=yqMHR0Z0aVeHPdU7GGghI4+MBQDdK48qYp/dKJdytGY=;
	b=fT59unzFBkw1LjdFVUcEWkZwDYLDCa4u6LhyMRHlRs1qaS2uf4k3rrgWeO/XyYVc9CU7aO
	aP/24yaaFPT3H11gEh98HTvol4ZN8Ik2uwG5qkUcm5nKo1MxhT8YQdwiAP0q/YPweozBUp
	FD5zcPLrRpmxr9wn8fbyVYBZlOQiwHo=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ewxjwJTfMDVa; Wed,  2 Aug 2023 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1690991533; bh=yqMHR0Z0aVeHPdU7GGghI4+MBQDdK48qYp/dKJdytGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cvk4t1AzQEkxxA1E1hNXYfPbU+DrxTNYnBKuVbuaYiEHytSWvEY2M9wg6Xs5YHYqF
	 PZOnPuMj0tMFH4OI6+hAVN9PGFor8Yiw86CQUimpbSS6m+3xEZ3VBhcs+t2xZZKKWt
	 ewoDr0HoPx6phDZvvud1M7alF2hYrBIGltul36nEt7VSm+pm4Fab6UqkovVQQpLs16
	 O0mZN/8Hf7mDRwzgK0ct8RY9yBs8KkgNTniRqujZRUN0ddh6S/txFz486yxq/IBAMe
	 xUSgDZAhAQWbfdIF/dKv3Q3ozRb6QniDTu0t+r5xxWCD0FpuvaNLNqkwzcE1KZDAyD
	 CIM+jb+TJ1UARVj5dLhouk5RVCQdsGRgm/hZwIaU/uZ3+23Fssw7kRNw0NUt5OQUVm
	 i23AcHfJmkKxQqcjmyk5nG7jV9brmNy3WSBEQuJiQGXs8OeY58T94trayXPNWHRxdv
	 j5umebvH5TFZp5tAgu659Onukc8T9MvPNUZ+F9R3GhBAU2PxXZzmGOS3slBCii93Na
	 FZmqYb+NPGSNlnHWNWRXdQG+F9ZLvaE0BjY7PRXLA2e2Tn5hZtUD3QX5jkdRLeh6N/
	 3xzX/nvWoUl6mV+S6DUlkIgm3qwOsdqm1vr7MgxyQ7DdtoYaqr5cBYpQeFlY+L6hRr
	 UDQYujMgkBcUV7CzNnifx2pg=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8448040E020F;
	Wed,  2 Aug 2023 15:51:58 +0000 (UTC)
Date: Wed, 2 Aug 2023 17:51:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Tao Liu <ltao@redhat.com>,
	Michael Roth <michael.roth@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-kernel@vger.kernel.org, bhe@redhat.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230802155146.GCZMp7ksDdN2ETVzKV@fat_crate.local>
References: <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
 <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
 <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
 <20230802093927.GAZMokT57anC5jBISK@fat_crate.local>
 <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
 <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local>
 <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_085234_128445_1406B477 
X-CRM114-Status: GOOD (  11.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Aug 02, 2023 at 04:55:27PM +0200, Ard Biesheuvel wrote:
> ... because now, entering via startup_32 is broken, given that it only
> maps the kernel image itself and relies on the #PF handling for
> everything else it accesses, including firmware tables.
> 
> AFAICT this also means that entering via startup_32 is broken entirely
> for any configuration that enables the cc blob config table check,
> regardless of the platform.

Lemme brain-dump what Tom and I just talked on IRC.

That startup_32 entry path for SNP guests was used with old grubs which
used to enter through there and not anymore, reportedly. Which means,
that must've worked at some point but Joerg would know. CCed.

Newer grubs enter through the 64-bit entry point and thus are fine
- otherwise we would be seeing explosions left and right.

So dependent on what we wanna do, if we kill the 32-bit path, we can
kill the 32-bit C-bit verif code. But that's for later and an item on my
TODO list.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
