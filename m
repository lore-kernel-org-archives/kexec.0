Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0150C02194
	for <kexec@archiver.kernel.org>; Tue,  4 Feb 2025 23:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2FhDkutlFDrUXKpErmzzncgU1ZoP8wGLXswD+EnhQbo=; b=sH7QgWRfwxKF9yQKvWsSRNANRW
	YX73cgbkx9/EjyZI5rRSk9S0Hya9/8XLiGL7sTVw3jWV+XYE8vJw5K3aPtdxK2QwNjtCuVzkgvQ6K
	q1QOrYhjh8UL86CriQ3xGQpTyaMMV6eG0q54fGkhKjsd80C80NzGeP2YuN5dEh0MjDnBrEJL5WkyB
	gCNdCkUajcqtkN66LEALTZpQQZePTEiIqiEYpYAk2wcfN5bk+WdgzOHuub+uuVdHUqPcpKnyahEqU
	C5K+UqsnO7FnMwQADHK3QBSAqboG5M7OlubfQoM6UAO2GAUAKX3IrHS2FvNT1NZyAG2NyVYVVXcgE
	zFZ0InyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfSBd-00000001ocO-1xpZ;
	Tue, 04 Feb 2025 23:18:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfRnF-00000001kkr-1xyh
	for kexec@lists.infradead.org;
	Tue, 04 Feb 2025 22:53:22 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEomA028728;
	Tue, 4 Feb 2025 22:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2FhDku
	tlFDrUXKpErmzzncgU1ZoP8wGLXswD+EnhQbo=; b=buDx+2EIwON7ki0cbzYcuJ
	OoacryrPaq0O9pjpC26J6FQwHw0sJ5aOQkcI6Slj5PHhp7HfDMpL0XHwnLU3zsUk
	kBxg7IqjmQQrIe0eGkn4DNSlvBmP7Pt94OCq1a7wGdANna6hBnJy7e+rygE3ygME
	XpVpqorVcyhGj6lYNU4Pz9OiN/skVuJFH7jy77plKb8FRHjDm2UdTVgljKR13OhQ
	qUxk/XkbSEjsILb+aWOJl7UXcAJvcjrhmQ2gPFGfaKAPvPNCnYod7hFXPIQw2TfS
	xIwNFKymBcMEfreQTE5/jpZPqQdF5R/L6ndcBpaYzVKnaUHGgHEr3OMBiBe1V/AA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44knqtsww9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 22:51:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514L0Zkr005261;
	Tue, 4 Feb 2025 22:51:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05jwkxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 22:51:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514MpvRM6357672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 22:51:57 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F104B58043;
	Tue,  4 Feb 2025 22:51:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1231658055;
	Tue,  4 Feb 2025 22:51:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 22:51:55 +0000 (GMT)
Message-ID: <fff34d89-6009-43d1-8033-5c62b812938b@linux.ibm.com>
Date: Tue, 4 Feb 2025 17:51:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/7] ima: kexec: skip IMA segment validation after
 kexec soft reboot
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-4-chenste@linux.microsoft.com>
 <00eeeb8b-cc28-42af-873f-3478cd22fb6e@linux.ibm.com>
 <aeef2ca5-2538-4487-a501-7eb2925d198b@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <aeef2ca5-2538-4487-a501-7eb2925d198b@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z4ncMD1yBBQd530Qu8FeBYpetBqy8kFO
X-Proofpoint-ORIG-GUID: Z4ncMD1yBBQd530Qu8FeBYpetBqy8kFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_09,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=857 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040167
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250204_145321_637564_DDDC6DB9 
X-CRM114-Status: UNSURE (   8.95  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 2/4/25 3:28 PM, steven chen wrote:
> On 2/4/2025 11:39 AM, Stefan Berger wrote:
>> On 2/3/25 6:20 PM, steven chen wrote:
>
> 
> Hi Stefan, I will update in next release. Thanks!

You should try to rebase it on 6.14-rc1. There were a few changes.


