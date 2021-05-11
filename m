Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 11 May 2021 13:48:06 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v6 00/13] Add build ID to stacktraces
Message-ID: <YJpu9mC8J+Kb6qWg@alley>
References: <20210511003845.2429846-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
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
To: Stephen Boyd <swboyd@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Dave Young <dyoung@redhat.com>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>, Jiri Olsa <jolsa@kernel.org>, kexec@lists.infradead.org, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sasha Levin <sashal@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>, x86@kernel.org, Christoph Hellwig <hch@infradead.org>, peter enderborg <peter.enderborg@sony.com>

On Mon 2021-05-10 17:38:32, Stephen Boyd wrote:
> This series adds the kernel's build ID[1] to the stacktrace header
> printed in oops messages, warnings, etc. and the build ID for any module
> that appears in the stacktrace after the module name. The goal is to
> make the stacktrace more self-contained and descriptive by including the
> relevant build IDs in the kernel logs when something goes wrong. This
> can be used by post processing tools like script/decode_stacktrace.sh
> and kernel developers to easily locate the debug info associated with a
> kernel crash and line up what line and file things started falling apart
> at.

The entire series looks good to me.

I reviewed carefully only the 5th patch touching printk/kallsyms/module
code. I just scanned over the other patches touching kernel code
and did not notice any obvious problem. I did not check the changes
in decode_stacktrace.sh at all.

I tried to get stacktraces on x86_64 and it worked as expected.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
