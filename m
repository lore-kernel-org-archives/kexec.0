From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 20 Sep 2007 18:41:06 -0700
Subject: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump
In-Reply-To: <200709211120.00448.ncunningham@crca.org.au>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211024.35991.nigel@nigel.suspend2.net>
	<20070920180623.5d7da7b9.akpm@linux-foundation.org>
	<200709211120.00448.ncunningham@crca.org.au>
Message-ID: <20070920184106.79e1858a.akpm@linux-foundation.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, 21 Sep 2007 11:19:59 +1000 Nigel Cunningham <ncunningham@crca.org.au> wrote:

> Hi.
> 
> On Friday 21 September 2007 11:06:23 Andrew Morton wrote:
> > On Fri, 21 Sep 2007 10:24:34 +1000 Nigel Cunningham 
> <nigel@nigel.suspend2.net> wrote:
> > 
> > > Hi Andrew.
> > > 
> > > On Thursday 20 September 2007 20:09:41 Pavel Machek wrote:
> > > > Seems like good enough for -mm to me.
> > > > 
> > > > 									Pavel
> > > 
> > > Andrew, if I recall correctly, you said a while ago that you didn't want 
> > > another hibernation implementation in the vanilla kernel. If you're going 
> to 
> > > consider merging this kexec code, will you also please consider merging 
> > > TuxOnIce?
> > > 
> > 
> > The theory is that kexec-based hibernation will mainly use preexisting
> > kexec code and will permit us to delete the existing hibernation
> > implementation.
> > 
> > That's different from replacing it.
> 
> TuxOnIce doesn't remove the existing implementation either. It can 
> transparently replace it, but you can enable/disable that at compile time.

Right.  So we end up with two implementations in-tree.  Whereas
kexec-based-hibernation leads us to having zero implementations in-tree.

See, it's different.

