Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPHIW-000718-Ng
 for kexec@lists.infradead.org; Mon, 08 Apr 2013 19:00:10 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 1/8] x86: give FIX_EFI_MPF its own fixmap entry
Date: Mon, 8 Apr 2013 19:59:46 +0100
Message-ID: <1365447593-11988-2-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
References: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: Ian Jackson <Ian.Jackson@eu.citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Ian Campbell <Ian.Campbell@citrix.com>

From: David Vrabel <david.vrabel@citrix.com>

FIX_EFI_MPF was the same as FIX_KEXEC_BASE_0 which is going away.  So
add its own entry.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 xen/arch/x86/mpparse.c       |    2 --
 xen/include/asm-x86/fixmap.h |    1 +
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/xen/arch/x86/mpparse.c b/xen/arch/x86/mpparse.c
index 97ab5d3..f13ba93 100644
--- a/xen/arch/x86/mpparse.c
+++ b/xen/arch/x86/mpparse.c
@@ -538,8 +538,6 @@ static inline void __init construct_default_ISA_mptable(int mpc_default_type)
 	}
 }
 
-#define FIX_EFI_MPF FIX_KEXEC_BASE_0
-
 static __init void efi_unmap_mpf(void)
 {
 	if (efi_enabled)
diff --git a/xen/include/asm-x86/fixmap.h b/xen/include/asm-x86/fixmap.h
index d026d78..2eefcf4 100644
--- a/xen/include/asm-x86/fixmap.h
+++ b/xen/include/asm-x86/fixmap.h
@@ -71,6 +71,7 @@ enum fixed_addresses {
     FIX_APEI_RANGE_BASE,
     FIX_APEI_RANGE_END = FIX_APEI_RANGE_BASE + FIX_APEI_RANGE_MAX -1,
     FIX_IGD_MMIO,
+    FIX_EFI_MPF,
     __end_of_fixed_addresses
 };
 
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
