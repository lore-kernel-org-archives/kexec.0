Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31001C54E60
	for <kexec@archiver.kernel.org>; Tue, 19 Mar 2024 08:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zV379YYtuGf8jY2yEfpc3Oyy7iUTyl08NVlsa2atS0o=; b=4FsYCquZy3etw/
	2FZIpTIV4RB9Fqxbl+h7cAVX4VFgHUZvIjWyY/YWH0Q9TAt5yhnRgehdA9I3CAjzggZyZQSIh/R+l
	3aEpHrzcD+ZV7lEeuwGrky9MH6NE7/dF5YjE2am/vXJ7GeVgG7IOFjL5mxL7BQFkaqoYx7iDpPn4L
	mJEjdkrjej7eFptu6FXWmWVaGXQ6qv1nakcdITOYgLMBSdQ3ick++B9JD5EAnnTGdVWcjQ173nyTr
	mZumpFzUWtRYzqSUdskoAZT4SQG2NnKpRkL8zH/671WfVUSQbOaptEkatQzrXnk2WHGvR9xStdyZK
	kckLRAtob1G/kF4EUIuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmUQX-0000000BmsA-0Tgk;
	Tue, 19 Mar 2024 08:02:29 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmUQT-0000000Bmqd-3pEx
	for kexec@lists.infradead.org;
	Tue, 19 Mar 2024 08:02:27 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42J7qTNv026006;
	Tue, 19 Mar 2024 08:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=783k+iJDssWOqY+gKqgdV1OwoRKiU82xaA7y4uXr9u4=;
 b=gD09FA9bgbzmbKJ4yi1V4vQ2mQSNWq+3s3Hv0vbK4ZEFMBnj4atfzJmeC/oUQumq/sL0
 ctDWJh0nOTZTwgDfXXz7SnapZ1D1Edh1c7s/h4Fw29xMI87Hc0iViaemWj0iK8j+k/Ec
 Tm9n8nGl0ir9/22uy8jmai/jAntruhB1xbt6j8EBDV7kcEl1Tc87WQkie464t8OUqv2i
 /vHThSCcsjQ2CyY9i04vjZ8MB9sJgeLzlZPU0oPw9HlVprtHvAMySMKPxNI5oK40E1fG
 v8zEeikvTSniy7XV1qZ5gcBNMqzcFhjYsk8m6M7LJHZAO/qDTtGXRUISodYym8JR8T7G EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy6ptg25a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:02:00 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42J820DK014841;
	Tue, 19 Mar 2024 08:02:00 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy6ptg254-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:02:00 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42J76ugf017242;
	Tue, 19 Mar 2024 08:01:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrt6aac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:01:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42J81tKq48890118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 08:01:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADB7920040;
	Tue, 19 Mar 2024 08:01:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93F4D2004D;
	Tue, 19 Mar 2024 08:01:53 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.195])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 08:01:53 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Kexec-ml <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>, Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf-next v2] bpf: fix warning for crash_kexec
Date: Tue, 19 Mar 2024 13:31:52 +0530
Message-ID: <20240319080152.36987-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kjOiKMSgrobbTjzxVPrM-Eu7i7N0u8Y8
X-Proofpoint-ORIG-GUID: 5SkujAUyH9kK3HpHxE751-_QtLH_41lk
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240319_010226_095529_436A2A6B 
X-CRM114-Status: GOOD (  16.87  )
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

With [1], crash dump specific code is moved out of CONFIG_KEXEC_CORE
and placed under CONFIG_CRASH_DUMP, where it is more appropriate.
And since CONFIG_KEXEC & !CONFIG_CRASH_DUMP build option is supported
with that, it led to the below warning:

  "WARN: resolve_btfids: unresolved symbol crash_kexec"

Fix it by using the appropriate #ifdef.

[1] https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/

Acked-by: Baoquan He <bhe@redhat.com>
Fixes: 29fd9ae62910 ("crash: split crash dumping code out from kexec_core.c")
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v2:
* Updated changelog.
* Added Fixes and Acked-by tags.


 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a89587859571..449b9a5d3fe3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2548,7 +2548,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
-#ifdef CONFIG_KEXEC_CORE
+#ifdef CONFIG_CRASH_DUMP
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
