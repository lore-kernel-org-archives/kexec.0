Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB000C77B7A
	for <kexec@archiver.kernel.org>; Tue,  6 Jun 2023 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w89L30aHPiAQ6VNOf6h4pIu8aPaGYJVdSOqka4flCks=; b=QKTLya3/WzM04b
	O6s/pTsmLctnUrGkegE79p0rUxTg5khGzWY9+7twc2excXA0G49r+dZf8LzCkieDoHvrIdMDCCm76
	VGPrP8z2N/nU3ZRk6jBuJAfRp06gP2qEeGU85tqMYzWT12pc8KK8Lajb1Z8Kkcbmk8Ny6Ff7wPFy8
	MITRSr19/T/hWjagjGgRpoFVm/L2bHrln5XC+ZZ+3W7DQr7mOL38DY8ZQB8SdawHik195Gv2bsEp/
	M08G4lZ0BducrIVQK+2xbvuFjBaphMyrrEAdCxgRPVyTysYZ3EKcdCaoUCjxY26AH9Ny+GcvNZCSC
	udi4SdrgKD5o74jKFmcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Z5s-002L2u-1W;
	Tue, 06 Jun 2023 15:59:36 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Z5p-002L1h-2F
	for kexec@lists.infradead.org;
	Tue, 06 Jun 2023 15:59:34 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356Fmo7K017398;
	Tue, 6 Jun 2023 15:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GiCQelCwO+L7OMG18zX9YrnMBan/4k8ixaaVOWtEPPQ=;
 b=CGYwiN8dDk3DeH35RWOPQlLMRWTmLHw4Z1SXZ6K2Yz79MZu5DAn8E43EBrRoctsi5RDw
 0J9LeUMzsdTLziiDZO0WSf71rcfPRR7bLAnd7v3eSSJ+Sd3AYNxs2ld9SZwjVOxMfyyX
 ES+c/mKalGRzOJEPMicGHJ5MEDSIg7YcPG1jOXjzGcHVhhKq8/wNt94UdkA464YP3ujQ
 OVM51XN6VUXoFQnhe11wxELNm47dMJMe3dwybGbxVZfnJQjhJfe7ImVTaNoV5+BWezRo
 OqZus5n6+qkQX/RyaTsMVM76/ePALxKcz8+yQQgiEZwhhp802fhjgLuTYb11kL3oApfM pg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r27s7rad3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jun 2023 15:59:13 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 356Fn87Q017999;
	Tue, 6 Jun 2023 15:59:11 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r27s7raca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jun 2023 15:59:11 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
	by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 356FU82s026046;
	Tue, 6 Jun 2023 15:59:09 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
	by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3qyxnvqyfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jun 2023 15:59:09 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 356Fx8S935389912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Jun 2023 15:59:08 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6625058062;
	Tue,  6 Jun 2023 15:59:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7458358056;
	Tue,  6 Jun 2023 15:59:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.156.200])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Jun 2023 15:59:07 +0000 (GMT)
Message-ID: <91dd069c090522be1e3369e83520d3813336b5bf.camel@linux.ibm.com>
Subject: Re: need help: patches to capture events between kexec load and
 execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>,
        Tushar Sugandhi
	 <tusharsu@linux.microsoft.com>,
        Jonathan McDowell <noodles@fb.com>, bauermann@kolabnow.com
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Alasdair G
 Kergon <agk@redhat.com>,
        Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>, code@tyhicks.com
Date: Tue, 06 Jun 2023 11:59:06 -0400
In-Reply-To: <3748147f-85f5-4aeb-0083-cbeef375e12a@linux.ibm.com>
References: <c33ba2f1-bacd-54dd-90d7-b0ab82568fff@linux.microsoft.com>
	 <Yp24dc/i8XU9A+5/@noodles-fedora.dhcp.thefacebook.com>
	 <87775c1e-d1d3-519c-599b-30cdb1691cb2@linux.microsoft.com>
	 <4eff26f794254c1f06ace12e68527fd3452ac47d.camel@linux.ibm.com>
	 <41270374-dc5e-3aa2-d2ed-9b8fc73ad65f@linux.microsoft.com>
	 <8308a411a50a1168aa5a1a0d70138b29cea73914.camel@linux.ibm.com>
	 <3748147f-85f5-4aeb-0083-cbeef375e12a@linux.ibm.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bVa1nFcJzW2KLyTPpZHbIho3zf1R6aFa
X-Proofpoint-ORIG-GUID: zcIjdqfDzsNzEkjcY6zT4FSenbx3oU69
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_11,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306060133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_085933_742281_2D4E9D92 
X-CRM114-Status: GOOD (  23.25  )
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

On Tue, 2023-06-06 at 11:37 -0400, Stefan Berger wrote:
> 
> On 5/31/23 18:43, Mimi Zohar wrote:
> > On Wed, 2023-05-31 at 15:02 -0700, Tushar Sugandhi wrote:
> >> Hi Mimi,
> >>
> >> On 5/31/23 04:39, Mimi Zohar wrote:
> >>> Hi Tushar,
> >>>
> >>> On Thu, 2023-05-25 at 10:21 -0700, Tushar Sugandhi wrote:
> >>>
> >>>> The issue of IMA measurements getting lost between kexec 'load' and 'execute' still exists.
> >>>> I verified it on the mainline kernel 6.4.rc3. See *Appendix A* for details.
> 
> I think there's a 2nd problem.  Once the IMA measurement list is frozen (at kexec 'exec' stage)
> IMA must stop extending PCRs. It can log (into the void) if it wanted to but the PCR extensions
> have to stop otherwise the TPM's PCR state won't match the log in the kexec'ed-to kernel. I have
> seen that on PPC64 some processes are being kicked off by kexec 'exec' that end up causing TPM
> driver error message due to what seems to be a shutdown of the driver subsystem at this point.
> I am not sure what an elegant method would be to stop PCR extensions. Maybe a flag on the level
> of IMA would do? Or notifying the TPM driver to reject PCR extensions or just any command?

Thank you for raising this concern.

Agreed "kexec exec" might trigger additional measurements.  As long as
these are known, consistent measurements, they could be pre-measured
before calling "kexec exec".

-- 
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
