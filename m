Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264101075269
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 02:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SJ8sIisCrKz1pfFqCGWdfudAJu2vDi/fhdg2VLlfn5k=; b=h01fwJpLkzRcEycGCAF1bXJYC4
	Eh23LHQ1iNlC6rb6Rf+GmJhK+ABepKK+DZ5R1HuEJnfXHWXBvNXo+w0BHT16gZHRA277bTIiUfLvi
	u8j1ac5dnwFQO/FLe5NC1rmtTcOE8eTc6W0IYLekHf3FAGA131LZYV3rUP16/EHZdUWOEVdPHkaNa
	HerKzRSUS8bIjvIgRF1ll3ygxCN/kjZ9od31Q8ihRm1BF2Zwb0+ZUH3CI9mFegOXNIL6xBAuJTr5E
	k6P4qbL0ux40rzuttzL2rIEIK9Iywf/bX1ryz5GyoihUJb9UxC/DKVTjNPKhelT4rNSWNDXVu+a8x
	n00kZuiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48WV-0000000EzBA-11h8;
	Sun, 22 Mar 2026 02:26:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48WT-0000000Ez9m-15hP
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 02:26:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8EB6F4447E;
	Sun, 22 Mar 2026 02:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9A0C19421;
	Sun, 22 Mar 2026 02:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774146396;
	bh=4b4Etkege9OuIa+NLmVfx9XW/rjguhYd053gW25s+f0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=omDg/ew1B/3T9euyYM+m4qesco9pn8VGkh8qG9e3lbttkcwrtm1SsyNexDpkh/0JG
	 9cLX1Vck4NNWMlkJ2EmLCl3adqo7nZ5eslMoJnmrE6ryF3duWpQLw1ZaP/mdBPQgPs
	 uz4HA1eNUU+iRLhwCblcWzjgQeaKQI51JRbngvpKsyqHFkrOaRcjkQjU8VsIllgRiC
	 lxnPh9mXaYd/AOFDTitvxOzl3zItFnxnSYg9n6r2l4JJohvZBssgShTse1arFnlsOV
	 xHUFwRPcEzTB3dakxF/6B5b+3vCTBbZPcNp5rRY7Sd0tGgdVazAD5kuqLVc8czWqI0
	 0UJMjkiNZaWfw==
Content-Type: multipart/mixed; boundary="===============4421140977929886089=="
MIME-Version: 1.0
Message-Id: <e3b343793849491757c2745b3d6d23a079bf9c0d6c32ba32874aee826911167d@mail.kernel.org>
In-Reply-To: <20260322014402.8815-4-piliu@redhat.com>
References: <20260322014402.8815-4-piliu@redhat.com>
Subject: Re: [PATCHv7 03/13] lib/decompress: Keep decompressor when CONFIG_KEEP_DECOMPRESSOR
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,linux-kernel@vger.kernel.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,kexec@lists.infradead.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 02:26:35 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_192637_321457_6A70E3F6 
X-CRM114-Status: UNSURE (   9.01  )
X-CRM114-Notice: Please train this message.
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

--===============4421140977929886089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
> index ac862422df15..39df02bcbc66 100644
> --- a/include/linux/decompress/mm.h
> +++ b/include/linux/decompress/mm.h

[ ... ]

> @@ -92,7 +93,14 @@ MALLOC_VISIBLE void free(void *where)
>  #define large_malloc(a) vmalloc(a)
>  #define large_free(a) vfree(a)
>
> +#ifdef CONFIG_KEEP_DECOMPRESSOR
> +#define INIT
> +#define INITCONST
> +#else
>  #define INIT __init
> +#define INITCONST __initconst
> +#endif

The INITCONST macro is defined here in the kernel path (the #else
branch of #ifdef STATIC), but the pre-boot path earlier in this
header only defines INIT:

include/linux/decompress/mm.h:
    #ifdef STATIC
    ...
    #define INIT

Should INITCONST also be defined in the pre-boot path for
consistency? The individual decompressor files (decompress_inflate.c,
decompress_bunzip2.c, etc.) all include this header and are compiled
in both contexts. If any of them later uses INITCONST for a const
array following the pattern in lib/decompress.c, the pre-boot build
would fail with an undefined macro.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23393379437
--===============4421140977929886089==--

