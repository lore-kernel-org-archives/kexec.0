Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1elXTy-0004id-LG
 for kexec@lists.infradead.org; Tue, 13 Feb 2018 10:07:36 +0000
Received: by mail-qt0-x231.google.com with SMTP id q18so3014213qtl.3
 for <kexec@lists.infradead.org>; Tue, 13 Feb 2018 02:06:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFTCetR6cbs1eLwaxu_U4pXQ4f51e3L6R2Kz2z545VH6EX+ncA@mail.gmail.com>
References: <CANc8B5NV7xepYWHWZ3sYsv1uP2ofxwtw1SN2DERxfA4ta05fKw@mail.gmail.com>
 <CAFTCetR6cbs1eLwaxu_U4pXQ4f51e3L6R2Kz2z545VH6EX+ncA@mail.gmail.com>
From: Gioh Kim <gurugio@gmail.com>
Date: Tue, 13 Feb 2018 11:06:25 +0100
Message-ID: <CANc8B5NL-if_9FBoE6sHfmoUeD1zj37VcRKEYOThZBWkpo-iAQ@mail.gmail.com>
Subject: Re: how to use kexec to jump back to the original kernel
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
To: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Cc: kexec@lists.infradead.org

On Mon, Feb 12, 2018 at 7:56 AM, Bhupesh SHARMA <bhupesh.linux@gmail.com> wrote:
> Hello,
>
> On Fri, Feb 9, 2018 at 7:24 PM, Gioh Kim <gurugio@gmail.com> wrote:
>> Hello,
>>
>> "echo c > /proc/sysrq-trigger" generates the kernel dump but it
>> reboots the system.
>> I'd like to generate kernel dump without system reboot.
>>
>> I think it is possible to jump to the kdump kernel and generate kernel
>> dump, and come back to the operating kernel with kexec.
>> I know I can jump to the kdump kernel with "kexec -e" but I cannot
>> figure out how to come back to the operating kernel.
>>
>> For example, I tried following sequences after reading kexec manual page.
>>
>> 0. rebuild kernel with CONFIG_KEXEC_JUMP option
>> 1. kexec --load=/boot/vmlinuz --initrd=/boot/initrd --reuse-cmdline
>
> Instead you should be using something like:
> # kexec -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname
> -r`.img --reuse-cmdline  --load-preserve-context --mem-min=addr
> --mem-max=addr

Hello Bhupesh,

Thank you for your advice.

I tried load-preserve-context as below but it failed with "Invalid
argument" error.
There is no reason in the error message.
But there is entry address that looks like the address "kexec -e" in
the kdump kernel will jump to.
Following is what I did.

root@pserver:~# kexec -l /boot/vmlinuz-`uname -r`
--initrd=/boot/initrd.img-`uname -r` --reuse-cmdline
--load-preserve-context --mem-min=0x1000000 --mem-max=0xffffffff
kexec_load failed: Invalid argument
entry       = 0xbffcb7f0 flags = 0x3e0002
nr_segments = 7
segment[0].buf   = (nil)
segment[0].bufsz = 0x0
segment[0].mem   = 0x1000000
segment[0].memsz = 0xba080000
segment[1].buf   = 0x7fe372eaa010
segment[1].bufsz = 0x2f7fddc
segment[1].mem   = 0xbb080000
segment[1].memsz = 0x2f80000
segment[2].buf   = 0x7fe375e2e210
segment[2].bufsz = 0x61c840
segment[2].mem   = 0xbe000000
segment[2].memsz = 0x14e1000
segment[3].buf   = (nil)
segment[3].bufsz = 0x0
segment[3].mem   = 0xbf4e1000
segment[3].memsz = 0xae5000
segment[4].buf   = 0x25eb920
segment[4].bufsz = 0x42c6
segment[4].mem   = 0xbffc6000
segment[4].memsz = 0x5000
segment[5].buf   = 0x25e27c0
segment[5].bufsz = 0x9100
segment[5].mem   = 0xbffcb000
segment[5].memsz = 0xb000
segment[6].buf   = 0x25e1e20
segment[6].bufsz = 0x400
segment[6].mem   = 0xbffd6000
segment[6].memsz = 0x4000
root@pserver:~#
root@pserver:~#
root@pserver:~# kexec -e
Nothing has been loaded!

I added an output with adding -d option for your information.


>
> to let the kernel know that the primary kernel context should be
> retained so that we can return to the same once we do a 'kexec -e'
> from the secondary kernel.
>
> Can you please try the same. Also can you please share the details of
> the hardware you are using this one, AFAIK only x86 and sh
> architectures support CONFIG_KEXEC_JUMP in upstream linux.

Of course, I'm using x86 platform.
I'm testing v4.4 and v4.14 kernel on x86 Dell desktop and x86 Qemu
virtual machine.

>
> Regards,
> Bhupesh
>
>> 2. kexec -e
>> 3. now kdump kernel is running
>> 4. kexec --load-jump-back-helper --entry=<ADDRESS>
>> 5. kexec -e
>>
>> I can jump to the kdump kernel with step 1 and step 2.
>> kexec manual says I need an entry address.
>> I don't know what address I should use.
>> I found a email thread about jump_back_entry= but there is no
>> parameter like jump_back_entry in kernel booting parameters of
>> v4.4~v4.14.
>>
>> Does anybody know how to use kexec to jump between kdump kernel and
>> operating kernel?
>>
>>
>> --
>>
>> Best regards,
>> Gioh Kim
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec

Following is the output of kexec with -d option.

root@pserver:~# kexec -d -l /boot/vmlinuz-`uname -r`
--initrd=/boot/initrd.img-`uname -r` --reuse-cmdline
--load-preserve-context --mem-min=0x1000000 --mem-max=0xffffffff
kernel: 0x7fd6b55eb010 kernel_size: 0x620a40
MEMORY RANGES
0000000000000100-000000000009fbff (0)
000000000009fc00-000000000009ffff (1)
00000000000f0000-00000000000fffff (1)
0000000000100000-00000000bffd9fff (0)
00000000bffda000-00000000bfffffff (1)
00000000feffc000-00000000feffffff (1)
00000000fffc0000-00000000ffffffff (1)
0000000100000000-000000013fffffff (0)
0000000000000000-0000000000000fff : reserved
0000000000001000-000000000009fbff : System RAM
000000000009fc00-000000000009ffff : reserved
00000000000a0000-00000000000bffff : PCI Bus 0000:00
00000000000c0000-00000000000c95ff : Video ROM
00000000000c9800-00000000000ca5ff : Adapter ROM
00000000000ca800-00000000000ccbff : Adapter ROM
00000000000f0000-00000000000fffff : reserved
00000000000f0000-00000000000fffff : System ROM
0000000000100000-00000000bffd9fff : System RAM
0000000001000000-0000000001846440 : Kernel code
0000000001846441-0000000001f5baff : Kernel data
00000000020af000-000000000236efff : Kernel bss
000000002a000000-0000000031ffffff : Crash kernel
00000000bffda000-00000000bfffffff : reserved
00000000c0000000-00000000febfffff : PCI Bus 0000:00
00000000fc000000-00000000fdffffff : 0000:00:02.0
00000000fe000000-00000000fe003fff : 0000:00:06.0
00000000fe000000-00000000fe003fff : virtio-pci-modern
00000000fe004000-00000000fe007fff : 0000:00:07.0
00000000fe004000-00000000fe007fff : virtio-pci-modern
00000000fe008000-00000000fe00bfff : 0000:00:08.0
00000000fe008000-00000000fe00bfff : virtio-pci-modern
00000000feb80000-00000000febbffff : 0000:00:03.0
00000000febc0000-00000000febdffff : 0000:00:03.0
00000000febc0000-00000000febdffff : e1000
00000000febe0000-00000000febeffff : 0000:00:02.0
00000000febf0000-00000000febf0fff : 0000:00:02.0
00000000febf1000-00000000febf1fff : 0000:00:06.0
00000000febf2000-00000000febf2fff : 0000:00:07.0
00000000febf3000-00000000febf3fff : 0000:00:08.0
00000000fec00000-00000000fec003ff : IOAPIC 0
00000000fed00000-00000000fed003ff : HPET 0
00000000fed00000-00000000fed003ff : PNP0103:00
00000000fee00000-00000000fee00fff : Local APIC
00000000feffc000-00000000feffffff : reserved
00000000fffc0000-00000000ffffffff : reserved
0000000100000000-000000013fffffff : System RAM
get_backup_area: 0000000000001000-000000000009fbff : System RAM
CRASH MEMORY RANGES
0000000000000000-0000000000000fff (1)
0000000000001000-000000000009fbff (0)
000000000009fc00-000000000009ffff (1)
0000000100000000-00000000000fffff (1)
0000000000100000-00000000000effff (0)
00000000bffda000-00000000000effff (1)
00000000feffc000-00000000000effff (1)
0000000100000000-00000000feffffff (0)
00000000fffc0000-00000000000effff (1)
0000000100000000-000000013fffffff (0)
kernel load physical addr start = 0x0000000001000000
kernel symbol _stext vaddr = ffffffff810002b8
kernel vaddr = 0xffffffff81000000 size = 0x1395000
Memmap after adding segment
0000000000001000-000000000009fbff (0)
Memmap after adding segment
0000000000001000-000000000009fbff (0)
00000000000f0000-00000000ffffffff (0)
get_crash_notes_per_cpu: crash_notes addr = 137619200, size = 368
Elf header: p_type = 4, p_offset = 0x137619200 p_paddr = 0x137619200
p_vaddr = 0x0 p_filesz = 0x170 p_memsz = 0x170
get_crash_notes_per_cpu: crash_notes addr = 137639200, size = 368
Elf header: p_type = 4, p_offset = 0x137639200 p_paddr = 0x137639200
p_vaddr = 0x0 p_filesz = 0x170 p_memsz = 0x170
get_crash_notes_per_cpu: crash_notes addr = 137659200, size = 368
Elf header: p_type = 4, p_offset = 0x137659200 p_paddr = 0x137659200
p_vaddr = 0x0 p_filesz = 0x170 p_memsz = 0x170
get_crash_notes_per_cpu: crash_notes addr = 137679200, size = 368
Elf header: p_type = 4, p_offset = 0x137679200 p_paddr = 0x137679200
p_vaddr = 0x0 p_filesz = 0x170 p_memsz = 0x170
Kernel text Elf header: p_type = 1, p_offset = 0x1000000 p_paddr =
0x1000000 p_vaddr = 0xffffffff81000000 p_filesz = 0x1395000 p_memsz =
0x1395000
Elf header: p_type = 1, p_offset = 0x0 p_paddr = 0x1000 p_vaddr =
0xffff880000001000 p_filesz = 0x9ec00 p_memsz = 0x9ec00
Elf header: p_type = 1, p_offset = 0x100000 p_paddr = 0x100000 p_vaddr
= 0xffff880000100000 p_filesz = 0xffffffffffff0000 p_memsz =
0xffffffffffff0000
Elf header: p_type = 1, p_offset = 0x100000000 p_paddr = 0x100000000
p_vaddr = 0xffff880100000000 p_filesz = 0xffffffffff000000 p_memsz =
0xffffffffff000000
Elf header: p_type = 1, p_offset = 0x100000000 p_paddr = 0x100000000
p_vaddr = 0xffff880100000000 p_filesz = 0x40000000 p_memsz =
0x40000000
Created elf header segment at 0xbffd6000
Memmap after deleting segment
0000000000001000-000000000009fbff (0)
00000000000f0000-00000000bffd5fff (0)
00000000bffda000-00000000ffffffff (0)
Command line after adding elfcorehdr
root=UUID=4845fda7-1e7f-4aa8-8e09-2076ddc8e17f ro quiet
crashkernel=128M possible_cpus=512 crashkernel=384M-:128M
elfcorehdr=3145560K
Memmap after adding segment
0000000000000000-0000000000000fff (1)
0000000000001000-000000000009fbff (0)
00000000000f0000-00000000bffd5fff (0)
00000000bffda000-00000000ffffffff (0)
Memmap after adding segment
0000000000000000-0000000000000fff (1)
0000000000001000-000000000009fbff (0)
000000000009fc00-000000000009ffff (1)
00000000000f0000-00000000bffd5fff (0)
00000000bffda000-00000000ffffffff (0)
Memmap after adding segment
0000000000000000-0000000000000fff (1)
0000000000001000-000000000009fbff (0)
000000000009fc00-000000000009ffff (1)
00000000000f0000-00000000bffd5fff (0)
00000000bffda000-00000000ffffffff (0)
0000000100000000-00000000000fffff (1)
Memmap after adding segment
0000000000000000-0000000000000fff (1)
0000000000001000-000000000009fbff (0)
000000000009fc00-000000000009ffff (1)
00000000000f0000-00000000bffd5fff (0)
00000000bffda000-00000000ffffffff (0)
0000000100000000-00000000000fffff (1)
00000000bffda000-00000000000effff (1)
Memmap after adding segment
0000000000000000-0000000000000fff (1)
0000000000001000-000000000009fbff (0)
000000000009fc00-000000000009ffff (1)
00000000000f0000-00000000bffd5fff (0)
00000000bffda000-00000000ffffffff (0)
0000000100000000-00000000000fffff (1)
00000000bffda000-00000000000effff (1)
00000000feffc000-00000000000effff (1)
Memmap after adding segment
0000000000000000-0000000000000fff (1)
0000000000001000-000000000009fbff (0)
000000000009fc00-000000000009ffff (1)
00000000000f0000-00000000bffd5fff (0)
00000000bffda000-00000000ffffffff (0)
0000000100000000-00000000000fffff (1)
00000000bffda000-00000000000effff (1)
00000000feffc000-00000000000effff (1)
00000000fffc0000-00000000000effff (1)
sym: sha256_update info: 12 other: 00 shndx: 1 value: 5880 size: 152
sym: sha256_update value: bffd0880 addr: bffcb005
R_X86_64_64
sym: sha256_regions info: 11 other: 00 shndx: 9 value: 40 size: 100
sym: sha256_regions value: bffd2040 addr: bffcb010
R_X86_64_64
sym: sha256_starts info: 12 other: 00 shndx: 1 value: 1180 size: 79
sym: sha256_starts value: bffcc180 addr: bffcb037
R_X86_64_64
sym: sha256_regions info: 11 other: 00 shndx: 9 value: 40 size: 100
sym: sha256_regions value: bffd2140 addr: bffcb053
R_X86_64_64
sym: sha256_finish info: 12 other: 00 shndx: 1 value: 59d2 size: 375
sym: sha256_finish value: bffd09d2 addr: bffcb06a
R_X86_64_64
sym: sha256_digest info: 11 other: 00 shndx: 9 value: 0 size: 20
sym: sha256_digest value: bffd2000 addr: bffcb07b
R_X86_64_64
sym:     memcmp info: 12 other: 00 shndx: 1 value: 65e size: 1d
sym: memcmp value: bffcb65e addr: bffcb08a
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: bffd0e60 addr: bffcb0a0
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 550 size: c9
sym: printf value: bffcb550 addr: bffcb0ac
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: bffd0e80 addr: bffcb0b8
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: bffd0e90 addr: bffcb0d0
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 550 size: c9
sym: printf value: bffcb550 addr: bffcb0da
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: bffd0e96 addr: bffcb0ec
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: bffd0e98 addr: bffcb0fd
R_X86_64_64
sym: sha256_digest info: 11 other: 00 shndx: 9 value: 0 size: 20
sym: sha256_digest value: bffd2000 addr: bffcb10c
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: bffd0e90 addr: bffcb120
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: bffd0e96 addr: bffcb134
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 550 size: c9
sym: printf value: bffcb550 addr: bffcb13e
R_X86_64_64
sym: __stack_chk_fail info: 10 other: 00 shndx: 0 value: 0 size: 0
sym: __stack_chk_fail value: 0 addr: bffcb162
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: bffd0ea8 addr: bffcb17a
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 550 size: c9
sym: printf value: bffcb550 addr: bffcb186
R_X86_64_64
sym: setup_arch info: 12 other: 00 shndx: 1 value: 822 size: 3a
sym: setup_arch value: bffcb822 addr: bffcb193
R_X86_64_64
sym: verify_sha256_digest info: 12 other: 00 shndx: 1 value: 0 size: 178
sym: verify_sha256_digest value: bffcb000 addr: bffcb19f
R_X86_64_64
sym: post_verification_setup_arch info: 12 other: 00 shndx: 1 value:
894 size: 3b
sym: post_verification_setup_arch value: bffcb894 addr: bffcb1b2
R_X86_64_64
sym:    putchar info: 12 other: 00 shndx: 1 value: e13 size: 141
sym: putchar value: bffcbe13 addr: bffcb20a
R_X86_64_64
sym:    putchar info: 12 other: 00 shndx: 1 value: e13 size: 141
sym: putchar value: bffcbe13 addr: bffcb24d
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: bffd0eba addr: bffcb31c
R_X86_64_64
sym:    putchar info: 12 other: 00 shndx: 1 value: e13 size: 141
sym: putchar value: bffcbe13 addr: bffcb429
R_X86_64_64
sym: __stack_chk_fail info: 10 other: 00 shndx: 0 value: 0 size: 0
sym: __stack_chk_fail value: 0 addr: bffcb478
R_X86_64_64
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 1bc size: 2d5
sym: vsprintf value: bffcb1bc addr: bffcb522
R_X86_64_64
sym: __stack_chk_fail info: 10 other: 00 shndx: 0 value: 0 size: 0
sym: __stack_chk_fail value: 0 addr: bffcb53e
R_X86_64_64
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 1bc size: 2d5
sym: vsprintf value: bffcb1bc addr: bffcb5eb
R_X86_64_64
sym: __stack_chk_fail info: 10 other: 00 shndx: 0 value: 0 size: 0
sym: __stack_chk_fail value: 0 addr: bffcb607
R_X86_64_64
sym:    entry32 info: 10 other: 00 shndx: 1 value: 680 size: 0
sym: entry32 value: bffcb67c addr: bffcb68d
R_X86_64_PC32
sym:    entry32 info: 10 other: 00 shndx: 1 value: 680 size: 0
sym: entry32 value: bffcb67c addr: bffcb6a2
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd215c addr: bffcb6bd
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd213c addr: bffcb6c4
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0d74 addr: bffcb6ca
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd21ac addr: bffcb6d0
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0d4c addr: bffcb6d6
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0de1 addr: bffcb709
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0df0 addr: bffcb710
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0dfb addr: bffcb717
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0e06 addr: bffcb71e
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0e11 addr: bffcb725
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0e1c addr: bffcb72c
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0e27 addr: bffcb733
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0e16 addr: bffcb73a
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd2271 addr: bffcb741
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0e0c addr: bffcb753
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0e3c addr: bffcb769
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0d7c addr: bffcb77c
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0d84 addr: bffcb783
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0d8c addr: bffcb78a
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0d94 addr: bffcb791
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0d9c addr: bffcb798
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0da4 addr: bffcb79f
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0dac addr: bffcb7a6
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0db4 addr: bffcb7ad
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0dbc addr: bffcb7b4
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0dc4 addr: bffcb7bb
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0dcc addr: bffcb7c2
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0dd4 addr: bffcb7c9
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0ddc addr: bffcb7d0
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0de4 addr: bffcb7d7
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0dec addr: bffcb7de
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0df4 addr: bffcb7e5
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0dfc addr: bffcb7eb
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0e3c addr: bffcb7f3
R_X86_64_PC32
sym: jump_back_entry info: 11 other: 00 shndx: 9 value: 2008 size: 8
sym: jump_back_entry value: bffd4004 addr: bffcb80d
R_X86_64_PC32
sym:       .bss info: 03 other: 00 shndx: b value: 0 size: 0
sym: .bss value: bffd5ffc addr: bffcb814
R_X86_64_PC32
sym:  purgatory info: 12 other: 00 shndx: 1 value: 178 size: 44
sym: purgatory value: bffcb174 addr: bffcb819
R_X86_64_PC32
sym:    entry64 info: 10 other: 00 shndx: 1 value: 750 size: 0
sym: entry64 value: bffcb74c addr: bffcb81e
R_X86_64_PC32
sym:  reset_vga info: 11 other: 00 shndx: 9 value: 2012 size: 1
sym: reset_vga value: bffd4012 addr: bffcb824
R_X86_64_64
sym: x86_reset_vga info: 12 other: 00 shndx: 1 value: f54 size: 1fb
sym: x86_reset_vga value: bffcbf54 addr: bffcb834
R_X86_64_64
sym: legacy_pic info: 11 other: 00 shndx: 9 value: 2011 size: 1
sym: legacy_pic value: bffd4011 addr: bffcb840
R_X86_64_64
sym: x86_setup_legacy_pic info: 12 other: 00 shndx: 1 value: 114f size: 31
sym: x86_setup_legacy_pic value: bffcc14f addr: bffcb850
R_X86_64_64
sym: cmdline_end info: 11 other: 00 shndx: 9 value: 2000 size: 8
sym: cmdline_end value: bffd4000 addr: bffcb85e
R_X86_64_64
sym: jump_back_entry info: 11 other: 00 shndx: 9 value: 2008 size: 8
sym: jump_back_entry value: bffd4008 addr: bffcb870
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: bffd0ecb addr: bffcb87a
R_X86_64_64
sym:    sprintf info: 12 other: 00 shndx: 1 value: 491 size: bf
sym: sprintf value: bffcb491 addr: bffcb887
R_X86_64_64
sym: panic_kernel info: 11 other: 00 shndx: 9 value: 2010 size: 1
sym: panic_kernel value: bffd4010 addr: bffcb896
R_X86_64_64
sym: crashdump_backup_memory info: 12 other: 00 shndx: 1 value: d33 size: 3e
sym: crashdump_backup_memory value: bffcbd33 addr: bffcb8a6
R_X86_64_64
sym: jump_back_entry info: 11 other: 00 shndx: 9 value: 2008 size: 8
sym: jump_back_entry value: bffd4008 addr: bffcb8b2
R_X86_64_64
sym: x86_setup_jump_back_entry info: 12 other: 00 shndx: 1 value: 85c size: 38
sym: x86_setup_jump_back_entry value: bffcb85c addr: bffcb8c3
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4047 addr: bffcb8e7
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd404f addr: bffcb8ed
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4075 addr: bffcb90d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd407f addr: bffcb913
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4089 addr: bffcb919
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4093 addr: bffcb91f
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4076 addr: bffcb926
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd408d addr: bffcb92d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd406d addr: bffcb9f7
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4075 addr: bffcb9fd
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd409b addr: bffcba1d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd40a5 addr: bffcba23
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd40af addr: bffcba29
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd40b9 addr: bffcba2f
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd40e2 addr: bffcba72
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd412b addr: bffcbab5
R_X86_64_PC32
sym: backup_src_start info: 11 other: 00 shndx: 9 value: 2078 size: 8
sym: backup_src_start value: bffd4078 addr: bffcbd35
R_X86_64_64
sym: backup_src_size info: 11 other: 00 shndx: 9 value: 2070 size: 8
sym: backup_src_size value: bffd4070 addr: bffcbd42
R_X86_64_64
sym: backup_start info: 11 other: 00 shndx: 9 value: 2080 size: 8
sym: backup_start value: bffd4080 addr: bffcbd54
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 1 value: 646 size: 18
sym: memcpy value: bffcb646 addr: bffcbd66
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4088 addr: bffcbd73
R_X86_64_64
sym: serial_base info: 11 other: 00 shndx: 9 value: 2090 size: 2
sym: serial_base value: bffd4090 addr: bffcbd80
R_X86_64_64
sym: serial_baud info: 11 other: 00 shndx: 9 value: 208c size: 4
sym: serial_baud value: bffd408c addr: bffcbdbd
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4088 addr: bffcbded
R_X86_64_64
sym: console_vga info: 11 other: 00 shndx: 9 value: 2093 size: 1
sym: console_vga value: bffd4093 addr: bffcbe15
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4098 addr: bffcbe2c
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4098 addr: bffcbe91
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4094 addr: bffcbea6
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4098 addr: bffcbeb5
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4098 addr: bffcbec8
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4094 addr: bffcbed4
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4094 addr: bffcbeeb
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4094 addr: bffcbf09
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd4098 addr: bffcbf1b
R_X86_64_64
sym: console_serial info: 11 other: 00 shndx: 9 value: 2092 size: 1
sym: console_serial value: bffd4092 addr: bffcbf25
R_X86_64_64
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcbd71 addr: bffcbf37
R_X86_64_64
sym: __stack_chk_fail info: 10 other: 00 shndx: 0 value: 0 size: 0
sym: __stack_chk_fail value: 0 addr: bffd0874
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 1 value: 646 size: 18
sym: memcpy value: bffcb646 addr: bffd0932
R_X86_64_64
sym: sha256_process info: 12 other: 00 shndx: 1 value: 11f9 size: 4687
sym: sha256_process value: bffcc1f9 addr: bffd0950
R_X86_64_64
sym: sha256_process info: 12 other: 00 shndx: 1 value: 11f9 size: 4687
sym: sha256_process value: bffcc1f9 addr: bffd0984
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 1 value: 646 size: 18
sym: memcpy value: bffcb646 addr: bffd09c6
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd40c0 addr: bffd0a8e
R_X86_64_64
sym: sha256_update info: 12 other: 00 shndx: 1 value: 5880 size: 152
sym: sha256_update value: bffd0880 addr: bffd0a9b
R_X86_64_64
sym: sha256_update info: 12 other: 00 shndx: 1 value: 5880 size: 152
sym: sha256_update value: bffd0880 addr: bffd0aba
R_X86_64_64
sym: __stack_chk_fail info: 10 other: 00 shndx: 0 value: 0 size: 0
sym: __stack_chk_fail value: 0 addr: bffd0d3b
R_X86_64_64
sym:    entry16 info: 10 other: 00 shndx: 1 value: 8d0 size: 0
sym: entry16 value: bffcb8d0 addr: bffd0d78
R_X86_64_64
sym:    entry32 info: 10 other: 00 shndx: 1 value: 680 size: 0
sym: entry32 value: bffcb680 addr: bffd0e00
R_X86_64_64
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0e10 addr: bffd0e12
R_X86_64_64
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: bffd0e40 addr: bffd0e42
R_X86_64_64
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcb000 addr: bffd0f08
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcb178 addr: bffd0f40
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcb1bc addr: bffd0f70
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcb491 addr: bffd0fc0
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcb550 addr: bffd0fe0
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcb619 addr: bffd1018
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcb632 addr: bffd1030
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcb646 addr: bffd1048
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcb65e addr: bffd1060
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcb822 addr: bffd1090
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcb85c addr: bffd10b0
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcb894 addr: bffd10c8
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcbd33 addr: bffd1100
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcbd71 addr: bffd1130
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcbe13 addr: bffd1148
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcbf54 addr: bffd1190
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcc14f addr: bffd11c0
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcc180 addr: bffd11f0
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffcc1f9 addr: bffd1210
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffd0880 addr: bffd1230
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: bffd09d2 addr: bffd1250
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: bffd2140 addr: bffd2142
R_X86_64_64
Loaded purgatory at addr 0xbffcb000
Loaded real_mode_data and command line at 0xbffc6000
kernel init_size 0x14e1000
Loaded 64bit kernel at 0xbe000000
Loaded initrd at 0xbb080000 size 0x2f7fddc
E820 memmap:
0000000000000100-000000000009fbff (1)
000000000009fc00-000000000009ffff (2)
00000000000f0000-00000000000fffff (2)
0000000000100000-00000000bffd9fff (1)
00000000bffda000-00000000bfffffff (2)
00000000feffc000-00000000feffffff (2)
00000000fffc0000-00000000ffffffff (2)
0000000100000000-000000013fffffff (1)
/sys/firmware/edd does not exist.
kexec_load: entry = 0xbffcb7f0 flags = 0x3e0002
nr_segments = 7
segment[0].buf   = (nil)
segment[0].bufsz = 0x0
segment[0].mem   = 0x1000000
segment[0].memsz = 0xba080000
segment[1].buf   = 0x7fd6b266b010
segment[1].bufsz = 0x2f7fddc
segment[1].mem   = 0xbb080000
segment[1].memsz = 0x2f80000
segment[2].buf   = 0x7fd6b55ef210
segment[2].bufsz = 0x61c840
segment[2].mem   = 0xbe000000
segment[2].memsz = 0x14e1000
segment[3].buf   = (nil)
segment[3].bufsz = 0x0
segment[3].mem   = 0xbf4e1000
segment[3].memsz = 0xae5000
segment[4].buf   = 0x1776920
segment[4].bufsz = 0x42c6
segment[4].mem   = 0xbffc6000
segment[4].memsz = 0x5000
segment[5].buf   = 0x176d7c0
segment[5].bufsz = 0x9100
segment[5].mem   = 0xbffcb000
segment[5].memsz = 0xb000
segment[6].buf   = 0x176ce20
segment[6].bufsz = 0x400
segment[6].mem   = 0xbffd6000
segment[6].memsz = 0x4000
kexec_load failed: Invalid argument
entry       = 0xbffcb7f0 flags = 0x3e0002
nr_segments = 7
segment[0].buf   = (nil)
segment[0].bufsz = 0x0
segment[0].mem   = 0x1000000
segment[0].memsz = 0xba080000
segment[1].buf   = 0x7fd6b266b010
segment[1].bufsz = 0x2f7fddc
segment[1].mem   = 0xbb080000
segment[1].memsz = 0x2f80000
segment[2].buf   = 0x7fd6b55ef210
segment[2].bufsz = 0x61c840
segment[2].mem   = 0xbe000000
segment[2].memsz = 0x14e1000
segment[3].buf   = (nil)
segment[3].bufsz = 0x0
segment[3].mem   = 0xbf4e1000
segment[3].memsz = 0xae5000
segment[4].buf   = 0x1776920
segment[4].bufsz = 0x42c6
segment[4].mem   = 0xbffc6000
segment[4].memsz = 0x5000
segment[5].buf   = 0x176d7c0
segment[5].bufsz = 0x9100
segment[5].mem   = 0xbffcb000
segment[5].memsz = 0xb000
segment[6].buf   = 0x176ce20
segment[6].bufsz = 0x400
segment[6].mem   = 0xbffd6000
segment[6].memsz = 0x4000

-- 

Best regards,
Gioh Kim

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
