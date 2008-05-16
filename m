Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jwp4M-0005VC-VB
	for kexec@lists.infradead.org; Fri, 16 May 2008 01:49:15 +0000
Subject: Re: [PATCH -mm] kexec jump -v9
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <m1skwjghen.fsf@frodo.ebiederm.org>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
	<1210830110.23707.141.camel@caritas-dev.intel.com>
	<20080516005121.GA6926@redhat.com> <m1skwjghen.fsf@frodo.ebiederm.org>
Date: Fri, 16 May 2008 09:55:02 +0800
Message-ID: <1210902902.23707.164.camel@caritas-dev.intel.com>
MIME-Version: 1.0
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Thu, 2008-05-15 at 18:35 -0700, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > ioapic_suspend() is not putting APICs in Legacy mode and that's why
> > we are seeing the issue. It only saves the IOAPIC routing table entries
> > and these entries are restored during ioapic_resume().
> >
> > But I think somebody has to put APICs in legacy mode for normal 
> > hibernation also. Not sure who does it. May be BIOS, so that during
> > resume, second kernel can get the timer interrupts.
> 
> I doubt anything cares in the suspend to ram case. There should just
> be a small BIOS trampoline to get back to linux when the processor
> restarts.  And you don't need interrupts for any of that. 

As far as I know, in suspend to ram, interrupt is used as waking up
event, such as, keyboard interrupt.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
