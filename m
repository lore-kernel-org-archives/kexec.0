Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 30 Sep 2015 13:50:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [V4 PATCH 2/4] panic/x86: Allow cpus to save registers even if
 they are looping in NMI context
Message-ID: <20150930115025.GG2881@worktop.programming.kicks-ass.net>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112807.4258.12180.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150925112807.4258.12180.stgit@softrs>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Sep 25, 2015 at 08:28:07PM +0900, Hidehiro Kawai wrote:
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -718,6 +718,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
>  static nmi_shootdown_cb shootdown_callback;
>  
>  static atomic_t waiting_for_crash_ipi;
> +static int crash_ipi_done;
>  
>  static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
>  {
> @@ -779,6 +780,7 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
>  	wmb();
>  
>  	smp_send_nmi_allbutself();
> +	crash_ipi_done = 1; /* Kick cpus looping in nmi context */

I would suggest using WRITE_ONCE() for that, because without the
volatile the compiler need not actually emit the store until after the
whole waiting thing _IF_ it can inline the whole thing.

Currently udelay() will end up being a function call and will therefore
force the store to be emitted, but I'd rather not rely on that.

>  
>  	msecs = 1000; /* Wait at most a second for the other cpus to stop */
>  	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
