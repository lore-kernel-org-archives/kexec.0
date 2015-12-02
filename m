Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a462u-0003Je-Kt
 for kexec@lists.infradead.org; Wed, 02 Dec 2015 11:58:05 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V5 PATCH 3/4] kexec: Fix race between panic() and
 crash_kexec() called directly
Date: Wed, 2 Dec 2015 11:57:38 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454A3B032@GSjpTKYDCembx31.service.hitachi.net>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093648.4285.17715.stgit@softrs> <20151125095457.GB29499@pd.tnic>
In-Reply-To: <20151125095457.GB29499@pd.tnic>
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
To: 'Borislav Petkov' <bp@alien8.de>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Hello Borislav,

Sorry, I haven't replied to this mail yet.

> On Fri, Nov 20, 2015 at 06:36:48PM +0900, Hidehiro Kawai wrote:
...
> > +void crash_kexec(struct pt_regs *regs)
> > +{
> > +	int old_cpu, this_cpu;
> > +
> > +	/*
> > +	 * Only one CPU is allowed to execute the crash_kexec() code as with
> > +	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
> > +	 * may stop each other.  To exclude them, we use panic_cpu here too.
> > +	 */
> > +	this_cpu = raw_smp_processor_id();
> > +	old_cpu = atomic_cmpxchg(&panic_cpu, -1, this_cpu);
> > +	if (old_cpu == -1) {
> > +		/* This is the 1st CPU which comes here, so go ahead. */
> > +		__crash_kexec(regs);
> > +
> > +		/*
> > +		 * Reset panic_cpu to allow another panic()/crash_kexec()
> > +		 * call.
> 
> So can we make __crash_kexec() return error values?
> 
> * failed to grab kexec_mutex -> reset panic_cpu
> 
> * no kexec_crash_image -> no need to reset it, all future crash_kexec()
> calls won't work so no need to run into that path anymore. However, this could
> be problematic if we want the other CPUs to panic. Do we care?
> 
> * machine_kexec successful -> doesn't matter

We can do so, but I think resetting panic_cpu always would be
simpler and safer.

Although checking kexec_crash_image each time is pointless, it
doesn't cause any actual problem.

Regards,

--
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
