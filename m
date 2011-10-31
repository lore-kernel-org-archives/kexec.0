Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RKr4L-0002nI-1H
	for kexec@lists.infradead.org; Mon, 31 Oct 2011 12:34:26 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9VCYLDu011908
	for <kexec@lists.infradead.org>; Mon, 31 Oct 2011 12:34:21 GMT
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
	[9.149.37.217])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p9VCYKKQ1855588
	for <kexec@lists.infradead.org>; Mon, 31 Oct 2011 12:34:20 GMT
Received: from d06av06.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p9VJYK6a013249
	for <kexec@lists.infradead.org>; Mon, 31 Oct 2011 13:34:21 -0600
Message-ID: <1320064459.2796.26.camel@br98xy6r>
Subject: [PATCH v2] kdump: Fix crash_kexec - smp_send_stop race in panic
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Mon, 31 Oct 2011 13:34:19 +0100
In-Reply-To: <20111031033948.a0edb7f3.akpm@linux-foundation.org>
References: <1319639649.3321.11.camel@br98xy6r>
	<20111028161143.e5ebf617.akpm@linux-foundation.org>
	<1320055036.2796.8.camel@br98xy6r>
	<20111031033948.a0edb7f3.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Vivek Goyal <vgoyal@redhat.com>

Hello Andrew, hello linux-arch,

On Mon, 2011-10-31 at 03:39 -0700, Andrew Morton wrote:
> On Mon, 31 Oct 2011 10:57:16 +0100 Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:
> 
> > > Should this be done earlier in the function?  As it stands we'll have
> > > multiple CPUs scribbling on buf[] at the same time and all trying to
> > > print the same thing at the same time, dumping their stacks, etc. 
> > > Perhaps it would be better to single-thread all that stuff
> > 
> > My fist patch took the spinlock at the beginning of panic(). But then
> > Eric asked, if it wouldn't be better to get both panic printk's and I
> > agreed.
> 
> Hm, why?  It will make a big mess.

@Andrew:

I thought it would be good to have both messages and it would be good to
change the panic behavior as less as possible...

But ok, I have no problem with getting the lock at the beginning of
panic(). Below, I attached the updated patch.

> > > Also...  this patch affects all CPU architectures, all configs, etc. 
> > > So we're expecting that every architecture's smp_send_stop() is able to
> > > stop a CPU which is spinning in spin_lock(), possibly with local
> > > interrupts disabled.  Will this work?
> > 
> > At least on s390 it will work. If there are architectures that can't
> > stop disabled CPUs then this problem is already there without this
> > patch.
> > 
> > Example:
> > 
> > 1. 1st CPU gets lock X and panics
> > 2. 2nd CPU is disabled and gets lock X
> 
> (irq-disabled)
> 
> > 3. 1st CPU calls smp_send_stop()
> >    -> 2nd CPU loops disabled and can't be stopped
> 
> Well OK.  Maybe some architectures do have this problem - who would
> notice?  If that is the case, we just made the failure cases much more
> common.  Could you check, please?

@linux-arch: 

This patch introduces a spinlock to prevent parallel execution of the
panic code. Andrew pointed out that this might be a problem for
architectures that can't do smp_send_stop() on remote CPUs that have
interrupts disabled. When irq-disabled CPUs execute panic() in parallel,
we then would have looping CPUs.

So please speak up if somebody has a problem with this patch!

Michael
---
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: kdump: fix crash_kexec()/smp_send_stop() race in panic

When two CPUs call panic at the same time there is a possible race
condition that can stop kdump.  The first CPU calls crash_kexec() and the
second CPU calls smp_send_stop() in panic() before crash_kexec() finished
on the first CPU.  So the second CPU stops the first CPU and therefore
kdump fails:

1st CPU:
panic()->crash_kexec()->mutex_trylock(&kexec_mutex)-> do kdump

2nd CPU:
panic()->crash_kexec()->kexec_mutex already held by 1st CPU
       ->smp_send_stop()-> stop 1st CPU (stop kdump)

This patch fixes the problem by introducing a spinlock in panic that
allows only one CPU to process crash_kexec() and the subsequent panic
code.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kernel/panic.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

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
@@ -68,8 +69,12 @@ NORET_TYPE void panic(const char * fmt,
 	 * It's possible to come here directly from a panic-assertion and
 	 * not have preempt disabled. Some functions called from here want
 	 * preempt to be disabled. No point enabling it later though...
+	 *
+	 * Only one CPU is allowed to execute the panic code from here. For
+	 * multiple parallel invocations of panic all other CPUs will wait on
+	 * the panic_lock. They are stopped afterwards by smp_send_stop().
 	 */
-	preempt_disable();
+	spin_lock_irq(&panic_lock);
 
 	console_verbose();
 	bust_spinlocks(1);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
