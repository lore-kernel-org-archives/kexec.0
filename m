Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122E9C2BB3F
	for <kexec@archiver.kernel.org>; Wed, 15 Nov 2023 19:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=04fh8Paju7HYoTL4T7emTJnzkSxQnhVASx9fo11WHwY=; b=RJ7/z/C6jwOm2+
	kQSGKK5DqckjNYVqC3DobNBJAVRcb4VxDgm60oyy7KmC2AcbsyTqORftGZWRHxP6vOFxN6s+1e46k
	PfMFKXC+ZNhn3oj6hNkbHQbsOCijIwUaoko21rgs/Bjh9c76J99h0nlXD8RdRR4GqSKM4RoRGWMR2
	tSiYBnGGPWDMHsLC0kQxGpMPimuyG5gw+ilZo7lkv2oUXFjpE3dEYyPPdnG7PxFkMHf9ZQQ2ACk+M
	oll221z0i4Pxbt2FhS8onKv8Unt2MVsLpfiKtnuocTWn53TGM7so/Rs6SXsvab/KwBw7VcJoew0t5
	b9eYSH+zBcPLHcRZvO6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3LSX-001Zw7-2P;
	Wed, 15 Nov 2023 19:21:57 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3LST-001ZvI-0A
	for kexec@lists.infradead.org;
	Wed, 15 Nov 2023 19:21:54 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2566A20B74C1;
	Wed, 15 Nov 2023 11:21:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2566A20B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700076109;
	bh=SaBUovaOZgPZmbXPH57FNEVFc+ljV6c65NGm0njD1cg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nZ6obCLJUSUBATwf80Ckn/zRTdXg8uJvglKGcSt85/6sEjSXcT6Gk4Buz7k6kwVLP
	 0g9jPAom16Gu/crQMF+BBpQk7sT6Qj59jDBGbCZ4L8+Tn7GfG0pGplpKc40LFTfj1v
	 Xpdw/iJmrljgwXIzNkMgIpajEUpQfauHM7gI8784=
Message-ID: <d7f7c59e-a71c-45b3-a125-78fd6cd31e3c@linux.microsoft.com>
Date: Wed, 15 Nov 2023 11:21:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] ima: kexec: measure events between kexec load and
 execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <8f87e7e4fe5c5a24cdc0d3e2267eeaf00825d1bb.camel@linux.ibm.com>
 <348e6e3ebd1c6ee1c85cd12f15591f32bb699fdc.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <348e6e3ebd1c6ee1c85cd12f15591f32bb699fdc.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_112153_168730_E80F6603 
X-CRM114-Status: UNSURE (   4.86  )
X-CRM114-Notice: Please train this message.
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 10/27/23 12:51, Mimi Zohar wrote:
> Does this patch set take into account kexec_calculate_store_digests(),
> which is called from kexec_load, and verify_sha256_digest()?
I am not yet sure if my patches will impact the
kexec_calculate_store_digests() and verify_sha256_digest()
functionality.

I will investigate further and get back to you as soon as possible.

Thanks for bringing this up Mimi.

~Tushar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
