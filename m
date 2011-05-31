Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2001:470:1f0b:1c35:abcd:42:0:1])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QRQfV-0008Tu-LW
	for kexec@lists.infradead.org; Tue, 31 May 2011 15:15:42 +0000
Message-ID: <4DE50617.7090509@linutronix.de>
Date: Tue, 31 May 2011 17:15:35 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Kexec support for PPC440x
References: <4DE345B0.8020505@in.ibm.com>
In-Reply-To: <4DE345B0.8020505@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, lkml <linux-kernel@vger.kernel.org>


Suzuki Poulose wrote:
> Index: powerpc/arch/powerpc/kernel/44x_kexec_mapping.S
> ===================================================================
> --- /dev/null
> +++ powerpc/arch/powerpc/kernel/44x_kexec_mapping.S
....

> + *
> + */
> +    bl    nxtins                /* Find our address */
> +nxtins:    mflr    r5                /* Make it accessible */

Please don't mix labels and instructions.

> +    tlbsx    r23,0,r5            /* Find entry we are in */

using tabs instead of spaces would make it look nice. Please also separate 
the arguments of the instruction i.e.
	tlbsx	r23, 0, r5


> Index: powerpc/arch/powerpc/kernel/misc_32.S
> ===================================================================
> --- powerpc.orig/arch/powerpc/kernel/misc_32.S
> +++ powerpc/arch/powerpc/kernel/misc_32.S
> @@ -736,6 +736,28 @@ relocate_new_kernel:
>      mr      r5, r31
>  
>      li    r0, 0
> +#elif defined(CONFIG_44x)  && !defined(CONFIG_47x)
> +
> +    mr    r29, r3
> +    mr    r30, r4
> +    mr    r31, r5
> +
> +#include "44x_kexec_mapping.S"

The way you setup the 1:1 mapping should be close to what you are doing on
kernel entry. Isn't it possible to include the file here and in the entry
code?

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
