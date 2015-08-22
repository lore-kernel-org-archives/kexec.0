Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZSxqB-0002AT-Ei
 for kexec@lists.infradead.org; Sat, 22 Aug 2015 01:43:28 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V3 PATCH 2/4] panic/x86: Allow cpus to save registers even if
 they are looping in NMI context
Date: Sat, 22 Aug 2015 01:43:00 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445493C80C@GSjpTKYDCembx31.service.hitachi.net>
References: <20150806054543.25766.29590.stgit@softrs>
 <20150806054543.25766.5526.stgit@softrs>
 <20150820231816.GH3161@worktop.event.rightround.com>
In-Reply-To: <20150820231816.GH3161@worktop.event.rightround.com>
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
To: 'Peter Zijlstra' <peterz@infradead.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric
 W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

> From: Peter Zijlstra [mailto:peterz@infradead.org]
> 
> On Thu, Aug 06, 2015 at 02:45:43PM +0900, Hidehiro Kawai wrote:
> > When cpu-A panics on NMI just after cpu-B has panicked, cpu-A loops
> > infinitely in NMI context.  Especially for x86, cpu-B issues NMI IPI
> > to other cpus to save their register states and do some cleanups if
> > kdump is enabled, but cpu-A can't handle the NMI and fails to save
> > register states.
> >
> > To solve thie issue, we wait for the timing of the NMI IPI, then
> > call the NMI handler which saves register states.
> 
> Sorry, I don't follow, what?

First, a subroutine of crash_kexec(), nmi_shootdown_cpus()
send NMI IPI to non-panic cpus to stop them while saving their
registers ans doing some cleanups for crash dumping.  So if a non-panic
cpu is looping in NMI context infinitely at that time, we fail to save
its register information and lose the information from the crash dump.

`Infinite loop in NMI context' can happen when panic on NMI is about
to happen while another cpu has already been processing panic().
To save regs and do some cleanups in that case too, this patch does
two things:

1. Moves the timing of `infinite loop in NMI context' (actually
   panic_smp_self_stop()) outside of panic() to keep the pt_regs object
2. call a callback of nmi_shootdown_cpus() directly to save regs and
   do some cleanups after setting waiting_for_crash_ipi which is used
   for counting down the number of cpus which handled the callback

Does that answer your question?

Regards,

Hidehiro Kawai
Hitachi, Ltd. Research & Development Group

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
