Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vms042pub.verizon.net ([206.46.252.42])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K6LaL-0004Bo-NA
	for kexec@lists.infradead.org; Wed, 11 Jun 2008 08:21:37 +0000
Received: from localhost.localdomain ([72.93.254.151])
	by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0K2A00780HVQ48R2@vms042.mailsrvcs.net> for
	kexec@lists.infradead.org; Wed, 11 Jun 2008 03:21:27 -0500 (CDT)
Date: Wed, 11 Jun 2008 04:21:23 -0400 (EDT)
From: Len Brown <lenb@kernel.org>
Subject: Re: [linux-pm] [PATCH -mm 2/2] kexec jump -v11: save/restore device
	state
In-reply-to: <1213146074.21923.10.camel@caritas-dev.intel.com>
Message-id: <alpine.LFD.1.10.0806110418370.4233@localhost.localdomain>
MIME-version: 1.0
References: <1213082106.22608.30.camel@caritas-dev.intel.com>
	<alpine.LFD.1.10.0806101400090.14381@localhost.localdomain>
	<1213146074.21923.10.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>



On Wed, 11 Jun 2008, Huang, Ying wrote:

> On Tue, 2008-06-10 at 14:01 -0400, Len Brown wrote:
> > 
> > On Tue, 10 Jun 2008, Huang, Ying wrote:
> > 
> > > This patch implements devices state save/restore before after kexec.
> > > 
> > > 
> > > This patch together with features in kexec_jump patch can be used for
> > > following:
> > > 
> > > - A simple hibernation implementation without ACPI support. You can
> > >   kexec a hibernating kernel, save the memory image of original system
> > >   and shutdown the system. When resuming, you restore the memory image
> > >   of original system via ordinary kexec load then jump back.
> > 
> > What part of ACPI's role in hibernation are you trying to avoid
> > 1. enabling wake devices
> > 2. removing power from the system
> > 3. something else?
> 
> ACPI S5 is used instead of S4 for this simple hibernation
> implementation. That is, before creating the hibernation image, the ACPI
> _PTS is not executed, devices are not put into low power state and wake
> devices are not enabled. After creating the hibernation image, the image
> is saved to disk and system is shutdown (go to S5). When resuming from
> hibernated image, ACPI _BFS and _WAK are not executed too.

Doesn't that resume the devices and their drivers into an unknown state?

-Len


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
