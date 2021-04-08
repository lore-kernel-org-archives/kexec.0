Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga04.intel.com ([192.55.52.120])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUUiw-00889F-0K
 for kexec@lists.infradead.org; Thu, 08 Apr 2021 13:29:32 +0000
Date: Thu, 8 Apr 2021 16:29:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
Message-ID: <YG8FJOYVovYIOLXA@smile.fi.intel.com>
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
 <03be4ed9-8e8d-e2c2-611d-ac09c61d84f9@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <03be4ed9-8e8d-e2c2-611d-ac09c61d84f9@rasmusvillemoes.dk>
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
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Mike Rapoport <rppt@kernel.org>, Corey Minyard <cminyard@mvista.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Vlastimil Babka <vbabka@suse.cz>, "Paul E. McKenney" <paulmck@kernel.org>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, openipmi-developer@lists.sourceforge.net, linux-remoteproc@vger.kernel.org, linux-arch@vger.kernel.org, kexec@lists.infradead.org, rcu@vger.kernel.org, linux-fsdevel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Corey Minyard <minyard@acm.org>, Ohad Ben-Cohen <ohad@wizery.com>, Arnd Bergmann <arnd@arndb.de>, Eric Biederman <ebiederm@xmission.com>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>

On Thu, Apr 08, 2021 at 02:45:12PM +0200, Rasmus Villemoes wrote:
> On 06/04/2021 15.31, Andy Shevchenko wrote:
> > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > Here is the attempt to start cleaning it up by splitting out panic and
> > oops helpers.
> 
> Yay.
> 
> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Thanks!

> > At the same time convert users in header and lib folder to use new header.
> > Though for time being include new header back to kernel.h to avoid twisted
> > indirected includes for existing users.
> 
> I think it would be good to have some place to note that "This #include
> is just for backwards compatibility, it will go away RealSoonNow, so if
> you rely on something from linux/panic.h, include that explicitly
> yourself TYVM. And if you're looking for a janitorial task, write a
> script to check that every file that uses some identifier defined in
> panic.h actually includes that file. When all offenders are found and
> dealt with, remove the #include and this note.".

Good and...

> > +struct taint_flag {
> > +	char c_true;	/* character printed when tainted */
> > +	char c_false;	/* character printed when not tainted */
> > +	bool module;	/* also show as a per-module taint flag */
> > +};
> > +
> > +extern const struct taint_flag taint_flags[TAINT_FLAGS_COUNT];
> 
> While you're doing this, nothing outside of kernel/panic.c cares about
> the definition of struct taint_flag or use the taint_flags array, so
> could you make the definition private to that file and make the array
> static? (Another patch, of course.)

...according to the above if *you are looking for a janitorial task*... :-))

> > +enum lockdep_ok {
> > +	LOCKDEP_STILL_OK,
> > +	LOCKDEP_NOW_UNRELIABLE,
> > +};
> > +
> > +extern const char *print_tainted(void);
> > +extern void add_taint(unsigned flag, enum lockdep_ok);
> > +extern int test_taint(unsigned flag);
> > +extern unsigned long get_taint(void);
> 
> I know you're just moving code, but it would be a nice opportunity to
> drop the redundant externs.

As above. But for all these I have heard you. So, I'll keep this response
as part of my always only growing TODO list.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
