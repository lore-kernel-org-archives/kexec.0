Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 11 May 2021 08:52:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v6 00/13] Add build ID to stacktraces
Message-ID: <20210511085235.09bc38a7@gandalf.local.home>
In-Reply-To: <b30f6d396edf4db5974a2b90364b6314@AcuMS.aculab.com>
References: <20210511003845.2429846-1-swboyd@chromium.org>
 <b30f6d396edf4db5974a2b90364b6314@AcuMS.aculab.com>
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
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Stephen Boyd' <swboyd@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Baoquan He <bhe@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Dave Young <dyoung@redhat.com>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Sasha Levin <sashal@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>, "x86@kernel.org" <x86@kernel.org>, Christoph Hellwig <hch@infradead.org>, peter enderborg <peter.enderborg@sony.com>

On Tue, 11 May 2021 12:36:06 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> >  x1 : ffffff93fef15788 x0 : ffffffe3622352e0
> >  Call trace:
> >   lkdtm_WARNING+0x28/0x30 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
> >   direct_entry+0x16c/0x1b4 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
> >   full_proxy_write+0x74/0xa4  
> 
> Is there any way to get it to print each module ID only once?

If there's a trivial way to do that, then perhaps it should be done, but for
now, this patch series isn't as obnoxious as the previous versions. It only
affects stack traces, and I'm fine with that.

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
