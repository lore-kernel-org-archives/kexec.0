Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjmCl-0004D9-0j
 for kexec@lists.infradead.org; Mon, 30 Nov 2020 16:39:11 +0000
Date: Mon, 30 Nov 2020 17:39:08 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] dt-ops: fix memory leak when new_node malloc fails
Message-ID: <20201130163907.GC20208@vergenet.net>
References: <20201130064156.2208-1-qiuguorui1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201130064156.2208-1-qiuguorui1@huawei.com>
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
To: qiuguorui1 <qiuguorui1@huawei.com>
Cc: leeyou.li@huawei.com, bhsharma@redhat.com, kexec@lists.infradead.org, zengweilin@huawei.com

On Mon, Nov 30, 2020 at 02:41:56PM +0800, qiuguorui1 wrote:
> In function dtb_set_property, when malloc new_node fails,
> we need to free new_dtb before return.
> 
> Fixes: f56cbcf4c2766 ("kexec/dt-ops.c: Fix '/chosen' v/s 'chosen' node
> being passed to fdt helper functions")
> Signed-off-by: qiuguorui1 <qiuguorui1@huawei.com>
> ---
>  kexec/dt-ops.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kexec/dt-ops.c b/kexec/dt-ops.c
> index dd2feaa..cc5feae 100644
> --- a/kexec/dt-ops.c
> +++ b/kexec/dt-ops.c
> @@ -89,6 +89,7 @@ int dtb_set_property(char **dtb, off_t *dtb_size, const char *node,
>  	new_node = malloc(strlen("/") + strlen(node) + 1);
>  	if (!new_node) {
>  		dbgprintf("%s: malloc failed\n", __func__);
> +		free(new_dtb);

Can we use the goto idiom here,
as is used elsewhere in this function?

>  		return -ENOMEM;
>  	}
>  
> -- 
> 2.12.3
> 
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
