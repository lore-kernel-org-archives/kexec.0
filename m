Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RIiSO-00028N-A0
	for kexec@lists.infradead.org; Tue, 25 Oct 2011 14:58:25 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9PEwLc1027610
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 14:58:21 GMT
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p9PEwK7C2478174
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 15:58:20 +0100
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p9PEwJnI023353
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 08:58:20 -0600
Message-ID: <1319554699.3056.11.camel@br98xy6r>
Subject: Re: kdump: crash_kexec()-smp_send_stop() race in panic
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Tue, 25 Oct 2011 16:58:19 +0200
In-Reply-To: <m17h3tcm52.fsf@fess.ebiederm.org>
References: <1319468137.3615.16.camel@br98xy6r>
	<m1ipneifqv.fsf@fess.ebiederm.org>
	<CAM_iQpVktWsgOFCWoT47dQ1YdSTnnbTZAAKNYEEX=5wWzhHMzg@mail.gmail.com>
	<m1aa8qfhdk.fsf@fess.ebiederm.org> <1319532245.3056.5.camel@br98xy6r>
	<m17h3tcm52.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Tue, 2011-10-25 at 05:04 -0700, Eric W. Biederman wrote:
> Michael Holzheu <holzheu@linux.vnet.ibm.com> writes:
> 
> > Hello Eric,
> >
> > On Mon, 2011-10-24 at 10:07 -0700, Eric W. Biederman wrote:
> >
> > [snip]
> >
> >> So my second thought is to introduce another atomic variable
> >> panic_in_progress, visible only in panic.  The cpu that sets
> >> increments panic_in_progress can call smp_send_stop.  The rest of
> >> the cpus can just go into a busy wait.  That should stop nasty
> >> fights about who is going to come out of smp_send_stop first.
> >
> > So this is a spinlock, no? What about the following patch:
> Do we want both panic printks?

Ok, good point. We proably should not change that.

> We really only need the mutual exclusion starting just before
> smp_send_stop so that is where I would be inclined to put it.

I think to fix the race, at least we have the get the lock before we
call crash_kexec(). 

Is the following patch ok for you?
---
 kernel/panic.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -59,6 +59,7 @@ EXPORT_SYMBOL(panic_blink);
  */
 NORET_TYPE void panic(const char * fmt, ...)
 {
+	static DEFINE_SPINLOCK(panic_lock);
 	static char buf[1024];
 	va_list args;
 	long i, i_next = 0;
@@ -82,6 +83,13 @@ NORET_TYPE void panic(const char * fmt,
 #endif
 
 	/*
+	 * Only one CPU is allowed to execute the panic code from here. For
+	 * multiple parallel invocations of panic all other CPUs will wait on
+	 * the panic_lock. They are stopped afterwards by smp_send_stop().
+	 */
+	spin_lock(&panic_lock);
+
+	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
 	 * everything else.
 	 * Do we want to call this before we try to display a message?



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
