Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B2606A334
	for <kexec@archiver.kernel.org>; Sun, 15 Nov 2026 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=n662IQlt;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2aAKF9+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=E5e8BJEiuZ4whbgu1Hr+6JPc8nqHGgyY0u0a+RokHVQ=; b=n662IQlt/oVAku43QJdFak+BcN
	LEyQw10ZX7gdAG1ShQS1THDB88ILj5rFTDOMb3AfM1+Fj9x4Dy97kLddqxJRy4z6xUsPPKhP8jkFY
	x+3VLb2JX3lE3cV72snDG13MjXrBYtOhAWDRbD3MKedsBEkd6KJJ3oqKGqPzhq/B7ODEp4sODyUyA
	I94V4u1Zpe13u7X0kBaSSI+Whw9JsefuGzJLsyV4YqrT9jusRbrruTy+CMrSTITJxNKtuGoBWUwhy
	EjBwEYBxq8+zgsq2UOrP0jbt8uy9pqfP8So23TEgWfSFXp8IPz2lvKfCZGKm81Hoyg5au+HvM+ZHm
	12a8MSzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSeY6-00000000IPn-2zFd;
	Sun, 15 Nov 2026 18:01:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSeY5-00000000IPK-06kc;
	Sun, 15 Nov 2026 18:01:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7C45C43DA4;
	Sun, 15 Nov 2026 18:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FBC1F000C4;
	Sun, 15 Nov 2026 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794765711;
	bh=E5e8BJEiuZ4whbgu1Hr+6JPc8nqHGgyY0u0a+RokHVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=o2aAKF9+YecDzzGk4bV1bgV0jRjVUpJLhAYO7F+KOkCHqua5bwkkqaIW2TcKzIbVH
	 8RrypZah37W8SoLFH+cHTWDJSt7g97GkpFDUJwpOa8fXEP+C7Fk6eZGhN5bZ5QIWGv
	 rNolRUfDXYPxamX3x3K99oNFg+prs8oECrVd82aJgQ4n1vZ2k1l/hIbRyzuBfF8uiT
	 SP3N1MJ5SlYTbuy72JItmaVx0qM0W054SYKcPl3aN0rEaY1nttQPHOG1KwcWmsiT9y
	 t6SsJiUY3zhw8E+wDnL4kBJBk7lTf7M92W7m9dew6fxdbCTR+FrT6wxWeM+LVgDM2r
	 6NmZ515+KqNWw==
Date: Sun, 15 Nov 2026 20:01:37 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, robin.murphy@arm.com,
	maz@kernel.org, will@kernel.org,
	David Matlack <dmatlack@google.com>,
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com,
	loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	oupton@kernel.org, alex@shazbot.org, gle.com@google.com,
	pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
	kevin.tian@intel.com, joro@8bytes.org, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org, kvm@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
Message-ID: <avnzgVJic77yKMoh@kernel.org>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110050202.529473-6-tarunsahu@google.com>
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

On Tue, Nov 10, 2026 at 05:01:48AM +0000, Tarun Sahu wrote:
>
> Each subsystem registers its serialized structure with:
> 
>         DECLARE_KHO_SER(name, payload_size, nr_required, nr_optional)
> 
> This establishes compile-time assertions and provides type-checked
> helpers: kho_ser_size() for total allocation size, kho_ser_init() to
> initialize the header, kho_ser_payload() to access the typed payload at
> its dynamic offset, and kho_ser_validate() to validate required features
> during restoration. DECLARE_KHO_SER_HDR(name, *fhdr) declares a struct
> kho_ser_hdr pointer while verifying at compile time that name was
> registered with DECLARE_KHO_SER(), allowing callers to document which
> structure a feature header pointer represents.
> 
> An example demonstrating how a hypothetical structure defines its
> features:
> 
>   enum foo_ser_required {
>           FOO_SER_REQ_BAR,
>           __FOO_SER_NR_REQUIRED,
>   };
> 
>   enum foo_ser_optional {
>           FOO_SER_OPT_BAZ,
>           __FOO_SER_NR_OPTIONAL,
>   };
> 
>   struct foo_ser {
>           __u64 base;     /* base fields, always present */
>           __u64 bar;      /* FOO_SER_REQ_BAR */
>           __u64 baz;      /* FOO_SER_OPT_BAZ */
>   };
> 
>   DECLARE_KHO_SER(foo_ser, 24,

The example should have included 7 fields total to make it 42 ;-)

Seriously, this magic number show must stop.

>                   __FOO_SER_NR_REQUIRED, __FOO_SER_NR_OPTIONAL);
> 

-- 
Sincerely yours,
Mike.

