Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fldsmtpe04.verizon.com ([140.108.26.143])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VzWdt-0004i0-K3
 for kexec@lists.infradead.org; Sat, 04 Jan 2014 19:12:18 +0000
From: Don Slutz <dslutz@verizon.com>
Subject: [PATCH 4/4] Add basic domain.guest_type support.
Date: Sat,  4 Jan 2014 14:11:26 -0500
Message-Id: <1388862686-1832-5-git-send-email-dslutz@verizon.com>
In-Reply-To: <1388862686-1832-1-git-send-email-dslutz@verizon.com>
References: <1388862686-1832-1-git-send-email-dslutz@verizon.com>
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
To: crash-utility@redhat.com
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, Don Slutz <dslutz@verizon.com>, xen-devel@lists.xen.org

Signed-off-by: Don Slutz <dslutz@verizon.com>
---
 xen_hyper.c             | 8 ++++++++
 xen_hyper_defs.h        | 1 +
 xen_hyper_dump_tables.c | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/xen_hyper.c b/xen_hyper.c
index 00a0e2c..c18e815 100644
--- a/xen_hyper.c
+++ b/xen_hyper.c
@@ -207,6 +207,7 @@ xen_hyper_domain_init(void)
 	XEN_HYPER_MEMBER_OFFSET_INIT(domain_domain_flags, "domain", "domain_flags");
 	XEN_HYPER_MEMBER_OFFSET_INIT(domain_evtchn, "domain", "evtchn");
 	XEN_HYPER_MEMBER_OFFSET_INIT(domain_is_hvm, "domain", "is_hvm");
+	XEN_HYPER_MEMBER_OFFSET_INIT(domain_guest_type, "domain", "guest_type");
 	XEN_HYPER_MEMBER_OFFSET_INIT(domain_is_privileged, "domain", "is_privileged");
 	XEN_HYPER_MEMBER_OFFSET_INIT(domain_debugger_attached, "domain", "debugger_attached");
 
@@ -1251,6 +1252,13 @@ xen_hyper_store_domain_context(struct xen_hyper_domain_context *dc,
                     *(dp + XEN_HYPER_OFFSET(domain_is_hvm))) {
 			dc->domain_flags |= XEN_HYPER_DOMS_HVM;
 		}
+                if (XEN_HYPER_VALID_MEMBER(domain_guest_type) &&
+                    *(dp + XEN_HYPER_OFFSET(domain_guest_type))) {
+			/* For now PVH and HVM are the same for crash.
+			 * and 0 is PV.
+			 */
+			dc->domain_flags |= XEN_HYPER_DOMS_HVM;
+		}
 		if (*(dp + XEN_HYPER_OFFSET(domain_is_privileged))) {
 			dc->domain_flags |= XEN_HYPER_DOMS_privileged;
 		}
diff --git a/xen_hyper_defs.h b/xen_hyper_defs.h
index 1f5b0ba..abc9a07 100644
--- a/xen_hyper_defs.h
+++ b/xen_hyper_defs.h
@@ -673,6 +673,7 @@ struct xen_hyper_offset_table {
 	long domain_domain_flags;
 	long domain_evtchn;
 	long domain_is_hvm;
+	long domain_guest_type;
 	long domain_is_privileged;
 	long domain_debugger_attached;
 	long domain_is_polling;
diff --git a/xen_hyper_dump_tables.c b/xen_hyper_dump_tables.c
index 38558d5..337eb25 100644
--- a/xen_hyper_dump_tables.c
+++ b/xen_hyper_dump_tables.c
@@ -772,6 +772,8 @@ xen_hyper_dump_xen_hyper_offset_table(char *spec, ulong makestruct)
 		(buf, "%ld\n", xen_hyper_offset_table.domain_evtchn));
 	XEN_HYPER_PRI(fp, len, "domain_is_hvm: ", buf, flag,
 		(buf, "%ld\n", xen_hyper_offset_table.domain_is_hvm));
+	XEN_HYPER_PRI(fp, len, "domain_guest_type: ", buf, flag,
+		(buf, "%ld\n", xen_hyper_offset_table.domain_guest_type));
 	XEN_HYPER_PRI(fp, len, "domain_is_privileged: ", buf, flag,
 		(buf, "%ld\n", xen_hyper_offset_table.domain_is_privileged));
 	XEN_HYPER_PRI(fp, len, "domain_debugger_attached: ", buf, flag,
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
