Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X9XXY-00070q-NO
 for kexec@lists.infradead.org; Tue, 22 Jul 2014 10:43:26 +0000
Date: Tue, 22 Jul 2014 18:42:55 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: kexec/kdump fails to load in ELF symbol relocation on ppc64 arch
Message-ID: <20140722104255.GF13924@dhcp-17-37.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org

Hi, Laurent

With gcc -fexceptions, kexec/kdump fails to load:

 # kexec -p /boot/vmlinuz
 Warning: append= option is not passed. Using the first kernel root partition
 REL24 -157778404 out of range!

 (I'll attach the full log of kexec -d in the end of this email)

I narrowed it down to the following commit (git-bisect):

commit d047cb7
Author: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date:   Mon Feb 3 15:37:49 2014 +0100

    kexec/ppc64 ELF ABIv2 ABI support

    When building in PPC64 little endian mode, the compiler is now using the
    new ABI v2. Among other changes, this new ABI remove the function
    descriptors and changes the way the TOC address is computed when entering a
    C function.

    The purgatory assembly part where the dot symbols are removed, and ELF
    relocation code are impacted in this patch.

    Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>


This is a ppc64 big endian platform. If I mask -fexceptions or use a
previous version of kexec (prior to this commit), load is just fine.

Could you please look into this issue? Let me know if you need anything
and I'm happy to test once you have a patch.


Thanks
WANG Chao

(Full output of kexec -d -p):

 # kexec -d -p /boot/vmlinuz
 kernel: 0x3fffab640010 kernel_size: 0x1330e28
 0000000010000000-0000000018000000 : 0
 0000000018000000-0000000020000000 : 0
 0000000020000000-0000000028000000 : 0
 0000000028000000-0000000030000000 : 0
 0000000030000000-0000000038000000 : 0
 0000000038000000-0000000040000000 : 0
 0000000040000000-0000000048000000 : 0
 0000000000000000-0000000010000000 : 0
 get base memory ranges:8
 usable memory rgns size:1 base:ee90000 size:1170000
 exclude_range sorted exclude_range[0] start:0, end:1650000
 exclude_range sorted exclude_range[1] start:ee90000, end:10000000
 setup_memory_ranges memory_range[0] start:1650001, end:ee8ffff
 get memory ranges:1
 Warning: append= option is not passed. Using the first kernel root
 partition
 CRASH MEMORY RANGES
 0000000000000000-0000000000010000
 0000000010000000-0000000018000000
 0000000018000000-0000000020000000
 0000000020000000-0000000028000000
 0000000028000000-0000000030000000
 0000000030000000-0000000038000000
 0000000038000000-0000000040000000
 0000000000010000-0000000008000000
 000000000ee90000-0000000010000000
 get_crash_notes_per_cpu: crash_notes addr = 17193d0, size = 536
 Elf header: p_type = 4, p_offset = 0x17193d0 p_paddr = 0x17193d0
 p_vaddr = 0x0 p_filesz = 0x218 p_memsz = 0x218
 get_crash_notes_per_cpu: crash_notes addr = 17593d0, size = 536
 Elf header: p_type = 4, p_offset = 0x17593d0 p_paddr = 0x17593d0
 p_vaddr = 0x0 p_filesz = 0x218 p_memsz = 0x218
 get_crash_notes_per_cpu: crash_notes addr = 17993d0, size = 536
 Elf header: p_type = 4, p_offset = 0x17993d0 p_paddr = 0x17993d0
 p_vaddr = 0x0 p_filesz = 0x218 p_memsz = 0x218
 get_crash_notes_per_cpu: crash_notes addr = 17d93d0, size = 536
 Elf header: p_type = 4, p_offset = 0x17d93d0 p_paddr = 0x17d93d0
 p_vaddr = 0x0 p_filesz = 0x218 p_memsz = 0x218
 vmcoreinfo header: p_type = 4, p_offset = 0x1517d60 p_paddr = 0x1517d60
 p_vaddr = 0x0 p_filesz = 0x1000 p_memsz = 0x1000
 Elf header: p_type = 1, p_offset = 0x9650000 p_paddr = 0x0 p_vaddr =
 0xc000000000000000 p_filesz = 0x10000 p_memsz = 0x10000
 Elf header: p_type = 1, p_offset = 0x10000000 p_paddr = 0x10000000
 p_vaddr = 0xc000000010000000 p_filesz = 0x8000000 p_memsz = 0x8000000
 Elf header: p_type = 1, p_offset = 0x18000000 p_paddr = 0x18000000
 p_vaddr = 0xc000000018000000 p_filesz = 0x8000000 p_memsz = 0x8000000
 Elf header: p_type = 1, p_offset = 0x20000000 p_paddr = 0x20000000
 p_vaddr = 0xc000000020000000 p_filesz = 0x8000000 p_memsz = 0x8000000
 Elf header: p_type = 1, p_offset = 0x28000000 p_paddr = 0x28000000
 p_vaddr = 0xc000000028000000 p_filesz = 0x8000000 p_memsz = 0x8000000
 Elf header: p_type = 1, p_offset = 0x30000000 p_paddr = 0x30000000
 p_vaddr = 0xc000000030000000 p_filesz = 0x8000000 p_memsz = 0x8000000
 Elf header: p_type = 1, p_offset = 0x38000000 p_paddr = 0x38000000
 p_vaddr = 0xc000000038000000 p_filesz = 0x8000000 p_memsz = 0x8000000
 Elf header: p_type = 1, p_offset = 0x10000 p_paddr = 0x10000 p_vaddr =
 0xc000000000010000 p_filesz = 0x7ff0000 p_memsz = 0x7ff0000
 Elf header: p_type = 1, p_offset = 0xee90000 p_paddr = 0xee90000
 p_vaddr = 0xc00000000ee90000 p_filesz = 0x1170000 p_memsz = 0x1170000
 Command line after adding elfcorehdr:  elfcorehdr=153984K
 sym: _savegpr0_27 info: 10 other: 00 shndx: 2 value: 950 size: 0
 sym: _savegpr0_27 value: 9670950 addr: 9670004
 sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
 sym: .data value: 9678570 addr: 967000e
 sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
 sym: .data value: 9678570 addr: 9670012
 sym: .sha256_starts info: 12 other: 00 shndx: 2 value: 9d4 size: c0
 sym: .sha256_starts value: 96709d4 addr: 9670020
 sym: .sha256_update info: 12 other: 00 shndx: 2 value: 7a9c size: 1a4
 sym: .sha256_update value: 9677a9c addr: 9670038
 sym: .sha256_finish info: 12 other: 00 shndx: 2 value: 7c40 size: 5cc
 sym: .sha256_finish value: 9677c40 addr: 9670054
 sym:    .memcmp info: 12 other: 00 shndx: 2 value: 548 size: 3c
 sym: .memcmp value: 9670548 addr: 9670068
 sym: .rodata.str1.1 info: 03 other: 00 shndx: 4 value: 0 size: 0
 sym: .rodata.str1.1 value: 967820c addr: 967007a
 sym: .rodata.str1.1 info: 03 other: 00 shndx: 4 value: 0 size: 0
 sym: .rodata.str1.1 value: 967823c addr: 967007e
 sym: .rodata.str1.1 info: 03 other: 00 shndx: 4 value: 0 size: 0
 sym: .rodata.str1.1 value: 967820c addr: 9670082
 sym:    .printf info: 12 other: 00 shndx: 2 value: 460 size: 54
 sym: .printf value: 9670460 addr: 9670088
 sym: .rodata.str1.1 info: 03 other: 00 shndx: 4 value: 0 size: 0
 sym: .rodata.str1.1 value: 967822c addr: 9670092
 sym: .rodata.str1.1 info: 03 other: 00 shndx: 4 value: 0 size: 0
 sym: .rodata.str1.1 value: 967823c addr: 9670096
 sym: .rodata.str1.1 info: 03 other: 00 shndx: 4 value: 0 size: 0
 sym: .rodata.str1.1 value: 967822c addr: 967009a
 sym:    .printf info: 12 other: 00 shndx: 2 value: 460 size: 54
 sym: .printf value: 9670460 addr: 967009c
 sym:    .printf info: 12 other: 00 shndx: 2 value: 460 size: 54
 sym: .printf value: 9670460 addr: 96700b4
 sym: .rodata.str1.1 info: 03 other: 00 shndx: 4 value: 0 size: 0
 sym: .rodata.str1.1 value: 9678242 addr: 96700c6
 sym: .rodata.str1.1 info: 03 other: 00 shndx: 4 value: 0 size: 0
 sym: .rodata.str1.1 value: 9678242 addr: 96700ce
 sym:    .printf info: 12 other: 00 shndx: 2 value: 460 size: 54
 sym: .printf value: 9670460 addr: 96700d8
 sym: .rodata.str1.1 info: 03 other: 00 shndx: 4 value: 0 size: 0
 sym: .rodata.str1.1 value: 9678244 addr: 96700e2
 sym: .rodata.str1.1 info: 03 other: 00 shndx: 4 value: 0 size: 0
 sym: .rodata.str1.1 value: 9678244 addr: 96700e6
 sym:    .printf info: 12 other: 00 shndx: 2 value: 460 size: 54
 sym: .printf value: 9670460 addr: 96700e8
 sym:    .printf info: 12 other: 00 shndx: 2 value: 460 size: 54
 sym: .printf value: 9670460 addr: 96700f8
 sym:    .printf info: 12 other: 00 shndx: 2 value: 460 size: 54
 sym: .printf value: 9670460 addr: 967010c
 sym: _restgpr0_27 info: 10 other: 00 shndx: 2 value: 9a0 size: 0
 sym: _restgpr0_27 value: 96709a0 addr: 967011c
 sym: .rodata.str1.1 info: 03 other: 00 shndx: 4 value: 0 size: 0
 sym: .rodata.str1.1 value: 9678254 addr: 9670132
 sym: .rodata.str1.1 info: 03 other: 00 shndx: 4 value: 0 size: 0
 sym: .rodata.str1.1 value: 9678254 addr: 9670136
 sym:    .printf info: 12 other: 00 shndx: 2 value: 460 size: 54
 sym: .printf value: 9670460 addr: 9670140
 sym: .setup_arch info: 12 other: 00 shndx: 2 value: 818 size: 10
 sym: .setup_arch value: 9670818 addr: 9670148
 sym: .verify_sha256_digest info: 12 other: 00 shndx: 2 value: 0 size:
 12c
 sym: .verify_sha256_digest value: 9670000 addr: 9670150
 sym: .post_verification_setup_arch info: 12 other: 00 shndx: 2 value:
 828 size: 40
 sym: .post_verification_setup_arch value: 9670828 addr: 9670160
 sym: _savegpr0_24 info: 10 other: 00 shndx: 2 value: 944 size: 0
 sym: _savegpr0_24 value: 9670944 addr: 9670188
 sym: .rodata.str1.1 info: 03 other: 00 shndx: 4 value: 0 size: 0
 sym: .rodata.str1.1 value: 9678266 addr: 9670192
 sym: .rodata.str1.1 info: 03 other: 00 shndx: 4 value: 0 size: 0
 sym: .rodata.str1.1 value: 9678266 addr: 96701aa
 sym:   .putchar info: 12 other: 00 shndx: 2 value: 868 size: 68
 sym: .putchar value: 9670868 addr: 96701d4
 sym:   .putchar info: 12 other: 00 shndx: 2 value: 868 size: 68
 sym: .putchar value: 9670868 addr: 967021c
 sym:   .putchar info: 12 other: 00 shndx: 2 value: 868 size: 68
 sym: .putchar value: 9670868 addr: 96703dc
 sym: _restgpr0_24 info: 10 other: 00 shndx: 2 value: 994 size: 0
 sym: _restgpr0_24 value: 9670994 addr: 9670408
 sym:  .vsprintf info: 12 other: 00 shndx: 2 value: 184 size: 294
 sym: .vsprintf value: 9670184 addr: 9670440
 sym:  .vsprintf info: 12 other: 00 shndx: 2 value: 184 size: 294
 sym: .vsprintf value: 9670184 addr: 9670494
 sym:     my_toc info: 11 other: 00 shndx: 8 value: 148 size: 8
 sym: my_toc value: 96786b8 addr: 9670712
 sym:     my_toc info: 11 other: 00 shndx: 8 value: 148 size: 8
 sym: my_toc value: 96786b8 addr: 9670716
 sym:     my_toc info: 11 other: 00 shndx: 8 value: 148 size: 8
 sym: my_toc value: 96786b8 addr: 967071e
 sym:     my_toc info: 11 other: 00 shndx: 8 value: 148 size: 8
 sym: my_toc value: 96786b8 addr: 9670722
 sym:      stack info: 11 other: 00 shndx: 8 value: 158 size: 8
 sym: stack value: 96786c8 addr: 967072a
 sym:      stack info: 11 other: 00 shndx: 8 value: 158 size: 8
 sym: stack value: 96786c8 addr: 967072e
 sym:      stack info: 11 other: 00 shndx: 8 value: 158 size: 8
 sym: stack value: 96786c8 addr: 9670736
 sym:      stack info: 11 other: 00 shndx: 8 value: 158 size: 8
 sym: stack value: 96786c8 addr: 967073a
 sym: .purgatory info: 12 other: 00 shndx: 2 value: 12c size: 58
 sym: .purgatory value: 967012c addr: 9670744
 sym:  dt_offset info: 11 other: 00 shndx: 8 value: 150 size: 8
 sym: dt_offset value: 96786c0 addr: 967075e
 sym:  dt_offset info: 11 other: 00 shndx: 8 value: 150 size: 8
 sym: dt_offset value: 96786c0 addr: 9670762
 sym:  dt_offset info: 11 other: 00 shndx: 8 value: 150 size: 8
 sym: dt_offset value: 96786c0 addr: 967076a
 sym:  dt_offset info: 11 other: 00 shndx: 8 value: 150 size: 8
 sym: dt_offset value: 96786c0 addr: 967076e
 sym:  opal_base info: 11 other: 00 shndx: 8 value: 130 size: 8
 sym: opal_base value: 96786a0 addr: 967078a
 sym:  opal_base info: 11 other: 00 shndx: 8 value: 130 size: 8
 sym: opal_base value: 96786a0 addr: 967078e
 sym:  opal_base info: 11 other: 00 shndx: 8 value: 130 size: 8
 sym: opal_base value: 96786a0 addr: 9670796
 sym:  opal_base info: 11 other: 00 shndx: 8 value: 130 size: 8
 sym: opal_base value: 96786a0 addr: 967079a
 sym: opal_entry info: 11 other: 00 shndx: 8 value: 128 size: 8
 sym: opal_entry value: 9678698 addr: 96707a2
 sym: opal_entry info: 11 other: 00 shndx: 8 value: 128 size: 8
 sym: opal_entry value: 9678698 addr: 96707a6
 sym: opal_entry info: 11 other: 00 shndx: 8 value: 128 size: 8
 sym: opal_entry value: 9678698 addr: 96707ae
 sym: opal_entry info: 11 other: 00 shndx: 8 value: 128 size: 8
 sym: opal_entry value: 9678698 addr: 96707b2
 sym:     kernel info: 11 other: 00 shndx: 8 value: 140 size: 8
 sym: kernel value: 96786b0 addr: 96707ba
 sym:     kernel info: 11 other: 00 shndx: 8 value: 140 size: 8
 sym: kernel value: 96786b0 addr: 96707be
 sym:     kernel info: 11 other: 00 shndx: 8 value: 140 size: 8
 sym: kernel value: 96786b0 addr: 96707c6
 sym:     kernel info: 11 other: 00 shndx: 8 value: 140 size: 8
 sym: kernel value: 96786b0 addr: 96707ca
 sym: run_at_load info: 10 other: 00 shndx: 2 value: 65c size: 4
 sym: run_at_load value: 967065c addr: 96707d2
 sym: run_at_load info: 10 other: 00 shndx: 2 value: 65c size: 4
 sym: run_at_load value: 967065c addr: 96707d6
 sym: run_at_load info: 10 other: 00 shndx: 2 value: 65c size: 4
 sym: run_at_load value: 967065c addr: 96707de
 sym: run_at_load info: 10 other: 00 shndx: 2 value: 65c size: 4
 sym: run_at_load value: 967065c addr: 96707e2
 sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
 sym: .data value: 9678690 addr: 967082a
 sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
 sym: .data value: 9678690 addr: 967082e
 sym: .crashdump_backup_memory info: 12 other: 00 shndx: 2 value: 8d0
 size: 4c
 sym: .crashdump_backup_memory value: 96708d0 addr: 9670844
 sym:       .toc info: 03 other: 00 shndx: d value: 0 size: 0
 sym: .toc value: 9678830 addr: 967086a
 sym:       .toc info: 03 other: 00 shndx: d value: 0 size: 0
 sym: .toc value: 9678830 addr: 967086e
 sym:   .putchar info: 12 other: 00 shndx: 2 value: 868 size: 68
 sym: .putchar value: 9670868 addr: 967089c
 sym: .plpar_hcall_norets info: 10 other: 00 shndx: 2 value: 7fc size: 0
 sym: .plpar_hcall_norets value: 96707fc addr: 96708b4
 sym: _restgpr0_31 info: 10 other: 00 shndx: 2 value: 9c4 size: 0
 sym: _restgpr0_31 value: 96709c4 addr: 96708c0
 sym:       .toc info: 03 other: 00 shndx: d value: 0 size: 0
 sym: .toc value: 9678838 addr: 96708d2
 sym:       .toc info: 03 other: 00 shndx: d value: 0 size: 0
 sym: .toc value: 9678838 addr: 96708d6
 sym:    .memcpy info: 12 other: 00 shndx: 2 value: 518 size: 30
 sym: .memcpy value: 9670518 addr: 96708f8
 sym:    .memcpy info: 12 other: 00 shndx: 2 value: 518 size: 30
 sym: .memcpy value: 9670518 addr: 9677b74
 sym: .sha256_process info: 12 other: 00 shndx: 2 value: a94 size: 7008
 sym: .sha256_process value: 9670a94 addr: 9677b8c
 sym: .sha256_process info: 12 other: 00 shndx: 2 value: a94 size: 7008
 sym: .sha256_process value: 9670a94 addr: 9677bc8
 sym:    .memcpy info: 12 other: 00 shndx: 2 value: 518 size: 30
 sym: .memcpy value: 9670518 addr: 9677c18
 sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
 sym: .data value: 96786d8 addr: 9677d7a
 sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
 sym: .data value: 96786d8 addr: 9677d7e
 sym: .sha256_update info: 12 other: 00 shndx: 2 value: 7a9c size: 1a4
 sym: .sha256_update value: 9677a9c addr: 9677d84
 sym: .sha256_update info: 12 other: 00 shndx: 2 value: 7a9c size: 1a4
 sym: .sha256_update value: 9677a9c addr: 9677d98
 sym: ._Unwind_Resume info: 10 other: 00 shndx: 0 value: 0 size: 0
 sym: ._Unwind_Resume value: 0 addr: 96781e4
 REL24 -157778404 out of range!


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
