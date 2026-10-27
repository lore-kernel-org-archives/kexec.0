Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C1606A324
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=o6z0Yso9;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=HmsO7bof
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PxRb990Xj/uwND6b4fXh9A/3T5i+xI2zB08D/68nqZA=; b=o6z0Yso9ZJa74PmT3Lqy28LoYi
	5MGXkbr4uc+zs08so7BPWVrH/yoNwjtqORHRFaFvetqCXnO2Fa+C7Aa0Oj9tBt+zgyLPyO6cB3JFM
	5aH0kue0Ios62iD1eXZMKMMQKDAy33Kn4fTTvcl8bVpaeHM3b0Oj9fwNhH6+86pL4HPIrNA7EE5aH
	QZiB3AhvozAUSEp6PMoHhFxl/J+8VFpCuHV758zPshqnl+4M66HYdCTreVf0+mFL5S18a030OiawB
	0xrV1CBWWxeCTqLSnLI2PzxerMCra914XGATpukzuui5vc3zWKU/h0OPSPJcSDdrnYJJbrZq0mTwL
	f0RsVufw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLjvK-00000005L90-2638;
	Tue, 27 Oct 2026 16:21:18 +0000
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLjvH-00000005L8B-2Ko5
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 16:21:17 +0000
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso49653e0c.0
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 09:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793118073; x=1793722873; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PxRb990Xj/uwND6b4fXh9A/3T5i+xI2zB08D/68nqZA=;
        b=HmsO7bofLpLzzYOQ+DvCciHyJr+cPRxf2AJ5rkdTo/mPGbf1CfgYnCtC6uKzpvPWsR
         FCb9XaS6NG45bmDjJHabexKXKHTw2CIfATLnBiP7ROf891a9jM8n5PiS5chIAc9wuL8z
         ZR13TOb5EAxaisCh8+qazbh3Vuy/woZB8zeVtiJ7+YozrjRYjyWs3QIe4/QRKkbydk7j
         /ov8e4PD579SYmvtNPOBhlIAB9EBcyfwX3nhcRt2wo4JGGWHdLPI2G2vG7gnEWAyCUqg
         VbhIEW5DRpno2tC9/2R4sI83a+ZjgB0d/ToU3KVbpOYGTbEHdomHAFooWJmVg5ouWIFq
         Q3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118073; x=1793722873;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PxRb990Xj/uwND6b4fXh9A/3T5i+xI2zB08D/68nqZA=;
        b=eoKJDLONBVQN+2kOMjTc8h8N2GyRB0DeuU+Mz2Gf6op+Jf3h3l7YHpF6Wcei4PECIh
         pXGbITtHYdUQtl58xbg0qAeM7SBvfIeDXRsCa6qwN59dq8roESsjLh3cpg/isnDrbnrm
         TqLm2fjnEdhwgb/vz+M+Bgf6SrrO2oO09GO3y25lKyLtdgR/fRl6ePnQq9g8Z3SXdOHA
         aqQS8lUSd4qhCBUyEcaPyQ8jOeU48MVAyd7TW8MBgzqM4FqLACudj18jHZIYefXvIudB
         HCASAeLMjqFfxHa2t2k1ZEkrI3GxLu4bRZYuAQe349t5skjpTST4EfJQylbkixWihdrY
         FKDA==
X-Forwarded-Encrypted: i=1; AKwUvBw0O+q583w/40Qb8YH5bxzpIJk4dim2kGcUMmAelpGzqwPQbQRrZEltscOeyNZfB+tco/y4eA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJbLfr+t3UOzwmnWUQ06cvg2ghUvcgU3zKefFV42WBlLdgYXzWQ
	magQkV8VuPqXO7JO7Mc0uzdv2slszfYQ7Sko6w9DGbEtYdRDjl1SSc419zOJ6pAYwvw=
X-Gm-Gg: AYBFou2LifkI/FQkEJEqfu3T0nGiO503l7DzAfMZ5mEhKGGtmrjeauHGOyKXR5Wj8ma
	EhO4/Fl6m/w2gpute3/Dfy0fDFQ8i8YQDRTbVrdeO3Zw03Yxs/uFCNKUq1kHlk8YD2NvMM5uPw0
	tpdePD3mg815QQM3rQJGB4b3y0GLbJJe7NLftwrZZj/R7Ieqf5XPCUYGs4EM+cEhO71nkqwsMl2
	JC3ML1K6ScXmf42S+ie0dpJTxw5v6sYVTYn3m+k80aATNeVUZGFiEXz4Nocg04RTzfshiPlI5I3
	IqCePVKPPFKuU1ILIk4g5emu2sHUFJrEKmCWNhtYq8vcQUNPJX1FTN7Sq0aUGvElQhAQ8rCU5MN
	7PsVTfupd5U7lTEedRvjQuaEpPBqCDmYea/uYma99fOJgGbh3fDJuepY+bRxw1gXQJc0kgB+Xxm
	GasEMFULZFiJCXTwBqddchOXmMaYTI12Sa6yVFdpGn2BzicbH8eOH4BSME/EoRpRnFapbZSnn24
	37oMsmU75fde8Ivdkao91NNNcmkzRNKwUcQrIedmFIBOVt1Z6z/+igAyvwrD61evf+O2SwiCMkT
	0boXJXsHvXU8E00LPdx3VRvDL5GVqRTy8gXm6nTlBmqUUfksFuXKQpprHRQvKmrYPaSQFZ5mquP
	mIDfVxUS/Bz/guBkPPY1Rs6dq8mYrmA==
X-Received: by 2002:a05:6122:1352:b0:5c9:c60e:3a40 with SMTP id 71dfb90a1353d-5ec232e48ecmr4515149e0c.18.1793118073126;
        Tue, 27 Oct 2026 09:21:13 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4a5f26c7sm304662e0c.9.2026.10.27.09.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:21:12 -0700 (PDT)
Date: Tue, 27 Oct 2026 12:21:11 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, tarunsahu@google.com,
	Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
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
Message-ID: <auDPd6tjzACQVszf@google.com>
References: <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
 <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at-8vkVpN2SF3XgB@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_092115_659187_90FE9D3B 
X-CRM114-Status: GOOD (  16.18  )
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10-26 20:49, David Matlack wrote:
> I still think it's not advisable to define name##_wrap since anyone
> could accidentally start using it on the incoming path and we wouldn't
> notice at first (especially since same kernel Live Update tests would
> keep working totally fine). I also don't think asserting the combined
> size buys us anything. The header size is just a function of the
> number of features, and what we are trying to protect against is
> structs embedded in the payload changing size.

Fair point.

> 
> So I would just do:
> 
>   /* Marks struct name as a KHO serialized payload with a kho_ser_hdr. */
>   #define DECLARE_KHO_SER(name, payload_size) \
>           static_assert(sizeof(struct name) == (payload_size))
> 
>   DECLARE_KHO_SER(luo_memfd_ser, 16);

My main requirement is that DECLARE_KHO_SER() in include/linux/kho/abi/ 
must be enforced by the compiler rather than being just a bare 
static_assert() that someone could forget to add. Since kho/abi/ headers 
contain both versioned structs and unversioned sub-structs, it must be 
mandatory to declare versioned structs in kho/abi/ with their 
static_assert size check before the kho_ser_*() helpers can be used on 
them.

So, how about adding enum names like this, that are going to be required 
in accessor functions later:

#define DECLARE_KHO_SER(name, payload_size, nr_feats)             \
    static_assert(sizeof(struct name) == (payload_size),          \
                  "struct " #name " size mismatch");              \
    enum {                                                        \
        __KHO_SER_SIZE_##name = (payload_size),                   \
        __KHO_SER_NR_FEATS_##name = (nr_feats),                   \
    }

> Plus helpers that allocate and initialize the header and return the
> payload as a typed pointer. Both the outgoing and incoming paths find
> the payload the same way, by computing its offset from the header,
> rather than through a struct with a fixed payload offset:
> 
>   /* outgoing */
>   hdr = kho_ser_alloc(luo_memfd_ser, LUO_MEMFD_NR_FEATS);
>   ser = kho_ser_payload(hdr, luo_memfd_ser);
> 
>   /* incoming */
>   hdr = phys_to_virt(args->serialized_data);
>   ser = kho_ser_payload(hdr, luo_memfd_ser);

These would become, where without enum, the init would fail:

#define kho_ser_init(buf, name)                                     \
      __kho_ser_init(buf, __KHO_SER_SIZE_##name,                    \
                          __KHO_SER_NR_FEATS_##name)

And payload can also check the existance of DECLARE_KHO_SER, using 
(expr1, expr2):

#define kho_ser_payload(hdr, name)                                  \
      ((void)__KHO_SER_SIZE_##name,                                 \
       (struct name *)__kho_ser_payload(hdr))

We can also add an optional kho_ser_alloc(name) to allocate, init, and 
preserve.

