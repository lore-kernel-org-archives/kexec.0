Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B910EB64DC
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 02:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HoLsNhFG1TYjZRcXnhZkDYmwhcW3httC2atM8GUyn/M=; b=br+YENCUU9/AcX
	cf+XiWNSvbaNEziC/fUA2tiUceUTIlvzrgBZAapO7S1lApfccdObWoLfjsWo18605vDQJ3t7v1zDI
	h4hLeauOOWTfj8uy1/sxhJcbZXUK+4hQfVrr+gq58EDcGwp7ob9AjMzureGpxzy6ldIfUGdOE5WKd
	SAdjJ7hUmFOzjTK84nJaU4d1NSXHHosKftygqnbzvHJnR3iHoKh7rlH5hUvH6MZNjF/KAn6xRRaIz
	h2Qw1YJGYnD0IWvi4qkJ/fjkOv3GKd084RvCzsTZ7VrBh/KFNS8Rg144yLD/CoTXN76WjWlgf+40a
	hfObSuskw3XdcZI4/stQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHbV7-003GsH-0v;
	Fri, 07 Jul 2023 02:47:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHbV4-003Grm-1r
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 02:47:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688698032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qoH4ad0vFVh5H5bsCMA0Q+pNHJiT6f1IPBQfe5zvw5s=;
	b=NbWSWDV3EADjb5e2L1v+PR/rWgrIhllYmji0P6R8HXh5X8qRgIfvXC7UG2x6fTSSGy43C+
	olRUvPStRMQrhgeQ+xA5pfAIlaeuvyXU3//nsbl+1H1qzF24cjKLo3HVFJztZ5YY/ekDpA
	3VDsKDTFvc8XZ8DcBWvZ6scoWXsOmJE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-6NPFoNixMW60lkBybvpoSw-1; Thu, 06 Jul 2023 22:45:34 -0400
X-MC-Unique: 6NPFoNixMW60lkBybvpoSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DED638149A8;
	Fri,  7 Jul 2023 02:45:34 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (ovpn-12-250.pek2.redhat.com [10.72.12.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C469C478DE;
	Fri,  7 Jul 2023 02:45:27 +0000 (UTC)
Date: Fri, 7 Jul 2023 10:47:00 +0800
From: Dave Young <dyoung@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Tao Liu <ltao@redhat.com>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	ardb@kernel.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <ZKd8pK7yQ31FWkIx@darkstar.users.ipa.redhat.com>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_194714_772123_D49FBEB7 
X-CRM114-Status: GOOD (  40.15  )
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

On 07/05/23 at 07:33pm, Borislav Petkov wrote:
> On Thu, Jun 01, 2023 at 03:20:44PM +0800, Tao Liu wrote:
> > A kexec kernel bootup hang is observed on Intel Atom cpu due to unmapped
> 
> s/cpu/CPU/g
> 
> > EFI config table.
> > 
> > Currently EFI system table is identity-mapped for the kexec kernel, but EFI
> > config table is not mapped explicitly:
> 
> Why does the EFI config table *need* to be mapped explicitly?
> 
> >     commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI
> >                           tables to the ident map")
> > 
> > Later in the following 2 commits, EFI config table will be accessed when
> > enabling sev at kernel startup.
> 
> What does SEV have to do with an Intel problem?

I'm also curious, let's cc the author of below mentioned commits.

> 
> > This may result in a page fault due to EFI
> > config table's unmapped address. Since the page fault occurs at an early
> > stage, it is unrecoverable and kernel hangs.
> > 
> >     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
> >                           earlier during boot")
> >     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
> >                           detection/setup")
> > 
> > In addition, the issue doesn't appear on all systems, because the kexec
> > kernel uses Page Size Extension (PSE) for identity mapping. In most cases,
> > EFI config table can end up to be mapped into due to 1 GB page size.
> > However if nogbpages is set, or cpu doesn't support pdpe1gb feature
> > (e.g Intel Atom x6425RE cpu), EFI config table may not be mapped into
> > due to 2 MB page size, thus a page fault hang is more likely to happen.
> 
> This doesn't answer my question above.
> 
> > This patch will make sure the EFI config table is always mapped.
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.
> 
> 
> > 
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> > Changes in v2:
> > - Rephrase the change log based on Baoquan's suggestion.
> > - Rename map_efi_sys_cfg_tab() to map_efi_tables().
> > - Link to v1: https://lore.kernel.org/kexec/20230525094914.23420-1-ltao@redhat.com/
> > ---
> >  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > index 1a3e2c05a8a5..664aefa6e896 100644
> > --- a/arch/x86/kernel/machine_kexec_64.c
> > +++ b/arch/x86/kernel/machine_kexec_64.c
> > @@ -28,6 +28,7 @@
> >  #include <asm/setup.h>
> >  #include <asm/set_memory.h>
> >  #include <asm/cpu.h>
> > +#include <asm/efi.h>
> >  
> >  #ifdef CONFIG_ACPI
> >  /*
> > @@ -86,10 +87,12 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
> >  #endif
> >  
> >  static int
> > -map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
> > +map_efi_tables(struct x86_mapping_info *info, pgd_t *level4p)
> >  {
> >  #ifdef CONFIG_EFI
> >  	unsigned long mstart, mend;
> > +	void *kaddr;
> > +	int ret;
> >  
> >  	if (!efi_enabled(EFI_BOOT))
> >  		return 0;
> > @@ -105,6 +108,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
> >  	if (!mstart)
> >  		return 0;
> >  
> > +	ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
> > +	if (ret)
> > +		return ret;
> > +
> > +	kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
> > +	if (!kaddr) {
> > +		pr_err("Could not map UEFI system table\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	mstart = efi_config_table;
> 
> Yeah, about this, did you see efi_reuse_config() and the comment above
> it especially?
> 
> Or is it that the EFI in that box wants the config table mapped 1:1 and
> accesses it during boot/kexec?
> 
> In any case, this is all cloudy without a proper root cause.

efi_reuse_config is patching the SMBIOS table address in efi init path
durint kexec kernel bootup due to some nasty firmware behavior.

It seems the sev code is searching for table with EFI_CC_BLOB_GUID. In
theory it is safe as it will not access SMBIOS table here.  But for
safe purpose it would be better to test on AMD SEV guest, see if the
EFI_CC_BLOB table address is untouched after the 1st kernel booting.

> 
> Also, I'd like for Ard to have a look at this too.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
