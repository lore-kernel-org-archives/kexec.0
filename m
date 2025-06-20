Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F5BC7115C
	for <kexec@archiver.kernel.org>; Fri, 20 Jun 2025 12:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6rUXYjFjupmfyWYiQGzWx5o52sn1aiaXwQdBHvw+BUk=; b=vJGiRzCP3anxgaatJROKE7SR9g
	ozccdI2A1aEZYVCU4FlmQWFjBe1y6488JpvLA1Ozo4dE+9C4JdIlEbDZ/d6ICMXSL3knE2U/qRy6X
	rjF/FZiQ/N0lTe2nKXT8HMyxl3cl84L0Qm7Fwq2mK3nBjukH9SqcGdi6iJXQduHGEIvjh91h8m205
	XZhZ3G7ZfhjzfMxiVbCIhr7tKtlyCDFSbogDRwTg9g+6PeSKob4oTQ1kqHu3doALrawxnErI5gzlZ
	JiFutxXLbrruWj3G5yvLgbD/nLmjNDcT6+S7DZcpjN8tLHLkt/IPNESevdO8GpIzTToQPAcd/jrZ+
	jaqcOfLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSbJv-0000000Fcb4-0A9E;
	Fri, 20 Jun 2025 12:58:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSaoW-0000000FZTz-2V42
	for kexec@lists.infradead.org;
	Fri, 20 Jun 2025 12:25:50 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K9lGCX002753;
	Fri, 20 Jun 2025 12:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6rUXYj
	FjupmfyWYiQGzWx5o52sn1aiaXwQdBHvw+BUk=; b=Iv3srOcgaRFqGuU22t5Z9e
	Nv8g6elxB66uPEpceNfjCYEyNDSZHpKLFhDnSzyc25QXKfVI741ZlcEsWu7HtgPS
	6y/kKcSqmTi4hWrVtURanRUCRy5MGyNgwIl6hBUlL00tyACr7nGYTGmINZytJnj5
	R4ckF+R5A+UFhoxK30v8zUYYAroGN7QxUmu0KMBAHPHwkY4HrADfgJ2W0OFHp+p9
	djn2KOAzahvHk/iloDBBGr0P8RIQSERLXfGgd190YrsW5h9bCKWt0V7RgaWA3hNe
	dUPvQkSFGE5Oyrl+pujjAohIaI/fa3Vm739j7yhERoX2OZcAvRy67EpsjX70nUQg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47beet965a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 12:25:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55K93I34027509;
	Fri, 20 Jun 2025 12:25:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479kt0b6pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 12:25:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55KCPhDI55247136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 12:25:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36F7720040;
	Fri, 20 Jun 2025 12:25:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15A6620043;
	Fri, 20 Jun 2025 12:25:42 +0000 (GMT)
Received: from [9.111.26.104] (unknown [9.111.26.104])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Jun 2025 12:25:41 +0000 (GMT)
Message-ID: <72d9e399-74ce-4882-b219-30ab70e17b06@linux.ibm.com>
Date: Fri, 20 Jun 2025 17:55:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][makedumpfile] Fix a data race in multi-threading mode
 (--num-threads=N)
To: Tao Liu <ltao@redhat.com>, yamazaki-msmt@nec.com, k-hagio-ab@nec.com,
        kexec@lists.infradead.org
References: <20250618235644.22589-2-ltao@redhat.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20250618235644.22589-2-ltao@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8f3D5BjFirimD9YyP1TJ7psdTHQmU7ao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA4NyBTYWx0ZWRfXxX07WZFQmk4k WaEeTSsC1JxRmekyxeQMWpCZqAM4bsMCKD9tn0InTe6XA+u8VbUOVpMTmm7USh769CjJDNW/ux7 eDyhz5RVTNI+O1i1pK8GFGCqZNudc913ZFalTdEnmgbwvdqCm+eMsQHoE6Q6I8MTc8B5U/U1MVy
 4FvjmKlAj1UprOnMzDWrB3LI2HAnUWVzV5iuTZB1dz2SMYt2qksnuKJ5d9acwGn2kLJGZHAwdoZ q+jb2Laqq7nMK4GlUIZnUk49Ks8ZvZgOeHq9/6GVe7zfWnA6gTyrfRJq0w/PU5xqpxTelM9u+VE L0beqRs+XfwrGsqYcga9LtPpJn5hMRI78UB3GHewva2RJtBh3MvXs0dhdiLRWFbs60W6GBPNV6E
 5cm1e5Pcg3g1+TZmDK1Lxq8iWv/d93DnCLRCkANP9hREh6pVg7pIGIekomAHem3jzE+CIMTG
X-Authority-Analysis: v=2.4 cv=PrSTbxM3 c=1 sm=1 tr=0 ts=6855534a cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=8P2hAZW1AYW8fd-Ex7AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8f3D5BjFirimD9YyP1TJ7psdTHQmU7ao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250620_052548_990440_F2213B12 
X-CRM114-Status: GOOD (  30.93  )
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

Hello Tao,

On 19/06/25 05:26, Tao Liu wrote:
> A vmcore corrupt issue has been noticed in powerpc arch [1]. Although the
> original issue was closed, but it still can be reproduced with upstream
> makedumpfile.
>
> With --num-threads=N enabled, there will be N sub-threads created. All
> sub-threads are producers which responsible for mm page processing, e.g.
> compression. The main thread is the consumer which responsible for
> writing the compressed data into file. page_flag_buf->ready is used to
> sync main and sub-threads. When a sub-thread finishes page processing,
> it will set ready flag to be FLAG_READY. In the meantime, main thread
> looply check all threads of the ready flags, and break the loop when
> find FLAG_READY.
>
> page_flag_buf->ready is read/write by main/sub-threads simultaneously,
> but it is unprotected and unsafe. I have tested both mutex and atomic_rw
> can fix this issue. This patch takes atomic_rw for its simplicity.
>
> [1]: https://github.com/makedumpfile/makedumpfile/issues/15
>
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
>   makedumpfile.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 2d3b08b..bac45c2 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -8621,7 +8621,8 @@ kdump_thread_function_cyclic(void *arg) {
>   
>   		while (buf_ready == FALSE) {
>   			pthread_testcancel();
> -			if (page_flag_buf->ready == FLAG_READY)
> +			if (__atomic_load_n(&page_flag_buf->ready,
> +					__ATOMIC_SEQ_CST) == FLAG_READY)
>   				continue;
>   
>   			/* get next dumpable pfn */
> @@ -8637,7 +8638,8 @@ kdump_thread_function_cyclic(void *arg) {
>   			info->current_pfn = pfn + 1;
>   
>   			page_flag_buf->pfn = pfn;
> -			page_flag_buf->ready = FLAG_FILLING;
> +			__atomic_store_n(&page_flag_buf->ready, FLAG_FILLING,
> +					__ATOMIC_SEQ_CST);
>   			pthread_mutex_unlock(&info->current_pfn_mutex);
>   			sem_post(&info->page_flag_buf_sem);
>   
> @@ -8726,7 +8728,8 @@ kdump_thread_function_cyclic(void *arg) {
>   			page_flag_buf->index = index;
>   			buf_ready = TRUE;
>   next:
> -			page_flag_buf->ready = FLAG_READY;
> +			__atomic_store_n(&page_flag_buf->ready, FLAG_READY,
> +					__ATOMIC_SEQ_CST);
>   			page_flag_buf = page_flag_buf->next;
>   
>   		}
> @@ -8855,7 +8858,8 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>   			 * current_pfn is used for recording the value of pfn when checking the pfn.
>   			 */
>   			for (i = 0; i < info->num_threads; i++) {
> -				if (info->page_flag_buf[i]->ready == FLAG_UNUSED)
> +				if (__atomic_load_n(&info->page_flag_buf[i]->ready,
> +						__ATOMIC_SEQ_CST) == FLAG_UNUSED)
>   					continue;
>   				temp_pfn = info->page_flag_buf[i]->pfn;
>   
> @@ -8863,7 +8867,8 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>   				 * count how many threads have reached the end.
>   				 */
>   				if (temp_pfn >= end_pfn) {
> -					info->page_flag_buf[i]->ready = FLAG_UNUSED;
> +					__atomic_store_n(&info->page_flag_buf[i]->ready,
> +						FLAG_UNUSED, __ATOMIC_SEQ_CST);
>   					end_count++;
>   					continue;
>   				}
> @@ -8885,7 +8890,8 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>   			 * If the page_flag_buf is not ready, the pfn recorded may be changed.
>   			 * So we should recheck.
>   			 */
> -			if (info->page_flag_buf[consuming]->ready != FLAG_READY) {
> +			if (__atomic_load_n(&info->page_flag_buf[consuming]->ready,
> +					__ATOMIC_SEQ_CST) != FLAG_READY) {
>   				clock_gettime(CLOCK_MONOTONIC, &new);
>   				if (new.tv_sec - last.tv_sec > WAIT_TIME) {
>   					ERRMSG("Can't get data of pfn.\n");
> @@ -8927,7 +8933,8 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>   				goto out;
>   			page_data_buf[index].used = FALSE;
>   		}
> -		info->page_flag_buf[consuming]->ready = FLAG_UNUSED;
> +		__atomic_store_n(&info->page_flag_buf[consuming]->ready,
> +				FLAG_UNUSED, __ATOMIC_SEQ_CST);
>   		info->page_flag_buf[consuming] = info->page_flag_buf[consuming]->next;
>   	}
>   finish:


I also observed this issue, and it is easily reproducible on Power 
systems with large memory configurations around 64TB.
In my case the crash tool printed following error message when running 
to debug the corrupted vmcore.

```
crash: compressed kdump: uncompress failed: 0
crash: read error: kernel virtual address: c0001e2d2fe48000  type: 
"hardirq thread_union"
crash: cannot read hardirq_ctx[930] at c0001e2d2fe48000
crash: compressed kdump: uncompress failed: 0
```

Should we include the above crash logs or the you observed in this 
commit message for easy reference?

I tested this fix on high-end Power systems with 64TB of RAM as well as 
on systems with lower memory, and everything is
working fine in both cases.

Thanks for the fix.
Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>

- Sourabh Jain

