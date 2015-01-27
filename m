Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 27 Jan 2015 17:57:40 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4/8] arm64: Add EL2 switch to soft_restart
Message-ID: <20150127175740.GK3226@e104818-lin.cambridge.arm.com>
References: <cover.1421449714.git.geoff@infradead.org>
 <bb44d4eee4fab15278e4a8829a0981878bc9acd7.1421449714.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bb44d4eee4fab15278e4a8829a0981878bc9acd7.1421449714.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
>  ENTRY(cpu_reset)
> -	mrs	x1, sctlr_el1
> -	bic	x1, x1, #1
> -	msr	sctlr_el1, x1			// disable the MMU
> +	mrs	x2, sctlr_el1
> +	bic	x2, x2, #1
> +	msr	sctlr_el1, x2			// disable the MMU
>  	isb
> -	ret	x0
> +
> +	cbz	x0, 1f				// el2_switch?
> +	mov	x0, x1
> +	mov	x1, xzr
> +	mov	x2, xzr
> +	mov	x3, xzr
> +	hvc	#HVC_CALL_FUNC			// no return

If that's the only user of HVC_CALL_FUNC, why do we bother with
arguments, calling convention?

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
