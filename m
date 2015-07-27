Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZJjoQ-0005Fu-EF
 for kexec@lists.infradead.org; Mon, 27 Jul 2015 14:55:30 +0000
Received: by wibxm9 with SMTP id xm9so116530610wib.0
 for <kexec@lists.infradead.org>; Mon, 27 Jul 2015 07:55:08 -0700 (PDT)
Date: Mon, 27 Jul 2015 16:55:06 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [V2 PATCH 2/3] kexec: Fix race between panic() and crash_kexec()
 called directly
Message-ID: <20150727145506.GG11317@dhcp22.suse.cz>
References: <20150727015850.4928.87717.stgit@softrs>
 <20150727015850.4928.15194.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150727015850.4928.15194.stgit@softrs>
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
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Mon 27-07-15 10:58:50, Hidehiro Kawai wrote:
[...]
> @@ -1472,6 +1472,18 @@ void __weak crash_unmap_reserved_pages(void)
>  
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
> +	old_cpu = atomic_cmpxchg(&panicking_cpu, -1, this_cpu);
> +	if (old_cpu != -1 && old_cpu != this_cpu)
> +		return;
> +
>  	/* Take the kexec_mutex here to prevent sys_kexec_load
>  	 * running on one cpu from replacing the crash kernel
>  	 * we are using after a panic on a different cpu.
> @@ -1491,6 +1503,14 @@ void crash_kexec(struct pt_regs *regs)
>  		}
>  		mutex_unlock(&kexec_mutex);
>  	}
> +
> +	/*
> +	 * If we came here from panic(), we have to keep panicking_cpu
> +	 * to prevent other cpus from entering panic().  Otherwise,
> +	 * resetting it so that other cpus can enter panic()/crash_kexec().
> +	 */
> +	if (old_cpu == this_cpu)
> +		atomic_set(&panicking_cpu, -1);

This do the opposite what the comment says, wouldn't it? You should
check old_cpu == -1. Also atomic_set doesn't imply memory barriers which
might be a problem.
-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
