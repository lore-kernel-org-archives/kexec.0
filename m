Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9938CE77199
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sz+OaCt6VHFwHy69HSLd7yO0UqMuAsCNfcDDMxudYRY=; b=NYS1rMpGljgx5mhZuApS1Zb4Si
	RyoBkcCwb0amQ5pxH8+vfVQC27+GtFjU/TwNwwyPFxiRpKuGRtL6KA6QTJwQhoyfPkUg3mZD1SwXA
	n9zQ90kTlogSetrzf55YrgXKtIONte0pIXm70mc4VFDAVIOB9S3JyZKnZmbiG+3r2qJMcw6oMrMT6
	dZxoE8m1hHFhFuocGjNzCzqy91sLSGlMa3o0m7muQN3IlxQ1yQDGXJrgcEg7T19nlB2/94OhMB2hu
	9U6cO4tu6S49coGQKktmoPzVisk1Z2rokejuYkf6VwIga+zvv+txXKgz0E3vxHrJz0hMZ3KxGYEe8
	1IJGppGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVVZC-00000008Vfm-1Utt;
	Wed, 08 Jan 2025 12:53:46 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVUmV-00000008LcB-10qh
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 12:03:28 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5083ruvX007978;
	Wed, 8 Jan 2025 12:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sz+OaC
	t6VHFwHy69HSLd7yO0UqMuAsCNfcDDMxudYRY=; b=Nw7ILq/6+rGQrezDpVrUPO
	3m7HpWF+3tYCmB0KFVZaGmG6FX+gnL5nDHp6RPp61cIlbggPLmclmz8DpHxoVB3S
	Q7UmtZGseoS6CAZT3LBV3QQwwixbflWyAiyF79CNOrAIE1ssVChiGW9rcchHJW61
	c+VkbfxKOdvjP+FAfioai4xP/tpyJVJ9MpeqjTzoB3kifipIbtAzZUYGdF72Z4VZ
	6a4mLQG7LrsDVYEwWxsGwgf70e/pZwBtRB5NI78fk4P2rlyNKfKbNMHl2VtOLG2v
	rxw62LnXzmGzEFjcIeB73WPA8s+TH75/09XNYU40egBBgWN8F0eTPCQhta27Scfg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441hupt2p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 12:03:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508ASVeE027963;
	Wed, 8 Jan 2025 12:03:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhk7c5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 12:03:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508C3GF244237240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 12:03:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F6DE2004D;
	Wed,  8 Jan 2025 12:03:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E6A32004B;
	Wed,  8 Jan 2025 12:03:13 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2025 12:03:13 +0000 (GMT)
Message-ID: <9a420bf8-3c22-4dc2-809a-19ceac9aa373@linux.ibm.com>
Date: Wed, 8 Jan 2025 17:33:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v1 5/5] crash: option to let arch decide mem range
 is usable
To: Baoquan he <bhe@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250108101458.406806-1-sourabhjain@linux.ibm.com>
 <20250108101458.406806-6-sourabhjain@linux.ibm.com>
 <Z35jpYq4GvCAXiII@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Z35jpYq4GvCAXiII@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZG1W62BsKV561xoiulsaJlrKgW9sDapX
X-Proofpoint-GUID: ZG1W62BsKV561xoiulsaJlrKgW9sDapX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=686
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_040327_292916_739F8B52 
X-CRM114-Status: GOOD (  13.19  )
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




On 08/01/25 17:08, Baoquan he wrote:
> On 01/08/25 at 03:44pm, Sourabh Jain wrote:
> ...snip...
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index f0e9f8eda7a3..407f8b0346aa 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -205,6 +205,15 @@ static inline int arch_kimage_file_post_load_cleanup(struct kimage *image)
>>   }
>>   #endif
>>   
>> +#ifndef arch_check_excluded_range
>> +static inline int arch_check_excluded_range(struct kimage *image,
>> +					    unsigned long start,
>> +					    unsigned long end)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
>>   #ifdef CONFIG_KEXEC_SIG
>>   #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
>>   int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 3eedb8c226ad..52e1480dbfa1 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -464,6 +464,12 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>>   			continue;
>>   		}
>>   
>> +		/* Make sure this does not conflict exclude range */
>                                                     ^
>                  Make sure this doesn't conflict with excluded range?
>
>> +		if (arch_check_excluded_range(image, temp_start, temp_end)) {
>> +			temp_start = temp_start - PAGE_SIZE;
>> +			continue;
>> +		}
>> +
>>   		/* We found a suitable memory range */
>>   		break;
>>   	} while (1);
>> @@ -498,6 +504,12 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>>   			continue;
>>   		}
>>   
>> +		/* Make sure this does not conflict exclude range */
>                                                     ^
>                                                   Ditto.

I will update both comments.

Thanks,
Sourabh Jain


