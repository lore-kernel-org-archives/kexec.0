Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPZFj-002Lcv-WA
 for kexec@lists.infradead.org; Thu, 25 Mar 2021 23:19:03 +0000
Received: by mail-pg1-x534.google.com with SMTP id v3so3370775pgq.2
 for <kexec@lists.infradead.org>; Thu, 25 Mar 2021 16:18:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a7a5e6b4-109b-fdf6-5d72-1d8675a2b1ae@sony.com>
References: <20210324020443.1815557-1-swboyd@chromium.org>
 <a7a5e6b4-109b-fdf6-5d72-1d8675a2b1ae@sony.com>
Subject: Re: [PATCH v2 00/12] Add build ID to stacktraces
From: Stephen Boyd <swboyd@chromium.org>
Date: Thu, 25 Mar 2021 16:18:54 -0700
Message-ID: <161671433461.3012082.9521190652380269571@swboyd.mtv.corp.google.com>
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
To: Andrew Morton <akpm@linux-foundation.org>, peter enderborg <peter.enderborg@sony.com>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Dave Young <dyoung@redhat.com>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>, Jiri Olsa <jolsa@kernel.org>, kexec@lists.infradead.org, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Petr Mladek <pmladek@suse.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sasha Levin <sashal@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>, x86@kernel.org

Quoting peter enderborg (2021-03-25 04:14:31)
> >   el0_sync_compat_handler+0xa8/0xcc
> >   el0_sync_compat+0x178/0x180
> >  ---[ end trace 3d95032303e59e68 ]---
> 
> How will this work with the ftrace?
> 

It won't affect ftrace, if that's the question you're asking.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
