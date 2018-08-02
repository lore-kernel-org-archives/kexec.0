Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1flAdC-0004lm-Aa
 for kexec@lists.infradead.org; Thu, 02 Aug 2018 10:14:56 +0000
Date: Thu, 2 Aug 2018 12:14:36 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: multiboot non-elf and framebuffer support for kexec-tools
Message-ID: <20180802101436.szbbghu4vlrifhsl@verge.net.au>
References: <34EA379E6200FBA190C21A4D9996C7AB@felloff.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34EA379E6200FBA190C21A4D9996C7AB@felloff.net>
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

Hi,

On Sat, Jul 28, 2018 at 06:18:11PM +0200, cinap_lenrek@felloff.net wrote:
> theres a patch that provides support for non-elf multiboot kernels
> and passes framebuffer information to the kernel if requested in
> the multiboot header.
> 
> only rgb truecolor framebuffers are supported right now. if --reset-vga
> or --console-vga was specified, it assumes the framebuffer will be
> standard ega text mode.
> 
> also pass acpi nvs and acpi reclaim ranges in the multiboot memory
> map as such; instead of just reserved. this allowing to kernel to
> locate acpi tables on uefi systems.
> 
> i'm new on the list, so is there a prefered address to send patches
> like this to?

kexec@lists.infradead.org is the right list to send kexec-tools patches.

Patches need a changelog which includes a Signed-off-by line,
like used with the Linux kernel, in order to be accepted.

> diff --git a/include/x86/mb_info.h b/include/x86/mb_info.h
> index 317bdfa..fd1bb1d 100644
> --- a/include/x86/mb_info.h
> +++ b/include/x86/mb_info.h
> @@ -172,6 +172,28 @@ struct multiboot_info
>  	uint16_t vbe_interface_seg;
>  	uint16_t vbe_interface_off;
>  	uint16_t vbe_interface_len;
> +
> +	uint64_t framebuffer_addr;
> +	uint32_t framebuffer_pitch;
> +	uint32_t framebuffer_width;
> +	uint32_t framebuffer_height;
> +	uint8_t  framebuffer_bpp;
> +	uint8_t	 framebuffer_type;
> +
> +	union {
> +		struct {
> +			uint32_t	framebuffer_palette_addr;
> +			uint16_t	framebuffer_palette_num_color;
> +		};
> +		struct {
> +			uint8_t		framebuffer_red_field_position;
> +			uint8_t		framebuffer_red_mask_size;
> +			uint8_t		framebuffer_green_field_position;
> +			uint8_t		framebuffer_green_mask_size;
> +			uint8_t		framebuffer_blue_field_position;
> +			uint8_t		framebuffer_blue_mask_size;
> +		};
> +	};
>  };
>  
>  /*
> @@ -211,6 +233,11 @@ struct multiboot_info
>  
>  /* Is there video information?  */
>  #define MB_INFO_VIDEO_INFO		0x00000800
> +#define MB_INFO_FRAMEBUFFER_INFO	0x00001000
> +
> +#define MB_FRAMEBUFFER_TYPE_INDEXED	0
> +#define MB_FRAMEBUFFER_TYPE_RGB		1
> +#define MB_FRAMEBUFFER_TYPE_EGA_TEXT	2
>  
>  /*
>   *  The following value must be present in the EAX register.
> diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
> index 69027e2..9bba4c1 100644
> --- a/kexec/arch/i386/kexec-multiboot-x86.c
> +++ b/kexec/arch/i386/kexec-multiboot-x86.c
> @@ -7,9 +7,6 @@
>   * 
>   *  TODO:  
>   *    - smarter allocation of new segments
> - *    - proper support for the MULTIBOOT_VIDEO_MODE bit
> - *    - support for the MULTIBOOT_AOUT_KLUDGE bit
> - *
>   *
>   *  Copyright (C) 2003  Tim Deegan (tjd21 at cl.cam.ac.uk)
>   * 
> @@ -56,21 +53,23 @@
>  #include <x86/mb_header.h>
>  #include <x86/mb_info.h>
>  
> +/* Framebuffer */
> +#include <sys/ioctl.h>
> +#include <linux/fb.h>
> +
>  /* Static storage */
>  static char headerbuf[MULTIBOOT_SEARCH];
>  static struct multiboot_header *mbh = NULL;
> +static off_t mbh_offset = 0;
>  
> -#define MIN(_x,_y) (((_x)<=(_y))?(_x):(_y))
> +extern struct arch_options_t arch_options;
>  
> +#define MIN(_x,_y) (((_x)<=(_y))?(_x):(_y))
>  
>  int multiboot_x86_probe(const char *buf, off_t buf_len)
>  /* Is it a good idea to try booting this file? */
>  {
>  	int i, len;
> -	/* First of all, check that this is an ELF file */
> -	if ((i=elf_x86_probe(buf, buf_len)) < 0) {
> -		return i;
> -	}

I'm a little confused about how we can parse the file if we don't know its
type. Perhaps rather than removing this check it should be an x || y check?

>  	/* Now look for a multiboot header in the first 8KB */
>  	len = MULTIBOOT_SEARCH;
>  	if (len > buf_len) {
> @@ -81,10 +80,10 @@ int multiboot_x86_probe(const char *buf, off_t buf_len)
>  		/* Short file */
>  		return -1;
>  	}
> -	for (i = 0; i <= (len - 12); i += 4)
> +	for (mbh_offset = 0; mbh_offset <= (len - 12); mbh_offset += 4)
>  	{
>  		/* Search for a multiboot header */
> -		mbh = (struct multiboot_header *)(headerbuf + i);
> +		mbh = (struct multiboot_header *)(headerbuf + mbh_offset);
>  		if (mbh->magic != MULTIBOOT_MAGIC 
>  		    || ((mbh->magic+mbh->flags+mbh->checksum) & 0xffffffff))
>  		{
> @@ -92,13 +91,34 @@ int multiboot_x86_probe(const char *buf, off_t buf_len)
>  			continue;
>  		}
>  		if (mbh->flags & MULTIBOOT_AOUT_KLUDGE) {
> -			/* Requires options we don't support */
> -			fprintf(stderr, 
> -				"Found a multiboot header, but it uses "
> -				"a non-ELF header layout,\n"
> -				"and I can't do that (yet).  Sorry.\n");
> -			return -1;
> -		} 
> +			if (mbh->load_addr & 0xfff) {
> +				fprintf(stderr, "multiboot load address not 4k aligned\n");
> +				return -1;
> +			}
> +			if (mbh->load_addr > mbh->header_addr) {
> +				fprintf(stderr, "multiboot header address > load address\n");
> +				return -1;
> +			}
> +			if (mbh->load_end_addr < mbh->load_addr) {
> +				fprintf(stderr, "multiboot load end address < load address\n");
> +				return -1;
> +			}
> +			if (mbh->bss_end_addr < mbh->load_end_addr) {
> +				fprintf(stderr, "multiboot bss end address < load end address\n");
> +				return -1;
> +			}
> +			if (mbh->load_end_addr - mbh->header_addr > buf_len - mbh_offset) {
> +				fprintf(stderr, "multiboot file truncated\n");
> +				return -1;
> +			}
> +			if (mbh->entry_addr < mbh->load_addr || mbh->entry_addr >= mbh->load_end_addr) {
> +				fprintf(stderr, "multiboot entry out of range\n");
> +				return -1;
> +			}
> +		} else {
> +			if ((i=elf_x86_probe(buf, buf_len)) < 0)
> +				return i;
> +		}
>  		if (mbh->flags & MULTIBOOT_UNSUPPORTED) {
>  			/* Requires options we don't support */
>  			fprintf(stderr, 
> @@ -107,16 +127,6 @@ int multiboot_x86_probe(const char *buf, off_t buf_len)
>  				"don't understand.  Sorry.\n");
>  			return -1;
>  		} 
> -		if (mbh->flags & MULTIBOOT_VIDEO_MODE) { 
> -			/* Asked for screen mode information */
> -			/* XXX carry on regardless */
> -			fprintf(stderr, 
> -				"BEWARE!  Found a multiboot header which asks "
> -				"for screen mode information.\n"
> -				"BEWARE!  I am NOT supplying screen mode "
> -                                "information, but loading it regardless.\n");
> -			
> -		}
>  		/* Bootable */
>  		return 0;
>  	}
> @@ -134,6 +144,75 @@ void multiboot_x86_usage(void)
>  	printf("                                 (can be used multiple times).\n");
>  }
>  
> +static int framebuffer_info(struct multiboot_info *mbi)
> +{
> +	struct fb_fix_screeninfo info;
> +	struct fb_var_screeninfo mode;
> +	int fd;
> +
> +	/* check if purgatory will reset to standard ega text mode */
> +	if (arch_options.reset_vga || arch_options.console_vga) {
> +		mbi->framebuffer_type = MB_FRAMEBUFFER_TYPE_EGA_TEXT;
> +		mbi->framebuffer_addr = 0xb8000;
> +		mbi->framebuffer_pitch = 80*2;
> +		mbi->framebuffer_width = 80;
> +		mbi->framebuffer_height = 25;
> +		mbi->framebuffer_bpp = 16;
> +
> +		mbi->flags |= MB_INFO_FRAMEBUFFER_INFO;
> +		return 0;
> +	}
> +
> +	/* use current graphics framebuffer settings */
> +	fd = open("/dev/fb0", O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "can't open /dev/fb0: %s\n", strerror(errno));
> +		return -1;
> +	}
> +	if (ioctl(fd, FBIOGET_FSCREENINFO, &info) < 0){
> +		fprintf(stderr, "can't get screeninfo: %s\n", strerror(errno));
> +		close(fd);
> +		return -1;
> +	}
> +	if (ioctl(fd, FBIOGET_VSCREENINFO, &mode) < 0){
> +		fprintf(stderr, "can't get modeinfo: %s\n", strerror(errno));
> +		close(fd);
> +		return -1;
> +	}
> +	close(fd);
> +
> +	if (info.smem_start == 0 || info.smem_len == 0) {
> +		fprintf(stderr, "can't get linerar framebuffer address\n");
> +		return -1;
> +	}
> +
> +	if (info.type != FB_TYPE_PACKED_PIXELS) {
> +		fprintf(stderr, "unsupported framebuffer type\n");
> +		return -1;
> +	}
> +
> +	if (info.visual != FB_VISUAL_TRUECOLOR) {
> +		fprintf(stderr, "unsupported framebuffer visual\n");
> +		return -1;
> +	}
> +
> +	mbi->framebuffer_type = MB_FRAMEBUFFER_TYPE_RGB;
> +	mbi->framebuffer_addr = info.smem_start;
> +	mbi->framebuffer_pitch = info.line_length;
> +	mbi->framebuffer_width = mode.xres;
> +	mbi->framebuffer_height = mode.yres;
> +	mbi->framebuffer_bpp = mode.bits_per_pixel;
> +	mbi->framebuffer_red_field_position = mode.red.offset;
> +	mbi->framebuffer_red_mask_size = mode.red.length;
> +	mbi->framebuffer_green_field_position = mode.green.offset;
> +	mbi->framebuffer_green_mask_size = mode.green.length;
> +	mbi->framebuffer_blue_field_position = mode.blue.offset;
> +	mbi->framebuffer_blue_mask_size = mode.blue.length;
> +
> +	mbi->flags |= MB_INFO_FRAMEBUFFER_INFO;
> +	return 0;
> +}
> +
>  int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  	struct kexec_info *info)
>  /* Marshal up a multiboot-style kernel */
> @@ -154,7 +233,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  	struct AddrRangeDesc *mmap;
>  	int command_line_len;
>  	int i, result;
> -	uint32_t u;
> +	uint32_t u, entry;
>  	int opt;
>  	int modules, mod_command_line_space;
>  	/* See options.h -- add any more there, too. */
> @@ -211,8 +290,18 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  	}
>  	command_line_len = strlen(command_line) + 1;
>  	
> -	/* Load the ELF executable */
> -	elf_exec_build_load(info, &ehdr, buf, len, 0);
> +	if (mbh->flags & MULTIBOOT_AOUT_KLUDGE) {
> +		add_segment(info,
> +			buf + (mbh_offset - (mbh->header_addr - mbh->load_addr)),
> +			mbh->load_end_addr - mbh->load_addr,
> +			mbh->load_addr,
> +			mbh->bss_end_addr - mbh->load_addr);
> +		entry = mbh->entry_addr;
> +	} else {
> +		/* Load the ELF executable */
> +		elf_exec_build_load(info, &ehdr, buf, len, 0);
> +		entry = ehdr.e_entry;
> +	}
>  
>  	/* Load the setup code */
>  	elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size, 0,
> @@ -259,7 +348,8 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  		mmap[i].base_addr_high  = range[i].start >> 32;
>  		mmap[i].length_low     = length & 0xffffffff;
>  		mmap[i].length_high    = length >> 32;
> -		if (range[i].type == RANGE_RAM) {
> +		switch (range[i].type) {
> +		case RANGE_RAM:
>  			mmap[i].Type = 1; /* RAM */
>  			/*
>                           * Is this the "low" memory?  Can't just test
> @@ -277,7 +367,15 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
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
> @@ -302,6 +400,12 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  		/* done */
>  	}
>  
> +	/* Video */
> +	if (mbh->flags & MULTIBOOT_VIDEO_MODE) {
> +		if (framebuffer_info(mbi) < 0)
> +			fprintf(stderr, "not providing framebuffer information.\n");
> +	}
> +
>  	/* Load modules */
>  	if (modules) {
>  		char *mod_filename, *mod_command_line, *mod_clp, *buf;
> @@ -384,7 +488,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  	elf_rel_get_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
>  	regs.eax = 0x2BADB002;
>  	regs.ebx = mbi_offset;
> -	regs.eip = ehdr.e_entry;
> +	regs.eip = entry;
>  	elf_rel_set_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
>  
>  out:


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
