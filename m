Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YpOYG-000314-0Y
 for kexec@lists.infradead.org; Mon, 04 May 2015 22:09:25 +0000
Message-ID: <5547EE37.2020303@linux.intel.com>
Date: Mon, 04 May 2015 17:09:59 -0500
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: Re: commit 5edcbfd1368e break kexec on x86-64
References: <CAE9FiQXBJygEhKpAgxZ3yVktAM5u-rxBGuy7oS1NU8wFRuub8g@mail.gmail.com>	<20150430050944.GJ15511@verge.net.au>	<20150501011556.GJ13754@verge.net.au>	<55478B96.4060706@linux.intel.com>	<554796B4.5020101@linux.intel.com>
 <CAE9FiQX8Sqb8rd3jE0n+7oDMLPWmnA0_d6J5bdRdoVNsxRVaVg@mail.gmail.com>
In-Reply-To: <CAE9FiQX8Sqb8rd3jE0n+7oDMLPWmnA0_d6J5bdRdoVNsxRVaVg@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------030407030907040907050105"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Mariano Lopez <mariano.lopez@linux.intel.com>, Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

This is a multi-part message in MIME format.
--------------030407030907040907050105
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi,

On 04/05/15 11:49, Yinghai Lu wrote:
> On Mon, May 4, 2015 at 8:56 AM, Aníbal Limón
> <anibal.limon@linux.intel.com> wrote:
>> Hi Yinghai,
>>
>> I'm trying to reproduce the issue that you found but i can't, any option
>> that you use?.
> Can you compile current upstream kernel?
Now i tested with latest 4.1-rc2 kernel and works,

commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun May 3 19:22:23 2015 -0700

     Linux 4.1-rc2

See attached log.

Kind regards,
     alimon


--------------030407030907040907050105
Content-Type: text/x-log;
 name="kexec-opensuse-13.1-linux-4.1-rc2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kexec-opensuse-13.1-linux-4.1-rc2.log"

Try gzip decompression.
kernel: 0x7f5e3bf7d010 kernel_size: 0x85a980d
MEMORY RANGES
0000000000010000-000000000009ffff (0)
0000000000100000-00000000b6673fff (0)
00000000b6674000-00000000b6a73fff (3)
00000000b6a74000-00000000b6b35fff (0)
00000000b6b36000-00000000b6d36fff (1)
00000000b6d37000-00000000b86bffff (0)
00000000b86c0000-00000000b88c3fff (1)
00000000b88c4000-00000000b89c3fff (3)
00000000b89c4000-00000000b8a43fff (2)
00000000b8a44000-00000000bca87fff (0)
00000000bcab8000-00000000bcaeffff (0)
00000000bd2f0000-00000000bd31bfff (1)
00000000bd31c000-00000000bd35afff (2)
00000000bd35b000-00000000bfffffff (1)
00000000e0000000-00000000efffffff (1)
00000000fe000000-00000000ffffffff (1)
0000000100000000-000000203fffffff (0)
sym: sha256_starts info: 12 other: 00 shndx: 1 value: 10e0 size: 79
sym: sha256_starts value: 110e0 addr: 10004
R_X86_64_64
sym: sha256_update info: 12 other: 00 shndx: 1 value: 4936 size: 154
sym: sha256_update value: 14936 addr: 1000f
R_X86_64_64
sym: sha256_regions info: 11 other: 00 shndx: 8 value: 20 size: 100
sym: sha256_regions value: 16020 addr: 1001a
R_X86_64_64
sym: sha256_regions info: 11 other: 00 shndx: 8 value: 20 size: 100
sym: sha256_regions value: 16120 addr: 10044
R_X86_64_64
sym: sha256_finish info: 12 other: 00 shndx: 1 value: 4a8a size: 34b
sym: sha256_finish value: 14a8a addr: 1005b
R_X86_64_64
sym: sha256_digest info: 11 other: 00 shndx: 8 value: 0 size: 20
sym: sha256_digest value: 16000 addr: 1006c
R_X86_64_64
sym:     memcmp info: 12 other: 00 shndx: 1 value: 59f size: 21
sym: memcmp value: 1059f addr: 10079
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 14ef0 addr: 1008f
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 4bd size: a0
sym: printf value: 104bd addr: 1009b
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 14f10 addr: 100a7
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 14f20 addr: 100be
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 4bd size: a0
sym: printf value: 104bd addr: 100c8
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 14f26 addr: 100da
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 14f28 addr: 100eb
R_X86_64_64
sym: sha256_digest info: 11 other: 00 shndx: 8 value: 0 size: 20
sym: sha256_digest value: 16000 addr: 100fa
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 14f20 addr: 1010e
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 14f26 addr: 10122
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 4bd size: a0
sym: printf value: 104bd addr: 1012c
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 14f38 addr: 10149
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 4bd size: a0
sym: printf value: 104bd addr: 10155
R_X86_64_64
sym: setup_arch info: 12 other: 00 shndx: 1 value: 764 size: 3a
sym: setup_arch value: 10764 addr: 10162
R_X86_64_64
sym: verify_sha256_digest info: 12 other: 00 shndx: 1 value: 0 size: 147
sym: verify_sha256_digest value: 10000 addr: 1016e
R_X86_64_64
sym: post_verification_setup_arch info: 12 other: 00 shndx: 1 value: 7d6 size: 3c
sym: post_verification_setup_arch value: 107d6 addr: 10181
R_X86_64_64
sym:    putchar info: 12 other: 00 shndx: 1 value: d6c size: 143
sym: putchar value: 10d6c addr: 101ca
R_X86_64_64
sym:    putchar info: 12 other: 00 shndx: 1 value: d6c size: 143
sym: putchar value: 10d6c addr: 1020c
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 14f4a addr: 102d7
R_X86_64_64
sym:    putchar info: 12 other: 00 shndx: 1 value: d6c size: 143
sym: putchar value: 10d6c addr: 103db
R_X86_64_64
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 18c size: 29b
sym: vsprintf value: 1018c addr: 104ab
R_X86_64_64
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 18c size: 29b
sym: vsprintf value: 1018c addr: 1054b
R_X86_64_64
sym:    entry32 info: 10 other: 00 shndx: 1 value: 5c0 size: 0
sym: entry32 value: 105bc addr: 105cd
R_X86_64_PC32
sym:    entry32 info: 10 other: 00 shndx: 1 value: 5c0 size: 0
sym: entry32 value: 105bc addr: 105e2
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 1613c addr: 105fd
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 1611c addr: 10604
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e04 addr: 1060a
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 1618c addr: 10610
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14ddc addr: 10616
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e71 addr: 10649
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e80 addr: 10650
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e8b addr: 10657
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e96 addr: 1065e
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14ea1 addr: 10665
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14eac addr: 1066c
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14eb7 addr: 10673
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14ea6 addr: 1067a
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 16251 addr: 10681
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e9c addr: 10693
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14ecc addr: 106a9
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e0c addr: 106bc
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e14 addr: 106c3
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e1c addr: 106ca
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e24 addr: 106d1
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e2c addr: 106d8
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e34 addr: 106df
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e3c addr: 106e6
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e44 addr: 106ed
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e4c addr: 106f4
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e54 addr: 106fb
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e5c addr: 10702
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e64 addr: 10709
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e6c addr: 10710
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e74 addr: 10717
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e7c addr: 1071e
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e84 addr: 10725
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14e8c addr: 1072b
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14ecc addr: 10733
R_X86_64_PC32
sym: jump_back_entry info: 11 other: 00 shndx: 8 value: 2008 size: 8
sym: jump_back_entry value: 18004 addr: 1074d
R_X86_64_PC32
sym:       .bss info: 03 other: 00 shndx: a value: 0 size: 0
sym: .bss value: 19ffc addr: 10754
R_X86_64_PC32
sym:  purgatory info: 12 other: 00 shndx: 1 value: 147 size: 44
sym: purgatory value: 10143 addr: 10759
R_X86_64_PC32
sym:    entry64 info: 10 other: 00 shndx: 1 value: 690 size: 0
sym: entry64 value: 1068c addr: 1075e
R_X86_64_PC32
sym:  reset_vga info: 11 other: 00 shndx: 8 value: 2012 size: 1
sym: reset_vga value: 18012 addr: 10766
R_X86_64_64
sym: x86_reset_vga info: 12 other: 00 shndx: 1 value: eb0 size: 1f9
sym: x86_reset_vga value: 10eb0 addr: 10776
R_X86_64_64
sym: legacy_pic info: 11 other: 00 shndx: 8 value: 2011 size: 1
sym: legacy_pic value: 18011 addr: 10782
R_X86_64_64
sym: x86_setup_legacy_pic info: 12 other: 00 shndx: 1 value: 10ac size: 31
sym: x86_setup_legacy_pic value: 110ac addr: 10792
R_X86_64_64
sym: cmdline_end info: 11 other: 00 shndx: 8 value: 2000 size: 8
sym: cmdline_end value: 18000 addr: 107a0
R_X86_64_64
sym: jump_back_entry info: 11 other: 00 shndx: 8 value: 2008 size: 8
sym: jump_back_entry value: 18008 addr: 107b2
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 14f5b addr: 107bc
R_X86_64_64
sym:    sprintf info: 12 other: 00 shndx: 1 value: 427 size: 96
sym: sprintf value: 10427 addr: 107c9
R_X86_64_64
sym: panic_kernel info: 11 other: 00 shndx: 8 value: 2010 size: 1
sym: panic_kernel value: 18010 addr: 107d8
R_X86_64_64
sym: crashdump_backup_memory info: 12 other: 00 shndx: 1 value: c84 size: 3e
sym: crashdump_backup_memory value: 10c84 addr: 107e9
R_X86_64_64
sym: jump_back_entry info: 11 other: 00 shndx: 8 value: 2008 size: 8
sym: jump_back_entry value: 18008 addr: 107f5
R_X86_64_64
sym: x86_setup_jump_back_entry info: 12 other: 00 shndx: 1 value: 79e size: 38
sym: x86_setup_jump_back_entry value: 1079e addr: 10806
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18047 addr: 10837
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 1804f addr: 1083d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18075 addr: 1085d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 1807f addr: 10863
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18089 addr: 10869
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18093 addr: 1086f
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18076 addr: 10876
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 1808d addr: 1087d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 1806d addr: 10947
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18075 addr: 1094d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 1809b addr: 1096d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 180a5 addr: 10973
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 180af addr: 10979
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 180b9 addr: 1097f
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 180e2 addr: 109c2
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 1812b addr: 10a05
R_X86_64_PC32
sym: backup_src_start info: 11 other: 00 shndx: 8 value: 2078 size: 8
sym: backup_src_start value: 18078 addr: 10c86
R_X86_64_64
sym: backup_src_size info: 11 other: 00 shndx: 8 value: 2070 size: 8
sym: backup_src_size value: 18070 addr: 10c93
R_X86_64_64
sym: backup_start info: 11 other: 00 shndx: 8 value: 2080 size: 8
sym: backup_start value: 18080 addr: 10ca5
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 1 value: 587 size: 18
sym: memcpy value: 10587 addr: 10cb7
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18088 addr: 10cc6
R_X86_64_64
sym: serial_base info: 11 other: 00 shndx: 8 value: 2090 size: 2
sym: serial_base value: 18090 addr: 10cd4
R_X86_64_64
sym: serial_baud info: 11 other: 00 shndx: 8 value: 208c size: 4
sym: serial_baud value: 1808c addr: 10d10
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18088 addr: 10d44
R_X86_64_64
sym: console_vga info: 11 other: 00 shndx: 8 value: 2093 size: 1
sym: console_vga value: 18093 addr: 10d6f
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18098 addr: 10d85
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18098 addr: 10dea
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18094 addr: 10dff
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18098 addr: 10e0e
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18098 addr: 10e21
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18094 addr: 10e2d
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18094 addr: 10e51
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18094 addr: 10e64
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 18098 addr: 10e76
R_X86_64_64
sym: console_serial info: 11 other: 00 shndx: 8 value: 2092 size: 1
sym: console_serial value: 18092 addr: 10e80
R_X86_64_64
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 10cc4 addr: 10e92
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 1 value: 587 size: 18
sym: memcpy value: 10587 addr: 149e8
R_X86_64_64
sym: sha256_process info: 12 other: 00 shndx: 1 value: 1159 size: 37dd
sym: sha256_process value: 11159 addr: 14a06
R_X86_64_64
sym: sha256_process info: 12 other: 00 shndx: 1 value: 1159 size: 37dd
sym: sha256_process value: 11159 addr: 14a3c
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 1 value: 587 size: 18
sym: memcpy value: 10587 addr: 14a7e
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 180a0 addr: 14b37
R_X86_64_64
sym: sha256_update info: 12 other: 00 shndx: 1 value: 4936 size: 154
sym: sha256_update value: 14936 addr: 14b44
R_X86_64_64
sym: sha256_update info: 12 other: 00 shndx: 1 value: 4936 size: 154
sym: sha256_update value: 14936 addr: 14b63
R_X86_64_64
sym:    entry16 info: 10 other: 00 shndx: 1 value: 820 size: 0
sym: entry16 value: 10820 addr: 14e08
R_X86_64_64
sym:    entry32 info: 10 other: 00 shndx: 1 value: 5c0 size: 0
sym: entry32 value: 105c0 addr: 14e90
R_X86_64_64
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14ea0 addr: 14ea2
R_X86_64_64
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 14ed0 addr: 14ed2
R_X86_64_64
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 10000 addr: 14f98
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 10147 addr: 14fcc
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 1018c addr: 15000
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 10427 addr: 1504c
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 104bd addr: 15068
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 10560 addr: 150a0
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 10573 addr: 150b4
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 10587 addr: 150c8
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 1059f addr: 150dc
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 10764 addr: 15108
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 1079e addr: 15128
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 107d6 addr: 1513c
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 10c84 addr: 15178
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 10cc4 addr: 151a8
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 10d6c addr: 151c4
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 10eb0 addr: 15208
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 110ac addr: 15238
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 110e0 addr: 15268
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 11159 addr: 15288
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 14936 addr: 152a8
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 14a8a addr: 152c8
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 16120 addr: 16122
R_X86_64_64
kexec_load: entry = 0x10730 flags = 0x3e0000
nr_segments = 6
segment[0].buf   = 0x17510e0
segment[0].bufsz = 0x80e0
segment[0].mem   = 0x10000
segment[0].memsz = 0xa000
segment[1].buf   = 0x1750b40
segment[1].bufsz = 0x44
segment[1].mem   = 0x1a000
segment[1].memsz = 0x1000
segment[2].buf   = 0x7f5e3c17d010
segment[2].bufsz = 0xace000
segment[2].mem   = 0x1000000
segment[2].memsz = 0xace000
segment[3].buf   = 0x7f5e3cd7d010
segment[3].bufsz = 0xe2000
segment[3].mem   = 0x1c00000
segment[3].memsz = 0xe2000
segment[4].buf   = 0x7f5e3cf7d010
segment[4].bufsz = 0x17718
segment[4].mem   = 0x1ce2000
segment[4].memsz = 0x18000
segment[5].buf   = 0x7f5e3d077010
segment[5].bufsz = 0x142000
segment[5].mem   = 0x1cfa000
segment[5].memsz = 0x2e0000

--------------030407030907040907050105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------030407030907040907050105--

