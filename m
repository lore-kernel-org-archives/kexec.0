Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J0eMo-0005WD-DL
	for kexec@lists.infradead.org; Fri, 07 Dec 2007 14:39:57 +0000
Date: Fri, 7 Dec 2007 09:39:44 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on
	boot cpu
Message-ID: <20071207143944.GF2863@redhat.com>
References: <474CA733.9050908@redhat.com> <20071128153649.GC3192@redhat.com>
	<20071128160206.GA21286@hmsendeavour.rdu.redhat.com>
	<20071128190525.GD3192@redhat.com> <474F7177.7050306@redhat.com>
	<20071130144250.GC23810@redhat.com>
	<20071130145131.GB5822@hmsendeavour.rdu.redhat.com>
	<20071206213951.GB28898@hmsreliant.think-freely.org>
	<20071206221143.GC2863@redhat.com>
	<20071207001023.GA7312@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071207001023.GA7312@hmsendeavour.rdu.redhat.com>
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
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, Dec 06, 2007 at 07:10:23PM -0500, Neil Horman wrote:
> On Thu, Dec 06, 2007 at 05:11:43PM -0500, Vivek Goyal wrote:
> > On Thu, Dec 06, 2007 at 04:39:51PM -0500, Neil Horman wrote:
> > > On Fri, Nov 30, 2007 at 09:51:31AM -0500, Neil Horman wrote:
> > > > On Fri, Nov 30, 2007 at 09:42:50AM -0500, Vivek Goyal wrote:
> > > <snip>
> > > > 
> > > > Thats what I'm doing at the moment.  I'm working on a RHEL5 patch at the moment
> > > > (since thats whats on the production system thats failing), and will forward
> > > > port it once its working
> > > > 
> > > > And not to split hairs, but techically thats not our _only_ choice.  We could
> > > > force kdump boots on cpu0 as well ;)
> > > > 
> > > > Thanks
> > > > Neil
> > > > 
> > > > > Thanks
> > > > > Vivek
> > > > 
> > > 
> > > 
> > > Sorry to have been quiet on this issue for a few days. Interesting news to
> > > report, though.  So I was working on a patch to do early apic enabling on
> > > x86_64, and had something working for the old 2.6.18 kernel that we were
> > > origionally testing on.  Unfortunately while it worked on 2.6.18 it failed
> > > miserably on 2.6.24-rc3-mm2, causing check_timer to consistently report that the
> > > timer interrupt wasn't getting received (even though we could successfully run
> > > calibrate_delay).  Vivek and I were digging into this, when I ran accross the
> > > description of the hypertransport configuration register in the opteron
> > > specification.  It contains a bit that, suprise, configures the ht bus to either
> > > unicast interrupts delivered accross the ht bus to a single cpu, or to broadcast
> > > it to all cpus.  Since it seemed more likely that the 8259 in the nvidia
> > > southbridge was transporting legacy mode interrupts over the ht bus than
> > > directly to cpu0 via an actual wire, I wrote the attached patch to add a quirk
> > > for nvidia chipsets, which scanned for hypertransport controllers, and ensured
> > > that that broadcast bit was set.  Test results indicate that this solves the
> > > problem, and kdump kernels boot just fine on the affected system.
> > > 
> > 
> > Hi Neil,
> > 
> > Should we disable this broadcasting feature once we are through? Otherwise
> > in normal systems it might mean extra traffic on hypertransport. There
> > is no need for every interrupt to be broadcasted in normal systems?
> > 
> > Thanks
> > Vivek
> 
> No, I don't think thats necessecary.  Once the apics are enabled, interrupts
> shouldn't travel accross the hypertransport bus anyway, opting instead to use
> the dedicated apic bus (at least thats my understanding).

I think all interrupt message travel on hypertransport. Even after APICS
have been enabled.

Look at the following document.

http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/24674.pdf

Have a look at figure 1, figure 2 and section 3.4.2.2 and 3.4.2.3

That's a different thing that once IOAPIC has formed the vectored message,
Hypertransport might not touch the destination field.
 
Having said that, I am wondering what will happen if a system continues
to operate the timer through IOAPIC in ExtInt mode. Will hypertransport
keep on broadcasting that interrupt to every cpu? And every cpu will 
process that interrupt.

Hence, I feel it is safe to restore the broadcast bit back to BIOS value once
we are through calibrate_delay().

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
