Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VtwJ8-000431-4k
 for kexec@lists.infradead.org; Fri, 20 Dec 2013 09:23:47 +0000
Date: Fri, 20 Dec 2013 17:00:34 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] makedumpfile: memset() in cyclic bitmap initialization
 introduce segment fault
Message-ID: <20131220090034.GA16537@dhcp-16-126.nay.redhat.com>
References: <20131218133402.GA23617@dhcp-17-89.nay.redhat.com>
 <52B39878.3030403@jp.fujitsu.com>
 <20131220021750.GA7962@dhcp-16-126.nay.redhat.com>
 <52B404A4.3000702@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52B404A4.3000702@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, WANG Chao <chaowang@redhat.com>

On 12/20/13 at 05:49pm, HATAYAMA Daisuke wrote:
> (2013/12/20 11:17), Dave Young wrote:
> >>Also, I'm interested in the memory map passed to from EFI in that
> >>
> >>>cat /proc/iomem:
> >>>00000000-00000fff : reserved
> >>>00001000-0009ffff : System RAM
> >>>000a0000-000bffff : PCI Bus 0000:00
> >>>000f0000-000fffff : System ROM
> >>>00100000-3d162017 : System RAM
> >>>   01000000-015cab9b : Kernel code
> >>>   015cab9c-019beb3f : Kernel data
> >>>   01b4f000-01da9fff : Kernel bss
> >>>   30000000-37ffffff : Crash kernel
> >>>3d162018-3d171e57 : System RAM
> >>>3d171e58-3d172017 : System RAM
> >>>3d172018-3d17ae57 : System RAM
> >>>3d17ae58-3dc10fff : System RAM
> >>
> >>this part is consecutive but somehow is divided into 4 entries.
> >>You called your environment as ``EFI virtual machine'', could you tell
> >>me precisely what it mean? qemu/KVM or VMware guest system? I do want
> >>to understand how this kind of memory map was created. I think this
> >>kind of memory mapping is odd and I guess this is caused by the fact
> >>that the system is a virtual environment.
> >
> >This is not specific to EFI machine, it's the reserved setup_data regions
> >They happened to be continous but they do not have to be continuous.
> >
> 
> Thanks for pointing out that. I've just read Documentation/x86/boot.txt
> and parse_setup_data().
> 
> But I don't understand well why these regions are divided as these.
> I guess kernel divides the System RAM this way and the memory map first
> passed to by EFI is all page aligned, right?

setup_data are passed as a link list by boot loader, each node is a block
of memory, there could be many different setup_data type.

> 
> Also, looking at parse_setup_data(), currently handled data in setup_data
> interface is extended e820 entries and dtb case only.
> 
>                 switch (data_type) {
>                 case SETUP_E820_EXT:
>                         parse_e820_ext(pa_data, data_len);
>                         break;
>                 case SETUP_DTB:
>                         add_dtb(pa_data);
>                         break;
>                 default:
>                         break;
>                 }
> 
> Is it right that this kind of memory map doesn't occur as long as either
> of information is passed to via setup_data? IOW, is this necessary
> information?

If bootloader does not pass it, there will be no such mem ranges in /proc/iomem.

> 
> >>
> >>And for Vivek, this case is a concrete example of multiple RAM entries
> >>appearing in a single page I suspected in the mmap failure patch,
> >>although these entries are consecutive in physical address and can be
> >>represented by a single entry by merging them in a single entry. But
> >>then it seems to me that there could be more odd case that multiple
> >>RAM entries but not consecutive. I again think this should be addressed
> >>in the patch for the mmap failure issue. How do you think?
> >
> >They are different problems, the previous mmap bug is for cross page regions
> >with different page flags.
> >
> 
> I understand that. What I think problem here is the case where multiple
> System RAM entries appear in a single page. In the above memory map, they
> are 3d171000, 3d172000 and 3d17a000. My fixing patch is to copy fractional
> pages in the 2nd kernel in order to make it possible to mmap without affecting
> non-System RAM area as much as possible, and then if there is this kind of
> System RAM entries, we need to use the same page in the 2nd kernel for
> different System RAM entries that shares the same page in the 1st kernel. This
> needs a little additional processing and we want to keep implementation as
> simple as possible as long as there's no such system in real world. However,
> I'm surprised to see the memory mapping above.

These ranges are "system ram" of type E820_RESERVED_KERN, please see below:
arch/x86/kernel/setup.c: e820_reserve_setup_data()

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
