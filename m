Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KwmZH-0005Wm-Br
	for kexec@lists.infradead.org; Sun, 02 Nov 2008 23:41:16 +0000
Date: Mon, 3 Nov 2008 10:41:11 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec memory ranges dynamic allocation
Message-ID: <20081102234109.GG11409@verge.net.au>
References: <572af9170810140811v446a6874pd67cb77753a9e32d@mail.gmail.com>
	<20081015031818.GC27243@verge.net.au>
	<572af9170810150146p58c599fvabb41338ffd4e033@mail.gmail.com>
	<20081031022902.GH27118@verge.net.au>
	<572af9170810302353l417781berf1da0661b37bc6db@mail.gmail.com>
	<20081101031601.GA11013@verge.net.au>
	<572af9170811010143v37826aa2y3200eb6815aba966@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <572af9170811010143v37826aa2y3200eb6815aba966@mail.gmail.com>
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
To: Maxim Uvarov <muvarov@gmail.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Chandru <chandru@in.ibm.com>, kexec@lists.infradead.org

On Sat, Nov 01, 2008 at 11:43:15AM +0300, Maxim Uvarov wrote:
> 2008/11/1 Simon Horman <horms@verge.net.au>
> 
> > On Fri, Oct 31, 2008 at 09:53:23AM +0300, Maxim Uvarov wrote:
> > > 2008/10/31 Simon Horman <horms@verge.net.au>
> > >
> > > > Hi,
> > > >
> > > > Could someone please comment on the satus of this patch?
> > > >
> > > Hello,  Simon
> > >
> > > I can not reproduce  error which you wrote before on my target. So it is
> > a
> > > little bit
> > > difficult to say what  was wrong exactly.
> >
> > Hi,
> >
> > the version of the patch below (which I think is the latest)
> > compiles fine for me. I wanted to confirm that you
> > and Chandru are happy for it to be merged.
> >
> > If so, could you please provide a short descripton for the change-log
> > and a Signed-off-by line.
> 
> Patch looks good.
> 
> Description is:
>    Do not count  max_memory_range for allocation. Increase allocation
> buffers
>    when it is needed. This actually allows us to avoid a lot of troubles
> with
>    various device-tree files.
> 
> Signed-off-by: Maxim Uvarov <muvarov@gmail.com>

Thanks, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
