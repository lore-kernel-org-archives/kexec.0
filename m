Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fzha7-0003D0-5f
 for kexec@lists.infradead.org; Tue, 11 Sep 2018 12:15:49 +0000
Date: Tue, 11 Sep 2018 14:15:32 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] multiboot-x86: pass ACPI reserved memory information in
 memory map
Message-ID: <20180911121531.5argv7ds64lli5i2@verge.net.au>
References: <A32C87822A7FA21BB228259A89E0F4D8@felloff.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <A32C87822A7FA21BB228259A89E0F4D8@felloff.net>
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
To: cinap_lenrek@felloff.net
Cc: kexec@lists.infradead.org

On Thu, Aug 02, 2018 at 04:05:02PM +0200, cinap_lenrek@felloff.net wrote:
> Use the appropriate types for ACPI reclaim and ACPI NVS
> ranges in the multiboot memory map.
> 
> This allows the kernel to locate ACPI tables on UEFI
> systems without having a explicit pointer to the RSD.
> 
> Signed-off-by: Friedemann Gerold <cinap_lenrek@felloff.net>

This seems reasonable to me, but I would value a third-party review
of this change.

Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
> diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
> index 69027e2..afa0959 100644
> --- a/kexec/arch/i386/kexec-multiboot-x86.c
> +++ b/kexec/arch/i386/kexec-multiboot-x86.c
> @@ -259,7 +286,8 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  		mmap[i].base_addr_high  = range[i].start >> 32;
>  		mmap[i].length_low     = length & 0xffffffff;
>  		mmap[i].length_high    = length >> 32;
> -		if (range[i].type == RANGE_RAM) {
> +		switch (range[i].type) {
> +		case RANGE_RAM:
>  			mmap[i].Type = 1; /* RAM */
>  			/*
>                           * Is this the "low" memory?  Can't just test
> @@ -277,7 +305,15 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  			if ((range[i].start <= 0x100000)
>  			    && (range[i].end > mem_upper + 0x100000))
>  				mem_upper = range[i].end - 0x100000;
> -		} else {
> +			break;
> +		case RANGE_ACPI:
> +			mmap[i].Type = 3;
> +			break;
> +		case RANGE_ACPI_NVS:
> +			mmap[i].Type = 4;
> +			break;
> +		case RANGE_RESERVED:
> +		default:
>  			mmap[i].Type = 2;  /* Not RAM (reserved) */
>  		}
>  	}
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
