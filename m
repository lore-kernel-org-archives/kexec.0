Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 11 May 2021 15:35:30 +0100
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 00/13] Add build ID to stacktraces
Message-ID: <YJqWMgiirWPNNvnX@casper.infradead.org>
References: <20210511003845.2429846-1-swboyd@chromium.org>
 <b30f6d396edf4db5974a2b90364b6314@AcuMS.aculab.com>
 <20210511085235.09bc38a7@gandalf.local.home>
 <37ca7834a8514a5695ed002e073a83b6@AcuMS.aculab.com>
 <YJqTB5pJiRqS1yGY@alley>
 <f09e9d68e4b14de58e881050a3c78ec1@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f09e9d68e4b14de58e881050a3c78ec1@AcuMS.aculab.com>
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
To: David Laight <David.Laight@aculab.com>
Cc: 'Petr Mladek' <pmladek@suse.com>, 'Steven Rostedt' <rostedt@goodmis.org>, 'Stephen Boyd' <swboyd@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Dave Young <dyoung@redhat.com>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sasha Levin <sashal@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>, "x86@kernel.org" <x86@kernel.org>, Christoph Hellwig <hch@infradead.org>, peter enderborg <peter.enderborg@sony.com>

On Tue, May 11, 2021 at 02:31:38PM +0000, David Laight wrote:
> Actually, for the use case, the id could be trimmed significantly.
> It is only trying to differentiate between builds of a specific module.
> So even 8 digits would be plenty.

asked and answered.  please review the bidding.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
