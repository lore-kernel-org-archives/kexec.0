Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xenotime.net ([66.160.160.81])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IPLXV-00021P-KX
	for kexec@lists.infradead.org; Sun, 26 Aug 2007 13:04:46 -0400
Received: from midway.site ([96.225.192.201]) by xenotime.net for
	<kexec@lists.infradead.org>; Sun, 26 Aug 2007 10:04:31 -0700
Date: Sun, 26 Aug 2007 10:04:31 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: kexec+kdump + vmcoreinfo patch
Message-Id: <20070826100431.e36f92e7.rdunlap@xenotime.net>
In-Reply-To: <20070826132305.GA15555@hmsendeavour.rdu.redhat.com>
References: <20070824144147.5e1cadc2.rdunlap@xenotime.net>
	<20070824170139.021be621.rdunlap@xenotime.net>
	<20070826132305.GA15555@hmsendeavour.rdu.redhat.com>
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
Cc: kexec@lists.infradead.org

On Sun, 26 Aug 2007 09:23:05 -0400 Neil Horman wrote:

> On Fri, Aug 24, 2007 at 05:01:39PM -0700, Randy Dunlap wrote:
> > On Fri, 24 Aug 2007 14:41:47 -0700 Randy Dunlap wrote:
> > 
> > > Hi,
> > > 
> > > I'm trying to use the recent vmcoreinfo patch...
> > 
> > > c.  My 2.6.23-rc3 dump-capture kernel currently faults a few times,
> > > then it panics.  I'll add a serial console and capture its output
> > > to see what is going on.
> > 
> > I booted 3 times with no problems (without serial console on the
> > dump-capture kernel), then I added a serial console to that kernel
> > and got lots of problems.  They all seem to be OOM problems, then
> > the kernel gives up and falls over.  (log attached)
> > 
> haven't looked at your log yet, but how much memory are you passing in your
> crashkernel parameter in your first kernel boot?  Nominally 64MB is the minimum
> recommended for most kernel configurations

Hi Neil,

crashkernel=64M@16M


> Regards
> Neil
> 
> > 
> > d.  Documentation/kdump/kdump.txt mentions an option to produce
> > ELF32 headers instead of 64-bit headers:  --elf32-core-headers.
> > Where is this option used?  I.e., what program recognizes it?
> > kdump.txt isn't telling me this info and I can't read it between
> > the lines.


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
