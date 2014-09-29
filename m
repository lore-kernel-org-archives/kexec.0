Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XYV4h-0006YL-Ue
 for kexec@lists.infradead.org; Mon, 29 Sep 2014 07:08:48 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s8T78MZ9024419
 for <kexec@lists.infradead.org>; Mon, 29 Sep 2014 15:08:23 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v1 0/5] makedumpfile: --split: assign fair I/O workloads in
 appropriate time
Date: Mon, 29 Sep 2014 15:06:22 +0800
Message-ID: <1411974387-10839-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

The issue is discussed at http://lists.infradead.org/pipermail/kexec/2014-March/011289.html

This patch implements the idea of 2-pass algorhythm with smaller memory to manage block table.
Exactly the algorhythm is still 3-pass,but the time of second pass is much shorter.
The tables below show the performence with different size of cyclic-buffer and block.
The test is executed on the machine having 128G memory.

the value is total time (including first pass and second pass).
the value in brackets is the time of second pass.
															      sec
	cyclic-buffer	1		2		4		8		16		32		64
block-size
1M			4.74(0.00)	4.22(0.01)	3.94(0.01)	3.78(0.02)	3.71(0.03)	3.73(0.07)	3.74(0.10)	
2M			4.74(0.00)	4.19(0.00)	3.94(0.01)	3.80(0.03)	3.71(0.03)	3.72(0.07)	3.72(0.09)	
4M			4.73(0.00)	4.21(0.01)	3.95(0.01)	3.78(0.02)	3.70(0.02)	3.73(0.08)	3.73(0.10)	
8M			4.73(0.00)	4.19(0.00)	3.94(0.01)	3.83(0.02)	3.73(0.03)	3.72(0.07)	3.74(0.10)	
16M			4.74(0.01)	4.21(0.00)	3.94(0.01)	3.76(0.01)	3.73(0.03)	3.73(0.08)	3.74(0.10)	
32M			4.72(0.00)	4.20(0.02)	3.92(0.01)	3.77(0.02)	3.71(0.02)	3.70(0.06)	3.74(0.10)	
64M			4.74(0.01)	4.20(0.00)	3.95(0.01)	3.78(0.02)	3.70(0.02)	3.71(0.07)	3.72(0.09)	
128M			4.73(0.01)	4.20(0.00)	3.94(0.01)	3.78(0.02)	3.76(0.03)	3.72(0.08)	3.74(0.09)	
256M			4.75(0.02)	4.22(0.02)	3.96(0.03)	3.78(0.02)	3.70(0.03)	3.70(0.07)	3.74(0.11)	
512M			4.77(0.04)	4.21(0.03)	3.97(0.04)	3.79(0.03)	3.73(0.04)	3.75(0.09)	3.82(0.13)	
1G			4.82(0.09)	4.26(0.07)	4.00(0.08)	3.83(0.07)	3.76(0.08)	3.73(0.08)	3.76(0.12)	
2G			8.26(3.54)	7.34(3.14)	6.86(2.93)	6.56(2.80)	6.44(2.76)	6.45(2.79)	6.42(2.80)

the performence of 3-pass algorhythm
origin			8.25(3.54)	7.26(3.11)	6.80(2.91)	6.52(2.80)	6.39(2.76)	6.40(2.78)	6.45(2.85)

															       sec
	cyclic-buffer	128		256		512		1024		2048		4096		8192	
block-size
1M			3.83(0.21)	3.94(0.33)	4.16(0.54)	4.61(0.99)	7.03(3.41)	8.73(5.11)	8.69(5.08)
2M			3.86(0.21)	3.92(0.32)	4.16(0.54)	4.64(0.98)	7.02(3.41)	8.71(5.09)	8.72(5.09)
4M			3.82(0.21)	3.95(0.32)	4.18(0.55)	4.62(0.99)	7.05(3.44)	8.70(5.09)	8.68(5.07)
8M			3.82(0.21)	3.95(0.33)	4.17(0.54)	4.58(0.97)	7.03(3.41)	8.79(5.16)	8.71(5.09)
16M			3.83(0.21)	3.93(0.31)	4.15(0.54)	4.60(0.98)	7.06(3.43)	8.76(5.13)	8.73(5.10)
32M			3.84(0.22)	3.93(0.32)	4.15(0.54)	4.61(0.98)	7.00(3.40)	8.69(5.08)	8.75(5.13)
64M			3.84(0.21)	3.94(0.33)	4.15(0.54)	4.60(0.98)	7.04(3.42)	8.74(5.10)	8.80(5.16)
128M			3.85(0.22)	3.97(0.33)	4.16(0.54)	4.60(0.98)	7.07(3.44)	8.68(5.07)	8.69(5.07)
256M			3.84(0.21)	3.94(0.33)	4.16(0.55)	4.64(1.00)	7.02(3.41)	8.74(5.11)	8.73(5.11)
512M			3.85(0.24)	3.97(0.34)	4.17(0.56)	4.61(0.99)	7.05(3.44)	8.73(5.11)	8.75(5.13)
1G			3.85(0.22)	3.96(0.35)	4.18(0.56)	4.65(1.00)	7.06(3.44)	8.76(5.12)	8.72(5.11)
2G			6.53(2.91)	6.86(3.25)	7.54(3.92)	8.95(5.31)	10.60(6.97)	14.08(10.47)	14.32(10.60)

the performence of 3-pass algorhythm
origin			6.64(3.05)	6.81(3.24)	7.51(3.93)	8.86(5.30)	10.51(6.94)	13.92(10.36)	14.11(10.55)

Zhou Wenjian (5):
  Add support for block
  Add tools for reading and writing from block table
  Add module of generating table
  Add module of calculating start_pfn and end_pfn in each dumpfile
  Add support for --block-size

 makedumpfile.8 |   16 ++++
 makedumpfile.c |  245 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 makedumpfile.h |   15 ++++
 3 files changed, 271 insertions(+), 5 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
