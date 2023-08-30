Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2A4C6FA8F
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3LLFBFXG+3p01/GkDM/N0Ki+K5UJuam/YeDUzlkApqY=; b=cA6/+wQnJHB961
	q2p70T4BNxmcljN8H2m+Jfo5D2qF8xFy83GdODDKFjlBwyZ1Xi9x0OadE63c9Mp1xDK5cuyTXSIw8
	oM6xugzXdQyssAXodEZw4EpZHPahdmVENykxeLq6YT8jWJ6mgV5jY2BO6agwQ+WsP34o3cFL1bA4g
	JX6xjw9wMpe6j62AmgV+EL6ud4kflAcyZMyqJcUrmdI0tL/jwmfdPV7DomduJsxe3Fv7MeCKdYlyL
	0UFlr5YtsWB6EXUWBcDWzWJ2wHzWSyY0veU4DmGop3oSbWpKFM643XPB/30t+UGXhdGEmvxuad/Jh
	D9u0472jhXvcFHuKtyWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbPb5-00Dwtv-25;
	Wed, 30 Aug 2023 18:07:19 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbPb2-00Dwsz-2d
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 18:07:18 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UI6G4a011229;
	Wed, 30 Aug 2023 18:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7mpGdRMaj7IRJgIUoNl0dbzZit8I0dcef/sQKvRTk/o=;
 b=Fxl9aFdXzRnVhSc2y+F+lzImmy6I3uqpxxgKM6DqTCurcp5CFti/ma8JSPcm+h+wMoFN
 IDCo/wq4OOk+4HekniOHVsBct3giY4pP3wlMYko9zQQ/Hy34swKt6wQuF3aSAM/jvxzB
 IxjIgDZJT+B4j/nsmK37AfmjGx8Ikup4fEWYs8gsX7nYRxG59GScWnpxAAkVoLFPsoun
 DC10LiwBEGL/LIxNL2Dzbht47G0SWZQy8aDeYxq+LkOX0K0uG5poWa6l8RqBHtDF3KNn
 TbjWe6GXdybCT7N0Ayuc88ZyxSEp5zma4QjIH1bl5HGvWP6TeQWn34nFDsTBtDr6K/4L 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st8c0bwu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 18:06:59 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37UI6LUS012482;
	Wed, 30 Aug 2023 18:06:41 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st8c0bvtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 18:06:41 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37UGk9fB014103;
	Wed, 30 Aug 2023 18:06:25 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxk5f5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 18:06:25 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37UI6O3T7930598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Aug 2023 18:06:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2861458059;
	Wed, 30 Aug 2023 18:06:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0CE158043;
	Wed, 30 Aug 2023 18:06:22 +0000 (GMT)
Received: from [9.67.11.225] (unknown [9.67.11.225])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Aug 2023 18:06:22 +0000 (GMT)
Message-ID: <5c323243-e22e-dd61-f808-2875654936a6@linux.ibm.com>
Date: Wed, 30 Aug 2023 14:06:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - network bandwidth
Content-Language: en-US
To: Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
From: Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qj2m_T3VrIBLu6wVx5WTxCf5LfnCMZa8
X-Proofpoint-ORIG-GUID: lCf2BCuSL9uOz6AJzPPyqrg48nogS2ey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=787 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300165
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_110716_884794_D8C8DE8F 
X-CRM114-Status: UNSURE (   9.55  )
X-CRM114-Notice: Please train this message.
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



On 8/1/2023 3:12 PM, Sush Shringarputale wrote:
> In addition, a large IMA log can add pressure on the network bandwidth when
> the attestation client sends it to remote-attestation-service.

I would not worry too much about network bandwidth.

1. Every solution eventually realizes that sending the entire log each 
time hurts performance.  The verifier will ask the attestor, "give me 
everything since record n", and the number of new entries approaches zero.

2. My benchmarks show that

On the client, the TPM quote time swamps everything else.
On the server, verifying the IMA entry signatures swamps everything else.

The network transfer time is negligible.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
