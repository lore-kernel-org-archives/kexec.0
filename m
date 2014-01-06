Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W0IIC-0006N5-DE
 for kexec@lists.infradead.org; Mon, 06 Jan 2014 22:05:06 +0000
Message-ID: <1389045513.1792.0.camel@misato.fc.hp.com>
Subject: Re: [PATCH v4 4/4 update] Passing efi related data via setup_data
From: Toshi Kani <toshi.kani@hp.com>
Date: Mon, 06 Jan 2014 14:58:33 -0700
In-Reply-To: <20131230071656.GB3827@dhcp-16-126.nay.redhat.com>
References: <1387533947-18210-1-git-send-email-dyoung@redhat.com>
 <1387533947-18210-5-git-send-email-dyoung@redhat.com>
 <20131230071656.GB3827@dhcp-16-126.nay.redhat.com>
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

On Mon, 2013-12-30 at 15:16 +0800, Dave Young wrote:
> For supporting efi runtime, several efi physical addresses
> fw_vendor, runtime, config tables, smbios and the whole runtime
> mapping info need to be used in kexec kernel. Thus introduce
> setup_data struct for passing these data.
> 
> collect the varialbes from /sys/firmware/efi/systab and
> /sys/firmware/efi/runtime-map
> 
> Tested on qemu+ovmf, dell laptop, lenovo laptop and HP workstation.
> 
> v1->v2:
> HPA: use uint*_t instead of __uint*_t
> Simon: indention fix; fix a memory leak
> move offset change update to previous patch in setup header
> only passing setup_data when the bzImage support efi boot
> Vivek: export a value in bzImage probe so it can be used
>       to check if we should pass acpi_rsdp.
> coding style
> 
> v2->v3:
> code cleanup
> bail out if efi mm desc_version != 1
> bhe: define macro for SETUP_EFI
>      break loop if find matched string in systab.
> 
> v3->v4:
> update memmap in efi_info to the saved runtime map
> So kernel side can iterate them as normal boot.
> 
> v4->v5:
> simplify function get_efi_value(), add error handling
> realloc error handling
> move map[0] out of efi_setup_data since memmap addr is set in efi_info
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Tested-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
Toshi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
