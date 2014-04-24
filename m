Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WdBIS-0001yw-N6
 for kexec@lists.infradead.org; Thu, 24 Apr 2014 04:30:05 +0000
Date: Thu, 24 Apr 2014 13:29:42 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [kexec-tools] [PATCH 1/2] Fix rebuilding the purgatory.c file.
Message-ID: <20140424042942.GB9469@verge.net.au>
References: <1398312272-15634-1-git-send-email-pabs3@bonedaddy.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398312272-15634-1-git-send-email-pabs3@bonedaddy.net>
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
To: Paul Wise <pabs3@bonedaddy.net>
Cc: kexec@lists.infradead.org

Thanks,

this looks good to me as does the follow up patch.
Could you flesh out the changelog and add
signed-off-by line to each patch?

On Thu, Apr 24, 2014 at 12:04:31PM +0800, Paul Wise wrote:
> ---
>  kexec/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kexec/Makefile b/kexec/Makefile
> index 7d3175b..62fecdb 100644
> --- a/kexec/Makefile
> +++ b/kexec/Makefile
> @@ -1,7 +1,7 @@
>  #
>  # kexec (linux booting linux)
>  #
> -PURGATORY_HEX_C = kexec/purgatory.c
> +PURGATORY_HEX_C = purgatory/purgatory.c
>  
>  $(PURGATORY_HEX_C): $(PURGATORY) $(BIN_TO_HEX)
>  	$(MKDIR) -p $(@D)
> -- 
> 1.9.2
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
