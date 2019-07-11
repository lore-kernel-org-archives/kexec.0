Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1hlW0S-0004Hb-13
 for kexec@lists.infradead.org; Thu, 11 Jul 2019 10:08:54 +0000
Date: Thu, 11 Jul 2019 12:08:48 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/4] kexec/arm64: Add support for handling zlib
 compressed (Image.gz) image
Message-ID: <20190711100847.im3zph37uqctvrwl@verge.net.au>
References: <1562788469-22935-1-git-send-email-bhsharma@redhat.com>
 <1562788469-22935-5-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1562788469-22935-5-git-send-email-bhsharma@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: takahiro.akashi@linaro.org, bhupesh.linux@gmail.com, kexec@lists.infradead.org

On Thu, Jul 11, 2019 at 01:24:29AM +0530, Bhupesh Sharma wrote:
> Currently the kexec_file_load() support for arm64 doesn't allow
> handling zlib compressed (i.e. Image.gz) image.
> 
> Since most distributions use 'make zinstall' rule inside
> 'arch/arm64/boot/Makefile' to install the arm64
> Image.gz compressed file inside the boot destination directory (for e.g.
> /boot), currently we cannot use kexec_file_load() to load vmlinuz (or
> Image.gz):
> 
>  # file /boot/vmlinuz
>    /boot/vmlinuz: gzip compressed data, was "Image", <..snip..>, max
>    compression, from Unix, original size 21945120
> 
>  Now, since via kexec_file_load() we pass the 'fd' of Image.gz
>  (compressed file) via the following command line ...
> 
>  # kexec -s -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname
>    -r`.img --reuse-cmdline
> 
> ... kernel returns -EINVAL error value, as it is not able to locate
> the magic number =0x644d5241, which is expected in the 64-byte header
> of the decompressed kernel image.
> 
> We can fix this in user-space kexec-tools, which handles an
> 'Image.gz' being passed via kexec_file_load(), using an approach
> as follows:
> 
> a). Copy the contents of Image.gz to a temporary file.
> b). Decompress (gunzip-decompress) the contents inside the
>     temporary file.
> c). Pass the 'fd' of the temporary file to the kernel space. So
>     basically the kernel space still gets a decompressed kernel
>     image to load via kexec-tools
> 
> I tested this patch for the following three use-cases:
> 
> 1. Uncompressed Image file:
>  #kexec -s -l Image --initrd=/boot/initramfs-`uname -r`.img --reuse-cmdline
> 
> 2. Signed Image file:
>  #kexec -s -l Image.signed --initrd=/boot/initramfs-`uname -r`.img --reuse-cmdline
> 
> 3. zlib compressed Image.gz file:
>  #kexec -s -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname -r`.img --reuse-cmdline
> 
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  kexec/arch/arm64/Makefile             |   3 +-
>  kexec/arch/arm64/kexec-arm64.c        |   1 +
>  kexec/arch/arm64/kexec-arm64.h        |   7 ++
>  kexec/arch/arm64/kexec-image-arm64.c  |   4 +-
>  kexec/arch/arm64/kexec-zImage-arm64.c | 199 ++++++++++++++++++++++++++++++++++
>  kexec/kexec.c                         |  12 ++
>  6 files changed, 223 insertions(+), 3 deletions(-)
>  create mode 100644 kexec/arch/arm64/kexec-zImage-arm64.c
> 
> diff --git a/kexec/arch/arm64/Makefile b/kexec/arch/arm64/Makefile
> index 9d9111caa8ed..d27c8ee1b5e7 100644
> --- a/kexec/arch/arm64/Makefile
> +++ b/kexec/arch/arm64/Makefile
> @@ -15,7 +15,8 @@ arm64_KEXEC_SRCS += \
>  	kexec/arch/arm64/kexec-arm64.c \
>  	kexec/arch/arm64/kexec-elf-arm64.c \
>  	kexec/arch/arm64/kexec-uImage-arm64.c \
> -	kexec/arch/arm64/kexec-image-arm64.c
> +	kexec/arch/arm64/kexec-image-arm64.c \
> +	kexec/arch/arm64/kexec-zImage-arm64.c
>  
>  arm64_UIMAGE = kexec/kexec-uImage.c
>  
> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> index 2992bce8139f..eb3a3a37307c 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -71,6 +71,7 @@ struct file_type file_type[] = {
>  	{"vmlinux", elf_arm64_probe, elf_arm64_load, elf_arm64_usage},
>  	{"Image", image_arm64_probe, image_arm64_load, image_arm64_usage},
>  	{"uImage", uImage_arm64_probe, uImage_arm64_load, uImage_arm64_usage},
> +	{"zImage", zImage_arm64_probe, zImage_arm64_load, zImage_arm64_usage},
>  };
>  
>  int file_types = sizeof(file_type) / sizeof(file_type[0]);
> diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
> index cc3419f4c10f..628de79b7f70 100644
> --- a/kexec/arch/arm64/kexec-arm64.h
> +++ b/kexec/arch/arm64/kexec-arm64.h
> @@ -38,11 +38,18 @@ int image_arm64_probe(const char *kernel_buf, off_t kernel_size);
>  int image_arm64_load(int argc, char **argv, const char *kernel_buf,
>  	off_t kernel_size, struct kexec_info *info);
>  void image_arm64_usage(void);
> +
>  int uImage_arm64_probe(const char *buf, off_t len);
>  int uImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
>  		      struct kexec_info *info);
>  void uImage_arm64_usage(void);
>  
> +int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size);
> +int zImage_arm64_load(int argc, char **argv, const char *kernel_buf,
> +	off_t kernel_size, struct kexec_info *info);
> +void zImage_arm64_usage(void);
> +
> +
>  off_t initrd_base;
>  off_t initrd_size;
>  
> diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
> index 685a99352e39..aa8f2e22d72b 100644
> --- a/kexec/arch/arm64/kexec-image-arm64.c
> +++ b/kexec/arch/arm64/kexec-image-arm64.c
> @@ -114,6 +114,6 @@ exit:
>  void image_arm64_usage(void)
>  {
>  	printf(
> -"     An ARM64 binary image, compressed or not, big or little endian.\n"
> -"     Typically an Image, Image.gz or Image.lzma file.\n\n");
> +"     An ARM64 binary image, uncompressed, big or little endian.\n"
> +"     Typically an Image file.\n\n");
>  }
> diff --git a/kexec/arch/arm64/kexec-zImage-arm64.c b/kexec/arch/arm64/kexec-zImage-arm64.c
> new file mode 100644
> index 000000000000..2b83ef6bdffd
> --- /dev/null
> +++ b/kexec/arch/arm64/kexec-zImage-arm64.c
> @@ -0,0 +1,199 @@
> +/*
> + * ARM64 kexec zImage (Image.gz) support.
> + *
> + * Several distros use 'make zinstall' rule inside
> + * 'arch/arm64/boot/Makefile' to install the arm64
> + * Image.gz compressed file inside the boot destination
> + * directory (for e.g. /boot).
> + *
> + * Currently we cannot use kexec_file_load() to load vmlinuz
> + * (or Image.gz).
> + *
> + * To support Image.gz, we should:
> + * a). Copy the contents of Image.gz to a temporary file.
> + * b). Decompress (gunzip-decompress) the contents inside the
> + *     temporary file.
> + * c). Pass the 'fd' of the temporary file to the kernel space.
> + *
> + * So basically the kernel space still gets a decompressed
> + * kernel image to load via kexec-tools.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <stdlib.h>
> +#include "crashdump-arm64.h"
> +#include "image-header.h"
> +#include "kexec.h"
> +#include "kexec-arm64.h"
> +#include "kexec-syscall.h"
> +#include "kexec-zlib.h"
> +#include "arch/options.h"
> +
> +#define FILENAME_IMAGE		"/tmp/ImageXXXXXX"
> +
> +/* Returns:
> + * -1 : in case of error/invalid format (not a valid Image.gz format.
> + *  fd: File descriptor of the temp file containing the decompressed
> + *      Image.
> + */
> +int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
> +{
> +	int kernel_fd = 0;
> +	char *fname = NULL;
> +	char *kernel_uncompressed_buf = NULL;
> +	const struct arm64_image_header *h;
> +
> +	if (!is_zlib_file(kernel_buf, &kernel_size)) {
> +		dbgprintf("%s: Not an zImage file (Image.gz).\n", __func__);
> +		return -1;
> +	}
> +
> +	if (!(fname = strdup(FILENAME_IMAGE))) {
> +		dbgprintf("%s: Can't duplicate strings %s\n", __func__,
> +				fname);
> +		return -1;
> +	}
> +
> +	if ((kernel_fd = mkstemp(fname)) < 0) {
> +		dbgprintf("%s: Can't open file %s\n", __func__,
> +				fname);
> +		return -1;
> +	}
> +
> +	kernel_uncompressed_buf =
> +		(char *) calloc(kernel_size, sizeof(off_t));
> +	if (!kernel_uncompressed_buf) {
> +		dbgprintf("%s: Can't calloc %ld bytes\n",
> +				__func__, kernel_size);
> +		return -ENOMEM;
> +	}
> +
> +	/* slurp in the input kernel */
> +	dbgprintf("%s: ", __func__);
> +	kernel_uncompressed_buf = slurp_decompress_file(kernel_buf,
> +							&kernel_size);
> +
> +	/* check for correct header magic */
> +	if (kernel_size < sizeof(struct arm64_image_header)) {
> +		dbgprintf("%s: No arm64 image header.\n", __func__);
> +		return -1;
> +	}
> +
> +	h = (const struct arm64_image_header *)(kernel_uncompressed_buf);
> +
> +	if (!arm64_header_check_magic(h)) {
> +		dbgprintf("%s: Bad arm64 image header.\n", __func__);
> +		return -1;
> +	}
> +
> +	if (write(kernel_fd, kernel_uncompressed_buf,
> +				kernel_size) != kernel_size) {
> +		dbgprintf("%s: Can't write the uncompressed file %s\n",
> +				__func__, fname);
> +		return -1;
> +	}

I think that kernel_fd needs to also be closed in
error cases to avoid a leak.

> +
> +	close(kernel_fd);

What if the contents of the file whose name is fdname is replaced at this
moment?

> +
> +	/* Open the tmp file again, this time in O_RDONLY mode, as
> +	 * opening the file in O_RDWR and calling kexec_file_load()
> +	 * causes the kernel to return -ETXTBSY
> +	 */
> +	kernel_fd = open(fname, O_RDONLY);
> +	if (kernel_fd == -1) {
> +		dbgprintf("%s: Failed to open file %s\n",
> +				__func__, fname);
> +		return -1;
> +	}

I think that fname is leaked here and in error cases.

> +
> +	return kernel_fd;
> +}
> +
> +int zImage_arm64_load(int argc, char **argv, const char *kernel_buf,
> +	off_t kernel_size, struct kexec_info *info)
> +{
> +	const struct arm64_image_header *header;
> +	unsigned long kernel_segment;
> +	int result;
> +
> +	if (info->file_mode) {
> +		if (arm64_opts.initrd) {
> +			info->initrd_fd = open(arm64_opts.initrd, O_RDONLY);
> +			if (info->initrd_fd == -1) {
> +				fprintf(stderr,
> +					"Could not open initrd file %s:%s\n",
> +					arm64_opts.initrd, strerror(errno));
> +				result = EFAILED;
> +				goto exit;
> +			}
> +		}
> +
> +		if (arm64_opts.command_line) {
> +			info->command_line = (char *)arm64_opts.command_line;
> +			info->command_line_len =
> +					strlen(arm64_opts.command_line) + 1;
> +		}
> +
> +		return 0;
> +	}
> +
> +	header = (const struct arm64_image_header *)(kernel_buf);
> +
> +	if (arm64_process_image_header(header))
> +		return EFAILED;
> +
> +	kernel_segment = arm64_locate_kernel_segment(info);
> +
> +	if (kernel_segment == ULONG_MAX) {
> +		dbgprintf("%s: Kernel segment is not allocated\n", __func__);
> +		result = EFAILED;
> +		goto exit;
> +	}
> +
> +	dbgprintf("%s: kernel_segment: %016lx\n", __func__, kernel_segment);
> +	dbgprintf("%s: text_offset:    %016lx\n", __func__,
> +		arm64_mem.text_offset);
> +	dbgprintf("%s: image_size:     %016lx\n", __func__,
> +		arm64_mem.image_size);
> +	dbgprintf("%s: phys_offset:    %016lx\n", __func__,
> +		arm64_mem.phys_offset);
> +	dbgprintf("%s: vp_offset:      %016lx\n", __func__,
> +		arm64_mem.vp_offset);
> +	dbgprintf("%s: PE format:      %s\n", __func__,
> +		(arm64_header_check_pe_sig(header) ? "yes" : "no"));
> +
> +	/* create and initialize elf core header segment */
> +	if (info->kexec_flags & KEXEC_ON_CRASH) {
> +		result = load_crashdump_segments(info);
> +		if (result) {
> +			dbgprintf("%s: Creating eflcorehdr failed.\n",
> +								__func__);
> +			goto exit;
> +		}
> +	}
> +
> +	/* load the kernel */
> +	add_segment_phys_virt(info, kernel_buf, kernel_size,
> +			kernel_segment + arm64_mem.text_offset,
> +			arm64_mem.image_size, 0);
> +
> +	/* load additional data */
> +	result = arm64_load_other_segments(info, kernel_segment
> +		+ arm64_mem.text_offset);
> +
> +exit:
> +	if (result)
> +		fprintf(stderr, "kexec: load failed.\n");
> +	return result;
> +}
> +
> +void zImage_arm64_usage(void)
> +{
> +	printf(
> +"     An ARM64 zImage, compressed, big or little endian.\n"
> +"     Typically an Image.gz or Image.lzma file.\n\n");
> +}
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 8ca3b457cac8..bc6ab3dbd10b 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1206,8 +1206,20 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
>  	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
>  
>  	for (i = 0; i < file_types; i++) {
> +#ifdef __aarch64__
> +		/* handle Image.gz like cases */
> +		if (is_zlib_file(kernel, &kernel_size)) {
> +			if ((ret = file_type[i].probe(kernel, kernel_size)) >= 0) {
> +				kernel_fd = ret;
> +				break;
> +			}
> +		} else
> +			if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
> +				break;
> +#else
>  		if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
>  			break;
> +#endif
>  	}
>  
>  	if (i == file_types) {
> -- 
> 2.7.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
