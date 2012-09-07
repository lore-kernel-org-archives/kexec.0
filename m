Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T9zgP-0003zH-Oa
 for kexec@lists.infradead.org; Fri, 07 Sep 2012 14:37:22 +0000
Subject: Re: [PATCH]kdump: pass noefi and acpi_rsdp= to 2nd kernel
From: Khalid Aziz <khalid.aziz@hp.com>
In-Reply-To: <5049B6AD.9000304@redhat.com>
References: <20120905054445.GA6370@dhcp-16-143.nay.redhat.com>
 <5047DBA9.8030000@hp.com> <504815EB.9000701@redhat.com>
 <5048E40E.7040003@hp.com>  <5049B6AD.9000304@redhat.com>
Date: Fri, 07 Sep 2012 08:37:14 -0600
Message-ID: <1347028634.20255.79.camel@lyra>
Mime-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org, vgoyal@redhat.com

On Fri, 2012-09-07 at 16:56 +0800, Dave Young wrote:
> Actually in x86 setup code if bootloader do not pass correct efi_info in
> boot_params efi_enabled will be set to 0 automaticlly.
> 

When we kexec a kernel, the EFI signature is missing in the bootloader
signature in boot_params, so kexec'd kernels currently disable EFI
automatically even without noefi in this code:

arch/x86/kernel/setup.c:

733         if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
734                      "EL32", 4)) {
735                 efi_enabled = 1;
736                 efi_64bit = false;
737         } else if (!strncmp((char *)&boot_params.efi_info.efi_loader_signatu     re,             
738                      "EL64", 4)) {
739                 efi_enabled = 1;
740                 efi_64bit = true;
741         }

efi_enabled is initialized to 0.

-- 
Khalid Aziz <khalid.aziz@hp.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
