From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 10 May 2022 10:04:08 -0300
Subject: [PATCH 04/30] firmware: google: Convert regular spinlock into
 trylock on panic path
In-Reply-To: <YnpOv4hAPV4b+6v4@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-5-gpiccoli@igalia.com>
 <CAE=gft5Pq25L4KFoPWbftkPF-JN1ex2yws77mMJ4GQnn9W0L2g@mail.gmail.com>
 <adcf6d0e-c37c-6ede-479e-29959d03d8c0@igalia.com> <YnpOv4hAPV4b+6v4@alley>
Message-ID: <c23f408f-d030-b599-19b4-8561d511ef73@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 10/05/2022 08:38, Petr Mladek wrote:
> [...]
> I see two more alternative solutions:
> 
> 1st variant is a trick already used in console write() callbacks.
> They do trylock() when oops_in_progress is set. They remember
> the result to prevent double unlock when printing Oops messages and
> the system will try to continue working. For example:
> 
> pl011_console_write(struct console *co, const char *s, unsigned int count)
> {
> [...]
> 	int locked = 1;
> [...]
> 	if (uap->port.sysrq)
> 		locked = 0;
> 	else if (oops_in_progress)
> 		locked = spin_trylock(&uap->port.lock);
> 	else
> 		spin_lock(&uap->port.lock);
> 
> [...]
> 
> 	if (locked)
> 		spin_unlock(&uap->port.lock);
> }
> 
> 
> 2nd variant is to check panic_cpu variable. It is used in printk.c.
> We might move the function to panic.h:
> 
> static bool panic_in_progress(void)
> {
> 	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
> }
> 
> and then do:
> 
> 	if (panic_in_progress()) {
> 		...

Thanks for the review Petr! I feel alternative two is way better, it
checks for panic - the oops_in_progress isn't really enough, since we
can call panic() directly, not necessarily through an oops path, correct?

For me, we could stick with the lock check, but I'll defer to Evan - I
didn't work the V2 patch yet, what do you prefer Evan?


> [...]
> As already mentioned in the other reply, panic() sometimes stops
> the other CPUs using NMI, for example, see kdump_nmi_shootdown_cpus().
> 
> Another situation is when the CPU using the lock ends in some
> infinite loop because something went wrong. The system is in
> an unpredictable state during panic().
> 
> I am not sure if this is possible with the code under gsmi_dev.lock
> but such things really happen during panic() in other subsystems.
> Using trylock in the panic() code path is a good practice.
> 
> Best Regards,
> Petr

Makes total sense, thanks for confirming!
Cheers,


Guilherme

