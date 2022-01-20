From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Thu, 20 Jan 2022 12:51:11 -0300
Subject: [PATCH V3] panic: Move panic_print before kmsg dumpers
In-Reply-To: <YektvNyN6mAHv9jJ@alley>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv> <YegytkfED+QI56Y8@alley>
 <94bb12a2-a788-cee6-7d4f-dc0ac581fb39@igalia.com> <YektvNyN6mAHv9jJ@alley>
Message-ID: <4de89aeb-c127-908c-b403-f9cea128a0b0@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 20/01/2022 06:39, Petr Mladek wrote:
> [...]
> It makes perfect sense to disable the watchdogs during panic().
> For example, rcu_panic() just sets a variable:
> 
> static int rcu_panic(struct notifier_block *this, unsigned long ev, void *ptr)
> {
> 	rcu_cpu_stall_suppress = 1;
> 	return NOTIFY_DONE;
> }
> 
> It is quick and super-safe. It might make sense to implement similar
> thing for other watchdogs and do something like:
> 
> void panic_supress_watchdogs(void)
> {
> 	rcu_panic();
> 	softlockup_watchog_panic();
> 	wq_watchog_panic();
> }
> 
> It might be caller early in panic().
> 

For reference, I saw your great input about this subject in another
related thread, which I think we should mention here:

https://lore.kernel.org/lkml/Yel8WQiBn%2FHNQN83 at alley/


> JFYI, there is an extension for the crash tool that might be able to read
> the trace log, see https://crash-utility.github.io/extensions.html
> 
> I haven't tested it myself yet.

Thanks, nice to know =)

