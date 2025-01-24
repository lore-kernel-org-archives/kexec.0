Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D35C02181
	for <kexec@archiver.kernel.org>; Fri, 24 Jan 2025 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hpKskXVjgOzyZaxztnFU2cAlivF8Cd3w2FfX1ovqe0Y=; b=vgEt53sFRfVkJylZ5YBF00u7uq
	ry4E3ZUmMRfJ1Z41WWcSelh/jrchV1mjwgMtsiLI8ftmc74eckeDG/KioAZNW9ftzCOXFtEWfoxDY
	DlxI6jvTF1KnAZUAXDbqZY8kGC3xX1TKdi2WrIifm7BPoMAPfHjdpJf6V6Y8nw0gNYVgbDHTEUUZy
	IuZLiFqTVyIshy7/MYawcSV8H4d+2/ogyqTcpbCc4hshJNpOzPTIVFtvStVRdPrspF+sbid7G+Uj5
	HvHOkeMwHoglKM1LtHxlpExDFAH4/uJbzBFKJqhuzVVuwAJRv0fyVvGD73odTuc8e5/FxGGv/IeYb
	STsNwPfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbGvG-0000000ESfL-29wB;
	Fri, 24 Jan 2025 10:28:22 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbGvE-0000000ESeD-1C3U
	for kexec@lists.infradead.org;
	Fri, 24 Jan 2025 10:28:21 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O7XqUH024041;
	Fri, 24 Jan 2025 10:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hpKskX
	VjgOzyZaxztnFU2cAlivF8Cd3w2FfX1ovqe0Y=; b=Q2fjwg9IubUoeNTMpplPRB
	ZA6XNaPov4t6WELAgV+IDcUulaInuK5Yoz7CpCS2wSt7No/i0Ek+H6fJaVAiX7c1
	8lsNRVfn8p17y/YYAv9Bxdfx9IRp2r+o6oxb3nP+ftqW/WVWv7/E3K4n7QCMGLud
	xtElb9JSkaB6HIFr+1zRfMwEEo3rbRpFXvqkJ+mQGuUe/zF7HHMQMIrW5iEYEpo2
	m97cM2POyD/ONNzlvPUE2T9ucuQ137d7jUUklFQBjrxjfIxlyDjN4z904inSSanO
	H4G7feb29m0DRk2Bpl5TvCa/NgwxE7u4eKKYc7pYok4FQ/+y0giY9wT/RiDyzJjg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c6jngqwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 10:28:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50O8YHC5022384;
	Fri, 24 Jan 2025 10:28:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4kju1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 10:28:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OAS7nR21103158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 10:28:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F2422020E;
	Fri, 24 Jan 2025 10:28:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 820CB2020B;
	Fri, 24 Jan 2025 10:28:05 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 10:28:05 +0000 (GMT)
Message-ID: <6af97bc3-1ff1-4843-a15a-6067c1a40b9d@linux.ibm.com>
Date: Fri, 24 Jan 2025 15:58:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] crash: option to let arch decide mem range is
 usable
To: Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250121115442.1278458-1-sourabhjain@linux.ibm.com>
 <20250121115442.1278458-7-sourabhjain@linux.ibm.com>
 <755825bb-4153-44ce-8c1d-7c011fac4b7d@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <755825bb-4153-44ce-8c1d-7c011fac4b7d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -Unl90OubHgdJMTixrrxnbojyUIdUzgg
X-Proofpoint-ORIG-GUID: -Unl90OubHgdJMTixrrxnbojyUIdUzgg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_03,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_022820_452763_703301B2 
X-CRM114-Status: GOOD (  24.59  )
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

Hello Hari,


On 24/01/25 15:22, Hari Bathini wrote:
> Hi Sourabh,
>
> On 21/01/25 5:24 pm, Sourabh Jain wrote:
>> On PowerPC, the memory reserved for the crashkernel can contain
>> components like RTAS, TCE, OPAL, etc., which should be avoided when
>> loading kexec segments into crashkernel memory. Due to these special
>> components, PowerPC has its own set of functions to locate holes in the
>> crashkernel memory for loading kexec segments for kdump. However, for
>> loading kexec segments in the kexec case, PowerPC uses generic functions
>> to locate holes.
>>
>> So, let's use generic functions to locate memory holes for kdump on
>> PowerPC by adding an arch hook to handle such special regions while
>> loading kexec segments, and remove the PowerPC functions to locate
>> holes.
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
>>   arch/powerpc/include/asm/kexec.h  |   6 +-
>>   arch/powerpc/kexec/file_load_64.c | 259 ++----------------------------
>>   include/linux/kexec.h             |   9 ++
>>   kernel/kexec_file.c               |  12 ++
>>   4 files changed, 34 insertions(+), 252 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/kexec.h 
>> b/arch/powerpc/include/asm/kexec.h
>> index 64741558071f..5e4680f9ff35 100644
>> --- a/arch/powerpc/include/asm/kexec.h
>> +++ b/arch/powerpc/include/asm/kexec.h
>> @@ -95,8 +95,10 @@ int arch_kexec_kernel_image_probe(struct kimage 
>> *image, void *buf, unsigned long
>>   int arch_kimage_file_post_load_cleanup(struct kimage *image);
>>   #define arch_kimage_file_post_load_cleanup 
>> arch_kimage_file_post_load_cleanup
>>   -int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>> -#define arch_kexec_locate_mem_hole arch_kexec_locate_mem_hole
>> +int arch_check_excluded_range(struct kimage *image, unsigned long 
>> start,
>> +                  unsigned long end);
>> +#define arch_check_excluded_range  arch_check_excluded_range
>> +
>>     int load_crashdump_segments_ppc64(struct kimage *image,
>>                     struct kexec_buf *kbuf);
>> diff --git a/arch/powerpc/kexec/file_load_64.c 
>> b/arch/powerpc/kexec/file_load_64.c
>> index dc65c1391157..e7ef8b2a2554 100644
>> --- a/arch/powerpc/kexec/file_load_64.c
>> +++ b/arch/powerpc/kexec/file_load_64.c
>> @@ -49,201 +49,18 @@ const struct kexec_file_ops * const 
>> kexec_file_loaders[] = {
>>       NULL
>>   };
>>   -/**
>> - * __locate_mem_hole_top_down - Looks top down for a large enough 
>> memory hole
>> - *                              in the memory regions between 
>> buf_min & buf_max
>> - *                              for the buffer. If found, sets 
>> kbuf->mem.
>> - * @kbuf:                       Buffer contents and memory parameters.
>> - * @buf_min:                    Minimum address for the buffer.
>> - * @buf_max:                    Maximum address for the buffer.
>> - *
>> - * Returns 0 on success, negative errno on error.
>> - */
>> -static int __locate_mem_hole_top_down(struct kexec_buf *kbuf,
>> -                      u64 buf_min, u64 buf_max)
>> -{
>> -    int ret = -EADDRNOTAVAIL;
>> -    phys_addr_t start, end;
>> -    u64 i;
>> -
>> -    for_each_mem_range_rev(i, &start, &end) {
>> -        /*
>> -         * memblock uses [start, end) convention while it is
>> -         * [start, end] here. Fix the off-by-one to have the
>> -         * same convention.
>> -         */
>> -        end -= 1;
>> -
>> -        if (start > buf_max)
>> -            continue;
>> -
>> -        /* Memory hole not found */
>> -        if (end < buf_min)
>> -            break;
>> -
>> -        /* Adjust memory region based on the given range */
>> -        if (start < buf_min)
>> -            start = buf_min;
>> -        if (end > buf_max)
>> -            end = buf_max;
>> -
>> -        start = ALIGN(start, kbuf->buf_align);
>> -        if (start < end && (end - start + 1) >= kbuf->memsz) {
>> -            /* Suitable memory range found. Set kbuf->mem */
>> -            kbuf->mem = ALIGN_DOWN(end - kbuf->memsz + 1,
>> -                           kbuf->buf_align);
>> -            ret = 0;
>> -            break;
>> -        }
>> -    }
>> -
>> -    return ret;
>> -}
>> -
>> -/**
>> - * locate_mem_hole_top_down_ppc64 - Skip special memory regions to 
>> find a
>> - *                                  suitable buffer with top down 
>> approach.
>> - * @kbuf:                           Buffer contents and memory 
>> parameters.
>> - * @buf_min:                        Minimum address for the buffer.
>> - * @buf_max:                        Maximum address for the buffer.
>> - * @emem:                           Exclude memory ranges.
>> - *
>> - * Returns 0 on success, negative errno on error.
>> - */
>> -static int locate_mem_hole_top_down_ppc64(struct kexec_buf *kbuf,
>> -                      u64 buf_min, u64 buf_max,
>> -                      const struct crash_mem *emem)
>> +int arch_check_excluded_range(struct kimage *image, unsigned long 
>> start,
>> +                  unsigned long end)
>>   {
>> -    int i, ret = 0, err = -EADDRNOTAVAIL;
>> -    u64 start, end, tmin, tmax;
>> -
>> -    tmax = buf_max;
>> -    for (i = (emem->nr_ranges - 1); i >= 0; i--) {
>> -        start = emem->ranges[i].start;
>> -        end = emem->ranges[i].end;
>> -
>> -        if (start > tmax)
>> -            continue;
>> -
>> -        if (end < tmax) {
>> -            tmin = (end < buf_min ? buf_min : end + 1);
>> -            ret = __locate_mem_hole_top_down(kbuf, tmin, tmax);
>> -            if (!ret)
>> -                return 0;
>> -        }
>> -
>> -        tmax = start - 1;
>> -
>> -        if (tmax < buf_min) {
>> -            ret = err;
>> -            break;
>> -        }
>> -        ret = 0;
>> -    }
>> -
>> -    if (!ret) {
>> -        tmin = buf_min;
>> -        ret = __locate_mem_hole_top_down(kbuf, tmin, tmax);
>> -    }
>> -    return ret;
>> -}
>> -
>> -/**
>> - * __locate_mem_hole_bottom_up - Looks bottom up for a large enough 
>> memory hole
>> - *                               in the memory regions between 
>> buf_min & buf_max
>> - *                               for the buffer. If found, sets 
>> kbuf->mem.
>> - * @kbuf:                        Buffer contents and memory parameters.
>> - * @buf_min:                     Minimum address for the buffer.
>> - * @buf_max:                     Maximum address for the buffer.
>> - *
>> - * Returns 0 on success, negative errno on error.
>> - */
>> -static int __locate_mem_hole_bottom_up(struct kexec_buf *kbuf,
>> -                       u64 buf_min, u64 buf_max)
>> -{
>> -    int ret = -EADDRNOTAVAIL;
>> -    phys_addr_t start, end;
>> -    u64 i;
>> -
>> -    for_each_mem_range(i, &start, &end) {
>> -        /*
>> -         * memblock uses [start, end) convention while it is
>> -         * [start, end] here. Fix the off-by-one to have the
>> -         * same convention.
>> -         */
>> -        end -= 1;
>> -
>> -        if (end < buf_min)
>> -            continue;
>> -
>> -        /* Memory hole not found */
>> -        if (start > buf_max)
>> -            break;
>> -
>> -        /* Adjust memory region based on the given range */
>> -        if (start < buf_min)
>> -            start = buf_min;
>> -        if (end > buf_max)
>> -            end = buf_max;
>> -
>> -        start = ALIGN(start, kbuf->buf_align);
>> -        if (start < end && (end - start + 1) >= kbuf->memsz) {
>> -            /* Suitable memory range found. Set kbuf->mem */
>> -            kbuf->mem = start;
>> -            ret = 0;
>> -            break;
>> -        }
>> -    }
>> -
>> -    return ret;
>> -}
>> -
>> -/**
>> - * locate_mem_hole_bottom_up_ppc64 - Skip special memory regions to 
>> find a
>> - *                                   suitable buffer with bottom up 
>> approach.
>> - * @kbuf:                            Buffer contents and memory 
>> parameters.
>> - * @buf_min:                         Minimum address for the buffer.
>> - * @buf_max:                         Maximum address for the buffer.
>> - * @emem:                            Exclude memory ranges.
>> - *
>> - * Returns 0 on success, negative errno on error.
>> - */
>> -static int locate_mem_hole_bottom_up_ppc64(struct kexec_buf *kbuf,
>> -                       u64 buf_min, u64 buf_max,
>> -                       const struct crash_mem *emem)
>> -{
>> -    int i, ret = 0, err = -EADDRNOTAVAIL;
>> -    u64 start, end, tmin, tmax;
>> -
>> -    tmin = buf_min;
>> -    for (i = 0; i < emem->nr_ranges; i++) {
>> -        start = emem->ranges[i].start;
>> -        end = emem->ranges[i].end;
>> -
>> -        if (end < tmin)
>> -            continue;
>> -
>> -        if (start > tmin) {
>> -            tmax = (start > buf_max ? buf_max : start - 1);
>> -            ret = __locate_mem_hole_bottom_up(kbuf, tmin, tmax);
>> -            if (!ret)
>> -                return 0;
>> -        }
>> -
>> -        tmin = end + 1;
>> +    struct crash_mem *emem;
>> +    int i;
>>   -        if (tmin > buf_max) {
>> -            ret = err;
>> -            break;
>> -        }
>> -        ret = 0;
>> -    }
>> +    emem = image->arch.exclude_ranges;
>> +    for (i = 0; i < emem->nr_ranges; i++)
>> +        if (start < emem->ranges[i].end && end > emem->ranges[i].start)
>> +            return 1;
>>   -    if (!ret) {
>> -        tmax = buf_max;
>> -        ret = __locate_mem_hole_bottom_up(kbuf, tmin, tmax);
>> -    }
>> -    return ret;
>> +    return 0;
>>   }
>>     #ifdef CONFIG_CRASH_DUMP
>> @@ -1004,64 +821,6 @@ int setup_new_fdt_ppc64(const struct kimage 
>> *image, void *fdt, struct crash_mem
>>       return ret;
>>   }
>>   -/**
>> - * arch_kexec_locate_mem_hole - Skip special memory regions like 
>> rtas, opal,
>> - *                              tce-table, reserved-ranges & such 
>> (exclude
>> - *                              memory ranges) as they can't be used 
>> for kexec
>> - *                              segment buffer. Sets kbuf->mem when 
>> a suitable
>> - *                              memory hole is found.
>> - * @kbuf:                       Buffer contents and memory parameters.
>> - *
>> - * Assumes minimum of PAGE_SIZE alignment for kbuf->memsz & 
>> kbuf->buf_align.
>> - *
>> - * Returns 0 on success, negative errno on error.
>> - */
>> -int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
>> -{
>> -    struct crash_mem **emem;
>> -    u64 buf_min, buf_max;
>> -    int ret;
>> -
>> -    /* Look up the exclude ranges list while locating the memory 
>> hole */
>> -    emem = &(kbuf->image->arch.exclude_ranges);
>> -    if (!(*emem) || ((*emem)->nr_ranges == 0)) {
>> -        pr_warn("No exclude range list. Using the default locate mem 
>> hole method\n");
>> -        return kexec_locate_mem_hole(kbuf);
>> -    }
>> -
>> -    buf_min = kbuf->buf_min;
>> -    buf_max = kbuf->buf_max;
>> -    /* Segments for kdump kernel should be within crashkernel region */
>> -    if (IS_ENABLED(CONFIG_CRASH_DUMP) && kbuf->image->type == 
>> KEXEC_TYPE_CRASH) {
>> -        buf_min = (buf_min < crashk_res.start ?
>> -               crashk_res.start : buf_min);
>> -        buf_max = (buf_max > crashk_res.end ?
>> -               crashk_res.end : buf_max);
>> -    }
>> -
>> -    if (buf_min > buf_max) {
>> -        pr_err("Invalid buffer min and/or max values\n");
>> -        return -EINVAL;
>> -    }
>> -
>> -    if (kbuf->top_down)
>> -        ret = locate_mem_hole_top_down_ppc64(kbuf, buf_min, buf_max,
>> -                             *emem);
>> -    else
>> -        ret = locate_mem_hole_bottom_up_ppc64(kbuf, buf_min, buf_max,
>> -                              *emem);
>> -
>> -    /* Add the buffer allocated to the exclude list for the next 
>> lookup */
>> -    if (!ret) {
>> -        add_mem_range(emem, kbuf->mem, kbuf->memsz);
>> -        sort_memory_ranges(*emem, true);
>> -    } else {
>> -        pr_err("Failed to locate memory buffer of size %lu\n",
>> -               kbuf->memsz);
>> -    }
>> -    return ret;
>> -}
>> -
>>   /**
>>    * arch_kexec_kernel_image_probe - Does additional handling needed 
>> to setup
>>    *                                 kexec segments.
>
>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index f0e9f8eda7a3..407f8b0346aa 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -205,6 +205,15 @@ static inline int 
>> arch_kimage_file_post_load_cleanup(struct kimage *image)
>>   }
>>   #endif
>>   +#ifndef arch_check_excluded_range
>> +static inline int arch_check_excluded_range(struct kimage *image,
>> +                        unsigned long start,
>> +                        unsigned long end)
>> +{
>> +    return 0;
>> +}
>> +#endif
>> +
>>   #ifdef CONFIG_KEXEC_SIG
>>   #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
>>   int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long 
>> kernel_len);
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 3eedb8c226ad..fba686487e3b 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -464,6 +464,12 @@ static int locate_mem_hole_top_down(unsigned 
>> long start, unsigned long end,
>>               continue;
>>           }
>>   +        /* Make sure this does not conflict with exclude range */
>> +        if (arch_check_excluded_range(image, temp_start, temp_end)) {
>> +            temp_start = temp_start - PAGE_SIZE;
>> +            continue;
>> +        }
>> +
>>           /* We found a suitable memory range */
>>           break;
>>       } while (1);
>> @@ -498,6 +504,12 @@ static int locate_mem_hole_bottom_up(unsigned 
>> long start, unsigned long end,
>>               continue;
>>           }
>>   +        /* Make sure this does not conflict with exclude range */
>> +        if (arch_check_excluded_range(image, temp_start, temp_end)) {
>> +            temp_start = temp_start + PAGE_SIZE;
>> +            continue;
>> +        }
>> +
>>           /* We found a suitable memory range */
>>           break;
>>       } while (1);
>
> Please split this arch-independent patch and have it as a preceding
> patch. Arch-specific changes can go in a separate patch.

Yes, I will split this patch in the next version.

Thanks,
Sourabh Jain


