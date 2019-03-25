Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8IxO-0003tL-EF
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 06:19:41 +0000
Date: Mon, 25 Mar 2019 14:19:29 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86/boot: Use EFI setup data if provided
Message-ID: <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
 <20190322152328.GD12472@zn.tnic>
 <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
 <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "bp@suse.de" <bp@suse.de>

On 03/25/19 at 02:01pm, Dave Young wrote:
> On 03/25/19 at 12:27am, Junichi Nomura wrote:
> > On Fri, Mar 22, 2019 at 04:23:28PM +0100, Borislav Petkov wrote:
> > > On Fri, Mar 22, 2019 at 11:03:43AM +0000, Junichi Nomura wrote:
> > > > Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
> > > > boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
> > > > in the early parsing code tries to search RSDP from EFI table but
> > > > whose address is virtual.
> > > > 
> > > > Since kexec(1) provides physical address of config_table via boot_params,
> > > > efi_get_rsdp_addr() should look for setup_data in the same way as
> > > > efi_systab_init() in arch/x86/platform/efi/efi.c does.
> > > 
> > > If the kexec kernel should continue to use efi_systab_init() then you
> > > should make efi_get_rsdp_addr() exit early in the kexec-ed kernel.
> > 
> > I'm not sure which way kexec devel is going. Added kexec list.
> > Here is the version that exits early in efi_get_rsdp_addr().
> > 
> > [PATCH] x86/boot: Don't try to search RSDP from EFI when kexec-booted
> > 
> > Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
> > boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
> > in the early parsing code tries to search RSDP from EFI table but
> > whose address is virtual.
> > 
> > Normally kexec(1) provides physical address of config_table via boot_params
> > and EFI code uses that during initialization.
> > For the early boot code, we just exit efi_get_rsdp_addr() early if the kernel
> > is booted by kexec.
> > 
> > Fixes: 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")
> > Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> > Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > 
> > diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> > index 0ef4ad5..1cefc43 100644
> > --- a/arch/x86/boot/compressed/acpi.c
> > +++ b/arch/x86/boot/compressed/acpi.c
> > @@ -44,6 +44,24 @@ static acpi_physical_address get_acpi_rsdp(void)
> >  	return addr;
> >  }
> >  
> > +static bool is_kexec_booted(void)
> > +{
> > +	struct setup_data *data;
> > +
> > +	/*
> > +	 * kexec-tools provides EFI setup data so that kexec-ed kernel
> > +	 * can find proper tables.
> > +	 */
> > +	data = (struct setup_data *) boot_params->hdr.setup_data;
> > +	while (data) {
> > +		if (data->type == SETUP_EFI)
> > +			return true;
> > +		data = (struct setup_data *) data->next;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  /* Search EFI system tables for RSDP. */
> >  static acpi_physical_address efi_get_rsdp_addr(void)
> >  {
> > @@ -57,6 +75,10 @@ static acpi_physical_address efi_get_rsdp_addr(void)
> >  	int size, i;
> >  	char *sig;
> >  
> > +	/* If the system is kexec-booted, poking EFI systab may not work. */
> > +	if (is_kexec_booted())
> > +		return 0;
> > +
> >  	ei = &boot_params->efi_info;
> >  	sig = (char *)&ei->efi_loader_signature;
> >  
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 
> Good catch, this way looks good to me.  But the function
> is_kexec_booted can be compiled when #ifdef CONFIG_EFI
> 
> Otherwise:
> 
> Acked-by: Dave Young <dyoung@redhat.com>
> 

Hold on, I replied too quick.  One question is does the above patch
passed your test?   It can workaround and skip the wrong phys addr
issue, but the acpi early parsing still fails because efi_get_rsdp_addr
return 0? 

If this is the case you may need go with your old patch.

I think normally people do not see this bug, because kernel will set the
rsdp in boot_params->acpi_rsdp_addr.  Maybe you are testing with
different kernel versions, eg.

old kernel kexec to new kernel.

And the old kernel does not set boot_params->acpi_rsdp_addr

Is this correct?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
