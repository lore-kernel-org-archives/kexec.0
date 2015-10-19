Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1445293795.30908.50.camel@infradead.org>
Subject: Re: [PATCH V2 11/11] arm64: wait for transmit completion before
 next character transmission
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 19 Oct 2015 15:29:55 -0700
In-Reply-To: <51d1170ea05f86a1ed7bf42f384c600e98447b7a.1431582203.git.panand@redhat.com>
References: <cover.1431582203.git.panand@redhat.com>
 <51d1170ea05f86a1ed7bf42f384c600e98447b7a.1431582203.git.panand@redhat.com>
Mime-Version: 1.0
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
To: Pratyush Anand <panand@redhat.com>
Cc: takahiro.akashi@linaro.org, kexec@lists.infradead.org

Hi,

I tested this on the foundation model and it hangs.

-Geoff

On Thu, 2015-05-14 at 11:25 +0530, Pratyush Anand wrote:
> Previous transmission must be completed before next character to be
> transmitted, otherwise TX buffer may saturate and we will not see all
> the characters on screen.
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  purgatory/arch/arm64/purgatory-arm64.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/purgatory/arch/arm64/purgatory-arm64.c
> b/purgatory/arch/arm64/purgatory-arm64.c
> index 25960c30bd05..3a1c9243bfa2 100644
> --- a/purgatory/arch/arm64/purgatory-arm64.c
> +++ b/purgatory/arch/arm64/purgatory-arm64.c
> @@ -11,15 +11,37 @@ extern uint32_t *arm64_sink;
>  extern void (*arm64_kernel_entry)(uint64_t);
>  extern uint64_t arm64_dtb_addr;
>  
> +static void wait_for_xmit_complete(void)
> +{
> +	volatile uint32_t status;
> +	volatile uint32_t *status_reg;
> +
> +	/*
> +	 * Since most of the UART with ARM platform has LSR register
> at
> +	 * offset 0x14 and should have value as 0x60 for TX empty,
> so we
> +	 * have hardcoded these values. Can modify in future if need
> +	 * arises.
> +	 */
> +	status_reg = (volatile uint32_t *)((uint64_t)arm64_sink +
> 0x14);
> +	while (1) {
> +		status = *status_reg;
> +		if ((status & 0x60) == 0x60)
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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
