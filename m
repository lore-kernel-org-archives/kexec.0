Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TlVS3-0004b3-4y
 for kexec@lists.infradead.org; Thu, 20 Dec 2012 02:01:36 +0000
Received: by mail-pb0-f46.google.com with SMTP id wy7so1615761pbc.33
 for <kexec@lists.infradead.org>; Wed, 19 Dec 2012 18:01:32 -0800 (PST)
Message-ID: <50D27175.7030006@gmail.com>
Date: Thu, 20 Dec 2012 10:01:25 +0800
From: Daniel Mack <zonque@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec-zImage-arm: simply cmdline-related DTB resizing
References: <1355959196-14500-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1355959196-14500-1-git-send-email-swarren@wwwdotorg.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Stephen Warren <swarren@nvidia.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Sven Neumann <neumann@teufel.de>

On 12/20/2012 07:19 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> When resizing a dtb to add the command-line, only resize the DTB once,
> rather than once to add the /chosen node, and once to add the bootargs
> property.
> 
> Also, simply add 1K of overhead (beyond strlen(cmdline)) to the buffer,
> to avoid requiring precise knowledge of the size impact of the requested
> FTB changes. In particular, some padding is performed when setting
> property values, which was not accounted for in the current code, which
> caused failures to set the bootargs values in some cases.
> 
> Cc: Daniel Mack <zonque@gmail.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Much cleaner, thanks Stephen.


Daniel


> ---
>  kexec/arch/arm/kexec-zImage-arm.c |   21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> index 0950897..db29a7b 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -370,31 +370,22 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  				const char *prop_name = "bootargs";
>  				int off;
>  
> +				dtb_length = fdt_totalsize(dtb_buf) + 1024 +
> +					strlen(command_line);
> +				dtb_buf = xrealloc(dtb_buf, dtb_length);
> +				fdt_set_totalsize(dtb_buf, dtb_length);
> +
>  				/* check if a /choosen subnode already exists */
>  				off = fdt_path_offset(dtb_buf, node_name);
>  
> -				if (off == -FDT_ERR_NOTFOUND) {
> -					dtb_length = fdt_totalsize(dtb_buf)
> -							+ strlen(node_name) + 1
> -							+ sizeof(struct fdt_node_header)
> -							+ FDT_TAGSIZE;
> -					dtb_buf = xrealloc(dtb_buf, dtb_length);
> -					fdt_set_totalsize(dtb_buf, dtb_length);
> +				if (off == -FDT_ERR_NOTFOUND)
>  					off = fdt_add_subnode(dtb_buf, off, node_name);
> -				}
>  
>  				if (off < 0) {
>  					fprintf(stderr, "FDT: Error adding %s node.\n", node_name);
>  					return -1;
>  				}
>  
> -				dtb_length = fdt_totalsize(dtb_buf)
> -						+ strlen(prop_name)
> -						+ strlen(command_line) + 1
> -						+ sizeof(struct fdt_property);
> -				dtb_buf = xrealloc(dtb_buf, dtb_length);
> -				fdt_set_totalsize(dtb_buf, dtb_length);
> -
>  				if (fdt_setprop(dtb_buf, off, prop_name,
>  						command_line, strlen(command_line) + 1) != 0) {
>  					fprintf(stderr, "FDT: Error setting %s/%s property.\n",
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
