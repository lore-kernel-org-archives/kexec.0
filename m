Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133A3C001B0
	for <kexec@archiver.kernel.org>; Mon, 14 Aug 2023 22:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=075sEQ2flGvIrt+vfXntJh0DyxdqR/TLTfCu+CF8vhs=; b=Kf9KK8RCUj32bU
	8zlQMBk4KUczBPsVbjqJHN8l3/2AJ5BbmG6WQX+6goyxkBuyVaIwzrCnxjr9neyy49xzHLv7smA1D
	2wPRPzfHLVoynCp0tBoGI5WYDyrcKXu19EtpH5UGMY9aM9ezL+En3x8PQzIUFVLF9S4UfRv7+1tLb
	y1E731UqH3nxfzzJxHA7kn7yIfzn1yUP57y7QVO9FPWYCqT603oq2bCRbHmPpes9mdgwUaeev/7XO
	40nC1zCqJ9QT96mU7twbMsCzWKj8sPTYUuQzpMr6RAcYFlnmjgnFlSeqlr9hqxmkkRXhwQl2KvsSt
	h1enldyAO66TJ09HYk1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVfeA-000Qeq-35;
	Mon, 14 Aug 2023 22:02:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVfe8-000QdW-0h
	for kexec@lists.infradead.org;
	Mon, 14 Aug 2023 22:02:45 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EM2SHx018871;
	Mon, 14 Aug 2023 22:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=FpIoN8YUDy/37QmvnUB3eIyTNRsXSQVZQhIRZ1O8vdM=;
 b=iE7qvxlPBDojCpIChCLGoN11AwoFOto1+T55iVSOR1IgdqVfDdtl5yXkC/uW+kiUy5ti
 bXGJqHhZ1AIvDSWo5lY55DvzooMwwgxdjvD1r5YPEuS75kX18n0/i9r/4nlYsh/RJV/m
 pJmw+5k5LK+I0BvCwbEfuQE+HkJXhlZbXblsnVa8YvMT2b4ik9tA+veCLIJzZtCcL7eY
 sWOCab1aCdJZbKqiTzMAHOGrBwZrsd0C5StybGwLd5+zcpD+LQTU7mX1DQ2/gcKGWvc5
 H6B4nHlFD8Exn0w8QMeo7TKg6gol4HHzhJMykbvHJUqxkcR3jBXgrXxeEGPRitXupsgM Og== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfvq4801f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 22:02:27 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37EM2Qt8018846;
	Mon, 14 Aug 2023 22:02:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfvq48016-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 22:02:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37EKULJt001107;
	Mon, 14 Aug 2023 22:02:26 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsy0af6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 22:02:26 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37EM2PMk66847068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Aug 2023 22:02:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A81F58059;
	Mon, 14 Aug 2023 22:02:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8535F5804B;
	Mon, 14 Aug 2023 22:02:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.145.19])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Aug 2023 22:02:23 +0000 (GMT)
Message-ID: <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From: Mimi Zohar <zohar@linux.ibm.com>
To: Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore
	 <paul@paul-moore.com>, serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi
	 <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
Date: Mon, 14 Aug 2023 18:02:23 -0400
In-Reply-To: <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
	 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
	 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6baQrZRHoxmXqAZcmAVpDSkAA5M3VbwR
X-Proofpoint-GUID: Sj7FcZiqreEfeid5Qv3WlRMcISm3L49a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=885 adultscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140199
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_150244_584622_9BB267F7 
X-CRM114-Status: GOOD (  22.13  )
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

On Mon, 2023-08-14 at 14:42 -0700, Sush Shringarputale wrote:
> > This design seems overly complex and requires synchronization between
> > the "snapshot" record and exporting the records from the measurement
> > list.  None of this would be necessary if the measurements were copied
> > from kernel memory to a backing file (e.g. tmpfs), as described in [1].
> >
> > What is the real problem - kernel memory pressure, memory pressure in
> > general, or disk space?  Is the intention to remove or offload the
> > exported measurements?

> The main concern is the memory pressure on both the kernel and the 
> attestation client
> when it sends the request.  The concern you bring up is valid and we are 
> working on
> creating a prototype.  There is no intention to remove the exported 
> measurements.

Glad to hear that you're not intending to remove the exported
measurements.

Defining and including a new record in the measurement list measurement
is fine, if it helps with attestation and doesn't require pausing the
measurements.

-- 
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
