From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 10 May 2022 10:00:58 -0300
Subject: [PATCH 05/30] misc/pvpanic: Convert regular spinlock into trylock
 on panic path
In-Reply-To: <YnpXGOXicwdy1E6n@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-6-gpiccoli@igalia.com> <YnpXGOXicwdy1E6n@alley>
Message-ID: <0a20dd06-f459-638e-cb4d-8255ab1a1f23@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 10/05/2022 09:14, Petr Mladek wrote:
> [...]
>> With that said, it's dangerous to use regular spinlocks in such path,
>> as introduced by commit b3c0f8774668 ("misc/pvpanic: probe multiple instances").
>> This patch fixes that by replacing regular spinlocks with the trylock
>> safer approach.
> 
> It seems that the lock is used just to manipulating a list. A super
> safe solution would be to use the rcu API: rcu_add_rcu() and
> list_del_rcu() under rcu_read_lock(). The spin lock will not be
> needed and the list will always be valid.
> 
> The advantage would be that it will always call members that
> were successfully added earlier. That said, I am not familiar
> with pvpanic and am not sure if it is worth it.
> 
>> It also fixes an old comment (about a long gone framebuffer code) and
>> the notifier priority - we should execute hypervisor notifiers early,
>> deferring this way the panic action to the hypervisor, as expected by
>> the users that are setting up pvpanic.
> 
> This should be done in a separate patch. It changes the behavior.
> Also there might be a discussion whether it really should be
> the maximal priority.
> 
> Best Regards,
> Petr

Thanks for the review Petr. Patch was already merged - my goal was to be
concise, i.e., a patch per driver / module, so the patch kinda fixes
whatever I think is wrong with the driver with regards panic handling.

Do you think it worth to remove this patch from Greg's branch just to
split it in 2? Personally I think it's not worth, but opinions are welcome.

About the RCU part, this one really could be a new patch, a good
improvement patch - it makes sense to me, we can think about that after
the fixes I guess.

Cheers,


Guilherme

