Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU9Ce-0059Uc-JH
 for kexec@lists.infradead.org; Wed, 07 Apr 2021 14:30:49 +0000
Received: by mail-pl1-f174.google.com with SMTP id t20so9410688plr.13
 for <kexec@lists.infradead.org>; Wed, 07 Apr 2021 07:30:44 -0700 (PDT)
Date: Wed, 7 Apr 2021 14:30:40 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
Message-ID: <20210407143040.GB4332@42.do-not-panic.com>
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
 <20210406165108.GA4332@42.do-not-panic.com>
 <CAHp75Ve9vBQqSegM2-ch9NUN-MdevxxOs5ZdHkk1W7AacN+Wrw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHp75Ve9vBQqSegM2-ch9NUN-MdevxxOs5ZdHkk1W7AacN+Wrw@mail.gmail.com>
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
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Mike Rapoport <rppt@kernel.org>, Corey Minyard <cminyard@mvista.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Vlastimil Babka <vbabka@suse.cz>, "Paul E. McKenney" <paulmck@kernel.org>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, openipmi-developer@lists.sourceforge.net, linux-remoteproc@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, kexec@lists.infradead.org, rcu@vger.kernel.org, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Corey Minyard <minyard@acm.org>, Ohad Ben-Cohen <ohad@wizery.com>, Arnd Bergmann <arnd@arndb.de>, Eric Biederman <ebiederm@xmission.com>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Kees Cook <keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>

On Wed, Apr 07, 2021 at 10:33:44AM +0300, Andy Shevchenko wrote:
> On Wed, Apr 7, 2021 at 10:25 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Tue, Apr 06, 2021 at 04:31:58PM +0300, Andy Shevchenko wrote:
> > > diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> > > new file mode 100644
> > > index 000000000000..41e32483d7a7
> > > --- /dev/null
> > > +++ b/include/linux/panic_notifier.h
> > > @@ -0,0 +1,12 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _LINUX_PANIC_NOTIFIERS_H
> > > +#define _LINUX_PANIC_NOTIFIERS_H
> > > +
> > > +#include <linux/notifier.h>
> > > +#include <linux/types.h>
> > > +
> > > +extern struct atomic_notifier_head panic_notifier_list;
> > > +
> > > +extern bool crash_kexec_post_notifiers;
> > > +
> > > +#endif       /* _LINUX_PANIC_NOTIFIERS_H */
> >
> > Why is it worth it to add another file just for this?
> 
> The main point is to break tons of loops that prevent having clean
> headers anymore.
>
> In this case, see bug.h, which is very important in this sense.

OK based on the commit log this was not clear, it seemed more of moving
panic stuff to its own file, so just cleanup.

> >  Seems like a very
> > small file.
> 
> If it is an argument, it's kinda strange. We have much smaller headers.

The motivation for such separate file was just not clear on the commit
log.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
