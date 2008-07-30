Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.18.174])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KO5n8-00011l-IZ
	for kexec@lists.infradead.org; Wed, 30 Jul 2008 07:08:11 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6U77KeH025187
	for <kexec@lists.infradead.org>; Wed, 30 Jul 2008 17:07:20 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6U76pH9479382
	for <kexec@lists.infradead.org>; Wed, 30 Jul 2008 17:06:51 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6U76oFa012656
	for <kexec@lists.infradead.org>; Wed, 30 Jul 2008 17:06:51 +1000
Date: Wed, 30 Jul 2008 12:36:43 +0530
From: Ankita Garg <ankita@in.ibm.com>
Subject: Re: linux-next: build failure
Message-ID: <20080730070643.GA18347@in.ibm.com>
References: <20080730153028.95226354.sfr@canb.auug.org.au>
	<20080730064146.GA1564@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080730064146.GA1564@cs181140183.pp.htv.fi>
Reply-To: Ankita Garg <ankita@in.ibm.com>
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
To: Adrian Bunk <bunk@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, linux-next@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

On Wed, Jul 30, 2008 at 09:41:46AM +0300, Adrian Bunk wrote:
> On Wed, Jul 30, 2008 at 03:30:28PM +1000, Stephen Rothwell wrote:
> > Hi Ananth,
> > 
> > Today's linux-next build (powerpc allyesconfig) failed like this:
> > 
> > tests/lkdtm.c:182: error: expected ')' before '*' token
> > 
> > I have no idea why this fails now when it did not before.
> 
> Sorry, that's my fault.
> (I didn't notice since my allyes builds have CONFIG_MODULES=n, and
>  no defconfig seems to have both LKDTM and IDE=y.)
> 
> Bart, can you either apply Stephen's patch or drop the lkdtm.c chunk 
> from my patch?
>

I suppose it would be better if the earlier changes are reverted, as
lkdtm already has bits to include ide.h depending on CONFIG_IDE being
y/n.

> > I applied the following patch.
> > -- 
> > Cheers,
> > Stephen Rothwell                    sfr@canb.auug.org.au
> > http://www.canb.auug.org.au/~sfr/
> > 
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Wed, 30 Jul 2008 15:24:53 +1000
> > Subject: [PATCH] tests: lkdtm needs ide.h
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  tests/lkdtm.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/tests/lkdtm.c b/tests/lkdtm.c
> > index 2a40d18..856f060 100644
> > --- a/tests/lkdtm.c
> > +++ b/tests/lkdtm.c
> > @@ -52,6 +52,7 @@
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/hrtimer.h>
> > +#include <linux/ide.h>
> >  #include <scsi/scsi_cmnd.h>
> >  
> >  #define NUM_CPOINTS 8
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
