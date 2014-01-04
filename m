Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fldsmtpe04.verizon.com ([140.108.26.143])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VzWdZ-0004gs-4q
 for kexec@lists.infradead.org; Sat, 04 Jan 2014 19:11:57 +0000
From: Don Slutz <dslutz@verizon.com>
Subject: [PATCH 2/4] xen: Fix offset output to be decimal.
Date: Sat,  4 Jan 2014 14:11:24 -0500
Message-Id: <1388862686-1832-3-git-send-email-dslutz@verizon.com>
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

---
 xen_hyper_dump_tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xen_hyper_dump_tables.c b/xen_hyper_dump_tables.c
index 0582159..38558d5 100644
--- a/xen_hyper_dump_tables.c
+++ b/xen_hyper_dump_tables.c
@@ -767,7 +767,7 @@ xen_hyper_dump_xen_hyper_offset_table(char *spec, ulong makestruct)
 	XEN_HYPER_PRI(fp, len, "domain_next_in_list: ", buf, flag,
 		(buf, "%ld\n", xen_hyper_offset_table.domain_next_in_list));
 	XEN_HYPER_PRI(fp, len, "domain_domain_flags: ", buf, flag,
-		(buf, "%lx\n", xen_hyper_offset_table.domain_domain_flags));
+		(buf, "%ld\n", xen_hyper_offset_table.domain_domain_flags));
 	XEN_HYPER_PRI(fp, len, "domain_evtchn: ", buf, flag,
 		(buf, "%ld\n", xen_hyper_offset_table.domain_evtchn));
 	XEN_HYPER_PRI(fp, len, "domain_is_hvm: ", buf, flag,
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
