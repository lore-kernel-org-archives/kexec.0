Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D8DCD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 14:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fQcvAdzI+8RrB6IxWgEKY5lEAzeqP1wLMtFJ8Pc+1Bg=; b=HMvn8yRsmh2H+MGcAbGm3yHkCU
	b4IJwAvp0TiCe95AfOsRt/PgR3snLbGdg/Pd9NBYKg4Yu4SZAJCbBTOoqVgs5Z6MustfOX2rR1osQ
	Uqk8N40wHXnbmKM89Z2euGkvV3a6dYsukUF9k4zhWy3UJ0ASOEoRFVkiDenIulvE7fUdq5SovVLF+
	2eDDGP0d1sMDVPqa1uG67vcKSCHmUbXHyEMT9u+rwEVXrrmpIu6egat595JBaWk+DYeIWypKs++IW
	UB7QeHheVpgPDdjTNUvksRBojm4e5BaJqAhY4GaHB9XjM5VpPpMKco59Nh9muT2W9Z6/+yVZo8cqu
	OwsFJiIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKd56-000000013Dq-0Io2;
	Wed, 06 May 2026 14:18:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKd55-000000013DU-0pYH
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 14:18:31 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6466QG4h1531488;
	Wed, 6 May 2026 14:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fQcvAd
	zI+8RrB6IxWgEKY5lEAzeqP1wLMtFJ8Pc+1Bg=; b=N9OFoh8XpVqo69zkDnOHUN
	W92atgB8BK7U0bx4H1g5zAt+9D1NeCPqwGzsPK7nsTloWONc07bSsgZTtajNt6nr
	oJYBRwIszTENpLhcntu4QINftzDPDEH83ZOWEJ9ydOkhBE4O8/7KayUttluefzWP
	k4v9DmNqed7nlf1vr0edOwYXwoZsS6VgKJVt3zIs6vU4m9JXQkTC1ghggz/PjPsV
	jrz1X6tLU8WRLyt9lDBRH2tIWGyH9Taun/9RCphhcoSCT3GpGnoKwIeRjU03ZGwQ
	hC/h/Gjs7+vbB5BhplXaZzQakjMz8kk4g1pvZZ7z3UEM/y5zoMyXjy44KSQYDe+w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4s1v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:18:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646E9VMm007278;
	Wed, 6 May 2026 14:18:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgecw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:18:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646EI5H531916536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 14:18:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE8B020043;
	Wed,  6 May 2026 14:18:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D99C20040;
	Wed,  6 May 2026 14:18:02 +0000 (GMT)
Received: from [9.124.208.31] (unknown [9.124.208.31])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 14:18:01 +0000 (GMT)
Message-ID: <0e2328f1-a057-45d5-8889-c5c333826b45@linux.ibm.com>
Date: Wed, 6 May 2026 19:48:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] crash_dump: Read the number of dm-crypt keys from
 reserved memory
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>, Coiby Xu <coxu@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
 <20260501234342.2518281-5-coiby.xu@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260501234342.2518281-5-coiby.xu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzOSBTYWx0ZWRfX9y0MwTyLjfiV
 xNyIF4eTe4WHuiJxc60K608meVTSm6aKPwh8mvxeRc9pP9lwGzDTDnL1EObM8kJSkKb+xCU0itY
 QXAy8Slzjo9+gsAgzFg7F3CHNsmAAQhwJaeh7nssiBUdjd32rPkP+p4OhJ2hUaHqm1t+GR5LldV
 EP2hYyqQUiO5d8sd5eXqCRLWnQCm0Er0khwJR3P8P9NroKKq/72cPUPWJig1xqaKxVC083UnAct
 /f/jQoiHcvExbFGv6PXv316JynRySCbSw0LDEgb4sD1T69oL8XA6kR0wnsQmcTgR7XrABN4+/t6
 9nDaYfSBoEwxIMCMmMU0fU4ggpePwYsWzYbpgKlNgOFYgX49NJ7k9HTbA0FvFkgnMQDHOeIW74s
 Z8s/frQLHMNzt2JLpxDKM3DHj/ORycx3t+d40GIf8YqgzmuxFD2NACdWdthBDUn5z0+3fIFbjfa
 uVmsRoFPGdJuQEVoeuA==
X-Proofpoint-ORIG-GUID: jBeBQxKUNSjzFUkYS9XDntMgoZ2jlYD-
X-Proofpoint-GUID: Gh7Gu9yIkmJfJgfDLU3OiIIsCkREUkv4
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fb4da0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=4dglYSz4F3maezcncv4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060139
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_071831_252330_F0C4CB5E 
X-CRM114-Status: GOOD (  21.71  )
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



On 02/05/26 05:13, Coiby Xu wrote:
> In case user adds/deletes the keys by mistake, it's safer to read the
> number of keys from reserved memory.
>
> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
> Reported-and-Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>   kernel/crash_dump_dm_crypt.c | 36 +++++++++++++++++++++++-------------
>   1 file changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 6377ee86ec50..a3e460714d23 100644
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

Yes it is good to do a sanity check before using it.

- Sourabh Jain

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
> @@ -431,12 +441,12 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   
>   	mutex_lock(&config_keys_subsys.su_mutex);
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
> @@ -447,7 +457,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   	 * cleaned up at the end of kexec_file_load syscall
>   	 */
>   	kbuf.buffer = keys_header;
> -	kbuf.bufsz = get_keys_header_size(key_count);
> +	kbuf.bufsz = get_keys_header_size(keys_header->total_keys);
>   
>   	kbuf.memsz = kbuf.bufsz;
>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;


