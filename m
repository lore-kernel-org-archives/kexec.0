Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WT38s-0004SO-7J
 for kexec@lists.infradead.org; Thu, 27 Mar 2014 05:46:19 +0000
Date: Thu, 27 Mar 2014 13:47:15 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: PATCH: kexec/i386: fix erroneous memory descriptor message
Message-ID: <20140327054715.GA20847@dhcp-16-126.nay.redhat.com>
References: <5333AEEB.4090100@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5333AEEB.4090100@suse.de>
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
To: Tony Jones <tonyj@suse.de>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 03/26/14 at 09:54pm, Tony Jones wrote:
> On non-EFI systems, efi_info section of boot_params is zero filled resulting 
> in an erroneous message from kexec regarding "efi memory descriptor" version.
> 
> Caused by commit: e1ffc9e9a0769e1f54185003102e9bec428b84e8 "Passing efi related 
> data via setup_data"
> 
> # od -j 448 -N 32 -v -x /sys/kernel/boot_params/data 
> 0000700 0000 0000 0000 0000 0000 0000 0000 0000
> 0000720 0000 0000 0000 0000 0000 0000 0000 0000
> 0000740
> 
> # kexec -l --reuse-cmdline --initrd=/boot/initrd-`uname -r` /boot/vmlinuz-`uname -r`
> efi memory descriptor version 0 is not supported!
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> 
> ---
>  kexec/arch/i386/x86-linux-setup.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -687,17 +687,25 @@ static void setup_efi_info(struct kexec_
>  	ret = get_bootparam(&real_mode->efi_info, offset, 32);
>  	if (ret)
>  		return;
> +	if (((struct efi_info *)real_mode->efi_info)->efi_memmap_size == 0)
> +		/* zero filled efi_info */
> +		goto out;
>  	desc_version = get_efi_mem_desc_version(real_mode);
>  	if (desc_version != 1) {
>  		fprintf(stderr,
>  			"efi memory descriptor version %d is not supported!\n",
>  			desc_version);
> -		memset(&real_mode->efi_info, 0, 32);
> -		return;
> +		goto out;
>  	}
>  	ret = setup_efi_data(info, real_mode);
>  	if (ret)
> -		memset(&real_mode->efi_info, 0, 32);
> +		goto out;
> +
> +	return;
> +
> +out:
> +	memset(&real_mode->efi_info, 0, 32);
> +	return;
>  }
>  
>  void setup_linux_system_parameters(struct kexec_info *info,

Good catch, thanks.

Acked-by: Dave Young <dyoung@redhat.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
