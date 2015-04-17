Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yiyul-00087c-Nx
 for kexec@lists.infradead.org; Fri, 17 Apr 2015 05:34:08 +0000
Date: Fri, 17 Apr 2015 13:36:21 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH RFC 6/6] arm64: wait for transmit completion before next
 character transmission
Message-ID: <20150417053621.GA8658@dhcp-128-1.nay.redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
 <6c8a63f701e98cb7cf4ddd96ab5b509115ebdc41.1429201849.git.panand@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6c8a63f701e98cb7cf4ddd96ab5b509115ebdc41.1429201849.git.panand@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org, kexec@lists.fedoraproject.org

On 04/16/15 at 10:17pm, Pratyush Anand wrote:
> Previous transmission must be completed before next character to be
> transmitted, otherwise TX buffer may saturate and we will not see all
> the characters on screen.
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  kexec/arch/arm64/include/arch/options.h | 10 +++++++++-
>  kexec/arch/arm64/kexec-arm64.c          | 17 +++++++++++++++++
>  purgatory/arch/arm64/entry.S            | 10 ++++++++++
>  purgatory/arch/arm64/purgatory-arm64.c  | 22 +++++++++++++++++++++-
>  4 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/arm64/include/arch/options.h b/kexec/arch/arm64/include/arch/options.h
> index af14102220ea..a1f6f2cb00be 100644
> --- a/kexec/arch/arm64/include/arch/options.h
> +++ b/kexec/arch/arm64/include/arch/options.h
> @@ -8,7 +8,9 @@
>  #define OPT_PAGE_OFFSET	((OPT_MAX)+4)
>  #define OPT_PORT	((OPT_MAX)+5)
>  #define OPT_REUSE_CMDLINE	((OPT_MAX+6))
> -#define OPT_ARCH_MAX	((OPT_MAX)+7)
> +#define OPT_PORT_LSR	((OPT_MAX)+7)
> +#define OPT_PORT_LSR_VAL	((OPT_MAX)+8)
> +#define OPT_ARCH_MAX	((OPT_MAX)+9)
>  
>  #define KEXEC_ARCH_OPTIONS \
>  	KEXEC_OPTIONS \
> @@ -19,6 +21,8 @@
>  	{ "lite",         0, NULL, OPT_LITE }, \
>  	{ "page-offset",  1, NULL, OPT_PAGE_OFFSET }, \
>  	{ "port",         1, NULL, OPT_PORT }, \
> +	{ "port-lsr",     1, NULL, OPT_PORT_LSR }, \
> +	{ "port-lsr-val", 1, NULL, OPT_PORT_LSR_VAL }, \
>  	{ "ramdisk",      1, NULL, OPT_INITRD }, \
>  	{ "reuse-cmdline", 0, NULL, OPT_REUSE_CMDLINE }, \
>  
> @@ -34,6 +38,8 @@ static const char arm64_opts_usage[] __attribute__ ((unused)) =
>  "     --lite                Fast reboot, no memory integrity checks.\n"
>  "     --page-offset         Kernel page-offset for binary image load.\n"
>  "     --port=ADDRESS        Purgatory output to port ADDRESS.\n"
> +"     --port-lsr=ADDRESS    Purgatory output port line status ADDRESS.\n"
> +"     --port-lsr-val=VALUE  Purgatory output port Line status expected SET value when TX empty.\n"
>  "     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
>  "     --reuse-cmdline       Use command line arg of primary kernel.\n";
>  
> @@ -43,6 +49,8 @@ struct arm64_opts {
>  	const char *initrd;
>  	uint64_t page_offset;
>  	uint64_t port;
> +	uint64_t port_lsr;
> +	uint32_t port_lsr_val;
>  	int lite;
>  };
>  
> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> index 190037c75186..5c7445b86305 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -99,6 +99,12 @@ int arch_process_options(int argc, char **argv)
>  		case OPT_PORT:
>  			arm64_opts.port = strtoull(optarg, NULL, 0);
>  			break;
> +		case OPT_PORT_LSR:
> +			arm64_opts.port_lsr = strtoull(optarg, NULL, 0);
> +			break;
> +		case OPT_PORT_LSR_VAL:
> +			arm64_opts.port_lsr_val = strtoull(optarg, NULL, 0);
> +			break;
>  		case OPT_PAGE_OFFSET:
>  			arm64_opts.page_offset = strtoull(optarg, NULL, 0);
>  			break;
> @@ -594,6 +600,8 @@ int arm64_load_other_segments(struct kexec_info *info,
>  	unsigned long dtb_base;
>  	char *initrd_buf = NULL;
>  	uint64_t purgatory_sink;
> +	uint64_t purgatory_sink_lsr;
> +	uint32_t purgatory_sink_lsr_val;
>  	unsigned long purgatory_base;
>  	struct dtb dtb_1 = {.name = "dtb_1"};
>  	struct dtb dtb_2 = {.name = "dtb_2"};
> @@ -615,6 +623,9 @@ int arm64_load_other_segments(struct kexec_info *info,
>  	dbgprintf("%s:%d: purgatory sink: 0x%" PRIx64 "\n", __func__, __LINE__,
>  		purgatory_sink);
>  
> +	purgatory_sink_lsr = arm64_opts.port_lsr;
> +	purgatory_sink_lsr_val = arm64_opts.port_lsr_val;
> +
>  	if (arm64_opts.dtb) {
>  		dtb_2.buf = slurp_file(arm64_opts.dtb, &dtb_2.size);
>  		assert(dtb_2.buf);
> @@ -732,6 +743,12 @@ int arm64_load_other_segments(struct kexec_info *info,
>  		elf_rel_set_symbol(&info->rhdr, "arm64_sink", &purgatory_sink,
>  			sizeof(purgatory_sink));
>  
> +		elf_rel_set_symbol(&info->rhdr, "arm64_sink_lsr",
> +			&purgatory_sink_lsr, sizeof(purgatory_sink_lsr));
> +
> +		elf_rel_set_symbol(&info->rhdr, "arm64_sink_lsr_val",
> +			&purgatory_sink_lsr_val, sizeof(purgatory_sink_lsr_val));
> +
>  		elf_rel_set_symbol(&info->rhdr, "arm64_kernel_entry",
>  			&kernel_entry, sizeof(kernel_entry));
>  
> diff --git a/purgatory/arch/arm64/entry.S b/purgatory/arch/arm64/entry.S
> index 140e91d87ab1..fdb2fca774e7 100644
> --- a/purgatory/arch/arm64/entry.S
> +++ b/purgatory/arch/arm64/entry.S
> @@ -43,6 +43,11 @@ arm64_sink:
>  	.quad	0
>  size arm64_sink
>  
> +.globl arm64_sink_lsr
> +arm64_sink_lsr:
> +	.quad	0
> +size arm64_sink_lsr
> +
>  .globl arm64_kernel_entry
>  arm64_kernel_entry:
>  	.quad	0
> @@ -52,3 +57,8 @@ size arm64_kernel_entry
>  arm64_dtb_addr:
>  	.quad	0
>  size arm64_dtb_addr
> +
> +.globl arm64_sink_lsr_val
> +arm64_sink_lsr_val:
> +	.word	0

Since arm64_sink_lsr_val is declared as uint32_t, it is better to keep
the same format here.

Thanks
Minfei

> +size arm64_sink_lsr_val
> diff --git a/purgatory/arch/arm64/purgatory-arm64.c b/purgatory/arch/arm64/purgatory-arm64.c
> index 25960c30bd05..1b88bb799f54 100644
> --- a/purgatory/arch/arm64/purgatory-arm64.c
> +++ b/purgatory/arch/arm64/purgatory-arm64.c
> @@ -8,18 +8,38 @@
>  /* Symbols set by kexec. */
>  
>  extern uint32_t *arm64_sink;
> +extern uint32_t *arm64_sink_lsr;
> +extern uint32_t arm64_sink_lsr_val;
>  extern void (*arm64_kernel_entry)(uint64_t);
>  extern uint64_t arm64_dtb_addr;
>  
> +static void wait_for_xmit_complete(void)
> +{
> +	volatile uint32_t status;
> +	volatile uint32_t *status_reg = (volatile uint32_t *)arm64_sink_lsr;
> +
> +	if (!arm64_sink_lsr)
> +		return;
> +
> +	while (1) {
> +		status = *status_reg;
> +		if ((status & arm64_sink_lsr_val) == arm64_sink_lsr_val)
> +			break;
> +	}
> +}
> +
>  void putchar(int ch)
>  {
>  	if (!arm64_sink)
>  		return;
>  
> +	wait_for_xmit_complete();
>  	*arm64_sink = ch;
>  
> -	if (ch == '\n')
> +	if (ch == '\n') {
> +		wait_for_xmit_complete();
>  		*arm64_sink = '\r';
> +	}
>  }
>  
>  void setup_arch(void)
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
