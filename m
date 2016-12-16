Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cHiKA-0004gV-Iq
 for kexec@lists.infradead.org; Fri, 16 Dec 2016 02:32:43 +0000
Date: Fri, 16 Dec 2016 10:32:13 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v1 2/2] firmware: dmi_scan: Pass dmi_entry_point to
 kexec'ed kernel
Message-ID: <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <20161202195416.58953-3-andriy.shevchenko@linux.intel.com>
 <20161215122856.7d24b7a8@endymion>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20161215122856.7d24b7a8@endymion>
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
To: Jean Delvare <jdelvare@suse.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On 12/15/16 at 12:28pm, Jean Delvare wrote:
> Hi Andy,
> 
> On Fri,  2 Dec 2016 21:54:16 +0200, Andy Shevchenko wrote:
> > Until now kexec'ed kernel has no clue where to look for DMI entry point.
> > 
> > Pass it via kernel command line parameter in the same way as it's done for ACPI
> > RSDP.
> 
> I am no kexec expert but this confuses me. Shouldn't the second kernel
> have access to the EFI systab as the first kernel does? It includes
> many more pointers than just ACPI and DMI tables, and it would seem
> inconvenient to have to pass all these addresses individually
> explicitly.

Yes, in modern linux kernel, kexec has the support for EFI, I think it
should work naturally at least in x86_64.

Is there any test log with latest mainline kernel about this?

> 
> Adding Eric to Cc for his opinion.
> 
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
> >  drivers/firmware/dmi_scan.c                     | 14 ++++++++++++++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index be2d6d0..94f219f 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -843,6 +843,11 @@
> >  			The filter can be disabled or changed to another
> >  			driver later using sysfs.
> >  
> > +	dmi_entry_point=	[DMI,EFI,KEXEC]
> > +			Pass the DMI entry point to the kernel, mostly used
> > +			on machines running EFI runtime service to boot the
> > +			second kernel for kdump.
> > +
> >  	drm_kms_helper.edid_firmware=[<connector>:]<file>[,[<connector>:]<file>]
> >  			Broken monitors, graphic adapters, KVMs and EDIDless
> >  			panels may send no or incorrect EDID data sets.
> > diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> > index b88def6..215843f 100644
> > --- a/drivers/firmware/dmi_scan.c
> > +++ b/drivers/firmware/dmi_scan.c
> > @@ -595,8 +595,22 @@ static int __init dmi_smbios3_present(const u8 *buf)
> >  	return 1;
> >  }
> >  
> > +#ifdef CONFIG_KEXEC
> > +static unsigned long dmi_entry_point;
> > +static int __init setup_dmi_entry_point(char *arg)
> > +{
> > +	return kstrtoul(arg, 16, &dmi_entry_point);
> > +}
> > +early_param("dmi_entry_point", setup_dmi_entry_point);
> > +#endif
> > +
> >  static resource_size_t __init dmi_get_entry_point(void)
> >  {
> > +#ifdef CONFIG_KEXEC
> > +	if (dmi_entry_point)
> > +		return dmi_entry_point;
> > +#endif
> > +
> >  	if (efi_enabled(EFI_CONFIG_TABLES)) {
> >  		/*
> >  		 * According to the DMTF SMBIOS reference spec v3.0.0, it is
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
