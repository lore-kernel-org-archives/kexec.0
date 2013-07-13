Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]
 helo=tx2outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UxtMZ-00040P-8a
 for kexec@lists.infradead.org; Sat, 13 Jul 2013 06:31:25 +0000
Message-ID: <51E0F41A.20904@mail.usask.ca>
Date: Sat, 13 Jul 2013 00:30:50 -0600
From: Chris Friesen <cbf123@mail.usask.ca>
MIME-Version: 1.0
Subject: Re: visible memory seems wrong in kexec crash dump kernel
References: <51DF1BBB.5060904@mail.usask.ca> <51DF2229.5010604@mail.usask.ca>
 <20130712012142.GA24112@concordia> <51E07056.8040007@mail.usask.ca>
 <51E08A40.80900@mail.usask.ca>
In-Reply-To: <51E08A40.80900@mail.usask.ca>
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

On 07/12/2013 04:59 PM, Chris Friesen wrote:
> On 07/12/2013 03:08 PM, Chris Friesen wrote:
>
>> I turned on the instrumentation in early_init_dt_scan_memory() and got
>> the following when jumping to the capture kernel:
>>
>> memory scan node memory, reg size 16, data: 0 0 2 0,
>> - 0 , 200000000
>>
>> That 0x200000000 matches the fact that I'm seeing 8GB of memory
>> available in the recovery kernel.
>>
>> If I boot the original kernel with "crashkernel=224M@32M", should I
>> expect that only 224MB is marked as "linux,usable-memory" in the
>> recovery kernel?
>
> I started looking at the kexec side of things, and I noticed something a
> bit odd. In most places dealing with the device tree in kexec it accepts
> either "memory" or "memory@" for the memory node name. In
> add_usable_mem_property() in arch/ppc64/fs2dt.c it seems to only accept
> "memory@".
>
> Is this expected behaviour? It seems to be the same in current git
> versions of kexec-tools.
>
> On my system I see "/proc/device-tree/memory".
>
> If I modify add_usable_mem_property() to also accept "/memory" then my
> recovery kernel boots up with
>
> physicalMemorySize = 0x10000000
>
> which is 256MB (which is still a bit odd since I specified 224MB for the
> crashkernel).
>
> However, it then hits the BUG() call at the end of mark_bootmem() in
> mm/bootmem.c.

One final thing and I'll stop replying to myself. :)

It looks like the problem is that some board-specific freescale code was 
calling lmb_reserve() with a base address in the 4GB range.  It seems 
odd that lmb_reserve() didn't throw some kind of error when the recovery 
kernel was supposed to be limited to 224MB.

Rather than try and fix the bug, I turned off the (unneeded) config 
options related to the above lmb_reserve() calls and was able to 
successfully access the information I needed via /dev/oldmem.

The upshot is that there seems to be a number of things that could be 
improved:

1) kexec should accept "/memory" and not just "/memory@"
2) lmb_reserve() should really respect the crashkernel memory limit
3) the freescale stuff really shouldn't assume it can map things 
wherever it feels like

Chris


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
