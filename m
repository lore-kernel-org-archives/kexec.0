Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9BFC3ABAA
	for <kexec@archiver.kernel.org>; Fri,  2 May 2025 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QKq6LqM0pEX95ODNBXEkqdtsxLl41A0R2DmDPU6S99M=; b=OxpTM9Og39wIjKNlPPyN9XMsT2
	FypCqEx/PDqgXF5kWKz7HDTWX6tAzn1zDH8f6mcVOIOzDIGVFdzJ7fXQty2wgKxJU4rWyG+t/JiGC
	N2pK/8+YBfy2YsbEWo9dx7Zs2d1sttlGWkCZSOi+piMFt/3xO2uTzgR+UppefDYYs4j2Tqg9CP4vq
	lhXU7MkqYOzlcLYOgvgnoc+qf7hxzpnke1o7GsmVy2IsnJTsySDMx301NYt4TD3Cmta91vIK53lOp
	4ouX57H36NE6vMid6rRgPlJq9s8ZHyXEe5u10MBr6PRnd9zcMaV3pY1BqvPBrfPeJuMhjnaerdSfK
	3qbxPFUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAu6F-00000002dlU-12Fq;
	Fri, 02 May 2025 17:22:59 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAtCX-00000002VBF-2T58
	for kexec@lists.infradead.org;
	Fri, 02 May 2025 16:25:26 +0000
Received: from [100.70.194.49] (unknown [172.172.34.12])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8F15E2038A5C;
	Fri,  2 May 2025 09:25:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8F15E2038A5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746203122;
	bh=QKq6LqM0pEX95ODNBXEkqdtsxLl41A0R2DmDPU6S99M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ID4wW6akUmsu1eI4m/k7RRlTytYoBIZShSAOY+6ZSHApFoZsG3WsqP0+cO4iAaqDL
	 3CvJWrgfBs1ABDVOR854Wx0UJmDlMoHWgeXaaQpU3zY5ERO2PyZLiIdVNbfHtq/Hkb
	 gaKrfZMN+AGUkSa7QmtuFlqh9t/L4H00IJhDRqBQ=
Message-ID: <7337e27f-cc54-4c51-91d8-11d875baee49@linux.microsoft.com>
Date: Fri, 2 May 2025 09:25:19 -0700
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
X-CRM114-CacheID: sfid-20250502_092525_662566_8D67FC63 
X-CRM114-Status: GOOD (  16.90  )
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
>
Hi Baoquan,

I tested the kernel with above change. Normal soft reboot works fine.

I will post the patch for review.

Please make sure to test KDump scenario.

Thanks,

Steven


