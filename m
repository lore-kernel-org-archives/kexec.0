Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTCIF-009zMb-SQ
 for kexec@lists.infradead.org; Thu, 23 Sep 2021 00:08:53 +0000
Received: by mail-lf1-x12b.google.com with SMTP id b15so18496963lfe.7
 for <kexec@lists.infradead.org>; Wed, 22 Sep 2021 17:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <0de07021e49ac26a8f9386f62f3e15e947d0f6d0.1631709384.git.geert+renesas@glider.be>
In-Reply-To: <0de07021e49ac26a8f9386f62f3e15e947d0f6d0.1631709384.git.geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 Sep 2021 02:08:39 +0200
Message-ID: <CACRpkdZzz5_oVSXPwuwpqMDYvzwTkHvmy6ua6yoJqOOSuZb4xg@mail.gmail.com>
Subject: Re: [PATCH v6] ARM: uncompress: Parse "linux,
 usable-memory-range" DT property
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
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Ard Biesheuvel <ardb@kernel.org>, Lukasz Stelmach <l.stelmach@samsung.com>, Simon Horman <horms@verge.net.au>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org

On Wed, Sep 15, 2021 at 3:20 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Add support for parsing the "linux,usable-memory-range" DT property.
> This property is used to describe the usable memory reserved for the
> crash dump kernel, and thus makes the memory reservation explicit.
> If present, Linux no longer needs to mask the program counter, and rely
> on the "mem=" kernel parameter to obtain the start and size of usable
> memory.
>
> For backwards compatibility, the traditional method to derive the start
> of memory is still used if "linux,usable-memory-range" is absent.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Very nice patch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
