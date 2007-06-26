Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86] helo=ruth.realtime.net)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I33ds-0003k9-6U
	for kexec@lists.infradead.org; Tue, 26 Jun 2007 01:31:10 -0400
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <200706210952.20232.francesco.chiechi@colibre.it>
Message-Id: <3846e5ac377656a7edf923d54935a1d6@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] kexec tools mipsel port
Date: Tue, 26 Jun 2007 00:31:10 -0500
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: francesco chiechi <francesco.chiechi@colibre.it>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Thu Jun 21 03:52:19 EDT 2007, francesco chiechi wrote:
> On Monday 04 June 2007 07:40, Horms wrote:
>> On Sat, Jun 02, 2007 at 12:21:38AM +0200, francesco chiechi wrote:
>>> Hello,
>>>
>>> We developed a patch to port kexec-tools to mips arch and included
>>> support for command line passing through elf boot notes.  We did it
>>> for a customer of ours on a specific platform derived from toshiba
>>> tx4938 (so we think it should work at least for tx4938 evaluation
>>> board also).  We would like to contribute it in case somebody else
>>> needs it or wants to improve it.  This patch works for us but the
>>> assembler part in particular, should be considered as a starting 
>>> point
>>> because my assembly knowledge is not too deep.
>>>
>>
>> I'm curious to about all the #ifdef __MIPSEL__ stuff in kexec.c.
>> Is there no chance that couldn't be placed somewhere in 
>> /kexec/arch/mipsel
>> somehow? kexec is a bit hapazard in parts, but generally there
>> isn't much #ifdef ARCH foo in there and we try and keep
>> architecture-specific and generic code separated.
>
> I am aware of this problem but I did not find a more appropriate way 
> to solve
> this. This has something to to with the way mips handles virtual 
> addresses.
> I will retry to fix this as soon as I have some time

Looking at your patch, you seem to use this _virt stuff to hold the 
argument buffers.

(1) Why do you need to allocate the buffer virtual in the generic code? 
   Just allocate the physical space, and do the translation from 
physical to virtual in the architecture code.

(2) Most ports enter purgatory with translation off.  I'm not familiar 
with MIPS, but did you consider doing this?  Your final kernel exit 
shouldn't be providing more environment than specified by the user 
code.  Don't assume the new code will be a Linux kernel.

The design of kexec is the kernel exit to userspace in a very basic 
state.  The system call provides for specifying memory contents to be 
placed at specified locations and an address to start execution.  In 
most ports, the kernel tuns off the mmu, copies the new kernel into 
place, and enters the user space supplied code in real mode.   This 
code, usually called relocate_new_kernel, is position independent (or 
is patched by the kernel exit), self-contained, and actually run from 
some address allocated in a hole of the user supplied code[1].  It is 
expected that  userspace (kexec-tools) will provide a trampoline to get 
from this basic machine state to and environment to run purgatory, then 
setup what the loaded code (new kernel) expects, including loading 
values or pointers in registers and performing any needed fixups to 
data structures.


[1]  64 bit powerpc is split somewhat differently because only a small 
fraction of memory is reachable in real mode.  We copy before killing 
the mmu.  This requires special considerations to keep the mmu alive 
during the copy.  I've written a few emails on this topic; I need to 
gather them and write a file for Documentation/).

milton


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
