From: Petr Mladek <pmladek@suse.com>
Date: Tue, 10 May 2022 14:14:16 +0200
Subject: [PATCH 05/30] misc/pvpanic: Convert regular spinlock into
 trylock on panic path
In-Reply-To: <20220427224924.592546-6-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-6-gpiccoli@igalia.com>
Message-ID: <YnpXGOXicwdy1E6n@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed 2022-04-27 19:48:59, Guilherme G. Piccoli wrote:
> The pvpanic driver relies on panic notifiers to execute a callback
> on panic event. Such function is executed in atomic context - the
> panic function disables local IRQs, preemption and all other CPUs
> that aren't running the panic code.
> 
> With that said, it's dangerous to use regular spinlocks in such path,
> as introduced by commit b3c0f8774668 ("misc/pvpanic: probe multiple instances").
> This patch fixes that by replacing regular spinlocks with the trylock
> safer approach.

It seems that the lock is used just to manipulating a list. A super
safe solution would be to use the rcu API: rcu_add_rcu() and
list_del_rcu() under rcu_read_lock(). The spin lock will not be
needed and the list will always be valid.

The advantage would be that it will always call members that
were successfully added earlier. That said, I am not familiar
with pvpanic and am not sure if it is worth it.

> It also fixes an old comment (about a long gone framebuffer code) and
> the notifier priority - we should execute hypervisor notifiers early,
> deferring this way the panic action to the hypervisor, as expected by
> the users that are setting up pvpanic.

This should be done in a separate patch. It changes the behavior.
Also there might be a discussion whether it really should be
the maximal priority.

Best Regards,
Petr

