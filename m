Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZKKEu-0007Cg-8S
 for kexec@lists.infradead.org; Wed, 29 Jul 2015 05:49:17 +0000
From: =?iso-2022-jp?B?GyRCMk85ZzFROSgbKEIgLyBLQVdBSRskQiEkGyhCSElERUhJUk8=?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: Re: [V2 PATCH 1/3] x86/panic: Fix re-entrance problem due to
 panic on NMI
Date: Wed, 29 Jul 2015 05:48:47 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445491D5E8@GSjpTKYDCembx31.service.hitachi.net>
References: <20150727015850.4928.87717.stgit@softrs>
 <20150727015850.4928.50289.stgit@softrs>
 <20150727143405.GF11317@dhcp22.suse.cz> <55B6E2A3.8070004@hitachi.com>
In-Reply-To: <55B6E2A3.8070004@hitachi.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: =?iso-2022-jp?B?GyRCMk85ZzFROSgbKEIgLyBLQVdBSRskQiEkGyhCSElERUhJUk8=?= <hidehiro.kawai.ez@hitachi.com>, Michal Hocko <mhocko@kernel.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?iso-2022-jp?B?GyRCSj8+PjJtTCYbKEIgLyBISVJBTUFUVRskQiEkGyhCTUFTQU1J?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Hi,

> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Hidehiro Kawai
> (2015/07/27 23:34), Michal Hocko wrote:
> > On Mon 27-07-15 10:58:50, Hidehiro Kawai wrote:
[...]
> > The check could be also relaxed a bit and nmi_panic would
> > return only if the ongoing panic is the current cpu when we really have
> > to return and allow the preempted panic to finish.
> 
> It's reasonable.  I'll do that in the next version.

I noticed atomic_read() is insufficient.  Please consider the following
scenario.

CPU 1: call panic() in the normal context
CPU 0: call nmi_panic(), check the value of panic_cpu, then call panic()
CPU 1: set 1 to panic_cpu
CPU 0: fail to set 0 to panic_cpu, then do an infinite loop
CPU 1: call crash_kexec(), then call kdump_nmi_shootdown_cpus()

At this point, since CPU 0 loops in NMI context, it never executes
the NMI handler registered by kdump_nmi_shootdown_cpus().  This means
that no register states are saved and no cleanups for VMX/SVM are
performed.  So, we should still use atomic_cmpxchg() in nmi_panic() to
prevent other cpus from running panic routines.

> > +void nmi_panic(const char *fmt, ...)
> > +{
> > +	/*
> > +	 * We have to back off if the NMI has preempted an ongoing panic and
> > +	 * allow it to finish
> > +	 */
> > +	if (atomic_read(&panic_cpu) == raw_smp_processor_id())
> > +		return;
> > +
> > +	panic();
> > +}
> > +EXPORT_SYMBOL(nmi_panic);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
