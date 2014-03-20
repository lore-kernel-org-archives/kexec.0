Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQVyK-0003fP-Pg
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 05:56:58 +0000
Date: Thu, 20 Mar 2014 13:57:11 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] kexec: pass initrd position in dtb
Message-ID: <20140320055711.GF4722@dhcp-16-126.nay.redhat.com>
References: <1395293742-56591-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395293742-56591-1-git-send-email-wangnan0@huawei.com>
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
To: Wang Nan <wangnan0@huawei.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

On 03/20/14 at 01:35pm, Wang Nan wrote:
> This patch append the position of initrd to dtb when loading arm kernel
> and initrd without using atag.
> 
> Change from v1:
> 
>  - Remove #include "libfdt_internal.h" since it is for internal use
>    for libfdt.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Geng Hui <hui.geng@huawei.com>
> ---
>  kexec/arch/arm/kexec-zImage-arm.c | 83 +++++++++++++++++++++++++++------------
>  1 file changed, 58 insertions(+), 25 deletions(-)
> 
> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> index 8a35018..1cd4ed0 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -216,6 +216,47 @@ int atag_arm_load(struct kexec_info *info, unsigned long base,
>  	return 0;
>  }
>  
> +static int setup_dtb_prop(char **bufp, off_t *sizep, const char *node_name,
> +		const char *prop_name, const void *val, int len)
> +{
> +	char *dtb_buf;
> +	int off;
> +
> +	if ((bufp == NULL) || (sizep == NULL) || (*bufp == NULL))
> +		die("Internal error\n");
> +
> +	dtb_buf = *bufp;
> +
> +	*sizep = fdt_totalsize(*bufp) + FDT_TAGSIZE + len +
> +		_ALIGN(strlen(node_name) + 1, FDT_TAGSIZE) +
> +		_ALIGN(strlen(prop_name) + 1, FDT_TAGSIZE) +
> +		sizeof(struct fdt_property);
> +
> +	dtb_buf = xrealloc(dtb_buf, *sizep);
> +	if (dtb_buf == NULL)
> +		die("xrealloc failed\n");
> +	*bufp = dtb_buf;
> +
> +	fdt_set_totalsize(dtb_buf, *sizep);
> +
> +	/* check if the subnode already exists */
> +	off = fdt_path_offset(dtb_buf, node_name);
> +
> +	if (off == -FDT_ERR_NOTFOUND)
> +		off = fdt_add_subnode(dtb_buf, off, node_name);
> +	if (off < 0) {
> +		fprintf(stderr, "FDT: Error adding %s node.\n", node_name);
> +		return -1;
> +	}
> +	if (fdt_setprop(dtb_buf, off, prop_name,
> +				val, len) != 0) {
> +		fprintf(stderr, "FDT: Error setting %s/%s property.\n",
> +				node_name, prop_name);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
>  int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  	struct kexec_info *info)
>  {
> @@ -375,32 +416,11 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  			}
>  
>  			if (command_line) {
> -				const char *node_name = "/chosen";
> -				const char *prop_name = "bootargs";
> -				int off;
> -
> -				dtb_length = fdt_totalsize(dtb_buf) + 1024 +
> -					strlen(command_line);
> -				dtb_buf = xrealloc(dtb_buf, dtb_length);
> -				fdt_set_totalsize(dtb_buf, dtb_length);
> -
> -				/* check if a /choosen subnode already exists */
> -				off = fdt_path_offset(dtb_buf, node_name);
> -
> -				if (off == -FDT_ERR_NOTFOUND)
> -					off = fdt_add_subnode(dtb_buf, off, node_name);
> -
> -				if (off < 0) {
> -					fprintf(stderr, "FDT: Error adding %s node.\n", node_name);
> +				/* Error should have been reported */
> +				if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
> +						"bootargs", command_line,
> +						strlen(command_line) + 1))
>  					return -1;
> -				}
> -
> -				if (fdt_setprop(dtb_buf, off, prop_name,
> -						command_line, strlen(command_line) + 1) != 0) {
> -					fprintf(stderr, "FDT: Error setting %s/%s property.\n",
> -						node_name, prop_name);
> -					return -1;
> -				}
>  			}
>  		} else {
>  			/*
> @@ -417,6 +437,19 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  		if (ramdisk) {
>  			add_segment(info, ramdisk_buf, initrd_size,
>  			            initrd_base, initrd_size);
> +
> +			unsigned long start, end;
> +			start = cpu_to_be32((unsigned long)(initrd_base));
> +			end = cpu_to_be32((unsigned long)(initrd_base + initrd_size));
> +
> +			if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
> +					"linux,initrd-start", &start,
> +					sizeof(start)))
> +				return -1;
> +			if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
> +					"linux,initrd-end", &end,
> +					sizeof(end)))
> +				return -1;
>  		}
>  
>  		/* Stick the dtb at the end of the initrd and page
> -- 
> 1.8.4
> 

Hi,

Thanks for quick update, would you like to redo the patch again and
split it to 2 patches as I mentioned in another reply?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
