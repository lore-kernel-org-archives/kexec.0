Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga12.intel.com ([192.55.52.136])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUmPb-0001r9-Kh
 for kexec@lists.infradead.org; Fri, 09 Apr 2021 08:22:45 +0000
Date: Fri, 9 Apr 2021 11:22:26 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
Message-ID: <YHAOwm5JtmH/8Njr@smile.fi.intel.com>
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
 <202104061143.E11D2D0@keescook>
 <CAHp75Ve+11u=dtNTO8BCohOJHGWSMJtb1nGCOrNde7bXaD4ehA@mail.gmail.com>
 <20210408232303.453749e0e6fb0adfa8545440@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408232303.453749e0e6fb0adfa8545440@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Michael Ellerman <mpe@ellerman.id.au>, Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Mike Rapoport <rppt@kernel.org>, Corey Minyard <cminyard@mvista.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Vlastimil Babka <vbabka@suse.cz>, "Paul E. McKenney" <paulmck@kernel.org>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, openipmi-developer@lists.sourceforge.net, linux-remoteproc@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, kexec@lists.infradead.org, rcu@vger.kernel.org, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Corey Minyard <minyard@acm.org>, Ohad Ben-Cohen <ohad@wizery.com>, Arnd Bergmann <arnd@arndb.de>, Eric Biederman <ebiederm@xmission.com>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>

On Thu, Apr 08, 2021 at 11:23:03PM -0700, Andrew Morton wrote:
> On Wed, 7 Apr 2021 11:46:37 +0300 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Wed, Apr 7, 2021 at 11:17 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Tue, Apr 06, 2021 at 04:31:58PM +0300, Andy Shevchenko wrote:
> > > > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > > > Here is the attempt to start cleaning it up by splitting out panic and
> > > > oops helpers.
> > > >
> > > > At the same time convert users in header and lib folder to use new header.
> > > > Though for time being include new header back to kernel.h to avoid twisted
> > > > indirected includes for existing users.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > I like it! Do you have a multi-arch CI to do allmodconfig builds to
> > > double-check this?
> > 
> > Unfortunately no, I rely on plenty of bots that are harvesting mailing lists.
> > 
> > But I will appreciate it if somebody can run this through various build tests.
> > 
> 
> um, did you try x86_64 allmodconfig?
> 
> I'm up to
> kernelh-split-out-panic-and-oops-helpers-fix-fix-fix-fix-fix-fix-fix.patch
> and counting.


I will try on my side and will fix those, thanks!

> and.... drivers/leds/trigger/ledtrig-heartbeat.c as well.
> 
> I'll drop it.

No problem, thanks for the report.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
