Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCY8f-0003bi-Ta
 for kexec@lists.infradead.org; Thu, 18 Feb 2021 01:29:54 +0000
Date: Thu, 18 Feb 2021 09:29:31 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 1/1] kernel/crash_core: Add crashkernel=auto for
 vmcore creation
Message-ID: <20210218012931.GC3089@dhcp-128-65.nay.redhat.com>
References: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com>
 <77fcb8e8-c3ec-6161-14a8-c142e02a9061@oracle.com>
 <20210217142653.0fcd9ce3@gandalf.local.home>
 <20210217194211.GC31184@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210217194211.GC31184@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: linux-doc@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Ingo Molnar <mingo@kernel.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, YiFei Zhu <yifeifz2@illinois.edu>, Masahiro Yamada <masahiroy@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, john.p.donnelly@oracle.com, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Frederic Weisbecker <frederic@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>

On 02/17/21 at 02:42pm, Vivek Goyal wrote:
> On Wed, Feb 17, 2021 at 02:26:53PM -0500, Steven Rostedt wrote:
> > On Wed, 17 Feb 2021 12:40:43 -0600
> > john.p.donnelly@oracle.com wrote:
> > 
> > > Hello.
> > > 
> > > Ping.
> > > 
> > > Can we get this reviewed and staged ?
> > > 
> > > Thank you.
> > 
> > Andrew,
> > 
> > Seems you are the only one pushing patches in for kexec/crash. Is this
> > maintained by anyone?
> 
> Dave Young and Baoquan He still maintain kexec/kdump stuff, AFAIK. I
> don't get time to look into this stuff now a days. 

Vivek, no problem, both Baoquan and me are on holiday leaves previously.

I'm fine with the change. 
This patch benefits distributions and those people who want to deploy a lot of
machines.  It is a good start and we can continue to improve the estimation later.

Thanks
Dave 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
