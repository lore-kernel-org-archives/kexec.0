Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from n26.bullet.mail.ukl.yahoo.com ([87.248.110.143])
	by bombadil.infradead.org with smtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Lua7v-0007hV-VA
	for kexec@lists.infradead.org; Thu, 16 Apr 2009 22:32:18 +0000
Message-ID: <415970.75253.qm@web28316.mail.ukl.yahoo.com>
Date: Thu, 16 Apr 2009 22:32:10 +0000 (GMT)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: RE: about ppc32/kexec
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Ming Lei <mlei@Brocade.COM>
Cc: kexec@lists.infradead.org


Hi,

> I don't understand why you choose to turn the MMU off on
> ppc.. Is there
> any practical reason? On Freescale 85xx which is close to
> PPC44x, I did
> not turn off MMU(I cannot) and I just rely on the current
> virtual to
> physical mapping to jump to the start address to execute
> the second
> kernel.

kexec is designed to boot whatever self contained executable image you want (linux or any other binary). In fact, the ppc port was developed on a GameCube, and was designed to boot Linux and non-Linux binaries from Linux.

It currently avoids making assumptions about in-place memory mappings and works in real addressing mode.
The MMU is turned off to switch to real mode addressing. The relocation code works in real addressing mode to copy the image to its final place and then jumps to the entry point of the loaded image, in real addressing mode.
On kexec-tools, depending on the type of executable image loaded, a small stub is used as the entry point which setups whatever environment (address mappings if needed, etc.) the loaded binary expects, and then jumps to the actual entry point of the binary.
In this way, the setup of the different possible environments for the different types of binary images than can be loaded is moved from kernelspace to userspace. The interface between the kernel and kexec-tools is well defined and constant.

On platforms that cannot turn the MMU off you may need to choose another approach. And you may need to fix kexec-tools too to account for that.

Cheers,
Albert



      


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
