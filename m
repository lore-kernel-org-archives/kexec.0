Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6QHc-0001aK-Kj
 for kexec@lists.infradead.org; Tue, 08 Dec 2015 21:58:53 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 04/14] crashdump/x86: Add print_crashkernel_region_size()
 function
Date: Tue,  8 Dec 2015 22:57:37 +0100
Message-Id: <1449611867-15672-5-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1449611867-15672-1-git-send-email-daniel.kiper@oracle.com>
References: <1449611867-15672-1-git-send-email-daniel.kiper@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, keir@xen.org, david.vrabel@citrix.com, konrad.wilk@oracle.com

Crash kernel region size is available via sysfs on Linux running on
bare metal. However, this does not work when Linux runs as Xen dom0.
In this case Xen crash kernel region size should be established using
__HYPERVISOR_kexec_op hypercall (Linux kernel kexec functionality does
not make a lot of sense in Xen dom0). Sadly hypercalls are not easily
accessible using shell scripts or something like that. Potentially we
can check "xl dmesg" output for crashkernel option but this is not nice.
So, let's add this functionality, for Linux running on bare metal and
as Xen dom0, to kexec-tools. This way kdump scripts may establish crash
kernel region size in one way regardless of platform. All burden of
platform detection lies on kexec-tools.

Figure (and unit) displayed by this new kexec-tools functionality is
the same as one taken from /sys/kernel/kexec_crash_size.

This patch just adds print_crashkernel_region_size() function, which
prints crash kernel region size, for x86 arch. Next patches will add
same named function for other archs supported by kexec-tools. Last patch
of this series will export this functionality to the userspace via
separate kexec utility option.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/arch/i386/crashdump-x86.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index bbc0f35..10a56a8 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -1056,7 +1056,7 @@ static int crashkernel_mem_callback(void *UNUSED(data), int nr,
 	return 0;
 }
 
-int is_crashkernel_mem_reserved(void)
+static int get_crashkernel_region(void)
 {
 	int ret;
 
@@ -1079,3 +1079,19 @@ int is_crashkernel_mem_reserved(void)
 
 	return !!crash_reserved_mem_nr;
 }
+
+int is_crashkernel_mem_reserved(void)
+{
+	return get_crashkernel_region();
+}
+
+void print_crashkernel_region_size(void)
+{
+	uint64_t start, end;
+
+	if (get_crashkernel_region()) {
+		get_crash_kernel_load_range(&start, &end);
+		printf("%lu\n", end - start + 1);
+	} else
+		printf("0\n");
+}
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
