Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RIccE-0003mH-4c
	for kexec@lists.infradead.org; Tue, 25 Oct 2011 08:44:10 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9P8i7oV017219
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 08:44:07 GMT
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
	[9.149.37.217])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p9P8i7oO2392182
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 09:44:07 +0100
Received: from d06av06.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p9PFi6OR012149
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 09:44:07 -0600
Message-ID: <1319532245.3056.5.camel@br98xy6r>
Subject: Re: kdump: crash_kexec()-smp_send_stop() race in panic
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Tue, 25 Oct 2011 10:44:05 +0200
In-Reply-To: <m1aa8qfhdk.fsf@fess.ebiederm.org>
References: <1319468137.3615.16.camel@br98xy6r>
	<m1ipneifqv.fsf@fess.ebiederm.org>
	<CAM_iQpVktWsgOFCWoT47dQ1YdSTnnbTZAAKNYEEX=5wWzhHMzg@mail.gmail.com>
	<m1aa8qfhdk.fsf@fess.ebiederm.org>
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

Hello Eric,

On Mon, 2011-10-24 at 10:07 -0700, Eric W. Biederman wrote:

[snip]

> So my second thought is to introduce another atomic variable
> panic_in_progress, visible only in panic.  The cpu that sets
> increments panic_in_progress can call smp_send_stop.  The rest of
> the cpus can just go into a busy wait.  That should stop nasty
> fights about who is going to come out of smp_send_stop first.

So this is a spinlock, no? What about the following patch:
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
+	 * Only one CPU is allowed to execute the panic code. For multiple
+	 * parallel invocations of panic all other CPUs will wait on the
+	 * panic_lock. They are stopped afterwards by smp_send_stop().
 	 */
-	preempt_disable();
+	spin_lock(&panic_lock);
 
 	console_verbose();
 	bust_spinlocks(1);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
