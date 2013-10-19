Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
MIME-version: 1.0
Date: Sat, 19 Oct 2013 11:15:48 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] ARM: head-common.S: relocate atags area if necessary
In-reply-to: <20131018175414.GF25034@n2100.arm.linux.org.uk>
Message-id: <alpine.LFD.2.03.1310191059290.1951@syhkavp.arg>
References: <1382112776-20300-1-git-send-email-zonque@gmail.com>
 <20131018162956.GE25034@n2100.arm.linux.org.uk> <52616B56.10407@gmail.com>
 <20131018175414.GF25034@n2100.arm.linux.org.uk>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: kexec@lists.infradead.org, neumann@teufel.de, linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>

On Fri, 18 Oct 2013, Russell King - ARM Linux wrote:

> When things were at a fixed location, they were always placed at
> around 256 bytes into the memory, below the kernel.  I guess now people
> are placing them at some random location elsewhere.
> 
> This is becoming more a more of a pain.  We have all sorts of randomly
> placed objects in memory now that its only a matter of time before we
> hit something.  We keep on dreaming up these "well, let's move it"
> solutions but does that really help?  Move it to where?  Another place
> where we think there isn't going to be anything?  What if there is?

This is why I suggested adding a recommendation for placing the 
initrd/DTB/ATAGs above the 128MB boundary from start of RAM in the ARM 
booting document.

The zImage code does have to take into account the location of the final 
kernel's .bss area in order to properly accommodate appended DTB to 
zImage, otherwise the simple relocation of the decompressor (with its 
appended DTB) out of the way of the final kernel image is not sufficient 
to guarantee that the appended DTB won't be overwritten.

But I think that this is the extent of what we should do.  We already 
don't relocate the initrd if it is in the way either.  Trying to make 
everything automagically relocate properly in all cases during very 
early boot is very difficult, so it is best to simply not attempt it.  
On the other hand, the loader agent, whether it is kexec or a 
bootloader, should be aware of all the available RAM and could therefore 
make things safe.

If you have the ability to load the DTB and/or ATAG independently from 
zImage or uncompressed Image (which is not the case for the appended 
DTB) then it is your responsibility to load it sufficiently far away 
from the kernel.  Same rule applies for the initrd.  Hence the "above 
128MB from start of RAM" recommendation.


Nicolas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
