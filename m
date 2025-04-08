Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F59C369A7
	for <kexec@archiver.kernel.org>; Tue,  8 Apr 2025 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TAs+0tcGs9Gp50zejQZIViX1uDlyODSQhUTm/49LdbA=; b=mI6s0CYJKebm9zq//YjbjqzkJy
	/R624GS088ftvpXzEVmxXz238BrCmTEBJniFJl93CZEsgAfdtbrO3w5reT7YVBJ+xDMlVZrhKJqMw
	pcZREN+NrXoGHHqZOxK7ouLq1J4Ujv0Z3/UsKyYW/v+B8uk/dKumwyf4OuP7tHqGJa4rb2bGXCQme
	OQkcdgjgPNhKpPyaHW6kecVOme7Wg5g0UjiZmoa/q8J4xM688MzTmEaIxRxnzkXTE7VC3s8rOROEd
	kM/DqfefpcVWkmIfb4IT/gu9B8dfU10PmL3AO+DPLrZUv8aBF49KLZukXB/LzcRpaMbItN4BO4tx8
	wnuufI7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u29vl-00000004Nfo-4AbT;
	Tue, 08 Apr 2025 14:28:01 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u29uf-00000004NMv-0TdE
	for kexec@lists.infradead.org;
	Tue, 08 Apr 2025 14:26:54 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538AkvLe025333;
	Tue, 8 Apr 2025 14:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TAs+0t
	cGs9Gp50zejQZIViX1uDlyODSQhUTm/49LdbA=; b=It7Ln4Vk+6s7KX1Xivhjr+
	TzpfzRODFAH7A8MHjlTSh7v3E5Z08LKo6/JvRlBgOOVkN27fzWLZioj3BxRghx4L
	f6T/g6ADQxGpq0CbFti75J/WMGZEjkhusMoiRHSz/9968OBGVvQ6zDM0E7HBdGcZ
	FZQrL79MwXCgeTEAaEEap59f1/4fHwUeZmIBW86NERAl2zc2FMMArYSEgQofUD/t
	mdGNd56iS/FFzA9lmr+HI5P9Fope45QtXXu0o19R3hdwvcw7dcH15NZjpuZXZrAh
	aU4XxU7hCnfW7B3zWe29CfqhgJVUeVTgs4+SzRuGVmDK5LsJn1z+utk20X3acifw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vnvq423e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 14:21:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538BdA7B011518;
	Tue, 8 Apr 2025 14:21:32 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7yk5db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 14:21:32 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 538ELVBJ24052298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 14:21:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE29B58053;
	Tue,  8 Apr 2025 14:21:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD9D15805D;
	Tue,  8 Apr 2025 14:21:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.48.163])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 14:21:29 +0000 (GMT)
Message-ID: <90fff5f793fb48659e20fa69cb5895867f51e021.camel@linux.ibm.com>
Subject: Re: [PATCH v11 5/9] ima: kexec: define functions to copy IMA log at
 soft boot
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
Date: Tue, 08 Apr 2025 10:21:29 -0400
In-Reply-To: <20250402124725.5601-6-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
	 <20250402124725.5601-6-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LFIZAZOa8Py6A9mi7oxapgfZlsbgYwW4
X-Proofpoint-ORIG-GUID: LFIZAZOa8Py6A9mi7oxapgfZlsbgYwW4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_072653_272241_AC5A57AC 
X-CRM114-Status: GOOD (  16.55  )
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
> The IMA log is currently copied to the new kernel during kexec 'load'=20
> using ima_dump_measurement_list(). However, the log copied at kexec=20
> 'load' may result in loss of IMA measurements that only occurred after
> kexec "load'.

Ok

> Therefore, the log needs to be copied during kexec=20
> 'execute'.=C2=A0

The above line is unnecessary.

> Setup the needed infrastructure to move the IMA log copy from
> kexec 'load' to 'execute'.
>=20
> Define a new IMA hook ima_update_kexec_buffer() as a stub function.
> It will be used to call ima_dump_measurement_list() during kexec 'execute=
'.
>=20
> Implement ima_kexec_post_load() function to be invoked after the new=20
> Kernel image has been loaded for kexec. ima_kexec_post_load() maps the=
=20
> IMA buffer to a segment in the newly loaded Kernel.  It also registers=
=20
> the reboot notifier_block to trigger ima_update_kexec_buffer() at=20
> kexec 'execute'.
>=20
> Set the priority of register_reboot_notifier to INT_MIN to ensure that th=
e
> IMA log copy operation will happen at the end of the operation chain, whi=
ch
> is crucial for maintaining the integrity of the logs

Instead of ", which is crucial for maintaining the integrity of the logs"
say something like=C2=A0", so that all the IMA measurement records extended=
 into the
TPM are copied."

>=20
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>=20
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Steven.  With the change to use INT_MIN, the "kexec_execute" record=
 is
now added to the IMA measurement list, extended into the PCR, and included =
in
the IMA measurement list records copied.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


