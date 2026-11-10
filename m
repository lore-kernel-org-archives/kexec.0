Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E14606A32D
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Yc4LlKbK;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CgLIQfBc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FNcC9m18UoMJxRcJEPoSUxoKZdU2fxVY/XU8PXnrjcA=; b=Yc4LlKbKv7pfls
	OL49dSkiayepcxmLGv+9qjtAIUO4UbVCKwdxqasyDTnpxLRPfExQtG3EqHkDVYzk6h8Mqa22lSbH0
	dI/FB12jJYg6TeyoY4eTU5UD0BLn3iWiNKRJZOXMQ9whTRE9Aj3FqGsadpo391ul+wQg9xK3U2QbG
	SawzUXzUbq1yxqk5bpYYT3Okc3UiLoJ9Gc3zFKGqOnC12BmZoOuc3Yp1bPkIdlzzrCaFNpJCR/D1T
	5EUN/OZh3+tiWbQgNnOk85cbfOWmasGxPccA/gsX2lP/HCo7hqF3cmB91z7N3UlPdaSkT6BpBKL1o
	ueOgyceD5CaIhTNtHIIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQpJh-00000004d0t-2tHL;
	Tue, 10 Nov 2026 17:07:29 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQpJe-00000004czo-2Crj
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 17:07:28 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso1087610a12.3
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 09:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794330445; x=1794935245; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FNcC9m18UoMJxRcJEPoSUxoKZdU2fxVY/XU8PXnrjcA=;
        b=CgLIQfBcWorczUVQQ6iNeoA88wLFgdUG9oqQS+AjTwv6m+69ROyfyk8OMt34/EcJnP
         UDiJx+YJbUBe+4BWtLSHLiFlfRvC0ChPIKAUnySZqrQrR56kxMWmd0hE3+HJXUvmIJjA
         oyF5sBKK9HVn1bkSaMz+CBrbBZELvVB1dPqENQz1FLYm+KfZdhI8WpZCdwXcrhb8hbtw
         mOCHI/myPJt4DZIDmR1KEbfABgNRQjsj9YYu1pUGMiLo5H3x2Dg+f54Zbe41oo2HA9BK
         oTuwNz55XodXsht8SWkBA/jupHnu5sXY4c5wknXYRhX3ffypDmuIOWW0HJWObzE/tmxb
         O9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794330445; x=1794935245;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNcC9m18UoMJxRcJEPoSUxoKZdU2fxVY/XU8PXnrjcA=;
        b=Q3yb/HnpsF7W2Qpcq4fh+psH2QuPpJfEoxWisoCOQ9VX4Og7GgFraCPwGeLu/7KZC3
         fGoD5Ue+1Wvo7dJqwQp/qannOfHEPQkxjQSP1UcXuKX9xITdBwT3TkEueZErQFLI9QlJ
         8VmlEV7vlCzgsv1A9wQvltGpogntXVZ10YwDkwpKvxF959/OhnYm4fDuliFFD7tyIQYr
         qTa+60zdtk4Y1VO0UwQT6/iI7GgVaRbNztHtbKmIrfh3mr95femZRQmmKVJFAv6F+iJd
         3KXb6hOclkNRNN/x7+2QQU3fk6k46coUj1AXLPBLqm1kPo6NZp+6aw52b4YPLwLi5sQg
         w+tg==
X-Forwarded-Encrypted: i=1; AL+hErHNWmaMyEmhQ5JpAVJrE3e8ZS/9peqRIn9q5U/9fcdNQYtszzu4r6TPyLz6rsq980ZqreLU4A==@lists.infradead.org
X-Gm-Message-State: APuU4Z8/avDLwMaiFzOnfQVOfRjTNVnurGetJbLwPwL/fL2nRAUDlCWE
	FrnNA7o3NDvTChhxDR9H/2igwM7Ey2ocKH1DLootPmAq/rS+YQHPi8trwNH/+Hy3/g==
X-Gm-Gg: AYBFou2fxNOUJnbZVD0LJZhbvNWCQOJ+whCbepRY036XP+WJ5HpK6SY+J5NEcrieoWG
	e8NAWuAOipEJHHrqpu3GKpdwPWtufDims0eGXMkqMdvPW73+Ihqfj0MVK2Jpn4DPiFaxyL9Q5tv
	f1hfY57QE7iifC9y42rA34jc6WSIlL/GpHfOEf+uLnI84XosC/5vfYNjQLR0NlYyDb2L6VtS1U0
	VPhV6W1wyGULDuSf0bSHZLpEbZLoZZ1xyrp3Hk4YGLyziXRyznIcjh2lplV+QhcUjDgrUZGQiBH
	HYKlE7qqF32tc9mtiZNSz81cCyXAszBNiJ/TkzdpdlT5cj/L0Rd7RhfHGTEJOD6OsSMOKjtdVxz
	nKF8fsQXyuCKcC3RrvnoCmLCBvmIOhd3ajuW00OsbrvguAM/hl+R8Mn0rQ7Ic5gbF16ZXbYA4TW
	6zJUWFUEGH7cs+SKIJob3ps+AQCRSv37y7UVO+LlLAo2y77QOi5CikBWOuM65GbVpWQVawIAm3+
	qe/JbaMEaEdotq8t/Hvu92zQ2xNQV7LgDc0kmF/WfoFjqA92bJ8fSfq88H1BmItivpMcjfVHjNr
	JM6zM9m4YQWmeM9M2jHvduCdKKH40renYZaZSrYBwkfLRZFNL0MhPlEuwy+CY6f7
X-Received: by 2002:a17:90a:e7c1:b0:3a5:133:ca5f with SMTP id 98e67ed59e1d1-3b166cdb54amr3659496a91.46.1794330444574;
        Tue, 10 Nov 2026 09:07:24 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db56c7esm499973a91.8.2026.11.10.09.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 09:07:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 17:07:22 +0000
Message-Id: <DMRP21FATCC0.ARAURXWV85JP@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/19] kho: block: Add the feature header to blocks
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
 <20261110050202.529473-9-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-9-tarunsahu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_090726_560103_11E50D5F 
X-CRM114-Status: GOOD (  12.54  )
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
> Precede struct kho_block_header_ser with struct kho_ser_hdr using
> DECLARE_KHO_SER. Each block in a block set starts with struct
> kho_ser_hdr followed by struct kho_block_header_ser. Serialized entries
> start immediately after the header payload at offset fhdr->size.

This adds a feature header to every block in the set, but the layout it
describes is a property of the whole set: all blocks are written by the
same kernel with the same header.

Blocks are only ever added and removed at the tail, so the head block
is stable for the lifetime of the set. I'd put a single set-wide
header in the first block only, e.g. a struct kho_block_set_ser with
its own feature header, and keep the per-block header to next and
count.

entry_size (added in patch 2) is another set-wide property that belongs
there. All blocks in a set have the same entry size, so recording it in
every block is redundant, and restore has to check that the copies
agree.

[...]

>  		entry_size =3D ser->entry_size;
>  		bs->entry_size =3D entry_size;
> -		capacity =3D (KHO_BLOCK_SIZE - sizeof(*ser)) / bs->entry_size;
> +		capacity =3D (KHO_BLOCK_SIZE - fhdr->size) / bs->entry_size;
>  		bs->count_per_block =3D capacity;

Nothing checks that the blocks agree. Each block's entries start at its
own fhdr->size, and count_per_block ends up being whatever the last
block implies. With a single set-wide header this can't happen.

