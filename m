Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDD7CAC5A7
	for <kexec@archiver.kernel.org>; Tue, 23 Sep 2025 16:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XafgPKTS6uVeZqg14MUmlXdf5k9uAExktP9DAQc6Wno=; b=BDmDw9SrPGseVfMaSx2Jgc1SmZ
	yob9tb51yfamVq+7hqpqOzPpk2U6fI20d5Juw1A607WNBQFQXm7/J3IlTUeM4AKLWzaFgx1nBBpMA
	moKvBuHgAXrImGfQyjO7oJ3xX+FSs+op8uN/h3pcNjerp1zHfKoalkHx4C6gg8zO9Al2NbexmNvSX
	XJrpW+RYWS6Zb60J0/v5xy5imiqpsCL3XwMnUvzVqVqFd4azWIZND4MkfL2AI5YnYOixGBgbhKZr5
	1tHQoJuvcsHzCbwMwGNf6Esgop9rUqacki0z7QCrt/beTcGPty7VbMixcxWSf+tw060O/kGY8JpLg
	oaaTGb5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v16F2-0000000EJbC-0xuI;
	Tue, 23 Sep 2025 16:51:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v16Ez-0000000EJam-34iQ
	for kexec@lists.infradead.org;
	Tue, 23 Sep 2025 16:51:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2CB6344715;
	Tue, 23 Sep 2025 16:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A631C4CEF5;
	Tue, 23 Sep 2025 16:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758646305;
	bh=mQG0BLn09doLZgKIxhmEOCbAqtuJYfg+WmTgeqeWubg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dskjiY5Y4YAAaShlGNnMT7WdObnSm6ix3EjYQruxAM9BIN63Jt1g+eaGsapjWVMSt
	 dsFnyg+/gkrxHdskBZ9XTiCn1DTw+SjLCfkW0zrM+/a1vPlQylp9r43S+ullTBw0dn
	 kTNXIwMIIu1TZMZZTtbrBIOgGLjU6ncpdU7baYrel3FtrH1UmMBCl9YoqqqrHYBAlF
	 ePV2nj9+2UtMByM6YO1FJNo5YqyzgbMRL3ZqFC4IYX3kQKiyrsy906VVu1y67EGnMF
	 4EPG4F879c4DmGkoK/cT+Qcv7TFLzfnKJKgwjUYK/hP2CRInZAgRVn3KhrEd4dGn/Y
	 wSCD97C3a7Zvg==
Date: Tue, 23 Sep 2025 17:51:41 +0100
From: Simon Horman <horms@kernel.org>
To: Youling Tang <youling.tang@linux.dev>
Cc: Huacai Chen <chenhuacai@kernel.org>, kexec@lists.infradead.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH v2 00/10] Fix and improve the LoongArch implementation
Message-ID: <20250923165141.GD1084957@horms.kernel.org>
References: <20250916014655.841632-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916014655.841632-1-youling.tang@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_095145_815784_EC239FDE 
X-CRM114-Status: GOOD (  12.13  )
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

On Tue, Sep 16, 2025 at 09:46:45AM +0800, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> - Add kexec_file support for LoongArch.
> - Fix and improve the LoongArch implementation.
> - Fixed the handling of crashkernel parameters when using --reuse-cmdline.
> 
> Kernel support for kexec_file was introduced by the patch detailed in Link [1].
> 
> Link[1]:
> https://lore.kernel.org/loongarch/20250903030100.196744-1-youling.tang@linux.dev/T/#t
> 
> Changelog:
> v2:
>  - Add kexec_file support for LoongArch.
>  - Correct email address and Signed-off-by.
> 
> Youling Tang (10):
>   kexec: Handle removal of multiple 'crashkernel' parameters
>   LoongArch: Fix comments
>   LoongArch: Terminate the cmdline string using '\0'
>   LoongArch: Enforce relocatable kernel check for crash dump
>   LoongArch: Change initrd allocation to top-down
>   LoongArch: Fix the use of loongarch_image_header in ELF format
>   LoongArch: Add pe_hdr->machine check for pei format images
>   LoongArch/pez: Fix kernel_fd handling when kexec_file is supported
>   LoongArch: Add kexec_file_load syscall
>   LoongArch: Remove 'kexec_file' cmdline parameters when using
>     --reuse-cmdline option

Thanks, applied.

- LoongArch: Remove 'kexec_file' cmdline parameters when using --reuse-cmdline option
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=19d1b275c649
- LoongArch: Add kexec_file_load syscall
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=f1d66280a48b
- LoongArch/pez: Fix kernel_fd handling when kexec_file is supported
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=b7c35c42c3db
- LoongArch: Add pe_hdr->machine check for pei format images
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=13e701e72ecf
- LoongArch: Fix the use of loongarch_image_header in ELF format
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=919005b26c8f
- LoongArch: Change initrd allocation to top-down
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=2d3f8185f5d7
- LoongArch: Enforce relocatable kernel check for crash dump
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=024073e74dc7
- LoongArch: Terminate the cmdline string using '\0'
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=d9c82c188646
- LoongArch: Fix comments
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=e2bfd6df147c
- kexec: Handle removal of multiple 'crashkernel' parameters
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=39ba2bd288af

