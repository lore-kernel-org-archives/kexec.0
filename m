Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjVxC-0002Ng-FF
 for kexec@lists.infradead.org; Fri, 14 Dec 2012 14:09:31 +0000
Received: by mail-wg0-f51.google.com with SMTP id gg4so1327342wgb.18
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 06:09:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50B8C259.9080902@gmail.com>
References: <CAJXQGfJRQ9SO5MLpG5RC1DffaRRaWvRzpX1Rq=wEM5V=Pm31EA@mail.gmail.com>
 <50B8C259.9080902@gmail.com>
Date: Fri, 14 Dec 2012 19:39:19 +0530
Message-ID: <CAJXQGf+PoAZY+HcEGSCK_9hS7a3SXX76evENmugbd0uUSZ0Bug@mail.gmail.com>
Subject: Re:
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
To: s.neumann@raumfeld.com
Cc: magnus.damm@gmail.com, kexec@lists.infradead.org, Daniel Mack <zonque@gmail.com>

Hi Sven Neumann,

I can see you have tested a patch from "Daniel Mack"
http://lists.infradead.org/pipermail/kexec/2012-December/007526.html

Can you please help me with the following

1. On which target it has been tested ?
2. Which kernel is used for testing ?
3. What are the --command-line arguments you have passed ?

I really appreciate your help.

Thanks and Regards
-Naresh Bhat

On Fri, Nov 30, 2012 at 7:57 PM, Daniel Mack <zonque@gmail.com> wrote:
> On 30.11.2012 14:58, Naresh Bhat wrote:
>> Hi,
>>
>> I am using Versatile express target at Daughterboard Site 1:
>> V2P-CA15_A7 Cortex A15
>>
>> root@arm-cortex-a15:~# kexec -f zImage --dtb=vexpress.dtb
>> --append="root=/dev/nfs rw ip=dhcp
>> nfsroot=<Host-IP>:/mnt/sda3/nfs/cortexa15/core-image
>> console=ttyAMA0,38400n8 nosmp"
>> Starting new kernel
>> Bye!
>> Uncompressing Linux...
>
> That could be just that the new kernel is missing its bootargs cmdline
> with the appropriate console= tag. How are you booting the first kernel?
> Does you bootloader add a /chosen tag?
>
> Some suggestions:
>
> 1. Add a static CMDLINE to the second kernel, so it doesn't rely on that
> information being passed from the first on.
>
> 2. Try running kexec without the --dtb option. kexec will then walk
> /proc/device-tree and build up one dynamically (CONFIG_PROC_DEVICETREE
> is needed for that).
>
> 3. Try passing --command-line to kexec. Note that this won't work
> together with --dtb, as there's currently no code that adds the cmdline
> to a dtb binary blob. But with two patches I recently submitted, it
> works with the dynamic /proc/device-tree parsing mode.
>
> 4. In case you have LEDs connected to GPIOs on your board, configure
> them to the heartbeat trigger mode. If that works, you know that the
> kernel is actually booting, but just not showing anything on the console.
>
> 5. If 4) fails, try to toggle the GPIOs very early in the boot process,
> as some sort of interface to trace the control flow, even without a JTAG.
>
> 6. In case you have CONFIG_THUMB2_KERNEL set, switch it off. I had no
> luck yet booting into a kernel that was compiled in Thumb-2 mode.
>
>
> Daniel
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
