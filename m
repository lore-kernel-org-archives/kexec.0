Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 21 Aug 2015 01:08:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [V3 PATCH 3/4] kexec: Fix race between panic() and crash_kexec()
 called directly
Message-ID: <20150820230845.GF3161@worktop.event.rightround.com>
References: <20150806054543.25766.29590.stgit@softrs>
 <20150806054543.25766.5914.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150806054543.25766.5914.stgit@softrs>
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
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Aug 06, 2015 at 02:45:43PM +0900, Hidehiro Kawai wrote:
>  void crash_kexec(struct pt_regs *regs)
>  {
> +	int old_cpu, this_cpu;
> +
> +	/*
> +	 * `old_cpu == -1' means we are the first comer and crash_kexec()
> +	 * was called without entering panic().
> +	 * `old_cpu == this_cpu' means crash_kexec() was called from panic().
> +	 */
> +	this_cpu = raw_smp_processor_id();
> +	old_cpu = atomic_cmpxchg(&panic_cpu, -1, this_cpu);
> +	if (old_cpu != -1 && old_cpu != this_cpu)
> +		return;

This allows recursive calling of crash_kexec(), the Changelog did not
mention that. Is this really required?

> +
>  	/* Take the kexec_mutex here to prevent sys_kexec_load
>  	 * running on one cpu from replacing the crash kernel
>  	 * we are using after a panic on a different cpu.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
