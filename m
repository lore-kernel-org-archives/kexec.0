Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505D6CE8D6B
	for <kexec@archiver.kernel.org>; Mon, 17 Nov 2025 18:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CB4azO07xyg1JfNcGlWqEWWzwLoXdVKZABwYq4c8BVY=; b=QLiziZb4ZT3RcJKgBrq462jjFF
	I/NXxw7gofo6S80Boxcm6T9UwJcKOb8MAyfcwY5LJn/XUAEaAb/aesH8dIiOTBJxQSlkxMG83MOUl
	EFOldcsc4Qi4Fx+EWEAIQIV44YWF4tHmQsge88Up9KtCBXBFil5/9O68TU/H2udBxj7mm/38YzcYm
	30U7eX3AAQcYFAMkSyEDkzIpRvKwgPF7a2+LZoJdHt4xXUvot6KzxnR8/5pULb2Zl0PtDpf6ukO65
	6JQPP0E2cmpMus3hnHlUjzWjmsFc+S++qt5aoNalkOsEexy/paJ3jVlg05TVIwGCcx5D0aJfO7HpT
	EyBeI8aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL43E-0000000Gce1-36J9;
	Mon, 17 Nov 2025 18:34:08 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL43B-0000000Gcda-3Lwh
	for kexec@lists.infradead.org;
	Mon, 17 Nov 2025 18:34:07 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHBlNK5017282;
	Mon, 17 Nov 2025 18:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CB4azO
	07xyg1JfNcGlWqEWWzwLoXdVKZABwYq4c8BVY=; b=Ijgo3hGQSin4zYV/JXPl2r
	r9u2yN+I597/lVvzC+ylB3//8PWhCmpdUvnFXNwzQAWwW5xQ00DEx+ub/R9LDpkA
	VXbjOnZFQl8Urin/PTSKUB69FUZsSwOm7Wgj/FP3kJ8x0oZevMivvERtkUdWOlvf
	hBVNUodLNR+tn1VD/iuiSHl7ea3cQwE96MGVtWlnmBIZktOh4/riKUFCXXYtXyjF
	uRHqi1bXRZyQbeVOWQWVZ7Rwu2xx89uU/diSynw3exHi+wfVvklTIpPkyyISeeMW
	kNwWx0Xt7Vg5jIMVGM7y2X5SRqQdtfXO+HU5bkuvEbeMY/IQdJ9FV8TFKizXUlUw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjtqd3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 18:34:04 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AHISmE4016800;
	Mon, 17 Nov 2025 18:34:03 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjtqd39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 18:34:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHHrgtE010411;
	Mon, 17 Nov 2025 18:34:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af3urygt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 18:34:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AHIXxmN8061184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 18:33:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 177362004B;
	Mon, 17 Nov 2025 18:33:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEBB920040;
	Mon, 17 Nov 2025 18:33:55 +0000 (GMT)
Received: from [9.39.23.49] (unknown [9.39.23.49])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 18:33:55 +0000 (GMT)
Message-ID: <469c97cb-5ea1-4c2b-a70f-b1a6febf70df@linux.ibm.com>
Date: Tue, 18 Nov 2025 00:03:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] crash: export crashkernel CMA reservation to userspace
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Aditya Gupta <adityag@linux.ibm.com>,
        Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Pingfan Liu <piliu@redhat.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        kexec@lists.infradead.org
References: <20251117041905.1277801-1-sourabhjain@linux.ibm.com>
 <20251117094211.f8b4426ddda3bc0db5a62624@linux-foundation.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20251117094211.f8b4426ddda3bc0db5a62624@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CU9iESYN2j67vAEv2SgazOoBXgPDzaQZ
X-Proofpoint-ORIG-GUID: pxnzCu9taJxuT8G2Bw21OV8xLzu6ZmTS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX27fIVSon0c6o
 UhN7VIJqtR8X3Mll3WY0QUrGaxzD3eoEtbFLhPJP4xwmtisCcKFGgUTtpJFYFNCuz8lf8PriBwf
 Mo/rT53XUKk0VG3KPLrYJQBmmAUS+LkMpqB5MZIdiHhU3g9cJ9i3x6DI6vpdneuc1Ax9A37PAhW
 jbgBAvIt23EnO+qkzXEfmuB0oieL+72N0YJ1lZUkit9jf2cPx7EzjkyHl9HGs3+dA9Q3KJANyRt
 kRxGDqsSZQPDM7yR6rUmru+g7ZN5mNdTzenEcOob2W5hsyzNv+YDsCzIltQgDNSusGPKfXOhwKx
 cRMIK2OaYKyHSzi8LzsGL1xB3TZn1WHiSqQOh2N51evC/vDLGqQuD/yNkIGHXvPhJeJwbS10Z4G
 0fKNeNrEdaZy3dB3H7icpuJe0t5wdg==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=691b6a9c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=0l8sKcWMKP3lnFByZlwA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_103405_980521_CB74F480 
X-CRM114-Status: GOOD (  16.50  )
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



On 17/11/25 23:12, Andrew Morton wrote:
> On Mon, 17 Nov 2025 09:49:05 +0530 Sourabh Jain <sourabhjain@linux.ibm.com> wrote:
>
>> Add a sysfs entry /sys/kernel/kexec/crash_cma_ranges to expose all
>> CMA crashkernel ranges.
>>
>> This allows userspace tools configuring kdump to determine how much
>> memory is reserved for crashkernel. If CMA is used, tools can warn
>> users when attempting to capture user pages with CMA reservation.
>>
>> The new sysfs hold the CMA ranges in below format:
>>
>> cat /sys/kernel/kexec/crash_cma_ranges
>> 100000000-10c7fffff
>>
>> There are already four kexec and kdump sysfs entries under /sys/kernel.
>> Adding more entries there would clutter the directory. To avoid this,
>> the new crash_cma_ranges sysfs entry is placed in a new kexec node under
>> /sys/kernel/.
> I suggest not creating /sys/kernel/kexec in this patch.
>
> Moving everything into a new /sys/kernel/kexec is a separate patchset
> and a separate concept and it might never be merged - it changes ABI!
>
> So let's put crash_cma_ranges in /sys/kernel and move it to
> /sys/kernel/kexec within the other patchset.

Yeah sure. I will send the patches accordingly.

Thanks,
Sourabh Jain

