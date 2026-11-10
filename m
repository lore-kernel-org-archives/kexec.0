Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB39160A262E
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t/2Mu6hl;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=kfj58K0U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=; b=t/2Mu6hlPothhY
	iAVZTva8HGgo+KlRXxMke7l9yG074PwhQakQFhsk7qDB5W5a3HWTBpHx2HJsjckJPyziw1cweGORO
	HWitR/OuVFJNG/v0easrEwzth8gaRsIq2h+Xd2iPb3Q41lXczndWUZmZKUpTXKAFxUc7ibuQp3DCE
	qV/puVDtVzwInDAI4fDacrRbd5Ob2k8yIHblF3F7BuHHlX4mBpUW6t6748Q3Sbk3pedgVb86OwR8i
	IisoTmYUKWCok9Q/AKfDgPJx6/5l514hVZ+0RXMxkXCrtPB3AdWVh0RC/CtOLTK+1T5Z3uwODGZFc
	lHwFtI3FtRQuVmvLviAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnWO-00000004KJj-0MRP;
	Tue, 10 Nov 2026 15:12:28 +0000
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnWL-00000004KIY-2kS0
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 15:12:26 +0000
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso744064e0c.0
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794323544; x=1794928344; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=;
        b=kfj58K0UI2AScHuaLPZ/Rn+zoTI8/+0aKlpuqlnHNvF+t/P9SZdtsiXXW1VSBHL31T
         CXqjh0SpLb/qFoWTzRIscyghAzsAEyvkHgvFt5hUhm559uCR3Hzeyt7aCiTmsOhYEzcL
         tye3JpQUDZgVVT+hG9i+n/l/39ZwqZCm//ZLIB5/lGXyRkm2yCtrh9MRkWhs0Vuflt+T
         LJ/lAi4de7iJ7pBrDwLnlj+ZGOWtzKxyW5busxZmVsV0iZR3e5E3GH0DD/61DaeQ3Nw6
         hqOaUxoWJo9Kk+67K46SJ1cPYduxw6qoB1MJ4qH8v63jnMhGKJvEQj2G8hRdTnU7ag7s
         f+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323544; x=1794928344;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=;
        b=2aXGLx4XlTvJcALQxzRbIeisdQvT53p0lWr2LPnTh72w+pl/EhfZhSIGD7GqSNPfSU
         ou/3KEk5Lm8W+zyxSl9wuC9xiD4VuDfOtylGsag2OL1iYSBqRhqXmLh/po7tbrko18HR
         hRpTM2W3EIsl87omo7jrUs5A3zXqZPetu+RkVtb70FqV63t6dQ6N3sPoVWWQ1Pg0X0ZU
         655EcIj/RnhPcu1+5F9o3w92NIzXRcnV1Y2+AeBlkiipQAmS8Jzqq3gu0zEr7BkM9VPv
         B46TEhMSYBeXWnN39H26QGI5thQPCA/pEjron16GV5Qp0ZlmmosP24hKUCgfmmyL+QhK
         GIrA==
X-Forwarded-Encrypted: i=1; AL+hErEVbu5PRQ7Lsbco4mQI3aBDZe7/6nWlD1u1QaSQ9QgwJFzBWNKgYHeUQsvoSZeml9RSwWKmWg==@lists.infradead.org
X-Gm-Message-State: APuU4Z9J6g/ilnYBJG9ukHzQ2idltw8SGGcgrT8Vd1ZolJMKo5etBLcO
	mZf2IDq+6RWlZwm/oL9IiASvOGQMt3VInSzDb2NUiyB5inAgR7eMrcJTAFq6rtPqdFo=
X-Gm-Gg: AYBFou2vfjJbgzEhFXJJlwiWHL24/iLjKNB5Uf19W6QiZraBjC4Qm6/plctM6i9294M
	gNk0bv1wKDj3uMGdlcc1x601mfi0pHcQ7kLgHk41nsMqQRphuRkXCnZDVsRvZ48xqJ6SIJ/kZfJ
	K7AqhmWYBhytscS0ZmHy5YH+k+gIAeHtXe/pzwlnJ/1xvIYhNpxvzwprfDnLWEoyqaQtpoz/NxA
	NBak9V3QhN+9R9Wnl0FlqvI3ajM1auqdryPjNcyOAVfXTr5OSI4AaRi2xuqKJff78U9C6pDmC3M
	Vh9iMlHF8/5vdvSVW5YEx3mrFBYmhcuwkgMBV4ChP6kaWVAtjHrU6JNC+VE56roeA7jS8NPy1nm
	fKj82r/n1r4P6ZepMYs66ZAeVCDVopM/I1NDToPir4zawZmWWs8GpEZv7YgrhLoRBkt+dkzRd1A
	l9qIrwddtj473uz2gbggQtVTxU1UcJR2xtyuXX7S3pBHxbuBpQwuTJxL8O44Yupr4JmUAFEdDy5
	mAuWwSRwM8l07wqj1cWANyW9FJOpJrQTOfdqFrxV8q+oDBERTra483Tbn7Re6/btg1ZUHYzArtp
	auXmn/Jr4T0O6shcAkhWqN3lVyPEwX1ckyUSioULeDVY4iW7+hf7zA6vTJt649pk+nBwzzqxthu
	PKqStGHfjzhqfIxF2G1Kl9p7Gp9To
X-Received: by 2002:a05:6122:5313:b0:5ea:a0f0:192f with SMTP id 71dfb90a1353d-5ee0d0cd07bmr947867e0c.10.1794323544266;
        Tue, 10 Nov 2026 07:12:24 -0800 (PST)
Received: from localhost (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c45a110sm2039560e0c.2.2026.11.10.07.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:12:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 10:12:22 -0500
Message-Id: <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-6-tarunsahu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_071225_705061_24B54C85 
X-CRM114-Status: UNSURE (   8.67  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:

> +/**
> + * DECLARE_KHO_SER - Register a serialized payload structure with KHO.
> + * @name:         Structure tag name (e.g. luo_ser).
> + * @payload_size: Compile-time expected size of struct @name in bytes.
> + * @nr_required:  Total number of defined required features.
> + * @nr_optional:  Total number of defined optional features.
> + *
> + * Size and 8-byte alignment are asserted under CONFIG_64BIT: KHO and LU=
O are
> + * 64-bit only, while !CONFIG_KEXEC_HANDOVER stubs pull ABI headers into
> + * 32-bit builds where u64 has 4-byte or 2-byte alignment.
> + */
> +#define DECLARE_KHO_SER(name, payload_size, nr_required, nr_optional)	\
> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
> +		      sizeof(struct name) =3D=3D (payload_size),		\
> +		      "struct " #name " size mismatch");		\
> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
> +		      __alignof__(struct name) =3D=3D 8,			\
> +		      "struct " #name " must be 8-byte aligned");	\
> +	extern struct kho_ser_hdr __kho_ser_hdr_##name;			\

Remove this extern.

> +	enum {								\
> +		__KHO_SER_SIZE_##name =3D (payload_size),			\
> +		__KHO_SER_NR_REQUIRED_##name =3D (nr_required),		\
> +		__KHO_SER_NR_OPTIONAL_##name =3D (nr_optional),		\
> +	}
> +
> +/**
> + * DECLARE_KHO_SER_HDR - Declare a feature header variable, field, or pa=
rameter.
> + * @name: Structure tag name registered with DECLARE_KHO_SER().
> + * @decl: Declarator (e.g. *fhdr, **out_fhdr, or * inside DECLARE_KHOSER=
_PTR).
> + *
> + * Declares @decl with type struct kho_ser_hdr while checking at compile=
 time
> + * that @name was registered with DECLARE_KHO_SER(), documenting which
> + * serialized payload structure a feature header pointer belongs to.
> + */
> +#define DECLARE_KHO_SER_HDR(name, decl)	typeof(__kho_ser_hdr_##name) dec=
l

Remove DECLARE_KHO_SER_HDR, use kho_ser_hdr directly.

--=20
Pasha


