Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38202C41535
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 20:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YX3wJucfzNjPosCl0ob6oZYtXrO7c5psTH8+D214gs8=; b=B58wTN2CicKXpP
	Q4gDKS4jgTdWN4hEaXO5kLY0bO2yv/gpL7LQrqMAp7+bqMjj8kCxtvawpS+tHAT7ZlSC4zB8Ogp9j
	aAVI/JNmeuOLrOlW9Ip/VrCu57coibiUN7n0uDP/FSKES4S76ffxKaZHEOxFQZyulJYTvvcdIh5F8
	ElkarbjfEosEy9Sz7HtjFY45uVt01Z4lQ2WY83N+2YhxIzbHc4p38R70E2We0vcVYvYaN2EpfkhRu
	HanVZGhXThjyMI6wwaLl12fQetaEy1o7r8mB9vWj1rX2/owjUxCq75/snoQPNcDL2X5I1H4LK3+nN
	QQukZIdGHNRtua9DivnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFgbH-00FOIm-2T;
	Tue, 19 Dec 2023 20:21:59 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFgbE-00FOI7-28
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 20:21:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BB524CE181A;
	Tue, 19 Dec 2023 20:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC87C433C8;
	Tue, 19 Dec 2023 20:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703017313;
	bh=LTznM+nJnvfhzKJWRfp37Jsxl2aZjoXM7HdJ4keOzxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PFIpb+JI2WpqXlzcb8/eNuVhDXIZHv61W1U1GOkLLqBTA7ZwRlYwkKSx4lNBnz8zc
	 K+J1kmoB0HqliqBhULCX6Ti76mZEnAhypX2buDp6tQWqZ9IDbQfIXB2WO1k9sM8tsx
	 sHX2EW+qrG7XZIcF52/aPHU4raQG/PPIsXuBaWI0=
Date: Tue, 19 Dec 2023 12:21:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: bhe@redhat.com, bp@alien8.de, corbet@lwn.net,
 dave.hansen@linux.intel.com, ebiederm@xmission.com, hpa@zytor.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH] x86/kexec: use pr_err() instead of kexec_dprintk() when
 an error occurs
Message-Id: <20231219122151.aa4ae562537abf74067588fe@linux-foundation.org>
In-Reply-To: <20231219072902.90104-1-ytcoode@gmail.com>
References: <20231218102436.4378f51a36525ce770f6cd30@linux-foundation.org>
	<20231219072902.90104-1-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_122156_892504_D9CE609D 
X-CRM114-Status: GOOD (  16.63  )
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

On Tue, 19 Dec 2023 15:29:01 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:

> When an error is detected, use pr_err() instead of kexec_dprintk() to
> output log message.
>
> In addition, remove the unnecessary return from set_page_address().

The above describes what the code does, which is already quite clear
from looking at the code.

Please write changelogs and code comments which describe *why* the code
does something, rather than *what* it does.

>
>
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -429,7 +429,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	 * command line. Make sure it does not overflow
>  	 */
>  	if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
> -		kexec_dprintk("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
> +		pr_err("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");

ie, what are the reasons for this change?

>  		return ERR_PTR(-EINVAL);
>  	}
>  
> diff --git a/mm/highmem.c b/mm/highmem.c
> index e19269093a93..bd48ba445dd4 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -799,8 +799,6 @@ void set_page_address(struct page *page, void *virtual)
>  		}
>  		spin_unlock_irqrestore(&pas->lock, flags);
>  	}
> -
> -	return;
>  }
>  
>  void __init page_address_init(void)
> -- 
> 2.43.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
