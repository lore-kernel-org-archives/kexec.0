Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400080.outbound.protection.outlook.com
 ([40.107.140.80] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgzP4-00AwQH-6E
 for kexec@lists.infradead.org; Thu, 13 May 2021 00:40:40 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: [ANNOUNCE] makedumpfile 1.6.9 is available
Date: Thu, 13 May 2021 00:40:20 +0000
Message-ID: <OSBPR01MB19918FBC00F42965E3E6FF92DD519@OSBPR01MB1991.jpnprd01.prod.outlook.com>
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
To: kexec-ml <kexec@lists.infradead.org>

Hi,

I'm pleased to announce the release of makedumpfile-1.6.9.
I would like to thank everyone who contributed to this release.
Your comments/patches are always welcome.

Download:
The latest makedumpfile can be downloaded from the following URL.
https://github.com/makedumpfile/makedumpfile/releases

Main new features: 
- Support for recent arm64 kernels and 52-bit kernel VA
- Support for mips64 architecture
- Add --dry-run option and report of write byte size
- Support for newer kernels up to v5.12 (x86_64)

decc5ef97412 [PATCH] Support newer kernels up to v5.12 (Kazuhito Hagio)
a8250642a4ff [PATCH] x86_64: fix a use-after-free bug in -e option (Kazuhito Hagio)
974a507447e8 [PATCH] mips64: Retrieve MAX_PHYSMEM_BITS from vmcoreinfo (Youling Tang)
f8348d3efa53 [PATCH] fix build on sparc64 (Fabrice Fontaine)
0ef2ca6c9fa2 [PATCH] Show write byte size in report messages (Kazuhito Hagio)
a0216b678a95 [PATCH 3/3] arm64: support flipped VA and 52-bit kernel VA (Kazuhito Hagio)
67d0e1d68f28 [PATCH 2/3] arm64: Make use of NUMBER(VA_BITS) in vmcoreinfo (Kazuhito Hagio)
d8b701796f04 [PATCH 1/3] Use vmcoreinfo note in /proc/kcore for --mem-usage option (Kazuhito Hagio)
7f185d29aa17 [PATCH v2] Add initial mips64 support (Youling Tang)
01b4bd354c4a [PATCH] Makefile: Fix a compile error on Debian with pthread (Jiang Wang)
6f3e75a558ed [PATCH 2/2] Add shorthand --show-stats option to show report stats (Julien Thierry)
3422e1d6bc35 [PATCH 1/2] Add --dry-run option to prevent writing the dumpfile (Julien Thierry)
54aec3878b3f [PATCH] make use of 'uts_namespace.name' offset in VMCOREINFO (Alexander Egorenkov)
44b073b7ec46 [PATCH 2/2] printk: use committed/finalized state values (John Ogness)
c617ec633392 [PATCH 1/2] printk: add support for lockless ringbuffer (John Ogness)

Thanks,
Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
