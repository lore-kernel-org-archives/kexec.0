Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YYl4m-0004es-7A
 for kexec@lists.infradead.org; Fri, 20 Mar 2015 00:46:12 +0000
Received: from ayumi.isobedori.kobe.vergenet.net
 (p8130-ipbfp1005kobeminato.hyogo.ocn.ne.jp [118.10.149.130])
 by kirsty.vergenet.net (Postfix) with ESMTP id 2833925BF53
 for <kexec@lists.infradead.org>; Fri, 20 Mar 2015 11:45:49 +1100 (EST)
Date: Fri, 20 Mar 2015 09:45:46 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] x86: Remove unnecessary res variable from efi_map_added
Message-ID: <20150320004546.GA26666@verge.net.au>
References: <1426731739-19328-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1426731739-19328-1-git-send-email-horms@verge.net.au>
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
To: kexec@lists.infradead.org

On Thu, Mar 19, 2015 at 11:22:19AM +0900, Simon Horman wrote:
> gcc 4.9.1 tells me this variable is set but unused
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>

I have queued this up.

> ---
>  kexec/arch/i386/kexec-x86-common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
> index bc622e9..3624192 100644
> --- a/kexec/arch/i386/kexec-x86-common.c
> +++ b/kexec/arch/i386/kexec-x86-common.c
> @@ -293,10 +293,10 @@ again:
>   * @return 1 if parameter is present, 0 if not or if an error occurs.
>   */
>  int efi_map_added( void ) {
> -	char buf[512], *res;
> +	char buf[512];
>  	FILE *fp = fopen( "/proc/cmdline", "r" );
>  	if( fp ) {
> -		res = fgets( buf, 512, fp );
> +		fgets( buf, 512, fp );
>  		fclose( fp );
>  		return strstr( buf, "add_efi_memmap" ) != NULL;
>  	} else {
> -- 
> 2.1.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
