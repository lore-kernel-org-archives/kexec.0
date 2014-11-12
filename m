Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XofCD-0006hX-Iu
 for kexec@lists.infradead.org; Wed, 12 Nov 2014 21:11:23 +0000
Date: Wed, 12 Nov 2014 22:10:50 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [Qemu-devel] uniquely identifying KDUMP files that originate
 from QEMU
Message-ID: <20141112221050.47189fcd@hananiah.suse.cz>
In-Reply-To: <5463803F.5020209@codeaurora.org>
References: <5461F18C.2080400@redhat.com> <54624710.6070306@codeaurora.org>
 <20141112090554.6dc15b9f@hananiah.suse.cz>
 <54635E0C.5090802@codeaurora.org>
 <20141112142601.58a4c214@hananiah.suse.cz>
 <54636A42.9020508@redhat.com> <54637322.5060101@codeaurora.org>
 <546376AF.20801@redhat.com> <5463803F.5020209@codeaurora.org>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Christopher Covington <cov@codeaurora.org>
Cc: Wen Congyang <wency@cn.fujitsu.com>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>, kexec@lists.infradead.org, qemu devel list <qemu-devel@nongnu.org>, Qiao Nuohan <qiaonuohan@cn.fujitsu.com>, Dave Anderson <anderson@redhat.com>, kumagai-atsushi@mxc.nes.nec.co.jp, Laszlo Ersek <lersek@redhat.com>, crash-utility@redhat.com

On Wed, 12 Nov 2014 10:43:59 -0500
Christopher Covington <cov@codeaurora.org> wrote:

> On 11/12/2014 10:03 AM, Laszlo Ersek wrote:
> > On 11/12/14 15:48, Christopher Covington wrote:
> >> Thanks Petr and Laszlo for entertaining my questions. I've got one last one if
> >> you have the time.
> >>
> >> On 11/12/2014 09:10 AM, Laszlo Ersek wrote:
> >>> On 11/12/14 14:26, Petr Tesarik wrote:
> >>>> On Wed, 12 Nov 2014 08:18:04 -0500
> >>>> Christopher Covington <cov@codeaurora.org> wrote:
> >>>>
> >>>>> On 11/12/2014 03:05 AM, Petr Tesarik wrote:
> >>>>>> On Tue, 11 Nov 2014 12:27:44 -0500
> >>>>>> Christopher Covington <cov@codeaurora.org> wrote:
> >>>>>>
> >>>>>>> On 11/11/2014 06:22 AM, Laszlo Ersek wrote:
> >>>>>>>> (Note: I'm not subscribed to either qemu-devel or the kexec list; please
> >>>>>>>> keep me CC'd.)
> >>>>>>>>
> >>>>>>>> QEMU is able to dump the guest's memory in KDUMP format (kdump-zlib,
> >>>>>>>> kdump-lzo, kdump-snappy) with the "dump-guest-memory" QMP command.
> >>>>>>>>
> >>>>>>>> The resultant vmcore is usually analyzed with the "crash" utility.
> >>>>>>>>
> >>>>>>>> The original tool producing such files is kdump. Unlike the procedure
> >>>>>>>> performed by QEMU, kdump runs from *within* the guest (under a kexec'd
> >>>>>>>> kdump kernel), and has more information about the original guest kernel
> >>>>>>>> state (which is being dumped) than QEMU. To QEMU, the guest kernel state
> >>>>>>>> is opaque.
> >>>>>>>>
> >>>>>>>> For this reason, the kdump preparation logic in QEMU hardcodes a number
> >>>>>>>> of fields in the kdump header. The direct issue is the "phys_base"
> >>>>>>>> field. Refer to dump.c, functions create_header32(), create_header64(),
> >>>>>>>> and "include/sysemu/dump.h", macro PHYS_BASE (with the replacement text
> >>>>>>>> "0").
> >>>>>>>>
> >>>>>>>> http://git.qemu.org/?p=qemu.git;a=blob;f=dump.c;h=9c7dad8f865af3b778589dd0847e450ba9a75b9d;hb=HEAD
> >>>>>>>>
> >>>>>>>> http://git.qemu.org/?p=qemu.git;a=blob;f=include/sysemu/dump.h;h=7e4ec5c7d96fb39c943d970d1683aa2dc171c933;hb=HEAD
> >>>>>>>>
> >>>>>>>> This works in most cases, because the guest Linux kernel indeed tends to
> >>>>>>>> be loaded at guest-phys address 0. However, when the guest Linux kernel
> >>>>>>>> is booted on top of OVMF (which has a somewhat unusual UEFI memory map),
> >>>>>>>> then the guest Linux kernel is loaded at 16MB, thereby getting out of
> >>>>>>>> sync with the phys_base=0 setting visible in the KDUMP header.
> >>>>>>>>
> >>>>>>>> This trips up the "crash" utility.
> >>>>>>>>
> >>>>>>>> Dave worked around the issue in "crash" for ELF format dumps -- "crash"
> >>>>>>>> can identify QEMU as the originator of the vmcore by finding the QEMU
> >>>>>>>> notes in the ELF vmcore. If those are present, then "crash" employs a
> >>>>>>>> heuristic, probing for a phys_base up to 32MB, in 1MB steps.
> >>>>>>>
> >>>>>>> What advantages does KDUMP have over ELF?
> >>>>>>
> >>>>>> It's smaller (data is compressed), and it contains a header with some
> >>>>>> useful information (e.g. the crashed kernel's version and release).
> >>>
> >>> Another advantage is that all zero-filled pages are represented in the
> >>> kdump file by one shared zero page.
> >>>
> >>> The difference in speed of dumping is stunning.
> >>
> >> Would you expect using SHT_NOBITS to give a similar speedup to the ELF dumper?
> > 
> > Sorry, I don't know what SHT_NOBITS is.
> 
> My newbie understanding is that SHT_NOBITS is the section type of the .bss
> section in an everyday executable.

Heh, yes and no. Let's clarify a few things.

First, a Linux kernel dump (or a QEMU ELF dump) does not contain any
sections. It only contains program headers. The reason is that program
headers can specify both the virtual address and the physical address.
BTW this feature is used to determine the physical base of the Linux
kernel when dumping via kexec. Sections can only specify the virtual
address. Of course, program headers can achieve an effect similar to
SHT_NOBITS: by specifying a larger memory size than file size.

Now, all this does not mean you can't create a new standard that uses
sections instead (in fact, Xen DomU dumps already use ELF sections).
But of course, this new standard won't be understood by the existing
tools until somebody (you?) adds support for it. Same thing is true
for the SHF_COMPRESSED section flag.

Anyway, reuse of the zero page is a minor point. The main difference in
speed comes from using a faster compression algorithm (LZO or snappy).
Of course, nothing prevents you from using those algorithms in ELF
compressed sections, but you'd have to extend the ELF standard first,
adding magic numbers for these algorithms. To me it sounds like a long
way to go.

In short, there's no technical reason why ELF couldn't achieve results
similar to KDUMP. It's "merely" not implemented, and for sure, I'm not
going to push all the necessary changes. ;-)

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
