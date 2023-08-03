Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D636C001DE
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 01:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J3WPZrUF2xFB/6TxIUrUFI425MY+cjSpp41hwpUr/F4=; b=ZCb7D35y006aaz
	QWt+Yqq85Pfprrh8HfOVXbcKy9R+1e9Pq1FpREbebWIuukIsyKo/zDg6AetAbQT5YyTwXKGjh14Pi
	akFOfkfz7/tT1NmvBtqx3ezPDom9AI+2Dn7Vcugheyv7cjF7iwj3D7VIbRYIQucsbux1jywY/kHSq
	SlbVaJuzHt12ibg6V6OllV2Se8RXPRp5QDoK2HZKuMW26BvTuJ60iDo44uNSM+YPaQzddLK38g6Fz
	jV61DxpcxPJMRk/urqTvgkqwVqD6rqGKj00TIKsy0MRegWD3nSF5ua1/DY7arVDX8ZdDzQ5REB7Ht
	x7aretuSe392V+nNcjTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRN7p-006Mea-2x;
	Thu, 03 Aug 2023 01:27:37 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRN7m-006MdQ-0E
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 01:27:35 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3731PGu3007458;
	Thu, 3 Aug 2023 01:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GmyzOxBMyR6kxXjZnhUZb9kBaKDndW0hpW8M78XlOdQ=;
 b=iu0MZy3U9oX6ytXefe7DqGn8fYx5Lx77R8zPZbHYctDQ9GWZY8Futyh9CRbqL2+Nh1Wr
 wYhwpKQl5zzzw8remVwK4NPpDt8wk3exaZ2fP1HVRw3AmKJ5Uf2gGlEq/d6XYCWqimDy
 TlaDdMJNHsBnE4zN1YPWrYErq01w0qVMLJ2yOOXDQR5l7ZrV7WZEXQYQNZjyAfB3vQkr
 GOuUUN24QB7L3dF9HJZjcpAEt54ddqCItfxiNqV+U6ZegCgq7Wj8u5GtqFVYIoTWLVgM
 u1oQVj3/1sZ0lFIE+YLH6veL+iQRel6MmkQbIC230cHA/c8Ks7eC8amNAOfV8FzAzFDz Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s82jbr0jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Aug 2023 01:27:11 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3731RBAN011226;
	Thu, 3 Aug 2023 01:27:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s82jbr0je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Aug 2023 01:27:11 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3730teH8017005;
	Thu, 3 Aug 2023 01:22:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5dfyhkxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Aug 2023 01:22:09 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3731M8Dv15532748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Aug 2023 01:22:09 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B43865805D;
	Thu,  3 Aug 2023 01:22:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27E8058043;
	Thu,  3 Aug 2023 01:22:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.115.23])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Aug 2023 01:22:07 +0000 (GMT)
Message-ID: <8c4257fb07a8c9fd26b70ce716665a9535e6af54.camel@linux.ibm.com>
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Tushar Sugandhi
 <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 02 Aug 2023 21:22:06 -0400
In-Reply-To: <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
	 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
	 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
	 <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
	 <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cTPHhMShhoCIqCuBndgM-0ABiYGW3Yiu
X-Proofpoint-ORIG-GUID: kQek6MPD53-4gkIeExz5Ds8ocwd9lOQ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_21,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 mlxlogscore=791 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030008
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_182734_376477_BD63693C 
X-CRM114-Status: GOOD (  14.90  )
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

On Wed, 2023-08-02 at 06:58 +0300, Jarkko Sakkinen wrote:
> 
> From long description I see zero motivation to ack this change, except
> some heresay about IMA requiring it. Why does IMA need update_cnt and
> why this is not documented to the long description?

The motivation is to detect whether the IMA measurement list has been
truncated, for whatever reason.  A new IMA record should be defined
containing the "pcrCounter" value.  (I have not had a chance to review
this patch set.)

This new record would be a pre-req for both Tushar's "ima: measure
events between kexec load and execute" patch set and Sush's proposal to
trim the measurement list.  (I haven't looked at it yet either.)

-- 
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
