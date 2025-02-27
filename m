Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00612C282C5
	for <kexec@archiver.kernel.org>; Thu, 27 Feb 2025 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b+BxbcZny328vBDeBNuKHl0X5uSvYbJu041HX++8d1c=; b=xfTdTWdfa8zhMItqaRjxUwY6Nv
	6827b7Mhl1j/pV7dxS8P5qJFdqRgBQsgL/RBlUErKx8lxO70TaEWQsO+eufLAsWIGKZDpG5Nvip4C
	RXTTlH9S9WrFEEIFeZNaaXucZdbcgUfAynKd0XPzjQmy1J9tL6zjrZ8+WNwufAeNErhR90hXpmB41
	uFapECemmspXRyz1pUh7KHJQ1TXUGRel9Q+aGEj7CHczFsUpAfan3vteOk2UW2lsTUdcWG9x7Nu1j
	aPQ0NM1mjHAp7TILsSDZXh7aBOr2d6K3OufOu22xn1Hrj896svNLukZhOr7qxNujgNHMRjkAMwAcz
	tY2YmQIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnji3-00000008VVm-1zIj;
	Thu, 27 Feb 2025 19:38:15 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tng1T-00000007wQ8-1dU0
	for kexec@lists.infradead.org;
	Thu, 27 Feb 2025 15:42:04 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R7X61p018108;
	Thu, 27 Feb 2025 15:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b+Bxbc
	Zny328vBDeBNuKHl0X5uSvYbJu041HX++8d1c=; b=BW+CAklgFMbwmvwJ90u4Cz
	mGP1D83BRyX61YNQHEY8kV+H6JQ4YacQTXeG1c78yGqs8Q3t8c4FQxCgveayhtBh
	9ZJZ8RZEEiva0HfPWBq4mzbjMOf48a9btMSLgtbkPEoi5y/krwOYVAXlGseySA9z
	pwc4FBoJyKXqcYFAxvQn6gEL7ZK2r2znBEHlNi2NXE9oiyfOo8Bylf1Ow39QxrQ3
	NgzCQFh5Dg3TsF7aUbQbKt00lieJXTHChOzoOyRJhifPbGl9mDMq98ZcIo2oIsmc
	S8RoG4cXl+NA0GQqti70Z7ySNzmWTR7a7hqMsbTuPBVUyLLXLGiE6ccvzHXL/IaA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452krpab3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:41:42 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51RFZC10020841;
	Thu, 27 Feb 2025 15:41:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452krpab3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:41:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51RFOYFd012131;
	Thu, 27 Feb 2025 15:41:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9ysjqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:41:41 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51RFfeVx8782300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 15:41:40 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC38858045;
	Thu, 27 Feb 2025 15:41:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E248458054;
	Thu, 27 Feb 2025 15:41:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.182.161])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Feb 2025 15:41:38 +0000 (GMT)
Message-ID: <55acf768b52b47dd9d33fa0486772d8c7ae38779.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>, steven chen <chenste@linux.microsoft.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
        vgoyal@redhat.com, dyoung@redhat.com,
        Mike Rapoport <mike.rapoport@gmail.com>
Date: Thu, 27 Feb 2025 10:41:38 -0500
In-Reply-To: <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-3-chenste@linux.microsoft.com>
	 <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ch4kdlH88UqRX1-HCo1ZOA_UlxSUa3fp
X-Proofpoint-GUID: 91rmgt_eP3x3zo_lmBXUAyyK5DSmDO87
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270117
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_074203_557559_4E0E2BEE 
X-CRM114-Status: GOOD (  21.40  )
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

[Cc'ing Mike Rapoport]

On Mon, 2025-02-24 at 14:14 +0800, Baoquan He wrote:
> Hi Steve, Mimi,
>=20
> On 02/18/25 at 02:54pm, steven chen wrote:
> > Currently, the mechanism to map and unmap segments to the kimage
> > structure is not available to the subsystems outside of kexec.  This
> > functionality is needed when IMA is allocating the memory segments
> > during kexec 'load' operation.  Implement functions to map and unmap
> > segments to kimage.
>=20
> I am done with the whole patchset understanding. My concern is if this
> TPM PCRs content can be carried over through newly introduced KHO. I can
> see that these patchset doesn't introduce too much new code changes,
> while if many conponents need do this, kexec reboot will be patched all
> over its body and become ugly and hard to maintain.
>=20
> Please check Mike Rapoport's v4 patchset to see if IMA can register
> itself to KHO and do somthing during 2nd kernel init to restore those
> TPM PCRs content to make sure all measurement logs are read correctly.
> [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)

Hi Baoquan,

I was hoping to look at Mike's patch set before responding, but perhaps it =
is
better to respond earlier rather than later with my initial thoughts.

The IMA measurement list isn't stored in contiguous memory, but has to be
marshalled before being carried across kexec, and then unmarshalled to rest=
ore
it after the kexec.  Roberto Sassu has been thinking about changing how the=
 IMA
measurement list is stored so marshalling/unmarshalling wouldn't be necessa=
ry.=20
Making both this change and using KHO going forward would be a good idea.

However, that sort of change wouldn't be appropriate to backport.  So the
question comes down to whether being unable to attest the measurement list,
because the measurements are copied too early at kexec load, but the TPM is
being extended through kexec exec, is considered a bug.  If that is the cas=
e,
then I suggest finish cleaning up and upstreaming this patch set so that it
could be backported.

thanks,

Mimi

