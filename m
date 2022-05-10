From: Petr Mladek <pmladek@suse.com>
Date: Tue, 10 May 2022 17:16:01 +0200
Subject: [PATCH 14/30] panic: Properly identify the panic event to the
 notifiers' callbacks
In-Reply-To: <20220427224924.592546-15-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-15-gpiccoli@igalia.com>
Message-ID: <YnqBsXBImU64PAOL@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed 2022-04-27 19:49:08, Guilherme G. Piccoli wrote:
> The notifiers infrastructure provides a way to pass an "id" to the
> callbacks to determine what kind of event happened, i.e., what is
> the reason behind they getting called.
> 
> The panic notifier currently pass 0, but this is soon to be
> used in a multi-targeted notifier, so let's pass a meaningful
> "id" over there.
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  include/linux/panic_notifier.h | 5 +++++
>  kernel/panic.c                 | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> index 41e32483d7a7..07dced83a783 100644
> --- a/include/linux/panic_notifier.h
> +++ b/include/linux/panic_notifier.h
> @@ -9,4 +9,9 @@ extern struct atomic_notifier_head panic_notifier_list;
>  
>  extern bool crash_kexec_post_notifiers;
>  
> +enum panic_notifier_val {
> +	PANIC_UNUSED,
> +	PANIC_NOTIFIER = 0xDEAD,
> +};

Hmm, this looks like a hack. PANIC_UNUSED will never be used.
All notifiers will be always called with PANIC_NOTIFIER.

The @val parameter is normally used when the same notifier_list
is used in different situations.

But you are going to use it when the same notifier is used
in more lists. This is normally distinguished by the @nh
(atomic_notifier_head) parameter.

IMHO, it is a bad idea. First, it would confuse people because
it does not follow the original design of the parameters.
Second, the related code must be touched anyway when
the notifier is moved into another list so it does not
help much.

Or do I miss anything, please?

Best Regards,
Petr

