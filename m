Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RIfk4-0007ns-UO
	for kexec@lists.infradead.org; Tue, 25 Oct 2011 12:04:29 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1319468137.3615.16.camel@br98xy6r>
	<m1ipneifqv.fsf@fess.ebiederm.org>
	<CAM_iQpVktWsgOFCWoT47dQ1YdSTnnbTZAAKNYEEX=5wWzhHMzg@mail.gmail.com>
	<m1aa8qfhdk.fsf@fess.ebiederm.org> <1319532245.3056.5.camel@br98xy6r>
Date: Tue, 25 Oct 2011 05:04:57 -0700
In-Reply-To: <1319532245.3056.5.camel@br98xy6r> (Michael Holzheu's message of
	"Tue, 25 Oct 2011 10:44:05 +0200")
Message-ID: <m17h3tcm52.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: kdump: crash_kexec()-smp_send_stop() race in panic
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
To: holzheu@linux.vnet.ibm.com
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Michael Holzheu <holzheu@linux.vnet.ibm.com> writes:

> Hello Eric,
>
> On Mon, 2011-10-24 at 10:07 -0700, Eric W. Biederman wrote:
>
> [snip]
>
>> So my second thought is to introduce another atomic variable
>> panic_in_progress, visible only in panic.  The cpu that sets
>> increments panic_in_progress can call smp_send_stop.  The rest of
>> the cpus can just go into a busy wait.  That should stop nasty
>> fights about who is going to come out of smp_send_stop first.
>
> So this is a spinlock, no? What about the following patch:
Do we want both panic printks?

We really only need the mutual exclusion starting just before
smp_send_stop so that is where I would be inclined to put it.

But yeah something like the below should work.

Eric


> ---
>  kernel/panic.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -59,6 +59,7 @@ EXPORT_SYMBOL(panic_blink);
>   */
>  NORET_TYPE void panic(const char * fmt, ...)
>  {
> +	static DEFINE_SPINLOCK(panic_lock);
>  	static char buf[1024];
>  	va_list args;
>  	long i, i_next = 0;
> @@ -68,8 +69,12 @@ NORET_TYPE void panic(const char * fmt,
>  	 * It's possible to come here directly from a panic-assertion and
>  	 * not have preempt disabled. Some functions called from here want
>  	 * preempt to be disabled. No point enabling it later though...
> +	 *
> +	 * Only one CPU is allowed to execute the panic code. For multiple
> +	 * parallel invocations of panic all other CPUs will wait on the
> +	 * panic_lock. They are stopped afterwards by smp_send_stop().
>  	 */
> -	preempt_disable();
> +	spin_lock(&panic_lock);
>  
>  	console_verbose();
>  	bust_spinlocks(1);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
