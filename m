Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20200902154129.6358-1-geert+renesas@glider.be>
In-Reply-To: <20200902154129.6358-1-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Sep 2020 17:48:00 +0200
Message-ID: <CAMuHMdX722bUNmZLjGi7qEVQdA4ODY5gZ-61SnMU+oiOqnjZXQ@mail.gmail.com>
Subject: Re: [PATCH] arm: kdump: Add DT properties to crash dump kernel's DTB
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
To: Simon Horman <horms@verge.net.au>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Akashi Takahiro <takahiro.akashi@linaro.org>, Lukasz Stelmach <l.stelmach@samsung.com>, kexec@lists.infradead.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Sep 2, 2020 at 5:41 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Pass the following properties to the crash dump kernel, to provide a
> modern DT interface between kexec and the crash dump kernel:
>
>   - linux,elfcorehdr: ELF core header segment, similar to the
>     "elfcorehdr=" kernel parameter.
>   - linux,usable-memory-range: Usable memory reserved for the crash dump
>     kernel.
>     This makes the memory reservation explicit, so Linux no longer needs
>     to mask the program counter, and rely on the "mem=" kernel parameter
>     to obtain the start and size of usable memory.
>
> For backwards compatibility, the "elfcorehdr=" and "mem=" kernel
> parameters are still appended to the kernel command line.
>
> Loosely based on the ARM64 version by Akashi Takahiro.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

The counterpart patch for linux is "[PATCH] ARM: Parse kdump DT
properties"
(https://lore.kernel.org/r/20200902154538.6807-1-geert+renesas@glider.be)

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
