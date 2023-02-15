Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5150CC61DA4
	for <kexec@archiver.kernel.org>; Wed, 15 Feb 2023 02:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4zWbgkgwcT10jAOMtGiugtKfLUfB3vNacGlTxHW9ouY=; b=qVdg9d2ETPbRkb
	mkJkUTkf6QhuMspdE5mSeWEqxF+15TJinEMuAaj4qig5vEG5L5hY55y6/jsp/K6HX673ents3Bap9
	nXGjAIiyZ1J7YKgVPmASkkkH89X7RC/oJRXQhG6s6O623I5n0VdhQwAL3deqeKHY+P3+ey9jsD4KA
	m4y07jCwVXKudaY0CKrUeAo9s4rNfLxxqV4Ky/8UjdCLKeAr4dmgDsEP20TYX7Exdnn0p/+967StH
	Phen9c6ul3XXyzLGRP2XsmgsNaQSkQrWFqTwPTG9qybcBeDTKAEfLEVIUkicKkyDHOL7T5GmSK7oR
	rDOVwUpCCVun51/OcXxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS7vN-004SqW-9Y; Wed, 15 Feb 2023 02:53:37 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS7vK-004Spa-0z
	for kexec@lists.infradead.org; Wed, 15 Feb 2023 02:53:35 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F1gCOT013853;
	Wed, 15 Feb 2023 02:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Exgxn0AYVPDxRYZks80xT9MtkCEQSRrBSvU9sNrFG28=;
 b=rEiTbULsEJYQrx14lrnXV7hD9U6egDiMPFWaEa4d2d1WmWaX5Qb8vmWuh2gx+rxy0xOH
 Zy1xaarMSn1lr5yI5hPfZI+dcHwf1XLmaKGgLhtEGckTCMSRZHD/TRnp9d2ABwqAXTqr
 OtEWvamYggW4mwHYewjovnASdIFekrmOCmZebE6WvzEgYmVfNqdKO+xZWCnbwEfTMV0F
 mJNA7lFH8v+iX+xkmQfxGUxfwTBVhmGRFeEScfHtlkIPxB6MZvzvAlCxM0ZwZGPGg81P
 UtlNsaa0tTP0pSxZAGTDnKwDgYJ/LDzEOuLttydWUq6JN/21BPqywjeNa3svklPM6f6z Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrny0hgt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Feb 2023 02:53:17 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31F2hLmj027776;
	Wed, 15 Feb 2023 02:53:16 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrny0hgs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Feb 2023 02:53:16 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31E7UAFA007931;
	Wed, 15 Feb 2023 02:53:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3np2n6bhpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Feb 2023 02:53:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31F2rBjp24052426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Feb 2023 02:53:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E784720049;
	Wed, 15 Feb 2023 02:53:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF00320043;
	Wed, 15 Feb 2023 02:53:06 +0000 (GMT)
Received: from [9.43.21.73] (unknown [9.43.21.73])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Feb 2023 02:53:06 +0000 (GMT)
Message-ID: <4b22740d-6cd4-2485-7a26-c73c8bb6be27@linux.ibm.com>
Date: Wed, 15 Feb 2023 08:23:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
To: Eric DeVolder <eric.devolder@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org,
        efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
 <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com> <87ttzpzpzx.ffs@tglx>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <87ttzpzpzx.ffs@tglx>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CLg_oi2szPZcFT6u2gma6lTr1KgQeZlV
X-Proofpoint-GUID: VUkDzequ_XNonaN8X033IYNY-j6xIXOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_17,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_185334_080917_80413E45 
X-CRM114-Status: GOOD (  15.48  )
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


On 13/02/23 18:22, Thomas Gleixner wrote:
> On Mon, Feb 13 2023 at 10:10, Sourabh Jain wrote:
>> The sysconf document says _SC_NPROCESSORS_CONF is processors configured,
>> isn't that equivalent to possible CPUs?
> glibc tries to evaluate that in the following order:
>
>    1) /sys/devices/system/cpu/cpu*
>
>       That's present CPUs not possible CPUs
>
>    2) /proc/stat
>
>       That's online CPUs
>
>    3) sched_getaffinity()
>
>       That's online CPUs at best. In the worst case it's an affinity mask
>       which is set on a process group

Thanks for the clarification Thomas.

- Sourabh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
