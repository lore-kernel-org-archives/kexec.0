Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZhSuL-0003Gg-3u
 for kexec@lists.infradead.org; Thu, 01 Oct 2015 01:43:42 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V4 PATCH 2/4] panic/x86: Allow cpus to save registers even if
 they are looping in NMI context
Date: Thu, 1 Oct 2015 01:43:18 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445499CC87@GSjpTKYDCembx31.service.hitachi.net>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112807.4258.12180.stgit@softrs>
 <20150930115025.GG2881@worktop.programming.kicks-ass.net>
In-Reply-To: <20150930115025.GG2881@worktop.programming.kicks-ass.net>
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

> On Fri, Sep 25, 2015 at 08:28:07PM +0900, Hidehiro Kawai wrote:
> > --- a/arch/x86/kernel/reboot.c
> > +++ b/arch/x86/kernel/reboot.c
> > @@ -718,6 +718,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
> >  static nmi_shootdown_cb shootdown_callback;
> >
> >  static atomic_t waiting_for_crash_ipi;
> > +static int crash_ipi_done;
> >
> >  static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
> >  {
> > @@ -779,6 +780,7 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
> >  	wmb();
> >
> >  	smp_send_nmi_allbutself();
> > +	crash_ipi_done = 1; /* Kick cpus looping in nmi context */
> 
> I would suggest using WRITE_ONCE() for that, because without the
> volatile the compiler need not actually emit the store until after the
> whole waiting thing _IF_ it can inline the whole thing.
> 
> Currently udelay() will end up being a function call and will therefore
> force the store to be emitted, but I'd rather not rely on that.

OK, I use WRITE_ONCE().
Thanks!

> >
> >  	msecs = 1000; /* Wait at most a second for the other cpus to stop */
> >  	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {


Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
