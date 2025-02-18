Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B3DC021B0
	for <kexec@archiver.kernel.org>; Tue, 18 Feb 2025 21:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GyD0ds0X932uvbp5T3ctUK6UvHo61gC9ydF28Xc6wAk=; b=42wkhNBOUVRaThHj3lC3R//607
	3bTJjdelngaNtzSDcQ4YB32Yu2YAbLmgQ21VIU8cowAyFBfAWeVvYt9AZfnWD+HAGyoV5tt8wR+I9
	cAygMQ7ili9EstmzOfvrAUAAFuwCt+LvQBX01TN7EnqxAxWKFJ9u7dN+NUqvDtQybocdACN6JbgwG
	quiz9+IsQj2+ZuxeRWY57FDC0A0LtjoNzfDYk5hQ9XoPu6jjzPbH6zcprhC8yfrNxPe2uH8wQFdOi
	FZv7oS5dk+2JTxc79XCHYPPUGssF+RAWSedBSiX4h8o3Vt/koQAqC2dwE5sSWiWqmoxCD85d96sJ0
	DBPmhDkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkV6W-00000009yxq-2sJR;
	Tue, 18 Feb 2025 21:26:08 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkTRS-00000009c4M-1EWK
	for kexec@lists.infradead.org;
	Tue, 18 Feb 2025 19:39:39 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IIxiK5015844;
	Tue, 18 Feb 2025 19:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GyD0ds
	0X932uvbp5T3ctUK6UvHo61gC9ydF28Xc6wAk=; b=HidhPtacs92VbrCylNV2rq
	s9EfCQP97/UUfeGgmWl2X27yQ2vK5lv5MJYOqSlY7vPkKuD4r5LRU+ekaTQfh17M
	r0cjVYliZkRgiiU297pbv71QDVH4iqWauYAFpSDCk21Ptb37BEtJwJuhnDSTGxRo
	f0XSxMHq8910OZlC+BFkRJCbN+aEkt4H1Q+7PLgZ7Jq/S5oAUvmjLoJPKw7wMBBw
	AfxlFVWbX+wcZqXMKeKqg0YN1mOD+5zSFDZO65+OCdIEgtdR4q0ZP7cdvZOwpy6p
	4fkbj34dOPErZmbLQ1fb4/0bY/hVXAasb8s+ngdSgz+tt9J2BT3LUd8ph08AdDrQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vyypr4tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 19:39:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51IJ4VQq030176;
	Tue, 18 Feb 2025 19:39:15 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01x04en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 19:39:15 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51IJdFcf28050030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 19:39:15 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6455458055;
	Tue, 18 Feb 2025 19:39:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B66C25804B;
	Tue, 18 Feb 2025 19:39:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 19:39:13 +0000 (GMT)
Message-ID: <c99d2151d3c99f86c1e4e2bbf236ad53603e2ff2.camel@linux.ibm.com>
Subject: Re: [PATCH v7 0/7] ima: kexec: measure events between kexec load
 and execute
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
Date: Tue, 18 Feb 2025 14:39:13 -0500
In-Reply-To: <20250218172046.649307-1-chenste@linux.microsoft.com>
References: <20250218172046.649307-1-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uQtBQv0wcriZcYkDer-9HBAO1DciNcAU
X-Proofpoint-ORIG-GUID: uQtBQv0wcriZcYkDer-9HBAO1DciNcAU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_09,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502180135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_113938_449079_396153F2 
X-CRM114-Status: GOOD (  17.21  )
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

Hi Steven,

I'm ignoring this version of v7.  Please remember to update the version to =
v8 before re-
posting and update the change log.

thanks,

Mimi

On Tue, 2025-02-18 at 09:20 -0800, steven chen wrote:
> The current kernel behavior is IMA measurements snapshot is taken at
> kexec 'load' and not at kexec 'execute'.=C2=A0 IMA log is then carried
> over to the new kernel after kexec 'execute'.
>=20
> New events can be measured during/after the IMA log snapshot at kexec=20
> 'load' and before the system boots to the new kernel.=C2=A0 In this scena=
rio,
> the TPM PCRs are extended with these events, but they are not carried
> over to the new kernel after kexec soft reboot since the snapshot is
> already taken.=C2=A0 This results in mismatch between TPM PCR quotes and =
the
> actual IMA measurements list after kexec soft reboot, which in turn
> results in remote attestation failure.
>=20
> To solve this problem -=20
> =C2=A0- allocate the necessary buffer at kexec 'load' time,
> =C2=A0- populate the buffer with the IMA measurements at kexec 'execute' =
time,=20
> =C2=A0- and measure two new IMA events 'kexec_load' and 'kexec_execute' a=
s
> =C2=A0=C2=A0 critical data to help detect missing events after kexec soft=
 reboot.


[ ... ]


> Change Log v7:
> =C2=A0- Incorporated feedback from the community (Stefan Berger, Tyler Hi=
cks)=20
> =C2=A0=C2=A0 on v6 of this series[8].
> =C2=A0- Verified all the patches are bisect-safe by booting into each
> =C2=A0=C2=A0 patch and verifying multiple kexec 'load' operations work,
> =C2=A0=C2=A0 and also verifying kexec soft reboot works, and IMA log gets
> =C2=A0=C2=A0 carried over for each patch.

