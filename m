Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9kAh-0002s0-NS
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 22:03:36 +0000
Date: Fri, 7 Sep 2012 07:03:29 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC PATCH 0/4]  Add device-tree support to kexec-tools for ARM
Message-ID: <20120906220329.GB10174@verge.net.au>
References: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
 <20120905123850.GA11453@verge.net.au>
 <000001cd8b73$82e6b4f0$88b41ed0$@leach@arm.com>
 <20120906032901.GG6432@verge.net.au>
 <20120906090128.GA858@mudshark.cambridge.arm.com>
 <20120906090914.GA8673@verge.net.au>
 <20120906091406.GC858@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120906091406.GC858@mudshark.cambridge.arm.com>
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
To: Will Deacon <will.deacon@arm.com>
Cc: Matthew Leach <Matthew.Leach@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, Sep 06, 2012 at 10:14:06AM +0100, Will Deacon wrote:
> On Thu, Sep 06, 2012 at 10:09:14AM +0100, Simon Horman wrote:
> > Hi Will,
> > 
> > On Thu, Sep 06, 2012 at 10:01:28AM +0100, Will Deacon wrote:
> > > Hi guys,
> > > 
> > > On Thu, Sep 06, 2012 at 04:29:02AM +0100, Simon Horman wrote:
> > > > On Wed, Sep 05, 2012 at 03:34:09PM +0100, Matthew Leach wrote:
> > > > > Also, I use a
> > > > > different segment for the dtb rather than appending it to the
> > > > > zImage; I think this approach would be better as it is less
> > > > > restrictive, however a kernel patch is required to set r2 to the
> > > > > appropriate address on entry to the new kernel. What are your
> > > > > thoughts?
> > > > 
> > > > I would prefer to avoid requiring kernel changes unless necessary -
> > > > the kernels some of the boards I work with require DT since 3.5.
> > > > However, I am happy to discuss this further, there certainly is
> > > > merit to a clean implementation.
> > > 
> > > I had a quick look at both the approaches and it looks like Matthew requires
> > > changes to the host kernel (to load the dtb correctly) and Simon requires
> > > changes to the target kernel (to pick up the dtb correctly).
> > 
> > Could you explain a little why you feel my patch requires a change to
> > the target kernel?
> 
> Sure, I may be misunderstanding something, so please shout if that's the
> case! Anyway, I was under the impression that you required
> CONFIG_ARM_APPENDED_DTB to be enabled in the target so that it can pick up
> the new DT. If that's not the case, then you'll need to change the host
> kernel to fix up r2 (rather than point it at the KEXEC_ARM_ATAGS_OFFSET,
> which is too small for a dtb).

Thanks. It was not my intention that  CONFIG_ARM_APPENDED_DTB is required,
though due to limitations of the bootloader on the board I was using I did
have that option enabled for the host kernel.

Thanks for pointing out the size issue with using KEXEC_ARM_ATAGS_OFFSET,
I had overlooked that.

I think the best way forward, as both you and Matt suggested earlier,
is to modify the host kernel.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
