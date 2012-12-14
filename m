Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjZ92-00056e-Pj
 for kexec@lists.infradead.org; Fri, 14 Dec 2012 17:33:57 +0000
Received: by mail-wg0-f51.google.com with SMTP id gg4so1433893wgb.18
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 09:33:55 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 14 Dec 2012 23:03:54 +0530
Message-ID: <CAJXQGfKcqFK7hBiKqEhZzvsGbFi44fFYAF+-L5+f4FQ=2V3pmQ@mail.gmail.com>
Subject: KEXEC on ARM Cortex-A15 versatile express V2P
From: Naresh Bhat <nareshgbhat@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Daniel Mack <zonque@gmail.com>
Cc: magnus.damm@gmail.com, kexec@lists.infradead.org

Hi Daniel,

Thanks for the suggestions.  I really appreciate your help.

I have tried the following in my below setup

My setup:
kexec-tools - latest GIT tree with
http://lists.infradead.org/pipermail/kexec/2012-December/007526.html
patch
Kernel version -   3.4.22
Hardware target -  V2P-CA15_A7 Cortex A15 (ARM Versatile Express)

That could be just that the new kernel is missing its bootargs cmdline
with the appropriate console= tag. How are you booting the first
kernel?

The first kernel command line console=tty0 console=ttyAMA0,38400n8
root=/dev/mmcblk0p1 rootwait ro mmci.fmax=6000000

Does you bootloader add a /chosen tag?

I did't understand what you are asking here .  can you please
elaborate little more ?

Some suggestions:

1. Add a static CMDLINE to the second kernel, so it doesn't rely on
that information being passed from the first on.

root@arm-cortex-a15:~#  kexec -l uImage --dtb=vexpress.dtb
--command-line="console=tty0 console=ttyAMA0,38400n8
root=/dev/mmcblk0p1 rootwait ro mmci.fmax=6000000"
root@arm-cortex-a15:~# kexec -e
Starting new kernel
Uncompressing Linux...

2. Try running kexec without the --dtb option. kexec will then walk
/proc/device-tree and build up one dynamically (CONFIG_PROC_DEVICETREE
is needed for that).
I have enabled the CONFIG_PROC_DEVICETREE option in my kernel and I
have tried without using --dtb option

root@arm-cortex-a15:~#  kexec -l uImage --dtb=vexpress.dtb
--command-line="console=tty0 console=ttyAMA0,38400n8
root=/dev/mmcblk0p1 rootwait ro mmci.fmax=6000000"
Modified cmdline:console=tty0 console=ttyAMA0,38400n8
root=/dev/mmcblk0p1 rootwait ro mmci.fmax=6000000
Unable to find /proc/device-tree//chosen/linux,stdout-path, printing
from purgatory is diabled
root@arm-cortex-a15:~#
root@arm-cortex-a15:~# kexec -e
Starting new kernel
Uncompressing Linux...

3. Try passing --command-line to kexec. Note that this won't work
together with --dtb, as there's currently no code that adds the
cmdline to a dtb binary blob. But with two patches I recently
submitted, it works with the dynamic /proc/device-tree parsing mode.

How can I overcome from the above warning  "Unable to find
/proc/device-tree//chosen/linux,stdout-path, printing from purgatory
is diabled"

4. In case you have LEDs connected to GPIOs on your board, configure
them to the heartbeat trigger mode. If that works, you know that the
kernel is actually booting, but just not showing anything on the
console.
I will open the box on Monday and confirm the same.

5. If 4) fails, try to toggle the GPIOs very early in the boot
process, as some sort of interface to trace the control flow, even
without a JTAG.
I will try it on Monday.  BTW I do not have any JTAG.

6. In case you have CONFIG_THUMB2_KERNEL set, switch it off. I had no
luck yet booting into a kernel that was compiled in Thumb-2 mode.

By default CONFIG_THUMB2_KERNEL is desabled in my kernel


Please, provide your inputs/suggestions so that I can overcome from this issue.
Thanks and Regards
-Naresh Bhat

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
