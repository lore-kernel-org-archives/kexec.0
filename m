Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F560A2634
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kcUnQrZ6;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=IKsXlgdz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WKAEhFQ+Dah3DMHVjGDEQ1FI4504gN8wbhTTvAQenls=; b=kcUnQrZ6uSsOqR
	9Fu7CKqgwoNRQ/38x9hA6LgWu266Ca4ihhvV+ktr5IUZ55/f0krlasJQrC4RmE1IEbSM6sSDol0kB
	liOodYkcn8u8mbDkFPpErHV1QaMKubo4sPlbu7KH4Yfmv019K8cqbsXY7QcoaClHP00UVQantYSrn
	3NLWGn5FETud5yNqfrlS0cgSGNGmDf5f2xAl53mzAg9OMlbDPj/JZBaxTUwZLXCAytIrJaSOu8NfK
	J7+uuFmY3HTk4tJVqO5Em/ieN413izWBuc+9Iyx4XrKR0/VSAvhxFPC72MWa4YOcI54EoDUdBHMte
	gBDhWVEkZnzQWu+fQD8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnSS-00000004Js1-21NB;
	Tue, 10 Nov 2026 15:08:24 +0000
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnSP-00000004Jqo-2fLC
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 15:08:23 +0000
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-98301b325c4so500367241.1
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794323300; x=1794928100; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WKAEhFQ+Dah3DMHVjGDEQ1FI4504gN8wbhTTvAQenls=;
        b=IKsXlgdzhauBXkvQT1ySs13NZ9LbxMFk6Xqy8vxqYlxCDlFPbo9kRKtq0WW7o+96Jw
         mLKl098O0zKhLbSfG8KTR9mYRbZHf3Fv47Z8VML9RELSrb6V2Ep87d7IGxmCr7pm4BCG
         mN1Xp5sBStMpM0iqAkFYNtO6iV3I5jXhcrLGy47jiPq86KAIaSC1p1ZCArMDxV2n3CMc
         dz9M2sZj2LYg6uBzpkUi0KDegrAP1ny+3r6QQkSHPzobzoNrwHLNodFCrftib6Rs8n7D
         jlyUhe8gm5ALfqm9fhedPX4ne+/tuVwsTQcyZHI5BG10NXCyAGRVvpCA9J5GMt1Rahmd
         pssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323300; x=1794928100;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WKAEhFQ+Dah3DMHVjGDEQ1FI4504gN8wbhTTvAQenls=;
        b=BEXCObcDBej98yhBuxvHP9U50vO03aB5ZFDMbm4EzPZr2pSNRG+mlKfzjjdnS8uCvr
         mmIs+gyIh5H3VI1CavF+J6ro42xqvqKmCMBNDuAbAtkTRTmEwZQ1Gu4fKDXE+mKohru8
         B24yNa5hKUn5I0ssbo3ZcbkLvNQLM0tK2V6XOKfWjGWhrWcqpw6jIHNgaYbjOkpdXnBI
         UMPhPdFdLNCiAPpwZJLwsDY1PThGvsSkx2+sDrkdjIHJcjqVisbX/+ffi8lsGCNy/Rto
         34yz5JkYOqBytoeusMU/CPguPdDaNRFXSFty4HEzGBazN39LPZNmPCFrJ+AWM+QR3Xbp
         te5w==
X-Forwarded-Encrypted: i=1; AL+hErG5fu+l1w+cUIw/zKRIPkJIot90LwuLUt25tLJkkbWHp7C8JQeM4qrucLKA/nY3ZY19ffGf/w==@lists.infradead.org
X-Gm-Message-State: APuU4Z9lF7egifzqlOrMSnhck7s++ADtjJuIuCaJpWmFL0TLibKzDMaQ
	LRmDwOvQd1aAxAoYOiXLpHWC+gUEYBNZg++WMCU+5XcPRM66HWmaR22GRZ92zMMOwT0=
X-Gm-Gg: AYBFou2zeQoVQcYMIHqxSyOTfByx3eUnIt7e2ielJOSwFktfuNRIq9UCBpCGQUq70gk
	lckTZOvGl7jv5Uw7ZXE15TbmC2Ax3hj0uIcA0ZdAdH0sCJk/g3Q+fQezoFfhZiwPfi8BvrMtHZ9
	BOfGtO4W+XF+0t337ZBnMxTrbtcuBpmAxBDtLkoUp3gkOM+tIUj63uWBzW6DgZ0p7lAuZLFc2Rj
	l6OtBF0rfIO5vyqEjUo9KHVGz3SHdCI3yO5SXaZFuJ78fHAQ44rarY/WBHPZb8ofX+/dkmne5+c
	7Dbx+LluhURLYXNUU2lnS5chga7GBF8rXdPDFbAB8MFDB54JW0H4qlL8MyMuzgbDUdEHZJLoNSc
	RX5u0o5OX3riicnlHYffrwlssl28vSuoKTx7dDvK/WjoGVxPV5vyyJOzyA8d1TJXsMgj0L0bUyK
	MHrDQUsc/smrOnU55YP/TwMD8vBFsO5Tv9k1YXXT50d5F5GAkHQtdw33JUJq1p7ldJy0V1tMZM7
	pgPXcvd7wJdUptDbIBJ4uksOsd3dbFk0ZbR0vj9y81fTTwHdXhMlivhr65ADJRHkV/ebr4CrXuo
	H9+V1Y5XabahIexzbqfLiokYtAi4HAQMJR16hYRjlC9u8sQN38F06TF03Opif/bl4wdB96qFCyC
	m+6gn7bQ4jveEc9ZcjqM1tO9+3UrkFLcpMTn0W55kaiko
X-Received: by 2002:a05:6122:468c:b0:5da:a74:d6a4 with SMTP id 71dfb90a1353d-5ee0d1254cdmr983516e0c.15.1794323299946;
        Tue, 10 Nov 2026 07:08:19 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c1fffe63asm1965122241.4.2026.11.10.07.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:08:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 06/19] kho: kexec_metadata: Add the feature header
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, 
 will@kernel.org, David Matlack <dmatlack@google.com>, 
 Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, 
 loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, 
 baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>, 
 oupton@kernel.org, alex@shazbot.org, gle.com@google.com, 
 pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>, 
 kevin.tian@intel.com, joro@8bytes.org, kvmarm@lists.linux.dev, 
 linux-pci@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
 kexec@lists.infradead.org, kvm@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261110050202.529473-7-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-7-tarunsahu@google.com>
Date: Tue, 10 Nov 2026 10:08:12 -0500
Message-Id: <179432329215.2329176.14453669404153142360.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3169;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=QPKh6oqVuep5a0uq5kk2HJ+pkn4UzCARnNzVJdUZk/E=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8zNhLa8G7KPQhtpqNqIaC7iUSrItiw95IH4+W
 4FZp+mLRNmJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavMzYQAKCRC7dyhM23N6
 3ixyD/9hSlVPu6pn+Usl6EKxRh1wkp2nNTAGfSwd0T80brdKlRNG7a8mQqhUQi1H7cXmovyHBUq
 ES73eQCtV9EEqD3V+9mhbM/vQ3DNxapFoBftgUpOKocv/TyzS+fnYCCd+V4qkZp6JbEE04DX5ph
 RXIIzYY1cOoM3lIFUa3WAKuQ5IlLTqUrcCnmCGDDA2ABc3Dn4YGxVfA+j1TEgs3i5/pZ3Jg6vPm
 2w2Rki59ZZh1OvjNwqaQcNxFUaUzOua2A1T1C5uWqXUw29+H364g+FPC9TsTFighlf5Dm5nInFm
 sy05T7yV7PmS1d4eRFn5VjWQo2hboOwrVmB5E3sLTnbZ+oXkY0TgWbPqKYlXfKYQ1RF1dttkf3y
 L666oJVxxNOxQuWbB80WyaaQp1G11CUhLjsRBaxuJqYWD3LuhT6NKGc7rkKJ+4Y1QHbv77qrsL0
 xU62OLvV+UYlxbDgjPM1r4q1njY/2zmio3uMBSt4oubrAmtiUMAW6J6dY86mFHlcm8xgbSUbn5B
 HOb83UbLMhoMCV4Zf4R9ofmr8Zb5PO+Ieg4+UAv33DElEYGHzsZJuh7rv0KDrtHn6JA4zqY3vNY
 KpfJSWU9gzyoa94bAOMSWiRRC/83AeXcMfiQw7G8I+bNVH6Sm/Q6RfvqXkiiTkw9BXIWwqNbXQH
 2NBA/068NaYZqOw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_070821_696720_604DE571 
X-CRM114-Status: GOOD (  23.03  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The kexec metadata subtree currently uses a monolithic u32 version field
> to identify the metadata structure layout. Any change to the structure,
> even an optional additive field, requires incrementing the version and
> breaks compatibility between adjacent kernels.
> 
> Replace the u32 version field in struct kho_kexec_metadata with
> struct kho_ser_hdr using DECLARE_KHO_SER. Later fields can be appended
> under new feature indices without breaking compatibility across kexec.
> Also make the 3-byte padding hole between previous_release and kexec_count
> explicit as reserved[3].
> 
> During deserialization, validate the blob size against the header size
> and reject unknown required features. A legacy v1 metadata blob is
> ignored with a warning.
> 
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>
> diff --git a/include/linux/kho/abi/kexec_metadata.h b/include/linux/kho/abi/kexec_metadata.h
> index e9e3f7e38a7c..316b3e5ad01b 100644
> --- a/include/linux/kho/abi/kexec_metadata.h
> +++ b/include/linux/kho/abi/kexec_metadata.h
> @@ -18,28 +18,31 @@
>  #ifndef _LINUX_KHO_ABI_KEXEC_METADATA_H
>  #define _LINUX_KHO_ABI_KEXEC_METADATA_H
>  
> +#include <linux/build_bug.h>
> +#include <linux/kho/abi/feature.h>
>  #include <linux/types.h>
>  #include <linux/utsname.h>
>  
> -#define KHO_KEXEC_METADATA_VERSION 1
> -
>  /**
>   * struct kho_kexec_metadata - Kexec metadata passed between kernels
> - * @version: ABI version of this struct (must be first field)
>   * @previous_release: Kernel version string that initiated the kexec
> + * @reserved: Reserved for structure alignment; must be zero
>   * @kexec_count: Number of kexec boots since last cold boot
>   *
> - * This structure is preserved across kexec and allows the new kernel to
> + * This structure is preserved across kexec and allows the target kernel to
>   * identify which kernel it was booted from and how many kexec reboots
> - * have occurred.
> + * have occurred. Preceded by &struct kho_ser_hdr.
>   *
>   * __NEW_UTS_LEN is part of uABI, so it safe to use it in here.
>   */
>  struct kho_kexec_metadata {
> -	u32 version;
>  	char previous_release[__NEW_UTS_LEN + 1];
> +	u8 reserved[3];
>  	u32 kexec_count;
> -} __packed;
> +} __aligned(8);

Why __packed was not removed in the first commit? __aligned(8) should 
not be needed, given that it must follow DECLARE_KHO_SER which is 8-byte 
aligned.

> +
> +/* Register kho_kexec_metadata with KHO serialization accessors */
here and in all other places, please remove this comment.

> +DECLARE_KHO_SER(kho_kexec_metadata, 72, 0, 0);
>  
>  #define KHO_METADATA_NODE_NAME "kexec-metadata"
>  
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 6f1f55fe3181..2edd772bb6d3 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1740,6 +1740,7 @@ static __init int kho_out_fdt_setup(void)
>  
>  static void __init kho_in_kexec_metadata(void)
>  {
> +	DECLARE_KHO_SER_HDR(kho_kexec_metadata, *fhdr);

Please don't do this, use kho_ser_hdr directly.

-- 
Pasha


