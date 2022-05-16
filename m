From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 16 May 2022 13:11:25 -0300
Subject: [PATCH 25/30] panic, printk: Add console flush parameter and
 convert panic_print to a notifier
In-Reply-To: <YoJmKYLzPZqCDDim@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-26-gpiccoli@igalia.com> <YoJmKYLzPZqCDDim@alley>
Message-ID: <41bede24-2bc4-a85b-9ba0-0f2562f8d0ca@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 16/05/2022 11:56, Petr Mladek wrote:
> [...]
> I really like both changes. Just please split it them into two
> patchset. I mean one patch for the new "panic_console_replay"
> parameter and 2nd that moves "printk_info" into the notifier.
> 

OK sure, will do that in V2.
Thanks,


Guilherme

