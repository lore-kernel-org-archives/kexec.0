Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69001C61D97
	for <kexec@archiver.kernel.org>; Wed, 22 Nov 2023 01:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dW+92nO/MQtMAjOLMnTiwF1VH3TpThSTExQehRd184g=; b=dZ66NktP9ocLKN
	zUdUtVLtG4N7eJI6p3q/Bill08wYu5mbw0rpe24iBO4jighW7RkD8fKtYpx0LZ9YxMbeyqkPpvbMQ
	3PpsqACGhspcaEEooALvltgPiDM7oiOznbGw/+nQNIR93nKevEwquyMUhSSdOIZXqJy4uruVt4tHh
	vUj9q/drFBnsHt8+e5CGDmaWWqOce0xGgDD42+opdVkWy12c65jJLHrIqrWikpaDW3N0WyIzbE5ub
	ZKBZgH4yQuLK09ulqAYWd0JhOA65ofj8Q7sf5ih7+wF8f9ImyOGeqOl9yrl/IRwToYgjgboZpCIuK
	d7J9Amgt5I/4guIE01Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5bt3-000Odx-1b;
	Wed, 22 Nov 2023 01:18:41 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5bt0-000Od4-1Y
	for kexec@lists.infradead.org;
	Wed, 22 Nov 2023 01:18:40 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM0GARr010991;
	Wed, 22 Nov 2023 01:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=fnovNk6AHp/U+kSPAbJeVqRSf5N2j37dZWSMh8VhmEs=;
 b=AO22bOAmcpDFQBiARFxQ9s7TSfDOSrHL8qa5e1FIcyR6jytGUg8tfBausyPhSoA4g165
 Qp1WFKkCNJAhJNcpp44te9bfNaSm5JnNPmflfTiLEUijsgAP325wx5/hYk9Wxambm/4n
 0mLY1t5FdZ4qomLAeq6KbU5HMu+2A5KJYnJiFwYAmusya7PhQzhHXZtxD9KyseEPp+El
 5HA/5wzEWxbM+xHvf5PhYfhf3YKy3rZ+JcZ4jRhNo+83cyhIj+jUyqiHB6DhGC5dehxA
 6eC9yYUx/MxLUzAuPfES2ReK3D6pIKU+fcHsbgp4PjnawoJDWoD1/MNCMzHmF1trIjhh 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh6xy970d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 01:18:19 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AM1B7Ku003858;
	Wed, 22 Nov 2023 01:18:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh6xy9702-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 01:18:18 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM1DMYB022360;
	Wed, 22 Nov 2023 01:18:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yymt98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 01:18:17 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AM1IG7N33161728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 01:18:17 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8FFB58054;
	Wed, 22 Nov 2023 01:18:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA9AF5803F;
	Wed, 22 Nov 2023 01:18:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.87.103])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 01:18:14 +0000 (GMT)
Message-ID: <09adb80a9317062a7139527eb0cbd45bb7d78b4f.camel@linux.ibm.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Paul Moore
	 <paul@paul-moore.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        Jarkko Sakkinen
 <jarkko@kernel.org>, jgg@ziepe.ca,
        Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, serge@hallyn.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-security-module@vger.kernel.org,
        Tyler Hicks
 <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>,
        Sush Shringarputale
 <sushring@linux.microsoft.com>
Date: Tue, 21 Nov 2023 20:18:14 -0500
In-Reply-To: <e0cf16b3-514e-45bd-b6f8-7638ed57b00e@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
	 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
	 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
	 <e0cf16b3-514e-45bd-b6f8-7638ed57b00e@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cINbTcskzZy0QxIrZQAVWvcTkZpauqXr
X-Proofpoint-GUID: wIOEghWbEitrioMbjd5cWPJ6cHOPa2P_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_16,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220006
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_171838_880335_1F0EA4B6 
X-CRM114-Status: GOOD (  19.58  )
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

On Tue, 2023-11-21 at 17:01 -0800, Tushar Sugandhi wrote:
> Hi Mimi,
> To address your concern about pausing the measurements -
> We are not proposing to pause the measurements for the entire duration
> of UM <--> Kernel interaction while taking a snapshot.
> 
> We are simply proposing to pause the measurements when we get the TPM
> PCR quotes to add them to "snapshot_aggregate". (which should be a very
> small time window). IMA already has this mechanism when two separate
> modules try to add entry to IMA log - by using
> mutex_lock(&ima_extend_list_mutex); in ima_add_template_entry.
> 
> 
> We plan to use this existing locking functionality.
> Hope this addresses your concern about pausing extending the measurement
> list.

Each TPM PCR read is a separate TPM command.  Have you done any
performance anlaysis to see how long it actually takes to calculate the
"snapshot_aggregate" with a physical TPM?

The "snapshot_aggregate" is a new critical-data and should be
upstreamed independently of this patch set.

-- 
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
