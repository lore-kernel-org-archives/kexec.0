Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3TQn-0004oW-6b
 for kexec@lists.infradead.org; Wed, 15 Jan 2014 16:35:06 +0000
Date: Wed, 15 Jan 2014 11:34:27 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] Add /sys/kernel/vmcoreinfo ABI documentation
Message-ID: <20140115163427.GA3180@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux kernel mailing list <linux-kernel@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

/sys/kernel/vmcoreinfo was introduced long back but there is no ABI
documentation. This patch adds the documentation.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 Documentation/ABI/testing/sysfs-kernel-vmcoreinfo |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: linux-2.6/Documentation/ABI/testing/sysfs-kernel-vmcoreinfo
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/Documentation/ABI/testing/sysfs-kernel-vmcoreinfo	2014-01-15 11:30:22.402206445 -0500
@@ -0,0 +1,14 @@
+What:		/sys/kernel/vmcoreinfo
+Date:		October 2007
+KernelVersion:	2.6.24
+Contact:	Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
+		Kexec Mailing List <kexec@lists.infradead.org>
+		Vivek Goyal <vgoyal@redhat.com>
+Description
+		Shows physical address and size of vmcoreinfo ELF note.
+		First value contains physical address of note in hex and
+		second value contains the size of note in hex. This ELF
+		note info is parsed by second kernel and exported to user
+		space as part of ELF note in /proc/vmcore file. This note
+		contains various information like struct size, symbol
+		values, page size etc.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
