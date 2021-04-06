Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.kundenserver.de ([212.227.17.10])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTnLI-002tue-Ou
 for kexec@lists.infradead.org; Tue, 06 Apr 2021 15:10:14 +0000
Received: from mail-ot1-f42.google.com ([209.85.210.42]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MfHMj-1m68673E67-00gmFo for <kexec@lists.infradead.org>; Tue, 06 Apr 2021
 17:10:09 +0200
Received: by mail-ot1-f42.google.com with SMTP id
 l12-20020a9d6a8c0000b0290238e0f9f0d8so14913586otq.8
 for <kexec@lists.infradead.org>; Tue, 06 Apr 2021 08:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Apr 2021 17:09:50 +0200
Message-ID: <CAK8P3a3PBvj_JEgxqSD6fg_J8kZzUz_KthZ66RdA5tF4CPPbdg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
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
Cc: Michael Ellerman <mpe@ellerman.id.au>, Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Mike Rapoport <rppt@kernel.org>, Corey Minyard <cminyard@mvista.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Vlastimil Babka <vbabka@suse.cz>, "Paul E. McKenney" <paulmck@kernel.org>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, openipmi-developer@lists.sourceforge.net, linux-remoteproc@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, kexec@lists.infradead.org, rcu@vger.kernel.org, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Corey Minyard <minyard@acm.org>, Ohad Ben-Cohen <ohad@wizery.com>, Eric Biederman <ebiederm@xmission.com>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>

On Tue, Apr 6, 2021 at 3:31 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out panic and
> oops helpers.
>
> At the same time convert users in header and lib folder to use new header.
> Though for time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
