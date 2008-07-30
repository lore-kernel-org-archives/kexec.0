Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KO5OR-00062b-J1
	for kexec@lists.infradead.org; Wed, 30 Jul 2008 06:42:40 +0000
Date: Wed, 30 Jul 2008 09:41:46 +0300
From: Adrian Bunk <bunk@kernel.org>
Subject: Re: linux-next: build failure
Message-ID: <20080730064146.GA1564@cs181140183.pp.htv.fi>
References: <20080730153028.95226354.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080730153028.95226354.sfr@canb.auug.org.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, linux-next@vger.kernel.org, Ankita Garg <ankita@in.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Jul 30, 2008 at 03:30:28PM +1000, Stephen Rothwell wrote:
> Hi Ananth,
> 
> Today's linux-next build (powerpc allyesconfig) failed like this:
> 
> tests/lkdtm.c:182: error: expected ')' before '*' token
> 
> I have no idea why this fails now when it did not before.

Sorry, that's my fault.
(I didn't notice since my allyes builds have CONFIG_MODULES=n, and
 no defconfig seems to have both LKDTM and IDE=y.)

Bart, can you either apply Stephen's patch or drop the lkdtm.c chunk 
from my patch?

> I applied the following patch.
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 30 Jul 2008 15:24:53 +1000
> Subject: [PATCH] tests: lkdtm needs ide.h
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  tests/lkdtm.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/tests/lkdtm.c b/tests/lkdtm.c
> index 2a40d18..856f060 100644
> --- a/tests/lkdtm.c
> +++ b/tests/lkdtm.c
> @@ -52,6 +52,7 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/hrtimer.h>
> +#include <linux/ide.h>
>  #include <scsi/scsi_cmnd.h>
>  
>  #define NUM_CPOINTS 8

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
