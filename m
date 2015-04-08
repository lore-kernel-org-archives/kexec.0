Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 8 Apr 2015 14:02:21 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [v3 1/5] arm64: kvm: add a cpu tear-down function
Message-ID: <20150408130221.GA5977@leverpostej>
References: <1427953216-11737-1-git-send-email-takahiro.akashi@linaro.org>
 <1427953216-11737-2-git-send-email-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1427953216-11737-2-git-send-email-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "geoff@infradead.org" <geoff@infradead.org>, "broonie@kernel.org" <broonie@kernel.org>, "david.griego@linaro.org" <david.griego@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "freddy77@gmail.com" <freddy77@gmail.com>

> +	/* We're now in idmap, disable MMU */
> +1:	mrs	x0, sctlr_el2
> +	and	x1, x0, #SCTLR_EL2_EE
> +	orr	x0, x0, x1		// preserve endianness of EL2
> +	ldr	x1, =SCTLR_EL2_FLAGS
> +	eor	x1, x1, xzr
> +	bic	x0, x0, x1		// Clear SCTL_M and etc
> +	msr	sctlr_el2, x0
> +	isb

This can instead be:

1:	mrs	x0, sctlr_el2
	ldr	x1, =SCTLR_EL2_FLAGS
	bic	x0, x0, x1
	msr	sctlr_el2, x0
	isb

As SCTLR_EL2_FLAGS doesn't contain the EE bit.

Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
