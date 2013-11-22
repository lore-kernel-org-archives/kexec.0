Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjgoU-0004g5-0j
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 02:49:47 +0000
Date: Fri, 22 Nov 2013 10:48:50 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 5/9 v3] efi: export more efi table variable to sysfs
Message-ID: <20131122024850.GC3874@dhcp-16-126.nay.redhat.com>
References: <20131121061704.363730447@dhcp-16-126.nay.redhat.com>
 <20131121061754.887381332@dhcp-16-126.nay.redhat.com>
 <20131121165742.GN26009@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131121165742.GN26009@pd.tnic>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/21/13 at 05:57pm, Borislav Petkov wrote:
> On Thu, Nov 21, 2013 at 02:17:09PM +0800, dyoung@redhat.com wrote:
> > --- efi.orig/arch/x86/platform/efi/efi.c
> > +++ efi/arch/x86/platform/efi/efi.c
> > @@ -653,6 +653,10 @@ void __init efi_init(void)
> >  
> >  	set_bit(EFI_SYSTEM_TABLES, &x86_efi_facility);
> >  
> > +	efi.fw_vendor = (unsigned long)efi.systab->fw_vendor;
> > +	efi.runtime = (unsigned long)efi.systab->runtime;
> > +	efi.config_table = (unsigned long)efi.systab->tables;
> 
> A bit more readable:
> 
> 	efi.config_table = (unsigned long)efi.systab->tables;
> 	efi.fw_vendor	 = (unsigned long)efi.systab->fw_vendor;
> 	efi.runtime	 = (unsigned long)efi.systab->runtime;

Hmm, UEFI spec mentions the them like below so I use the order:

Several fields of the EFI System Table must be converted from
physical pointers to virtual pointers using the ConvertPointer()
service. These fields include FirmwareVendor, RuntimeServices,
and ConfigurationTable.

But since you like the reverse I can change it in next version.

--
Thanks for review
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
