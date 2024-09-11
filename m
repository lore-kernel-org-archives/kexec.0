Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EF3EE4997
	for <kexec@archiver.kernel.org>; Wed, 11 Sep 2024 11:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=j0uDzgsFMXA4LMEkNOwNQ3cQ3IinvuAQban8Qo3Lhls=; b=t89KD9QRiRZGDQ
	A7quH9ChWsEdb+AV8aZfo8IRPIV+yrlX+CdrYbdGkwH5IgnW+brByAimG+zjnzUlrKpHHmE1IgWen
	0slE42w33o21OeCDEVsJTUR/owPd8zeWSth7fQ7i0lYqY3yTQuWPpBOiFpuqGyf2zlxgO4Kjav8dp
	WkssFCM70RbeJycOR21VGN/uhttGByV/qrC/CTHPhrQxg8fCf0kiItKm9k4gRcGrFHYOQoDv6Xm5+
	KnVXWIDTlFtoi5kyiOuxrtLlP4M5GpXgzuyVVUB5sjHZN0rNw9ISb+i6wHZrenh4gwiXxIo+PltAJ
	kqLOE0jTt08H0pvYG0+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soLMy-00000009Gar-3KIy;
	Wed, 11 Sep 2024 11:18:44 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soLK6-00000009Fxs-1dg1
	for kexec@lists.infradead.org;
	Wed, 11 Sep 2024 11:15:48 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B7JqCW028394;
	Wed, 11 Sep 2024 11:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=Wp2GsN0eV/Isimo+fx+sy80p+eNfCNRoPfy1GC0
	Wgj8=; b=g+9mKXIFOQ0UCLDq6HB3/Bzz7mILPqulbYX/HTPPt0Up6XiXH6yL4js
	HlOLkq9ISsn6gF19d09SaLtO5v8BA0q28HZM44D2UKWaFwtuh61pdgcosS3srBpG
	6aWiBjkp5UYEnxhiW563ufP+3npsV+rBSCm3OwJaOjvM+SOb7Zsp5TDJqbxTpZvO
	1IxvFjIGV2i97mFd8JRAM3pHQCphIAiz9B6BSNSdPJ66h+oBEJArOJWdX77tKtCr
	cD2Ap/96khxg7zr66o3dw4H5yugnCjiCWg4I9PtzykpXUn8lvMv2rXJZKg40xDgS
	Hh8bagItolcIS1/3FLzRbfUygsNJEpQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefyn1n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:15:37 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48BBFbqG025638;
	Wed, 11 Sep 2024 11:15:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefyn1mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:15:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48BAaIGw032103;
	Wed, 11 Sep 2024 11:15:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nms01c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:15:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48BBFYVB51511696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 11:15:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58EC02004E;
	Wed, 11 Sep 2024 11:15:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 418C320040;
	Wed, 11 Sep 2024 11:15:31 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.116.75])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Sep 2024 11:15:30 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: bhe@redhat.com
Cc: Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: [PATCH v2] kexec/crash: no crash update when kexec in progress
Date: Wed, 11 Sep 2024 16:45:28 +0530
Message-ID: <20240911111528.104303-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LXb6hJqXbhDVpIsaY4eYybKBdraT82cB
X-Proofpoint-ORIG-GUID: jLbe-4MlMbIJfO3TCUFPXY5Xfgyq3fnl
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_041546_793698_DD8343A5 
X-CRM114-Status: GOOD (  18.67  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The following errors are observed when kexec is done with SMT=off on
powerpc.

[  358.458385] Removing IBM Power 842 compression device
[  374.795734] kexec_core: Starting new kernel
[  374.795748] kexec: Waking offline cpu 1.
[  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
[  374.935833] kexec: Waking offline cpu 2.
[  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
snip..
[  375.515823] kexec: Waking offline cpu 6.
[  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
[  375.695836] kexec: Waking offline cpu 7.

To avoid kexec kernel boot failure on PowerPC, all the present CPUs that
are offline are brought online during kexec. For more information, refer
to commit e8e5c2155b00 ("powerpc/kexec: Fix orphaned offline CPUs across
kexec"). Bringing the CPUs online triggers the crash hotplug handler,
crash_handle_hotplug_event(), to update the kdump image. Since the
system is on the kexec kernel boot path and the kexec lock is held, the
crash_handle_hotplug_event() function fails to acquire the same lock to
update the kdump image, resulting in the error messages mentioned above.

To fix this, return from crash_handle_hotplug_event() without printing
the error message if kexec is in progress.

The same applies to the crash_check_hotplug_support() function. Return
0 if kexec is in progress because kernel is not in a position to update
the kdump image.

Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
Cc: linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
Reported-by: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---

Changelog:

Since v1:
 - Keep the kexec_in_progress check within kexec_trylock() - Baoquan He
 - Include the reason why PowerPC brings offline CPUs online
   during the kexec kernel boot path - Baoquan He
 - Rebased on top of #next-20240910 to avoid conflict with the patch below
   https://lore.kernel.org/all/20240812041651.703156-1-sourabhjain@linux.ibm.com/T/#u

---
 kernel/crash_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index c1048893f4b6..078fe5bc5a74 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -505,7 +505,8 @@ int crash_check_hotplug_support(void)
 	crash_hotplug_lock();
 	/* Obtain lock while reading crash information */
 	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
+		if (!kexec_in_progress)
+			pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
 		crash_hotplug_unlock();
 		return 0;
 	}
@@ -547,7 +548,8 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 	crash_hotplug_lock();
 	/* Obtain lock while changing crash information */
 	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
+		if (!kexec_in_progress)
+			pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
 		crash_hotplug_unlock();
 		return;
 	}
-- 
2.46.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
