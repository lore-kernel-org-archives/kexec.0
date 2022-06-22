Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1E9C433EF
	for <kexec@archiver.kernel.org>; Wed, 22 Jun 2022 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:
	References:To:Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=16ZaUS7H0B+gIFd3qyrXdHwq4KRgYmOIOwfk0Tx2ycY=; b=yualf99K9UQKKZ
	1x8866UbeiN7Mm6F3Q3fM80GIY8IHuOTEp6BSS29ZgPtqfzIe9WnKaInPUHYSYpQJHI+ttqrnhBoX
	WRe9BpyW0XJgYjolQRwaxZpFPwsQUFNyTkZo9dwCcsC9HtvWnZvSenq6S4UQCBxZLw25+YOfpPMKs
	cqWbqqEBs1xyi7oYia/41JbKhvKWQmgLjAu26BLCZLJwgntmoGP5a0BQr9I06XqmW/P2EGVGMkNyV
	fteTpINmgcJDOnG67Gl4kJPAfXbWmC4NKBbkzNntKOAnFw/lelXUYDjoBJiwW70pSVmmt2EOEOycU
	Y+g66ZOy+wkPv1RNa0bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o42Ms-00BCrl-6w; Wed, 22 Jun 2022 15:34:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o42Mp-00BCqR-5h
	for kexec@lists.infradead.org; Wed, 22 Jun 2022 15:34:08 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MEpKDF018624;
	Wed, 22 Jun 2022 15:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fXnI9BJ+eT4kh1Bl1pOj1MQY0/BIJ1rTZJngWBFMbjw=;
 b=cH4t9swpy0/cajQ9OIUQmbYcxrxG6GedvGGEccZuMucM8Hh6VbpfynEOIO9RFEuMscyp
 qcW8EI/2p6Z/ZmF3UhTspCoNqNBaeNN3I3EXgC9dBrVvXZFHHsalUkta5o6LLb80n8rx
 p4Tx+jLu9u72ujF89JIFf0PXH1lJJPU9/h1GB0P6JdOZ6P9e8ZmLx/750v18IhnmQtWH
 vA9rC4F4ll8GcKLYf0VDnIxuq5CuO6c8Uwu5iCy3Jkxnin+CbXA+rn0lXsKtZ+L+tS82
 AzqkbNGjJx6BIegb2hkfoRD5XrwWtwlfIMEt23PMfjybdYRXgM0+lOJNhoLBLXtEYOVw SA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv56x98e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jun 2022 15:34:04 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25MEptuh020382;
	Wed, 22 Jun 2022 15:34:03 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv56x98cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jun 2022 15:34:03 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25MFM6L2009056;
	Wed, 22 Jun 2022 15:34:01 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma04fra.de.ibm.com with ESMTP id 3gs6b8vk8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jun 2022 15:34:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25MFXwNB19005880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jun 2022 15:33:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D5815204F;
	Wed, 22 Jun 2022 15:33:58 +0000 (GMT)
Received: from [9.145.21.142] (unknown [9.145.21.142])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B93245204E;
	Wed, 22 Jun 2022 15:33:57 +0000 (GMT)
Message-ID: <ca1f9857-e3f6-6beb-2419-91a5865f2953@linux.ibm.com>
Date: Wed, 22 Jun 2022 17:33:57 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v5 5/5] powerpc/crash hp: add crash page helper functions
Content-Language: fr
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
References: <20220620070106.93141-1-sourabhjain@linux.ibm.com>
 <20220620070106.93141-6-sourabhjain@linux.ibm.com>
From: Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <20220620070106.93141-6-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lhuxE-aTjfBmZgMQ9nmcC_cNHdFP4Tv_
X-Proofpoint-GUID: 7bEHyUCfQKV93meI1lJGZzZz1DGdyoxA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_04,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220077
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_083407_264495_4D215C71 
X-CRM114-Status: GOOD (  20.95  )
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
Cc: eric.devolder@oracle.com, kexec@lists.infradead.org, bhe@redhat.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 20/06/2022, 09:01:06, Sourabh Jain wrote:
> Define arch_[un]map_crash_pages functions to avoid build issues due to
> undefined arch specific function to access crash memory pages.
> 
> A temporary patch to avoid build issues may need some changes in
> generic code to avoid this.
> 
> The issue is under discussion:
> https://lkml.org/lkml/2022/6/20/22
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/kexec/core_64.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 373cb46bcc0e..d833fa96dcfa 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -492,6 +492,13 @@ int update_cpus_node(void *fdt)
>  
>  #if defined(CONFIG_HOTPLUG_CPU)
>  
> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> +{
> +	return __va(paddr);
> +}

Why not define this as an inline in the appropriate PowerPC header file?

> +
> +void arch_unmap_crash_pages(void **ptr) { }

same here

> +
>  int crash_hotplug_support(void) { return 1; }
>  
>  /**


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
