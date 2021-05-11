Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgRcW-009Zin-5W
 for kexec@lists.infradead.org; Tue, 11 May 2021 12:36:18 +0000
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v6 00/13] Add build ID to stacktraces
Date: Tue, 11 May 2021 12:36:06 +0000
Message-ID: <b30f6d396edf4db5974a2b90364b6314@AcuMS.aculab.com>
References: <20210511003845.2429846-1-swboyd@chromium.org>
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Language: en-US
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
To: 'Stephen Boyd' <swboyd@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Baoquan He <bhe@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Dave Young <dyoung@redhat.com>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Sasha Levin <sashal@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>, "x86@kernel.org" <x86@kernel.org>, Christoph Hellwig <hch@infradead.org>, peter enderborg <peter.enderborg@sony.com>

From: Stephen Boyd
> Sent: 11 May 2021 01:39
> 
> This series adds the kernel's build ID[1] to the stacktrace header
> printed in oops messages, warnings, etc. and the build ID for any module
> that appears in the stacktrace after the module name. The goal is to
> make the stacktrace more self-contained and descriptive by including the
> relevant build IDs in the kernel logs when something goes wrong. This
> can be used by post processing tools like script/decode_stacktrace.sh
> and kernel developers to easily locate the debug info associated with a
> kernel crash and line up what line and file things started falling apart
> at.
> 
> To show how this can be used I've included a patch to
> decode_stacktrace.sh that downloads the debuginfo from a debuginfod
> server. 
...
> Here's an example lkdtm stacktrace on arm64.
> 
>  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm]
>  Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE
>  CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de205662d5a9e0d4c580f19a1
>  Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
...
>  x1 : ffffff93fef15788 x0 : ffffffe3622352e0
>  Call trace:
>   lkdtm_WARNING+0x28/0x30 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
>   direct_entry+0x16c/0x1b4 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
>   full_proxy_write+0x74/0xa4

Is there any way to get it to print each module ID only once?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
