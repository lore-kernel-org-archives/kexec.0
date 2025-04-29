Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA80C369DC
	for <kexec@archiver.kernel.org>; Tue, 29 Apr 2025 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gIQY7xEXbpYM2GrulPmRHIyp5dF9trP+hXYQZJ+rf2g=; b=mBZk1HQ2f9OV3Dh5BsOFBPLtfL
	UtpdJ+gDgqWN8zlheCL59gEh0kt5Iy9bmV9CV5+mlz0kAwZ8wn1KvmB0y0ma+dTFrcHNgc3cpP61Z
	5yzU+u3HdqIIbPMhNHWQ4LPP6Y9zj6LX/dG0F7NgsMvFyBLFeO3bF7NLeKddHwYQbH8tgz5SPuSU3
	UzPTBVtTlVEwumMsO01dErAdf2/YUj57ywjkxfyoY1IV5Gjsq3+/mOiuMXxo3vgW6GCbNMTe+3Fk6
	ClkGtiXa7bvAldMGzyuIL/SfKllwDT7x65NBdEnnndC8PTQbo+oijH2Pc46XKs8p+4x5JgOLd7qIC
	N7Pa+bUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9ncW-0000000AE9u-3CaO;
	Tue, 29 Apr 2025 16:15:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9nH2-0000000ABQv-0Zd8;
	Tue, 29 Apr 2025 15:53:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3081461567;
	Tue, 29 Apr 2025 15:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF31C4CEE3;
	Tue, 29 Apr 2025 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745942011;
	bh=KUMxrCWS4kHpmdAy9k+WvcFlk1e7OoIGE+mnAbwsrzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bodHUhFWmP8Sz+DwztlGIKQ3DTG0NltdGnsHe7ni+bUP6fEyz2VjB5G4/RO632uxl
	 Ok5eMkAxLDy3ES9iw89J6qsDeCiVWLbFAOl4I7iIfYFK1owb91ueyY3AfuR298JbVI
	 jqUuik7hggNabBfGbkajNmHQQFzZBlSs8lHBfO7Pva49NvgOzont8BnXeZz/tZJqXY
	 ajwCCZIduCGd8lSj7mGgCYRo7ELlsZHcloWt+J+CGNmMn65WUlzciIyiX49vYjsa1A
	 sPAaL+CJ+s/g9wScEi5TRBzemcEql28oquwj8CODrTxymcg1tAYr9dgbCkX0CQU3qz
	 htosilAwBJ0Dg==
Date: Tue, 29 Apr 2025 18:53:15 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de,
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
	catalin.marinas@arm.com, corbet@lwn.net,
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com,
	hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org,
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com,
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de,
	robh@kernel.org, rostedt@goodmis.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, tglx@linutronix.de,
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Subject: Re: [PATCH v6 11/14] x86: add KHO support
Message-ID: <aBD165pVhOIl3_by@kernel.org>
References: <20250411053745.1817356-1-changyuanl@google.com>
 <20250411053745.1817356-12-changyuanl@google.com>
 <35c58191-f774-40cf-8d66-d1e2aaf11a62@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35c58191-f774-40cf-8d66-d1e2aaf11a62@intel.com>
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

On Mon, Apr 28, 2025 at 03:05:55PM -0700, Dave Hansen wrote:
> On 4/10/25 22:37, Changyuan Lyu wrote:
> > From: Alexander Graf <graf@amazon.com>
> > 
> > +#ifdef CONFIG_KEXEC_HANDOVER
> > +static bool process_kho_entries(unsigned long minimum, unsigned long image_size)
> > +{
> > +	struct kho_scratch *kho_scratch;
> > +	struct setup_data *ptr;
> > +	int i, nr_areas = 0;
> 
> Do these really need actual #ifdefs or will a nice IS_ENABLED() check
> work instead?
> 
> > +	ptr = (struct setup_data *)(unsigned long)boot_params_ptr->hdr.setup_data;
> 
> What's with the double cast?

The double cast is required for this to be compiled on 32 bits (just like
in mem_avoid_overlap). The setup_data is all u64 and to cast it to a
pointer on 32 bit it has to go via unsigned long.

If we keep actual #ifdef we can drop the double cast because KHO depends on
CONFIG_KEXEC_FILE which is only enabled for 64 bits.
 
> > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> > index 68530fad05f74..518635cc0876c 100644
> > --- a/arch/x86/kernel/kexec-bzimage64.c
> > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > @@ -233,6 +233,31 @@ setup_ima_state(const struct kimage *image, struct boot_params *params,
> >  #endif /* CONFIG_IMA_KEXEC */
> >  }
> >  
> > +static void setup_kho(const struct kimage *image, struct boot_params *params,
> > +		      unsigned long params_load_addr,
> > +		      unsigned int setup_data_offset)
> > +{
> > +#ifdef CONFIG_KEXEC_HANDOVER
> 
> Can this #ifdef be replaced with IS_ENABLED()?

The KHO structures in kexec image are under #ifdef, so it won't compile
with IS_ENABLED().

> > @@ -312,6 +337,13 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
> >  				     sizeof(struct ima_setup_data);
> >  	}
> >  
> > +	if (IS_ENABLED(CONFIG_KEXEC_HANDOVER)) {
> > +		/* Setup space to store preservation metadata */
> > +		setup_kho(image, params, params_load_addr, setup_data_offset);
> > +		setup_data_offset += sizeof(struct setup_data) +
> > +				     sizeof(struct kho_data);
> > +	}
> 
> This is a bit weird that it needs this IS_ENABLED() check and the
> earlier #ifdef. But I guess  it's following the IMA_KEXEC code's pattern
> at least.

And with other #ifdefs as well :)

if (IS_ENABLED()) can be dropped here, but having it makes things more
explicit IMHO.
 
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 766176c4f5ee8..496dae89cf95d 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -451,6 +451,28 @@ int __init ima_get_kexec_buffer(void **addr, size_t *size)
> >  }
> >  #endif
> >  
> > +static void __init add_kho(u64 phys_addr, u32 data_len)
> > +{
> > +#ifdef CONFIG_KEXEC_HANDOVER
> > +	struct kho_data *kho;
> > +	u64 addr = phys_addr + sizeof(struct setup_data);
> > +	u64 size = data_len - sizeof(struct setup_data);
> > +
> > +	kho = early_memremap(addr, size);
> > +	if (!kho) {
> > +		pr_warn("setup: failed to memremap kho data (0x%llx, 0x%llx)\n",
> > +			addr, size);
> > +		return;
> > +	}
> > +
> > +	kho_populate(kho->fdt_addr, kho->fdt_size, kho->scratch_addr, kho->scratch_size);
> > +
> > +	early_memunmap(kho, size);
> > +#else
> > +	pr_warn("Passed KHO data, but CONFIG_KEXEC_HANDOVER not set. Ignoring.\n");
> > +#endif
> > +}
> 
> Please axe the #ifdef in the .c file if at all possible, just like the
> others.

This one follows IMA, but it's easy to make it IS_ENABLED(). It's really up
to x86 folks preference.

-- 
Sincerely yours,
Mike.

