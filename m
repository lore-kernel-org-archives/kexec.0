Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yl925-00010o-Mb
 for kexec@lists.infradead.org; Thu, 23 Apr 2015 04:46:38 +0000
Date: Thu, 23 Apr 2015 13:46:14 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] purgatory: Fix memcmp for src address increment
Message-ID: <20150423044614.GD26500@verge.net.au>
References: <6cdeaea422f53a62d9c72dfb5848565697e27b08.1429758015.git.panand@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6cdeaea422f53a62d9c72dfb5848565697e27b08.1429758015.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: geoff@infradead.org, kexec@lists.infradead.org

On Thu, Apr 23, 2015 at 08:34:17AM +0530, Pratyush Anand wrote:
> src addresses are not being incremented, so only first byte is compared
> instead of first len bytes.
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> Acked-by: Geoff Levand <geoff@infradead.org>

Thanks, applied.

> ---
>  purgatory/string.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/purgatory/string.c b/purgatory/string.c
> index 4f35613ef751..f06c460b08f8 100644
> --- a/purgatory/string.c
> +++ b/purgatory/string.c
> @@ -46,6 +46,8 @@ int memcmp(void *src1, void *src2, size_t len)
>  		if (*s1 != *s2) {
>  			return *s2 - *s1;
>  		}
> +		s1++;
> +		s2++;
>  	}
>  	return 0;
>  	

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
