Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Thu, 20 Oct 2011 08:01:06 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: Possible regression in kexec on ARM ARMv6 and ARMv7 cores
Message-ID: <20111020070105.GA28548@mudshark.cambridge.arm.com>
References: <20111020042444.GA20260@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111020042444.GA20260@verge.net.au>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Dave Martin <dave.martin@linaro.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Frank Hofmann <frank.hofmann@tomtom.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Oct 20, 2011 at 05:24:45AM +0100, Simon Horman wrote:
> Hi Will, Hi All,

Hi Simon,

> it appears that "ARM: proc: add definition of cpu_reset for
>  ARMv6 and ARMv7 cores" (f4daf06fc23b99df5ca5b3e892428b91e148cc52),
> which was introduced for 3.1-rc1, causes a regression and that
> kexec no longer works on ARM. The board that I am testing
> on is a Renesas Mackerel which has an SH7372 (ARMv7) processor.

Wow, I'm surprised the old code worked at all on an ARMv7 CPU! It's certainly
highly unlikely to work by the letter of the architecture, so I guess the
planets aligned in just the right way for your particular implementation.

Please can you try my kexec/mmu-off patches? They should add the bits and
pieces you need for kexec to work reliably on a UP system. I plan to finish
these off next week in Prague so hopefully they'll hit mainline in the near
future.

https://github.com/wdeacon/linux-wd/commits/kexec/mmu-off

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
