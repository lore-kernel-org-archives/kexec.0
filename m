Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07DEC77B61
	for <kexec@archiver.kernel.org>; Mon, 24 Apr 2023 15:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NWBNIFiYQA2Q+Ss1uisod0Sc6f+CXJeyupWMkGc0Xsk=; b=gyMvIPWoVpme7wGzl0GbRhJViW
	lwtCUbv3vANV58VJK0bZCuH9Fv9LxkUlxh9ip6/FI+ueTSqENeQx1igZGZWVNi68yXa2Osg/6EyT3
	2xzpnxewASz1kFHY1LFxN0ivc4ECT4Vfh67StBEfthMDckq5NaQQ5TxccnjQRBhHWREwcFlxeLncS
	dez9IzseDmJdeqAPRewnWzWhdS6YEGHUfWmG0+egnR1l7jlE/EeY66AlIdjcFsaDuXESLjYSxrmTW
	m+fP7HQC3IiyaPizoIWXYUq5BnbZYqd264W9e7qsmA1CE80nDH1WSHeqHWpnx0w62A28kfwMGLQHY
	iPYAfsSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqyVG-00GkBV-0G;
	Mon, 24 Apr 2023 15:53:22 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqyVD-00GkB0-2X
	for kexec@lists.infradead.org;
	Mon, 24 Apr 2023 15:53:21 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OEeULd024589;
	Mon, 24 Apr 2023 15:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qWjmJITQVbVjpvpbeY5cXPitIqrlOKrTeWepgG54gaU=;
 b=UTK4oTclpjNGjXT1xrxCG+ae3+tOwvN83eIOtC1bYg5OqfsNvVIJY9WCduNhfDVXrUx3
 iI7lK2mqP5Jpeqvb3dqO3cgAV5aeoAOftGfTrcvpmOQKjkyr8mX0OpX5hHpAjVuHSjf3
 g0iHPegtpQMCLUH+ohqRe1HffkI5UAWVwkQItKYhlTDYu0im5nlJHIZHv5U6uiTFDb4Z
 pSJKCq+oEK8/B+wSplRyTfjls+X4kHucyN2KC9WTmnrCzDEu+FThYrVgJyeuCLJsQsvz
 jVLvmpBZidEL0+efn9APCj6x8buXQe13tV7B1Jy9uPHRemYj7zbuxmsF9Eh+EbwmhCOf OA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q4510ryq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Apr 2023 15:02:36 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33OEiknb023947;
	Mon, 24 Apr 2023 15:01:38 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q4510rwg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Apr 2023 15:01:38 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
	by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33O5M67O022510;
	Mon, 24 Apr 2023 15:01:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3q46ug102f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Apr 2023 15:01:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33OF0ugM13894330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Apr 2023 15:00:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBF3E20040;
	Mon, 24 Apr 2023 15:00:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34C812004E;
	Mon, 24 Apr 2023 15:00:54 +0000 (GMT)
Received: from [9.43.100.55] (unknown [9.43.100.55])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Apr 2023 15:00:53 +0000 (GMT)
Message-ID: <8a14c915-c121-c1c3-1d03-250ad571c840@linux.ibm.com>
Date: Mon, 24 Apr 2023 20:30:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v10 2/5] powerpc/crash: introduce a new config option
 CRASH_HOTPLUG
Content-Language: en-US
To: Laurent Dufour <ldufour@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
References: <20230423105213.70795-1-sourabhjain@linux.ibm.com>
 <20230423105213.70795-3-sourabhjain@linux.ibm.com>
 <c87ace32-b11d-8b60-50f5-584acc2bd824@linux.ibm.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <c87ace32-b11d-8b60-50f5-584acc2bd824@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NzirQfUcTCjkb1fLdSBKAXjtuyXHDeru
X-Proofpoint-ORIG-GUID: AiJCfFXlfSzpmmCC-n13nW8T9TV7qzPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_09,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240131
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_085319_942124_16F5C4AB 
X-CRM114-Status: GOOD (  23.59  )
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
Cc: bhe@redhat.com, kexec@lists.infradead.org, Laurent Dufour <laurent.dufour@fr.ibm.com>, eric.devolder@oracle.com, hbathini@linux.ibm.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


On 24/04/23 15:27, Laurent Dufour wrote:
> On 23/04/2023 12:52:10, Sourabh Jain wrote:
>> Due to CPU/Memory hot plug/unplug or online/offline events the system
>> resources changes. A similar change should reflect in the loaded kdump
>> kernel kexec segments that describes the state of the CPU and memory of
>> the running kernel.
>>
>> If the kdump kernel kexec segments are not updated after the CPU/Memory
>> hot plug/unplug or online/offline events and kdump kernel tries to
>> collect the dump with the stale system resource data then this might
>> lead to dump collection failure or an inaccurate dump collection.
>>
>> The current method to keep the kdump kernel kexec segments up to date is
>> by reloading the complete kdump kernel whenever a CPU/Memory hot
>> plug/unplug or online/offline event is observed in userspace. Reloading
>> the kdump kernel for every CPU/Memory hot plug/unplug or online/offline
>> event is inefficient and creates a large window where the kdump service
>> is not available. It can be improved by doing in-kernel updates to only
>> necessary kdump kernel kexec segments which describe CPU and Memory
>> resources of the running kernel to the kdump kernel.
>>
>> The kernel changes related to in-kernel updates to the kdump kernel
>> kexec segments are kept under the CRASH_HOTPLUG config option.
>>
>> Later in the series, a powerpc crash hotplug handler is introduced to
>> update the kdump kernel kexec segments on CPU/Memory hotplug events.
>> This arch-specific handler is triggered from a generic crash handler
>> that registers with the CPU/Memory add/remove notifiers.
>>
>> The CRASH_HOTPLUG config option is enabled by default.
>>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>
> I can't remember having sent a review-by on that patch earlier.
>
> Anyway, I can't find any issue with that one, so replace with:
> Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>

I apologies for mistakenly applying the "Reviewed-by" tag to the entire
patch series, when it was intended for only one patch. I will remove the
tag in next version.

- Sourabh Jain


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
