Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5758C3ABC3
	for <kexec@archiver.kernel.org>; Mon, 12 May 2025 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bsRyGKaV8sRJpQq5Zc/i6T71Ud1O1WM0d3J8aE2ryTI=; b=E0Vad/SWO76BRnz42L8tiyS8fH
	/1rhOc2u6sru89Crf1iCMqgpmXOMLcjQC0TJjmceZyIWqeDF1u6fj5t6+z4T7eHd6nXOX/5UPMTKm
	x++OfW3qR3/nlUeiIovAJCNUV7itVphh/WfH6qsNxYwYioNOHufQsikPdgr3yKq2YrVnqknM2i76o
	wLf3ySbF+H8TQKJ6hInrqLEaXgmyjO0f+xDUVNJQjbN3l03L6EQwGcgeccStnbZbGreRahB8wIUpA
	K2HNfOcIdnzcKGnaMQ8x6LhQSPMLEn/6ovjUKVlGDJZj+dyBvgD9ahOa1pyKGZHlShUfqTQr2KTfw
	Auikkn9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEUXN-00000009nxW-3s8u;
	Mon, 12 May 2025 14:53:49 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEU3z-00000009ht9-4533
	for kexec@lists.infradead.org;
	Mon, 12 May 2025 14:23:29 +0000
Received: from [100.70.33.9] (unknown [172.200.70.35])
	by linux.microsoft.com (Postfix) with ESMTPSA id 10728211D8CE;
	Mon, 12 May 2025 07:23:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 10728211D8CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747059806;
	bh=bsRyGKaV8sRJpQq5Zc/i6T71Ud1O1WM0d3J8aE2ryTI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=bxaNLGZnaWOn4pztP7LAHZSNR6oUEN7p2ff6LADZBG2eyd8ca5OtAL4bBgiy7h0zV
	 o0LSARw9BkeXDHj54jQFDmAFSN++gqBUtXl0OyphrZ2NCOPZFaa8xaxWamWb7kAK6y
	 SgS/N+JEflqT9Sb9poZ36Zz2ugSIGn+JBFtvNyEM=
Message-ID: <c0dcf292-4c43-4e87-8016-34194f2bddb4@linux.microsoft.com>
Date: Mon, 12 May 2025 07:23:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: Kdump kernel doesn't need IMA to do integrity
 measurement
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com
References: <20250502200337.6293-1-chenste@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250502200337.6293-1-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250512_072328_037053_4BDB126A 
X-CRM114-Status: GOOD (  15.09  )
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

On 5/2/2025 1:03 PM, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
>
> Kdump kernel doesn't need IMA to do integrity measurement.
> Hence the measurement list in 1st kernel doesn't need to be copied to
> kdump kenrel.
>
> Here skip allocating buffer for measurement list copying if loading
> kdump kernel. Then there won't be the later handling related to
> ima_kexec_buffer.
>
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> ---
>   security/integrity/ima/ima_kexec.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 38cb2500f4c3..7362f68f2d8b 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -146,6 +146,9 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	void *kexec_buffer = NULL;
>   	int ret;
>   
> +	if (image->type == KEXEC_TYPE_CRASH)
> +		return;
> +
>   	/*
>   	 * Reserve extra memory for measurements added during kexec.
>   	 */

Hi Baoquan,

Could you tell me when will you have time to validate kdump scenario 
using this patch?

This patch is based on the next-integrity branch of 
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/

Thanks,

Steven


