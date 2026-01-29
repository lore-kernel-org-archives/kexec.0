Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3815DD358F6
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 10:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=asMYvR4+8fIWZ4M/HFcAyNsDPqE2Xel47V6LP6IGUhQ=; b=VBgFoNGzt9EclwWszUHzU8+YXZ
	ylBTHn94Wnp/ne3NDseXDC4IDX4VpxbXGjgmV122asZ6XMNHzOqRuADfRYMRRIdN3MYXzXZPUZ8+u
	rBQCAAKRnvmAoBRBr0hhjlLQ8KPGlC3Dpitr00LGYEFL2v7IkmzJyoxg0RzSgeoW24eGjwgEpFY+W
	QZlofdKS+f25Oq/Dj/4oBTv1wAusUxlVYdUscpJCkceONqQh4K4FfckBaK/uvQsTC2KwpldEskYeR
	e8zEJD3xR+yxXsXHRLCJ0pxectT9FBAFQ1rXD5yKLteweKqUOsd1/PayoC99sqod6HyWfBBkGp/+E
	DHdizgww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlPWr-000000000PL-1lf7;
	Thu, 29 Jan 2026 10:45:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlPWn-000000000OG-1Qgc
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 10:45:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769683528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=asMYvR4+8fIWZ4M/HFcAyNsDPqE2Xel47V6LP6IGUhQ=;
	b=PxbBmVCkBq7qenLF4pvlx+aSOr/cdjJkIqj36A8nc06m8l7MMTGWYS1KIrd1FDocxugPQt
	xS13ow5fd3Iu4lDzGf9v6O2T4H/jDLPIGK+yG/b368lPHEymlgxH6p1C4ewEfbLqQu5t+6
	kCw9qfhaT2YJs41ivXzuMwTpluaZspE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-3p1EFxwDPXO9imhcR57k_g-1; Thu, 29 Jan 2026 05:45:27 -0500
X-MC-Unique: 3p1EFxwDPXO9imhcR57k_g-1
X-Mimecast-MFC-AGG-ID: 3p1EFxwDPXO9imhcR57k_g_1769683526
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a7a98ba326so10597225ad.1
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 02:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769683526; x=1770288326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asMYvR4+8fIWZ4M/HFcAyNsDPqE2Xel47V6LP6IGUhQ=;
        b=KhdSBOWnUvFG5VBIe9IJgGeI4fKa/LS7NVT2u9dwk9XTq161TUDrmOouSnwhcbmR0S
         yVTmC0ioZNZd8Jjo1yNvFW173KiXkA/hBwMD5OZJOA+S4stIvV2qXmRB8g7d5J6ODuBI
         cSnX1C1tKeU79yImd1mHTuIFIszQZhHOi079R9vru41om6jk5JNWOGMAcVXPKb4LMs2o
         ZxWeHg0Xjqpm01fOOIqkryt3/9R33CeauakB+ph0ngPJxh3VxHCbWOniHcGa4abfdKg4
         2LuGGjS97G/ITGrCcUz9yJq81tCv/m7l1mNnY+2oGn7/WtUIa9E19p7a4xR05Rvpf+JL
         bHkQ==
X-Gm-Message-State: AOJu0YxaAq42SxyfxFWjTNs/s2o6qHSbRYGtOQCq7NkaehsK6/GhWKj5
	hkKG9G9i/4PQVVus76M0ra3/b5DqqYRJoXxUWaO8bsWxu1SJUY6s+josye3c0RLt9KHDNTCPqrH
	QehE99dByjYScCygpJ8ryAHbYnyTphpA1iJdBx8UnOvbR/QHCgnHE2/d/qVlcug==
X-Gm-Gg: AZuq6aIUA4L4IBrsbrqT01lIoip6LSGXnQ18r4621cjiHnDkp+PmLadvNFh7iUzfdkT
	vO/shvEKoQWT32zRU+FozDaxVL3e8gMXwppu2qIUkquTVrbjAZsfI4VQoTy4QyERQ2xl+yvW4eR
	mjq+zFlSkagNarbIWW/lB1gkGLiVKtMTgbg2us6i+gJNGGiZy1oYud8bOFsbDVD0HTqhRg86XAM
	2BkE22hYwlFiMaLXQaZRG8Kk+6HAUBYgb5vj8OsVVXretdi4TNgBmohAUjzHpRQRDlmPJYuM+Ju
	SGHsun3j8QK/WGEXnN2kBFVnb3mlfRCHCVicajvo2xJCXWLYEbPkg4ZXQkoJvtZy2JMsBnPsVsP
	4
X-Received: by 2002:a17:902:e743:b0:2a0:f0e5:74eb with SMTP id d9443c01a7336-2a8bd51481cmr28168195ad.28.1769683525948;
        Thu, 29 Jan 2026 02:45:25 -0800 (PST)
X-Received: by 2002:a17:902:e743:b0:2a0:f0e5:74eb with SMTP id d9443c01a7336-2a8bd51481cmr28167925ad.28.1769683525347;
        Thu, 29 Jan 2026 02:45:25 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b426ae4sm46205555ad.43.2026.01.29.02.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:45:24 -0800 (PST)
Date: Thu, 29 Jan 2026 18:40:23 +0800
From: Coiby Xu <coxu@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Rob Herring <robh@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Saravana Kannan <saravanak@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3] arm64/kdump: pass dm-crypt keys to kdump kernel
Message-ID: <aXs0UnFE1fEa8Yxu@Rk>
References: <20260123081326.1362666-1-coxu@redhat.com>
 <aXd72PcvvFsIFXO2@willie-the-truck>
MIME-Version: 1.0
In-Reply-To: <aXd72PcvvFsIFXO2@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FkSNc9oqS5RY3R3c12K1IQJgsmZcbwDM4eKGEzvQ4bc_1769683526
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_024533_458857_6927EE91 
X-CRM114-Status: GOOD (  27.09  )
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

On Mon, Jan 26, 2026 at 02:36:08PM +0000, Will Deacon wrote:
>On Fri, Jan 23, 2026 at 04:13:25PM +0800, Coiby Xu wrote:
>> CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
>> device dump target by addressing two challenges [1],
>>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>>    machines, a system administrator may not have a chance to enter the
>>    password to decrypt the device in kdump initramfs after the 1st kernel
>>    crashes
>>
>>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>>    which is quite memory-consuming compared to the limited memory reserved
>>    for kdump.
>>
>> To also enable this feature for ARM64, we only need to add device tree
>> property dmcryptkeys [2] as similar to elfcorehdr to pass the memory
>> address of the stored info of dm-crypt keys to the kdump kernel. Since
>> this property is only needed by the kdump kenrel, it won't be exposed to
>> user space.
>>
>> [1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
>> [2] https://github.com/devicetree-org/dt-schema/pull/181
>>
>> Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
>> Cc: Baoquan he <bhe@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: Kairui Song <ryncsn@gmail.com>
>> Cc: Pingfan Liu <kernelfans@gmail.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>> v3
>> - Delete the property after reading it [Rob Herring]
>>
>> v2
>> - Krzysztof
>>   - Use imperative mood for commit message
>>   - Add dt-schema ABI Documentation
>>     https://github.com/devicetree-org/dt-schema/pull/181
>> - Don't print dm-crypt keys address via pr_debug
>>
>>
>>  arch/arm64/kernel/machine_kexec_file.c |  9 +++++++++
>>  drivers/of/fdt.c                       | 21 +++++++++++++++++++++
>>  drivers/of/kexec.c                     | 19 +++++++++++++++++++
>>  3 files changed, 49 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>> index 410060ebd86d..5f3bad8ca96d 100644
>> --- a/arch/arm64/kernel/machine_kexec_file.c
>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>> @@ -134,6 +134,15 @@ int load_other_segments(struct kimage *image,
>>
>>  		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>>  			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
>> +
>> +		ret = crash_load_dm_crypt_keys(image);
>> +
>> +		if (ret == -ENOENT) {
>> +			kexec_dprintk("No dm crypt key to load\n");
>> +		} else if (ret) {
>> +			pr_err("Failed to load dm crypt keys\n");
>> +			goto out_err;
>> +		}
>
>This looks like an unusual mixture of kexec_dprintk() and pr_err().
>
>Stepping back a second, why do we need to print anything from the arch
>code at all? It looks like crash_load_dm_crypt_keys() already prints for
>the -ENOENT case so I'd be inclined just to do:
>
>	ret = crash_load_dm_crypt_keys(image);
>	if (ret)
>		goto out_err;
>
>Will
>

Hi Will,

Thanks for carefully reviewing the patch! Yeah, crash_load_dm_crypt_keys
already prints for the -ENOTENT case, good catch! And it's also a good
idea to not let the arch code print anything since
crash_load_dm_crypt_keys is a better place. I'll make
crash_load_dm_crypt_keys print more logs and also return 0 for the case
of -ENOENT. This can make the arch code more succinct.


-- 
Best regards,
Coiby


