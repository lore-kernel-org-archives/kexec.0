Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1492085867.20068.4.camel@infradead.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org>
 <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
 <20170404073504.GI16309@linaro.org> <1491291844.6218.25.camel@infradead.org>
 <20170404092604.GB14898@arm.com> <1492085867.20068.4.camel@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Apr 2017 11:29:22 +0200
Message-ID: <CAMuHMdWHTZ6prRD+3FWBMV+d0huNuEA6DoGagS82DbucBSMjsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: Fix power-of-ten vs. power-of-two prefixes in
 user-visible messages
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
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, panand@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Mark Salter <msalter@redhat.com>, bauerman@linux.vnet.ibm.com, sgoel@codeaurora.org, Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi David,

On Thu, Apr 13, 2017 at 2:17 PM, David Woodhouse <dwmw2@infradead.org> wrote:
> The IEC binary prefixes (Ki, Mi, Gi, etc.) were published over twenty
> years ago. We should use them consistently, especially in user-visible
> messages.
>
> Sure, it doesn't often matter, just as *most* typos and spelling or
> grammar mistakes don't often matter. But sometimes, such misuse really
> do actually introduce ambiguity, and we should avoid that.
>
> Conversely, there is absolutely no good reason *not* to be using the
> binary prefixes. Some people once claimed to find them "ugly", or that
> they would cause confusion. But those are purely down to unfamiliarity.
>
> The perceived ugliness, and the alleged confusion, will pass with use.
>
> The correctness, and the lack of ambiguity, will not.
>
> ARM64 in particular, as a new platform, has no excuse for not using the
> IEC prefixes which predate its existence by a decade and a half.
>
> What's worse is that some people are pointing at the existing errors and
> actually claiming that they want their *new* code to be deliberately
> wrong in order to be "consistent" with what's there.
>
> So let's fix the user-visible messages in all of arch/arm64 and nip
> *that* particular stupidity in the bud...
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

For correctness:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

For the policy:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

You're gonna need a new sweep for soon to be added occurrences, though.

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
