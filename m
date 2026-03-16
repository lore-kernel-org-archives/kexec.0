Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ADDF30273
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 05:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=54l7x8IhbQtdZRTGFsHRf7iPiatZmyfZH8oZcoYfHkw=; b=H0feuTITMyx4qJF1rUIQtJ9V8D
	7H3pn3ofDKMDRlFFyemRst1+lZJI4EZX08vF3xmwUsfQCgu4sfaTwVLtBXpr9moobq5lIU2tbSyca
	GmDlPckkZ7XAW1U0tu4Zq60tVRwExVmbiHMdMfIsz4Sn+vPHQfE/Pw6H6zbfDJXt7ytFihAIxqBV6
	90uomipTXltHN/3GYV5VPSzuhyqPd55pOv3OfV1eTKuheJdeM7AlkVtVcFRPJShTF1pvM6RHt/Fmt
	63n88uw9NaFiC/QdRXFNaEgUl9ai2NaeQwtojZ1sKtzQGONMllOD1b7I+ekf+3DV+V7mOXYQylQlS
	qa+ZeMeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w20yC-00000003NW3-2Jvl;
	Mon, 16 Mar 2026 05:58:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w20y5-00000003NV8-1aBZ
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 05:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773640698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=54l7x8IhbQtdZRTGFsHRf7iPiatZmyfZH8oZcoYfHkw=;
	b=D5+OrSEd8JUL6ekKV9HNtIMQaYQ/k6XTAr6IBJGN28mcHLRiTh08jYlAbXMwrDT+uHtEFE
	bOPv56woDnKPa3W0RRStkSoaNHbUzzssSVJtzE9zpsdA37oQGeFu0/K63xjjyu2J3AcShZ
	BHpmmfIvGjguRREcnUW8n98t+lTDMzw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-0wxENqZIOi26Y68ERchjUw-1; Mon,
 16 Mar 2026 01:58:14 -0400
X-MC-Unique: 0wxENqZIOi26Y68ERchjUw-1
X-Mimecast-MFC-AGG-ID: 0wxENqZIOi26Y68ERchjUw_1773640693
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38C121953994;
	Mon, 16 Mar 2026 05:58:13 +0000 (UTC)
Received: from localhost (unknown [10.72.112.142])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3528300019F;
	Mon, 16 Mar 2026 05:58:10 +0000 (UTC)
Date: Mon, 16 Mar 2026 13:58:06 +0800
From: Baoquan He <bhe@redhat.com>
To: Kit Dallege <xaum.io@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kexec: add missing kernel-doc parameters for ELF
 loading functions
Message-ID: <abeb7qDkOnmsFMOB@fedora>
References: <20260315171011.66068-1-xaum.io@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20260315171011.66068-1-xaum.io@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 62EZ6RJrcq9-uCGhHm32mTaJwDGAbomGFnt-sZIEhWI_1773640693
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260315_225821_889193_90930B5F 
X-CRM114-Status: GOOD (  21.92  )
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

On 03/15/26 at 06:10pm, Kit Dallege wrote:
> Document all missing parameters across 6 functions in kexec_elf.c:
> elf_is_ehdr_sane(), elf_is_phdr_sane(), elf_read_phdrs(),
> kexec_free_elf_info(), kexec_build_elf_info(), and kexec_elf_load().
> 
> Assisted-by: Claude:claude-opus-4-6


> Signed-off-by: Kit Dallege <xaum.io@gmail.com>

Is this Claude-opus produced patch checked by people? There's no
changelog in this v2, I don't know what's improved since v1. Is it
created automatically?

> ---
>  kernel/kexec_elf.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
> index 3a5c25b2adc9..48f7c0677e87 100644
> --- a/kernel/kexec_elf.c
> +++ b/kernel/kexec_elf.c
> @@ -58,6 +58,7 @@ static uint16_t elf16_to_cpu(const struct elfhdr *ehdr, uint16_t value)
>  
>  /**
>   * elf_is_ehdr_sane - check that it is safe to use the ELF header
> + * @ehdr:	pointer to the ELF header to check.
>   * @buf_len:	size of the buffer in which the ELF file is loaded.
>   */
>  static bool elf_is_ehdr_sane(const struct elfhdr *ehdr, size_t buf_len)
> @@ -180,6 +181,7 @@ static int elf_read_ehdr(const char *buf, size_t len, struct elfhdr *ehdr)
>  
>  /**
>   * elf_is_phdr_sane - check that it is safe to use the program header
> + * @phdr:	pointer to the ELF program header to check.
>   * @buf_len:	size of the buffer in which the ELF file is loaded.
>   */
>  static bool elf_is_phdr_sane(const struct elf_phdr *phdr, size_t buf_len)
> @@ -244,6 +246,9 @@ static int elf_read_phdr(const char *buf, size_t len,
>  
>  /**
>   * elf_read_phdrs - read the program headers from the buffer
> + * @buf:	buffer to read ELF file from.
> + * @len:	size of @buf.
> + * @elf_info:	pointer to existing struct which will be populated.
>   *
>   * This function assumes that the program header table was checked for sanity.
>   * Use elf_is_ehdr_sane() if it wasn't.
> @@ -315,6 +320,7 @@ static int elf_read_from_buffer(const char *buf, size_t len,
>  
>  /**
>   * kexec_free_elf_info - free memory allocated by elf_read_from_buffer
> + * @elf_info:	ELF info struct to free.
>   */
>  void kexec_free_elf_info(struct kexec_elf_info *elf_info)
>  {
> @@ -323,6 +329,10 @@ void kexec_free_elf_info(struct kexec_elf_info *elf_info)
>  }
>  /**
>   * kexec_build_elf_info - read ELF executable and check that we can use it
> + * @buf:	buffer to read ELF file from.
> + * @len:	size of @buf.
> + * @ehdr:	pointer to existing struct which will be populated.
> + * @elf_info:	pointer to existing struct which will be populated.
>   */
>  int kexec_build_elf_info(const char *buf, size_t len, struct elfhdr *ehdr,
>  			       struct kexec_elf_info *elf_info)
> @@ -379,7 +389,11 @@ int kexec_elf_probe(const char *buf, unsigned long len)
>  
>  /**
>   * kexec_elf_load - load ELF executable image
> - * @lowest_load_addr:	On return, will be the address where the first PT_LOAD
> + * @image:		pointer to the kexec image being loaded.
> + * @ehdr:		pointer to the ELF header of the executable.
> + * @elf_info:		pointer to the ELF info struct with program headers.
> + * @kbuf:		pointer to the kexec buffer used for segment loading.
> + * @lowest_load_addr:	on return, will be the address where the first PT_LOAD
>   *			section will be loaded in memory.
>   *
>   * Return:
> -- 
> 2.53.0
> 


