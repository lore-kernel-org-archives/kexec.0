From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 20 Sep 2007 21:16:27 -0700
Subject: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump
In-Reply-To: <200709211157.28622.nigel@nigel.suspend2.net>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211120.00448.ncunningham@crca.org.au>
	<20070920184106.79e1858a.akpm@linux-foundation.org>
	<200709211157.28622.nigel@nigel.suspend2.net>
Message-ID: <20070920211627.d18f97f9.akpm@linux-foundation.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, 21 Sep 2007 11:57:26 +1000 Nigel Cunningham <nigel@nigel.suspend2.net> wrote:

> Hi.
> 
> On Friday 21 September 2007 11:41:06 Andrew Morton wrote:
> > > On Friday 21 September 2007 11:06:23 Andrew Morton wrote:
> > > > On Fri, 21 Sep 2007 10:24:34 +1000 Nigel Cunningham 
> > > <nigel@nigel.suspend2.net> wrote:
> > > > 
> > > > > Hi Andrew.
> > > > > 
> > > > > On Thursday 20 September 2007 20:09:41 Pavel Machek wrote:
> > > > > > Seems like good enough for -mm to me.
> > > > > > 
> > > > > > 									Pavel
> > > > > 
> > > > > Andrew, if I recall correctly, you said a while ago that you didn't 
> want 
> > > > > another hibernation implementation in the vanilla kernel. If you're 
> going 
> > > to 
> > > > > consider merging this kexec code, will you also please consider 
> merging 
> > > > > TuxOnIce?
> > > > > 
> > > > 
> > > > The theory is that kexec-based hibernation will mainly use preexisting
> > > > kexec code and will permit us to delete the existing hibernation
> > > > implementation.
> > > > 
> > > > That's different from replacing it.
> > > 
> > > TuxOnIce doesn't remove the existing implementation either. It can 
> > > transparently replace it, but you can enable/disable that at compile time.
> > 
> > Right.  So we end up with two implementations in-tree.  Whereas
> > kexec-based-hibernation leads us to having zero implementations in-tree.
> > 
> > See, it's different.
> 
> That's not true. Kexec will itself be an implementation, otherwise you'd end 
> up with people screaming about no hibernation support. And it won't result in 
> the complete removal of the existing hibernation code from the kernel. At the 
> very least, it's going to want the kernel being hibernated to have an 
> interface by which it can find out which pages need to be saved. I wouldn't 
> be surprised if it also ends up with an interface in which the kernel being 
> hibernated tells it what bdev/sectors in which to save the image as well 
> (otherwise you're going to need a dedicated, otherwise untouched partition 
> exclusively for the kexec'd kernel to use), or what network settings to use 
> if it wants to try to save the image to a network storage device. On top of 
> that, there are all the issues related to device reinitialisation and so on, 
> and it looks like there's greatly increased pain for users wanting to 
> configure this new implementation. Kexec is by no means proven to be the 
> panacea for all the issues.
> 

Maybe, maybe not, dunno.  That's why we haven't merged it yet.  If it ends
up being no good, we won't merge it!

