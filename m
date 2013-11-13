Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VgciE-0004Dt-EQ
 for kexec@lists.infradead.org; Wed, 13 Nov 2013 15:50:39 +0000
Date: Wed, 13 Nov 2013 15:50:17 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [patch 3/7 v2] Cleanup efi_enter_virtual_mode function
Message-ID: <20131113155017.GB17248@console-pimps.org>
References: <20131105082007.872550445@dhcp-16-126.nay.redhat.com>
 <20131105082716.825753041@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131105082716.825753041@dhcp-16-126.nay.redhat.com>
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
To: dyoung@redhat.com
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Tue, 05 Nov, at 04:20:10PM, dyoung@redhat.com wrote:
> Add two small functions:
> efi_merge_regions and efi_map_regions, efi_enter_virtual_mode
> calls them instead of embedding two long for loop.
> 
> v1->v2:
> refresh; coding style fixes.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/platform/efi/efi.c |  107 +++++++++++++++++++++++++-------------------
>  1 file changed, 63 insertions(+), 44 deletions(-)

[...]

> @@ -860,17 +840,59 @@ void __init efi_enter_virtual_mode(void)
>  			efi.systab = (efi_system_table_t *) (unsigned long) systab;
>  		}
>  
> -		new_memmap = krealloc(new_memmap,
> -				      (count + 1) * memmap.desc_size,
> -				      GFP_KERNEL);
> -		if (!new_memmap)
> +		*new_memmap = krealloc(*new_memmap,
> +					(*count + 1) * memmap.desc_size,
> +					GFP_KERNEL);
> +		if (!*new_memmap)
>  			goto err_out;
>  
> -		memcpy(new_memmap + (count * memmap.desc_size), md,
> +		memcpy(*new_memmap + (*count * memmap.desc_size), md,
>  		       memmap.desc_size);
> -		count++;
> +		(*count)++;
>  	}
>  
> +err_out:
> +	pr_err("Error reallocating memory, EFI runtime non-functional!\n");
> +}

You should really return an error value here so that we don't
dereference 'new_memmap' below if it's NULL. In fact, just return the
memmap...

> +
> +	efi_merge_regions();
> +
> +	efi_map_regions(&new_memmap, &count);
> +

and make sure to check the return value here.

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
