Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KjLsi-0004fE-7m
	for kexec@lists.infradead.org; Fri, 26 Sep 2008 22:33:49 +0000
From: "Worth, Kevin" <kevin.worth@hp.com>
Date: Fri, 26 Sep 2008 22:32:39 +0000
Subject: RE: Problems writing ELF dumps with makedumpfile 1.2.9
Message-ID: <28113A0489833849A1CF9EC16F4215434049D3EDB5@GVW1097EXB.americas.hpqcorp.net>
References: <28113A0489833849A1CF9EC16F42154340494D5BA0@GVW1097EXB.americas.hpqcorp.net>
	<48D72B2B.3000406@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F4215434049544C88@GVW1097EXB.americas.hpqcorp.net>
	<48D9EDDC.1070600@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F421543404958892C@GVW1097EXB.americas.hpqcorp.net>
	<48DB29A6.3070608@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F4215434049588E80@GVW1097EXB.americas.hpqcorp.net>,
	<48DC6C23.1040704@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F4215434049EAF1D2@GVW1097EXB.americas.hpqcorp.net>
In-Reply-To: <28113A0489833849A1CF9EC16F4215434049EAF1D2@GVW1097EXB.americas.hpqcorp.net>
Content-Language: en-US
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>

Note patching required ignoring whitespace (perhaps a tab/space issue in hunk #3 of makedumpfile.c?)

worthk:~/makedumpfile-1.2.9$ patch -p1 --dry-run <v1.3.0-rc01.patch
patching file Makefile
Hunk #1 succeeded at 1 with fuzz 1.
patching file ia64.c
patching file makedumpfile-R.pl
patching file makedumpfile.c
Hunk #3 FAILED at 240.
1 out of 17 hunks FAILED -- saving rejects to file makedumpfile.c.rej
patching file makedumpfile.h
patching file x86.c
patching file x86_64.c

worthk:~/makedumpfile-1.2.9$ patch -l -p1 --dry-run <v1.3.0-rc01.patch
patching file Makefile
Hunk #1 succeeded at 1 with fuzz 1.
patching file ia64.c
patching file makedumpfile-R.pl
patching file makedumpfile.c
patching file makedumpfile.h
patching file x86.c
patching file x86_64.c

The fuzz messages is because I'm patching against a makefile that was modified by Ubuntu to use "-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE" rather than "-D_FILE_OFFSET_BITS=64". Perhaps the difference between the Ubuntu version and this upstream setting should be resolved... Ubuntu changelog at https://launchpad.net/ubuntu/+source/makedumpfile  with note "Use _LARGEFILE_SOURCE and _LARGEFILE64_SOURCE instead of _FILE_OFFSET_BITS=64 for correct compilation." Could this have negative effects or is it just a different way to tell the compiler to support large files?

CFLAGS = -g -O2 -Wall -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE \
          -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'
CFLAGS_ARCH     = -g -O2 -Wall -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE



On to the actual testing- I wonder if I am worse off than before applying this patch...

With command line "makedumpfile -D -E -d 31 -I $rootmnt/boot/vmcoreinfo /proc/vmcore $rootmnt/var/crash/vmcore" I get what appears to be a regression in check_release:

readmem: Can't convert a virtual address(403c1364) to physical address.
check_release: Can't get the address of system_utsname.
LOAD (0)
  phys_start : 0
  phys_end   : a0000
  virt_start : c0000000
  virt_end   : c00a0000
LOAD (1)
  phys_start : 100000
  phys_end   : 1000000
  virt_start : c0100000
  virt_end   : c1000000
LOAD (2)
  phys_start : 5000000
  phys_end   : 38000000
  virt_start : c5000000
  virt_end   : f8000000
LOAD (3)
  phys_start : 38000000
  phys_end   : bf790000
  virt_start : ffffffffffffffff
  virt_end   : 8778ffff
LOAD (4)
  phys_start : 100000000
  phys_end   : 140000000
  virt_start : ffffffffffffffff
  virt_end   : 3fffffff
Linux kdump

max_mapnr    : 140000

PAE          : ON

makedumpfile Failed.


If I change the command line to "makedumpfile -D -E -d 1 -I $rootmnt/boot/vmcoreinfo /proc/vmcore $rootmnt/var/crash/vmcore" (simply turn "-d" down to 1) I get

Excluding zero pages               : [ 33 %] readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
create_2nd_bitmap: Can't exclude pages filled with zerocreate_2nd_bitmap: for creating an ELF dumpfile.
LOAD (0)
  phys_start : 0
  phys_end   : a0000
  virt_start : c0000000
  virt_end   : c00a0000
LOAD (1)
  phys_start : 100000
  phys_end   : 1000000
  virt_start : c0100000
  virt_end   : c1000000
LOAD (2)
  phys_start : 5000000
  phys_end   : 38000000
  virt_start : c5000000
  virt_end   : f8000000
LOAD (3)
  phys_start : 38000000
  phys_end   : bf790000
  virt_start : ffffffffffffffff
  virt_end   : 8778ffff
LOAD (4)
  phys_start : 100000000
  phys_end   : 140000000
  virt_start : ffffffffffffffff
  virt_end   : 3fffffff
Linux kdump

max_mapnr    : 140000
mem_map (0)
  mem_map    : 0
  pfn_start  : 0
  pfn_end    : 140000

makedumpfile Failed.


-----Original Message-----
From: kexec-bounces@lists.infradead.org [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Worth, Kevin
Sent: Friday, September 26, 2008 9:46 AM
To: Ken'ichi Ohmichi
Cc: Masaki Tachibana; kexec-ml
Subject: RE: Problems writing ELF dumps with makedumpfile 1.2.9

Could the fact that my kernel's page offset is different from the defaut be the cause of the address being beyond the maximum?
(from the kernel config diff I sent before, changing the VMSPLIT parameter, which gives the kernel 3GB of memory, causes the PAGE_OFFSET value to shift)

dif between default ubuntu and my kernel config:
< CONFIG_PAGE_OFFSET=0xC0000000
---
> # CONFIG_VMSPLIT_3G is not set
> # CONFIG_VMSPLIT_3G_OPT is not set
> # CONFIG_VMSPLIT_2G is not set
> CONFIG_VMSPLIT_1G=y
> CONFIG_PAGE_OFFSET=0x40000000

I don't know much about these memory internals, but just pointing out a spot in my config that is different from usual.

I will try testing with the new patch and report back.

-Kevin

________________________________________
From: Ken'ichi Ohmichi [oomichi@mxs.nes.nec.co.jp]
Sent: Thursday, September 25, 2008 9:59 PM
To: Worth, Kevin
Cc: Masaki Tachibana; kexec-ml
Subject: Re: Problems writing ELF dumps with makedumpfile 1.2.9

Hi Kevin,

Thank you for testing.

Worth, Kevin wrote:
> Below is the additional information you asked for (run with the patch you attached).
> It appears the binutils readelf has problems with reading the vmcore file
> (got error message "readelf: Error: Could not locate '/proc/vmcore'.
> System error message: Value too large for defined data type").
> I installed elfutils and used eu-readelf.
> That appears to work correctly.
>
> readmem: Can't seek the dump memory(/proc/vmcore). (Invalid argument) offset:b2800000ae7a02d8, addr:2c00000000
> create_2nd_bitmap: Can't exclude pages filled with zerocreate_2nd_bitmap: for creating an ELF dumpfile.
> LOAD (0)
>   phys_start : 0
>   phys_end   : a0000
>   virt_start : c0000000
>   virt_end   : c00a0000
> LOAD (1)
>   phys_start : 100000
>   phys_end   : 1000000
>   virt_start : c0100000
>   virt_end   : c1000000
> LOAD (2)
>   phys_start : 5000000
>   phys_end   : 38000000
>   virt_start : c5000000
>   virt_end   : f8000000
> LOAD (3)
>   phys_start : 38000000
>   phys_end   : bf790000
>   virt_start : ffffffffffffffff
>   virt_end   : 8778ffff
> LOAD (4)
>   phys_start : 100000000
>   phys_end   : 140000000
>   virt_start : ffffffffffffffff
>   virt_end   : 3fffffff
> Linux kdump
>
> max_mapnr    : 140000
>
> [snip]
>
> Program Headers:
>   Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
>   NOTE           0x000190 0x0000000000000000 0x0000000000000000 0x000148 0x000148     0x0
>   LOAD           0x0002d8 0x00000000c0000000 0x0000000000000000 0x0a0000 0x0a0000 RWE 0x0
>   LOAD           0x0a02d8 0x00000000c0100000 0x0000000000100000 0xf00000 0xf00000 RWE 0x0
>   LOAD           0xfa02d8 0x00000000c5000000 0x0000000005000000 0x33000000 0x33000000 RWE 0x0
>   LOAD           0x33fa02d8 0xffffffffffffffff 0x0000000038000000 0x87790000 0x87790000 RWE 0x0
>   LOAD           0xbb7302d8 0xffffffffffffffff 0x0000000100000000 0x40000000 0x40000000 RWE 0x0

According to the above log, problematic physical address is 0x2c00000000,
and this address is larger than the maximum physical address 0x140000000.
So.. now I cannot guess the cause why it happens.
In exclude_zero_pages(), the physical address is calculated by adding
page_size like the following:

int
exclude_zero_pages(void)
{
...
        for (pfn = paddr = 0; pfn < info->max_mapnr;
            pfn++, paddr += info->page_size) {

                print_progress(PROGRESS_ZERO_PAGES, pfn, info->max_mapnr);

                if (!is_in_segs(paddr))
                        continue;

                if (!is_dumpable(&bitmap2, pfn))
                        continue;

                if (!readmem(PADDR, paddr, buf, info->page_size))
                        return FALSE;

                if (is_zero_page(buf, info->page_size)) {
                        clear_bit_on_2nd_bitmap(pfn);
                        pfn_zero++;
                }
        }

info->max_mapnr is 0x140000, so the physical address(paddr) must be
smaller than 0x140000000 (0x140000 * 0x1000(page_size)).

I'd like to know the detail, so could you please test again ?
Some patches which we created recently are merged to one patch
(v1.3.0-rc01.patch), and it contains new error messages for
debugging this problem. Please download the patch from below
URL and try it.

https://sourceforge.net/tracker/index.php?func=detail&aid=2129657&group_id=178938&atid=887141

or

https://sourceforge.net/projects/makedumpfile/
-> [Tracker] -> [Patches] -> v1.3.0-rc01


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
