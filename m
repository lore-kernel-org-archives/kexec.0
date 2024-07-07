Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446FFC30653
	for <kexec@archiver.kernel.org>; Sun,  7 Jul 2024 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:Cc:References:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JcI4OsEgKZDT/3CLN4uIE/YXAjaPuGbvGrj+C0uoNdc=; b=5BfFsZ/UPphFQ6jgdk6lDTsQGZ
	hW+W4Oeb3zvOx6y6pCXqYeN8Alu1C2wPsj+3pCsbwj8XqTWwRXFKlxJUHwSGn3SR8bvTxsRfT9TDm
	LOfxxLVAkysHfTJv9GhO+dhl2mw2+64d/b7cn1CFPgLOBvqWVl+po47f4TMgseKsdm/3BJOmxrqZL
	IgctelC9EDA3vRVkia3C6MBLO1pL9aHq+w5Z7j33lZQHULqmAFciWqCPOyrwvw7iI01cwHz4xxL4a
	x3sMvdDKWJTn4QUzbpIo8RF0lOZ7Qd9scUIIeSb9Z4GSOI3GOc1+Wa+WYz4E/G2++uELOqNYFRbUK
	j1zsDZvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQTqQ-00000001wTI-3DsR;
	Sun, 07 Jul 2024 15:30:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQTqO-00000001wSt-29K3
	for kexec@lists.infradead.org;
	Sun, 07 Jul 2024 15:30:29 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467CwLfG014536;
	Sun, 7 Jul 2024 15:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:references:cc:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	mSCmjh7rrw9gKFBolHo5DSa3XYxKMM9nCxUgy3MuWsE=; b=fW0JONyKUxsG9y5g
	0eG4nunCdr83ssNZgNld5+m0txiG0lVL2UtyrQAYnl8+fJgF0uGv+zfcFuiyEHjI
	sM+PNqtK8MnfRU983+y6u+wOYoT9Ucx8NasOp78nvZSkPdjlPnlpJi7Fzx0f34zH
	dCCNjUkKr+OZaW8ibLoPJhIYYsWK6HeX++0KRA1rvSp8N9NEtDueQ6UZwms7ttNM
	OMGYPgMQYP+LUSOFSgZfTXo2SimXroAblyLnky+mivY6gnWrhfGSdQ13lHVIp0j+
	cQdl5UoPHqPgjB2jyfblhaMejtK4QTe38A9vosrECgyaT/nIxogbORNo9BXpuF30
	muPwLw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ug6g741-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 15:30:25 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 467FUPsC000430;
	Sun, 7 Jul 2024 15:30:25 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ug6g73y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 15:30:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 467EOfkv024680;
	Sun, 7 Jul 2024 15:30:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 407g8ttw40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 15:30:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 467FUL6t55050610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jul 2024 15:30:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E681D2005A;
	Sun,  7 Jul 2024 15:30:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 620352004B;
	Sun,  7 Jul 2024 15:30:19 +0000 (GMT)
Received: from [9.43.10.232] (unknown [9.43.10.232])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jul 2024 15:30:19 +0000 (GMT)
Message-ID: <f0f36b28-c229-40ca-a10c-cbf0ebade4a3@linux.ibm.com>
Date: Sun, 7 Jul 2024 21:00:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] kexec-tools v2.0.29 preparation
To: Simon Horman <horms@kernel.org>, kexec@lists.infradead.org
References: <20240704121517.GA1088210@kernel.org>
Content-Language: en-US
Cc: Baoquan He <bhe@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20240704121517.GA1088210@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J3Fg_PqE9qj-NYDFst6MLywZcq_3iiQ0
X-Proofpoint-GUID: GhUB0q58eQgvX4xbMcxGFXLU_EcfqDca
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 mlxlogscore=814 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407070126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240707_083028_594280_5750C08E 
X-CRM114-Status: GOOD (  13.64  )
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

Hello Simon,

On 04/07/24 17:45, Simon Horman wrote:
> Hi all,
>
> I am planning to release kexec-tools v2.0.29 in the next two weeks
> to roughly coincide with the release of the v6.10 kernel.
>
> I would like to ask interested parties to send any patches they would like
> included in v2.0.29 within one week so they can be considered for inclusion
> in an rc release.

It would be helpful if we could consider the below patch series for the 
v2.0.29 release.
https://lore.kernel.org/all/20240707152456.87899-1-sourabhjain@linux.ibm.com/


Thanks,
Sourabh Jain

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
