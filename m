Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f68.google.com ([209.85.166.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hC6kF-0001sp-R2
 for kexec@lists.infradead.org; Thu, 04 Apr 2019 18:05:49 +0000
Received: by mail-io1-f68.google.com with SMTP id s7so2759188iom.12
 for <kexec@lists.infradead.org>; Thu, 04 Apr 2019 11:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190328094910.12368-1-kasong@redhat.com>
 <20190404072529.GB5708@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190404072529.GB5708@dhcp-128-65.nay.redhat.com>
From: Kairui Song <kasong@redhat.com>
Date: Fri, 5 Apr 2019 02:05:33 +0800
Message-ID: <CACPcB9d4GT2p=1Q2RrpJ6+kbm+-kXV5-ee-91YZJAc76tJ=nzg@mail.gmail.com>
Subject: Re: [PATCH] x86: Always to to fill acpi_rsdp_addr in boot params
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
To: Dave Young <dyoung@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>

On Thu, Apr 4, 2019 at 3:25 PM Dave Young <dyoung@redhat.com> wrote:
>
> Hello Kairui
> On 03/28/19 at 05:49pm, Kairui Song wrote:
> > Since kernel commit e6e094e053af75 ("x86/acpi, x86/boot: Take RSDP address
> > from boot params if available"), kernel accept a acpi_rsdp_addr param in
> > boot_params. Sync the x86_linux_param_header to support this param.
> >
> > And previously we are already appending 'acpi_rsdp=' command line only for
> > loading crash kernel on EFI systems, it will be better to try to set the
> > boot param for any kernel get loaded, to help the kernel finding the
> > RSDP value more stably. Otherwise if the user decide to disable EFI
> > service in second kernel, it will fail to boot.
> >
> > There is no better way to find the RSDP address from legacy BIOS
> > interface rather than scanning the memory region and search for it,
> > which will always be done by the kernel as a fallback, so we only
> > look for RSDP in previous boot params, cmdline and EFI firmware.
>
> It would be good to always pass acpi_rsdp= kernel cmdline in case
> efi=old_map.  (or maybe efi=noruntime as well, but I did not remember
> the behavior of noruntime now), no matter kexec or kdump..
>
> And if you want, maybe fill the boot_params instead of passing cmdline
> for new kernel which supports the new boot_param field.
>
> Split the patch to small patches would be better.
>
> Thanks
> Dave

Thanks for the review!

I'll update in V2 accordingly.

-- 
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
