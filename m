Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TC9dc-0002ri-Vp
 for kexec@lists.infradead.org; Thu, 13 Sep 2012 13:39:26 +0000
Date: Thu, 13 Sep 2012 09:38:27 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH]kdump: pass noefi and acpi_rsdp= to 2nd kernel
Message-ID: <20120913133827.GB4396@redhat.com>
References: <20120905054445.GA6370@dhcp-16-143.nay.redhat.com>
 <5047DBA9.8030000@hp.com> <504815EB.9000701@redhat.com>
 <5048E40E.7040003@hp.com> <5049B6AD.9000304@redhat.com>
 <1347028634.20255.79.camel@lyra>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1347028634.20255.79.camel@lyra>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Khalid Aziz <khalid.aziz@hp.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, Dave Young <dyoung@redhat.com>

On Fri, Sep 07, 2012 at 08:37:14AM -0600, Khalid Aziz wrote:
> On Fri, 2012-09-07 at 16:56 +0800, Dave Young wrote:
> > Actually in x86 setup code if bootloader do not pass correct efi_info in
> > boot_params efi_enabled will be set to 0 automaticlly.
> > 
> 
> When we kexec a kernel, the EFI signature is missing in the bootloader
> signature in boot_params, so kexec'd kernels currently disable EFI
> automatically even without noefi in this code:
> 
> arch/x86/kernel/setup.c:
> 
> 733         if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
> 734                      "EL32", 4)) {
> 735                 efi_enabled = 1;
> 736                 efi_64bit = false;
> 737         } else if (!strncmp((char *)&boot_params.efi_info.efi_loader_signatu     re,             
> 738                      "EL64", 4)) {
> 739                 efi_enabled = 1;
> 740                 efi_64bit = true;
> 741         }
> 
> efi_enabled is initialized to 0.

Hi Khalid,

So what does this mean? Second kernel assumes the regular BIOS and tries
to initialize that way? That sounds broken or is it just fine given
the fact we are anyway not planning to call into any of the efi services.
But what about memory maps, ACPI tables etc.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
