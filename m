Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E378C369D9
	for <kexec@archiver.kernel.org>; Thu, 24 Apr 2025 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=74cZhWXIm6DNK3Mg2kUV74aTfyWRc7iRAWJvXq6yXtI=; b=buSNQF0EIG1dIaIkUm9BzUwkuK
	42CdZPNGugfehyU+rq7KGdchomHp7yIeFaQWVh0mbJ5rwGYT4BOwGSnSKqKHe6hAOqA7g2Kd3Tq0e
	z7r8ah80ZoBxOCH2BdBrsq9ChCDiuXk91yC1uDYy4XDtHONkkQtbrAe2/UX1Pl7v+DBVHwNWy33yH
	qQwkPam26L94o3+4K132baOQpR3N0VC23j97JV4yQtnqivVrRmR//DSPSCre9lSEd44lerUZBRiJO
	W3JyT6Y3+9zKxIgcrhaEhwd9ItA1f4F3wgim4fKR6GtcbY9UOWh9h2k6zukT6LyoxupJjrzFii9OK
	dHvBXiQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u82yM-0000000FIeb-49ks;
	Thu, 24 Apr 2025 20:15:02 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u82Dw-0000000FC3M-0wvD
	for kexec@lists.infradead.org;
	Thu, 24 Apr 2025 19:27:05 +0000
Received: from [100.70.202.48] (unknown [172.200.70.35])
	by linux.microsoft.com (Postfix) with ESMTPSA id C9726211308C;
	Thu, 24 Apr 2025 12:26:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9726211308C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745522821;
	bh=74cZhWXIm6DNK3Mg2kUV74aTfyWRc7iRAWJvXq6yXtI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iCwNa1PwnNR0onB/ijUlvcweRa6CXTmWKW14JsO29ycskZ7nGodrZpYFyGzH9k9V4
	 Sdk8+5Ymip2FoMrWkmBxEIDODYBWY+4iSWanqiEWUPN4Atf0HypxCtZ5KUIiX4oTmi
	 88xcyWJpxjt5nND9W+FXauji5KZmGss+dee/xv9Y=
Message-ID: <8909e6a6-4f3a-49a7-a3fe-f6ab9d925aaf@linux.microsoft.com>
Date: Thu, 24 Apr 2025 12:26:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/9] ima: kexec: measure events between kexec load and
 execute
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
 <aApMnEl1Xzarmimn@fedora>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <aApMnEl1Xzarmimn@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_122704_298616_C02B18DB 
X-CRM114-Status: GOOD (  15.77  )
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

On 4/24/2025 7:37 AM, Baoquan He wrote:
> Hi Steven,
>
> Could you test below code and post a formal patch to not copy
> measurement list buffer to kdump kernel? Below log is just for your
> reference, please feel free to modify or rephrase.
>
> ===
> Kdump kernel doesn't need IMA to do integrity measurement.
> Hence the measurement list in 1st kernel doesn't need to be copied to
> kdump kenrel.
>
> Here skip allocating buffer for measurement list copying if loading
> kdump kernel. Then there won't be the later handling related to
> ima_kexec_buffer.
> ===
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

I will work on it and I will post a patch after this patch set merged.

Thanks,

Steven


