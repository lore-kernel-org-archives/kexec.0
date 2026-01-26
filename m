Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CB8CF65DC
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nhGnuKqDmjsgPTBGV/GCL3/yxdPmLaO9kYF2GeSnp4E=; b=V6lAxXcaRba/Y18tu8DCZhMRgN
	4h/RzvBTd5qE1YghLRRU4oOeOZ/fozJip+8rr+hSm70Z6rvjdyFzfgvp/TLkQeJhZ+Tj6mE/hd7aA
	9B0fe9UEsyQWJbT12zJiKOPMnJmw75n7B79kJeDrf3QkopeDE3RXb0qjsI0ZexkqYH6eNXOBOpp9J
	ypH9mXJNeNDgj0HNApAOZ3HtH18fsZ+QaD7apXAC5rmVEOjQbeGort1kY/a0Nbhj7zU4xnLuCjDSU
	9CreCz7LDmNctYmU1PweObdDkNenRcBIU14DzK354fyP4MHEPhq3DQrM8GyB2zkbhGgqpkWarsQdn
	8LtH+gqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkKeQ-0000000CPFb-0U02;
	Mon, 26 Jan 2026 11:20:58 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkKeL-0000000CPF7-2VOg
	for kexec@lists.infradead.org;
	Mon, 26 Jan 2026 11:20:54 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60PKQCOO030960;
	Mon, 26 Jan 2026 11:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=nhGnuKqDmjsgPTBGV/GCL3/yxdPmLaO9kYF2GeSnp4E=; b=KBkxifqW
	8wFC3U4S/NXBVjreayld5Xu0vEJxxwh2NHPISXxYTHEhlWUbsHN+y0QlKhzLjvt6
	YuTOMmKz2Yx2k3NoeuZ18XUy/ESDq5KV4Z/dJD4OH29Se7wB8M7yBrLH71jylncH
	o7AURpqmU0LI7G465mQLM3n87cvKcdG4eJV/m/U7kz1JQyUrbIrcGM8AFXxvHUmo
	IloiF/wabV4GwN7JIHm4LpuaO18AHYDh23bSkTrY+9CDkIfPo9iVox5BHEc507uT
	UhalEXbwps+0J9RxSNp1jPjNFnxc86N5IEaDFjFQOWh826L8OnmbBbdVEgZdHYWV
	+0noSJSzlHSrfQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmes52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 11:20:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60QAul7i031048;
	Mon, 26 Jan 2026 11:20:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dscftr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 11:20:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60QBKmtJ51708238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 11:20:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C18B020043;
	Mon, 26 Jan 2026 11:20:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2949520040;
	Mon, 26 Jan 2026 11:20:48 +0000 (GMT)
Received: from localhost (unknown [9.111.28.207])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 26 Jan 2026 11:20:48 +0000 (GMT)
Date: Mon, 26 Jan 2026 12:20:46 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crash_dump: fix dm_crypt keys locking and ref leak
Message-ID: <patch.git-2d4d76083a5c.your-ad-here.call-01769426386-ext-2560@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=69774e13 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=LJbtVcqbS3dIJv1iuH4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: murARjc-QDbNMnOReiZCiwmAmQv3Wde5
X-Proofpoint-ORIG-GUID: murARjc-QDbNMnOReiZCiwmAmQv3Wde5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA5NiBTYWx0ZWRfX3ns8rBe4tE3g
 HRcsTtxM18CNftJ0Eh/DUncCLO20i9omltayiaXoj1OBpeDY6M9FLK1gEqgD45cEtlntcoz4MQv
 +EPMredhwbLKCqC3FGaRs9gNZIM/MfnGrOmaQ6l46mg2v5C8pnCmx5ix9kAMqeTlP6FcenIBZ7N
 nAw07VOrUqC0x+BqjSDTuW2gR7ZyoEv1KYXjyod7I/vXSadlKsRRsUbXWjHD/5Kt9OLQXRMJIJI
 iZBfHbfuqDiWzyr7nVIeqrr7ZADOgIsFVp1PV2oqbCVUGIf8z+RDsgVYcyQWxJtrBb0UCxcTcLI
 C1uBAj6fZKTRE0oW/QMj/J0py+RwSaF4OuLcg7bcusXd3kDZpPDqBK3r2mxA5U27bqd+rOxuIGM
 1nV7uZHyBZugYxiGIpy3gi9EqwmDGuvh9dkbdW7vn7XPvSXD5Nh/wi8PkZzM928ygvYnUdsSDI9
 5G35J11g2vhFbibHIhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601260096
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_032053_759830_7B4E1433 
X-CRM114-Status: GOOD (  15.72  )
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

crash_load_dm_crypt_keys() reads dm-crypt volume keys from the user
keyring. It uses user_key_payload_locked() without holding key->sem,
which makes lockdep complain when kexec_file_load() assembles the
crash image:

  =============================
  WARNING: suspicious RCU usage
  -----------------------------
  ./include/keys/user-type.h:53 suspicious rcu_dereference_protected() usage!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  no locks held by kexec/4875.

  stack backtrace:
  Call Trace:
   <TASK>
   dump_stack_lvl+0x5d/0x80
   lockdep_rcu_suspicious.cold+0x4e/0x96
   crash_load_dm_crypt_keys+0x314/0x390
   bzImage64_load+0x116/0x9a0
   ? __lock_acquire+0x464/0x1ba0
   __do_sys_kexec_file_load+0x26a/0x4f0
   do_syscall_64+0xbd/0x430
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

In addition, the key returned by request_key() is never key_put()'d,
leaking a key reference on each load attempt.

Take key->sem while copying the payload and drop the key reference
afterwards.

Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 kernel/crash_dump_dm_crypt.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 0d23dc1de67c..37129243054d 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -143,6 +143,7 @@ static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
 {
 	const struct user_key_payload *ukp;
 	struct key *key;
+	int ret = 0;
 
 	kexec_dprintk("Requesting logon key %s", dm_key->key_desc);
 	key = request_key(&key_type_logon, dm_key->key_desc, NULL);
@@ -152,20 +153,28 @@ static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
 		return PTR_ERR(key);
 	}
 
+	down_read(&key->sem);
 	ukp = user_key_payload_locked(key);
-	if (!ukp)
-		return -EKEYREVOKED;
+	if (!ukp) {
+		ret = -EKEYREVOKED;
+		goto out;
+	}
 
 	if (ukp->datalen > KEY_SIZE_MAX) {
 		pr_err("Key size %u exceeds maximum (%u)\n", ukp->datalen, KEY_SIZE_MAX);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	memcpy(dm_key->data, ukp->data, ukp->datalen);
 	dm_key->key_size = ukp->datalen;
 	kexec_dprintk("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
 		      dm_key->key_desc, dm_key->data);
-	return 0;
+
+out:
+	up_read(&key->sem);
+	key_put(key);
+	return ret;
 }
 
 struct config_key {
-- 
2.52.0

