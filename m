Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vu4TG-0003TZ-07
 for kexec@lists.infradead.org; Fri, 20 Dec 2013 18:06:46 +0000
Message-ID: <1387562470.21140.57.camel@misato.fc.hp.com>
Subject: Re: [PATCH v7 00/12] kexec kernel efi runtime support
From: Toshi Kani <toshi.kani@hp.com>
Date: Fri, 20 Dec 2013 11:01:10 -0700
In-Reply-To: <1387533742-18018-1-git-send-email-dyoung@redhat.com>
References: <1387533742-18018-1-git-send-email-dyoung@redhat.com>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, msalter@redhat.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, leif.lindholm@linaro.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, mingo@kernel.org, vgoyal@redhat.com

On Fri, 2013-12-20 at 18:02 +0800, Dave Young wrote:
> Here is the V7 patchset for supporting kexec kernel efi runtime.
> Per pervious discussion I pass the 1st kernel efi runtime mapping
> via setup_data to 2nd kernel. Besides of the runtime mapping
> info I also pass the fw_vendor, runtime, config table, smbios
> physical address in setup_data. EFI spec mentioned fw_vendor,
> runtime, config table addresses will be converted to virt address
> after entering virtual mode, but we will use it as physical address
> in efi_init. For smbios EFI spec did not mention about the address
> updating, but during my test on a HP workstation, the bios will
> convert it to Virt addr, thus pass it in setup_data as well.
> 
> For fw_vendor, runtime, config table, I export them in /sys/firmware/
> efi/, smbios is already in /sys/firmware/efi/systab.
> 
> For efi runtime mapping I add a new directory /sys/firmware/efi/
> runtime-map/ like below
> [dave@darkstar ~]$ tree /sys/firmware/efi/runtime-map/
> /sys/firmware/efi/runtime-map/
> |__ 0
> |   |__ attribute
> |   |__ num_pages
> |   |__ phys_addr
> |   |__ type
> |   |__ virt_addr
> |__ 1
> [snip]
> 
> kexec-tools will assemble them as setup_data and pass to 2nd kernel.
> I will send userspace patches as well.
> 
> Limitation is I only write support for x86_64, test on below machines:
> Lenovo thinkpad t420
> Dell inspiron 14 - 3421
> HP Z420 workstation
> Qemu + OVMF

Tested on an HP 60-way UEFI platform (proto).  For the series:

Tested-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
