Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E149C55ABA
	for <kexec@archiver.kernel.org>; Wed,  5 Aug 2026 11:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=coIaa6TvL8EuajtVr36u+a/klk7WQoffmI40iLsOVl4=; b=J76TOetj39Og9JT1Ypv8dVn4e5
	Qy3wfdIN8Qh6TtkcdYWddvyIOPDQnif5HTI9m5mZBvZlNB6lriQo/w7c2WXG+f9lnfHqsM6F6VuqN
	TX1Bj1rXzWnvBL2CwU6SZ9Rhw4cHAAHed5C5sNrPwLhTBIzC9DaJAC2DPcqeZL+fw3gIb62qwc0a4
	VTkEcEIOgER8SFJaPcWLS4IsJtpvHt/vm/ysY92avOoEqx83vRqDfakHIPGRvwsCEmfmpVToeGuTc
	enMl5Tl4uTUwRa79vthRJVHpdOUnwwKSsRYRK3fcCMWy9NVjsADFBBLCjANdqZtcl98wNxd2KAkqT
	kLaRpKDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrZRm-00000003mnS-2wqI;
	Wed, 05 Aug 2026 11:06:06 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrZRk-00000003mn5-1NEu
	for kexec@lists.infradead.org;
	Wed, 05 Aug 2026 11:06:05 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758laOB3354434;
	Wed, 5 Aug 2026 11:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=coIaa6
	TvL8EuajtVr36u+a/klk7WQoffmI40iLsOVl4=; b=CcVA72x28/q3hTjYmZiXEU
	AnOBRTK9OtIhXlwTZ+lrK6bWHrFrVhZuZSfCezmRmBzTD8ZnGKKU3fVG0jVxtZGf
	JN/UapLWmJT6/2KWZX3gOC7n+sd0O1Kh13zn85plDtKzMX0fXgRyacltZ00CSlPk
	+YX+yYMSR2bybdH1bxpKbCWsZYVHIEHkAA9QT3FJnL6+If9cshvKledGQVI3hl8E
	ZqHINCDdb3p/kdJ5C79LgSeTQ1HOlEO0yKZqeeFuZsmkBeoAydrFAfRAvFwe2NuM
	WfXzadW+BuQi5pL5pP0zkt0yCaE6LwivBg15foZWA0UDjnqeh8Xm+11q24z6ijAw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42nk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AfmBQ006377;
	Wed, 5 Aug 2026 11:05:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k66td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675B5t8S29032790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:05:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD8B320043;
	Wed,  5 Aug 2026 11:05:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66A712004B;
	Wed,  5 Aug 2026 11:05:52 +0000 (GMT)
Received: from [9.39.28.63] (unknown [9.39.28.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:05:52 +0000 (GMT)
Message-ID: <cf03f9c1-5970-4d65-9c4f-6b4fb12ccecf@linux.ibm.com>
Date: Wed, 5 Aug 2026 16:35:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] crash_dump: Read the number of dm-crypt keys
 from reserved memory
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, Coiby Xu <coxu@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-5-coiby.xu@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260729033654.311541-5-coiby.xu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a731917 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=blxvhoU7FtSDfcgUXAQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Sm5LDhbBfCNaCJxfOJIE0Pt3ft_2T5bS
X-Proofpoint-GUID: 5OFbmY6YnuKzQqT_0xGaJiDd8fRcFIkl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX2laoN3HAV5Qa
 PDUBs+WGLKJcFwjhQiDfZ7SZwztWwaWjIie43h62cJaeJ3YHWar7qhaNw+ArkhH0dRK6uK3dWJs
 kxzl5cTtkC0XxGVIpMkCoJMHbb5SbJU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX6QTMJ2Ujtj9n
 NkyUZxqnzZfeElq7UQfAOzkMbgsCpHpc9v03mpKKl8fK34N+WgdU6E6EW3eV5W79f9o3E5HS5tU
 zpv2ZaoJbecyTbmahLZfLVJYuWlUv1suWjqs7CmPPH1I3Qc4RTHL9iIqMKWIi9kvP8pd53w90D6
 m3+UBQEe5EhVhCeiT9XnnTZdoYgBmUB4y3uS0s6ooLWBteIsHEYytncxw70uAULkyYmuawvnKsV
 lG09prEE8QJBA7YBDN2X6q9skGeKa3Id6T6HHF9mtct2i4R/78OuLpsdZk99NbsXtAohox9wdrO
 aXoN6oiy6+nMqHs5esa4+6XXLLcAwI/C+seyN7fwA7ppnjFF0/U2q3HiVF/wnNUw9I0TWuakff0
 JmZvC2bYdnVrZ+PMeSl4xw9pTpkMlLpiCupy1b8t85eR5H/J4GPodCS89hV8uN7p/yGXHqtF47X
 8lJv38cqh1bd43dwD0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_040604_380951_4BB628B3 
X-CRM114-Status: GOOD (  27.19  )
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

Hi Coiby,

On 29/07/26 09:06, Coiby Xu wrote:
> In case user adds/deletes the keys by mistake, it's safer to read the
> number of keys from reserved memory.

I am not sure how we differentiate between a key being deleted 
accidentally and a user
intentionally deleting it. However, I have a question about how the 
kernel handles key
addition and removal.

How does the kernel handle key add/remove operations to keep the kexec 
segment
corresponding to the key header up to date?

The reason I am asking is to understand what happens when a user deletes 
a key. Does the
kexec segment corresponding to that key header still retain information 
about the deleted key?

If it does, could you explain why? If it does not, could you explain how 
the kexec segment gets updated?

Also, for my understanding, could you please point me to what exactly is 
stored in the key header's kexec
segment? During restore, kernel access the old kernel memory using the 
information stored in that kexec
segment, so I would like to better understand what data it contains.

Thanks,
Sourabh Jain



>
> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
> Reported-and-Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>   kernel/crash_dump_dm_crypt.c | 36 +++++++++++++++++++++++-------------
>   1 file changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index d2e66c6fe6f3..a3996208738b 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -88,21 +88,31 @@ static int get_keys_from_kdump_reserved_memory(void)
>   {
>   	struct keys_header *keys_header_loaded;
>   	size_t keys_header_size;
> -
> -	keys_header_size = get_keys_header_size(key_count);
> -	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
> -	if (!keys_header)
> -		return -ENOMEM;
> +	int r = 0;
>   
>   	arch_kexec_unprotect_crashkres();
>   	keys_header_loaded = kmap_local_page(pfn_to_page(
>   		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
>   
> +	if (keys_header_loaded->total_keys <= 0 ||
> +	    keys_header_loaded->total_keys > KEY_NUM_MAX) {
> +		pr_warn("keys_header saved to reserved memory may be corrupt\n");
> +		r = -EINVAL;
> +		goto kunmap;
> +	}
> +
> +	keys_header_size = get_keys_header_size(keys_header_loaded->total_keys);
> +	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
> +	if (!keys_header) {
> +		r = -ENOMEM;
> +		goto kunmap;
> +	}
> +
>   	memcpy(keys_header, keys_header_loaded, keys_header_size);
> +kunmap:
>   	kunmap_local(keys_header_loaded);
>   	arch_kexec_protect_crashkres();
> -
> -	return 0;
> +	return r;
>   }
>   
>   static int restore_dm_crypt_keys_to_thread_keyring(void)
> @@ -446,12 +456,12 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   	mutex_lock(&config_keys_subsys.su_mutex);
>   	mutex_acquired = true;
>   
> -	if (key_count <= 0) {
> -		kexec_dprintk("No dm-crypt keys\n");
> -		return 0;
> -	}
> -
>   	if (!is_dm_key_reused) {
> +		if (key_count <= 0) {
> +			kexec_dprintk("No dm-crypt keys\n");
> +			return 0;
> +		}
> +
>   		r = build_keys_header();
>   		if (r)
>   			goto out;
> @@ -462,7 +472,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   	 * cleaned up at the end of kexec_file_load syscall
>   	 */
>   	kbuf.buffer = keys_header;
> -	kbuf.bufsz = get_keys_header_size(key_count);
> +	kbuf.bufsz = get_keys_header_size(keys_header->total_keys);
>   
>   	kbuf.memsz = kbuf.bufsz;
>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;


