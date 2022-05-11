From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 11 May 2022 17:10:06 -0300
Subject: [PATCH 10/30] alpha: Clean-up the panic notifier code
In-Reply-To: <YnpzpkfuwzJYbPYj@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-11-gpiccoli@igalia.com>
 <f6def662-5742-b3a8-544f-bf15c636d83d@igalia.com> <YnpzpkfuwzJYbPYj@alley>
Message-ID: <37190938-8133-aafa-ea4a-e50f574dd73b@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 10/05/2022 11:16, Petr Mladek wrote:
> [...]
> Yeah, it is pretty strange behavior.
> 
> I looked into the history. This notifier was added into the alpha code
> in 2.4.0-test2pre2. In this historic code, the default panic() code
> either rebooted after a timeout or ended in a infinite loop. There
> was not crasdump at that times.
> 
> The notifier allowed to change the behavior. There were 3 notifiers:
> 
>    + mips and mips64 ended with blinking in panic()
>    + alpha did __halt() in this srm case
> 
> They both still do this. I guess that it is some historic behavior
> that people using these architectures are used to.
> 
> Anyway, it makes sense to do this as the last notifier after
> dumping other information.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr

Thanks a bunch for the review - added your tag for V2 =)

