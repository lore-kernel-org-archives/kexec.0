Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jhYla-0000LQ-P6
 for kexec@lists.infradead.org; Sat, 06 Jun 2020 13:21:44 +0000
Date: Sat, 6 Jun 2020 15:21:39 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: fix the unintended fallthrough when '-d'
 option is used
Message-ID: <20200606132139.GB24391@vergenet.net>
References: <159107231976.24822.8366905851318047662.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <159107231976.24822.8366905851318047662.stgit@hbathini.in.ibm.com>
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
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Kexec-ml <kexec@lists.infradead.org>

On Tue, Jun 02, 2020 at 10:01:59AM +0530, Hari Bathini wrote:
> Fixes: 28d4ab532808 ("Add generic debug option")
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Thanks, applied.

> ---
>  kexec/kexec.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 7ef3d2a..a62b362 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1374,6 +1374,7 @@ int main(int argc, char *argv[])
>  			return 0;
>  		case OPT_DEBUG:
>  			kexec_debug = 1;
> +			break;
>  		case OPT_NOIFDOWN:
>  			skip_ifdown = 1;
>  			break;
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
