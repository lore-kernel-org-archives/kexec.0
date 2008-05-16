Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwoB2-0002LT-0A
	for kexec@lists.infradead.org; Fri, 16 May 2008 00:52:04 +0000
Date: Thu, 15 May 2008 20:51:21 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Message-ID: <20080516005121.GA6926@redhat.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
	<1210830110.23707.141.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1210830110.23707.141.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

On Thu, May 15, 2008 at 01:41:50PM +0800, Huang, Ying wrote:
> Hi, Vivek,
> 
> On Wed, 2008-05-14 at 16:52 -0400, Vivek Goyal wrote:
> [...]
> > Ok, I have done some testing on this patch. Currently I have just
> > tested switching back and forth between two kernels and it is working for
> > me.
> > 
> > Just that I had to put LAPIC and IOAPIC in legacy mode for it to work. Few
> > comments/questions are inline.
> 
> It seems that for LAPIC and IOAPIC, there is
> lapic_suspend()/lapic_resume() and ioapic_suspend()/ioapic_resume(),
> which will be called before/after kexec jump through
> device_power_down()/device_power_up(). So, the mechanism for
> LAPIC/IOAPIC is there, we may need to check the corresponding
> implementation.
> 

ioapic_suspend() is not putting APICs in Legacy mode and that's why
we are seeing the issue. It only saves the IOAPIC routing table entries
and these entries are restored during ioapic_resume().

But I think somebody has to put APICs in legacy mode for normal 
hibernation also. Not sure who does it. May be BIOS, so that during
resume, second kernel can get the timer interrupts.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
