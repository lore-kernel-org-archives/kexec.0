Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjcQv-0003RP-3o
 for kexec@lists.infradead.org; Fri, 14 Dec 2012 21:04:41 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so1940288bkc.36
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 13:04:35 -0800 (PST)
Message-ID: <50CB945D.7050008@gmail.com>
Date: Fri, 14 Dec 2012 22:04:29 +0100
From: Daniel Mack <zonque@gmail.com>
MIME-Version: 1.0
Subject: Re: KEXEC on ARM Cortex-A15 versatile express V2P
References: <CAJXQGfKcqFK7hBiKqEhZzvsGbFi44fFYAF+-L5+f4FQ=2V3pmQ@mail.gmail.com>
 <50CB92F0.40308@gmail.com>
In-Reply-To: <50CB92F0.40308@gmail.com>
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
To: Naresh Bhat <nareshgbhat@gmail.com>
Cc: magnus.damm@gmail.com, kexec@lists.infradead.org

On 14.12.2012 21:58, Daniel Mack wrote:
> Hi,
> 
> On 14.12.2012 18:33, Naresh Bhat wrote:
>> Thanks for the suggestions.  I really appreciate your help.
>>
>> I have tried the following in my below setup
> 
> Your should really fix your mailer. The way you quote makes it
> impossible to see which lines you added.
> 
>> My setup:
>> kexec-tools - latest GIT tree with
>> http://lists.infradead.org/pipermail/kexec/2012-December/007526.html
>> patch
>> Kernel version -   3.4.22
> 
> Why are you running a kernel from the middle ages?
> 
>> Hardware target -  V2P-CA15_A7 Cortex A15 (ARM Versatile Express)
>>
>> That could be just that the new kernel is missing its bootargs cmdline
>> with the appropriate console= tag. How are you booting the first
>> kernel?
>>
>> The first kernel command line console=tty0 console=ttyAMA0,38400n8
>> root=/dev/mmcblk0p1 rootwait ro mmci.fmax=6000000
>>
>> Does you bootloader add a /chosen tag?
>>
>> I did't understand what you are asking here .  can you please
>> elaborate little more ?
> 
> Bootloaders have two ways of passing the command line to the kernel. The
> traditional way is to stuff it into a a linked list of boot parameters
> (ATAGs), the other is to fill the /chosen/bootargs property in the
> device tree and then pass the entire tree.
> 
>> Some suggestions:
>>
>> 1. Add a static CMDLINE to the second kernel, so it doesn't rely on
>> that information being passed from the first on.
>>
>> root@arm-cortex-a15:~#  kexec -l uImage --dtb=vexpress.dtb
>> --command-line="console=tty0 console=ttyAMA0,38400n8
>> root=/dev/mmcblk0p1 rootwait ro mmci.fmax=6000000"
>> root@arm-cortex-a15:~# kexec -e
>> Starting new kernel
>> Uncompressing Linux...
> 
> If that doesn't work, your problem is not related to any cmdline issue,
> and I might have midlead you here.
> 
> Please try a newer kernel and see if that helps. The kernels I was using
> with kexec recently were 3.7-rcX.

But just to be clear: it should of course work with the version you're
running. So that might not be the reason.

And one more thing that might be a hint: check which parts of the
hardware are actually running. We experienced some weird lockups during
kexec if audio was streaming on our device, but in such cases, we didn't
see the "Uncompressing Linux..." output either.

Not sure how to help you here really.


Daniel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
