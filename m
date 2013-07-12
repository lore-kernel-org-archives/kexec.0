Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]
 helo=co1outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UxkaS-000823-L6
 for kexec@lists.infradead.org; Fri, 12 Jul 2013 21:09:09 +0000
Message-ID: <51E07056.8040007@mail.usask.ca>
Date: Fri, 12 Jul 2013 15:08:38 -0600
From: Chris Friesen <cbf123@mail.usask.ca>
MIME-Version: 1.0
Subject: Re: visible memory seems wrong in kexec crash dump kernel
References: <51DF1BBB.5060904@mail.usask.ca> <51DF2229.5010604@mail.usask.ca>
 <20130712012142.GA24112@concordia>
In-Reply-To: <20130712012142.GA24112@concordia>
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

On 07/11/2013 07:21 PM, Michael Ellerman wrote:
> On Thu, Jul 11, 2013 at 03:22:49PM -0600, Chris Friesen wrote:
>> On 07/11/2013 02:55 PM, Chris Friesen wrote:
>>> Hi,
>>>
>>> I'm running 2.6.34 with kexec 2.0.1 on a Freescale p5020-based system
>>> with 8GB of memory.  (It's an embedded system and I can't do much
>>> about the fact that it's using older software.)
>>
>> I should probably clarify this...I may be able to update kexec, I
>> can't update the kernel but I can backport more recent code if
>> necessary.
>>
>> Looking at the version of kexec that I have, it seems like where x86
>> uses "memmap=" to specify the memory map usable by the capture
>> kernel, powerpc does something different.
>
>  From memory, it's been years, on powerpc we add properties to the memory
> nodes in the device tree that specify which memory is usable. The
> properties are called "linux,usable-memory", and in modern kernels they
> are read in early_init_dt_scan_memory().

I turned on the instrumentation in early_init_dt_scan_memory() and got 
the following when jumping to the capture kernel:

memory scan node memory, reg size 16, data: 0 0 2 0,
  - 0 ,  200000000

That 0x200000000 matches the fact that I'm seeing 8GB of memory 
available in the recovery kernel.

If I boot the original kernel with "crashkernel=224M@32M", should I 
expect that only 224MB is marked as "linux,usable-memory" in the 
recovery kernel?

Chris


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
