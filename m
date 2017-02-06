Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cap8x-0000Hp-RG
 for kexec@lists.infradead.org; Mon, 06 Feb 2017 19:40:20 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v2 00/12] crashdump: Add print_crashkernel_region_size()
 function
Date: Mon,  6 Feb 2017 13:42:12 -0600
Message-Id: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org, andrew.cooper3@citrix.com, dyoung@redhat.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

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
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
v0: Interal version.
v1: Posted to kexec-tools mailing list
v2: Incorporated feedback:
    - utilize the is_crashkernel_mem_reserved() function common in all archs
    - for ppc and ppc64, utilize device-tree values to print size
    - for unsupported architectures, print appropriate message


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
