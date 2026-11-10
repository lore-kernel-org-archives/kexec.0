Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246E9606E828
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JH+4yjz6;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EFAbUvSg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KprtAoIZUPQy03e7SCEXrO4BhVdW6Lml6VdK8wkVG2w=; b=JH+4yjz6lyOXH7
	sUpdLxC2rVoRsjSx4UmFA0X6yHfFEKNB0nP+7OzIMpLle7oPkeUoRqPikzu9IZMxUHKpT+gdFxd4o
	G2BcpZS61Sf/2WoApl2VoIpjq1hfuL7VgEn+R5GYqmwtzPaa4ab61Zi0GuaIJLljo05H+q19sCM9H
	zWHTDA4aoq9Z1aXyndV3u8jM2I/X0NycI4Vsji14qjGho5EZTa8hs8UG5r7GiPXXt7nkbBJxNYkzY
	uLn3BXvLXyFTnEqxArxNTKKXDUs4O9cUUHIbKD766hjInQysndmiwX6R2xYlgkMHAEPb0UFdd0029
	U1LnwWFzFul0zvZUlPxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQosk-00000004Zkc-2Wyd;
	Tue, 10 Nov 2026 16:39:38 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQosg-00000004Zj4-3YxJ
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 16:39:36 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3b1535be329so1180575a91.3
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 08:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794328774; x=1794933574; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KprtAoIZUPQy03e7SCEXrO4BhVdW6Lml6VdK8wkVG2w=;
        b=EFAbUvSgP4UKqUfTYEXA7xa4va4el3X6szjGdW3eOakLVgZee6somAT4yavn6GVslF
         bFbuXdS8gxUpTGXs3TRjDj9LDfmu7hs086EccZy2LFpiHivkSQFhrJ+JVOXz4ieQcoR5
         CYuyaLQ0719R7w1ttnnpOti/UExB63qGK05381qb8PLs8rc0j5y3dlxulzLh0zbf0GpM
         tjYfEbsqUSk9jR46uZHYRGxMB0qvuqR/o4/ayaqgX5d5Pd0O8WPv9sPDBc5JW03sKNW+
         DuDtjuEOyHEhdvj0dRIHAWrO3xl/Jkv7Vf8k63RuzC73a/YvFxlIG6Uqm/q1UpyDc+Z/
         N/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328774; x=1794933574;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KprtAoIZUPQy03e7SCEXrO4BhVdW6Lml6VdK8wkVG2w=;
        b=sIP4DF/CaJtIGi+oOAcA6wn/cjdpIAVMii1A9U/ITD+IL0yxbW1c7cgNhzmbJ04xrn
         KmPqWf1zIoPOhXh5sWJv26Xw4ggG+xI2S0i02IEOTy6wurqcOsogizhPrmtJoQ+PhBws
         9UbdPHyN0AteupPAdGWRIV3twKQvc1VAD+C0Hs9xe5UY8fmoaSGK2JOnC3M340PANA/c
         Ps4Ji6Kc76NthMKl+0ckW5kzDYGEvrAtb7EFHrQLdN5NHNFJT9WJnrLdubi5XAiJlvz4
         7lYsnmieKu7gphLZFx/F1IoDtd7XmaZGYAMFwXUGw0y/sXQ5aRUIljAcDglcVoISxqFo
         rYxA==
X-Forwarded-Encrypted: i=1; AL+hErH3p26OR49zt1UM5apsl0b8AHBMDWHwsdNmbxcFTkDxzF2UE7+8T3UMWz5dVZuUpGyIuai9Ig==@lists.infradead.org
X-Gm-Message-State: APuU4Z/yarYH2QQE4DADxhesRiUIfmovAbbM1fZMi0hXXzBTC4OQACCx
	u62ZN9rLhDHQADjLqHzhUIvhOT86qAiz5g6ilvtwhxUiqyWIzBNOYyznKkQuyFWKaw==
X-Gm-Gg: AYBFou2TtySDVU0+Gznb6Izik/OVNa0A5hZOLKpobCQY58BXY/Rjh5hiBm11GHiCE9I
	DxbaQI/UPHxMX3RdfcpvhSjrn1fAAAKfdOgF+e7r6XP4QhRppPIANzEUzHV0Vqt9ouiqYoljJgx
	kP+h70lbVExs8Y3L2kzLa/3M5P7He5Uke9T62wJOuatX4oFqQ7HVuvB+D4AfHL4H91k5AopJE+K
	mFTRbBNLzn9jCDk7asJjL/lPZRXXhD2AB23zIjF8k7La95EyRcgWy8A/DZZtW4SLZciZmvrrh8p
	d2vGs0dnxvprrTYjQJWfIVDxWHBdqHB+p/l/yYjMmlEPLj82dEQLHmkA4k7RnT0HDwT0B2BAvKP
	irhslOnaD/ZuZzoQWPXqCCFbwOHXVAmgh4x5Gd6uYOBKkEjVA9tHQHZq5772aFEztA/XsAcQTEx
	NXapLwpdLXmrCrkNKnYxKXXXNWOpXkpFe0Abbblmx+p4n9t9KNCOT2bwTB5/TG0AdC8yfV9zahd
	ZgBUIeDDZWOHE/5/c5NQU0CT0fn9IIBPKe1TgGXQd04wpSBJpZ/ZZUZn8K9HeHO0xLo5HQaMUqA
	kVpRgb+PzqH153/X7j4YLTTrnNyzBuH9fHDptKOlsIT+S8my4ZKk0PuV2EcTnA3W
X-Received: by 2002:a17:90a:d444:b0:3ac:9d83:8861 with SMTP id 98e67ed59e1d1-3b166e3c924mr3152630a91.67.1794328773194;
        Tue, 10 Nov 2026 08:39:33 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168a8de09sm2418499a91.0.2026.11.10.08.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:39:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 16:39:31 +0000
Message-Id: <DMROGPTP93G4.13PA42UFKZJNJ@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 15/19] PCI: liveupdate: Add feature header to struct
 pci_ser
From: "David Matlack" <dmatlack@google.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-16-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-16-tarunsahu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_083934_893790_AEEFDC4C 
X-CRM114-Status: GOOD (  19.34  )
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> PCI_SER_REQUIRED_FLAGS_SUPPORTED. Remove dev_ser_size and
> PCI_DEV_SER_MIN_SIZE so restoration derives the struct pci_dev_ser stride
> from the KHO block header entry_size. Drop __packed from struct pci_ser

Taking the stride from the block header is good, but dropping
PCI_DEV_SER_MIN_SIZE removes the only check that incoming entries are
large enough to hold the fields this kernel reads.
kho_block_set_restore() only rejects an entry_size of 0, so
pci_flb_retrieve() will now read past the end of entries smaller than
offsetofend(struct pci_dev_ser, refcount) instead of panicking. Please
keep an equivalent check against the incoming entry size.

> from the KHO block header entry_size. Drop __packed from struct pci_ser
> and struct pci_dev_ser, adding an explicit u32 reserved field to struct
> pci_ser for 8-byte alignment, and bump PCI_LUO_FLB_COMPATIBLE from pci to

Please move this to patch 1, which drops __packed from the other ABI
structs.

> pci_ser for 8-byte alignment, and bump PCI_LUO_FLB_COMPATIBLE from pci to
> pci-v2.

The PCI Live Update ABI hasn't been in a release yet, so maybe we don't
need a version bump?

[...]

> - *  * The size of each struct pci_dev_ser is recorded in
> - *    ``pci_ser.dev_ser_size`` and is never smaller than
> - *    ``PCI_DEV_SER_MIN_SIZE``. The next kernel ignores any fields beyon=
d the
> - *    ones it knows about, and must handle entries that are smaller than=
 its
> - *    own struct pci_dev_ser.
> + * Preserved devices are serialized as struct pci_dev_ser entries stored=
 in
> + * a KHO block set. The block header records the entry size, allowing th=
e
> + * next kernel to step through entries using the source kernel's stride
> + * even if fields are added in later versions.

Please keep the rules for extending struct pci_dev_ser. I'd say
something like: fields appended to struct pci_dev_ser must be gated by
a feature in struct pci_ser's header, entries are never smaller than
PCI_DEV_SER_MIN_SIZE, and the next kernel must not read fields beyond
the incoming entry size.

[...]

>  struct pci_flb_outgoing {
> -	struct pci_ser *ser;
> +	DECLARE_KHO_SER_HDR(pci_ser, *fhdr);
>  	struct kho_block_set block_set;
>  };

I'd keep the ser pointer here (and in struct pci_flb_incoming) and add
the header pointer alongside it. The header is only needed to free the
allocation and for args->data, and keeping ser avoids sprinkling
kho_ser_payload(outgoing->fhdr, pci_ser)-> throughout the file.

Also, please call it header rather than fhdr, here and throughout the
series. fhdr isn't obvious to someone reading this code for the first
time, whereas header is very obvious and clear.

[...]

> + * @reserved: Reserved for alignment.

Please document that this must be zero, so it can be used by a future
feature.

