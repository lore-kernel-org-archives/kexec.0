Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v12 16/16] arm64: kexec_file: add kaslr support
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-17-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <50b31f17-fc85-aa72-06f5-d3b62060a91f@arm.com>
Date: Thu, 26 Jul 2018 14:40:49 +0100
MIME-Version: 1.0
In-Reply-To: <20180724065759.19186-17-takahiro.akashi@linaro.org>
Content-Language: en-US
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
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, schwidefsky@de.ibm.com, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

Hi Akashi,

On 24/07/18 07:57, AKASHI Takahiro wrote:
> Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
> address randomization, at secondary kernel boot.

Hmm, there are three things that get moved by CONFIG_RANDOMIZE_BASE. The kernel
physical placement when booted via the EFIstub, the kernel-text VAs and the
location of memory in the linear-map region. Adding the kaslr-seed only does the
last two.

This means the physical placement of the new kernel is predictable from
/proc/iomem ... but this also tells you the physical placement of the current
kernel, so I don't think this is a problem.


> We always do this as it will have no harm on kaslr-incapable kernel.

> We don't have any "switch" to turn off this feature directly, but still
> can suppress it by passing "nokaslr" as a kernel boot argument.


> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 7356da5a53d5..47a4fbd0dc34 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -158,6 +160,12 @@ static int setup_dtb(struct kimage *image,

Don't you need to reserve some space in the area you vmalloc()d for the DT?


> +	/* add kaslr-seed */
> +	get_random_bytes(&value, sizeof(value));

What happens if the crng isn't ready?

It looks like this will print a warning that these random-bytes aren't really up
to standard, but the new kernel doesn't know this happened.

crng_ready() isn't exposed, all we could do now is
wait_for_random_bytes(), but that may wait forever because we do this
unconditionally.

I'd prefer to leave this feature until we can check crng_ready(), and skip
adding a dodgy-seed if its not-ready. This avoids polluting the next-kernel's
entropy pool.


> +	ret = fdt_setprop(buf, nodeoffset, "kaslr-seed", &value, sizeof(value));

Nit: It would be nice if this string were in a header file somewhere, to void
future refactoring typos.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
