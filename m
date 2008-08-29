Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]
	helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KZBRg-0008Fk-8W
	for kexec@lists.infradead.org; Fri, 29 Aug 2008 21:23:53 +0000
Message-ID: <48B868B9.9040706@sgi.com>
Date: Fri, 29 Aug 2008 14:23:05 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: How do i see printf output from the purgatory code?
References: <48B73F4C.5030206@sgi.com>	<20080829051907.GA25758@verge.net.au>
	<20080829095408.22f50a3f@halley.suse.de>
In-Reply-To: <20080829095408.22f50a3f@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

Bernhard Walle wrote:
> Hi,
> 
> * Simon Horman [2008-08-29 15:19]:
>> On Thu, Aug 28, 2008 at 05:14:04PM -0700, Jay Lan wrote:
>>> Specifically, an ia64.
>>>
>>> I added printf() to purgatory-ia64.c, compiled, and executed
>>> the kexec command from a shell window (ie, not from a script), but
>>> i still did not see the printf i put in.
>>>
>>> Thanks for help in advance!
>> IIRC, the printf output in purgatory only shows on the VGA console.
> 
> No, you just have to call kexec with right parameters:
> 
>        --console-serial
>               Enable the serial console.
> 
>        --serial=port
>               Specify the serial port for debug output.
> 
>        --serial-baud=baud_rate
>               Specify the baud rate of the serial port.
> 
> However, I don't know if it works on IA64, especially with SGI consoles
> I think one would have to patch kexec.
> 
> Also, don't use --noio (which is the default on SUSE on IA64 because
> we had problems on some machines without that parameter).

This is bad news. We need --noio option. :(

I have a 2.6.27 kernel that the kdump kernel would panic on boot,
depending on the physical address of 'physical_node_map'. If it
is located at the higher half of a 0xffff range, the instruction
in build_cnode_tables() in arch/ia64/sn/kernel/setup.c:
   memset(physical_node_map, -1, sizeof(physical_node_map));
would overwrite kern_memmap array of the kdump kernel.

It was so because, i think, the purgatory code of kexec
creates a boot efi_memmap with memory regions overlaped.
The above memset() put 0xff to part of memory of next region.

I am trying to debug the purgatory code :(

- jay


> 
> 
> Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
