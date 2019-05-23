Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hTdzR-0005JV-Tk
 for kexec@lists.infradead.org; Thu, 23 May 2019 03:01:59 +0000
Date: Thu, 23 May 2019 11:01:44 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 1/4] x86: Update boot parameters defination
Message-ID: <20190523030144.GA8174@dhcp-128-65.nay.redhat.com>
References: <20190514050959.21093-1-kasong@redhat.com>
 <20190514050959.21093-2-kasong@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190514050959.21093-2-kasong@redhat.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>

Hi Kairui
On 05/14/19 at 01:09pm, Kairui Song wrote:
> Since kernel commit e6e094e053af75 ("x86/acpi, x86/boot: Take RSDP address
> from boot params if available"), kernel accept a acpi_rsdp_addr param in
> boot_params. Sync the x86_linux_param_header to support this param.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  include/x86/x86-linux.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
> index 352ea02..a5d8df8 100644
> --- a/include/x86/x86-linux.h
> +++ b/include/x86/x86-linux.h
> @@ -45,8 +45,7 @@ struct apm_bios_info {
>  	uint16_t cseg_len;	/* 0x4e */
>  	uint16_t cseg_16_len;	/* 0x50 */
>  	uint16_t dseg_len;	/* 0x52 */
> -	uint8_t  reserved[44];	/* 0x54 */
> -};
> +} __attribute__((packed));

It should be good to keep same as the kernel header without packed
attribute.

is it possible to sync the latest mainline uapi bootparam header file,
maybe after this series get solved?

>  
>  /*
>   * EDD stuff
> @@ -113,12 +112,15 @@ struct x86_linux_param_header {
>  	uint8_t  reserved4[2];			/* 0x3e -- 0x3f reserved for future expansion */
>  
>  	struct apm_bios_info apm_bios_info;	/* 0x40 */
> +	uint8_t  reserved4_1[28];		/* 0x54 */
> +	uint64_t acpi_rsdp_addr;		/* 0x70 */
> +	uint8_t  reserved4_2[8];		/* 0x78 */
>  	struct drive_info_struct drive_info;	/* 0x80 */
>  	struct sys_desc_table sys_desc_table;	/* 0xa0 */
>  	uint32_t ext_ramdisk_image;		/* 0xc0 */
>  	uint32_t ext_ramdisk_size;		/* 0xc4 */
>  	uint32_t ext_cmd_line_ptr;		/* 0xc8 */
> -	uint8_t reserved4_1[0x1c0 - 0xcc];	/* 0xe4 */
> +	uint8_t reserved4_3[0x1c0 - 0xcc];	/* 0xe4 */
>  	uint8_t efi_info[32];			/* 0x1c0 */
>  	uint32_t alt_mem_k;			/* 0x1e0 */
>  	uint8_t  reserved5[4];			/* 0x1e4 */
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
