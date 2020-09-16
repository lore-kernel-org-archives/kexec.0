Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kITQa-0006xs-ME
 for kexec@lists.infradead.org; Wed, 16 Sep 2020 09:08:37 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08G92IEO174256
 for <kexec@lists.infradead.org>; Wed, 16 Sep 2020 05:08:33 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33kfhc8mud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 16 Sep 2020 05:08:33 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08G98C7f022792
 for <kexec@lists.infradead.org>; Wed, 16 Sep 2020 09:08:31 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma01fra.de.ibm.com with ESMTP id 33k5v9884k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 16 Sep 2020 09:08:31 +0000
From: Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: [PATCH 1/1] Calculate offset to field 'init_uts_ns.name'
Date: Wed, 16 Sep 2020 11:08:21 +0200
Message-Id: <20200916090821.929093-1-egorenar@linux.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Alexander Egorenkov <egorenar@linux.ibm.com>

The offset has changed in linux-next (v5.9.0) from 4 to 0 because
there is no more 'kref' member variable at the beginning of 'init_uts_ns'.
The change was introduced with commit 9a56493f6942c0e2df1579986128721da96e00d8.
To handle both cases correctly, calculate the offset at run time instead.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 makedumpfile.c | 6 ++++--
 makedumpfile.h | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 4c4251e..5114705 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1159,7 +1159,7 @@ check_release(void)
 	if (SYMBOL(system_utsname) != NOT_FOUND_SYMBOL) {
 		utsname = SYMBOL(system_utsname);
 	} else if (SYMBOL(init_uts_ns) != NOT_FOUND_SYMBOL) {
-		utsname = SYMBOL(init_uts_ns) + sizeof(int);
+		utsname = SYMBOL(init_uts_ns) + OFFSET(init_uts_ns.name);
 	} else {
 		ERRMSG("Can't get the symbol of system_utsname.\n");
 		return FALSE;
@@ -2077,7 +2077,7 @@ get_str_osrelease_from_vmlinux(void)
 	if (SYMBOL(system_utsname) != NOT_FOUND_SYMBOL) {
 		utsname = SYMBOL(system_utsname);
 	} else if (SYMBOL(init_uts_ns) != NOT_FOUND_SYMBOL) {
-		utsname = SYMBOL(init_uts_ns) + sizeof(int);
+		utsname = SYMBOL(init_uts_ns) + OFFSET(init_uts_ns.name);
 	} else {
 		ERRMSG("Can't get the symbol of system_utsname.\n");
 		return FALSE;
@@ -2697,6 +2697,8 @@ read_vmcoreinfo(void)
 		READ_MEMBER_OFFSET("log.text_len", printk_log.text_len);
 	}
 
+	READ_MEMBER_OFFSET("init_uts_ns.name", init_uts_ns.name);
+
 	READ_ARRAY_LENGTH("node_data", node_data);
 	READ_ARRAY_LENGTH("pgdat_list", pgdat_list);
 	READ_ARRAY_LENGTH("mem_section", mem_section);
diff --git a/makedumpfile.h b/makedumpfile.h
index 03fb4ce..7d8c54d 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1880,6 +1880,10 @@ struct offset_table {
 	struct cpu_spec_s {
 		long	mmu_features;
 	} cpu_spec;
+
+	struct init_uts_ns_s {
+		long	name;
+	} init_uts_ns;
 };
 
 /*
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
