Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTEi7-0005aD-Gs
 for kexec@lists.infradead.org; Thu, 27 Mar 2014 18:07:27 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH 2/2] Get Dom0 max_pfn using pfn_mfn_frame_list if max_pfn
 unavailable
Date: Thu, 27 Mar 2014 19:06:16 +0100
Message-Id: <1395943576-25362-3-git-send-email-ptesarik@suse.cz>
In-Reply-To: <1395943576-25362-1-git-send-email-ptesarik@suse.cz>
References: <20140327175508.5F86560141@nathan.suse.cz>
 <1395943576-25362-1-git-send-email-ptesarik@suse.cz>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, Petr Tesarik <ptesarik@suse.cz>

If max_pfn symbol is not exported in the Dom0 kernel's VMCOREINFO, the
maximum PFN can be determined from the size of the mapping between PFN
and MFN.

Using this approach, filtering works for Xen kernels without debuginfo
(and even without adding more lines to VMCOREINFO).

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 makedumpfile.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index d3f5237..92e8a6a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -189,9 +189,30 @@ get_dom0_mapnr()
 		}
 
 		info->dom0_mapnr = max_pfn;
-		DEBUG_MSG("domain-0 pfn : %llx\n", info->dom0_mapnr);
+	} else if (info->p2m_frames) {
+		unsigned long mfns[MFNS_PER_FRAME];
+		unsigned long mfn_idx = info->p2m_frames - 1;
+		unsigned long long maddr;
+		unsigned i;
+
+		maddr = pfn_to_paddr(info->p2m_mfn_frame_list[mfn_idx]);
+		if (!readmem(MADDR_XEN, maddr, &mfns, sizeof(mfns))) {
+			ERRMSG("Can't read %ld domain-0 mfns at 0x%llu\n",
+				(long)MFNS_PER_FRAME, maddr);
+			return FALSE;
+		}
+
+		for (i = 0; i < MFNS_PER_FRAME; ++i)
+			if (!mfns[i])
+				break;
+
+		info->dom0_mapnr = mfn_idx * MFNS_PER_FRAME + i;
+	} else {
+		/* dom0_mapnr is unavailable, which may be non-critical */
+		return TRUE;
 	}
 
+	DEBUG_MSG("domain-0 pfn : %llx\n", info->dom0_mapnr);
 	return TRUE;
 }
 
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
