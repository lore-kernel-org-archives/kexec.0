Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBB9606A31E
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SfmAiA1o;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bXKiyzgj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Glhm1d7B/bXe7XSf6a+44KZYpto2vUedcbuSuK5V4mM=; b=SfmAiA1oHmBCTNg3CjBhIQJJlr
	Lee8B6elpDev2I2KZjDrNVGPxF35LV76jOHnFUNgQLKc1hF0DeBnxEtIiaeNwJWVvXSjDLQUbXdYu
	dddO4pPPheRV7q72CPzpWpRtSz/TLI6/X5gpdaFfW4h6VXNmrGH4+CEtlY9689KUANgE3DaOlIfSq
	e2QdC6SmUL1H/Aa/BgO+ovuHD+uDSqtEN9qiFI6G+DdpJa0AjYNNqKD9CuhLwK8ASApAEGyBSDNpz
	oDrmPVnWXWqXQUm7UJnzTcDTOgL2RrJYe+W/+M7oMJ0VLx9c16F/064/Ygh9V9I6QVaIhctSjyIj/
	MAIOXj0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLl3X-00000005THn-03cQ;
	Tue, 27 Oct 2026 17:33:51 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLl3V-00000005TGw-0EcU
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 17:33:50 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2e8b20a899fso289465ad.1
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122428; x=1793727228; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Glhm1d7B/bXe7XSf6a+44KZYpto2vUedcbuSuK5V4mM=;
        b=bXKiyzgj3+isrqQEiPr2XDXPMW7qGTl7gTMY/O+d0zsjOOUr2K6q01UeSd977TA5DL
         BsQKJQlkzqiirrSscHiZbptu7A2I/9+uWYzwHdSdzgQYXA4m4zEsg7bM1EzhfyEdGNLY
         vnBPT6/0hWVLsk6NlMDkj5igu2GeZjyaTiJioGE4UKtvExaQ/RFLXQ+PRruaj1j2kgNa
         2gvvvvfuCrARIC29dEAdGq7rx/mJ4yDnUDslcacWzpxiYPxAsW7DUrY8Dt776qz/Ncl+
         Z6t8TH4l/FY5magMW2LHdvTTxgVJYZQ5kvqsdpoQp/plWX0RWrK8OcblDamoF0EWzT1Y
         M+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122428; x=1793727228;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Glhm1d7B/bXe7XSf6a+44KZYpto2vUedcbuSuK5V4mM=;
        b=zo+mMx3tilOrksrnvMUe65wEvhSDtzQ0Bcwnp7oMlpXrInom7Ms36CTj654a7pVQvh
         iDcLbuMMoXcQA8sm9ZM7tql2QSq9L97EvAQqcX0kDSBR/mG/PNCs1Ep/smxmmPaY/JyJ
         WTb4NI+mVvrIBWtdGNG2Y6RxqX8H9SZxENu6wijLH7QFzh1UJLIrbXutd982rHwVjVSx
         LGNUkxo8RLAMPmFpszsvKaJhwZX6f6Tl5/wjueJb5Vds6S9CGBfXFICV2y4bJVbqWyxj
         K8Te8X/GPgYCqtGIIzRgZynv+g3+lOE5KCY9Xiz/sDXkdzh8drFvSB1sqjwqUXB0BqwU
         zbXw==
X-Forwarded-Encrypted: i=1; AKwUvBz2WDIF4dtswt5lAPhebJq3afJJ268oJeHESo+O/AoHfd6cLoEtN8U875se1TKL7QjFls4hpA==@lists.infradead.org
X-Gm-Message-State: AFq9FYLbOgSd5t4aSYDZ8Ktewt0mp4dQwed1TTi6FmAEvsQxS2Uz+dQc
	bHasaE69ZuPOYavBnnSzizmYO9kyYoPqdFYjd3QUcUDcNA3iOW/XeKQML/8+mLgtig==
X-Gm-Gg: AYBFou3uPNX6qWYaSnGw5BMgkuZKBsOJYPakWnj6yfqALK4VD+ohHg/jmcFt9kng6EA
	+4k3dbauRRGAAtKnxVLpclm+XkiM+O2iwxuWmSsnXzAN2cfZPPoF9YQI3s9HyZWmEK7cu51k0PD
	wFOzyAAhs3VScOorYqUnBh8/NbCYi0koD6j8AYOKv03SmQBLsjE8m5biL0jIDX0ANxrI6xDT9Ln
	rs2IT8VaeyPKdJSyPw9wVju6Itbz2bH/sHZH4ZFGAW/3MNJqUAmTO7/1wylaA6RzGN/01UMofGt
	sm9MBajF0nYLdqIg5Efw53UezRo3bXGFpeAFc3eejCtE670Pdc5b8UCPOqdLoGEtDK+lsloKGEP
	r+nZcUTfB3ZTV1D5QQ/R2l0LMmEspn5tsfjTIuB3MSx5hBz2RdDv/d5cxG/qJDw7aZg4xsL7bG6
	JdvWSTBKPG5E3zl+kcWzZWfsDykTFQiSUCGh+x6XimC7tQk5025tQ6BwcOs5gDsOh182dPJLsvp
	BAkhmQjLomUkXe2zfOHAKVOhoh9pbvTqUengeuVg2pCjtkPskp+TSSP+Q09HTZTauMnQ2yMAb1H
	HmHE71bMQ/jI60EpztM7SL17ny2sN3LmBIg4mPqDYEVJyDYvOPdo0Gh3ZovkIH2QkA==
X-Received: by 2002:a17:903:3d0d:b0:2e9:5507:b52e with SMTP id d9443c01a7336-2eb005a6905mr454945ad.50.1793122427469;
        Tue, 27 Oct 2026 10:33:47 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm12585675ad.35.2026.10.27.10.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 10:33:44 -0700 (PDT)
Date: Tue, 27 Oct 2026 17:33:41 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>,
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <auDgdUb3y_ricEq9@google.com>
References: <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
 <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com>
 <auDPd6tjzACQVszf@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auDPd6tjzACQVszf@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_103349_152858_23B69249 
X-CRM114-Status: GOOD (  18.41  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 12:21 PM, Pasha Tatashin wrote:

> My main requirement is that DECLARE_KHO_SER() in include/linux/kho/abi/ 
> must be enforced by the compiler rather than being just a bare 
> static_assert() that someone could forget to add. Since kho/abi/ headers 
> contain both versioned structs and unversioned sub-structs, it must be 
> mandatory to declare versioned structs in kho/abi/ with their 
> static_assert size check before the kho_ser_*() helpers can be used on 
> them.
> 
> So, how about adding enum names like this, that are going to be required 
> in accessor functions later:
> 
> #define DECLARE_KHO_SER(name, payload_size, nr_feats)             \
>     static_assert(sizeof(struct name) == (payload_size),          \
>                   "struct " #name " size mismatch");              \
>     enum {                                                        \
>         __KHO_SER_SIZE_##name = (payload_size),                   \
>         __KHO_SER_NR_FEATS_##name = (nr_feats),                   \
>     }

Sounds good. Since you're also on board with splitting required
and optional features [1], this would take both counts:

#define DECLARE_KHO_SER(name, payload_size, nr_required, nr_optional) \
    static_assert(sizeof(struct name) == (payload_size),              \
                  "struct " #name " size mismatch");                  \
    enum {                                                            \
        __KHO_SER_SIZE_##name = (payload_size),                       \
        __KHO_SER_NR_REQUIRED_##name = (nr_required),                 \
        __KHO_SER_NR_OPTIONAL_##name = (nr_optional),                 \
    }

  DECLARE_KHO_SER(memfd_luo_ser, 16, MEMFD_LUO_NR_REQUIRED, MEMFD_LUO_NR_OPTIONAL);

The incoming path can also use __KHO_SER_NR_OPTIONAL_##name to validate
the incoming header only contains required features that it knows how to
handle:

#define kho_ser_validate(hdr, name) \
    __kho_ser_validate(hdr, __KHO_SER_NR_REQUIRED_##name)

> > Plus helpers that allocate and initialize the header and return the
> > payload as a typed pointer. Both the outgoing and incoming paths find
> > the payload the same way, by computing its offset from the header,
> > rather than through a struct with a fixed payload offset:
> > 
> >   /* outgoing */
> >   hdr = kho_ser_alloc(luo_memfd_ser, LUO_MEMFD_NR_FEATS);
> >   ser = kho_ser_payload(hdr, luo_memfd_ser);
> > 
> >   /* incoming */
> >   hdr = phys_to_virt(args->serialized_data);
> >   ser = kho_ser_payload(hdr, luo_memfd_ser);
> 
> These would become, where without enum, the init would fail:
> 
> #define kho_ser_init(buf, name)                                     \
>       __kho_ser_init(buf, __KHO_SER_SIZE_##name,                    \
>                           __KHO_SER_NR_FEATS_##name)
> 
> And payload can also check the existance of DECLARE_KHO_SER, using 
> (expr1, expr2):
> 
> #define kho_ser_payload(hdr, name)                                  \
>       ((void)__KHO_SER_SIZE_##name,                                 \
>        (struct name *)__kho_ser_payload(hdr))
> 
> We can also add an optional kho_ser_alloc(name) to allocate, init, and 
> preserve.

+1

