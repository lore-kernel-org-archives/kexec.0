Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3A60A2606
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pyN0Acwi;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aMVAeHnr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=N2mgW6LEnNu8wNmnoa3+p3F6g8tYE7yJEu2kZeiGcR0=; b=pyN0AcwiK96qs0HSSWPY/iw2SG
	ZvNC/lHIwFDWOMghqJmF95VXDakJV7rzz0vZiLBT7JQUybRnbMx3lWOzWWT9RJXBbbZLLcZuRLsKx
	1iK6E2BSDKSLVe2DmsX7sJNT7a1kHgvK00I5zDKXLboxI804rSLXvoludyF8i3FX18yl7ZNOBJdIz
	YDz5wJDcKDkEATmfFMa2hVrIhfWGgP6oEeYjZstENHW7e2lfVhU13rbh1CEPDha9hreQZFYx9JY+Y
	6TRoqS+pEOY68OwmvJuCW98httslORw7VVD5TuuHuTl5153zH29D6TUZrIeKJFo+MucmWi3VQSxPy
	spIfrXFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1tz-00000005nMs-48Oj;
	Wed, 11 Nov 2026 06:33:47 +0000
Received: from mail-ej1-x647.google.com ([2a00:1450:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1ty-00000005nLx-1G6M
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:33:47 +0000
Received: by mail-ej1-x647.google.com with SMTP id a640c23a62f3a-c42888c50c4so251172866b.0
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 22:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794378824; x=1794983624; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2mgW6LEnNu8wNmnoa3+p3F6g8tYE7yJEu2kZeiGcR0=;
        b=aMVAeHnrx+sspRJmEUn6cmk6O5u16bSIdPty5SQcjZ/jVmgBrI6QHGqx0fbeS3A4JL
         N+KMoAYKUPG5cGR1cGKJu14dMhrGaw4cRc0vhqMXALOQyTqR3abtZzmdPY1CqcxaN/2G
         cr/Tshd4KuYIQzFL1FhYMYP0n3g7qO2KfSUqMov47bN6yCgNUwHGNNr9tjCVq/BK3UZQ
         JrcSliFDZnO+OIrmsucEAZoimC1YjBam0T/xuMw7LVNWI3uxVhximr8ck7fTFKG02Cbr
         iV1hR0kXpQxXfCM6byDRiYf3DshpHJGAPnmbgrmt7vHySYko+1M28VXf9ihCFqhYDira
         8GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794378824; x=1794983624;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2mgW6LEnNu8wNmnoa3+p3F6g8tYE7yJEu2kZeiGcR0=;
        b=r2Qnt/s6Nk2oiLlrwirMTCcXJIgQJqCfFLEWpL/hSRGkT/hRKPaLvTQBrej1a/53ZE
         qSkIiOnA2f0lZhumjOBAEoAd2+RBEUzEORHuBkfVkmH9PsPzBvZZ/yDZBoKzsyfREtth
         rtdYF7GUC3xP1smNGKgFxxE9BlkjWQuRyZh2vstcaL6QMP8aAkNFR3TzPGTOuONxDkhk
         tsegEvGWNXhm4e8MyN0Hn+1ERxxkvZwknJ/wpIhottKgMbejw0k/eYXFkM03zoqIT0mh
         cNAZtyD4GDAdJ7xtWzDuzcxS60ZCkWxX3/+qxlRss5oarIIRogWZN4//6HuLhWtGpqa/
         W/cw==
X-Forwarded-Encrypted: i=1; AL+hErF43HUmGSCtYb497dZu9cyOJLxvBKge4dUGP9owLQR1OfFrCwPMStXrhGBpVLp8yM9ZRYCl/w==@lists.infradead.org
X-Gm-Message-State: APuU4Z/BCL2XVi9csltl37++6JQCZqiKg2yjYjnuh2I66lJBPQ2SoPjz
	5eK/AUOM4pH5sADCZkz9fUGnhMcUlK/V41kw3Oiu9swHKYHU9hplZ7hc7ET3zHQ4mgxTM3iWhZ1
	glC7h1uqvATm+Poi1Pw==
X-Received: from edgi9-n1.prod.google.com ([2002:a05:6402:a589:10b0:6b7:8226:b2f0])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:613:b0:6b1:ce0f:eb6b with SMTP id 4fb4d7f45d1cf-6b777700516mr806340a12.31.1794378823419;
 Tue, 10 Nov 2026 22:33:43 -0800 (PST)
Date: Wed, 11 Nov 2026 06:33:42 +0000
In-Reply-To: <179432329215.2329176.14453669404153142360.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-7-tarunsahu@google.com>
 <179432329215.2329176.14453669404153142360.b4-review@b4>
Message-ID: <9huzv763q3ll.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 06/19] kho: kexec_metadata: Add the feature header
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org, 
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_223346_350705_F640078A 
X-CRM114-Status: GOOD (  21.29  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pasha Tatashin <pasha.tatashin@soleen.com> writes:

>> The kexec metadata subtree currently uses a monolithic u32 version field
>> to identify the metadata structure layout. Any change to the structure,
>> even an optional additive field, requires incrementing the version and
>> breaks compatibility between adjacent kernels.
>> 
>> Replace the u32 version field in struct kho_kexec_metadata with
>> struct kho_ser_hdr using DECLARE_KHO_SER. Later fields can be appended
>> under new feature indices without breaking compatibility across kexec.
>> Also make the 3-byte padding hole between previous_release and kexec_count
>> explicit as reserved[3].
>> 
>> During deserialization, validate the blob size against the header size
>> and reject unknown required features. A legacy v1 metadata blob is
>> ignored with a warning.
>> 
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>>
>> diff --git a/include/linux/kho/abi/kexec_metadata.h b/include/linux/kho/abi/kexec_metadata.h
>> index e9e3f7e38a7c..316b3e5ad01b 100644
>> --- a/include/linux/kho/abi/kexec_metadata.h
>> +++ b/include/linux/kho/abi/kexec_metadata.h
>> @@ -18,28 +18,31 @@
>>  #ifndef _LINUX_KHO_ABI_KEXEC_METADATA_H
>>  #define _LINUX_KHO_ABI_KEXEC_METADATA_H
>>  
>> +#include <linux/build_bug.h>
>> +#include <linux/kho/abi/feature.h>
>>  #include <linux/types.h>
>>  #include <linux/utsname.h>
>>  
>> -#define KHO_KEXEC_METADATA_VERSION 1
>> -
>>  /**
>>   * struct kho_kexec_metadata - Kexec metadata passed between kernels
>> - * @version: ABI version of this struct (must be first field)
>>   * @previous_release: Kernel version string that initiated the kexec
>> + * @reserved: Reserved for structure alignment; must be zero
>>   * @kexec_count: Number of kexec boots since last cold boot
>>   *
>> - * This structure is preserved across kexec and allows the new kernel to
>> + * This structure is preserved across kexec and allows the target kernel to
>>   * identify which kernel it was booted from and how many kexec reboots
>> - * have occurred.
>> + * have occurred. Preceded by &struct kho_ser_hdr.
>>   *
>>   * __NEW_UTS_LEN is part of uABI, so it safe to use it in here.
>>   */
>>  struct kho_kexec_metadata {
>> -	u32 version;
>>  	char previous_release[__NEW_UTS_LEN + 1];
>> +	u8 reserved[3];
>>  	u32 kexec_count;
>> -} __packed;
>> +} __aligned(8);
>
> Why __packed was not removed in the first commit? __aligned(8) should 
> not be needed, given that it must follow DECLARE_KHO_SER which is 8-byte 
> aligned.

because this structure is not naturally aligned and we have o add
reserved[3] to make it aligned. So it will be ABI breakage. Adding
the KHO_SER_HDR is also ABI breakage, So I kept both changes in the same patch.

For the __aligned(8) part, yes we can remove it, I will update it.

>
>> +
>> +/* Register kho_kexec_metadata with KHO serialization accessors */
> here and in all other places, please remove this comment.
>
Got it.

~Tarun

>> +DECLARE_KHO_SER(kho_kexec_metadata, 72, 0, 0);
>>  
>>  #define KHO_METADATA_NODE_NAME "kexec-metadata"
>>  
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index 6f1f55fe3181..2edd772bb6d3 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -1740,6 +1740,7 @@ static __init int kho_out_fdt_setup(void)
>>  
>>  static void __init kho_in_kexec_metadata(void)
>>  {
>> +	DECLARE_KHO_SER_HDR(kho_kexec_metadata, *fhdr);
>
> Please don't do this, use kho_ser_hdr directly.
>
> -- 
> Pasha

