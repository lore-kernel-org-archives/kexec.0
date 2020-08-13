Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6BSk-0003WZ-O5
 for kexec@lists.infradead.org; Thu, 13 Aug 2020 11:32:03 +0000
Received: by mail-pj1-x1041.google.com with SMTP id kr4so2644488pjb.2
 for <kexec@lists.infradead.org>; Thu, 13 Aug 2020 04:32:00 -0700 (PDT)
Date: Thu, 13 Aug 2020 20:31:55 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot
 and real
Message-ID: <20200813113155.GA483@jagdpanzerIV.localdomain>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
 <20200811094413.GA12903@alley>
 <87zh7175hj.fsf@nanos.tec.linutronix.de>
 <20200811130218.GI6215@alley>
 <20200813015500.GC2020879@jagdpanzerIV.localdomain>
 <20200813102258.GL12903@alley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200813102258.GL12903@alley>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, ruifeng.zhang1@unisoc.com, Steven Sistare <steven.sistare@oracle.com>, Prarit Bhargava <prarit@redhat.com>, Baoquan He <bhe@redhat.com>, zhang.lyra@gmail.com, cixi.geng1@unisoc.com, Orson Zhai <orsonzhai@gmail.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, John Ogness <john.ogness@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Jon DeVree <nuxi@vault24.org>, Thomas Gleixner <tglx@linutronix.de>, Salvatore Bonaccorso <carnil@debian.org>, Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Orson Zhai <orson.zhai@unisoc.com>, John Stultz <john.stultz@linaro.org>

On (20/08/13 12:22), Petr Mladek wrote:
>
>   + would take more space (prefix + text vs. binary representation)

Dict buffer is allocated regardless of how we use it, and only printks
from drivers/* (dev_printk*) add dict payload. It might be the case
that on some (if not most) systems dict pages are not used 90% of times
(if not 99%).

>   + not reliable because dict is currently dropped when no space

Well, in the perfect world this is a problem, but "maybe not having
alternative timestamps sometimes" can be OK approach for people who
wants to use those triplet timestamps.

But, in general, how real this problem is? What I sae so far (on my boxes)
was that printk messages are longer than dict payload.

Example:

6,223,93298,-,caller=T1;acpi PNP0A08:00: _OSC: OS supports [Segments MSI HPX-Type3]
 SUBSYSTEM=acpi
 DEVICE=+acpi:PNP0A08:00
6,224,93413,-,caller=T1;acpi PNP0A08:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
 SUBSYSTEM=acpi
 DEVICE=+acpi:PNP0A08:00
6,225,93540,-,caller=T1;PCI host bridge to bus 0000:00
6,226,93541,-,caller=T1;pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
 SUBSYSTEM=pci_bus
 DEVICE=+pci_bus:0000:00

It might be the case, that overflowing dict buffer, without first overflowing
printk buffer, can be rather challenging.

>   + it would make the controversial dictionary feature more important

Yes. But, for the time being, this controversial dict feature allocates
pages for dict buffer anyway.

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
