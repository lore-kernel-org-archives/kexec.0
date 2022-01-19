From: Petr Mladek <pmladek@suse.com>
Date: Wed, 19 Jan 2022 16:48:06 +0100
Subject: [PATCH V3] panic: Move panic_print before kmsg dumpers
In-Reply-To: <20220119071318.GA4977@MiWiFi-R3L-srv>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv>
Message-ID: <YegytkfED+QI56Y8@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed 2022-01-19 15:13:18, Baoquan He wrote:
> On 01/14/22 at 03:30pm, Guilherme G. Piccoli wrote:
> > The panic_print setting allows users to collect more information in a
> > panic event, like memory stats, tasks, CPUs backtraces, etc.
> > This is a pretty interesting debug mechanism, but currently the print
> > event happens *after* kmsg_dump(), meaning that pstore, for example,
> > cannot collect a dmesg with the panic_print information.
> ...... 
> 
> Thanks for the effort.                                                                                                                  
> 
> I have some concerns about this patch, and it's still not clear to me
> why the thing done in this patch is needed. Hope you don't mind if I ask
> stupid question or things have been discussed in the earlier post.
> 
> Firstly, let me add some background information and details about the
> problem with my understanding, please correct me if anthing is wrong.
> 
> Background:
> ===========
> Currently, in panic(), there are 5 different ways to try best to
> collect information:
> 1) Vmcore dumping
>    done via kdump, high weight, almost get all information we want;
>    need switch to kdump kernel immediately.

My experience is that it basically always works when it is correctly
configured. It might be tested before the crash.



> 2) Panic notifier
>    iterating those registered handlers, light weight, information got
>    depends on those panic handlers. Try its best after panic, do not reboot.


From my POV, the function of panic notifiers is not well defined. They
do various things, for example:

  + on_panic_nb() flushes s390 console buffers. It looks like a
    complex and risky code. For example, __sclp_vt220_flush_buffer()
    takes spin locks and calls timer code.

  + dump_gisb_error() prints some info but it also communicates with
    the device, see gisb_read() and gisb_write() in
    brcmstb_gisb_arb_decode_addr(). I am not sure how reliable this is.

  + parisc_panic_event() re-enables the soft-power switch. I am not
    sure how safe this is.

  + pvpanic_panic_notify() takes spin lock and does in iowrite().


The do more that just providing information. Some are risky. It is not
easy to disable a particular one.


> 3) kmsg_dump
>    iterating registered dumpers to collect as much kernel log as possible
>    to store. E.g on pstore, light weight, only kernel log, do not reboot,
>    log can be checked after system reboot.

From my POV, it is similar functionality like the crash dump.

It might make sense to allow to call kmsg_dump before panic notifiers
to reduce the risk of a breakage. But I do not have enough experience
with them to judge this.

I can't remember any bug report in this code. I guess that only
few people use kmsg_dump.


> 4)console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>    Flush to get the pending logbuf printed out to console.

My experience is that there are many problems with consoles.
There might be deadlocks because of internal locks. Some
serial consoles are incredibly slow. Messages in the console
drivers might cause infinite output. Some drivers are pretty
complex, especially tty that is often enabled.

console_flush_on_panic() makes it even worse. It resets console_sem.
It means that it tries to use the consoles even when they are
already in use.

Note that printk() tries to show the messages on the console
immediately. console_flush_on_panic() is just the last
instance when all safe ways failed.


> 5)panic_print
>    Print out more system info, including all dmesg, task states, mem
>    info, etc.

This adds more information to the kernel log. They can be requested
by kernel commandline parameter. They can be seen only on the console
at the moment.

It makes sense to allow to see them also in crash dump or kmsg_dump.

> About the change, my question is why not packing
> console_flush_on_panic(CONSOLE_FLUSH_PENDING) into panic_print(), and
> move panic_print() up to be above kmsg_dump().

As explained above. console_flush_on_panic() is a dirty hack.
It really has to be called at the end as the last resort.


> And adding panic_print_sys_info(false) before kdump might not be a good
> idea. Firstly, panicked system is very unstable, kdump need switch to
> 2nd kernel asap w/o any extra action so that it can survive and collect
> tons of information. Added panic_print_sys_info(false) is obviously
> unnecessary to kdump, and increase risk to kernel switching.

Yes, panic_print_sys_info() increases the risk that the crash dump
will not succeed. But the change makes sense because:

  + panic_print_sys_info() does nothing by default. Most users will
    not enable it together with crash dump.

  + Guilherme uses crash dump only to dump the kernel log. It might
    be more reliable than kmsg_dump. In this case, panic_print_sys_info()
    is the only way to get the extra information.

  + panic_print_sys_info() might be useful even with full crash dump.
    For example, ftrace messages are not easy to read from the memory
    dump.

Best Regards,
Petr

