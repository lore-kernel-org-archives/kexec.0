Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E24C369BD
	for <kexec@archiver.kernel.org>; Thu, 17 Apr 2025 01:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ah/lLzBmfOIHy5wOwIFiZy+sp117fbDDGICRD88/xh8=; b=Ksshs5nQ5Sb2VSLebWsWD0X09U
	4CG7AmMKNImZHCwa4TQ8TbNyJQVkG+udQzox0F2CaMJ1AurwXN5ipta9AnnnNxIq28aUTUuHZPCtR
	bI+XuzSLs2ODOxc4tXebf5uruTVkQBvnPTA4G/4IXVqkalwZi2rXaxb597kL7o5yQx807/z+WAT29
	PDfmZRwqDGVqK3ajCH3UPYnxCtGz1jexyMlHCT9ytc1you5QALWm1PD08n8nkZiImeaX/mS76JeX2
	nboyrMONenyfJ6Bodtk5P6ngU6IQWzVtttkg4Tdvh2mLT/1OSdUo5R98yfx6y/qsBtjULr1/hEmHI
	2nhh1caQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Dys-0000000BQd0-3yBJ;
	Thu, 17 Apr 2025 01:23:54 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5DlI-0000000BOno-3JGh
	for kexec@lists.infradead.org;
	Thu, 17 Apr 2025 01:09:57 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GLW826019008;
	Thu, 17 Apr 2025 01:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ah/lLz
	BmfOIHy5wOwIFiZy+sp117fbDDGICRD88/xh8=; b=n86RXRgper66X0nQGr/SIC
	rYc7HochvI/iHrEML50CySpLEsaptWcfK7HSgDf7O8qS6C/zNnQPxwfo4pgb6+eX
	AkQxleDMoK8rlIxBFadOqGo2jcEr4rie3dbIIax0MMF++ZMn6pd0zad6QNsvFpZx
	/0fSVrfPEJLBVnApDjCByVBoqWCvNyqec4O5LUGn4DvyKYCUyG7xKmK24f0qfszi
	hQAonjj02jIGh2uAOBqZQy5tHmE96XC2phK+ohnOB0X9wmvLcUwp4SoheHCcLnKg
	2b1tARm921vHxIxNAf0JizkFpHIPUNgWVtNyCYPGmfBx29Pn784UoflR7LhTwiSQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mhu0r9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 01:09:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GNSmTf010392;
	Thu, 17 Apr 2025 01:09:27 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qkaym2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 01:09:27 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53H19QBm24380138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 01:09:27 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96C895805F;
	Thu, 17 Apr 2025 01:09:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DADCF5805A;
	Thu, 17 Apr 2025 01:09:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Apr 2025 01:09:24 +0000 (GMT)
Message-ID: <4a2f7fde-99ee-4bcd-a97d-fe0db418fd5f@linux.ibm.com>
Date: Wed, 16 Apr 2025 21:09:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/9] ima: kexec: measure events between kexec load and
 execute
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250416021028.1403-1-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Hvd2G1TS c=1 sm=1 tr=0 ts=680054c8 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=yMhMjlubAAAA:8 a=VnNF1IyMAAAA:8 a=KXIcZCm0EDoHl9fo71cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: j6fdTeznLc-rslj-Y7d3L1utxejtCVup
X-Proofpoint-GUID: j6fdTeznLc-rslj-Y7d3L1utxejtCVup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_09,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170006
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_180952_847367_C89B341C 
X-CRM114-Status: GOOD (  13.23  )
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



On 4/15/25 10:10 PM, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
> The current kernel behavior is IMA measurements snapshot is taken at
> kexec 'load' and not at kexec 'execute'.  IMA log is then carried
> over to the new kernel after kexec 'execute'.
> 
> Currently, the kernel behavior during kexec load is to fetch the IMA
> measurements log from TPM PCRs and store it in a buffer. When a kexec
> reboot is triggered, this stored log buffer is carried over to the second
> kernel. However, the time gap between kexec load and kexec reboot can be
> very long. During this time window, new events extended into TPM PCRs miss
> the chance to be carried over to the second kernel. This results in
> mismatch between TPM PCR quotes and the actual IMA measurements list after
> kexec soft reboot, which in turn results in remote attestation failure.

Tested-by: Stefan Berger <stefanb@linux.ibm.com> # ppc64/kvm


