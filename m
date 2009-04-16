Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from brm-mailgate-2.brocade.com ([144.49.197.3])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LuayI-0003XZ-QI
	for kexec@lists.infradead.org; Thu, 16 Apr 2009 23:26:25 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: about ppc32/kexec
Date: Thu, 16 Apr 2009 16:25:38 -0700
Message-ID: <4C94DE2070B172459E4F1EE14BD2364E02D87A3B@HQ-EXCH-5.corp.brocade.com>
In-Reply-To: <415970.75253.qm@web28316.mail.ukl.yahoo.com>
References: <415970.75253.qm@web28316.mail.ukl.yahoo.com>
From: "Ming Lei" <mlei@Brocade.COM>
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
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: kexec@lists.infradead.org

Albert,

Thank you for the details. Can you explain why with MMU on it needs to
assume in-place memory mappings? Do we always have __pa or __va
available to translate between? We don't need to assume any mapping
since on ppc32 you can always get to virtual address by adding
PAGE_OFFSET to physical address.

I try to implement kexec for freescal 85xx and IBM44x platform so the
current code for ppc32 definitely need to be either move to gamecube
specific or I create stub for each of 85xx and 44x, which I try to
avoid.

Ming


> I don't understand why you choose to turn the MMU off on
> ppc.. Is there
> any practical reason? On Freescale 85xx which is close to
> PPC44x, I did
> not turn off MMU(I cannot) and I just rely on the current
> virtual to
> physical mapping to jump to the start address to execute
> the second
> kernel.

kexec is designed to boot whatever self contained executable image you
want (linux or any other binary). In fact, the ppc port was developed on
a GameCube, and was designed to boot Linux and non-Linux binaries from
Linux.

It currently avoids making assumptions about in-place memory mappings
and works in real addressing mode.
The MMU is turned off to switch to real mode addressing. The relocation
code works in real addressing mode to copy the image to its final place
and then jumps to the entry point of the loaded image, in real
addressing mode.
On kexec-tools, depending on the type of executable image loaded, a
small stub is used as the entry point which setups whatever environment
(address mappings if needed, etc.) the loaded binary expects, and then
jumps to the actual entry point of the binary.
In this way, the setup of the different possible environments for the
different types of binary images than can be loaded is moved from
kernelspace to userspace. The interface between the kernel and
kexec-tools is well defined and constant.

On platforms that cannot turn the MMU off you may need to choose another
approach. And you may need to fix kexec-tools too to account for that.

Cheers,
Albert



      


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
