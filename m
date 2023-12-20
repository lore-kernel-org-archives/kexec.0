Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F09C3DA6E
	for <kexec@archiver.kernel.org>; Wed, 20 Dec 2023 22:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O5MRhfJTy4jMWWEQna6BxejsHrKICj2leQUNrXTKbmY=; b=VF2bPvQfnLdD4x
	uxCxCeYCftEYh267AkZCu45oAnkVBJ28lQ8T1jewbLRPCutKWyZjhyaF/1pknweIshXNbT52k7R7L
	DktO1Zrcu06OOg6wh3QPPT11UbfsV1SVhgllhxuoRlmznfZdqN7VMfS+IU0g4JBoX43dYaeqC/88Z
	IW7CuiFOD8uFDqMXOSOhm/p2l1EH71U4hzfEdYboKJ3tsf0jVMkISnmh8PngrfyvPit2iclg58tP9
	HhmR8vDB7G4sQksuGGcCpF73yKRjDI8iB8LAuIMwson/4O/XjjaEYA/+QqseF3tIW5G37GH7Hm0o3
	WsvkhwuMLPetvhPr6BNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rG4pR-0012aH-09;
	Wed, 20 Dec 2023 22:14:13 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rG4pO-0012YM-0r
	for kexec@lists.infradead.org;
	Wed, 20 Dec 2023 22:14:12 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKLRUcY004658;
	Wed, 20 Dec 2023 22:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Lme9PvKXLllsH+Mh5EhYOYKBv8+v9jzfCVw+p6oPtF8=;
 b=UX0vSB4SqHpjxVnbfc6C1k+QMHyj/FPDdaZHVuhBjySSqCl+CV0R8qcm+e/WU+l6Syg4
 OBz4uR9gQkhjjnJI4ST4DaCVbNHbMvHX5epourH7DnBE81J8xOyXI6yXRfmic1cKsEyY
 csO3ENneNcjmroDhuzj/MVFlu9WnE+JeczAlCYPshnQ/iGJaqJYn/qFq8a9/JtDliflT
 xXf731CgorhxcCmJYxHcQs84zdS7311yPGeFZOZL9i32i08FhauoVG+mBqi7tqy4drjM
 ZvW4NHyDuGuR5V5vkQPFieqLWv0kz0Ib6BR3YDBAfQebq7BCHz++Iw2D928I7o+ZAonv ew== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v42q73crh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 22:13:52 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BKLbqu1021251;
	Wed, 20 Dec 2023 22:13:51 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v42q73cr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 22:13:51 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKLNtYv012418;
	Wed, 20 Dec 2023 22:13:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1rx20stm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 22:13:50 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BKMDoNK22610544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 22:13:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3474058055;
	Wed, 20 Dec 2023 22:13:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96D585804B;
	Wed, 20 Dec 2023 22:13:48 +0000 (GMT)
Received: from [9.67.17.94] (unknown [9.67.17.94])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Dec 2023 22:13:48 +0000 (GMT)
Message-ID: <1c370ecf-272a-4052-8f06-4fcfd9bf08b5@linux.ibm.com>
Date: Wed, 20 Dec 2023 17:13:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, bhe@redhat.com,
        vgoyal@redhat.com, Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, serge@hallyn.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-security-module@vger.kernel.org,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
 <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
Content-Language: en-US
From: Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jdm9hFg47T3cry3by7vWsYkIffxDdom2
X-Proofpoint-ORIG-GUID: JoqsYci3m-cIbuNnF9sp5yvfTxOvXDiv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_13,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=909 bulkscore=0
 malwarescore=0 clxscore=1011 adultscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200158
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_141410_654980_629C7AEA 
X-CRM114-Status: GOOD (  15.32  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

I'm still struggling with the "new root of trust" concept.

Something - a user space agent, a third party, etc. - has to
retain the entire log from event 0, because a new verifier
needs all measurements.

Therefore, the snapshot aggregate seems redundant.  It has to
be verified to match the snapshotted events.

A redundancy is an attack surface.  A badly written verifier
might not do that verification, and this permits snapshotted
events to be forged. No aggregate means the verifier can't
make a mistake.

On 11/22/2023 9:22 AM, Paul Moore wrote:
> I believe the intent is to only pause the measurements while the
> snapshot_aggregate is generated, not for the duration of the entire
> snapshot process.  The purpose of the snapshot_aggregate is to
> establish a new root of trust, similar to the boot_aggregate, to help
> improve attestation performance.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
