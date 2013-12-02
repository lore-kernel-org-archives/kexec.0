Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnYps-0005Bt-S6
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 19:07:13 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 1/2] kexec-tools/xen: Do not call xc_interface_close() if
 xc_interface_open() failed
Date: Mon,  2 Dec 2013 20:06:24 +0100
Message-Id: <1386011185-29350-2-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1386011185-29350-1-git-send-email-daniel.kiper@oracle.com>
References: <1386011185-29350-1-git-send-email-daniel.kiper@oracle.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: andrew.cooper3@citrix.com, david.vrabel@citrix.com, horms@verge.net.au, kexec@lists.infradead.org, xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Do not call xc_interface_close() if xc_interface_open() failed.
xc_interface_close() crashes if it gets NULL as an argument.
Relevant fix for libxenctrl will be posted too but kexec-tools
should also behave properly.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/arch/i386/crashdump-x86.c    |    2 +-
 kexec/arch/i386/kexec-x86-common.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 85f3a87..a3eb5ae 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -305,7 +305,7 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 
 	if (!xc) {
 		fprintf(stderr, "%s: Failed to open Xen control interface\n", __func__);
-		goto err;
+		return -1;
 	}
 
 	rc = xc_get_machine_memory_map(xc, e820entries, CRASH_MAX_MEMORY_RANGES);
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index bf58f53..f55e2c2 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -176,7 +176,7 @@ static int get_memory_ranges_xen(struct memory_range **range, int *ranges)
 
 	if (!xc) {
 		fprintf(stderr, "%s: Failed to open Xen control interface\n", __func__);
-		goto err;
+		return -1;
 	}
 
 	rc = xc_get_machine_memory_map(xc, e820entries, MAX_MEMORY_RANGES);
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
