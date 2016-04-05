Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1anKYQ-0002pB-JH
 for kexec@lists.infradead.org; Tue, 05 Apr 2016 06:33:36 +0000
Date: Tue, 5 Apr 2016 15:33:06 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] arm: properly handle a missing /chosen node in the DT
Message-ID: <20160405063306.GA19694@verge.net.au>
References: <1459438260-8205-1-git-send-email-alban.bedel@avionic-design.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1459438260-8205-1-git-send-email-alban.bedel@avionic-design.de>
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
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>, kexec@lists.infradead.org

On Thu, Mar 31, 2016 at 05:30:58PM +0200, Alban Bedel wrote:
> From: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
> 
> When adding a new node to the DT in the setup_dtb_prop function, the
> parent offset need be passed to fdt_add_subnode.  Currently a bogus
> error code is used.  Fix that by adding the parent offset as an extra
> function argument to setup_dtb_prop, and change the handling of the
> /chosen node to operate on a relative path plus (zero) offset instead of
> an absolute path.
> 
> Signed-off-by: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>

Hi,

I am struggling to see the problem that this patch tries to solve.

* Where and when is a bogus error code used?
* Why is a new parameter added to fdt_add_subnode and always passed as zero?
* If it is inappropriate to pass off to fdt_add_subnode() can
  that be resolved by simply passing 0 instead?

> ---
>  kexec/arch/arm/kexec-zImage-arm.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> index d85ab9b..78518fd 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -257,8 +257,9 @@ int atag_arm_load(struct kexec_info *info, unsigned long base,
>  	return 0;
>  }
>  
> -static int setup_dtb_prop(char **bufp, off_t *sizep, const char *node_name,
> -		const char *prop_name, const void *val, int len)
> +static int setup_dtb_prop(char **bufp, off_t *sizep, int parentoffset,
> +		const char *node_name, const char *prop_name,
> +		const void *val, int len)
>  {
>  	char *dtb_buf;
>  	off_t dtb_size;
> @@ -273,14 +274,14 @@ static int setup_dtb_prop(char **bufp, off_t *sizep, const char *node_name,
>  	dtb_size = *sizep;
>  
>  	/* check if the subnode has already exist */
> -	off = fdt_path_offset(dtb_buf, node_name);
> +	off = fdt_subnode_offset(dtb_buf, parentoffset, node_name);
>  	if (off == -FDT_ERR_NOTFOUND) {
>  		dtb_size += fdt_node_len(node_name);
>  		fdt_set_totalsize(dtb_buf, dtb_size);
>  		dtb_buf = xrealloc(dtb_buf, dtb_size);
>  		if (dtb_buf == NULL)
>  			die("xrealloc failed\n");
> -		off = fdt_add_subnode(dtb_buf, off, node_name);
> +		off = fdt_add_subnode(dtb_buf, parentoffset, node_name);
>  	}
>  
>  	if (off < 0) {
> @@ -496,7 +497,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  				 *  Error should have been reported so
>  				 *  directly return -1
>  				 */
> -				if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
> +				if (setup_dtb_prop(&dtb_buf, &dtb_length, 0, "chosen",
>  						"bootargs", command_line,
>  						strlen(command_line) + 1))
>  					return -1;
> @@ -542,11 +543,11 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  			start = cpu_to_be32((unsigned long)(initrd_base));
>  			end = cpu_to_be32((unsigned long)(initrd_base + initrd_size));
>  
> -			if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
> +			if (setup_dtb_prop(&dtb_buf, &dtb_length, 0, "chosen",
>  					"linux,initrd-start", &start,
>  					sizeof(start)))
>  				return -1;
> -			if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
> +			if (setup_dtb_prop(&dtb_buf, &dtb_length, 0, "chosen",
>  					"linux,initrd-end", &end,
>  					sizeof(end)))
>  				return -1;
> -- 
> 2.8.0
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
