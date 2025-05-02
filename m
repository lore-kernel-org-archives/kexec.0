Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55186C3ABA9
	for <kexec@archiver.kernel.org>; Fri,  2 May 2025 00:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WPzx9SjLsbma8jjzIVYfMjxfEmiHm81w0LTL3+ws9pg=; b=LQcEcp7XYk0CRRnNGYIdTZK96U
	D48a3XBcCMsTuVU1MTTdnSZuzY1Rp0hLUguKNeJmU4tt16NoWhOugx8MUGP9zpIbACvgbMMdLlRZf
	JULf4TzriqlwDb3eH36Duk/oWZXgv2+YnW2V7T4HJda5QTyF/i9WhSyZptmahP2SeL09ZgHFzgtt5
	QMUnSpqGHosaWQ23pTra9oPFuJENVYnP5g97EXpSUYA6kIKqkwxnFqjPokcqJcmb2dOesN/nuSClr
	uYFmDvjmAj1CmQXaQeUXTX/ujGoAhAKML1PZm4TvmTkOiPaIJ1G3mskRmKn+Sn3pAtq/X94yHOUrG
	UfyoOKLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAeNq-00000000QIv-3hqD;
	Fri, 02 May 2025 00:36:06 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAeNk-00000000QHF-46Ru;
	Fri, 02 May 2025 00:36:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E7F7BA4B53E;
	Fri,  2 May 2025 00:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC394C4CEE3;
	Fri,  2 May 2025 00:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746146159;
	bh=r6cZ5DSQF3o0HeCCObfwUfYlDtCGgIB48FkNaQjiLrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZxVOGTRW15HvfWwscTK1CyhkU7Z0go8+g3X1Tx0IO+X6s2A0wZzwujqf7KkAM3rfo
	 SerkH9ABOcdbuUmxcJCSJtCW+GF8tU5uQGYr7rJY8LfxJPqG/URjiPpyLqXC1F81IB
	 m37cxSxymyVLc09B33S2IR3AZjFGRqsCNuhqhUgs=
Date: Thu, 1 May 2025 17:35:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Changyuan Lyu <changyuanl@google.com>
Cc: linux-kernel@vger.kernel.org, anthony.yznaga@oracle.com, arnd@arndb.de,
 ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
 catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com,
 devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com,
 graf@amazon.com, hpa@zytor.com, jgowans@amazon.com,
 kexec@lists.infradead.org, krzk@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
 mingo@redhat.com, pasha.tatashin@soleen.com, pbonzini@redhat.com,
 peterz@infradead.org, ptyadav@amazon.de, robh@kernel.org,
 rostedt@goodmis.org, rppt@kernel.org, saravanak@google.com,
 skinsburskii@linux.microsoft.com, tglx@linutronix.de,
 thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Subject: Re: [PATCH v7 06/18] kexec: include asm/early_ioremap.h
Message-Id: <20250501173557.1880f3aa8694352e0eb153b4@linux-foundation.org>
In-Reply-To: <20250501225425.635167-7-changyuanl@google.com>
References: <20250501225425.635167-1-changyuanl@google.com>
	<20250501225425.635167-7-changyuanl@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_173601_134107_CB68F7E2 
X-CRM114-Status: GOOD (  12.72  )
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

On Thu,  1 May 2025 15:54:13 -0700 Changyuan Lyu <changyuanl@google.com> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The early_memremap() function is decleared in a header that is only indirectly
> included here:
> 
> kernel/kexec_handover.c:1116:8: error: call to undeclared function 'early_memremap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>  1116 |         fdt = early_memremap(fdt_phys, fdt_len);
>       |               ^
> 
> ...
>
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -17,6 +17,9 @@
>  #include <linux/memblock.h>
>  #include <linux/notifier.h>
>  #include <linux/page-isolation.h>
> +
> +#include <asm/early_ioremap.h>
> +
>  /*
>   * KHO is tightly coupled with mm init and needs access to some of mm
>   * internal APIs.

When resending, it's best to fold little fixes like this into the base
patch, along with a little note and the author's signed-off-by.

I shall queue this as a fix to be folded into "kexec: add KHO parsing
support", thanks.

