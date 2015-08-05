Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ig0-x232.google.com ([2607:f8b0:4001:c05::232])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZN2PA-0006aI-KC
 for kexec@lists.infradead.org; Wed, 05 Aug 2015 17:23:05 +0000
Received: by igbpg9 with SMTP id pg9so119185345igb.0
 for <kexec@lists.infradead.org>; Wed, 05 Aug 2015 10:22:42 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 5 Aug 2015 13:22:42 -0400
Message-ID: <CAAn3ePJ9WS_Mmq4Rqc4KzKdV9-tRctTL=pDCgo-dbP+PeruAXA@mail.gmail.com>
Subject: Re: kexec of FIT image hangs, however kexec of zImage and DTB succeeds
From: Justin DeFields <justindefields@gmail.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Sorry, the command I'm using for the FIT section is:

CMDLINE=$(zcat /proc/cmdline)
kexec -l /boot/kernel_fdt.itb --append="$CMDLINE"
kexec -e

Justin D.


On Wed, Aug 5, 2015 at 1:18 PM, Justin DeFields
<justindefields@gmail.com> wrote:
> All,
>
> I'm having an issue on my ARM based platform (Xilinx Zynq, dual
> cortex-A9 ARM cores, 512MB RAM) where linux is hanging after 'kexec
> -e' is performed when I provide a FIT (flattened image tree) image:
>
> CMDLINE=$(zcat /proc/cmdline)
> kexec -l /boot/zImage  --append="$CMDLINE" --dtb=/boot/system.dtb
> kexec -e
> ---console output---
> kexec: Starting new kernel
> Disabling non-boot CPUs ...
> CPU1: shutdown
> Bye!
> -- unit hangs indefinitely
>
>
> But 'kexec -e' succeeds when the files are passed in seperately:
>
> CMDLINE=$(zcat /proc/cmdline)
> kexec -l /boot/zImage  --append="$CMDLINE" --dtb=/boot/system.dtb
> kexec -e
> ---console output---
> kexec: Starting new kernel
> Disabling non-boot CPUs ...
> CPU1: shutdown
> Bye!
> console [ttyPS0] enabled
> bootconsole [earlycon0] disabled
> -- unit gets all the way to root login
>
> I am thinking that perhaps there is an issue pulling zImage out of the
> FIT image somewhere in the kexec code.  Is anyone familiar with this,
> or has seen a similar issue?
>
> Thanks,
>
> Justin DeFields
> Embedded Software Engineer



-- 
Justin DeFields
Embedded Software Engineer
(215)514-3035

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
