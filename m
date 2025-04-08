Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13A1C369A2
	for <kexec@archiver.kernel.org>; Tue,  8 Apr 2025 16:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dtlnr9Ue7/PhcXuGg8004GnTJ63vMzWWit129eebbLs=; b=U0Iyni+gUJLvKadhv9Q4v4wLxW
	xOFyY6w0JC1xXaPenLQ9+l6EKFj7sObLOZDGASh/h6F136XGNdVC5SMPCRTFT7hKg+7I7TgALE9zX
	zEeU9s9njHJ387d/T+j7z8yk7o2+L/hy3px/+csxWpfJCizgpaeHhSC6uxXZacenF4H6nVY6wM8Nj
	JX00koDQfA8IS7bkhBIOOYWUKtH8MqfeJDtk7IgopWlslsfC37oJFhukIHxLIeiL/s3NbQVZ4SSJo
	l2Qn1yfAMIHRsbW0+FKa90ghyeVYwsgKF7XIAYJb71+v10odHJ9QAFVe7OqPBoPOIp5vENHxDPYS0
	wmxiLPBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2BfC-00000004n16-3lWQ;
	Tue, 08 Apr 2025 16:19:02 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2BeM-00000004moy-2s0r
	for kexec@lists.infradead.org;
	Tue, 08 Apr 2025 16:18:14 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538AkvYG025333;
	Tue, 8 Apr 2025 16:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dtlnr9
	Ue7/PhcXuGg8004GnTJ63vMzWWit129eebbLs=; b=ZGdE2tHKJX6i7HZyl2oVMv
	yYmTWfYLERhPrewMSYG6+dLnpbYazNeu7o3z11UQWO4/Y4LQxgyr2ctt/y2gXBT3
	6u/vvrujfhgajnMM3xgRuG4phipYu9wqLOnQ0nxm83qOF7E6Np4eTnB98cpgLeu2
	9NOCEEz490mCpQNLt1Vx7WUrfKPWIurvrRBQFGrWu7NlEiJsvJ9JRtpdvBr73mEW
	YoaAwiBBlVFz4Q3nVlPfXLlQkij3kEZR9DoLy1/QUldf9ZAIhoUyK0kZ2Xovh0ik
	I9d5sPk2GKw1NPTp0192GVKk8pmRPsEWNlGmdJ1qSuVBxZIki8zLRaOrT0V4BztA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vnvq4n60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 16:17:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538CTfxe025522;
	Tue, 8 Apr 2025 16:17:52 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbkuct8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 16:17:52 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 538GHpqY20185622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 16:17:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BE0358056;
	Tue,  8 Apr 2025 16:17:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5410B58064;
	Tue,  8 Apr 2025 16:17:50 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.48.163])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 16:17:50 +0000 (GMT)
Message-ID: <96ae5a8efbcb894e096881f1dd7a4939ce0a9490.camel@linux.ibm.com>
Subject: Re: [PATCH v11 6/9] ima: kexec: move IMA log copy from kexec load
 to execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Tue, 08 Apr 2025 12:17:50 -0400
In-Reply-To: <20250402124725.5601-7-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
	 <20250402124725.5601-7-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x-J3lUyWTUnQz2md1UOTUAOdtcu0hPTr
X-Proofpoint-ORIG-GUID: x-J3lUyWTUnQz2md1UOTUAOdtcu0hPTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_091810_852931_3E918708 
X-CRM114-Status: GOOD (  20.09  )
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

On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
> ima_dump_measurement_list() is called during kexec 'load', which may
> result in loss of IMA measurements during kexec soft reboot. Due to=20
> missed measurements that only occurred after kexec 'load', this function=
=20
> needs to be called during kexec 'execute'.

Re-use the motivation from 5/9 (with tweak):

The IMA log is currently copied to the new kernel during kexec 'load' using
ima_dump_measurement_list(). However, the=C2=A0IMA measurement list copied =
at kexec
'load' may result in loss of IMA measurements records that only occurred af=
ter
the kexec 'load'.

And finish the paragraph with:
Move the IMA measurement list log copy from kexec 'load' to 'execute'.

>=20
> Make the kexec_segment_size variable a local static variable within the=
=20
> file, so it can be accessed during both kexec 'load' and 'execute'.

> =20
> Implement the kexec_post_load() function to be invoked after the new kern=
el
> image has been loaded for kexec. Instead of calling machine_kexec_post_lo=
ad()
> directly from the kexec_file_load() syscall, call kexec_post_load(), whic=
h in
> turn calls machine_kexec_post_load() to maintain the original image proce=
ssing.

Define kexec_post_load() as a wrapper for calling ima_kexec_post_load() and
machine_kexec_post_load().  Replace the existing direct call to
machine_kexec_post_load() with kexec_post_load().

> =20
> Invoke ima_kexec_post_load() within the kexec_post_load() API only for ke=
xec=20
> soft reboot scenarios, excluding KEXEC_FILE_ON_CRASH.

"Don't call ima_kexec_post_load() on KEXEC_FILE_ON_CRASH" would be listed i=
n the
Changelog if it changed, not here in the patch description.  Please remove.

> =20
> Register a reboot notifier for the ima_update_kexec_buffer() API within=
=20
> ima_kexec_post_load() to ensure it is called upon receiving a reboot=20
> notification.

Registering the reboot notifier was done in "[PATCH v11 5/9] ima: kexec: de=
fine
functions to copy IMA log at soft boot", not here.  Please remove.

> =20
> Move the ima_dump_measurement_list() call from ima_add_kexec_buffer() to=
=20
> ima_update_kexec_buffer() to copy the IMA log at the kexec 'execute' stag=
e.

This information was already stated in the first paragraph as part of the
motivation for the patch.  Please remove.

> =20
> When there is insufficient memory to copy all the measurement logs, copy =
as
> much of the measurement list as possible.

Is this comment still applicable to this patch?

Please review your patch descriptions before posting, making sure that
everything is still applicable.

thanks,

Mimi

>=20
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>=20
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


