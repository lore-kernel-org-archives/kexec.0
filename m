Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from n24.bullet.mail.ukl.yahoo.com ([87.248.110.141])
	by bombadil.infradead.org with smtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LulW2-000416-2S
	for kexec@lists.infradead.org; Fri, 17 Apr 2009 10:41:59 +0000
Message-ID: <149724.46274.qm@web28314.mail.ukl.yahoo.com>
Date: Fri, 17 Apr 2009 10:41:46 +0000 (GMT)
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

> Thank you for the details. Can you explain why with MMU on
> it needs to
> assume in-place memory mappings? Do we always have __pa or
> __va
> available to translate between? We don't need to assume any
> mapping
> since on ppc32 you can always get to virtual address by
> adding
> PAGE_OFFSET to physical address.

Is CONFIG_HIGHMEM covered by that?

> I try to implement kexec for freescal 85xx and IBM44x
> platform so the
> current code for ppc32 definitely need to be either move to
> gamecube
> specific or I create stub for each of 85xx and 44x, which I
> try to
> avoid.

The current code is not gamecube specific, it is ppc32 generic and works for platforms that can turn off their MMU, which is the general case. 44x seems to have a lot of particularities. Guess that's why it has its own *.S's.

IMHO, at least you should try to keep the kexec interface as defined (all kexec structures use physical addresses).

If you can't turn off the MMU on those platforms, you need either to use a 1:1 mapping or deal with the special case in a special way.
You can modify the existing relocate_new_kernel and special case the 4xx or you can create a new relocate_new_kernel_4xx and use that if 4xx.

One way to follow/keep the kexec interface on 4xx for relocate_new_kernel might be:
- relocate the kernel translating physical addresses using a known mapping that can deal with all the memory that kexec is told to use to store the image (i.e. the memory that kexec_load uses to put the different pages that make up the image).
- then get rid of all the memory mappings, make sure to enable a 1:1 mapping that covers all the range of memory supported and jump to the entry point of the loaded image.

Another one could be:
- get rid of all the memory mappings, enable a 1:1 mapping and do the relocation using physical addresses (as they can be used directly then).
- jump to the entry point of the loaded image.

What do you think?

Cheers,
Albert



      


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
