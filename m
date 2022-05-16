From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 16 May 2022 13:08:15 -0300
Subject: [PATCH 22/30] panic: Introduce the panic post-reboot notifier list
In-Reply-To: <YoJjpBrz34QO+rn9@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-23-gpiccoli@igalia.com> <YoJjpBrz34QO+rn9@alley>
Message-ID: <cfc89eba-1079-6c80-4806-1fb8af1404f1@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 16/05/2022 11:45, Petr Mladek wrote:
> [...]
> 
> The patch looks good to me. I would just suggest two changes.
> 
> 1. I would rename the list to "panic_loop_list" instead of
>    "panic_post_reboot_list".
> 
>    It will be more clear that it includes things that are
>    needed before panic() enters the infinite loop.
> 
> 
> 2. I would move all the notifiers that enable blinking here.
> 
>    The blinking should be done only during the infinite
>    loop when there is nothing else to do. If we enable
>    earlier then it might disturb/break more important
>    functionality (dumping information, reboot).
> 

Perfect, I agree with you. I'll change both points in V2 =)

