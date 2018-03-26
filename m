Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo1502.tsb.2iij.net ([210.149.48.174] helo=mo.tsb.2iij.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f0Gob-0007iJ-Sq
 for kexec@lists.infradead.org; Mon, 26 Mar 2018 01:20:51 +0000
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.tsb.2iij.net (tsb-mr1500) with ESMTP id w2Q1KZZs030638
 for <kexec@lists.infradead.org>; Mon, 26 Mar 2018 10:20:35 +0900
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by imx12.toshiba.co.jp  with ESMTP id w2Q1KZwd027984
 for <kexec@lists.infradead.org>; Mon, 26 Mar 2018 10:20:35 +0900 (JST)
From: <daichi1.fukui@toshiba.co.jp>
Subject: makedumpfile fails on 4.4 longterm kernel with kaslr enabled
Date: Mon, 26 Mar 2018 01:20:31 +0000
Message-ID: <OSBPR01MB216670B2700A61193FF7C0B4F3AD0@OSBPR01MB2166.jpnprd01.prod.outlook.com>
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
To: kexec@lists.infradead.org
Cc: daichi1.fukui@toshiba.co.jp

Dear makedumpfile community,

Hi. My name is Fukui.
Please help me investigate an error related to makedumpfile.

When running the latest makedumpfile 1.6.3 on the Linux 4.4 kernel, we get an error:

-------------------------------------------
vtop4_x86_64: Can't get a valid pml4.
readmem: Can't convert a virtual address(22000000) to physical Address
readmem: type_addr: 0, addr:22000000, size:8
get_page_offset_x86_64: Can't read page_offset_base

makedumpfile Failed.
-------------------------------------------

After investigating the cause of this error, we found that the following patch fails to work correctly on Linux 4.4 kernel: 

[PATCH v5 2/2] x86_64: Calculate page_offset in case of re-filtering/sadump/virsh dump
https://sourceforge.net/p/makedumpfile/code/ci/4944f934845c81f28667b4d7d6452edba062e8e2/

For your information, here is our testing environment.
Linux kernel version: 4.4.112
makedumpfile version: 1.6.3 

According to the patch, the get_symbol_addr function gets the address of symbol "page_offset_base".

+       if (info->kaslr_offset) {
+               page_offset_base = get_symbol_addr("page_offset_base");
+               page_offset_base += info->kaslr_offset;

However, the symbol is available since Linux 4.8, so Linux 4.4 does not have the symbol.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=021182e52fe01c1f7b126f97fd6ba048dc4234fd

In addition, the patch depends on CONFIG_RANDOMIZE_MEMORY, but Linux 4.4 does not support the configuration.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=0483e1fa6e09d4948272680f691dccb1edb9677f

In short, on Linux 4.4, the kaslr patch (x86_64: Calculate page_offset in case of re-filtering/sadump/virsh dump)
does not work correctly because of lacking both of the symbol and the configuration.

Some may think why we run makedumpfile on Linux 4.4. 
We aim at building a longterm supportable Linux system on a PC platform.
Because 4.4 is a longterm release kernel, the kernel is very suitable for our goal.

Range of this influence can be large because Linux 4.4 will be maintained until 2020.
See kernel.org for details:
https://www.kernel.org/category/releases.html

Can you help us correct the compatibility issue?

Thanks,
Fukui




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
