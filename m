From: Petr Mladek <pmladek@suse.com>
Date: Mon, 16 May 2022 16:45:56 +0200
Subject: [PATCH 22/30] panic: Introduce the panic post-reboot notifier list
In-Reply-To: <20220427224924.592546-23-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-23-gpiccoli@igalia.com>
Message-ID: <YoJjpBrz34QO+rn9@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed 2022-04-27 19:49:16, Guilherme G. Piccoli wrote:
> Currently we have 3 notifier lists in the panic path, which will
> be wired in a way to allow the notifier callbacks to run in
> different moments at panic time, in a subsequent patch.
> 
> But there is also an odd set of architecture calls hardcoded in
> the end of panic path, after the restart machinery. They're
> responsible for late time tunings / events, like enabling a stop
> button (Sparc) or effectively stopping the machine (s390).
> 
> This patch introduces yet another notifier list to offer the
> architectures a way to add callbacks in such late moment on
> panic path without the need of ifdefs / hardcoded approaches.

The patch looks good to me. I would just suggest two changes.

1. I would rename the list to "panic_loop_list" instead of
   "panic_post_reboot_list".

   It will be more clear that it includes things that are
   needed before panic() enters the infinite loop.


2. I would move all the notifiers that enable blinking here.

   The blinking should be done only during the infinite
   loop when there is nothing else to do. If we enable
   earlier then it might disturb/break more important
   functionality (dumping information, reboot).

Best Regards,
Petr

