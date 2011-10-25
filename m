Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RIiwD-0002QG-Qi
	for kexec@lists.infradead.org; Tue, 25 Oct 2011 15:29:14 +0000
Date: Tue, 25 Oct 2011 11:28:57 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: kdump: crash_kexec()-smp_send_stop() race in panic
Message-ID: <20111025152857.GX3452@redhat.com>
References: <1319468137.3615.16.camel@br98xy6r>
	<m1ipneifqv.fsf@fess.ebiederm.org>
	<CAM_iQpVktWsgOFCWoT47dQ1YdSTnnbTZAAKNYEEX=5wWzhHMzg@mail.gmail.com>
	<m1aa8qfhdk.fsf@fess.ebiederm.org>
	<1319532245.3056.5.camel@br98xy6r>
	<m17h3tcm52.fsf@fess.ebiederm.org>
	<1319554699.3056.11.camel@br98xy6r>
	<20111025150830.GG23292@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111025150830.GG23292@redhat.com>
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
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, akpm@linux-foundation.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>

On Tue, Oct 25, 2011 at 11:08:30AM -0400, Vivek Goyal wrote:
> On Tue, Oct 25, 2011 at 04:58:19PM +0200, Michael Holzheu wrote:
> > On Tue, 2011-10-25 at 05:04 -0700, Eric W. Biederman wrote:
> > > Michael Holzheu <holzheu@linux.vnet.ibm.com> writes:
> > > 
> > > > Hello Eric,
> > > >
> > > > On Mon, 2011-10-24 at 10:07 -0700, Eric W. Biederman wrote:
> > > >
> > > > [snip]
> > > >
> > > >> So my second thought is to introduce another atomic variable
> > > >> panic_in_progress, visible only in panic.  The cpu that sets
> > > >> increments panic_in_progress can call smp_send_stop.  The rest of
> > > >> the cpus can just go into a busy wait.  That should stop nasty
> > > >> fights about who is going to come out of smp_send_stop first.
> > > >
> > > > So this is a spinlock, no? What about the following patch:
> > > Do we want both panic printks?
> > 
> > Ok, good point. We proably should not change that.
> > 
> > > We really only need the mutual exclusion starting just before
> > > smp_send_stop so that is where I would be inclined to put it.
> > 
> > I think to fix the race, at least we have the get the lock before we
> > call crash_kexec(). 
> > 
> > Is the following patch ok for you?
> > ---
> >  kernel/panic.c |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -59,6 +59,7 @@ EXPORT_SYMBOL(panic_blink);
> >   */
> >  NORET_TYPE void panic(const char * fmt, ...)
> >  {
> > +	static DEFINE_SPINLOCK(panic_lock);
> >  	static char buf[1024];
> >  	va_list args;
> >  	long i, i_next = 0;
> > @@ -82,6 +83,13 @@ NORET_TYPE void panic(const char * fmt,
> >  #endif
> >  
> >  	/*
> > +	 * Only one CPU is allowed to execute the panic code from here. For
> > +	 * multiple parallel invocations of panic all other CPUs will wait on
> > +	 * the panic_lock. They are stopped afterwards by smp_send_stop().
> > +	 */
> > +	spin_lock(&panic_lock);
> 
> Why leave irqs enabled?
> 
> Atleast for x86, Don Zickus had a patch to use NMI in smp_send_stop(). So
> that should work even if interrupts are disabled. (I think that patch is
> not merged yet).
> 
> So are other architectures a concern? If yes, then may be in future we
> can make it an arch call which can also choose to disable interrupts.
> 
> CCing Don also. This lock also brings in the serialization required for
> panic notifier list and kmsg_dump() infrastructure.

This serializes panics, for kmsg_dump we wanted to serialize the shutdown
path, IOW stop all the cpus realiably.  This patch solves a different
problem.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
