Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bPm73-0002cx-Uj
 for kexec@lists.infradead.org; Wed, 20 Jul 2016 07:40:14 +0000
Received: from penelope.kanocho.kobe.vergenet.net
 (p6047-ipbfp602kobeminato.hyogo.ocn.ne.jp [118.10.78.47])
 by kirsty.vergenet.net (Postfix) with ESMTPSA id 7DAFA25B7DD
 for <kexec@lists.infradead.org>; Wed, 20 Jul 2016 17:39:51 +1000 (AEST)
Date: Wed, 20 Jul 2016 16:39:50 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools v2.0.13 preparation
Message-ID: <20160720073950.GA28399@verge.net.au>
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
To: kexec@lists.infradead.org

Hi all,

I am planning to release kexec-tools v2.0.13 around the time that
the v4.7 kernel is released.

I would like to ask interested parties to send any patches they would like
included in v2.0.13 within the next week so that I can make an rc release.

For reference the patches queued up since v2.0.12 are as follows:

8d614008609f arm: use zImage size from header
f11d833efcbf arm: plug a zImage corner case
4db7f295d596 arm: fix kernel image size
fe9b19d49be8 arm: take account of TEXT_OFFSET for subsequent images
bf759f2aa662 Remove "max" parameter comment
dfd1de046099 arm: report which ELF core format we will use
9eb4a681fde5 arm: clean up phys/page offset debug
2f10ffb193c2 arm: fix type of phys_offset
fbee2f01cddf arm: add debug of reserved and coredump memory ranges
921a8d1d5bb2 arm: add support for boot-time crash kernel resource
db8209860120 arm: add support for multiple reserved regions
3e6bd29e7b02 arm: rename crash_reserved_mem to crash_kernel_mem
e401f4732157 arm: crashdump needs boot alias of crash kernel region
92e120d8ca5e arm: add support for platforms with boot memory aliases
103656d85960 arm: move crash system RAM parsing earlier
11c52266a2e3 arm: use generic mem_region sorting implementation
a40977d6d7ed arm: parse crash_reserved_mem early
d4b51af1719d arm: add maximum number of memory ranges
66d941fccb47 arm: add memory ranges debug
ccb582a4399f arm: report if crash kernel is out of bounds
8431da92d965 arm: return proper error for missing crash kernel
a5eacd16516f arm: fix ELF32/ELF64 check
38c18bb7d1e2 arm: fix get_kernel_stext_sym() to close its file
2185c79d3bf4 arm: fix off-by-one on memory end
45251676e562 arm: fix pointer signedness warning in kexec-uImage-arm.c
61ac72aefb9e kexec: add helper to exlude a region from a set of memory ranges
7dc06a544ffd kexec: add mem_regions sorting implementation
ba1e37a8ede8 kexec: add generic helper to add to memory_regions
8d8d2229a3af kexec: phys_to_virt() must take unsigned long long
5450d34a8864 kexec: add max_size to memory_ranges
58a5eb73678e kexec: fix warnings caused by selecting 64-bit file IO on 32-bit platforms
1c28b55604f3 kdump: print mmap() offset in hex
cb9056e009a9 arm: fix kdump to work on LPAE systems
58afa4991bf8 kdump: fix kdump mapping
e11f8002ce69 kdump: actually write out the memory
5a5ef3b9b71c kdump: fix multiple program header entries
bab7cb1ce778 kdump: mmap() and munmap() only work on page-aligned quantites
2a36d76bbbc3 arm: Change setup_dtb_prop to create nodes by offset and node name
a4360e730675 zImage-arm: Add support for booting android images
977f0ced4343 zImage-arm: Fix a return value check that use the wrong variable
3debb8cf3272 Properly align powerpc64 .toc
1e423dc297d1 ppc64: purgatory: Handle local symbols in ELF ABIv2
4a2ae3a39c64 Pass struct mem_sym into machine_apply_elf_rel()
75f7bc488432 kexec-tools 2.0.12.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
