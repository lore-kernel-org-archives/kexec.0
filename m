Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OcWHv-0005Cj-W2
	for kexec@lists.infradead.org; Sat, 24 Jul 2010 04:24:40 +0000
Date: Sat, 24 Jul 2010 13:24:35 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec for powerpc mpc83xx processors
Message-ID: <20100724042435.GJ6446@verge.net.au>
References: <AANLkTin0h-QftwCqLl0Yn7pi_JWlewC_VWSl01IPPwp-@mail.gmail.com>
	<1278948593.9525.3.camel@localhost>
	<20100713025819.GA23313@verge.net.au>
	<AANLkTimEjIx1lh7YJHg7-WeKZYNFYve73vl8k_C5KvAR@mail.gmail.com>
	<1279292915.4556.0.camel@localhost>
	<AANLkTikGM3wFFUYDLOvrG65FtsJseYwnbGRh62e95j6E@mail.gmail.com>
	<1279913113.22023.11.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1279913113.22023.11.camel@localhost>
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
To: Matthew McClintock <msm@freescale.com>
Cc: krish <radhakrishna.p@gmail.com>, kexec@lists.infradead.org

On Fri, Jul 23, 2010 at 02:25:13PM -0500, Matthew McClintock wrote:
> On Fri, 2010-07-23 at 15:34 +0530, krish wrote:
> > Hello Matthew,
> > 
> > Now, i am able to execute kexec successfully on mpc83xx platforms.
> > Thanks for your support.
> > 
> > But, My requirement is as follows:
> > The kexec always loads kernel and dtb images in to memory and starts
> > the new kernel loaded. But, I want to start the same kernel every
> > time.
> 
> You mean you don't want to load a new kernel you just want to reboot the
> current kernel in place? I don't think that is possible nor an small
> task.

That would be a new feature for kexec, not just a fix for powerpc.
And I also suspect it would be difficult to achieve. Certainly more
difficult than having the image lying around and giving that to kexec.

> > I am not sure whether i can post this message to kexec-mailing list,
> > If required i will add kexec-mailing list in CC. 
> 
> Generally, it's always best to post to the list as it will get you the
> most responses.

Yes :-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
