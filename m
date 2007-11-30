Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Iy6xu-0004dR-RF
	for kexec@lists.infradead.org; Fri, 30 Nov 2007 14:35:45 +0000
Date: Fri, 30 Nov 2007 09:35:34 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on
	boot cpu
Message-ID: <20071130143534.GB23810@redhat.com>
References: <20071127200011.GA3703@redhat.com>
	<20071127222408.GH24223@one.firstfloor.org>
	<474CA733.9050908@redhat.com> <20071128153649.GC3192@redhat.com>
	<20071128160206.GA21286@hmsendeavour.rdu.redhat.com>
	<20071128190525.GD3192@redhat.com>
	<m1d4tudun5.fsf@ebiederm.dsl.xmission.com>
	<474F7290.8010504@redhat.com>
	<m1sl2oa1ev.fsf@ebiederm.dsl.xmission.com>
	<86802c440711300059tb8bf924i72a9eca29723499f@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86802c440711300059tb8bf924i72a9eca29723499f@mail.gmail.com>
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
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Fri, Nov 30, 2007 at 12:59:26AM -0800, Yinghai Lu wrote:
> On Nov 29, 2007 6:54 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > Ben Woodard <woodard@redhat.com> writes:
> >
> >
> > > Eric W. Biederman wrote:
> > >> Vivek Goyal <vgoyal@redhat.com> writes:
> > >>
> > >>> Ok. Got it. So in this case we route the interrupts directly through LAPIC
> > >>> and put LVT0 in ExtInt mode and IOAPIC is bypassed.
> > >>>
> > >>> I am looking at Intel Multiprocessor specification v1.4 and as per figure
> > >>> 3-3 on page 3-9, 8259 is connected to LINTIN0 line, which in turn is
> > >>> connected to LINTIN0 pin on all processors. If that is the case, even in
> > >>> this mode, all the CPU should see the timer interrupts (which is coming
> > >>> from 8259)?
> > >>
> 
> there is two mode for mcp55. bios should have one option about virtul
> wired to LVT0 of BSP or IOAPIC pin 0.
> or the option like hpet route to ioapic pin 2.
> 

That's interesting. So with BIOS options I can force timer 
interrupts to be routed through IOAPIC? That would enable us to get
timer interrupts on any of the cpus in legacy mode. Ben, can you give it
a try?

> for kdump fix, could enable LVT0 of CPU for kdump and disable that for BSP?

We would not know the crashing cpu in advance hence can't set it. 

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
