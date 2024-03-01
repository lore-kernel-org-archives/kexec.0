Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4479CC5478C
	for <kexec@archiver.kernel.org>; Fri,  1 Mar 2024 05:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=646x66tTMdqzaG0fgGOVDYZWLqodwv4vPDoAn9AwrfM=; b=VqYKebzTSVSg1w
	tmR6PmHB6i42wQhVRxf+ntnXgMKKP8q7TDvfW99aw2rX5Pl6ybhOEk7HeOLuj7pDwcfl3MU6OhwNS
	m/x2+OHwDDlGR/HG7LGMGRIzXYMT2mVj9E9fNGzrcetlFcsNa/5B3oHyrUsHD6U3gJD8Qn6tYWKfz
	cVPKhQS37rulvuicXwUHVmGqg23ymuOptZJsaz+MrfbFD6HznABa0KIYuovk7VNKI3GLwylPGlYxC
	YRc6MfCp4WA7+bNH4PZ3jSbA2tBQgL1NW4VPeWfscBCr/H/B+KkxQCzfuMbSlgqQvlcyhcmbnIVLA
	SH6/PkTj5JJkn7LhtiHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfvDq-0000000GOHn-3oC6;
	Fri, 01 Mar 2024 05:14:14 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfvDm-0000000GOGX-2nb8
	for kexec@lists.infradead.org;
	Fri, 01 Mar 2024 05:14:12 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4215954T005398;
	Fri, 1 Mar 2024 05:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JX6eSvoNUnWfKDMb2h6OWhmreqplk4n9Il8ykxlGp3M=;
 b=AdVATzUmOoNEQ9mLog5p4g38qUeI6Eien0L47fgzj4QriuNnnEFEZQTxucgB7eQwQLgr
 iQHJTms8w1DY+ZBDnj+5yBW3A99a4svPVgqmbV2S/vx/FCoJXSRNIsSTGUG6T4n1FOR6
 W8vggbZLrkso82jkrBnU7AqobqoDU4W1MovSfVDj6QL/ORFKmmZcJjr4AhJ2Gj+tDPPS
 EU7LymATw++X7X+uWuyFlT637Sl+ArpzxGRTWTrEhiZx/15hXKh6evG1tPcJN3CJCfrY
 xjX0Cxq67SfzOrvdUbeUDvZy0krt2y5QwaiynqdXzg6BIJDIg6Td9YJ0h98R6s2hnSQQ fw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk8m6g34p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 05:13:35 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42159Pux006313;
	Fri, 1 Mar 2024 05:13:35 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk8m6g34f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 05:13:34 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4211hHXl021316;
	Fri, 1 Mar 2024 05:13:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfuspja0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 05:13:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4215DSUx24117966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 05:13:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32E972004D;
	Fri,  1 Mar 2024 05:13:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AF8B20040;
	Fri,  1 Mar 2024 05:13:20 +0000 (GMT)
Received: from [9.43.93.212] (unknown [9.43.93.212])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 05:13:19 +0000 (GMT)
Message-ID: <9dd60fea-5b6c-409d-bc55-8e27545b47d4@linux.ibm.com>
Date: Fri, 1 Mar 2024 10:43:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 0/6] powerpc/crash: Kernel handling of CPU and memory
 hotplug
To: Baoquan He <bhe@redhat.com>
Cc: linuxppc-dev@ozlabs.org, Akhil Raj <lf32.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky
 <boris.ostrovsky@oracle.com>,
        Christophe Leroy
 <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org
References: <20240226084118.16310-1-sourabhjain@linux.ibm.com>
 <ZeCL1EsQ/vLojCYs@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZeCL1EsQ/vLojCYs@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9u_Dv4MsjhfHbNzgxaoNunXKjOOrmFVH
X-Proofpoint-ORIG-GUID: -CQuMvGu3TPMfEpKcApoepztV5yUUGMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=930
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010041
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_211410_856294_A2CFF4BF 
X-CRM114-Status: GOOD (  20.37  )
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

Hello Baoquan,

On 29/02/24 19:21, Baoquan He wrote:
> Hi Sourabh,
>
> On 02/26/24 at 02:11pm, Sourabh Jain wrote:
>> Commit 247262756121 ("crash: add generic infrastructure for crash
>> hotplug support") added a generic infrastructure that allows
>> architectures to selectively update the kdump image component during CPU
>> or memory add/remove events within the kernel itself.
>>
>> This patch series adds crash hotplug handler for PowerPC and enable
>> support to update the kdump image on CPU/Memory add/remove events.
>>
>> Among the 5 patches in this series, the first two patches make changes
>> to the generic crash hotplug handler to assist PowerPC in adding support
>> for this feature. The last three patches add support for this feature.
> The whole series looks good to me. I have acked patch 1 and 2. Leave
> those three ppc patches to ppc expert to review and approve. Thanks a
> lot for your great work.
Thanks for your feedback. I will soon send v18 to fix the two mirror 
document issues
and will look forward to PPC maintainers to provide feedback on the rest 
of the series.

Appreciate your support!

- Sourabh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
