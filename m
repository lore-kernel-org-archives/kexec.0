Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ledLx-0061vi-VD
 for kexec@lists.infradead.org; Thu, 06 May 2021 12:43:43 +0000
Received: by mail-lj1-x232.google.com with SMTP id u25so6858271ljg.7
 for <kexec@lists.infradead.org>; Thu, 06 May 2021 05:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210317113130.2554368-1-geert+renesas@glider.be>
In-Reply-To: <20210317113130.2554368-1-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 May 2021 14:43:26 +0200
Message-ID: <CACRpkdb47SZ1npdp+MNiAz4WZZvfVZOeHcV3Scv5pK1QurT06A@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: Parse kdump DT properties
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
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Marek Szyprowski <m.szyprowski@samsung.com>, Dmitry Osipenko <digetx@gmail.com>, Rob Herring <robh+dt@kernel.org>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lukasz Stelmach <l.stelmach@samsung.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org

On Wed, Mar 17, 2021 at 12:31 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Parse the following DT properties in the crash dump kernel, to provide a
> modern interface between kexec and the crash dump kernel:
>   - linux,elfcorehdr: ELF core header segment, similar to the
>     "elfcorehdr=" kernel parameter.
>   - linux,usable-memory-range: Usable memory reserved for the crash dump
>     kernel.
>     This makes the memory reservation explicit.  If present, Linux no
>     longer needs to mask the program counter, and rely on the "mem="
>     kernel parameter to obtain the start and size of usable memory.
>
> For backwards compatibility, the traditional method to derive the start
> of memory is still used if "linux,usable-memory-range" is absent, and
> the "elfcorehdr=" and "mem=" kernel parameters are still parsed.
>
> Loosely based on the ARM64 version by Akashi Takahiro.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I like the approach overall.

I see Rob has some comments that need adressing.

The chosen.txt file needs an example of how to use this so people
can intuitively get it right if they want to play with it, it was at least
the first question in my head: how does that look in practice?

Yours,
Linus Walleij

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
