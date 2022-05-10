From: Petr Mladek <pmladek@suse.com>
Date: Tue, 10 May 2022 13:38:39 +0200
Subject: [PATCH 04/30] firmware: google: Convert regular spinlock into
 trylock on panic path
In-Reply-To: <adcf6d0e-c37c-6ede-479e-29959d03d8c0@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-5-gpiccoli@igalia.com>
 <CAE=gft5Pq25L4KFoPWbftkPF-JN1ex2yws77mMJ4GQnn9W0L2g@mail.gmail.com>
 <adcf6d0e-c37c-6ede-479e-29959d03d8c0@igalia.com>
Message-ID: <YnpOv4hAPV4b+6v4@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue 2022-05-03 16:12:09, Guilherme G. Piccoli wrote:
> On 03/05/2022 15:03, Evan Green wrote:
> > [...]
> > gsmi_shutdown_reason() is a common function called in other scenarios
> > as well, like reboot and thermal trip, where it may still make sense
> > to wait to acquire a spinlock. Maybe we should add a parameter to
> > gsmi_shutdown_reason() so that you can get your change on panic, but
> > we don't convert other callbacks into try-fail scenarios causing us to
> > miss logs.
> > 
> 
> Hi Evan, thanks for your feedback, much appreciated!
> What I've done in other cases like this was to have a helper checking
> the spinlock in the panic notifier - if we can acquire that, go ahead
> but if not, bail out. For a proper example of an implementation, check
> patch 13 of the series:
> https://lore.kernel.org/lkml/20220427224924.592546-14-gpiccoli at igalia.com/ .
> 
> Do you agree with that, or prefer really a parameter in
> gsmi_shutdown_reason() ? I'll follow your choice =)

I see two more alternative solutions:

1st variant is a trick already used in console write() callbacks.
They do trylock() when oops_in_progress is set. They remember
the result to prevent double unlock when printing Oops messages and
the system will try to continue working. For example:

pl011_console_write(struct console *co, const char *s, unsigned int count)
{
[...]
	int locked = 1;
[...]
	if (uap->port.sysrq)
		locked = 0;
	else if (oops_in_progress)
		locked = spin_trylock(&uap->port.lock);
	else
		spin_lock(&uap->port.lock);

[...]

	if (locked)
		spin_unlock(&uap->port.lock);
}


2nd variant is to check panic_cpu variable. It is used in printk.c.
We might move the function to panic.h:

static bool panic_in_progress(void)
{
	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
}

and then do:

	if (panic_in_progress()) {
		...


> > Though thinking more about it, is this really a Good Change (TM)? The
> > spinlock itself already disables interrupts, meaning the only case
> > where this change makes a difference is if the panic happens from
> > within the function that grabbed the spinlock (in which case the
> > callback is also likely to panic), or in an NMI that panics within
> > that window.

As already mentioned in the other reply, panic() sometimes stops
the other CPUs using NMI, for example, see kdump_nmi_shootdown_cpus().

Another situation is when the CPU using the lock ends in some
infinite loop because something went wrong. The system is in
an unpredictable state during panic().

I am not sure if this is possible with the code under gsmi_dev.lock
but such things really happen during panic() in other subsystems.
Using trylock in the panic() code path is a good practice.

Best Regards,
Petr

