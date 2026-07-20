Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F259FC4451B
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 09:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6iP3IcWKCPT9qAJ1CcuBL5r1Yf8wv9J89G/A7Z4zTJg=; b=ZBYpj6R79SMSWWXOFA5g1+IVK1
	Yyym3asAZJQeCzG5xv+CwtxQntg1hBy1RrP/qkmhmsJSc33MTma0Ob9F55kK3YC09msWPvCZ5Qouq
	ZQfFCnb0kzkxGP8E2eEdtx/mzZnUNbqSOPd3D5P0O9xBVjSrD2coqOewnSh2C58oh9s49hKXrCLAi
	ON7AvbK99WRqx3p1Y4FKN0QToyfcRM2TotCn7PmZzAS82KOTJKZaO1RXxTjW7puiS4QOnca9pv+au
	4G+f3jAcupIu2PREp54XCjdkLCf7euDxKAskmrRKklcD8Fo+tdJoOGUFgPAQGQJJ3996ZV/rKA7Ry
	aiZrLoJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlkEL-00000006IRr-3vaL;
	Mon, 20 Jul 2026 09:24:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlkEL-00000006IRl-14ZR
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 09:24:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B4BB140767;
	Mon, 20 Jul 2026 09:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFA61F000E9;
	Mon, 20 Jul 2026 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784539448;
	bh=6iP3IcWKCPT9qAJ1CcuBL5r1Yf8wv9J89G/A7Z4zTJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JrYC9+mzi6mRG+CWSxyJ2rrGJobZbd0qEO9X1kOX55yocpSA2OzQ8dLoCMC9muBzL
	 09RfJi9B00On0rc+sBOU4rwVoLuCUWwF8bB3jgZXatcdruVoBuaZwyEKqWIATltNrV
	 b3pLfNaMQZvhWjXHxCIm2sJyecCY5tMCU3jVZUVKKtGsPyasjdIx1F5Kh0WnZXWsHI
	 /Tlv1/LsYOXtFl6ZolHPYg4xATysWUV3hkmwOChat/XC+0zrbc0Um77yQv05Lih7BB
	 +aHxIAbFN7vn3MvVLccodVDlkS2WoOLo47EqPwmqiKgktBAoTHGiSxmAaZ3e0S/cOS
	 IU9M4ECw7/iOw==
Date: Mon, 20 Jul 2026 10:24:06 +0100
From: Simon Horman <horms@kernel.org>
To: Pnina Feder <pnina.feder@mobileye.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH 01/10] util_lib: add paddr_to_offset function and expose
 raw vmcoreinfo data
Message-ID: <20260720092406.GB1736709@horms.kernel.org>
References: <20260622205550.1087163-1-pnina.feder@mobileye.com>
 <20260622205550.1087163-2-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622205550.1087163-2-pnina.feder@mobileye.com>
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

On Mon, Jun 22, 2026 at 11:54:39PM +0300, Pnina Feder wrote:
> Add paddr_to_offset() to translate physical addresses to file offsets,
> complementing the existing vaddr_to_offset() for virtual addresses.
> 
> Store raw vmcoreinfo note data when parsing ELF notes and provide
> elf_get_raw_vmcoreinfo() accessor to retrieve it. This allows callers
> to access the unparsed vmcoreinfo content for external processing.
> and fix compilation warnings.
> 
> Change-Id: Icc75c22d6b2d95b6c951ccf647819d7e9cc4e7de
> Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>

Overall this looks good to me.
I have provided some minor feedback inline.

> ---
>  util_lib/elf_info.c         | 53 ++++++++++++++++++++++++++++++++-----
>  util_lib/include/elf_info.h | 11 ++++----
>  2 files changed, 52 insertions(+), 12 deletions(-)
> 
> diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c

...

> @@ -776,7 +805,7 @@ static void dump_dmesg_legacy(int fd, void (*handler)(char*, unsigned int))
>  	 * To collect full dmesg including the part before `dmesg -c` is useful
>  	 * for later debugging. Use same logic as what crash utility is using.
>  	 */
> -	logged_chars = log_end < log_buf_len ? log_end : log_buf_len;
> +	logged_chars = log_end < (unsigned int)log_buf_len ? log_end : (unsigned int)log_buf_len;

Adding this cast seems to be a clean-up which is not strictly related to
this patch. I'm not a huge fan of adding casts, but that aside, it
seems like a cleanup that would be best put in a separate patch.

Likewise for similar updates in this patch.

>  
>  	if (handler)
>  		handler(buf + (log_buf_len - logged_chars), logged_chars);

...

> diff --git a/util_lib/include/elf_info.h b/util_lib/include/elf_info.h
> index fdf4c3d0..c2873365 100644
> --- a/util_lib/include/elf_info.h
> +++ b/util_lib/include/elf_info.h
> @@ -24,13 +24,14 @@
>  #include <ctype.h>
>  
>  int get_pt_load(int idx,
> -	unsigned long long *phys_start,
> -	unsigned long long *phys_end,
> -	unsigned long long *virt_start,
> -	unsigned long long *virt_end);
> +		unsigned long long *phys_start,
> +		unsigned long long *phys_end,
> +		unsigned long long *virt_start,
> +		unsigned long long *virt_end);

Similarly, this whitespace change also seems to be a clean-up and if so
doesn't belong in this patch.

>  int read_phys_offset_elf_kcore(int fd, long *phys_off);
>  int read_elf(int fd);
>  void dump_dmesg(int fd, void (*handler)(char*, unsigned int));
>  extern void (*arch_scan_vmcoreinfo)(char *pos);
> -
> +uint64_t paddr_to_offset(uint64_t paddr);
> +int elf_get_raw_vmcoreinfo(const char **data, size_t *size);
>  #endif /* ELF_INFO_H */
> -- 
> 2.43.0
> 

