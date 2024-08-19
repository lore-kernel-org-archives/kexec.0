Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4992CC52D7C
	for <kexec@archiver.kernel.org>; Mon, 19 Aug 2024 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Iywpk7jSu6/gaYUzrsVIqwvSl1AIgYbSMuxfaOd2Sps=; b=DlQ84JNUSyJzYz
	Hy1Ix45QAWw94E2on9b+TvVwYWOv+hDGbJqBjkVY9ijEn4WlyIkOzpwZGEy0tvPw258pbnjcsK8y/
	abD8ZCtw/0xiz1iD62pO1B7tnv2LNuTFEnH4gfF9S8n2ThsM10mQ4fkY9KlkZy/u7q5z3f6ezZlcy
	/vrHqTpr30FdC5AtM5gExXYWsKw1KtRComGaFPh9ADxQMiD5j5oL1jT/0qeLQm3J7mXqPZT/tVaR+
	HbkWhjx7MFCXb+UaZLa8ojDcTSghUL6RDL3uYRH9cx7j0T9r3ETaxTS+26pqr7+ivt/VAEOPUaT/F
	hkf27ACe6+wz+Z2EzUPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg7cD-00000002g01-1oPb;
	Mon, 19 Aug 2024 19:00:29 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg6fv-00000002Ub5-08ZP
	for kexec@lists.infradead.org;
	Mon, 19 Aug 2024 18:00:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 57215CE0B1E;
	Mon, 19 Aug 2024 18:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08217C32782;
	Mon, 19 Aug 2024 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724090412;
	bh=H63fgBnwUhY8U7vA2KcfCcuURAdHX2PDPRe0AZv8kzo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=GuqOU689tiiBYPTumtsM+ZV1/ns0/lSWP+MrZFbn6NzJGHuBivjIMKP6f4nzWeyPf
	 TwHVr8yGhlBx+3WT0k2OKZa4ujdkBoHWRmvCsGdnxjjMAkzYQBRDI7CGLTI9YnljOx
	 mVow0Pe2Psavkt9XO7MOoXsBZFTPjFK9uUk/VcE1Rsx+LBm0l/IbY6fGd9vRgiignz
	 PKnkPsSmzTQzxc1Q20HdEk//qtF/LnJdu647BWeIqP5nR1RY73LJUonJUR+wAaEeVq
	 SUq0rTkrPGD8RYZy8hhl4J6yaiu3msntnStXLz2SylfCefh0gdnaBJEn8pGfYP8Aja
	 UT99ES95zNpQA==
Mime-Version: 1.0
Date: Mon, 19 Aug 2024 21:00:08 +0300
Message-Id: <D3K31JJ5PZQG.2XW6Y6OR1CTLG@kernel.org>
Cc: "Ard Biesheuvel" <ardb@kernel.org>, "Jan Hendrik Farr"
 <kernel@jfarr.cc>, "Philipp Rudo" <prudo@redhat.com>, "Lennart Poettering"
 <mzxreary@0pointer.de>, "Eric Biederman" <ebiederm@xmission.com>, "Baoquan
 He" <bhe@redhat.com>, "Dave Young" <dyoung@redhat.com>, "Mark Rutland"
 <mark.rutland@arm.com>, "Will Deacon" <will@kernel.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, <kexec@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 1/9] efi/libstub: Ask efi_random_alloc() to skip
 unusable memory
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Pingfan Liu" <piliu@redhat.com>, <linux-efi@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240819145417.23367-1-piliu@redhat.com>
 <20240819145417.23367-2-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-2-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_110015_271819_ECC5986A 
X-CRM114-Status: GOOD (  15.12  )
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

On Mon Aug 19, 2024 at 5:53 PM EEST, Pingfan Liu wrote:
> efi_random_alloc() demands EFI_ALLOCATE_ADDRESS when allocate_pages(),
> but the current implement can not ensure the selected target locates
> inside free area, that is to exclude EFI_BOOT_SERVICES_*,
> EFI_RUNTIME_SERVICES_* etc.
>
> Fix the issue by checking md->type.

If it is a fix shouldn't this have a fixes tag?

>
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> To: linux-efi@vger.kernel.org
> ---
>  drivers/firmware/efi/libstub/randomalloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
> index c41e7b2091cdd..7304e767688f2 100644
> --- a/drivers/firmware/efi/libstub/randomalloc.c
> +++ b/drivers/firmware/efi/libstub/randomalloc.c
> @@ -79,6 +79,8 @@ efi_status_t efi_random_alloc(unsigned long size,
>  		efi_memory_desc_t *md = (void *)map->map + map_offset;
>  		unsigned long slots;
>  

I'd add this inline comment:

/* Skip "unconventional" memory: */

> +		if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTENT_MEMORY)))
> +			continue;
>  		slots = get_entry_num_slots(md, size, ilog2(align), alloc_min,
>  					    alloc_max);
>  		MD_NUM_SLOTS(md) = slots;
> @@ -111,6 +113,9 @@ efi_status_t efi_random_alloc(unsigned long size,
>  		efi_physical_addr_t target;
>  		unsigned long pages;
>  
> +		if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTENT_MEMORY)))
> +			continue;
> +
>  		if (total_mirrored_slots > 0 &&
>  		    !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
>  			continue;

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
