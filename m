Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WBJwu-0006rx-3f
 for kexec@lists.infradead.org; Thu, 06 Feb 2014 08:04:40 +0000
Date: Thu, 6 Feb 2014 17:04:17 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: fix uImage probe false positive
Message-ID: <20140206080416.GG24865@verge.net.au>
References: <8bf27d38eb0cf5d0c70333ef17cf9f7167a0bf56.1391673023.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8bf27d38eb0cf5d0c70333ef17cf9f7167a0bf56.1391673023.git.baruch@tkos.co.il>
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
To: Baruch Siach <baruch@tkos.co.il>
Cc: "Suzuki K. Poulose" <suzuki@in.ibm.com>, kexec@lists.infradead.org

On Thu, Feb 06, 2014 at 09:50:23AM +0200, Baruch Siach wrote:
> Since bf06cf2095 (kexec/uImage: probe to identify a corrupted image)
> uImage_probe_kernel() returns 1 for non uImage files. Don't treat this value
> as positive probe indication.
> 
> Cc: Suzuki K. Poulose <suzuki@in.ibm.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Thanks. I had just applied the same patch from Dave Young.

> ---
>  kexec/kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index f13e5124aacc..703d524836b4 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -691,7 +691,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
>  	}
>  	if (!type || guess_only) {
>  		for (i = 0; i < file_types; i++) {
> -			if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
> +			if (file_type[i].probe(kernel_buf, kernel_size) == 0)
>  				break;
>  		}
>  		if (i == file_types) {
> -- 
> 1.8.5.3
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
