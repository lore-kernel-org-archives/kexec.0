Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VWtj8-0000cz-Oi
 for kexec@lists.infradead.org; Thu, 17 Oct 2013 19:59:23 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <525FA702.5070805@jp.fujitsu.com>
Date: Thu, 17 Oct 2013 12:58:30 -0700
In-Reply-To: <525FA702.5070805@jp.fujitsu.com> (HATAYAMA Daisuke's message of
 "Thu, 17 Oct 2013 17:59:46 +0900")
Message-ID: <8738nzbrfd.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: kexec cannot find text map area if kaslr is enabled
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
Cc: ahonig@google.com, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Dave Anderson <anderson@redhat.com>, keescook@google.com, Vivek Goyal <vgoyal@redhat.com>

HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:

> Hello,
>
> I tried to use x86/kaslr branch to check if how it works with kdump
> framework.

As far as I can tell x86/kaslr is a pretty silly idea.  There don't seem
to be enough bits to make it hard to brute force, much less hard to
guess.  And it is a lot of pain to get there... Sigh.

> I found kexec doesn't work. According to the message, it looks like kexec failing
> to find kernel text map area from kcore.

Well kexec -p doesn't work. 

> $ sudo /sbin/kexec  -p --command-line="ro root=UUID=cdd5e357-d223-47ee-9d6e-d1fa78b3f8a4 rd_NO_LUKS nodmraid rd_NO_MD KEYBOARDTYPE=pc KEYTABLE=jp106 LANG=ja_JP.UTF-8 rd_NO_LVM rd_NO_DM consol\
> e=ttyS0,19200n8r trace_event=block:*,irq:*,mce:*,sched:*,signal:*,workqueue:*,scsi:* trace_buf_size=25165824 irqpoll nr_cpus=2 reset_devices cgroup_disable=memory mce=off enable_lazy_purge " --initrd=/boot/initrd-3.12.0-rc4-k\
> aslrkdump.img /boot/vmlinuz-3.12.0-rc4-kaslr
> Can't find kernel text map area from kcore
> Cannot load /boot/vmlinuz-3.12.0-rc4-kaslr
>
> From source code, it looks like kexec trying to find text map area by hard-coded
> __START_KERNEL_map address. But this is being altered by kaslr.

Looking at the code you have found the hard coded address of -2G is
fine, and actually required by the compiler.   The actual problem
appears to be that the structure of the kernel mapping has changed.
There are now two mappings in the -2GB range.  one of 10MiB and one
of 1024MiB.  Where the code was looking for a mapping of 512MiB.

The entire bit of code is a just for pretty printing the core and I
suspect could be done more robustly, possibly by reporting all of the
kernel vaddrs of the mappings.

I expect you could increase X86_64_KERNEL_TEXT_SIZE 2GiB -1 aka
0x7fffffff and the code would work.  I don't know if you would have a
recognizable text segment in the core dump.

I believe ultimately what we want is to have an elf image with all of
the same PT_LOAD segments as /proc/kcore, and the current implementation
is not general enough to do that.  So this probably makes a good
opportunity to rewrite it.

It may also make sense to have some information from /proc/kallsyms.  We
aren't doing that on i386 and have something that works, so I suspect
the same logic will work on x86_64.  At least until it is decided that
the best way to load the kernel is to randomly reorder and relink all of
the .o's in the kernel at boot time.

Eric

> static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
>                                      struct crash_elf_info *elf_info)
> <cut>
>         /* Traverse through the Elf headers and find the region where
>          * kernel is mapped. */
>         end_phdr = &ehdr.e_phdr[ehdr.e_phnum];
>         for(phdr = ehdr.e_phdr; phdr != end_phdr; phdr++) {
>                 if (phdr->p_type == PT_LOAD) {
>                         unsigned long long saddr = phdr->p_vaddr;
>                         unsigned long long eaddr = phdr->p_vaddr + phdr->p_memsz;
>                         unsigned long long size;
>
>                         /* Look for kernel text mapping header. */
>                         if ((saddr >= X86_64__START_KERNEL_map) &&
>                             (eaddr <= X86_64__START_KERNEL_map + X86_64_KERNEL_TEXT_SIZE)) {
>                                 saddr = _ALIGN_DOWN(saddr, X86_64_KERN_VADDR_ALIGN);
>                                 elf_info->kern_vaddr_start = saddr;
>                                 size = eaddr - saddr;
>                                 /* Align size to page size boundary. */
>                                 size = _ALIGN(size, align);
>                                 elf_info->kern_size = size;
>                                 dbgprintf("kernel vaddr = 0x%llx size = 0x%llx\n",
>                                         saddr, size);
>                                 return 0;
>                         }
>                 }
>         }
>         fprintf(stderr, "Can't find kernel text map area from kcore\n");
>         return -1;
>
> It seems to me that kexec needs to get runtime relocation information for example
> from /proc/kallsyms.
>
> I think there would be other part that doesn't work well due to this kind of hard coded address.
>
> FYI, here are also part of /proc/iomem and /proc/kcore information on my environment:
>
> $ readelf -l /proc/kcore
> Elf file type is CORE (Core file)
> Entry point 0x0
> There are 11 program headers, starting at offset 64
>
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   NOTE           0x00000000000002a8 0x0000000000000000 0x0000000000000000
>                  0x0000000000000c74 0x0000000000000000         0
>   LOAD           0x00007fffff601000 0xffffffffff600000 0x0000000000000000
>                  0x0000000000800000 0x0000000000800000  RWE    1000
>   LOAD           0x00007fffa3001000 0xffffffffa3000000 0x0000000000000000
>                  0x0000000000ed4000 0x0000000000ed4000  RWE    1000
>   LOAD           0x0000490000001000 0xffffc90000000000 0x0000000000000000
>                  0x00001fffffffffff 0x00001fffffffffff  RWE    1000
>   LOAD           0x00007fffc0001000 0xffffffffc0000000 0x0000000000000000
>                  0x000000003f000000 0x000000003f000000  RWE    1000
>   LOAD           0x0000080000002000 0xffff880000001000 0x0000000000000000
>                  0x000000000009a000 0x000000000009a000  RWE    1000
>   LOAD           0x00006a0000001000 0xffffea0000000000 0x0000000000000000
>                  0x0000000000003000 0x0000000000003000  RWE    1000
>   LOAD           0x0000080000101000 0xffff880000100000 0x0000000000000000
>                  0x000000007af0d000 0x000000007af0d000  RWE    1000
>   LOAD           0x00006a0000004000 0xffffea0000003000 0x0000000000000000
>                  0x0000000001ae6000 0x0000000001ae6000  RWE    1000
>   LOAD           0x0000080100001000 0xffff880100000000 0x0000000000000000
>                  0x0000000780000000 0x0000000780000000  RWE    1000
>   LOAD           0x00006a0003801000 0xffffea0003800000 0x0000000000000000
>                  0x000000001a400000 0x000000001a400000  RWE    1000
>
> 00000000-00000fff : reserved
> 00001000-0009afff : System RAM
> 0009b000-0009ffff : reserved
> 000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000c7fff : Video ROM
> 000c8000-000c8fff : Adapter ROM
> 000c9000-000cefff : Adapter ROM
> 000e0000-000fffff : reserved
>   000f0000-000fffff : System ROM
> 00100000-7b00cfff : System RAM
>   03000000-22ffffff : Crash kernel
>   23000000-2355118e : Kernel code
>   2355118f-23af95ff : Kernel data
>   23cb2000-23eadfff : Kernel bss
> 7b00d000-7b00ffff : reserved
> 7b010000-7b65efff : ACPI Non-volatile Storage
> 7b65f000-7b681fff : ACPI Tables
> 7b682000-7b7bffff : reserved
> 7b7c0000-7ba3ffff : ACPI Non-volatile Storage
> 7ba40000-7baaafff : reserved
> 7baab000-7bcfffff : ACPI Tables
> 7bd00000-7bd12fff : reserved
> 7bd13000-7bd15fff : ACPI Tables
> 7bd16000-7bd45fff : reserved
> 7bd46000-7bd5efff : ACPI Tables
> 7bd5f000-7bdfefff : reserved
> 7bdff000-7bdfffff : ACPI Tables
> 7be00000-7be4efff : reserved
>   7be1b018-7be1b067 : APEI ERST
>   7be1b070-7be1b077 : APEI ERST
>   7be1b078-7be1d017 : APEI ERST
> 7be4f000-7bf83fff : ACPI Tables
> 7bf84000-7bfcefff : ACPI Non-volatile Storage
> 7bfcf000-7bffefff : ACPI Tables
> 7bfff000-8fffffff : reserved
>   80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
> 90000000-afffffff : PCI Bus 0000:00
> <cut>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
