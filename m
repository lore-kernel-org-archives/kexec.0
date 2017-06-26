Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dPKA3-0007L3-1a
 for kexec@lists.infradead.org; Mon, 26 Jun 2017 02:54:09 +0000
Date: Mon, 26 Jun 2017 10:52:56 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec:arm: support zImage with appended device tree
Message-ID: <20170626025256.GA3378@dhcp-128-65.nay.redhat.com>
References: <1498208138-19283-1-git-send-email-hoeun.ryu@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1498208138-19283-1-git-send-email-hoeun.ryu@gmail.com>
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
To: Hoeun Ryu <hoeun.ryu@gmail.com>
Cc: Matthew Leach <matthew.leach@arm.com>, Russell King <rmk@armlinux.org.uk>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Wang Nan <wangnan0@huawei.com>

On 06/23/17 at 05:55pm, Hoeun Ryu wrote:
> Arm linux supports zImage with appended dtb (CONFIG_ARM_APPENDED_DTB) and
> the concatenated image is generated like `cat zImage dtb > zImage_w_dtb`.
> 
> This patch is to support the concatednated zImage. This changes the
> priority of source of dtb file.
> 
>  1. --dtb dtb_file
>  2. zImage_w_dtb	<= newly added
>  3. /sys/firmware/fdt
>  4. /proc/device-tree

The original default fdt is /sys/firmware/fdt, after your changes it
becomes zImage attached dtb, presumably one knows his zImage appended a
dtb it is fine, but if one does not notice it, it changes the behavior
he expects.

How about add a new option for zImage_dtb, like --zImage-dtb

> 
> Users don't need to specify dtb file in the command line and don't have to
> have /sys/firmware/fdt or /proc/device-tree if dtb is available in zImage.
> 
> Signed-off-by: Hoeun Ryu <hoeun.ryu@gmail.com>
> ---
>  kexec/arch/arm/kexec-arm.h        |  1 +
>  kexec/arch/arm/kexec-zImage-arm.c | 47 ++++++++++++++++++++++++++++++---------
>  2 files changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/kexec/arch/arm/kexec-arm.h b/kexec/arch/arm/kexec-arm.h
> index a74cce2..94695b7 100644
> --- a/kexec/arch/arm/kexec-arm.h
> +++ b/kexec/arch/arm/kexec-arm.h
> @@ -4,6 +4,7 @@
>  #include <sys/types.h>
>  
>  #define SYSFS_FDT "/sys/firmware/fdt"
> +#define APPENDED_FDT ((char *)-1) /* it doesn't mean to be opened. */
>  #define BOOT_BLOCK_VERSION 17
>  #define BOOT_BLOCK_LAST_COMP_VERSION 16
>  
> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> index 7f02b93..59f0003 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -390,6 +390,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  	initrd_size = 0;
>  	use_atags = 0;
>  	dtb_file = NULL;
> +	dtb_buf = NULL;
>  	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
>  		switch(opt) {
>  		default:
> @@ -424,14 +425,6 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  		return -1;
>  	}
>  
> -	if (!use_atags && !dtb_file) {
> -		int f;
> -
> -		f = have_sysfs_fdt();
> -		if (f)
> -			dtb_file = SYSFS_FDT;
> -	}
> -
>  	if (command_line) {
>  		command_line_len = strlen(command_line) + 1;
>  		if (command_line_len > COMMAND_LINE_SIZE)
> @@ -440,9 +433,6 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  	if (ramdisk)
>  		ramdisk_buf = slurp_file(ramdisk, &initrd_size);
>  
> -	if (dtb_file)
> -		dtb_buf = slurp_file(dtb_file, &dtb_length);
> -
>  	if (len > 0x34) {
>  		const struct zimage_header *hdr;
>  		off_t size;
> @@ -459,6 +449,25 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  				  (unsigned long long)size,
>  				  (unsigned long long)len);
>  
> +			/* check if zImage has an appended dtb */
> +			if (!dtb_file) {
> +				if (fdt_check_header(buf + size) == 0) {
> +					/*
> +					 * dtb_file won't be opened. It's set
> +					 * just to pass NULL checking.
> +					 */
> +					dtb_file = APPENDED_FDT;
> +					dtb_length = fdt_totalsize(buf + size);
> +					dtb_buf = xmalloc(dtb_length);
> +					memcpy(dtb_buf, buf+size, dtb_length);
> +
> +					dbgprintf("found appended dtb, size 0x%llx\n",
> +						  (unsigned long long)dtb_length);
> +
> +
> +				}
> +			}
> +
>  			if (size > len) {
>  				fprintf(stderr,
>  					"zImage is truncated - file 0x%llx vs header 0x%llx\n",
> @@ -575,6 +584,22 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  		initrd_base = kernel_base + _ALIGN(len * 5, getpagesize());
>  	}
>  
> +	if (!use_atags && !dtb_file) {
> +		int f;
> +
> +		f = have_sysfs_fdt();
> +		if (f)
> +			dtb_file = SYSFS_FDT;
> +	}
> +
> +	/*
> +	 * dtb_buf can be allocated when checking zImage_with_dtb.
> +	 * dtb_buf won't be allocated in the logic if dtb_file is handed over
> +	 * in argv[].
> +	 */
> +	if (dtb_file && !dtb_buf)
> +		dtb_buf = slurp_file(dtb_file, &dtb_length);
> +
>  	if (use_atags) {
>  		/*
>  		 * use ATAGs from /proc/atags
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
