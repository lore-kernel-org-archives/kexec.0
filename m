Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD59C61DB9
	for <kexec@archiver.kernel.org>; Sun, 30 Aug 2026 07:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rSNJLfP2ClgRhLq+3tQST1sdUV0Ru6nvhs393Hlua0Q=; b=clh/sl5BCnFepi/9nW/l2wIaDq
	zt4PBI+DcF6qw3/1i3+HOFak3rOtNK/a3XtTE+R9fYrPeN9LTEOMiVReKt/0vFYGzf5J0x51SRY5K
	YPsrZVktcoVyamOnNl3+0MVgE/U5OQ6GwLIV7Jg8hMc0ejeaDbDVd3IvmdK41ux2lA0x/RSTcV7ed
	FATdSa77AafZgKYcwG+mnBhj7x+S2HOGflLkIk9PNUXvxEiR2Kn7miXQ3gfC+lZX7WURTYWi/BIQH
	LiqxUl3h8UXsT0xp75cU35dZW7etI58CGyn/mgpjSPp3eHtC6CisCpXr9dIu35e6yscB9hr2ome3M
	2ph9kiwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0Zpf-00000007XXo-0WG3;
	Sun, 30 Aug 2026 07:19:59 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0Zpc-00000007XXU-3wVH
	for kexec@lists.infradead.org;
	Sun, 30 Aug 2026 07:19:58 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67U61k0f2811220;
	Sun, 30 Aug 2026 07:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rSNJLf
	P2ClgRhLq+3tQST1sdUV0Ru6nvhs393Hlua0Q=; b=CKElfzHa5pLQec2MrRwn1x
	1GcyRlJwT40rtBlVKSDODF/VZq+FtsiWofndyQJ76Fcepsu5mdk9L8psqlCNp0OJ
	0Cn/ZWNQ4sUYj8PuxF4raWzhTLQco9mCx1WpJm5VG03woPQnz6Fxc64pUpbvfg5x
	qKEzuVhzIwf2ywelGZ7TAIX66pYEM8ISwTWHZ9eWMCx8r0XDk0ZyQuuTja+yoJnI
	sagBafKwlMp/5/aRXdYUgATn8XiaqoW/459F+Y0G7oZEKpwGcq383c5dhPueI8Uz
	Dk10/MyVHNQIzfyxXpwxNRmlwhus8fmhsx6tpuny24kuNg6W7rKQse35jISkIGXQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54btg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Aug 2026 07:19:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67U7Bcxc002833;
	Sun, 30 Aug 2026 07:19:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg0h51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Aug 2026 07:19:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67U7JmK749021348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Aug 2026 07:19:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5629820043;
	Sun, 30 Aug 2026 07:19:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48D0520040;
	Sun, 30 Aug 2026 07:19:44 +0000 (GMT)
Received: from [9.67.21.115] (unknown [9.67.21.115])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 30 Aug 2026 07:19:43 +0000 (GMT)
Message-ID: <859d4e5f-c491-4a0d-a7ea-0a16159f8059@linux.ibm.com>
Date: Sun, 30 Aug 2026 12:49:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] crash_dump: Read the number of dm-crypt keys from
 reserved memory
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
 <20260828084900.1496839-4-coiby.xu@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260828084900.1496839-4-coiby.xu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMwMDA1NyBTYWx0ZWRfXz0YCPV3lv4UH
 IKPVHBjyBSjCZ8z1zEPIUytpYYoRUYERlcTq53Nn25cvPIOTKJb32Uz1seTvF3Xih0mZn0Ypi0R
 xwEim4UWU3p15F6U1HJ4QxiaHFqoRGT6u320g61I/XRgr/UvylhxxYeM4eHjm6MqLybhT76A8oA
 o77SVF2u/Fda3YI+GJ1hnoHBebDNBHnlY6kU6ilY4WEQYdoLntwOC5gP5SmXMlwHBuGfFy0/8rw
 qMjIS9S3jwarM4cIPMzL2QXkJDqZQGha5liRYVM5eGayKhZ4xCk42gGb4QhX57ghiZVH1JBw7fa
 34IZoB7h38LbBqLR+djaVJniSNyV4ZKfyo3QzT9uYwz6JUayWfQopYwMARuODa+DO2Sh98BzBhB
 lPHOa6PLoFwDNuilrj+PcSb8wlN5Jqr1TDDB+HyuvsTPzIg1sb6n///LnD3XlnTPvcVl41gKzZs
 BaAiMQ34iOlndBwJl3g==
X-Proofpoint-ORIG-GUID: k9DhWxakAY-W5qahI_4Jaf_-Q66rmif0
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a93d997 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=Ih1Uonz5PMveX798KfkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: alrdb3oKMqCcAx18RzoTSmqYnLLTBoJ4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMwMDA1NyBTYWx0ZWRfXy9hJ7ZIDxolJ
 XJXU5HxIIUx156q2RhO8U5NA2PjZ96exStXNOPweczKNJxf4L/99JjMQEOIddusSxQAEujLB6J+
 kE+OVVf3pivNi0GRO34rIEMxLd9J34U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-30_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608300057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_001956_993741_A0BDF5DA 
X-CRM114-Status: GOOD (  21.38  )
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



On 28/08/26 14:18, Coiby Xu wrote:
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
> index 026c7de4ad85..0b9e09c60745 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -89,21 +89,31 @@ static int get_keys_from_kdump_reserved_memory(void)
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
> @@ -447,12 +457,12 @@ int crash_load_dm_crypt_keys(struct kimage *image)
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

Not directly related to this patch, but I have a query.

Do we really need to take config_keys_subsys.su_mutex when keys are
reused? If not, how about moving the acquisition and release of
config_keys_subsys.su_mutex into build_keys_header()?


- Sourabh Jain
>   		r = build_keys_header();
>   		if (r)
>   			goto out;
> @@ -463,7 +473,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   	 * cleaned up at the end of kexec_file_load syscall
>   	 */
>   	kbuf.buffer = keys_header;
> -	kbuf.bufsz = get_keys_header_size(key_count);
> +	kbuf.bufsz = get_keys_header_size(keys_header->total_keys);
>   
>   	kbuf.memsz = kbuf.bufsz;
>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;


