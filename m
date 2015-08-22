Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZSyeq-0003ke-Lw
 for kexec@lists.infradead.org; Sat, 22 Aug 2015 02:35:49 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V3 PATCH 3/4] kexec: Fix race between panic() and
 crash_kexec() called directly
Date: Sat, 22 Aug 2015 02:35:24 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445493C868@GSjpTKYDCembx31.service.hitachi.net>
References: <20150806054543.25766.29590.stgit@softrs>
 <20150806054543.25766.5914.stgit@softrs>
 <20150820230845.GF3161@worktop.event.rightround.com>
In-Reply-To: <20150820230845.GF3161@worktop.event.rightround.com>
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
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric
 W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

> From: Peter Zijlstra [mailto:peterz@infradead.org]
> 
> On Thu, Aug 06, 2015 at 02:45:43PM +0900, Hidehiro Kawai wrote:
> >  void crash_kexec(struct pt_regs *regs)
> >  {
> > +	int old_cpu, this_cpu;
> > +
> > +	/*
> > +	 * `old_cpu == -1' means we are the first comer and crash_kexec()
> > +	 * was called without entering panic().
> > +	 * `old_cpu == this_cpu' means crash_kexec() was called from panic().
> > +	 */
> > +	this_cpu = raw_smp_processor_id();
> > +	old_cpu = atomic_cmpxchg(&panic_cpu, -1, this_cpu);
> > +	if (old_cpu != -1 && old_cpu != this_cpu)
> > +		return;
> 
> This allows recursive calling of crash_kexec(), the Changelog did not
> mention that. Is this really required?

What part are you arguing?  Recursive call of crash_kexec() doesn't
happen.  In the first place, one of the purpose of this patch is
to prevent a recursive call of crash_kexec() in the following case
as I stated in the description:

CPU 0:
  oops_end()
    crash_kexec()
      mutex_trylock() // acquired
        <NMI>
        io_check_error()
          panic()
            crash_kexec()
              mutex_trylock() // failed to acquire
            infinite loop


Also, the logic doesn't change form V1 (although the implementation
changed), so I didn't add changelogs any more.

Regards,

Hidehiro Kawai
Hitachi, Ltd. Research & Development Group


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
