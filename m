From: Petr Mladek <pmladek@suse.com>
Date: Tue, 10 May 2022 16:16:06 +0200
Subject: [PATCH 10/30] alpha: Clean-up the panic notifier code
In-Reply-To: <f6def662-5742-b3a8-544f-bf15c636d83d@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-11-gpiccoli@igalia.com>
 <f6def662-5742-b3a8-544f-bf15c636d83d@igalia.com>
Message-ID: <YnpzpkfuwzJYbPYj@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon 2022-05-09 11:13:17, Guilherme G. Piccoli wrote:
> On 27/04/2022 19:49, Guilherme G. Piccoli wrote:
> > The alpha panic notifier has some code issues, not following
> > the conventions of other notifiers. Also, it might halt the
> > machine but still it is set to run as early as possible, which
> > doesn't seem to be a good idea.

Yeah, it is pretty strange behavior.

I looked into the history. This notifier was added into the alpha code
in 2.4.0-test2pre2. In this historic code, the default panic() code
either rebooted after a timeout or ended in a infinite loop. There
was not crasdump at that times.

The notifier allowed to change the behavior. There were 3 notifiers:

   + mips and mips64 ended with blinking in panic()
   + alpha did __halt() in this srm case

They both still do this. I guess that it is some historic behavior
that people using these architectures are used to.

Anyway, it makes sense to do this as the last notifier after
dumping other information.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

