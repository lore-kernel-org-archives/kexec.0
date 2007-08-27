Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IPhsM-0007EW-0I
	for kexec@lists.infradead.org; Mon, 27 Aug 2007 12:55:44 -0400
Date: Mon, 27 Aug 2007 12:55:38 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kexec+kdump + vmcoreinfo patch
Message-ID: <20070827165538.GE20548@hmsendeavour.rdu.redhat.com>
References: <20070824144147.5e1cadc2.rdunlap@xenotime.net>
	<20070824170139.021be621.rdunlap@xenotime.net>
	<20070826132305.GA15555@hmsendeavour.rdu.redhat.com>
	<20070826100431.e36f92e7.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070826100431.e36f92e7.rdunlap@xenotime.net>
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
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org

On Sun, Aug 26, 2007 at 10:04:31AM -0700, Randy Dunlap wrote:
> On Sun, 26 Aug 2007 09:23:05 -0400 Neil Horman wrote:
> 
> > On Fri, Aug 24, 2007 at 05:01:39PM -0700, Randy Dunlap wrote:
> > > On Fri, 24 Aug 2007 14:41:47 -0700 Randy Dunlap wrote:
> > > 
> > > > Hi,
> > > > 
> > > > I'm trying to use the recent vmcoreinfo patch...
> > > 
> > > > c.  My 2.6.23-rc3 dump-capture kernel currently faults a few times,
> > > > then it panics.  I'll add a serial console and capture its output
> > > > to see what is going on.
> > > 
> > > I booted 3 times with no problems (without serial console on the
> > > dump-capture kernel), then I added a serial console to that kernel
> > > and got lots of problems.  They all seem to be OOM problems, then
> > > the kernel gives up and falls over.  (log attached)
> > > 
> > haven't looked at your log yet, but how much memory are you passing in your
> > crashkernel parameter in your first kernel boot?  Nominally 64MB is the minimum
> > recommended for most kernel configurations
> 
> Hi Neil,
> 
> crashkernel=64M@16M
> 
Hmm, well that should be enough.  looking at your log, it appears as though you
have a 512k chunk allocatable, which should seem sufficient to go on a little
longer.  The fact that your not seems to indicate that you are allocating a
suspiciously large single chunk of ram.  I'd configure your initramfs to drop to
a shell prompt before it sets up lp0.  Then you can step through the actions of
the init script and monitor the contents of /proc/slabinfo to get an idea of
whats eating up all your lowmem prior to the oom kill.

Neil


> 
> > Regards
> > Neil
> > 
> > > 
> > > d.  Documentation/kdump/kdump.txt mentions an option to produce
> > > ELF32 headers instead of 64-bit headers:  --elf32-core-headers.
> > > Where is this option used?  I.e., what program recognizes it?
> > > kdump.txt isn't telling me this info and I can't read it between
> > > the lines.
> 
> 
> ---
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your code ***

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
