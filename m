Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A90C02192
	for <kexec@archiver.kernel.org>; Sat,  1 Feb 2025 07:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D0TqJrPFaCXJx1YuFrFi+B5yfQlPzZfk7qSonBtEN+c=; b=jZlTONvOX1L0QYEpl0j654RHT4
	afq80pcD9G/Dk+WUfp6V2i2hZutzPPh8hvj981L+2AGQsKXarFmP/dcCXZ7tNm9APKYJdVhuzB9E+
	tShwGeP6Rq4G15Y3Y/sDGBZgd2pTSYWpuMpxbutZIYiA6t5OgNjEcfUZ3RSxwrnnGQk/wLZvmuE7g
	79uL07YIE95px70/A9BPNInzkSRJ/7lOBBNy67gIa688v49i/NefmN5dmOTDv9xcR/DjjE3GMyeFZ
	RFCCScfoTSb6/pKHB6J9b0f9W+gWWrGcyhxrzIKTRmgPitiXWQvW35gu+4e1eR6ggnK3bphstYbOj
	qJn2Izpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1te7t4-0000000Bzhm-3wBT;
	Sat, 01 Feb 2025 07:25:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1te7kO-0000000ByLz-3xl8
	for kexec@lists.infradead.org;
	Sat, 01 Feb 2025 07:16:58 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5115P2Cd023403;
	Sat, 1 Feb 2025 07:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D0TqJr
	PFaCXJx1YuFrFi+B5yfQlPzZfk7qSonBtEN+c=; b=NGdlSk2CCbM5ZtHVxYY0su
	oY+VLN7+m6hmEuDFS46fDLuzGlIHoLNLAtXba3nV45KEI1T8ITmUjwXxqS82ipFx
	hAXjhzf2rNEGnCn62mnICY/PX7M8FTESnNka6ewtxJvyPJv5CqQok4RzxvHgforK
	kXxzMwSinHjOJQxu1NdIyjYVk8g956pKcNVeCOPrn6+9jKPFUCixKt4cUNaSX3QH
	vVfDO2JrW8jyBReVw5keuBF/4CyyfcgPEz91oDwf5K/5vvoshDYCcib9FJ6fl/Va
	JFjnwlm1Rd37fEHSuQSqakpwJGovNIhOGz+klu6spxVjigHNxzUFeFDlw9WBfVZQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44hdce886b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Feb 2025 07:16:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5115Cr40029818;
	Sat, 1 Feb 2025 07:16:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hd92rb7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Feb 2025 07:16:47 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5117GiRX37880182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Feb 2025 07:16:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A73620094;
	Sat,  1 Feb 2025 07:16:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5713D20092;
	Sat,  1 Feb 2025 07:16:41 +0000 (GMT)
Received: from [9.43.103.42] (unknown [9.43.103.42])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Feb 2025 07:16:41 +0000 (GMT)
Message-ID: <e7e371cc-cb34-4ba1-8aa5-c18ec3802d9a@linux.ibm.com>
Date: Sat, 1 Feb 2025 12:46:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] crash: Let arch decide usable memory range in
 reserved area
To: Baoquan he <bhe@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250131113830.925179-1-sourabhjain@linux.ibm.com>
 <20250131113830.925179-4-sourabhjain@linux.ibm.com> <Z52hUz5/nZhzTUb4@fedora>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Z52hUz5/nZhzTUb4@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IxliJALJ4rLAy8ZlFpwTVM7tGofSRKlj
X-Proofpoint-GUID: IxliJALJ4rLAy8ZlFpwTVM7tGofSRKlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-01_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=779
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502010059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_231657_108201_FC643B15 
X-CRM114-Status: GOOD (  14.72  )
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

Hello Baoquan,


On 01/02/25 09:52, Baoquan he wrote:
> On 01/31/25 at 05:08pm, Sourabh Jain wrote:
>> Although the crashkernel area is reserved, on architectures like
>> PowerPC, it is possible for the crashkernel reserved area to contain
>> components like RTAS, TCE, OPAL, etc. To avoid placing kexec segments
>> over these components, PowerPC has its own set of APIs to locate holes
>> in the crashkernel reserved area.
>>
>> Add an arch hook in the generic locate mem hole APIs so that
>> architectures can handle such special regions in the crashkernel area
>> while locating memory holes for kexec segments using generic APIs.
>> With this, a lot of redundant arch-specific code can be removed, as it
>> performs the exact same job as the generic APIs.
>>
>> To keep the generic and arch-specific changes separate, the changes
>> related to moving PowerPC to use the generic APIs and the removal of
>> PowerPC-specific APIs for memory hole allocation are done in a
>> subsequent patch titled "powerpc/crash: Use generic APIs to locate
>> memory hole for kdump.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan he <bhe@redhat.com>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: kexec@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   include/linux/kexec.h |  9 +++++++++
>>   kernel/kexec_file.c   | 12 ++++++++++++
>>   2 files changed, 21 insertions(+)
> LGTM,
>
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks for the Ack!

- Sourabh Jain


