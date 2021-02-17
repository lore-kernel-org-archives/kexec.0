Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCSiO-0004rw-PE
 for kexec@lists.infradead.org; Wed, 17 Feb 2021 19:42:26 +0000
Date: Wed, 17 Feb 2021 14:42:11 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 1/1] kernel/crash_core: Add crashkernel=auto for
 vmcore creation
Message-ID: <20210217194211.GC31184@redhat.com>
References: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com>
 <77fcb8e8-c3ec-6161-14a8-c142e02a9061@oracle.com>
 <20210217142653.0fcd9ce3@gandalf.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210217142653.0fcd9ce3@gandalf.local.home>
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
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Ingo Molnar <mingo@kernel.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, YiFei Zhu <yifeifz2@illinois.edu>, Masahiro Yamada <masahiroy@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Dave Young <dyoung@redhat.com>, john.p.donnelly@oracle.com, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Frederic Weisbecker <frederic@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>

On Wed, Feb 17, 2021 at 02:26:53PM -0500, Steven Rostedt wrote:
> On Wed, 17 Feb 2021 12:40:43 -0600
> john.p.donnelly@oracle.com wrote:
> 
> > Hello.
> > 
> > Ping.
> > 
> > Can we get this reviewed and staged ?
> > 
> > Thank you.
> 
> Andrew,
> 
> Seems you are the only one pushing patches in for kexec/crash. Is this
> maintained by anyone?

Dave Young and Baoquan He still maintain kexec/kdump stuff, AFAIK. I
don't get time to look into this stuff now a days. 

Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
