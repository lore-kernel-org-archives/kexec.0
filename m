Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 31 Jul 2019 16:50:42 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC v2 8/8] arm64, kexec: enable MMU during kexec relocation
Message-ID: <20190731155042.GF39768@lakrids.cambridge.arm.com>
References: <20190731153857.4045-1-pasha.tatashin@soleen.com>
 <20190731153857.4045-9-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190731153857.4045-9-pasha.tatashin@soleen.com>
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, james.morse@arm.com, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jul 31, 2019 at 11:38:57AM -0400, Pavel Tatashin wrote:
> +/*
> + * The following code is adoped from "Bare-metal Boot Code for ARMv8-A
> + * Processors Version 1.0, 5.3.1 Cleaning and invalidating the caches".
> + * http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dai0527a
> + */
> +.macro dcache_invalidate tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8
> +	mov	\tmp0, #0x0			/* tmp0 = Cache level */
> +	msr	CSSELR_EL1, \tmp0		/* 0x0 for L1, 0x2 for L2 */
> +	mrs	\tmp4, CCSIDR_EL1		/* Read Cache Size ID */
> +	and	\tmp1, \tmp4, #0x7
> +	add	\tmp1, \tmp1, #0x4		/* tmp1 Cache Line Size */
> +	ldr	\tmp3, =0x7fff
> +	and	\tmp2, \tmp3, \tmp4, lsr #13	/* tmp2 Cache Set num - 1 */
> +	ldr	\tmp3, =0x3ff
> +	and	\tmp3, \tmp3, \tmp4, lsr #3	/* tmp3 Cache Assoc. num - 1 */
> +	clz	\tmp4, \tmp3			/* tmp4 way pos. in the CISW */
> +	mov	\tmp5, #0			/* tmp5 way counter way_loop */
> +1: /* way_loop */
> +	mov	\tmp6, #0			/* tmp6 set counter set_loop */
> +2: /* set_loop */
> +	lsl	\tmp7, \tmp5, \tmp4
> +	orr	\tmp7, \tmp0, \tmp7		/* Set way */
> +	lsl	\tmp8, \tmp6, \tmp1
> +	orr	\tmp7, \tmp7, \tmp8		/* Set set */
> +	dc	cisw, \tmp7			/* Clean & Inval. cache line */
> +	add	\tmp6, \tmp6, #1		/* Increment set counter */
> +	cmp	\tmp6, \tmp2			/* Last set reached yet? */
> +	ble	2b				/* If not, iterate set_loop, */
> +	add	\tmp5, \tmp5, #1		/* else, next way. */
> +	cmp	\tmp5, \tmp3			/* Last way reached yet? */
> +	ble	1b				/* If not, iterate way_loop. */
> +.endm
> +

For various reasons, one cannot safely use Set/Way operations in
portable code. They only make sense for low-level platform-specific
firmware performing power management operations.

If you need to perform D-cache maintenance, you must use the VA
operations to do so.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
