Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]
 helo=co1outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UxmJW-0000v2-69
 for kexec@lists.infradead.org; Fri, 12 Jul 2013 22:59:47 +0000
Message-ID: <51E08A40.80900@mail.usask.ca>
Date: Fri, 12 Jul 2013 16:59:12 -0600
From: Chris Friesen <cbf123@mail.usask.ca>
MIME-Version: 1.0
Subject: Re: visible memory seems wrong in kexec crash dump kernel
References: <51DF1BBB.5060904@mail.usask.ca> <51DF2229.5010604@mail.usask.ca>
 <20130712012142.GA24112@concordia> <51E07056.8040007@mail.usask.ca>
In-Reply-To: <51E07056.8040007@mail.usask.ca>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

On 07/12/2013 03:08 PM, Chris Friesen wrote:

> I turned on the instrumentation in early_init_dt_scan_memory() and got
> the following when jumping to the capture kernel:
>
> memory scan node memory, reg size 16, data: 0 0 2 0,
> - 0 , 200000000
>
> That 0x200000000 matches the fact that I'm seeing 8GB of memory
> available in the recovery kernel.
>
> If I boot the original kernel with "crashkernel=224M@32M", should I
> expect that only 224MB is marked as "linux,usable-memory" in the
> recovery kernel?

I started looking at the kexec side of things, and I noticed something a 
bit odd.  In most places dealing with the device tree in kexec it 
accepts either "memory" or "memory@" for the memory node name.  In 
add_usable_mem_property() in arch/ppc64/fs2dt.c it seems to only accept 
"memory@".

Is this expected behaviour?  It seems to be the same in current git 
versions of kexec-tools.

On my system I see "/proc/device-tree/memory".

If I modify add_usable_mem_property() to also accept "/memory" then my 
recovery kernel boots up with

physicalMemorySize            = 0x10000000

which is 256MB (which is still a bit odd since I specified 224MB for the 
crashkernel).

However, it then hits the BUG() call at the end of mark_bootmem() in 
mm/bootmem.c.

Chris


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
