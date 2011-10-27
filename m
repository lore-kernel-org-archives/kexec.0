Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJKR4-0007WK-TR
	for kexec@lists.infradead.org; Thu, 27 Oct 2011 07:31:35 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9R7V0bw004588
	for <kexec@lists.infradead.org>; Thu, 27 Oct 2011 07:31:00 GMT
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
	[9.149.37.252])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p9R7V0hX2498742
	for <kexec@lists.infradead.org>; Thu, 27 Oct 2011 08:31:00 +0100
Received: from d06av11.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av11.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p9R7Uxng029645
	for <kexec@lists.infradead.org>; Thu, 27 Oct 2011 01:30:59 -0600
Date: Thu, 27 Oct 2011 09:30:58 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: kdump: No udev events for memory hotplug?
Message-ID: <20111027073058.GA2422@osiris.boeblingen.de.ibm.com>
References: <1319645292.3321.24.camel@br98xy6r>
	<20111026192449.GE355@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111026192449.GE355@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Kay Sievers <kay.sievers@vrfy.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>

On Wed, Oct 26, 2011 at 03:24:49PM -0400, Vivek Goyal wrote:
> On Wed, Oct 26, 2011 at 06:08:12PM +0200, Michael Holzheu wrote:
> > Hello Vivek and Eric,
> > 
> > I noticed that on my system kernel 3.1 *no* udev events for memory
> > hotplug are generated. Same on my RHEL6.1.
> > 
> > # udevadm monitor
> > # echo offline > /sys/devices/system/memory/memory4/state
> > 
> > -> No event
> > 
> > But we need the udev events in order to do a kdump reload for setting up
> > the ELF loads correctly.
> > 
> > In my /etc/udev/rules.d/98-kexec.rules there are rules for memory
> > hotplug:
> > 
> > SUBSYSTEM=="memory", ACTION=="add", PROGRAM="/etc/init.d/kdump restart"
> > SUBSYSTEM=="memory", ACTION=="remove", PROGRAM="/etc/init.d/kdump
> > restart"
> > 
> > Perhaps/probably I am missing something?
> 
> I don't know. Sounds like a bug. I have never looked into it. CCing Kay,
> if he has any thoughts.
> 
> Are any events generated for memory add?

Looks like uevents are only genereted when memory gets registered and
unregistered, but not when when it gets set online or offline.
To achieve that you would need to add similar code to
store_mem_state()/memory_block_change_state() in drivers/base/memory.c
like we have it already in store_online() in drivers/base/cpu.c

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
