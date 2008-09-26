Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kj5lR-0008QH-3p
	for kexec@lists.infradead.org; Fri, 26 Sep 2008 05:21:19 +0000
Message-ID: <48DC6C23.1040704@mxs.nes.nec.co.jp>
Date: Fri, 26 Sep 2008 13:59:15 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: Problems writing ELF dumps with makedumpfile 1.2.9
References: <28113A0489833849A1CF9EC16F42154340494D5BA0@GVW1097EXB.americas.hpqcorp.net>
	<48D72B2B.3000406@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F4215434049544C88@GVW1097EXB.americas.hpqcorp.net>
	<48D9EDDC.1070600@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F421543404958892C@GVW1097EXB.americas.hpqcorp.net>
	<48DB29A6.3070608@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F4215434049588E80@GVW1097EXB.americas.hpqcorp.net>
In-Reply-To: <28113A0489833849A1CF9EC16F4215434049588E80@GVW1097EXB.americas.hpqcorp.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0084307720=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Worth, Kevin" <kevin.worth@hp.com>
Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>

--===============0084307720==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


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


--===============0084307720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0084307720==--
