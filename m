Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Otsdz-0004UA-IB
	for kexec@lists.infradead.org; Fri, 10 Sep 2010 01:43:12 +0000
Date: Fri, 10 Sep 2010 10:43:07 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ppc64: increase TREEWORDS value in ppc64
Message-ID: <20100910014307.GF8477@verge.net.au>
References: <20100909202711.GA22581@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100909202711.GA22581@hmsreliant.think-freely.org>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, vgoyal@redhat.com

[ Repost with correct kexec ML address ]
[ CCed linuxppc-dev ]

On Thu, Sep 09, 2010 at 04:27:11PM -0400, Neil Horman wrote:
> hey-
>      Got a segfault recently on ppc64 kexec with a system with 256Gb of ram.
> Tracked it back to running over the end of the device tree buffer that we have
> allocated.  I can't find any docs on how big the device tree can legally be, so
> for now I figure just upping its size is sufficient.  Confirmed that this fixed
> the segfault.

Thanks Neil, though it would be nice to know what the limit actually is.
I'll hold off on applying this for a few days to see of the PPC people
have any comments on that.

> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 
> 
>  fs2dt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
> index 238a3f2..2f0f937 100644
> --- a/kexec/arch/ppc/fs2dt.c
> +++ b/kexec/arch/ppc/fs2dt.c
> @@ -33,7 +33,7 @@
>  
>  #define MAXPATH			1024	/* max path name length */
>  #define NAMESPACE		16384	/* max bytes for property names */
> -#define TREEWORDS		65536	/* max 32 bit words for properties */
> +#define TREEWORDS		131070	/* max 32 bit words for properties */
>  #define MEMRESERVE		256	/* max number of reserved memory blks */
>  #define MAX_MEMORY_RANGES	1024
>  #define COMMAND_LINE_SIZE	512	/* from kernel */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
