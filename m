Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787B1C19F32
	for <kexec@archiver.kernel.org>; Wed,  5 Mar 2025 12:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OEHbrEwynpPoc/PQYISTWGJJizTmVH8mOpEoVx0LCqA=; b=ad3tZ4gVXQ4SW5zNWRVEokvftL
	XQofMJH/F/i+JGPUYgxI2H8WUbFeEAeLBw8T3tSTU2AbIscneKMoe/jkxvF3BrrrmUl9boniwvexW
	rAqrrKZGFzuYmPZslQ9XKD7I2JxajfjIPnuHzCZc2nxw9CCV1LPAUIUJXStoXkOmgfjgl7NmR3VOU
	Ap7rAf8iPJV9k/1aJpvWRi3lT+ywLS7N32cbyfdeXdki4N00AaprLJ4DUgKMYDqgoFU6kZdWZO7NJ
	XD/EWOJRazfDSwqsWAiqzqsdVaCvRl0R2gNQ+qFa8x0qvIlqfCyKD2MNVHVb+et/mQNHeZkAmd5FR
	BeMJ4lFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpnlM-000000080WZ-23jY;
	Wed, 05 Mar 2025 12:22:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpn6Q-00000007tJd-0Vh2
	for kexec@lists.infradead.org;
	Wed, 05 Mar 2025 11:39:55 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525BUeBD018854;
	Wed, 5 Mar 2025 11:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OEHbrE
	wynpPoc/PQYISTWGJJizTmVH8mOpEoVx0LCqA=; b=K8FdW9LQ442qJW1CW823GB
	PSOP9e7mXMs9QQG9u0vY7suMNgvUeZP0ae+2oWLzSHj4Y6r7RgBruhl3B6piqY6u
	hLtzIPs4I2sy7SSmjmvp9sMG32CShVibq/04dHGhh8eXxsR2BK3onyzPlzqbRcxS
	l2in6zKu22i2JQE5KNelkaaozpWkt+aD3dM5leROSrwiANHUgV1xqyWckcA2LR3U
	we/+8K+OeuphwOcU6j9ylXj6lnr7C7Hd5v2DoD81TE+IgzCC5g0XL2CthQap0vEH
	yvycPjUdAB2t9yPvv56Hp/vzTNOz2pol2OLX5E+G81GAsbtUE8zWukWENT75EQHw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4562xpn6b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 11:34:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 525AmSWv008929;
	Wed, 5 Mar 2025 11:34:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxyjnxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 11:34:34 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525BYYiO24511044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 11:34:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DC9B5803F;
	Wed,  5 Mar 2025 11:34:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 263B758063;
	Wed,  5 Mar 2025 11:34:33 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.124.31])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 11:34:33 +0000 (GMT)
Message-ID: <d9c6cd2a5e27df0fbc5ccb5f2945c33b2dbe34ae.camel@linux.ibm.com>
Subject: Re: [PATCH v9 1/7] ima: copy only complete measurement records
 across kexec
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
Date: Wed, 05 Mar 2025 06:34:32 -0500
In-Reply-To: <3aadae5d35af3f984b9e8bc548d73bb878d666bd.camel@linux.ibm.com>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
	 <20250304190351.96975-2-chenste@linux.microsoft.com>
	 <3aadae5d35af3f984b9e8bc548d73bb878d666bd.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bZRj979JBHaiqKCOApV6k42MuXH5lncF
X-Proofpoint-GUID: bZRj979JBHaiqKCOApV6k42MuXH5lncF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_04,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_033954_167933_678F5B49 
X-CRM114-Status: GOOD (  19.80  )
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

On Tue, 2025-03-04 at 21:08 -0500, Mimi Zohar wrote:
> On Tue, 2025-03-04 at 11:03 -0800, steven chen wrote:
> >=20
> >  - Compared the memory size allocated with memory size of the entire=
=20
> >    measurement record. Copy only complete measurement records if there=
=20
> >    is enough memory. If there is not enough memory, it will not copy
> >    any IMA measurement records, and this situation will result in a=20
> >    failure of remote attestation.
>=20
> In discussions with Tushar, I was very clear that as many measurement rec=
ords as
> possible should be carried over to the kexec'ed kernel.  The main change =
between
> v8 and v9 was to make sure the last record copied was a complete record.

Steven, let me clarify=C2=A0my comment on v8.  The patch description said,

"Separate allocating the buffer and copying the measurement records into
separate functions in order to allocate the buffer at kexec 'load' and copy=
 the
measurements at kexec 'execute'."

The intention is fine, but it also did other things:
- only copied a full last measurement
- if there wasn't enough room, it didn't copy any measurement records.

Copying a full last measurement should be a separate, new patch to simplify
review.  I'm asking you to separate that change from the rest of the patch,=
 so
that it can be back ported independently of the rest of the patch set.

When splitting the function "that allocates the buffer and copies the
measurement records into separate functions", please make sure it still cop=
ies
as many measurement records as possible.

thanks,

Mimi

