Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C05C02182
	for <kexec@archiver.kernel.org>; Tue, 21 Jan 2025 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1XuHjAhe+6crgeyPxGiThULHkHEa/QwDtL3yiBvZqn4=; b=jidOvLJq8G6Y1RNphQ2Bh4ucE3
	uU7id65ZAhLfA/ue6eFwiXsFywUbARBJSaG4KjHOaI4qFPYmErz5f6IfWDO2Cv24g4hYqIpkYm2lF
	TLEqb2OCtLKFm7Rjjci5vCNtGQylbFE6w9cZvbDT9QkrHi9fI9fqBy7uDB742NEbp2dfnLuX4XTSM
	1hu6ksA+w6WAXxEcv8LkqJBXwxbdRN39N304RCyl84iYg/OaQmqNM9lhaI23SVNK64cCixejbaLtl
	imMpzBak/a/6uyM2QqzZxp7RrZHMe0E5p30UY6f4G0S/onx+yiK0b6/Pmg+Mp7//uOPYsCH4ZiQ70
	Ol7p69qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taFPM-000000085tC-0z8q;
	Tue, 21 Jan 2025 14:39:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taEUY-00000007zTl-2rmW;
	Tue, 21 Jan 2025 13:40:31 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LBcWDl021758;
	Tue, 21 Jan 2025 13:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1XuHjAhe+6crgeyPxGiThULHkHEa/Q
	wDtL3yiBvZqn4=; b=XXJc1fjY1LEte8uWYOHY0rVlVq4wX9PCcoXpIbn1EYs9EL
	OD4/8pPTNQ9wGah7zwpokGzeZLvKhyS2XwyswSQynQSvx4Pq0nVXT5v0PMm1KdzN
	F6FmU2v9zN3MF0dGtVIr8337iz/SeaELL+AkChcaIBTAfjVK9Q1TKCVQHZUYF4b8
	lkEmavTZcGG7bcRDLLuw9HOFrKWm+iyEw+rBb1iDcR2ksQakFyzbWZB9l+0n9NZH
	7bFXS3CXhWJ3qAfxFUQeEb9d90I2xBmDXS8qIuY9SsKjzzFL1VStL4eYIhJR/WhB
	kacwVPn3TvuRt93neu9S0HZxZA9oxnhjkLM3qkFg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44a1n9b0sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 13:40:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50LAtOsq021012;
	Tue, 21 Jan 2025 13:40:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1b14q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 13:40:19 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50LDeIWj60031254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 13:40:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25C3B2004B;
	Tue, 21 Jan 2025 13:40:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FD1A20040;
	Tue, 21 Jan 2025 13:40:17 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Jan 2025 13:40:17 +0000 (GMT)
Date: Tue, 21 Jan 2025 14:40:16 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
        codalist@coda.cs.cmu.edu, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
        io-uring@vger.kernel.org, bpf@vger.kernel.org,
        kexec@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        Song Liu <song@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2] treewide: const qualify ctl_tables where applicable
Message-ID: <Z4+jwDBrZNRgu85S@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250110-jag-ctl_table_const-v2-1-0000e1663144@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110-jag-ctl_table_const-v2-1-0000e1663144@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mWjZL4Eizm--6YwnTI2RlL8astD0-e-i
X-Proofpoint-GUID: mWjZL4Eizm--6YwnTI2RlL8astD0-e-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_05,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501210112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250121_054030_723458_EFCB0421 
X-CRM114-Status: GOOD (  18.79  )
X-Mailman-Approved-At: Tue, 21 Jan 2025 06:38:05 -0800
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Jan 10, 2025 at 03:16:08PM +0100, Joel Granados wrote:

Hi Joel,

> Add the const qualifier to all the ctl_tables in the tree except for
> watchdog_hardlockup_sysctl, memory_allocation_profiling_sysctls,
> loadpin_sysctl_table and the ones calling register_net_sysctl (./net,
> drivers/inifiniband dirs). These are special cases as they use a
> registration function with a non-const qualified ctl_table argument or
> modify the arrays before passing them on to the registration function.
> 
> Constifying ctl_table structs will prevent the modification of
> proc_handler function pointers as the arrays would reside in .rodata.
> This is made possible after commit 78eb4ea25cd5 ("sysctl: treewide:
> constify the ctl_table argument of proc_handlers") constified all the
> proc_handlers.

I could identify at least these occurences in s390 code as well:

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index dd7ba7587dd5..9b83c318f919 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -204,7 +204,7 @@ appldata_timer_handler(const struct ctl_table *ctl, int write,
 {
 	int timer_active = appldata_timer_active;
 	int rc;
-	struct ctl_table ctl_entry = {
+	const struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &timer_active,
 		.maxlen		= sizeof(int),
@@ -237,7 +237,7 @@ appldata_interval_handler(const struct ctl_table *ctl, int write,
 {
 	int interval = appldata_interval;
 	int rc;
-	struct ctl_table ctl_entry = {
+	const struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &interval,
 		.maxlen		= sizeof(int),
@@ -269,7 +269,7 @@ appldata_generic_handler(const struct ctl_table *ctl, int write,
 	struct list_head *lh;
 	int rc, found;
 	int active;
-	struct ctl_table ctl_entry = {
+	const struct ctl_table ctl_entry = {
 		.data		= &active,
 		.maxlen		= sizeof(int),
 		.extra1		= SYSCTL_ZERO,
diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
index 7857a7e8e56c..7d0ba16085c1 100644
--- a/arch/s390/kernel/hiperdispatch.c
+++ b/arch/s390/kernel/hiperdispatch.c
@@ -273,7 +273,7 @@ static int hiperdispatch_ctl_handler(const struct ctl_table *ctl, int write,
 {
 	int hiperdispatch;
 	int rc;
-	struct ctl_table ctl_entry = {
+	const struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &hiperdispatch,
 		.maxlen		= sizeof(int),
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 6691808bf50a..26e50de83d80 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -629,7 +629,7 @@ static int topology_ctl_handler(const struct ctl_table *ctl, int write,
 	int enabled = topology_is_enabled();
 	int new_mode;
 	int rc;
-	struct ctl_table ctl_entry = {
+	const struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &enabled,
 		.maxlen		= sizeof(int),
@@ -658,7 +658,7 @@ static int polarization_ctl_handler(const struct ctl_table *ctl, int write,
 {
 	int polarization;
 	int rc;
-	struct ctl_table ctl_entry = {
+	const struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &polarization,
 		.maxlen		= sizeof(int),
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 939e3bec2db7..8e354c90a3dd 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -263,7 +263,7 @@ static int cmm_pages_handler(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	long nr = cmm_get_pages();
-	struct ctl_table ctl_entry = {
+	const struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &nr,
 		.maxlen		= sizeof(long),
@@ -283,7 +283,7 @@ static int cmm_timed_pages_handler(const struct ctl_table *ctl, int write,
 				   loff_t *ppos)
 {
 	long nr = cmm_get_timed_pages();
-	struct ctl_table ctl_entry = {
+	const struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
 		.data		= &nr,
 		.maxlen		= sizeof(long),


> Best regards,
> -- 
> Joel Granados <joel.granados@kernel.org>

Thanks!

