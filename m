Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IAnpQ-0003Jm-BG
	for kexec@lists.infradead.org; Tue, 17 Jul 2007 10:15:06 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec
	=?iso-8859-15?q?base=09hibernation?=
Date: Tue, 17 Jul 2007 16:22:52 +0200
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707170101010.19248@asgard.lang.hm>
	<1184676518.10998.34.camel@caritas-dev.intel.com>
In-Reply-To: <1184676518.10998.34.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200707171622.53657.rjw@sisk.pl>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Tuesday, 17 July 2007 14:48, Huang, Ying wrote:
> On Tue, 2007-07-17 at 01:13 -0700, david@lang.hm wrote:
> > however, since the resume designed for ACPI won't work would the following 
> > approach work
> > 
> > 1. boot one kernel
> > 2. setup a kexec the same way you would for hibernate
> > 3. kexec to the new kernel
> > 4. overwrite the memory of the first kernel
> > 5. kexec 'back' to the main kernel that has now been overwritten by what was saved?
> > 
> > as part of this question, when you do a kexec, how does the kernel that 
> > you are doing the kexec to know what to run next?
> 
> For kernel in 3 that do kexec, the devices and CPU state are saved into
> memory before executing the new kernel. So when jumping back, the
> control will continue from kexec point. If the memory image of main
> kernel is restored from disk, the devices and CPU state in memory is
> restored too. Before jumping back in 5, the devices are put in the known
> state, after jumping back, the devices and CPU state is restored. If the
> "kexec -j" is used to trigger the kexec in 3, the system will continue
> with "kexec -j" exiting with exit code 0.
> 
> > it needs to do some initialization first before it starts running normal 
> > things, and at that point it the move back doesn't look for init like a 
> > normal kernel boot (or the system would effectivly boot instead of picking 
> > up where it left off)
> 
> I think the early initialization can be done in a initramfs. At that
> point, the resume image can be checked, the next step depends on the
> result of checking.
> 
> > is this 'restart point' flexible enough that either the pre-hibernate 
> > kerenl or the small hibernate kernel could tell the pre-hibernate kernel 
> > to go into suspend-to-ram mode before doing anything else?
> 
> It is possible for hibernate kernel to pass information back to
> pre-hibernate kernel. For example, the information can be passed in jump
> buffer page. 

I think it would be reasonable to have a protocol defined for passing this
information, so that it's independent of the kernel version etc.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
