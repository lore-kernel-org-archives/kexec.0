Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vu4QV-0003PH-DF
 for kexec@lists.infradead.org; Fri, 20 Dec 2013 18:03:56 +0000
Message-ID: <1387562293.21140.55.camel@misato.fc.hp.com>
Subject: Re: [PATCH v4 0/4] kexec-tools: efi runtime support on kexec kernel
From: Toshi Kani <toshi.kani@hp.com>
Date: Fri, 20 Dec 2013 10:58:13 -0700
In-Reply-To: <1387533947-18210-1-git-send-email-dyoung@redhat.com>
References: <1387533947-18210-1-git-send-email-dyoung@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Fri, 2013-12-20 at 18:05 +0800, Dave Young wrote:
> This patchset is for adding efi runtime support on kexec kernel
> kernel patches see below thread:
> http://thread.gmane.org/gmane.linux.kernel.efi/2491
> 
> in kexec-tools, this patchset will do below:
> 1. retrieve efi_info from debugfs boot_params, and fill the
> x86 setup header
> 
> 2. collect data efi runtime needed:
> /sys/firmware/efi/systab: fw_vendor, runtime, config_tables and smbios
> /sys/firmware/efi/efi-runtime-map/*, the phys-virt mappings in 1st kernel
> 
> 3. assemble setup_data based on data get in 2) then pass it to 2nd kernel
> 
> changelog v3->v4:
> update efi_info memmap to the saved runtime map instead of use 1st kernel
> untouched memmap.
> 
> Tested on OVMF, dell laptop, lenovo laptop and HP workstation
> 
> Dave Young (4):
>   build fix: include x86-linux.h in x86-linux-setup.h
>   Add function get_bootparam
>   Add efi_info in x86 setup header
>   Passing efi related data via setup_data
> 
>  include/x86/x86-linux.h             |   3 +-
>  kexec/arch/i386/crashdump-x86.c     |   4 +-
>  kexec/arch/i386/x86-linux-setup.c   | 246 ++++++++++++++++++++++++++++++++++--
>  kexec/arch/i386/x86-linux-setup.h   |   2 +
>  kexec/arch/x86_64/kexec-bzImage64.c |   6 +
>  5 files changed, 248 insertions(+), 13 deletions(-)
> 

Tested on an HP 60-way UEFI platform.  For the series:

Tested-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
