Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33AACD342A
	for <kexec@archiver.kernel.org>; Wed, 12 Nov 2025 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SblB2KAmTuwKP3qBb4spBPUSKpxGRH6EYqk/7ae5JNI=; b=DsdAnxGOYy9Iki4X6I3u1HVWxk
	LU4fxLkjeFWq6i3RA/bXdfMra+2srGNcS8QCTtbZH4zaji35EaZYOTQTcyrfcchTa+rm8stEKzQsM
	pzz5pinBzv/PkxGY0khU684YECuHpzjUug9PS+g+5000CXerLfc/zgdlqJwPf2TA0ZNilqRIZNolJ
	HgTQ8JNwzIi4LaIFq0r9fiiwrY6jpVJSfLiRLAJNv4YMsgIIDZl8Gmfosobl828vrfab0yffQVkbR
	UfNqoGO+8ydQe2k7WjrXwzDxdDYUUrWsYi9SRjkHqu2n1NjCpRX362vd4HRVD1iWf/+Yn6BjQhECA
	EytLysAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJEPn-00000009EAE-1n8o;
	Wed, 12 Nov 2025 17:13:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJEPk-00000009E9C-1hHW
	for kexec@lists.infradead.org;
	Wed, 12 Nov 2025 17:13:50 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFrTc2025879;
	Wed, 12 Nov 2025 17:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SblB2KAmTuwKP3qBb4spBPUSKpxGRH6EYqk/7ae5J
	NI=; b=rLUewenBZQMZmNiKlPXede/IPGRlkh5Woy95RzjGmVmLrWYMHrQOVvHpD
	7E9EjkbU1mzJ3ZmEU8qrpxmrv0ICGQsU5PLYFQfXaCAFmTShCWf+UOrqJ8fr6ntK
	IPsRZBE3UWKNSno+iKDjF42+KH4HeLxJGtZlU06yFVBpTKgfn478WxbMjIBruneI
	KCvaOCTnXH6ubWceWIbKmLT8p37+9WhDLezD5qqX6tPHhi+iT2xZ+G2byDeyhAl/
	25b162dQmlipXJAXY7XL+unyzQiaFIT1aYVlCKcAQUwt78jBOPuPEL6+3MCrfgPp
	/ytNXE4rqtg2pX+nLlpk/tMR0a0gQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8bsev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 17:13:39 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACHBcJu014716;
	Wed, 12 Nov 2025 17:13:39 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8bsen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 17:13:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACGqs0F007325;
	Wed, 12 Nov 2025 17:13:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdjh88t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 17:13:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACHDYVR41746812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 17:13:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92AFD20043;
	Wed, 12 Nov 2025 17:13:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39E5720040;
	Wed, 12 Nov 2025 17:13:32 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.124.218.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 17:13:31 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>, kexec@lists.infradead.org
Subject: [PATCH 1/2] powerpc/fadump: remove old sysfs symlink
Date: Wed, 12 Nov 2025 22:43:27 +0530
Message-ID: <20251112171328.298109-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX3VZOPQg7DoL8
 VMYiW/AJqoemTVP/PObzQ7Je8pCTe6Y14hViRhjf9ElOJwMhvU7iIUg8TlNYVHGWo+GFO8j7Uxq
 ys7C/y/TInzbdRTTgbskEFokUVxaTmlnwKabONn0mue1CB10J5nqtwY6LofIGTEZtcQloFhUW4I
 Nd+psar9wQMPBm1IcyCBK0VonbenaOXTCTtGdLfmQ/UUqYw0kJmEr460jNXBYxMmzwWLwJ8py/x
 AUlRGOhLzll8TOOZo/iBgouJaCkhFE6TM63V9J/AqYPXCnJuSP3mI87X2ss1rRccJcribQhedUi
 9Pyw3rVZFFnZTohDvlxNLKf6P2A72OFrNaKwgGawk+Uyft5c4oz8seaaHOA0oMNrCwnEwZDVlUt
 DRN9+MpnwXf5PgTfHcbzwHwS+DW3xQ==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=6914c043 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=MMG_BdGZt7urRIUxIQMA:9
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: 1zoa3h6ASXA9saSPNw_mRyZPk3Jxupyo
X-Proofpoint-GUID: hZeQqP-AEBpOiMNDMrplkHmj8YnqOuiJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_091348_814144_C85D603A 
X-CRM114-Status: GOOD (  13.39  )
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

Commit d418b19f34ed ("powerpc/fadump: Reorganize /sys/kernel/fadump_*
sysfs files") and commit 3f5f1f22ef10 ("Documentation/ABI: Mark
/sys/kernel/fadump_* sysfs files deprecated") moved the
/sys/kernel/fadump_* sysfs files to /sys/kernel/fadump/ and deprecated
the old files in 2019.

To maintain backward compatibility, symlinks were added at the old
locations so existing tools could still work. References [1][2] now use
the new sysfs interface, so we can safely remove the old symlinks.

Link: https://github.com/rhkdump/kdump-utils/commit/fc7c65312a5bef115ce40818bf43ddd3b01b8958 [1]
Link: https://github.com/openSUSE/kdump/commit/c274a22ff5f326c8afaa7bba60bd1b86abfc4fab [2]

Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: kexec@lists.infradead.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kernel/fadump.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4ebc333dd786..4348466260cf 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1604,43 +1604,7 @@ static void __init fadump_init_files(void)
 		pr_err("sysfs group creation failed (%d), unregistering FADump",
 		       rc);
 		unregister_fadump();
-		return;
-	}
-
-	/*
-	 * The FADump sysfs are moved from kernel_kobj to fadump_kobj need to
-	 * create symlink at old location to maintain backward compatibility.
-	 *
-	 *      - fadump_enabled -> fadump/enabled
-	 *      - fadump_registered -> fadump/registered
-	 *      - fadump_release_mem -> fadump/release_mem
-	 */
-	rc = compat_only_sysfs_link_entry_to_kobj(kernel_kobj, fadump_kobj,
-						  "enabled", "fadump_enabled");
-	if (rc) {
-		pr_err("unable to create fadump_enabled symlink (%d)", rc);
-		return;
-	}
-
-	rc = compat_only_sysfs_link_entry_to_kobj(kernel_kobj, fadump_kobj,
-						  "registered",
-						  "fadump_registered");
-	if (rc) {
-		pr_err("unable to create fadump_registered symlink (%d)", rc);
-		sysfs_remove_link(kernel_kobj, "fadump_enabled");
-		return;
 	}
-
-	if (fw_dump.dump_active) {
-		rc = compat_only_sysfs_link_entry_to_kobj(kernel_kobj,
-							  fadump_kobj,
-							  "release_mem",
-							  "fadump_release_mem");
-		if (rc)
-			pr_err("unable to create fadump_release_mem symlink (%d)",
-			       rc);
-	}
-	return;
 }
 
 static int __init fadump_setup_elfcorehdr_buf(void)
-- 
2.51.1


