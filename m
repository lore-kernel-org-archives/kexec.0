Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fY4Il-00051u-0e
 for kexec@lists.infradead.org; Wed, 27 Jun 2018 06:51:40 +0000
Date: Wed, 27 Jun 2018 08:51:25 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] arm64: error out if kernel command line is too long
Message-ID: <20180627065125.swbswslhi7ry4uyx@verge.net.au>
References: <1530042449-19329-1-git-send-email-kamatam@amazon.com>
 <1530042449-19329-2-git-send-email-kamatam@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1530042449-19329-2-git-send-email-kamatam@amazon.com>
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
To: Munehisa Kamata <kamatam@amazon.com>
Cc: kexec@lists.infradead.org

On Tue, Jun 26, 2018 at 12:47:29PM -0700, Munehisa Kamata wrote:
> Currently, in arm64, kexec silently truncates kernel command line longer
> than COMMAND_LINE_SIZE - 1. Error out in that case as some other
> architectures already do that. The error message is copied from x86_64.
> 
> Suggested-by: Tom Kirchner <tjk@amazon.com>
> Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
> ---
>  kexec/arch/arm64/kexec-arm64.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)


Hi,

This looks fine to me but I will wait to see if there are other reviews
before applying.

Reviewed-by: Simon Horman <horms@verge.net.au>

> 
> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> index 62f3758..8200064 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -536,8 +536,15 @@ int arm64_load_other_segments(struct kexec_info *info,
>  	char command_line[COMMAND_LINE_SIZE] = "";
>  
>  	if (arm64_opts.command_line) {
> +		if (strlen(arm64_opts.command_line) >
> +		    sizeof(command_line) - 1) {

> +			fprintf(stderr,
> +				"Kernel command line too long for kernel!\n");
> +			return EFAILED;
> +		}
> +
>  		strncpy(command_line, arm64_opts.command_line,
> -			sizeof(command_line));
> +			sizeof(command_line) - 1);
>  		command_line[sizeof(command_line) - 1] = 0;
>  	}
>  
> -- 
> 2.7.4
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
