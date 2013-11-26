Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlL1R-0007jg-7T
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 15:57:57 +0000
Date: Tue, 26 Nov 2013 15:57:31 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH v4 05/12] efi: export more efi table variable to sysfs
Message-ID: <20131126155731.GM11521@console-pimps.org>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-6-git-send-email-dyoung@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385445477-9665-6-git-send-email-dyoung@redhat.com>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Tue, 26 Nov, at 01:57:50PM, Dave Young wrote:
> Export fw_vendor, runtime and config tables physical
> addresses to /sys/firmware/efi/systab becaue kexec
> kernel will need them.
 
This commit log needs updating.

> From EFI spec these 3 variables will be updated to
> virtual address after entering virtual mode. But
> kernel startup code will need the physical address.
> 
> changelog:
> Greg: add standalone sysfs files instead of add lines to systab
> Document them as testing ABI
> Greg: use group attrs and is_visible
> Boris: align comments lines
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  Documentation/ABI/testing/sysfs-firmware-efi | 26 ++++++++++++++++
>  arch/x86/platform/efi/efi.c                  |  4 +++
>  drivers/firmware/efi/efi.c                   | 44 ++++++++++++++++++++++++++++
>  include/linux/efi.h                          |  3 ++
>  4 files changed, 77 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-efi
> 
> diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation/ABI/testing/sysfs-firmware-efi
> new file mode 100644
> index 0000000..9252a24
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-firmware-efi
> @@ -0,0 +1,26 @@
> +What:		/sys/firmware/efi/fw_vendor
> +Date:		Nov 2013
> +Contact:	Dave Young <dyoung@redhat.org>

redhat.org eh? Typo or legit?

> +Description:
> +		Shows the physical address of firmware vendor in the EFI
> +		system table.

It shows the physical address of the firmware vendor "entry" or "field"
in the EFI system table.

> +Users:
> +		Kexec Mailing List <kexec@lists.infradead.org>

The "Kexec mailing list" isn't a user, kexec is.

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
