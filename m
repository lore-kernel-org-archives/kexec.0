Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YpIix-0005Bt-Bi
 for kexec@lists.infradead.org; Mon, 04 May 2015 15:56:05 +0000
Message-ID: <554796B4.5020101@linux.intel.com>
Date: Mon, 04 May 2015 10:56:36 -0500
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: Re: commit 5edcbfd1368e break kexec on x86-64
References: <CAE9FiQXBJygEhKpAgxZ3yVktAM5u-rxBGuy7oS1NU8wFRuub8g@mail.gmail.com>
 <20150430050944.GJ15511@verge.net.au> <20150501011556.GJ13754@verge.net.au>
 <55478B96.4060706@linux.intel.com>
In-Reply-To: <55478B96.4060706@linux.intel.com>
Content-Type: multipart/mixed; boundary="------------040002080803080109060500"
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
--------------040002080803080109060500
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Yinghai,

I'm trying to reproduce the issue that you found but i can't, any option 
that you use?.

I made,

# ./configure
# make
# ./build/sbin/kexec -d -l /boot/vmlinuz-3.11.10-29-default

The OS is OpenSUSE 13.1 x86_64, i attached the logs.

Best regards,
     alimon

On 04/05/15 10:09, Aníbal Limón wrote:
> Hi Simon,
>
> Sorry about the problems that i caused, i was out from office.
> I'm working in for a solution.
>
> Best regards,
>     alimon
>
> On 30/04/15 20:15, Simon Horman wrote:
>> On Thu, Apr 30, 2015 at 02:09:44PM +0900, Simon Horman wrote:
>>> On Wed, Apr 29, 2015 at 03:36:17PM -0700, Yinghai Lu wrote:
>>>> with
>>>>
>>>> commit 5edcbfd1368e84fce913ceeeca7b712c524dc20d
>>>> Author: Aníbal Limón <anibal.limon@linux.intel.com>
>>>> Date:   Thu Mar 26 16:19:58 2015 +0000
>>>>
>>>>      x86_64: Add support to build kexec-tools with x32 ABI
>>>>
>>>>
>>>> after built kexec on opensuse 13.1 64bit, now when using kexec load
>>>> kernel, I got
>>>>
>>>> overflow in relocation type R_X86_64_32 val 21dffc020
>>>>
>>>> revert that commit and the one after it, kexec is working again.
>>> Thanks for bringing this to my attention.
>>>
>>> My current plan is to revert the above patch from the kexec tree
>>> unless a fix is forthcoming by tomorrow.
>> I have reverted the above commit.
>>
>> Aníbal and others, I am more than happy to consider a revised
>> version of the above patch or another solution to the problem it
>> aimed to solve.
>


--------------040002080803080109060500
Content-Type: text/plain; charset=UTF-8;
 name="os-release"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="os-release"

TkFNRT1vcGVuU1VTRQpWRVJTSU9OPSIxMy4xIChCb3R0bGUpIgpWRVJTSU9OX0lEPSIxMy4x
IgpQUkVUVFlfTkFNRT0ib3BlblNVU0UgMTMuMSAoQm90dGxlKSAoeDg2XzY0KSIKSUQ9b3Bl
bnN1c2UKQU5TSV9DT0xPUj0iMDszMiIKQ1BFX05BTUU9ImNwZTovbzpvcGVuc3VzZTpvcGVu
c3VzZToxMy4xIgpCVUdfUkVQT1JUX1VSTD0iaHR0cHM6Ly9idWdzLm9wZW5zdXNlLm9yZyIK
SE9NRV9VUkw9Imh0dHBzOi8vb3BlbnN1c2Uub3JnLyIKSURfTElLRT0ic3VzZSIK
--------------040002080803080109060500
Content-Type: text/x-log;
 name="kexec-opensuse-13.1.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kexec-opensuse-13.1.log"

Try gzip decompression.
kernel: 0x7fc475888010 kernel_size: 0x4c0988
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
sym: sha256_starts value: 203fff70e0 addr: 203fff6004
R_X86_64_64
sym: sha256_update info: 12 other: 00 shndx: 1 value: 4936 size: 154
sym: sha256_update value: 203fffa936 addr: 203fff600f
R_X86_64_64
sym: sha256_regions info: 11 other: 00 shndx: 8 value: 20 size: 100
sym: sha256_regions value: 203fffc020 addr: 203fff601a
R_X86_64_64
sym: sha256_regions info: 11 other: 00 shndx: 8 value: 20 size: 100
sym: sha256_regions value: 203fffc120 addr: 203fff6044
R_X86_64_64
sym: sha256_finish info: 12 other: 00 shndx: 1 value: 4a8a size: 34b
sym: sha256_finish value: 203fffaa8a addr: 203fff605b
R_X86_64_64
sym: sha256_digest info: 11 other: 00 shndx: 8 value: 0 size: 20
sym: sha256_digest value: 203fffc000 addr: 203fff606c
R_X86_64_64
sym:     memcmp info: 12 other: 00 shndx: 1 value: 59f size: 21
sym: memcmp value: 203fff659f addr: 203fff6079
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 203fffaef0 addr: 203fff608f
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 4bd size: a0
sym: printf value: 203fff64bd addr: 203fff609b
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 203fffaf10 addr: 203fff60a7
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 203fffaf20 addr: 203fff60be
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 4bd size: a0
sym: printf value: 203fff64bd addr: 203fff60c8
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 203fffaf26 addr: 203fff60da
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 203fffaf28 addr: 203fff60eb
R_X86_64_64
sym: sha256_digest info: 11 other: 00 shndx: 8 value: 0 size: 20
sym: sha256_digest value: 203fffc000 addr: 203fff60fa
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 203fffaf20 addr: 203fff610e
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 203fffaf26 addr: 203fff6122
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 4bd size: a0
sym: printf value: 203fff64bd addr: 203fff612c
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 203fffaf38 addr: 203fff6149
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 4bd size: a0
sym: printf value: 203fff64bd addr: 203fff6155
R_X86_64_64
sym: setup_arch info: 12 other: 00 shndx: 1 value: 764 size: 3a
sym: setup_arch value: 203fff6764 addr: 203fff6162
R_X86_64_64
sym: verify_sha256_digest info: 12 other: 00 shndx: 1 value: 0 size: 147
sym: verify_sha256_digest value: 203fff6000 addr: 203fff616e
R_X86_64_64
sym: post_verification_setup_arch info: 12 other: 00 shndx: 1 value: 7d6 size: 3c
sym: post_verification_setup_arch value: 203fff67d6 addr: 203fff6181
R_X86_64_64
sym:    putchar info: 12 other: 00 shndx: 1 value: d6c size: 143
sym: putchar value: 203fff6d6c addr: 203fff61ca
R_X86_64_64
sym:    putchar info: 12 other: 00 shndx: 1 value: d6c size: 143
sym: putchar value: 203fff6d6c addr: 203fff620c
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 203fffaf4a addr: 203fff62d7
R_X86_64_64
sym:    putchar info: 12 other: 00 shndx: 1 value: d6c size: 143
sym: putchar value: 203fff6d6c addr: 203fff63db
R_X86_64_64
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 18c size: 29b
sym: vsprintf value: 203fff618c addr: 203fff64ab
R_X86_64_64
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 18c size: 29b
sym: vsprintf value: 203fff618c addr: 203fff654b
R_X86_64_64
sym:    entry32 info: 10 other: 00 shndx: 1 value: 5c0 size: 0
sym: entry32 value: 203fff65bc addr: 203fff65cd
R_X86_64_PC32
sym:    entry32 info: 10 other: 00 shndx: 1 value: 5c0 size: 0
sym: entry32 value: 203fff65bc addr: 203fff65e2
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffc13c addr: 203fff65fd
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffc11c addr: 203fff6604
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae04 addr: 203fff660a
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffc18c addr: 203fff6610
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffaddc addr: 203fff6616
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae71 addr: 203fff6649
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae80 addr: 203fff6650
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae8b addr: 203fff6657
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae96 addr: 203fff665e
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffaea1 addr: 203fff6665
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffaeac addr: 203fff666c
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffaeb7 addr: 203fff6673
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffaea6 addr: 203fff667a
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffc251 addr: 203fff6681
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae9c addr: 203fff6693
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffaecc addr: 203fff66a9
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae0c addr: 203fff66bc
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae14 addr: 203fff66c3
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae1c addr: 203fff66ca
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae24 addr: 203fff66d1
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae2c addr: 203fff66d8
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae34 addr: 203fff66df
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae3c addr: 203fff66e6
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae44 addr: 203fff66ed
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae4c addr: 203fff66f4
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae54 addr: 203fff66fb
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae5c addr: 203fff6702
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae64 addr: 203fff6709
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae6c addr: 203fff6710
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae74 addr: 203fff6717
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae7c addr: 203fff671e
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae84 addr: 203fff6725
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffae8c addr: 203fff672b
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffaecc addr: 203fff6733
R_X86_64_PC32
sym: jump_back_entry info: 11 other: 00 shndx: 8 value: 2008 size: 8
sym: jump_back_entry value: 203fffe004 addr: 203fff674d
R_X86_64_PC32
sym:       .bss info: 03 other: 00 shndx: a value: 0 size: 0
sym: .bss value: 203ffffffc addr: 203fff6754
R_X86_64_PC32
sym:  purgatory info: 12 other: 00 shndx: 1 value: 147 size: 44
sym: purgatory value: 203fff6143 addr: 203fff6759
R_X86_64_PC32
sym:    entry64 info: 10 other: 00 shndx: 1 value: 690 size: 0
sym: entry64 value: 203fff668c addr: 203fff675e
R_X86_64_PC32
sym:  reset_vga info: 11 other: 00 shndx: 8 value: 2012 size: 1
sym: reset_vga value: 203fffe012 addr: 203fff6766
R_X86_64_64
sym: x86_reset_vga info: 12 other: 00 shndx: 1 value: eb0 size: 1f9
sym: x86_reset_vga value: 203fff6eb0 addr: 203fff6776
R_X86_64_64
sym: legacy_pic info: 11 other: 00 shndx: 8 value: 2011 size: 1
sym: legacy_pic value: 203fffe011 addr: 203fff6782
R_X86_64_64
sym: x86_setup_legacy_pic info: 12 other: 00 shndx: 1 value: 10ac size: 31
sym: x86_setup_legacy_pic value: 203fff70ac addr: 203fff6792
R_X86_64_64
sym: cmdline_end info: 11 other: 00 shndx: 8 value: 2000 size: 8
sym: cmdline_end value: 203fffe000 addr: 203fff67a0
R_X86_64_64
sym: jump_back_entry info: 11 other: 00 shndx: 8 value: 2008 size: 8
sym: jump_back_entry value: 203fffe008 addr: 203fff67b2
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 203fffaf5b addr: 203fff67bc
R_X86_64_64
sym:    sprintf info: 12 other: 00 shndx: 1 value: 427 size: 96
sym: sprintf value: 203fff6427 addr: 203fff67c9
R_X86_64_64
sym: panic_kernel info: 11 other: 00 shndx: 8 value: 2010 size: 1
sym: panic_kernel value: 203fffe010 addr: 203fff67d8
R_X86_64_64
sym: crashdump_backup_memory info: 12 other: 00 shndx: 1 value: c84 size: 3e
sym: crashdump_backup_memory value: 203fff6c84 addr: 203fff67e9
R_X86_64_64
sym: jump_back_entry info: 11 other: 00 shndx: 8 value: 2008 size: 8
sym: jump_back_entry value: 203fffe008 addr: 203fff67f5
R_X86_64_64
sym: x86_setup_jump_back_entry info: 12 other: 00 shndx: 1 value: 79e size: 38
sym: x86_setup_jump_back_entry value: 203fff679e addr: 203fff6806
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe047 addr: 203fff6837
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe04f addr: 203fff683d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe075 addr: 203fff685d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe07f addr: 203fff6863
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe089 addr: 203fff6869
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe093 addr: 203fff686f
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe076 addr: 203fff6876
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe08d addr: 203fff687d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe06d addr: 203fff6947
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe075 addr: 203fff694d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe09b addr: 203fff696d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe0a5 addr: 203fff6973
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe0af addr: 203fff6979
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe0b9 addr: 203fff697f
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe0e2 addr: 203fff69c2
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe12b addr: 203fff6a05
R_X86_64_PC32
sym: backup_src_start info: 11 other: 00 shndx: 8 value: 2078 size: 8
sym: backup_src_start value: 203fffe078 addr: 203fff6c86
R_X86_64_64
sym: backup_src_size info: 11 other: 00 shndx: 8 value: 2070 size: 8
sym: backup_src_size value: 203fffe070 addr: 203fff6c93
R_X86_64_64
sym: backup_start info: 11 other: 00 shndx: 8 value: 2080 size: 8
sym: backup_start value: 203fffe080 addr: 203fff6ca5
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 1 value: 587 size: 18
sym: memcpy value: 203fff6587 addr: 203fff6cb7
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe088 addr: 203fff6cc6
R_X86_64_64
sym: serial_base info: 11 other: 00 shndx: 8 value: 2090 size: 2
sym: serial_base value: 203fffe090 addr: 203fff6cd4
R_X86_64_64
sym: serial_baud info: 11 other: 00 shndx: 8 value: 208c size: 4
sym: serial_baud value: 203fffe08c addr: 203fff6d10
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe088 addr: 203fff6d44
R_X86_64_64
sym: console_vga info: 11 other: 00 shndx: 8 value: 2093 size: 1
sym: console_vga value: 203fffe093 addr: 203fff6d6f
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe098 addr: 203fff6d85
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe098 addr: 203fff6dea
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe094 addr: 203fff6dff
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe098 addr: 203fff6e0e
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe098 addr: 203fff6e21
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe094 addr: 203fff6e2d
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe094 addr: 203fff6e51
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe094 addr: 203fff6e64
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe098 addr: 203fff6e76
R_X86_64_64
sym: console_serial info: 11 other: 00 shndx: 8 value: 2092 size: 1
sym: console_serial value: 203fffe092 addr: 203fff6e80
R_X86_64_64
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff6cc4 addr: 203fff6e92
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 1 value: 587 size: 18
sym: memcpy value: 203fff6587 addr: 203fffa9e8
R_X86_64_64
sym: sha256_process info: 12 other: 00 shndx: 1 value: 1159 size: 37dd
sym: sha256_process value: 203fff7159 addr: 203fffaa06
R_X86_64_64
sym: sha256_process info: 12 other: 00 shndx: 1 value: 1159 size: 37dd
sym: sha256_process value: 203fff7159 addr: 203fffaa3c
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 1 value: 587 size: 18
sym: memcpy value: 203fff6587 addr: 203fffaa7e
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffe0a0 addr: 203fffab37
R_X86_64_64
sym: sha256_update info: 12 other: 00 shndx: 1 value: 4936 size: 154
sym: sha256_update value: 203fffa936 addr: 203fffab44
R_X86_64_64
sym: sha256_update info: 12 other: 00 shndx: 1 value: 4936 size: 154
sym: sha256_update value: 203fffa936 addr: 203fffab63
R_X86_64_64
sym:    entry16 info: 10 other: 00 shndx: 1 value: 820 size: 0
sym: entry16 value: 203fff6820 addr: 203fffae08
R_X86_64_64
sym:    entry32 info: 10 other: 00 shndx: 1 value: 5c0 size: 0
sym: entry32 value: 203fff65c0 addr: 203fffae90
R_X86_64_64
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffaea0 addr: 203fffaea2
R_X86_64_64
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 203fffaed0 addr: 203fffaed2
R_X86_64_64
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff6000 addr: 203fffaf98
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff6147 addr: 203fffafcc
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff618c addr: 203fffb000
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff6427 addr: 203fffb04c
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff64bd addr: 203fffb068
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff6560 addr: 203fffb0a0
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff6573 addr: 203fffb0b4
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff6587 addr: 203fffb0c8
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff659f addr: 203fffb0dc
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff6764 addr: 203fffb108
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff679e addr: 203fffb128
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff67d6 addr: 203fffb13c
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff6c84 addr: 203fffb178
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff6cc4 addr: 203fffb1a8
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff6d6c addr: 203fffb1c4
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff6eb0 addr: 203fffb208
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff70ac addr: 203fffb238
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff70e0 addr: 203fffb268
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fff7159 addr: 203fffb288
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fffa936 addr: 203fffb2a8
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 203fffaa8a addr: 203fffb2c8
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 203fffc120 addr: 203fffc122
R_X86_64_64
Loaded purgatory at addr 0x203fff6000
Loaded real_mode_data and command line at 0x203fff1000
kernel init_size 0x123b000
Loaded 64bit kernel at 0x203e000000
E820 memmap:
0000000000010000-000000000009ffff (1)
0000000000100000-00000000b6673fff (1)
00000000b6674000-00000000b6a73fff (4)
00000000b6a74000-00000000b6b35fff (1)
00000000b6b36000-00000000b6d36fff (2)
00000000b6d37000-00000000b86bffff (1)
00000000b86c0000-00000000b88c3fff (2)
00000000b88c4000-00000000b89c3fff (4)
00000000b89c4000-00000000b8a43fff (3)
00000000b8a44000-00000000bca87fff (1)
00000000bcab8000-00000000bcaeffff (1)
00000000bd2f0000-00000000bd31bfff (2)
00000000bd31c000-00000000bd35afff (3)
00000000bd35b000-00000000bfffffff (2)
00000000e0000000-00000000efffffff (2)
00000000fe000000-00000000ffffffff (2)
0000000100000000-000000203fffffff (1)
/sys/firmware/edd does not exist.
kexec_load: entry = 0x203fff6730 flags = 0x3e0000
nr_segments = 3
segment[0].buf   = 0x7fc47588c410
segment[0].bufsz = 0x4bc588
segment[0].mem   = 0x203e000000
segment[0].memsz = 0x123b000
segment[1].buf   = 0x10343a0
segment[1].bufsz = 0x4441
segment[1].mem   = 0x203fff1000
segment[1].memsz = 0x5000
segment[2].buf   = 0x102c280
segment[2].bufsz = 0x80e0
segment[2].mem   = 0x203fff6000
segment[2].memsz = 0xa000

--------------040002080803080109060500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------040002080803080109060500--

