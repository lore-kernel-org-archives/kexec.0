Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149A1C433EF
	for <kexec@archiver.kernel.org>; Mon, 20 Jun 2022 13:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gUB8sNrQZoGe7MAlbNd65twjmnQyViHmCVuy8BmMXYg=; b=ax9GZIUPlIvPkvGH2XaGdPZn5o
	chl/a8/Stfm9TcS9lm6/QhF9bVPLnhOYE70ly0ZUvN9ODM4GwVHqB6vTQ/DozAYuKmjA6rGdTspAo
	aCRYowEWdTKQ5NEc7KYVZLwoHK5/+BFIpnw0Epgap7EQC5oSv2aTYpFlm+tim4I+aV9quSZGIR7ok
	juQct9+WWFAUDo1pUe0fDfzn2HaAVsyqGj+CyrBwlQySv2inF0UEfMPi6KlKX9IiE0bVXAJIF90v3
	eHBo/XHUZnMYEipdg97eM5HZPpcZ95MCBRrHu/U2CLqoj3WoLfNqit5YIXZjf3cqq93iHkI1a1XwD
	BiTjeRMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3HQQ-000peq-9p; Mon, 20 Jun 2022 13:26:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3HG6-000kQk-JX
	for kexec@lists.infradead.org; Mon, 20 Jun 2022 13:16:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655730959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ncQr9LsCwAvRtNkynEUeHSlUPUh+xbH4xQyI+6gY25E=;
	b=H8Dr0quFPA71NNGpkUkCiUgSSFpXtIyFcMtBk7O+pkXd9NQvV7Z0qaqlg4UgnFvYlCp1YG
	qCAQrOhZ24FfEUxwgSOr8lstaaxlL3M2F6lNx6KdCs4rJC2HATm5GieLW9y8CKaA9WTRpl
	iNmJ7s7BFuK0mrgJpKCHlfMRkOBvsD4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-vZb-D6XBOF6JhQR5cjE4Fw-1; Mon, 20 Jun 2022 09:15:58 -0400
X-MC-Unique: vZb-D6XBOF6JhQR5cjE4Fw-1
Received: by mail-pl1-f199.google.com with SMTP id m17-20020a170902d19100b0016a0e65a433so4201748plb.8
        for <kexec@lists.infradead.org>; Mon, 20 Jun 2022 06:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ncQr9LsCwAvRtNkynEUeHSlUPUh+xbH4xQyI+6gY25E=;
        b=ivGkR4fGWRYQbULoLY8Y3bYzAkpXIzgzNy+nCAZqaDySpq5YDSdLzq5SF+omOCwAU8
         HEhIr2BzifzQmRiWYdmj+CTxhIlN50sW0VvC/YA1fSFvVbDXI8ZqUW1D9uG2w9ELnEQd
         t1KTEBcXun0IM+BOPfHM3A+2+vVCB4mgdBPWAnkHkQMKKOh++NFtXVrylm0Xhmc06/dv
         hSCS+aq/jaN/2/vsc/Ksy/lRZDrVEnGa3K32lLeNPcdlPRV9VQ40U/x1v5V2y5X6tkc2
         uvWuc4LJyrxAlITIVxUWdIryB9niv7ZCi5DCqIRlcx/ym3pkDDS2xAW+gAnI+rCxGN1m
         LvHg==
X-Gm-Message-State: AJIora/dyrmgXmVxcSHZu4TxdSLVum/dcbcjLWjo4h59GuRPP1MDq8e5
	mAc+AuIYUDPuQEahA9mR5KVjGWhIjnWty5JzMKffavS/d6k+YKDu/NhOLSiL01g4+ZzjlaayEFo
	bTFsph0XXLJpj8CgQAkLJ
X-Received: by 2002:a63:6e08:0:b0:40c:7557:c4aa with SMTP id j8-20020a636e08000000b0040c7557c4aamr11443472pgc.356.1655730957786;
        Mon, 20 Jun 2022 06:15:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tZnOGIEmpXjf4W8P84L+N3aI2UrxmRzitNw0xZKcxAiRTfAWfxlkVl3ezbAueoVHV1k7MOmA==
X-Received: by 2002:a63:6e08:0:b0:40c:7557:c4aa with SMTP id j8-20020a636e08000000b0040c7557c4aamr11443456pgc.356.1655730957482;
        Mon, 20 Jun 2022 06:15:57 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u24-20020a17090a891800b001e0c5da6a51sm4573562pjn.50.2022.06.20.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 06:15:56 -0700 (PDT)
Date: Mon, 20 Jun 2022 21:14:55 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	Michal Suchanek <msuchanek@suse.de>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Chun-Yi Lee <jlee@suse.com>
Subject: Re: [PATCH v8 0/4] use more system keyrings to verify arm64 and s390
 kexec kernel image signature
Message-ID: <20220620131455.lo2yzumr6ugmofuw@Rk>
References: <20220512070123.29486-1-coxu@redhat.com>
 <e382780002db9767671ca5a0213237f443243537.camel@linux.ibm.com>
 <20220525095957.vvref4yeaidd5iww@Rk>
 <d1a431e8cf69b3d892c118204705739a0ed907b7.camel@linux.ibm.com>
 <20220527134315.afnuszqbfqkpnxpv@Rk>
 <b3c87ce140b8d46659adcf07142e1d01ffbb2267.camel@linux.ibm.com>
 <20220616011506.ymbz2xuhw3refasw@Rk>
 <20220617035724.uyc7mp4n5gdlzta5@Rk>
 <dc23f46380e6fb218181e685ad2f0a1db34500fe.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <dc23f46380e6fb218181e685ad2f0a1db34500fe.camel@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_061602_797637_79B52CF7 
X-CRM114-Status: GOOD (  17.53  )
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

On Fri, Jun 17, 2022 at 07:58:37AM -0400, Mimi Zohar wrote:
>On Fri, 2022-06-17 at 11:57 +0800, Coiby Xu wrote:
>> >Thanks for explaining IMA to me! There is still the question of what's
>> >the root of trust for .builtin_trusted_keys when there is no real
>> >signature verification. For example, when CONFIG_KEXEC_SIG is enabled,
>> >the default IMA policy is to not appraise kexec image. Since lockdown is
>> >not enabled by default, there is no real verification as
>> >kimage_validate_signature succeeds even when kexec_image_verify_sig
>> >fails.
>>
>> I realize my reasoning is incorrect. Actually the signature
>> verification which establishes the trust on the keys happens in the
>> bootloader. So IMA appraisal or kimage_validate_signature is irrelevant
>> to the question of the root of trust of .builtin_trusted_key. For GRUB,
>> it won't verify the signature by default when secure boot is not enabled.
>> Thus the question of what's root of trust when there is no signature
>> verification is still valid.
>
>We're saying the same thing, just differently.  Your wording describes
>secure boot, how it is established, and who/what is responsible for it.
>I don't think those details are needed.  I originally said,

I think I'm addressing a different concern or case. If kexec_file_load is going
to verify a kernel image signature, what keys is it going to trust and why? I
believe explaining the root trust for different keyrings is to answer this
question. When a bootloader verifies a kernel image signature, the trust is
based on verification of the kernel image signature which we both agree. But
what if a bootloader doesn't do the verification? 

>
>.builtin_trusted_keys:
>
>For example,
>
>Keys may be built into the kernel during build or inserted into memory
>reserved for keys post build.  In both of these cases, trust is based
>on verification of the kernel image signature.  On a physical system in
>a secure boot environment, this trust is rooted in HW.
>
>The last line should have said, "For example, on a physical system in a
>...".
>
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
