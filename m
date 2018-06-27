Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fY9Br-0002F2-8R
 for kexec@lists.infradead.org; Wed, 27 Jun 2018 12:04:56 +0000
Date: Wed, 27 Jun 2018 14:04:38 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 2/2] kexec-arm64: Add functionality to dump 2nd dtb
Message-ID: <20180627120437.gdq66rfr7q2yiynd@verge.net.au>
References: <1529576678-14615-1-git-send-email-bhsharma@redhat.com>
 <1529576678-14615-3-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1529576678-14615-3-git-send-email-bhsharma@redhat.com>
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
Cc: dyoung@redhat.com, bhupesh.linux@gmail.com, kexec@lists.infradead.org, james.morse@arm.com, takahiro.akashi@linaro.org

On Thu, Jun 21, 2018 at 03:54:38PM +0530, Bhupesh Sharma wrote:
> Since during the arm64 kexec_load()/kdump invocation,
> the dtb is passed to the second kernel, it is sometimes useful
> to dump the dtb contents (to verify the correctness
> of the same).
> 
> This patch adds this feature which is enabled when '-d' flag is
> used with kexec command line invocation.

This seems significantly more verbose than what -d already outputs.
Perhaps a second debug level is warranted here?

> 
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  kexec/arch/arm64/kexec-arm64.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> index a206c172b1aa..47df756bd595 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -540,6 +540,8 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
>  	dtb->buf = new_buf;
>  	dtb->size = fdt_totalsize(new_buf);
>  
> +	dbgprintf("%s: found %s\n", __func__, dtb->path);
> +	dump_fdt(dtb->buf);
>  	dump_reservemap(dtb);
>  
>  	return result;
> -- 
> 2.7.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
