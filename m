Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcsinet15.oracle.com ([148.87.113.117])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SzpGp-0004lH-9c
 for kexec@lists.infradead.org; Fri, 10 Aug 2012 13:28:55 +0000
Date: Fri, 10 Aug 2012 15:27:33 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 4/6] xen: Get idle data from alternative source
Message-ID: <20120810132733.GE2576@host-192-168-1-59.local.net-space.pl>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: anderson@redhat.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, olaf@aepfle.de, jbeulich@suse.com, ptesarik@suse.cz, crash-utility@redhat.com, kexec@lists.infradead.org, xen-devel@lists.xensource.com

idle member was removed from struct schedule_data by 21422 changeset
(Fix CPU hotplug after percpu data handling changes). Get idle data
from alternative source.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

diff -Npru crash-6.0.8.orig/xen_hyper.c crash-6.0.8/xen_hyper.c
--- crash-6.0.8.orig/xen_hyper.c	2012-07-05 16:05:31.000000000 +0200
+++ crash-6.0.8/xen_hyper.c	2012-07-05 16:08:52.000000000 +0200
@@ -397,7 +397,8 @@ xen_hyper_misc_init(void)
 	XEN_HYPER_STRUCT_SIZE_INIT(schedule_data, "schedule_data");
 	XEN_HYPER_MEMBER_OFFSET_INIT(schedule_data_schedule_lock, "schedule_data", "schedule_lock");
 	XEN_HYPER_MEMBER_OFFSET_INIT(schedule_data_curr, "schedule_data", "curr");
-	XEN_HYPER_MEMBER_OFFSET_INIT(schedule_data_idle, "schedule_data", "idle");
+	if (MEMBER_EXISTS("schedule_data", "idle"))
+		XEN_HYPER_MEMBER_OFFSET_INIT(schedule_data_idle, "schedule_data", "idle");
 	XEN_HYPER_MEMBER_OFFSET_INIT(schedule_data_sched_priv, "schedule_data", "sched_priv");
 	XEN_HYPER_MEMBER_OFFSET_INIT(schedule_data_s_timer, "schedule_data", "s_timer");
 	XEN_HYPER_MEMBER_OFFSET_INIT(schedule_data_tick, "schedule_data", "tick");
@@ -539,7 +540,10 @@ xen_hyper_schedule_init(void)
 		}
 		schc->cpu_id = cpuid;
 		schc->curr = ULONG(buf + XEN_HYPER_OFFSET(schedule_data_curr));
-		schc->idle = ULONG(buf + XEN_HYPER_OFFSET(schedule_data_idle));
+		if (MEMBER_EXISTS("schedule_data", "idle"))
+			schc->idle = ULONG(buf + XEN_HYPER_OFFSET(schedule_data_idle));
+		else
+			schc->idle = xht->idle_vcpu_array[cpuid];
 		schc->sched_priv =
 			ULONG(buf + XEN_HYPER_OFFSET(schedule_data_sched_priv));
 		if (XEN_HYPER_VALID_MEMBER(schedule_data_tick))

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
