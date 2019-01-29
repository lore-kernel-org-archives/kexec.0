Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goZe2-0005Wv-QV
 for kexec@lists.infradead.org; Tue, 29 Jan 2019 20:06:08 +0000
Date: Tue, 29 Jan 2019 21:05:43 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RESEND 1/3] x86/boot: Add bit fields into xloadflags for
 5-level kernel checking
In-Reply-To: <20190125022817.29506-2-bhe@redhat.com>
Message-ID: <alpine.DEB.2.21.1901292059260.1950@nanos.tec.linutronix.de>
References: <20190125022817.29506-1-bhe@redhat.com>
 <20190125022817.29506-2-bhe@redhat.com>
MIME-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, hpa@zytor.com, dyoung@redhat.com, mingo@kernel.org, kirill.shutemov@linux.intel.com

On Fri, 25 Jan 2019, Baoquan He wrote:

> Add two bit fields XLF_5LEVEL and XLF_5LEVEL_ENABLED for 5-level kernel.

These are not bit fields. These are simple bits.

> Bit XLF_5LEVEL indicates if 5-level related code is contained
> in this kernel.
> Bit XLF_5LEVEL_ENABLED indicates if CONFIG_X86_5LEVEL=y is set.

I'm confused. 

> -			.word XLF0 | XLF1 | XLF23 | XLF4
> +#ifdef CONFIG_X86_64
> +#ifdef CONFIG_X86_5LEVEL
> +#define XLF56 (XLF_5LEVEL|XLF_5LEVEL_ENABLED)
> +#else
> +#define XLF56 XLF_5LEVEL
> +#endif
> +#else
> +#define XLF56 0
> +#endif
> +
> +			.word XLF0 | XLF1 | XLF23 | XLF4 | XLF56

So this actually stores the bits, but looking at the following patch which
fixes the real issue:

> +	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
> +		pr_err("Can not jump to old 4-level kernel from 5-level kernel.\n");
> +		return ret;
> +	}

So what is XLF_5LEVEL_ENABLED used for and why does it exist at all?

Thanks,

	tglx


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
