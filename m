Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61508E85372
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 14:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u4o+5xQz4rBlXhhhaVbeSyCEljJvqzKGzcABXH9U2Ss=; b=eJFLkCtyLhtMg1x7JyYfpDiBiG
	DEtWL/hczTjY7JJvwNOzFRevR0A8O4k7o+TAFHUsnWBpbGk3WynEjpvOWJiSrUQaMudppSSSMIFty
	7bKJ8/2wTVdz9GFD3M6TIM5g9wg52EjUSpqkch/zu3qK42QLMIUr+vx0SluwHk7e9oIFcRwB9zTRt
	10eQykXocsDVNL/xEZFY4N33omhWrOZVqb74CzvxT6CVIXXX+RhHP8j22mnZgzWFXewO4QX/dbmkx
	tQ0Z5/RvW5EmB1KpwuPDxP7khrxBO/Pq/XCWSACK/8iQ+QGn8PQRn5Xl5BSDC73FuA3TnFQvabCn5
	Fh63sFCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8fMA-000000027ys-43vR;
	Fri, 03 Apr 2026 14:18:42 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8fM8-000000027yL-2vE7
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 14:18:42 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6334bMp9473627;
	Fri, 3 Apr 2026 14:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u4o+5x
	Qz4rBlXhhhaVbeSyCEljJvqzKGzcABXH9U2Ss=; b=cPoTp5cXxotZ2EImhK0AmD
	B1+mrQUjazLVY40Ju3LXE4bKGa5R+vWWn7A8lko+Q+JQT963ee3FXeTQd5WAzoNm
	vaXu7bPLrH1FjVt0CDR0aXvObxX6Rm8ehlfl11B9njduTJ0q5atE3c37feDFyY8d
	SeLz93iw2Jn25Fxi/6PhcFrWzNZuw6cqV0NZGQDt9DdlFrqjnxjnaLApLJGojVim
	mLMSvHLTy643neTdLFp53tRoYiXvjzXBsc2XkzyecPSTgIOKUT+kGjhdZMBJ4WSN
	i7w3LkOCbew7Fpu6TP4I3D8YQzcS/szhnX8rPF2YMsjGpIdbWSfB/Ymh9iLppteA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dh07em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 14:18:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6339F0Cs030947;
	Fri, 3 Apr 2026 14:18:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk6708-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 14:18:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 633EIZs931785258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Apr 2026 14:18:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41A8920043;
	Fri,  3 Apr 2026 14:18:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F59F20040;
	Fri,  3 Apr 2026 14:18:32 +0000 (GMT)
Received: from [9.124.211.65] (unknown [9.124.211.65])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Apr 2026 14:18:32 +0000 (GMT)
Message-ID: <972b9a73-d066-4a38-8a4b-fe7d1ba2944b@linux.ibm.com>
Date: Fri, 3 Apr 2026 19:48:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash_dump: Fix potential double free and UAF of
 keys_header
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260403100126.1468200-1-coxu@redhat.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260403100126.1468200-1-coxu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEyNyBTYWx0ZWRfX5e3hD65KjPE8
 75KPQnF5RscaI0G98tuekDhtVJ7d8CjBopwmFeqTRoseeaSSo4QQat+GTdN6LxpSB+MtuS8etk0
 MLJVEfivV2tRSL3+E9awafsZfL/fIP8hb84ORKo9ANPBBBkQcMg6Nui/Pj/Uqol/4L4bycsRvjL
 p+Z2Eg0MXnAp8pArivvTu9NkO82ZS/0ibO1uuwYK6MqtYFKexLurk2QVbT8H1D/hZQuedrMnWG3
 J909VpewUoOIe7kJ9Y1o0RgflC2PUaIkXxjUKI99iWgiuunLJTxIZmcc6bGw4iD8rD0zqfro2qZ
 XrOOHAbeb0W9DqVGTJtOpkY6eF1R62inOCcCRJElss0WmYlHHUBeGYz8n0wMRREJWGH3xdoWzIX
 8swzIQXYZEef7fddAApzNoIyKlKlMLvFsI8lyS+D35WtxVuAG9mAXeFEFKC0X0+WCHl7L/RRj+c
 uf+IPl3T2jl95VjL0BQ==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cfcc3d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=VnNF1IyMAAAA:8
 a=LspaYCeSQ2Tinx22wy8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: Asdp7Dmj9Ch6BF2KJMHwrnzxu_0HgNcH
X-Proofpoint-ORIG-GUID: Asdp7Dmj9Ch6BF2KJMHwrnzxu_0HgNcH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_071840_854847_8DA312A0 
X-CRM114-Status: GOOD (  27.92  )
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

Hello Coiby,

On 03/04/26 15:31, Coiby Xu wrote:
> If kexec_add_buffer fails, keys_header will be freed. And depending on
> /sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
> following two problems if the kexec_file_load syscall is called again,
>    1. Double free of keys_header if reuse=false
>    2. UAF of keys_header if reuse=true
>
> Address these problems by setting keys_header to NULL after freeing
> kbuf.buffer and re-building keys_header when necessary respectively.
>
> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
> Cc: stable@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>   kernel/crash_dump_dm_crypt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index a20d4097744a..92eebef27156 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -417,7 +417,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   		return -ENOENT;
>   	}
>   
> -	if (!is_dm_key_reused) {
> +	if (!is_dm_key_reused || !keys_header) {
>   		image->dm_crypt_keys_addr = 0;
>   		r = build_keys_header();
>   		if (r)
> @@ -433,6 +433,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   	r = kexec_add_buffer(&kbuf);
>   	if (r) {
>   		kvfree((void *)kbuf.buffer);
> +		keys_header = NULL;
>   		return r;
>   	}
>   	image->dm_crypt_keys_addr = kbuf.mem;
>
> base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d

Sashiko raised seven concerns on this patch. Most of them are
not directly related to the changes introduced here, but I
think they can be addressed along with this fix.

https://sashiko.dev/#/patchset/20260403100126.1468200-1-coxu%40redhat.com


1. build_keys_header() does not release key_header memory on
    error. This can cause incorrect keys to be loaded for the
    kdump kernel in subsequent system calls.

Can be addressed by releasing keys_header on error path.

2–3. get_keys_header_size() uses key_count to find the size of
key_header buffer, which can lead to out-of-bounds access
at two places.
   a. Around kexec_add_buffer()
   b. In build_keys_header()

I think there is one more place where this applies is:
   c. In get_keys_from_kdump_reserved_memory() at memcpy

I agree with solution provided by Sashiko of using keys_header->total_keys
instead.

4. get_keys_from_kdump_reserved_memory() may run into issues
    if kexec_crash_image->dm_crypt_keys_addr is larger than a
    page size during memcpy. Because kmap_local_page only maps
    one page.

How about moving this in a loop and do map and copy page by page?

5. Related to releasing the keyring_ref reference count, but
    I did not fully understand this concern.

6. restore_dm_crypt_keys_to_thread_keyring() does not release
    previously allocated keys_header, leading to a memory leak.

As per kdump.rst, restore was introduced to handle CPU and
memory hotplug cases. Is it needed when there is no in-kernel
update to the kdump image on CPU or memory hotplug events?

But in that case, we rely on a udev rule to reload the kdump image
again.

I am confused about when exactly we need to restore.


7. Possible memory leak and data races due to concurrent kexec loads.

I think we can ignore this because both kexec system calls are protected
by the same lock.

I also noticed that kdump.rst still says CONFIG_CRASH_DM_CRYPT is
only supported on x86_64 for now. With the patch series below,
this needs to change, right?
https://lore.kernel.org/all/20260225060347.718905-1-coxu@redhat.com/

- Sourabh Jain





