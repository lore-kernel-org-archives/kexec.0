Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1TZF-0000by-KJ
 for kexec@lists.infradead.org; Wed, 25 Nov 2015 06:28:39 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V5 PATCH 3/4] kexec: Fix race between panic() and
 crash_kexec() called directly
Date: Wed, 25 Nov 2015 06:28:14 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454A2A48B@GSjpTKYDCembx31.service.hitachi.net>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093648.4285.17715.stgit@softrs>
 <20151124203555.GC6100@home.goodmis.org>
In-Reply-To: <20151124203555.GC6100@home.goodmis.org>
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
To: 'Steven Rostedt' <rostedt@goodmis.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

> On Fri, Nov 20, 2015 at 06:36:48PM +0900, Hidehiro Kawai wrote:
> > Currently, panic() and crash_kexec() can be called at the same time.
> > For example (x86 case):
> >
> > CPU 0:
> >   oops_end()
> >     crash_kexec()
> >       mutex_trylock() // acquired
> >         nmi_shootdown_cpus() // stop other cpus
> >
> > CPU 1:
> >   panic()
> >     crash_kexec()
> >       mutex_trylock() // failed to acquire
> >     smp_send_stop() // stop other cpus
> >     infinite loop
> >
> > If CPU 1 calls smp_send_stop() before nmi_shootdown_cpus(), kdump
> > fails.
> 
> So the smp_send_stop() stops CPU 0 from calling nmi_shootdown_cpus(), right?

Yes, but the important thing is that CPU 1 stops CPU 0 which is
only CPU processing crash_ kexec routines.

> >
> > In another case:
> >
> > CPU 0:
> >   oops_end()
> >     crash_kexec()
> >       mutex_trylock() // acquired
> >         <NMI>
> >         io_check_error()
> >           panic()
> >             crash_kexec()
> >               mutex_trylock() // failed to acquire
> >             infinite loop
> >
> > Clearly, this is an undesirable result.
> 
> I'm trying to see how this patch fixes this case.
> 
> >
> > To fix this problem, this patch changes crash_kexec() to exclude
> > others by using atomic_t panic_cpu.
> >
> > V5:
> > - Add missing dummy __crash_kexec() for !CONFIG_KEXEC_CORE case
> > - Replace atomic_xchg() with atomic_set() in crash_kexec() because
> >   it is used as a release operation and there is no need of memory
> >   barrier effect.  This change also removes an unused value warning
> >
> > V4:
> > - Use new __crash_kexec(), no exclusion check version of crash_kexec(),
> >   instead of checking if panic_cpu is the current cpu or not
> >
> > V2:
> > - Use atomic_cmpxchg() instead of spin_trylock() on panic_lock
> >   to exclude concurrent accesses
> > - Don't introduce no-lock version of crash_kexec()
> >
> > Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > ---
> >  include/linux/kexec.h |    2 ++
> >  kernel/kexec_core.c   |   26 +++++++++++++++++++++++++-
> >  kernel/panic.c        |    4 ++--
> >  3 files changed, 29 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index d140b1e..7b68d27 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -237,6 +237,7 @@ extern int kexec_purgatory_get_set_symbol(struct kimage *image,
> >  					  unsigned int size, bool get_value);
> >  extern void *kexec_purgatory_get_symbol_addr(struct kimage *image,
> >  					     const char *name);
> > +extern void __crash_kexec(struct pt_regs *);
> >  extern void crash_kexec(struct pt_regs *);
> >  int kexec_should_crash(struct task_struct *);
> >  void crash_save_cpu(struct pt_regs *regs, int cpu);
> > @@ -332,6 +333,7 @@ int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> >  #else /* !CONFIG_KEXEC_CORE */
> >  struct pt_regs;
> >  struct task_struct;
> > +static inline void __crash_kexec(struct pt_regs *regs) { }
> >  static inline void crash_kexec(struct pt_regs *regs) { }
> >  static inline int kexec_should_crash(struct task_struct *p) { return 0; }
> >  #define kexec_in_progress false
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 11b64a6..9d097f5 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -853,7 +853,8 @@ struct kimage *kexec_image;
> >  struct kimage *kexec_crash_image;
> >  int kexec_load_disabled;
> >
> > -void crash_kexec(struct pt_regs *regs)
> > +/* No panic_cpu check version of crash_kexec */
> > +void __crash_kexec(struct pt_regs *regs)
> >  {
> >  	/* Take the kexec_mutex here to prevent sys_kexec_load
> >  	 * running on one cpu from replacing the crash kernel
> > @@ -876,6 +877,29 @@ void crash_kexec(struct pt_regs *regs)
> >  	}
> >  }
> >
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
> > +		 */
> > +		atomic_set(&panic_cpu, -1);
> > +	}
> > +}
> > +
> >  size_t crash_get_memory_size(void)
> >  {
> >  	size_t size = 0;
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 4fce2be..5d0b807 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -138,7 +138,7 @@ void panic(const char *fmt, ...)
> >  	 * the "crash_kexec_post_notifiers" option to the kernel.
> >  	 */
> >  	if (!crash_kexec_post_notifiers)
> > -		crash_kexec(NULL);
> > +		__crash_kexec(NULL);
> 
> Why call the __crash_kexec() version and not just crash_kexec() here.
> This needs to be documented.

In this patch, an exclusive execution control with panic_cpu
is added to crash_kexec(). When crash_kexec() is called from
panic(), we don't need to check panic_cpu because we have already
held the exclusive control. So, __crash_kexec() is used here
to bypass it.

Of course, we can call crash_kexec() here, and crash_kexec()
checks if panic_cpu is equal to the current CPU number, and
if so, continues to process crash_kexec() routines.
This was done in older version of this patch series, but
Peter received a wrong impression about checking if panic_cpu
is equal to the current CPU number; it implies that it permits
recursive call of crash_kexec() (actually recursive call of
crash_kexec() can't happen).

Anyway, I'll add some comments.
 
Regards,

--
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
