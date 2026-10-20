Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E5606A31E
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cGRU0Snr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Tk5aRe9/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TP3lHd7ZCrOKSupriqyX6PtdNuECuFfGjiY9AbgLC+E=; b=cGRU0SnrFSQhmqUIesQ3OW/Mp/
	FJTeREVyg05bYBpF/4SreRUk1jkRo4X7dlVpyceV57ydzyA1ZO3IwE2NDOhfqGlSkdc2bAW9n6TdU
	8FRIgXWGQ3E55yiom8WPooM4XTXXNG7Qf+BcJsReoYa9czCsvcMMgGUGzzrfb0SoxQv/Ccul4Khth
	D9WmpYE0MjFVCMbcpMJInoXa9e+oULST6PqyDVbkchOWOBAsmwwjyNmPbc/RzPxC65bgQCDDgDAkR
	Eg72CTMR5iLZ1GDUvvrwy5H7DVgwxHMO0sl3WqoUIQPHNUPiUPjPUOqL8e2CFu9O3tHhx3L8OrZI9
	58JOZD1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ8ft-00000009djv-1VlC;
	Tue, 20 Oct 2026 12:10:37 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ8fq-00000009djZ-2XTj
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 12:10:35 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-48df8fe8513so2724896f8f.0
        for <kexec@lists.infradead.org>; Tue, 20 Oct 2026 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792498233; x=1793103033; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TP3lHd7ZCrOKSupriqyX6PtdNuECuFfGjiY9AbgLC+E=;
        b=Tk5aRe9/coZS+Ru16pfgi6oIacfENUx7Krb3ZtpqoeR8OuxpdT1xAGxlJheLRl9tVa
         xNTj+dmFs9EDh9J1leE9mTdzvFIle9ar1A8NGObjcAyewonXfCIMFEggH/jmUT0iH075
         AmwQlc8w0czwikV0yjmqfb9mqVTzNwxD7gp2eaPWQQcyQEbvdFoQLX/4NmPM4St+hbE6
         fNzJ/Tf5v88oDatCJklP0kSQFcwk+1LV+arEUFNCKYrg8SH3bJ0am0Vla/jSaLoHeWPC
         wADsJ2AaX1XfkzwNh/arSvB8iqy32G9xQHDpdKx4izAPuKINzSK7/l4qryL+OrZgkyeb
         DNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792498233; x=1793103033;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TP3lHd7ZCrOKSupriqyX6PtdNuECuFfGjiY9AbgLC+E=;
        b=ExFbSln1KWeGwgK1s19s13GOER+8HO05D7iZrZY2tHm2iWIf1h2MGGDcZj+O2mLX4k
         jqYiuMn8dOfpUatH9NpwPKBMSS0Yw7X+twHoQUNZftZfXSzo4zEoN1xZTvE1NFdPgxdy
         yRfxdhV9YGMB71/2Ddk9jTKxkLPQ/HAi4muvkgp5yFaZlq7Crl9x9ETz7STke+SSvReG
         xJhFrjQOrnqBUqjGC0YPIdfqRJk1RvnmyrsKNtK+CiTghY/0FpszOb/HC9fOWfLvhpMO
         5cWssJRwWqinhUkffmMxidUAHZ5qxCzOTVSyN0UNrUtjCew6HjowrFZjeE9QvFyVR7Ij
         S4oA==
X-Forwarded-Encrypted: i=1; AKwUvBxLkg6guWNIYkiSD9Ro0RtehJLKZ4aLE4arxtK8NfdLVCXS/SF/LNZgTZY5c8X1ABAkKHfd6A==@lists.infradead.org
X-Gm-Message-State: AFq9FYK49Cw0+ngqgjOEfhvFKnpSF4l1nQuwUyJ41PJhS3WCI5XCyG4Y
	1F6l8RSsn4buOX3V7wrbWhRSCzy3pfH0p9vZpsdnPimRnstDgL3qrgVgl4hBbYtmqtES5YFaOyG
	zBE5oOOU=
X-Gm-Gg: AYBFou2qbc6MRAAV86TDlM7yJcG3U+EAOdT+DioKXUbMCAzYxecAQEvaWJpRSZpg8hv
	q/BR77g3GpgK7A3DZQpSysQ6A5MzhVa/sVgJ9jglPjPcZhGFYXi8oKX5iyiwVHjgH6XHVZjl13B
	A+GUzUDixdH4BqQrK//X1uJKjZoQfRsf0tydlW94+sFWkRvdmz7dptf+dHFP2aUtZWfPIo+SXwx
	bg51O6aN10w9ANYCw9SIYyRHv1XceCOMHmCoyJd//ivzEdUpsM0G6LWviK1YdJ0H7lcOk6RiyUT
	rlFzNK6yDCrYHUUO9evimI2tVl32qFxoH51z4Wz1zI18iqqD6q55aWjJjMgKH2q9w0wE73rk0bX
	PrLfWOoN3dLvzowa/SbRJlok9mgqt/V/iX4gQEfc9eqZAKBGr6ia+UA7h8zWz3u3MUHyZMIoMG4
	qWR3EWtEEEQ7/ocemo0cS/wOoP4r+++4ujz3lzipcOr52XD06E+RNzCiOHRROSdzo8d0KL/FlQS
	HzOvzYqbaw=
X-Received: by 2002:a5d:5f51:0:b0:48e:412:3813 with SMTP id ffacd0b85a97d-48e07bb2fc7mr21324149f8f.20.1792498232549;
        Tue, 20 Oct 2026 05:10:32 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823cfcsm5747053f8f.39.2026.10.20.05.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:10:32 -0700 (PDT)
Date: Tue, 20 Oct 2026 14:10:29 +0200
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Subject: Re: [PATCH v2 2/6] crash: Notify pre-kdump callbacks before
 switching kernels
Message-ID: <atdaNQts1frMB8Kq@pathway.suse.cz>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <9ef573cdbbf5e659eea16fa23afeaf2488049198.1790014793.git.zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef573cdbbf5e659eea16fa23afeaf2488049198.1790014793.git.zack.rusin@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_051034_682593_F6E31E7E 
X-CRM114-Status: GOOD (  17.65  )
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
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Baoquan He <baoquan.he@linux.dev>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 2026-09-28 13:55:36, Zack Rusin wrote:
> Fatal x86 oopses can call crash_kexec() without reaching panic(). Run the
> pre-kdump chain from __crash_kexec() as well, after finding a loaded image
> under the kexec lock and capturing the original registers.
> 
> This covers direct crash entry without moving all panic notifiers ahead
> of kdump. A missing image or failed trylock leaves callbacks uncalled;
> the shared guard skips callbacks already invoked by panic().
> 
> Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
> New in v2: cover direct crash-kexec entry in a separate core patch.
> 
>  kernel/crash_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 2b36aa9fade0..5d9fe9e00f39 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -23,6 +23,7 @@
>  #include <linux/objtool.h>
>  #include <linux/delay.h>
>  #include <linux/panic.h>
> +#include <linux/panic_notifier.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -139,6 +140,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>  			struct pt_regs fixed_regs;
>  
>  			crash_setup_regs(&fixed_regs, regs);
> +			panic_notify_pre_kdump(NULL);

I understand why you did this. But it makes the code really hard to
follow: 

  + This code path will be called also by the 1st __crash_kexec() in
    vpanic() when "_crash_kexec_post_notifiers == false". It is the
    default.

  + The panic_notify_pre_kdump(buf) in vpanic(), added by 1st patch,
    is called when "_crash_kexec_post_notifiers == true" or when
    __crash_kexec() returns from some reason.

None of this is obvious.

I am going to think more about it.

Best Regards,
Petr

>  			crash_save_vmcoreinfo();
>  			machine_crash_shutdown(&fixed_regs);
>  			crash_cma_clear_pending_dma();

