Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95DAC77B7A
	for <kexec@archiver.kernel.org>; Fri, 26 May 2023 04:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xX4qMtmogEsfAvY9AFlaofRjf7qO4Vj15jCcCm3Sk7w=; b=rgAzz9qDeaGzbi
	/iyYS7ZD+IPIhyPTdyy7lMe5PtLZw9J86JCbliHQa4IXKDNQ4dIDqKg/G+0VgC1NDsK/mX/qobFU0
	rijcxiM93jYUTQKsHfAlkuVjJAA/HHW+wedrRt8EO+K096arcgnwzHg8K7ReRNabFDTIYNhVUl+rX
	zQV8GTE+2jMjTXdtxOqs2IjyVCox3mXTYU/R54rjFzt8UxzW3rF2ikN9kkjU/0W2nVLjhqftGVy8L
	OwYNGW7NVtxmYiPiLkMBL8yx97Vv/ZkD5Tzsbaz1BA+ttW53cJpPRXe3hHuN1pu/5vH8S7uUj4FWC
	2SbS1AedqzIFZZV2yEcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Oyn-000xyf-2X;
	Fri, 26 May 2023 04:23:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Oyk-000xxP-2Q
	for kexec@lists.infradead.org;
	Fri, 26 May 2023 04:23:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685074980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U2epE74rgQGpSbchmdCJa1fM29pXtiET/OfLMRsBcJc=;
	b=RPJv3cKjvcHp//1DnMydMYf2capru3t+pQZKj/1WFlK7qXPapoQ7T5UWVV1zV986DqzFax
	UjmtezcZ7RAL+/HSOudZ3NNJlEDGr7DZ12++UFo9yNptpNBy0z9ZsSE4n34CPvVkUfkkz7
	Nf8roHZCASv3jaIxE10L9lLNWXL089k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-S2A3ZgtOOM-QvBWPx5kFIw-1; Fri, 26 May 2023 00:22:56 -0400
X-MC-Unique: S2A3ZgtOOM-QvBWPx5kFIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAB5185A5A8;
	Fri, 26 May 2023 04:22:55 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 080F52166B2B;
	Fri, 26 May 2023 04:22:54 +0000 (UTC)
Date: Fri, 26 May 2023 12:22:51 +0800
From: Baoquan He <bhe@redhat.com>
To: Tao Liu <ltao@redhat.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	Ard Biesheuvel <ardb@kernel.org>, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <ZHA0G/jS+XlMzi6N@MiWiFi-R3L-srv>
References: <20230525094914.23420-1-ltao@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230525094914.23420-1-ltao@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_212302_883132_F8ECBD01 
X-CRM114-Status: GOOD (  27.96  )
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

Add Ard to CC.

On 05/25/23 at 05:49pm, Tao Liu wrote:
> A kexec kernel bootup hang is observed on Intel Atom cpu due to unmapped
> EFI config table.
> 
> Currently EFI system table is identity-mapped for the kexec kernel, but EFI
> config table is not mapped explicitly:
> 
>     commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI
>                           tables to the ident map")
> 
> Later in the following 2 commits, EFI config table will be accessed when
> enabling sev at kernel startup. This may result in a page fault due to EFI
> config table's unmapped address. Since the page fault occurs at an early
> stage, it is unrecoverable and kernel hangs.
> 
>     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
>                           earlier during boot")
>     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
>                           detection/setup")
> 
> In addition, the issue doesn't appear on all systems, because the kexec
> kernel uses Page Size Extension (PSE) for identity mapping. In most cases,
> EFI config table can end up to be mapped into due to 1 GB page size.
> However if nogbpages is set, or cpu doesn't support pdpe1gb feature
> (e.g Intel Atom x6425RE cpu), EFI config table may not be mapped into
> due to 2 MB page size, thus a page fault hang is more likely to happen.
> 
> In this patch, we will make sure the EFI config table is always mapped.
> 
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 1a3e2c05a8a5..755aa12f583f 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -28,6 +28,7 @@
>  #include <asm/setup.h>
>  #include <asm/set_memory.h>
>  #include <asm/cpu.h>
> +#include <asm/efi.h>
>  
>  #ifdef CONFIG_ACPI
>  /*
> @@ -86,10 +87,12 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
>  #endif
>  
>  static int
> -map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
> +map_efi_sys_cfg_tab(struct x86_mapping_info *info, pgd_t *level4p)
>  {
>  #ifdef CONFIG_EFI
>  	unsigned long mstart, mend;
> +	void *kaddr;
> +	int ret;
>  
>  	if (!efi_enabled(EFI_BOOT))
>  		return 0;
> @@ -105,6 +108,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
>  	if (!mstart)
>  		return 0;
>  
> +	ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
> +	if (ret)
> +		return ret;
> +
> +	kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
> +	if (!kaddr) {
> +		pr_err("Could not map UEFI system table\n");
> +		return -ENOMEM;
> +	}
> +
> +	mstart = efi_config_table;
> +
> +	if (efi_enabled(EFI_64BIT)) {
> +		efi_system_table_64_t *stbl = (efi_system_table_64_t *)kaddr;
> +
> +		mend = mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
> +	} else {
> +		efi_system_table_32_t *stbl = (efi_system_table_32_t *)kaddr;
> +
> +		mend = mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
> +	}
> +
> +	memunmap(kaddr);
> +
>  	return kernel_ident_mapping_init(info, level4p, mstart, mend);
>  #endif
>  	return 0;
> @@ -244,10 +271,10 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>  	}
>  
>  	/*
> -	 * Prepare EFI systab and ACPI tables for kexec kernel since they are
> -	 * not covered by pfn_mapped.
> +	 * Prepare EFI systab, config table and ACPI tables for kexec kernel
> +	 * since they are not covered by pfn_mapped.
>  	 */
> -	result = map_efi_systab(&info, level4p);
> +	result = map_efi_sys_cfg_tab(&info, level4p);
>  	if (result)
>  		return result;
>  
> -- 
> 2.33.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
