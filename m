Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2636E7717D
	for <kexec@archiver.kernel.org>; Wed, 11 Dec 2024 13:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qd9NakjpvIytA6vjwOGgInJVtxHEb9hPMV7KW579E9c=; b=arywbv5vZhK/Og+cniTiWqCLCf
	rbAiiygsC/3JkeAxdJpyhlF+SdaS9jcyI7/zfZkS6UpcOpNGu28rewfGas2xiGTrQHvejgRbqOk8a
	7fR8+lKoeHJXwRc9asKnb8mRUjpP1dxkIECcDbcFrPx2KZu8/eOd5Kmd0sWZiKa8yuQ7XRTSbeVg/
	RLTOSezxsmulpOBIcOF3n68YQq2x68L5nWllKAARobHRSFrpqPPkVuQUfrW1Y6OqrkcgRs2DQ24Vj
	7WEuDrP0GzAf5gAquntujkCds3DImMj30PV4LShWBLAkT+Ja6uPGRC5h6SgZQ8o6VpuTgOeDi2sEm
	VdT2AULA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLMNu-0000000EvCD-1nBd;
	Wed, 11 Dec 2024 13:04:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLMGC-0000000Eti6-17UQ
	for kexec@lists.infradead.org;
	Wed, 11 Dec 2024 12:56:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733921771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qd9NakjpvIytA6vjwOGgInJVtxHEb9hPMV7KW579E9c=;
	b=i13kWdb6hCubNK1Lua5wuNfxC9+dE6PARvQNOkS/ziU+eYybT7XSdvqMq+UECEhABNOzCn
	kMYJwzGcbSzbhlDoFZk6CPR/LRk5ZP2Z87EhOpObNOhqSnzoVpu8WAO3ZN6velC9Q/AFUf
	wr2t1pLShI+00++nT+mGUFrnm3s2TUA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-5w0geDonMzCS8396TgF_XQ-1; Wed,
 11 Dec 2024 07:56:06 -0500
X-MC-Unique: 5w0geDonMzCS8396TgF_XQ-1
X-Mimecast-MFC-AGG-ID: 5w0geDonMzCS8396TgF_XQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61670195609D;
	Wed, 11 Dec 2024 12:56:04 +0000 (UTC)
Received: from localhost (unknown [10.72.112.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 921081956048;
	Wed, 11 Dec 2024 12:56:02 +0000 (UTC)
Date: Wed, 11 Dec 2024 20:55:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 6/7] x86/crash: pass dm crypt keys to kdump kernel
Message-ID: <Z1mL2KBcRskFlffk@MiWiFi-R3L-srv>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-7-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029055223.210039-7-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_045612_379592_214D716B 
X-CRM114-Status: GOOD (  21.23  )
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

On 10/29/24 at 01:52pm, Coiby Xu wrote:
> 1st kernel will build up the kernel command parameter dmcryptkeys as
> similar to elfcorehdr to pass the memory address of the stored info of
> dm crypt key to kdump kernel.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/x86/kernel/crash.c           | 20 ++++++++++++++++++--
>  arch/x86/kernel/kexec-bzimage64.c |  7 +++++++
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 340af8155658..99d50c31db02 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -278,6 +278,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
>  				 unsigned long long mend)
>  {
>  	unsigned long start, end;
> +	int ret;
>  
>  	cmem->ranges[0].start = mstart;
>  	cmem->ranges[0].end = mend;
> @@ -286,22 +287,37 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
>  	/* Exclude elf header region */
>  	start = image->elf_load_addr;
>  	end = start + image->elf_headers_sz - 1;
> -	return crash_exclude_mem_range(cmem, start, end);
> +	ret = crash_exclude_mem_range(cmem, start, end);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* Exclude dm crypt keys region */
> +	if (image->dm_crypt_keys_addr) {
> +		start = image->dm_crypt_keys_addr;
> +		end = start + image->dm_crypt_keys_sz - 1;
> +		return crash_exclude_mem_range(cmem, start, end);
> +	}
> +
> +	return ret;
>  }
>  
>  /* Prepare memory map for crash dump kernel */
>  int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>  {
> +	unsigned int max_nr_ranges = 3;

Define a macro and add code comment to explain why this value is taken?

>  	int i, ret = 0;
>  	unsigned long flags;
>  	struct e820_entry ei;
>  	struct crash_memmap_data cmd;
>  	struct crash_mem *cmem;
>  
> -	cmem = vzalloc(struct_size(cmem, ranges, 1));
> +	cmem = vzalloc(struct_size(cmem, ranges, max_nr_ranges));
>  	if (!cmem)
>  		return -ENOMEM;
>  
> +	cmem->max_nr_ranges = max_nr_ranges;
> +
>  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
>  	cmd.params = params;
>  
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 68530fad05f7..9c94428927bd 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
>  	if (image->type == KEXEC_TYPE_CRASH) {
>  		len = sprintf(cmdline_ptr,
>  			"elfcorehdr=0x%lx ", image->elf_load_addr);
> +
> +		if (image->dm_crypt_keys_addr != 0)
> +			len += sprintf(cmdline_ptr + len,
> +					"dmcryptkeys=0x%lx ", image->dm_crypt_keys_addr);
>  	}
>  	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
>  	cmdline_len += len;
> @@ -441,6 +445,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  		ret = crash_load_segments(image);
>  		if (ret)
>  			return ERR_PTR(ret);
> +		ret = crash_load_dm_crypt_keys(image);
> +		if (ret)
> +			pr_debug("Either no dm crypt key or error to retrieve the dm crypt key\n");

If it's error, do we need change ti to pr_debug?
>  	}
>  #endif
>  
> -- 
> 2.47.0
> 


