Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KKws2-0006Op-49
	for kexec@lists.infradead.org; Mon, 21 Jul 2008 15:00:14 +0000
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 754FC41A78
	for <kexec@lists.infradead.org>; Mon, 21 Jul 2008 17:00:12 +0200 (CEST)
Date: Mon, 21 Jul 2008 17:00:54 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: linux-next: Tree for July 18: warning at kernel/lockdep.c:2068
	trace_hardirqs_on_caller
Message-ID: <20080721170054.3283b6cc@halley.suse.de>
In-Reply-To: <20080721145417.GE4451@redhat.com>
References: <20080719221723.GB5578@suse.de>
	<19f34abd0807191527u61c5ed61kffe2279c8d46915d@mail.gmail.com>
	<19f34abd0807191544nfd73be5nf7dde4b61992a7e8@mail.gmail.com>
	<20080719225817.GA6264@suse.de>
	<19f34abd0807191611y7cabf405iad307ba79591e04f@mail.gmail.com>
	<1216544462.9311.20.camel@nimitz>
	<20080721131721.GB4451@redhat.com>
	<20080721152539.3d8684f9@halley.suse.de>
	<20080721133937.GC4451@redhat.com>
	<20080721154733.07a116ad@halley.suse.de>
	<20080721145417.GE4451@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

* Vivek Goyal [2008-07-21 10:54]:
>
> On Mon, Jul 21, 2008 at 03:47:33PM +0200, Bernhard Walle wrote:
> > * Vivek Goyal [2008-07-21 09:39]:
> > > 
> > > But the point is, if /sys/devices/system/memory also represents all
> > > the physical memory present in the system then it might be not be
> > > justified to create another similar interface. (Until and unless there
> > > is something unique about /sys/firmware/memmap).
> > 
> > But I don't see anything like a physical address there:
> > 
> >   /sys/devices/system/memory/memory2:
> >   -r--r--r-- 1 root root 4096 2008-07-21 15:45 phys_device
> >   -r--r--r-- 1 root root 4096 2008-07-21 15:45 phys_index
> >   -rw-r--r-- 1 root root 4096 2008-07-21 15:45 state
> > 
> > (on a PPC64 machine where SUSE kernel has that interface enabled by
> > default).
> > 
> > 
> Do you want to respond to lkml and to dave hansen so that he can respond
> back. In this mail only kexec mailing list is there.

Group reply vs. reply. Thanks for noticing. :)



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
