Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LwZsK-00018r-95
	for kexec@lists.infradead.org; Wed, 22 Apr 2009 10:40:26 +0000
References: <149724.46274.qm@web28314.mail.ukl.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 22 Apr 2009 03:40:10 -0700
In-Reply-To: <149724.46274.qm@web28314.mail.ukl.yahoo.com> (Albert Herranz's
	message of "Fri\, 17 Apr 2009 10\:41\:46 +0000 \(GMT\)")
Message-ID: <m18wltvunp.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: about ppc32/kexec
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
Cc: kexec@lists.infradead.org, Ming Lei <mlei@Brocade.COM>

Albert Herranz <albert_herranz@yahoo.es> writes:

> Hi,
>
>> Thank you for the details. Can you explain why with MMU on
>> it needs to
>> assume in-place memory mappings? Do we always have __pa or
>> __va
>> available to translate between? We don't need to assume any
>> mapping
>> since on ppc32 you can always get to virtual address by
>> adding
>> PAGE_OFFSET to physical address.
>
> Is CONFIG_HIGHMEM covered by that?
>
>> I try to implement kexec for freescal 85xx and IBM44x
>> platform so the
>> current code for ppc32 definitely need to be either move to
>> gamecube
>> specific or I create stub for each of 85xx and 44x, which I
>> try to
>> avoid.
>
> The current code is not gamecube specific, it is ppc32 generic and works for platforms that can turn off their MMU, which is the general case. 44x seems to have a lot of particularities. Guess that's why it has its own *.S's.
>
> IMHO, at least you should try to keep the kexec interface as defined (all kexec structures use physical addresses).
>
> If you can't turn off the MMU on those platforms, you need either to use a 1:1 mapping or deal with the special case in a special way.
> You can modify the existing relocate_new_kernel and special case the 4xx or you can create a new relocate_new_kernel_4xx and use that if 4xx.
>
> One way to follow/keep the kexec interface on 4xx for relocate_new_kernel might be:
> - relocate the kernel translating physical addresses using a known mapping that can deal with all the memory that kexec is told to use to store the image (i.e. the memory that kexec_load uses to put the different pages that make up the image).
> - then get rid of all the memory mappings, make sure to enable a 1:1 mapping that covers all the range of memory supported and jump to the entry point of the loaded image.
>
> Another one could be:
> - get rid of all the memory mappings, enable a 1:1 mapping and do the relocation using physical addresses (as they can be used directly then).
> - jump to the entry point of the loaded image.
>
> What do you think?

I think the loaded image should be presented with a 1:1 virtual to
physical memory mapping and get the chance to figure out what to do
from there.  It is a nice least common denominator environment that
every architecture and every variation can support, and I expect
it will facilitate code sharing with the existing gamecube port.

I don't have a clue what kind of MMU the 85xx and the 44x have.  ppc has
done all sorts of weird things in the past.  But my experience on other
architectures like alpha, ia64 and x86_64 has been that setting up the
paging infrastructure to do a 1:1 virtual to physical mapping hasn't
been too hard even when you can't turn off the MMU.  Turning off the
MMU is just easier.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
