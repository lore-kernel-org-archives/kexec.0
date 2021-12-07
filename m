Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mubTX-008wRk-FO
 for kexec@lists.infradead.org; Tue, 07 Dec 2021 14:29:49 +0000
Date: Tue, 7 Dec 2021 15:29:40 +0100
From: Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH 1/3] s390: add variable command line size
Message-ID: <20211207152940.2f6536e6@rhtmp>
In-Reply-To: <20211122071401.3106858-2-svens@linux.ibm.com>
References: <20211122071401.3106858-1-svens@linux.ibm.com>
 <20211122071401.3106858-2-svens@linux.ibm.com>
MIME-Version: 1.0
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
To: Sven Schnelle <svens@linux.ibm.com>, Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: kexec@lists.infradead.org

Hi Sven,

On Mon, 22 Nov 2021 08:13:59 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> Newer s390 kernels support a command line size longer than 896
> bytes. Such kernels contain a new member in the parameter area,
> which might be utilized by tools like kexec. Older kernels have
> the location initialized to zero, so we check whether there's a
> non-zero number present and use that. If there isn't, we fallback
> to the legacy command line size of 896 bytes.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Reviewed-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  kexec/arch/s390/kexec-image.c | 53 ++++++++++++++++++++++++-----------
>  kexec/arch/s390/kexec-s390.h  | 19 +++++++------
>  2 files changed, 46 insertions(+), 26 deletions(-)
> 
> diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
> index 3c24fdfe3c7c..7747d02399db 100644
> --- a/kexec/arch/s390/kexec-image.c
> +++ b/kexec/arch/s390/kexec-image.c
> @@ -25,7 +25,7 @@
>  #include <fcntl.h>
>  
>  static uint64_t crash_base, crash_end;
> -static char command_line[COMMAND_LINESIZE];
> +static char *command_line;

isn't this the perfect opportunity to get rid of this global variable
and...

>  static void add_segment_check(struct kexec_info *info, const void *buf,
>  			      size_t bufsz, unsigned long base, size_t memsz)
> @@ -38,11 +38,16 @@ static void add_segment_check(struct kexec_info *info, const void *buf,
>  
>  int command_line_add(const char *str)

... simply pass the pointer as an argument ;)

Thanks
Philipp

>  {
> -	if (strlen(command_line) + strlen(str) + 1 > COMMAND_LINESIZE) {
> -		fprintf(stderr, "Command line too long.\n");
> +	char *tmp = NULL;
> +
> +	tmp = concat_cmdline(command_line, str);
> +	if (!tmp) {
> +		fprintf(stderr, "out of memory\n");
>  		return -1;
>  	}
> -	strcat(command_line, str);
> +
> +	free(command_line);
> +	command_line = tmp;
>  	return 0;
>  }
>  
> @@ -78,6 +83,8 @@ int image_s390_load_file(int argc, char **argv, struct kexec_info *info)
>  		if (info->initrd_fd == -1) {
>  			fprintf(stderr, "Could not open initrd file %s:%s\n",
>  					ramdisk, strerror(errno));
> +			free(command_line);
> +			command_line = NULL;
>  			return -1;
>  		}
>  	}
> @@ -97,7 +104,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
>  	const char *ramdisk;
>  	off_t ramdisk_len;
>  	unsigned int ramdisk_origin;
> -	int opt;
> +	int opt, ret = -1;
>  
>  	if (info->file_mode)
>  		return image_s390_load_file(argc, argv, info);
> @@ -112,7 +119,6 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
>  		};
>  	static const char short_options[] = KEXEC_OPT_STR "";
>  
> -	command_line[0] = 0;
>  	ramdisk = NULL;
>  	ramdisk_len = 0;
>  	ramdisk_origin = 0;
> @@ -132,7 +138,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
>  	if (info->kexec_flags & KEXEC_ON_CRASH) {
>  		if (parse_iomem_single("Crash kernel\n", &crash_base,
>  				       &crash_end))
> -			return -1;
> +			goto out;
>  	}
>  
>  	/* Add kernel segment */
> @@ -151,7 +157,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
>  		rd_buffer = slurp_file_mmap(ramdisk, &ramdisk_len);
>  		if (rd_buffer == NULL) {
>  			fprintf(stderr, "Could not read ramdisk.\n");
> -			return -1;
> +			goto out;
>  		}
>  		ramdisk_origin = MAX(RAMDISK_ORIGIN_ADDR, kernel_size);
>  		ramdisk_origin = _ALIGN_UP(ramdisk_origin, 0x100000);
> @@ -160,7 +166,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
>  	}
>  	if (info->kexec_flags & KEXEC_ON_CRASH) {
>  		if (load_crashdump_segments(info, crash_base, crash_end))
> -			return -1;
> +			goto out;
>  	} else {
>  		info->entry = (void *) IMAGE_READ_OFFSET;
>  	}
> @@ -183,15 +189,28 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
>  			*tmp = crash_end - crash_base + 1;
>  		}
>  	}
> -	/*
> -	 * We will write a probably given command line.
> -	 * First, erase the old area, then setup the new parameters:
> -	 */
> -	if (strlen(command_line) != 0) {
> -		memset(krnl_buffer + COMMAND_LINE_OFFS, 0, COMMAND_LINESIZE);
> -		memcpy(krnl_buffer + COMMAND_LINE_OFFS, command_line, strlen(command_line));
> +
> +	if (command_line) {
> +		unsigned long maxsize;
> +		char *dest = krnl_buffer + COMMAND_LINE_OFFS;
> +
> +		maxsize = *(unsigned long *)(krnl_buffer + MAX_COMMAND_LINESIZE_OFFS);
> +		if (!maxsize)
> +			maxsize = LEGACY_COMMAND_LINESIZE;
> +
> +		if (strlen(command_line) > maxsize-1) {
> +			fprintf(stderr, "command line too long, maximum allowed size %ld\n",
> +				maxsize-1);
> +			goto out;
> +		}
> +		strncpy(dest, command_line, maxsize-1);
> +		dest[maxsize-1] = '\0';
>  	}
> -	return 0;
> +	ret = 0;
> +out:
> +	free(command_line);
> +	command_line = NULL;
> +	return ret;
>  }
>  
>  int 
> diff --git a/kexec/arch/s390/kexec-s390.h b/kexec/arch/s390/kexec-s390.h
> index ef53b111e167..1b0e04848460 100644
> --- a/kexec/arch/s390/kexec-s390.h
> +++ b/kexec/arch/s390/kexec-s390.h
> @@ -10,16 +10,17 @@
>  #ifndef KEXEC_S390_H
>  #define KEXEC_S390_H
>  
> -#define IMAGE_READ_OFFSET     0x10000
> +#define IMAGE_READ_OFFSET           0x10000
>  
> -#define RAMDISK_ORIGIN_ADDR   0x800000
> -#define INITRD_START_OFFS     0x408
> -#define INITRD_SIZE_OFFS      0x410
> -#define OLDMEM_BASE_OFFS      0x418
> -#define OLDMEM_SIZE_OFFS      0x420
> -#define COMMAND_LINE_OFFS     0x480
> -#define COMMAND_LINESIZE      896
> -#define MAX_MEMORY_RANGES     1024
> +#define RAMDISK_ORIGIN_ADDR         0x800000
> +#define INITRD_START_OFFS           0x408
> +#define INITRD_SIZE_OFFS            0x410
> +#define OLDMEM_BASE_OFFS            0x418
> +#define OLDMEM_SIZE_OFFS            0x420
> +#define MAX_COMMAND_LINESIZE_OFFS   0x430
> +#define COMMAND_LINE_OFFS           0x480
> +#define LEGACY_COMMAND_LINESIZE     896
> +#define MAX_MEMORY_RANGES           1024
>  
>  #define MAX(x, y) ((x) > (y) ? (x) : (y))
>  #define MIN(x, y) ((x) < (y) ? (x) : (y))


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
