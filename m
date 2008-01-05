Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JBETe-0002Rd-Vs
	for kexec@lists.infradead.org; Sat, 05 Jan 2008 19:14:45 +0000
Date: Sat, 5 Jan 2008 14:14:36 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kdump from x86_64 using i386 capture kernel
Message-ID: <20080105191436.GA14123@hmsendeavour.rdu.redhat.com>
References: <200801041346.38120.stf_xl@wp.pl> <200801041600.26866.stf_xl@wp.pl>
	<20080104154931.GA8804@hmsendeavour.rdu.redhat.com>
	<200801051152.53550.stf_xl@wp.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200801051152.53550.stf_xl@wp.pl>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org

On Sat, Jan 05, 2008 at 11:52:53AM +0100, Stanislaw Gruszka wrote:
> On Friday 04 January 2008 16:49, Neil Horman wrote:
> > On Fri, Jan 04, 2008 at 04:00:26PM +0100, Stanislaw Gruszka wrote:
> > > On Friday 04 January 2008 14:55, Neil Horman wrote:
> > > > > It is possible to achieve valid vmcore when first is x86_64 and capture 
> > > > > is i386 ?
> > > > Possible I think, but not reliable.  If oldmem has regions to capture above the
> > > > 4GB range, a 386 kernel won't be able to access those addresses, and as such,
> > > > you won't get a complete vmcore.
> > > Uffff, I missed this fact. 
> > > 
> > > > I'm also confused about what exactly you are trying to accomplish.  Why are you
> > > > trying to use an x86 kernel to capture a x86_64 vmcore?  The available
> > > System load from flash and there is limited space. I tried to do one capture
> > > kernel, but see this was bad idea. I will scarify another 2MB and make separate
> > > image for x86_64. 
> > > 
> > 
> > I'm still not quite understanding, the kernel image that you used to initally
> > boot the box should be suitable for loading as the kdump image.  Even if you're
> > using i386 instead of x86_64 as your kdump kernel, you still need to maintain
> > two images.
> Turn on CONFIG_RELOCATABLE and using same kernel for work and capture is 
> the best for size requirement. However size is not only one requirement, I need 
> to capture kernel work reliably. RELOCATABLE is masked as experimental, so
> I like to avoid it. Additionally, if I use same kernel for capture, it could
> have same bugs and crash too during start up. So I decided to use separate
> 2.6.16.y kernel for capture. This version, maintained by Adrian Bunk, have many
> bug fixes and I think is very stable. Kernel config is different too, I do not only
> remove device drivers and modules, but also hardcoded things from Process Type
> and Features, Power Management and so on ... , just enough to boot and setup
> network with minimal probability of crash.
> 


I understand your concerns, but Just so that you know, we've been using
CONFIG_RELOCATABLE in RHEL5 for some time now, without issue (at least not as it
relates to the relocatable feature).  While its true that, if a kernel crashes
during boot up, it is like to crash again during kdump boot up, the inverse is
also true.  Once you have a reasonably stable system that boots reliably, you
can expect the kdump kernel to boot reliably as well.  Turning off
relocatability won't help with that (unless the problem specifically relates to
the relocatable code) (i.e. if you have an issue with in insmodding of a network
driver), it will crash on normal boot and kdump kernel boot, regadless of
weather its relocatable or not).


Neil

> Stanislaw Gruszka

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
