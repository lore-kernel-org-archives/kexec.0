Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170416231223.GA31693@verge.net.au>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org>
 <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
 <20170404073504.GI16309@linaro.org> <1491291844.6218.25.camel@infradead.org>
 <20170404092604.GB14898@arm.com> <1492085938.20068.6.camel@infradead.org>
 <20170416231223.GA31693@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Apr 2017 13:54:49 +0200
Message-ID: <CAMuHMdXTgCEesv3imtnzs6Mcnkp22KW_rx0Jiv3_zce7bR3AVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: Fix power-of-ten vs. power-of-two prefixes in
 comments etc.
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
Cc: Mark Rutland <mark.rutland@arm.com>, panand@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Young <dyoung@redhat.com>, Will Deacon <will.deacon@arm.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Mark Salter <msalter@redhat.com>, bauerman@linux.vnet.ibm.com, sgoel@codeaurora.org, David Woodhouse <dwmw2@infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Apr 17, 2017 at 1:12 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Apr 13, 2017 at 01:18:58PM +0100, David Woodhouse wrote:
>> Less important than in user-visible messages, but still good practice as
>> there's still no excuse for ARM64 code to look like it was written before
>> 1996.
>>
>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>
> Hi David,
>
> I'd be happy to take the Renesas portions of this change if they were
> broken out into a separate patch. The reason I would prefer a separate
> patch is to avoid the possibility of conflicts, even trivial ones.

s/possibility/reality/, unless this series goes in before v4.12-rc1.

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
