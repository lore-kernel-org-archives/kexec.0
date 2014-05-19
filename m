Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WmMFH-0005Rj-1O
 for kexec@lists.infradead.org; Mon, 19 May 2014 12:00:44 +0000
Message-ID: <5379F222.4090604@huawei.com>
Date: Mon, 19 May 2014 19:59:30 +0800
From: Wang Nan <wangnan0@huawei.com>
MIME-Version: 1.0
Subject: [BUG REPORT] kexec and makedumpfile can't detect PAGE_OFFSET on arm
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Atsushi and Simon,

I find a problem about VMSPLIT on arm plarform, related to kexec and
makedumpfile.

When CONFIG_VMSPLIT_1G/2G is selected by kernel, PAGE_OFFSET is actually
0x40000000 or 0x80000000. However, kexec hard codes PAGE_OFFSET to
0xc0000000 (in kexec/arch/arm/crashdump-arm.h), which is incorrect in
these situations. For example, on realview-pbx board with 1G/3G VMSPLIT,
PHDRs in generated /proc/vmcore is as follow:

  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  NOTE           0x001000 0x00000000 0x00000000 0x00690 0x00690     0
  LOAD           0x002000 0xc0000000 0x00000000 0x10000000 0x10000000 RWE 0
  LOAD           0x10002000 0xe0000000 0x20000000 0x8000000 0x8000000 RWE 0
  LOAD           0x18002000 0xf0000000 0x30000000 0x10000000 0x10000000 RWE 0
  LOAD           0x28002000 0x40000000 0x80000000 0x10000000 0x10000000 RWE 0

Which should be:

  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  ...
  LOAD            ...     0x40000000 0x00000000 0x10000000 0x10000000 RWE 0
  LOAD            ...     0x60000000 0x20000000 0x8000000 0x8000000 RWE 0
  LOAD            ...     0x70000000 0x30000000 0x10000000 0x10000000 RWE 0
  LOAD            ...     0xc0000000 0x80000000 0x10000000 0x10000000 RWE 0

I don't know why crash utility can deal with it without problem, but in
makedumpfile such VMSPLIT setting causes segfault:

 $ ./makedumpfile -c -d 31 /proc/vmcore ./out -f
 The kernel version is not supported.
 The created dumpfile may be incomplete.
 Excluding unnecessary pages        : [  0.0 %] /Segmentation fault

There are many ways to deal with it, I want discuss them in the maillist and
make a decision:

 1. Kexec changes, detect PAGE_OFFSET dynamically. However, I don't know
    whether there is a reliably way for this purpose, here I suggest
    kernel to export PAGE_OFFSET through sysfs, such as
    /sys/kernel/page_offset.

 2. Or, kexec accepts PAGE_OFFSET as a command line arguments, let user
    provide correct information.

 3. Or, makedumpfile changes, don't trust EHDR anymore. Kernel should
    export PAGE_OFFSET through VMCOREINFO.

How do you feel?

Thank you!



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
