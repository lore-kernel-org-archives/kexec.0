Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF71C02192
	for <kexec@archiver.kernel.org>; Mon,  3 Feb 2025 22:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p+u2z/Ts/LT6PtTkaWiVagg/BvIfy13aOSTGOYoxTG8=; b=cP+2WZ+OvwbuXAFJ+D/uTV/LST
	5i4YMXjBiuC1LroehUzsJzN9eUWmTIF3ElGxqJzubRPr87y22Vs0H9p+jUaI1iohUrr6eGhkYKt/4
	eBBcJlufQVzSMcoB+bS3dHar6+sYjabExlTtcQIgkIQGbWHf/ENH2yJ4DcFlGT4Gd+39vFbypRr5T
	b7tjZvjyeHm6WkdeF6yiKGzS/ViiamWtWCvAkDe1+7244fa9vAXw7yTQ5sZuJ9JimXDS0zkOSvLJ+
	ywYX6F01VwEvyZDxgXwkapkgO5vOuL/Ezwf8IwcjeuEG68sxIUnP8x9LpV6/tIYPR9xSr2mHMvnHx
	iwA5VlHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tf5CE-0000000GowX-3U9Q;
	Mon, 03 Feb 2025 22:45:38 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tf5CC-0000000Gow5-1INq
	for kexec@lists.infradead.org;
	Mon, 03 Feb 2025 22:45:37 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513FeQrV015310;
	Mon, 3 Feb 2025 22:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p+u2z/
	Ts/LT6PtTkaWiVagg/BvIfy13aOSTGOYoxTG8=; b=AXMVv0+9eJrTOik+ywky3J
	AaFadllkrIodUt1qZGIoUtNxeKJTraQa1WVrNBzlyorO1ST2LVQUvvo7NcrTPKI3
	hWWIlXYtSfQQcplJhfoyXzaCswG6lTDGa/czwMLKxXjTV/j8Qs42VngfR00kmBz9
	end2ws/5iDwEovfEGsOpqyvHt2nrinH9ufAGHkN9Oz8o7dxC4LeQdwhBbXrUt95g
	jllr1DTeDX4OAH2FH6Xp+PLLQYzbp+G5z7OHXLVoB0rrGlIc5+M7ZLNAnml7VRxE
	nZ3GvO3rbJKaG4eFfnWC816j6MTM15N9v94oj3NBHCvzE6oEyL/h/ezi6TxxKiyQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jqm7ct6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 22:44:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513KQPpG005258;
	Mon, 3 Feb 2025 22:44:13 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05jrd5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 22:44:13 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 513MiDDP13173268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 22:44:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44E7858055;
	Mon,  3 Feb 2025 22:44:13 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61F7558043;
	Mon,  3 Feb 2025 22:44:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 22:44:12 +0000 (GMT)
Message-ID: <64f329c9-2912-4e7d-9475-b16fa0ac1d04@linux.ibm.com>
Date: Mon, 3 Feb 2025 17:44:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] ima: kexec: measure events between kexec load and
 excute
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
References: <20250203184558.61367-1-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250203184558.61367-1-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ViUeqqliz0kJJ_jnOdhPWASG3FyCpIc8
X-Proofpoint-ORIG-GUID: ViUeqqliz0kJJ_jnOdhPWASG3FyCpIc8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=814 bulkscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030164
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_144536_363597_DA709394 
X-CRM114-Status: UNSURE (   7.71  )
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



On 2/3/25 1:45 PM, steven chen wrote:

It looks like 5/7 is missing.
Does it apply to 6.13?



