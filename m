Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xenotime.net ([66.160.160.81])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IPiwg-0007x1-EK
	for kexec@lists.infradead.org; Mon, 27 Aug 2007 14:04:18 -0400
Received: from midway.site ([96.225.192.201]) by xenotime.net for
	<kexec@lists.infradead.org>; Mon, 27 Aug 2007 11:04:09 -0700
Date: Mon, 27 Aug 2007 11:04:08 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: kexec+kdump + vmcoreinfo patch
Message-Id: <20070827110408.fb21e933.rdunlap@xenotime.net>
In-Reply-To: <20070827175557.GH20548@hmsendeavour.rdu.redhat.com>
References: <20070824144147.5e1cadc2.rdunlap@xenotime.net>
	<20070824170139.021be621.rdunlap@xenotime.net>
	<20070826132305.GA15555@hmsendeavour.rdu.redhat.com>
	<20070826100431.e36f92e7.rdunlap@xenotime.net>
	<20070827165538.GE20548@hmsendeavour.rdu.redhat.com>
	<20070827170253.GE27516@redhat.com>
	<20070827102827.5c5dcc53.rdunlap@xenotime.net>
	<20070827175557.GH20548@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
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
To: Neil Horman <nhorman@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>, kexec@lists.infradead.org

On Mon, 27 Aug 2007 13:55:57 -0400 Neil Horman wrote:

> On Mon, Aug 27, 2007 at 10:28:27AM -0700, Randy Dunlap wrote:
> > On Mon, 27 Aug 2007 13:02:53 -0400 Don Zickus wrote:
> > 
> > > On Mon, Aug 27, 2007 at 12:55:38PM -0400, Neil Horman wrote:
> > > > > crashkernel=64M@16M
> > > > > 
> > > > Hmm, well that should be enough.  looking at your log, it appears as though you
> > > > have a 512k chunk allocatable, which should seem sufficient to go on a little
> > > > longer.  The fact that your not seems to indicate that you are allocating a
> > > > suspiciously large single chunk of ram.  I'd configure your initramfs to drop to
> > > > a shell prompt before it sets up lp0.  Then you can step through the actions of
> > > > the init script and monitor the contents of /proc/slabinfo to get an idea of
> > > > whats eating up all your lowmem prior to the oom kill.
> > > > 
> > > > Neil
> > > > 
> > > 
> > > <snipped from Randy's output>
> > > 
> > > Out of memory: kill process 680 (boot) score 309 or a child
> > > Killed process 701 (S01boot.udev)
> > > 
> > > Heh, it's udev again.  What a surprise! </sarcasm>
> > 
> > Right, that's hardly a surprise.  :(
> > 
> > > Neil, didn't we solve this with an init 1 or something (ignoring the whole
> > > busybox thing).
> > 
> > I was trying to boot to runlevel 3.  I can just boot to runlevel 1
> > for a workaround (I think).
> > 
> Don is correct.  If we don't capture a dump from the initramfs, I mount the root
> fs and run init.  We do wind up booting to Run Level 3, but the kdump script
> runs early enough that I don't think udevd has a chance to start, and after we
> capture a dump we immediately reboot, so I wouldn't expect to see any udevd
> problems here.

I see.  Thanks again.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
