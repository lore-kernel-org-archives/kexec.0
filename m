Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 30 Mar 2021 12:59:23 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 00/12] Add build ID to stacktraces
Message-ID: <YGMEi6i8ksa9+adD@alley>
References: <20210324020443.1815557-1-swboyd@chromium.org>
 <20210324085543.GA2660708@infradead.org>
 <dbb430e1-2223-9df0-2563-4b017d6b409d@sony.com>
 <161671450646.3012082.10177164412320557022@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161671450646.3012082.10177164412320557022@swboyd.mtv.corp.google.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>, peter enderborg <peter.enderborg@sony.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Dave Young <dyoung@redhat.com>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>, Jiri Olsa <jolsa@kernel.org>, kexec@lists.infradead.org, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sasha Levin <sashal@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>, x86@kernel.org

On Thu 2021-03-25 16:21:46, Stephen Boyd wrote:
> Quoting peter enderborg (2021-03-25 04:06:17)
> > On 3/24/21 9:55 AM, Christoph Hellwig wrote:
> > > On Tue, Mar 23, 2021 at 07:04:31PM -0700, Stephen Boyd wrote:
> > >>  x5 : 0000000000000000 x4 : 0000000000000001
> > >>  x3 : 0000000000000008 x2 : ffffff93fef25a70
> > >>  x1 : ffffff93fef15788 x0 : ffffffe3622352e0
> > >>  Call trace:
> > >>   lkdtm_WARNING+0x28/0x30 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143=
b259e]
> > >>   direct_entry+0x16c/0x1b4 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e14=
3b259e]
> > > Yikes.  No, please do not make the backtraces a complete mess for
> > > something that serves absolutely no need.
> =

> It serves a need. Please look at the patches to understand that I'm
> adding the buildid to automatically find the associated debug
> information on distros.
> =

> > =

> > Would a "verbose" flag be acceptable solution?=A0=A0=A0 Something like =
write 1 to /sys/kernel/debug/verbose_stack to get the extra info.
> > =

> > I think I see a need for it.
> > =

> =

> Or a kernel config option and a commandline parameter? That would be OK
> for me as I said on v1 of this series. I'll add that in for the next
> patch series given all the distaste for some more hex characters next to
> the module name.

IMHO, a build configure option would fit the best here.

It does not make sense to show the ID when the kernel vendor does
not have a service to download the related binaries. But it makes
sense to show the buildid by default when the provider/distro has
the service and want to use the ID when handling bug reports.

We could always add boot/run time options when people really need it.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
