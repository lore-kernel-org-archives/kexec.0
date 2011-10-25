Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RIivn-0002PT-UH
	for kexec@lists.infradead.org; Tue, 25 Oct 2011 15:28:49 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9PFSjce014807
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 15:28:45 GMT
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p9PFSiql2564156
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 16:28:44 +0100
Received: from d06av07.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p9PFShQt024348
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 09:28:44 -0600
Message-ID: <1319556523.3056.16.camel@br98xy6r>
Subject: Re: kdump: crash_kexec()-smp_send_stop() race in panic
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Tue, 25 Oct 2011 17:28:43 +0200
In-Reply-To: <20111025150830.GG23292@redhat.com>
References: <1319468137.3615.16.camel@br98xy6r>
	<m1ipneifqv.fsf@fess.ebiederm.org>
	<CAM_iQpVktWsgOFCWoT47dQ1YdSTnnbTZAAKNYEEX=5wWzhHMzg@mail.gmail.com>
	<m1aa8qfhdk.fsf@fess.ebiederm.org> <1319532245.3056.5.camel@br98xy6r>
	<m17h3tcm52.fsf@fess.ebiederm.org> <1319554699.3056.11.camel@br98xy6r>
	<20111025150830.GG23292@redhat.com>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Cc: Don Zickus <dzickus@redhat.com>, kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, akpm@linux-foundation.org

On Tue, 2011-10-25 at 11:08 -0400, Vivek Goyal wrote:
> On Tue, Oct 25, 2011 at 04:58:19PM +0200, Michael Holzheu wrote:
> > On Tue, 2011-10-25 at 05:04 -0700, Eric W. Biederman wrote:
> > > Michael Holzheu <holzheu@linux.vnet.ibm.com> writes:
[snip]
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

For s390 we could disable the interrupts here. smp_send_stop() works
also when IRQs are disabled. But as you said - who knows if that is true
on all architectures...

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
