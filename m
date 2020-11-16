Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410087.outbound.protection.outlook.com
 ([40.107.141.87] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keTGP-0003p7-Rx
 for kexec@lists.infradead.org; Mon, 16 Nov 2020 01:25:03 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: [ANNOUNCE] makedumpfile 1.6.8 is released
Date: Mon, 16 Nov 2020 01:24:52 +0000
Message-ID: <OSBPR01MB1991F4B9F1AC7EAE69B77072DDE30@OSBPR01MB1991.jpnprd01.prod.outlook.com>
Content-Language: ja-JP
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi,

I'm pleased to announce the release of makedumpfile-1.6.8.
Thank you all for your help to maintain the makedumpfile tool.
Your comments/patches are always welcome.

Download:
The latest makedumpfile can be downloaded from the following URL.
https://github.com/makedumpfile/makedumpfile/releases

Main new features: 
o --check-params option to verify makedumpfile commandline parameters
o Support for ARMv8.2-LPA (52-bit PA support)
o Support for newer kernels up to v5.9 (x86_64)

Changelog:
fbfa803927bc [PATCH] Support newer kernels up to v5.9 (Kazuhito Hagio)
14b95db24b3f [PATCH] Fix compiler warning for x86 target (Kazuhito Hagio)
da0d25ffa585 [PATCH] arm64: Add support for ARMv8.2-LPA (52-bit PA support) (Bhupesh Sharma)
f1197543d1c4 [PATCH] Retrieve MAX_PHYSMEM_BITS from vmcoreinfo (Bhupesh Sharma)
e4b2fc4a00ac [PATCH 3/3] Cleanup: Remove offset_pt_load_memory (Petr Tesarik)
756dd087916f [PATCH 2/3] Cleanup: Remove unused elf_info.c functions (Petr Tesarik)
1e7764cb150d [PATCH 1/3] Cleanup: Remove a superfluous seek to physical address 0 (Petr Tesarik)
64d2aee2c465 [PATCH] README: Add the necessary method about elfutils (Jinyang He)
3c0cf7a93cff [PATCH] sadump, kaslr: fix failure of calculating kaslr_offset due to an sadump format
                     restriction (HATAYAMA Daisuke)
c9e078531efa [PATCH] sadump: Fix failure of reading __per_cpu_load memory (saito.kazuya@fujitsu.com)
81b79c514ff6 [PATCH] Avoid false-positive failure in mem_seciton validation (Kazuhito Hagio)
7bc78edf20c5 [PATCH] README: Update the URL of makedumpfile project page (Kazuhito Hagio)
6e4b2dfaed5e [PATCH] Fix cd_header offset overflow with large pfn (Jialong Chen)
7242ae4cb528 [PATCH] Align PMD_SECTION_MASK with PHYS_MASK (Michal Suchanek)
12250baa0258 [PATCH] Makefile: Fix build errors in static build (Kazuhito Hagio)
989152e113bf [PATCH] Introduce --check-params option (Kazuhito Hagio)
e113f1c974c8 [PATCH] cope with not-present mem section (Pingfan Liu)
399f2c9a3acd [PATCH] Remove duplicated variable definitions (Kairui Song)

Explanation of makedumpfile:
To shorten the size of the dumpfile and the time of creating the
dumpfile, makedumpfile copies only the necessary pages for analysis
to the dumpfile from /proc/vmcore. You can specify the kind of
unnecessary pages with dump_level. If you want to shorten the size
further, enable the compression of the page data.

Thanks,
Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
