Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <56E2AE87.4060209@arm.com>
Date: Fri, 11 Mar 2016 11:39:51 +0000
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v14 14/20] arm64/kexec: Add pr_debug output
References: <cover.1457135058.git.geoff@infradead.org>
 <b11ec7d6be4debe94cd91c20d218f4015980d057.1457135058.git.geoff@infradead.org>
In-Reply-To: <b11ec7d6be4debe94cd91c20d218f4015980d057.1457135058.git.geoff@infradead.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Geoff,

On 04/03/16 23:51, Geoff Levand wrote:
> To aid in debugging kexec problems or when adding new functionality to kexec add
> a new routine kexec_image_info() and several inline pr_debug statements.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

[ ... snip ...]

> +/**
> + * kexec_image_info - For debugging output.
> + */
> +#define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
> +static void _kexec_image_info(const char *func, int line,
> +	const struct kimage *kimage)
> +{
> +	unsigned long i;
> +

> +#ifndef DEBUG
> +	return;
> +#endif

From include/linux/printk.h on pr_foo():
> * All of these will print unconditionally, although note that pr_debug()
> * and other debug macros are compiled out unless either DEBUG is defined

So you can remove the #ifdef ... return, as all the pr_debug() calls will be
removed by the compiler in this case. (which also explains why it doesn't
complain about unreachable code!)


> +	pr_debug("%s:%d:\n", func, line);
> +	pr_debug("  kexec kimage info:\n");
> +	pr_debug("    type:        %d\n", kimage->type);
> +	pr_debug("    start:       %lx\n", kimage->start);
> +	pr_debug("    head:        %lx\n", kimage->head);
> +	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
> +
> +	for (i = 0; i < kimage->nr_segments; i++) {
> +		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages%s\n",
> +			i,
> +			kimage->segment[i].mem,
> +			kimage->segment[i].mem + kimage->segment[i].memsz,
> +			kimage->segment[i].memsz,
> +			kimage->segment[i].memsz /  PAGE_SIZE,
> +			(kexec_is_dtb(kimage->segment[i].buf) ?
> +				", dtb segment" : ""));
> +	}
> +}
> +
>  void machine_kexec_cleanup(struct kimage *kimage)
>  {
>  	/* Empty routine needed to avoid build errors. */


Thanks,

James



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
