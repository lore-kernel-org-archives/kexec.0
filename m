Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fk-out-0910.google.com ([209.85.128.188])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KOHcb-0004Cu-LG
	for kexec@lists.infradead.org; Wed, 30 Jul 2008 19:46:06 +0000
Received: by fk-out-0910.google.com with SMTP id 18so121986fks.2
	for <kexec@lists.infradead.org>; Wed, 30 Jul 2008 12:46:03 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: linux-next: build failure
Date: Wed, 30 Jul 2008 21:16:55 +0200
References: <20080730153028.95226354.sfr@canb.auug.org.au>
	<20080730064146.GA1564@cs181140183.pp.htv.fi>
	<20080730070643.GA18347@in.ibm.com>
In-Reply-To: <20080730070643.GA18347@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200807302116.55515.bzolnier@gmail.com>
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
To: Ankita Garg <ankita@in.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Adrian Bunk <bunk@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, linux-next@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

On Wednesday 30 July 2008, Ankita Garg wrote:
> On Wed, Jul 30, 2008 at 09:41:46AM +0300, Adrian Bunk wrote:
> > On Wed, Jul 30, 2008 at 03:30:28PM +1000, Stephen Rothwell wrote:
> > > Hi Ananth,
> > > 
> > > Today's linux-next build (powerpc allyesconfig) failed like this:
> > > 
> > > tests/lkdtm.c:182: error: expected ')' before '*' token
> > > 
> > > I have no idea why this fails now when it did not before.
> > 
> > Sorry, that's my fault.
> > (I didn't notice since my allyes builds have CONFIG_MODULES=n, and
> >  no defconfig seems to have both LKDTM and IDE=y.)
> > 
> > Bart, can you either apply Stephen's patch or drop the lkdtm.c chunk 
> > from my patch?
> >
> 
> I suppose it would be better if the earlier changes are reverted, as
> lkdtm already has bits to include ide.h depending on CONFIG_IDE being
> y/n.

I reverted lktdm.c change (sorry for not noticing it earlier).

Thanks,
Bart

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
