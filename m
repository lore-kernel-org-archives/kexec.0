Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XmIoL-0006cC-S5
 for kexec@lists.infradead.org; Thu, 06 Nov 2014 08:52:59 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sA68qMtj032645
 for <kexec@lists.infradead.org>; Thu, 6 Nov 2014 16:52:23 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH V5 0/5] makedumpfile: --split: assign fair I/O workloads in
 appropriate time
Date: Thu, 6 Nov 2014 16:49:23 +0800
Message-ID: <1415263768-15821-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: kexec@lists.infradead.org

v4->v5:
	1.fix the bug that last end_pfn can be shorter than the max_mapnr

v3->v4:
	1.address Atsushi Kumagai's comments about using divideup

v2->v3:
	1.remove the filtering for incomplete block (previous second pass) and adjust
	  relevant codes
	2.address HATAYAMA's comments about coding style

v1->v2:
	1.use splitblock instead of block
	2.add restriction (align to the page size) to splitblock size
	3.adjust the position of prepare_splitblock_table and check the return code
	4.use --splitblock-size to specify splitblock size and modify the print_info.c

the v2 test result is:

	cyc-buf	128		256		512		1024		2048		4096	
splblk-size
2M		24.05(0.65)	24.04(0.65)	24.58(0.65)	24.15(0.64)	24.14(0.64)	49.05(25.46)
4M		23.98(0.65)	24.01(0.65)	24.29(0.65)	24.20(0.64)	24.18(0.66)	49.04(25.46)
8M		24.02(0.65)	24.03(0.65)	24.25(0.65)	24.26(0.70)	24.15(0.64)	48.98(25.44)
16M		24.01(0.65)	24.01(0.65)	24.30(0.65)	24.19(0.64)	24.12(0.65)	48.99(25.45)
32M		23.97(0.65)	24.06(0.73)	24.23(0.65)	24.17(0.64)	24.19(0.64)	48.97(25.50)
64M		24.06(0.66)	24.07(0.66)	24.27(0.66)	24.16(0.65)	24.17(0.65)	48.98(25.49)
128M		24.03(0.67)	24.00(0.67)	24.27(0.66)	24.22(0.66)	24.19(0.66)	48.98(25.48)
256M		24.12(0.67)	23.99(0.67)	24.27(0.67)	24.17(0.66)	24.12(0.66)	49.04(25.49)
512M		24.06(0.70)	24.08(0.70)	24.26(0.70)	24.14(0.71)	24.19(0.70)	49.13(25.64)
1G		24.20(0.82)	24.13(0.81)	24.36(0.81)	24.31(0.80)	24.33(0.81)	49.28(25.75)
2G		24.19(0.81)	24.22(0.81)	24.37(0.81)	24.29(0.80)	24.28(0.82)	49.30(25.78)
4G		25.29(1.90)	25.26(1.91)	25.49(1.91)	25.41(1.89)	25.50(1.90)	49.99(26.45)
8G		25.33(1.90)	26.60(3.23)	26.87(3.21)	26.71(3.23)	26.64(3.22)	51.27(27.73)
16G		25.28(1.90)	26.52(3.21)	29.47(5.86)	29.34(5.84)	29.38(5.86)	53.99(30.40)


the latest test result turns to:

	cyc-buf	128		256		512		1024		2048		4096	
splblk-size
2M		23.34(0.00)	23.36(0.00)	23.51(0.00)	23.86(0.00)	23.48(0.00)	23.45(0.00)
4M		23.36(0.00)	23.32(0.00)	23.62(0.00)	23.48(0.00)	23.53(0.00)	23.45(0.00)
8M		23.33(0.00)	23.46(0.00)	23.61(0.00)	23.77(0.00)	23.52(0.00)	23.53(0.00)
16M		23.33(0.00)	23.38(0.00)	23.57(0.00)	23.47(0.00)	23.55(0.00)	23.49(0.00)
32M		23.40(0.00)	23.31(0.00)	23.64(0.00)	23.51(0.00)	23.50(0.00)	23.55(0.00)
64M		23.39(0.00)	23.41(0.00)	23.62(0.00)	23.47(0.00)	23.46(0.00)	23.50(0.00)
128M		23.36(0.00)	23.34(0.00)	23.59(0.00)	23.46(0.00)	23.46(0.00)	23.50(0.00)
256M		23.32(0.00)	23.36(0.00)	23.57(0.00)	23.49(0.00)	23.45(0.00)	23.52(0.00)
512M		23.32(0.00)	23.32(0.00)	23.63(0.00)	23.49(0.00)	23.52(0.00)	23.51(0.00)
1G		23.38(0.00)	23.32(0.00)	23.60(0.00)	23.54(0.00)	23.49(0.00)	23.54(0.00)
2G		23.34(0.00)	23.36(0.00)	23.62(0.00)	23.52(0.00)	23.52(0.00)	23.50(0.00)
4G		23.36(0.00)	23.37(0.00)	23.60(0.00)	23.48(0.00)	23.56(0.00)	23.55(0.00)
8G		23.37(0.00)	23.39(0.00)	23.52(0.00)	23.53(0.00)	23.46(0.00)	23.48(0.00)
16G		23.39(0.00)	23.41(0.00)	23.85(0.00)	23.48(0.00)	23.50(0.00)	23.45(0.00)



Zhou Wenjian (5):
  Add support for splitblock
  Add tools for reading and writing from splitblock table
  Add module of generating table
  Add module of calculating start_pfn and end_pfn in each dumpfile
  Add support for --splitblock-size

 makedumpfile.8 |   10 +++
 makedumpfile.c |  245 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 makedumpfile.h |   19 +++++
 print_info.c   |    5 +
 4 files changed, 273 insertions(+), 6 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
