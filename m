Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([119.145.14.64])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK5My-0002lq-Fa
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 11:15:18 +0000
Message-ID: <51503188.8060706@huawei.com>
Date: Mon, 25 Mar 2013 19:14:16 +0800
From: Xishi Qiu <qiuxishi@huawei.com>
MIME-Version: 1.0
Subject: [PATCH] ia64/mm: add size restriction to the kdump
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
To: "Luck, Tony" <tony.luck@intel.com>, vgoyal@redhat.com, hbabu@us.ibm.com, rob@landley.net
Cc: linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

In efi_init() memory aligns in IA64_GRANULE_SIZE(16M). If set "crashkernel=1024M-:600M"
and use sparse memory model, when crash kernel booting it changes [128M-728M] to [128M-720M].

But initrd memory is in [709M-727M], and virt_addr_valid() *can not* check the invalid pages
when freeing initrd memory, because there are some pages missed at the end of the seciton,
and this causes error.

...
Unpacking initramfs...
Freeing initrd memory: 19648kB freed
BUG: Bad page state in process swapper  pfn:02d00
page:e0000000102dd800 flags:(null) count:0 mapcount:1 mapping:(null) index:0

Call Trace:
 [<a000000100018dc0>] show_stack+0x80/0xa0
                                sp=e000000021e8fbd0 bsp=e000000021e81360
 [<a00000010090fcc0>] dump_stack+0x30/0x50
                                sp=e000000021e8fda0 bsp=e000000021e81348
 [<a0000001001a3180>] bad_page+0x280/0x380
                                sp=e000000021e8fda0 bsp=e000000021e81308
 [<a0000001001a8740>] free_hot_cold_page+0x3a0/0x5c0
                                sp=e000000021e8fda0 bsp=e000000021e812a0
 [<a0000001001a8a50>] free_hot_page+0x30/0x60
                                sp=e000000021e8fda0 bsp=e000000021e81280
 [<a0000001001a8b30>] __free_pages+0xb0/0xe0
                                sp=e000000021e8fda0 bsp=e000000021e81258
 [<a0000001001a8c00>] free_pages+0xa0/0xc0
                                sp=e000000021e8fda0 bsp=e000000021e81230
 [<a000000100bb40c0>] free_initrd_mem+0x230/0x290
                                sp=e000000021e8fda0 bsp=e000000021e811d8
 [<a000000100ba6620>] populate_rootfs+0x1c0/0x280
                                sp=e000000021e8fdb0 bsp=e000000021e811a0
 [<a00000010000ac30>] do_one_initcall+0x3b0/0x3e0
                                sp=e000000021e8fdb0 bsp=e000000021e81158
 [<a000000100ba0a90>] kernel_init+0x3f0/0x4b0
                                sp=e000000021e8fdb0 bsp=e000000021e81108
 [<a000000100016890>] kernel_thread_helper+0xd0/0x100
                                sp=e000000021e8fe30 bsp=e000000021e810e0
 [<a00000010000a4c0>] start_kernel_thread+0x20/0x40
                                sp=e000000021e8fe30 bsp=e000000021e810e0
...

In "http://marc.info/?l=linux-arch&m=136147092429314&w=2" Tony said:
"Perhaps in Documentation/kdump/kdump.txt (which the crashkernel entry
in kernel-parameters.txt points at).  The ia64 section of kdump.txt
notes that the start address will be rounded up to a GRANULE boundary,
but doesn't talk about restrictions on the size."

This patch add size restriction to the documentation of kdump.

Signed-off-by: Xishi Qiu <qiuxishi@huawei.com>
---
 Documentation/kdump/kdump.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 13f1aa0..9c7fd98 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -297,6 +297,7 @@ Boot into System Kernel
    On ia64, 256M@256M is a generous value that typically works.
    The region may be automatically placed on ia64, see the
    dump-capture kernel config option notes above.
+   If use sparse memory, the size should be rounded to GRANULE boundaries.

    On s390x, typically use "crashkernel=xxM". The value of xx is dependent
    on the memory consumption of the kdump system. In general this is not
-- 
1.7.6.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
