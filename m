Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTvK0-003dUu-Kt
 for kexec@lists.infradead.org; Tue, 06 Apr 2021 23:41:26 +0000
Received: by mail-wr1-f44.google.com with SMTP id x15so6728125wrq.3
 for <kexec@lists.infradead.org>; Tue, 06 Apr 2021 16:41:23 -0700 (PDT)
Date: Tue, 6 Apr 2021 23:41:21 +0000
From: Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
Message-ID: <20210406234121.4ebbaoxyrzdywdj4@liuwe-devbox-debian-v2>
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Mike Rapoport <rppt@kernel.org>, Corey Minyard <cminyard@mvista.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Vlastimil Babka <vbabka@suse.cz>, "Paul E. McKenney" <paulmck@kernel.org>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, openipmi-developer@lists.sourceforge.net, linux-remoteproc@vger.kernel.org, linux-arch@vger.kernel.org, kexec@lists.infradead.org, rcu@vger.kernel.org, linux-fsdevel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Corey Minyard <minyard@acm.org>, Ohad Ben-Cohen <ohad@wizery.com>, Arnd Bergmann <arnd@arndb.de>, Eric Biederman <ebiederm@xmission.com>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>

On Tue, Apr 06, 2021 at 04:31:58PM +0300, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out panic and
> oops helpers.
> 
> At the same time convert users in header and lib folder to use new header.
> Though for time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
