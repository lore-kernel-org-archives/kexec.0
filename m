Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C915F4198C
	for <kexec@archiver.kernel.org>; Wed, 15 Apr 2026 10:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sj9YPfnukpvQV9eNeIa+6hgskrP0ZG/p9aZilsClzTU=; b=Aru4KaBRphv6BUdWOHApxQVenQ
	7oUk631fWsSmLlFjXJYGulnMlLjrWJYvWJdTGBZHLjCmzOWtGQYXXwtsRmIt6VkzVTuR3Lj6Q2Tvz
	fH0OQcaFWTkuMhz9NiGFP+8YS4oGA7C1zpMGGT/qk5iWHPMDW4ckD+rPtiNmR9ROjeFmLsZKri5fY
	VZVb1fBQXhRjVGTRz1ORa+c5y0CDeEXxPCvZddUrZHFIahZILD3PZwdJfMZc80ISdqoBgM+u3DRS1
	GFRUjo2ZUJrzO1KHQ5a5i43Wb9WlpaT5byodQCD+hFDip7EtG0iJLXunSBAgyYKo7cQZArsoKKUmQ
	Mbzs+orA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCxgO-00000000zAq-07pG;
	Wed, 15 Apr 2026 10:41:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCxgM-00000000zA6-0OSx
	for kexec@lists.infradead.org;
	Wed, 15 Apr 2026 10:41:19 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F5NYt11835027;
	Wed, 15 Apr 2026 10:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sj9YPf
	nukpvQV9eNeIa+6hgskrP0ZG/p9aZilsClzTU=; b=f0Ar/o2fFKlTebQbWZPzAl
	cDM2X3TRO9gjogScvmf4XBiyds6J891HekigKl2Jhrgmud+KEvmDhopniBjiOfFl
	muPn4S4o7kM1BE9QBuNaR5ooNWn+YKocnSmMq6DW6FLQvGpud0OFzxUQcT5qP7lC
	+qOQ3NQQ8+HCTy90vvHLUR7YAAA/S3MPrbH/u8M0N2a7dTtqZHSO7vW+yWa6r1tJ
	8MApE4Oc9JFxmPUa3EyhNT8hamoA6vEE63NK1r+cH8BIBxu7MhpOFqLlierbRNn4
	kf/54G0DmxTGxMVMOkI6xEu7BV8k/xnq79jTJPd4LTjIyIBvzd8zZ97hdn+NUoCw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rfkt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 10:40:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F9Vgr4025643;
	Wed, 15 Apr 2026 10:40:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujnn9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 10:40:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FAesuA56099100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 10:40:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BFB520043;
	Wed, 15 Apr 2026 10:40:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28E452004D;
	Wed, 15 Apr 2026 10:40:53 +0000 (GMT)
Received: from [9.124.217.147] (unknown [9.124.217.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 10:40:52 +0000 (GMT)
Message-ID: <a477aff1-cf72-424b-bdfd-9f9353bebb0d@linux.ibm.com>
Date: Wed, 15 Apr 2026 16:10:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Dead link in kdump section of MAINTAINERS file
To: Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>
References: <e1e9e200-17d7-4ae9-b0eb-71300f4eb1ac@linux.ibm.com>
 <ad8rrO55DGZqSyZy@darkstar.users.ipa.redhat.com>
 <ad9XWAXVxYFc-dWd@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ad9XWAXVxYFc-dWd@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA5NCBTYWx0ZWRfX3kva/xRTZX9s
 zQgwYYxlQQisbDyr86MMVst6t+wIpl6fqcymX2RNSsf6g6BWpz0+SLhz7sKiWDWaVgng/X1lmB0
 HnZ++4YrcAHzj83CBYKJszo2Sl7HbI9ePt1DNTnriLnNE2ag/hxi9VgMwwBql0HElZEQQAClKrF
 HkEbdVaFby+jFNl4bjuc68OCkcqz9CK+K4ucygxMCP+exNnUABdurr8yfgCkeI2usx4Unrk6CpS
 /d76KT1ZkTQaKWiXsg7n0tzKiyYDSpp6r7JeBQ9Vx9U5WjTp5YpkE6A09UhztmN5q35ZV4tYiXv
 L2XrREKF2M1xSWT2CfMOUF6PGNmMqgN5iQTJX5A++TIGeKSlRoJvg8675TdfmpFXegM6X0CsfF5
 TO28bQypSph0rNt3SA46MM8ZQyAH6qFhdPC6hNQx5QI5kCMV2gO/DAe+MbMkODXiy6WT/COTlfZ
 B7N/WbICdPZAMWkoOwg==
X-Proofpoint-ORIG-GUID: y6qqaJq29LyFNHVauTpafw8Dd34fr6Am
X-Proofpoint-GUID: y6qqaJq29LyFNHVauTpafw8Dd34fr6Am
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69df6b39 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=FP58Ms26AAAA:8
 a=h5t_dk97a5Lb72ZHPswA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_034118_146704_94D797AB 
X-CRM114-Status: GOOD (  11.80  )
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



On 15/04/26 14:46, Baoquan He wrote:
> On 04/15/26 at 02:09pm, Dave Young wrote:
>> Hi Sourabh,
>>
>> On Wed, Apr 15, 2026 at 10:26:20AM +0530, Sourabh Jain wrote:
>>> Hi all,
>>>
>>> Noticed a dead link in the kdump section of the MAINTAINERS file:
>>>
>>> W: http://lse.sourceforge.net/kdump/
>>>
>>> The URL no longer seems to be accessible. Could this be updated
>>> or replaced with a valid reference?
>>>
>> I have no idea about the old link, I suggest to remove it if nobody
>> knows.
> Yes, agree to remove it with a patch. There's document inside linux
> kernel, no necessary doc from outside.

Thanks for the input Baoquan.

- Sourabh Jain

