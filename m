Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU9EG-0000bO-9g
 for kexec@lists.infradead.org; Tue, 04 Dec 2018 11:51:06 +0000
Date: Tue, 4 Dec 2018 19:50:43 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86: Handle 64bit framebuffer memory address properly
Message-ID: <20181204115009.GA13362@dhcp-128-65.nay.redhat.com>
References: <20181123092633.16111-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181123092633.16111-1-kasong@redhat.com>
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
Cc: horms@verge.net.au, kexec@lists.infradead.org

Hi Kairui,

On 11/23/18 at 05:26pm, Kairui Song wrote:
> In a EFI system, the frame buffer address is 64bit, so currently
> if the address is beyound 4G, kexec will set wrong address due to
> truncate.
> 
> Linux kernel commit ae2ee627dc87 ('efifb: Add support for 64-bit
> frame buffer addresses') added support for 64bit frame buffer
> address, an 'ext_lfb_base' field is added as the upper 32-bits of
> the frame buffer, and introduced a new capability flag
> 'VIDEO_TYPE_CAPABILITY_64BIT_BASE' to indicate if the extend field is
> used.
> 
> This patch adopts this change, set proper extent address and capability
> flag when the address is beyound 4G.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  include/x86/x86-linux.h           | 7 +++++--
>  kexec/arch/i386/x86-linux-setup.c | 7 ++++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
> index 7834751..352ea02 100644
> --- a/include/x86/x86-linux.h
> +++ b/include/x86/x86-linux.h
> @@ -107,7 +107,10 @@ struct x86_linux_param_header {
>  	uint16_t vesapm_seg;			/* 0x2e */
>  	uint16_t vesapm_off;			/* 0x30 */
>  	uint16_t pages;				/* 0x32 */
> -	uint8_t  reserved4[12];			/* 0x34 -- 0x3f reserved for future expansion */
> +	uint16_t vesa_attributes;		/* 0x34 */
> +	uint32_t capabilities;			/* 0x36 */
> +	uint32_t ext_lfb_base;			/* 0x3a */
> +	uint8_t  reserved4[2];			/* 0x3e -- 0x3f reserved for future expansion */
>  
>  	struct apm_bios_info apm_bios_info;	/* 0x40 */
>  	struct drive_info_struct drive_info;	/* 0x80 */
> @@ -199,7 +202,7 @@ struct x86_linux_param_header {
>  	struct 	edd_info eddbuf[EDDMAXNR];	/* 0xd00 */
>  						/* 0xeec */
>  #define COMMAND_LINE_SIZE 2048
> -};
> +} __attribute__((packed));
>  
>  struct x86_linux_faked_param_header {
>  	struct x86_linux_param_header hdr;	/* 0x00 */
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index 6cda12c..dc785a2 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -158,10 +158,15 @@ static int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
>  	real_mode->lfb_width      = var.xres;
>  	real_mode->lfb_height     = var.yres;
>  	real_mode->lfb_depth      = var.bits_per_pixel;
> -	real_mode->lfb_base       = fix.smem_start;
> +	real_mode->lfb_base       = fix.smem_start & 0xffffffff;
>  	real_mode->lfb_linelength = fix.line_length;
>  	real_mode->vesapm_seg     = 0;
>  
> +	if (fix.smem_start > 0xffffffff) {

This might be a problem for 32 bit case?  Other than this I do not see
other issues of this patch.

> +		real_mode->ext_lfb_base = fix.smem_start >> 32;
> +		real_mode->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
> +	}
> +
>  	/* FIXME: better get size from the file returned by proc_iomem() */
>  	real_mode->lfb_size       = (fix.smem_len + 65535) / 65536;
>  	real_mode->pages          = (fix.smem_len + 4095) / 4096;
> -- 
> 2.19.1
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
