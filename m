Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JWpuU-0007MG-M7
	for kexec@lists.infradead.org; Wed, 05 Mar 2008 09:27:39 +0000
Date: Wed, 5 Mar 2008 18:27:31 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: bug/patch for i386 EFI boot
Message-ID: <20080305092731.GB3979@verge.net.au>
References: <p0623090ac3f3b6cfa8b9@[192.168.9.5]>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <p0623090ac3f3b6cfa8b9@[192.168.9.5]>
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
To: "Scott D. Davilla" <davilla@4pi.com>
Cc: kexec@lists.infradead.org

On Tue, Mar 04, 2008 at 10:02:31PM -0500, Scott D. Davilla wrote:
> Problem:
> 	kexec fails under i386 EFI boot for hardware that does not 
> have a VGA bios or PC bios present. The EFI bootloader properly set 
> the initial screen_info boot params but kexec assumes an 
> orig_video_isVGA type of 1. This causes the kexec'd kernel assume the 
> presence of both VGA bios and normal PC BIOS and starts probing which 
> then panics somewhere I can't see because I have no console output 
> nor serial ports.
> 
> Solution:
> 	For EFI, efifb is a linear VGA framebuffer and can handle the 
> kexec kernel switch, kexec just has to setup the kernel boot params 
> properly. The below patch fixes this issue and allow a i386 EFI 
> booted kernel with no VGA bios/PC bios to kexec to another kernel.
> 
> Questions:
> 	Why is kexec assuming i386 x86 == VGA bios in the first 
> place. The existing kernel has a perfectly good screen_info stucture 
> that is an exported symbol by the kernel and could be accessed by 
> kexec. Since kexec is just pretending to be a boot loader, why does 
> it ignore information that the real bootloader (which knows a lot 
> more about the hardware) has passed? The below patch just hacks in a 
> trap for efifb and will fail in the future as other x86 hardware 
> without VGA bios/PC bios become available.
> 
> My first mainline submitted patch so be gentle :).

Hi Scott,

this looks good to me, though there is no need
to comment out unneeded lines, just remove them.

Also, if you could provide a sign-off line, as
per Section 5 of http://linux.yyz.us/patch-format.html
that would be great.

Finally, your mail reader (or something else) seems
to have mangled the patch such that leading <space><tab>
has been turned into <space><space><tab>. This isn't a bit
deal as its is easy enough for me to un-mangle it by hand.
But just so you know.

Thanks

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
