Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D0CC636CC
	for <kexec@archiver.kernel.org>; Wed,  8 Feb 2023 06:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=95KpgZEf7GeI6nJX8UrrTQ+uLIVyojJEtmpQtpRM3JA=; b=D6fgX2TN2vt6/W
	hqIDMShde9ilWn2PHs5aVBXprIN/sFnR4n0lCnqQMCRKUuyJBaWiOucM8ijwvVTBCgkKYpEix2pjn
	f3wIWMZtysB2RolclPWCWIPNVznsh7mYZTBKDVa7MJsJ5+mU0MI3xRV8m9WqZPTFyzF9y089D4Ded
	zZxEA55AYZfISCRTOgcYezI/NA9mowvV5kIQXwemMlqE83fTtqVPHyqeBiUWq6cYRINyhu+gqJlea
	VhCNzGrut2WFC4ZeQjtcLrPtQjnDz5fUSo5CoJJnpFQ/kjBKBCS1B0BOcaQIs21M9QBsSgOuH+/OC
	2sC/jj7+tAfYVutjMRdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPe1x-00EJS9-UC; Wed, 08 Feb 2023 06:34:09 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPe1r-00EJE3-AJ
	for kexec@lists.infradead.org; Wed, 08 Feb 2023 06:34:08 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3186CGv1014784;
	Wed, 8 Feb 2023 06:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6WTnmzOQn8b7vOuctp9jBKS8+nyvfqOnEMVWaeldgUo=;
 b=Tki3W33W+aINsYap8NAi0z7US2SKiSlQw1QjyP5T6md0BWWIPTjHQ6Cm/X/SdphGkj4a
 nnv2t+x+FjlnumuGhjvP5PQUl1hTg194gkx3vCiTqQvjenL6s/J4NtcnfgW9Sz+21UlX
 KmVTyhUunYJtNrWq4WppbxKaeW3J3NbfneEO6gTRqn7iXi7dTQoLkL31wUNPIPBdW7US
 ZhgIthtl1EBoAa7L6gR1iuiOZAvt7melnaqivj7xLwwX8F9ZIxwBOXkxgA9+v4WOEFXp
 2YZvlwgMGqlcNlJjdRBB7u7tMnvMR5CGAEVEPSAlZ/bLroRyvgQL9sYBBN6Mp+5365bK tQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nm68mrdtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Feb 2023 06:31:57 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3181r8Sx027510;
	Wed, 8 Feb 2023 06:31:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3nhf06u609-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Feb 2023 06:31:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3186Vp5451708374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Feb 2023 06:31:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 560422004F;
	Wed,  8 Feb 2023 06:31:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B57020040;
	Wed,  8 Feb 2023 06:31:50 +0000 (GMT)
Received: from [9.43.122.167] (unknown [9.43.122.167])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Feb 2023 06:31:50 +0000 (GMT)
Message-ID: <4166eda1-96d9-bda7-4956-031e90d43eda@linux.ibm.com>
Date: Wed, 8 Feb 2023 12:01:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ppc64: add --reuse-cmdline parameter support
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, hbathini@linux.ibm.com
References: <20230201085331.1004355-1-sourabhjain@linux.ibm.com>
 <Y+JpRdQ81Mt57EPK@vergenet.net>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Y+JpRdQ81Mt57EPK@vergenet.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QgLZJWIveanc9iEUKUYhOl-CdIp4FaBT
X-Proofpoint-ORIG-GUID: QgLZJWIveanc9iEUKUYhOl-CdIp4FaBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_02,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxlogscore=900
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_223403_407774_2A14A050 
X-CRM114-Status: GOOD (  15.08  )
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


On 07/02/23 20:37, Simon Horman wrote:
> On Wed, Feb 01, 2023 at 02:23:31PM +0530, Sourabh Jain wrote:
>> An option to copy the command line arguments from running kernel
>> to kexec'd kernel. This option works for both kexec and kdump.
>>
>> In case --append=<args> or --command-line=<args> is provided along
>> with --reuse-cmdline parameter then args listed against append and
>> command-line parameter will be combined with command line argument
>> from running kernel.
>>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks for accepting the patch.

- Sourabh Jain


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
