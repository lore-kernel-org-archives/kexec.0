From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 17 May 2022 12:32:39 -0300
Subject: [PATCH 15/30] bus: brcmstb_gisb: Clean-up panic/die notifiers
In-Reply-To: <YnqEqDnMfUgC4dM6@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-16-gpiccoli@igalia.com> <YnqEqDnMfUgC4dM6@alley>
Message-ID: <007af382-dcf5-b06d-acad-08f8d6ec7f8b@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 10/05/2022 12:28, Petr Mladek wrote:
> [...]
> IMHO, the check of the @self parameter was the proper solution.
> 
> "gisb_die_notifier" list uses @val from enum die_val.
> "gisb_panic_notifier" list uses @val from enum panic_notifier_val.
> 
> These are unrelated types. It might easily break when
> someone defines the same constant also in enum die_val.
> 
> Best Regards,
> Petr

OK Petr, I'll drop this idea for V2 - will just remove the useless
header / prototype then. (CC Florian)


Cheers,


Guilherme

