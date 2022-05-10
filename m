From: Petr Mladek <pmladek@suse.com>
Date: Tue, 10 May 2022 17:28:40 +0200
Subject: [PATCH 15/30] bus: brcmstb_gisb: Clean-up panic/die notifiers
In-Reply-To: <20220427224924.592546-16-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-16-gpiccoli@igalia.com>
Message-ID: <YnqEqDnMfUgC4dM6@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed 2022-04-27 19:49:09, Guilherme G. Piccoli wrote:
> This patch improves the panic/die notifiers in this driver by
> making use of a passed "id" instead of comparing pointer
> address; also, it removes an useless prototype declaration
> and unnecessary header inclusion.
> 
> This is part of a panic notifiers refactor - this notifier in
> the future will be moved to a new list, that encompass the
> information notifiers only.
> 
> --- a/drivers/bus/brcmstb_gisb.c
> +++ b/drivers/bus/brcmstb_gisb.c
> @@ -347,25 +346,14 @@ static irqreturn_t brcmstb_gisb_bp_handler(int irq, void *dev_id)
>  /*
>   * Dump out gisb errors on die or panic.
>   */
> -static int dump_gisb_error(struct notifier_block *self, unsigned long v,
> -			   void *p);
> -
> -static struct notifier_block gisb_die_notifier = {
> -	.notifier_call = dump_gisb_error,
> -};
> -
> -static struct notifier_block gisb_panic_notifier = {
> -	.notifier_call = dump_gisb_error,
> -};
> -
>  static int dump_gisb_error(struct notifier_block *self, unsigned long v,
>  			   void *p)
>  {
>  	struct brcmstb_gisb_arb_device *gdev;
> -	const char *reason = "panic";
> +	const char *reason = "die";
>  
> -	if (self == &gisb_die_notifier)
> -		reason = "die";
> +	if (v == PANIC_NOTIFIER)
> +		reason = "panic";

IMHO, the check of the @self parameter was the proper solution.

"gisb_die_notifier" list uses @val from enum die_val.
"gisb_panic_notifier" list uses @val from enum panic_notifier_val.

These are unrelated types. It might easily break when
someone defines the same constant also in enum die_val.

Best Regards,
Petr

