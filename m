Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 24 Mar 2021 08:55:43 +0000
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 00/12] Add build ID to stacktraces
Message-ID: <20210324085543.GA2660708@infradead.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210324020443.1815557-1-swboyd@chromium.org>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Dave Young <dyoung@redhat.com>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>, Jiri Olsa <jolsa@kernel.org>, kexec@lists.infradead.org, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Petr Mladek <pmladek@suse.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sasha Levin <sashal@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>, x86@kernel.org

On Tue, Mar 23, 2021 at 07:04:31PM -0700, Stephen Boyd wrote:
>  x5 : 0000000000000000 x4 : 0000000000000001
>  x3 : 0000000000000008 x2 : ffffff93fef25a70
>  x1 : ffffff93fef15788 x0 : ffffffe3622352e0
>  Call trace:
>   lkdtm_WARNING+0x28/0x30 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
>   direct_entry+0x16c/0x1b4 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]

Yikes.  No, please do not make the backtraces a complete mess for
something that serves absolutely no need.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
