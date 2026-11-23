Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEB9606A334
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CeZShF0V;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvgjBJDe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=w7l6GOVj1ta19VMv5L9sRcj+U6VdIqUJoDJrYzcoSww=; b=CeZShF0VRfHCYigFQDDsYcDtnI
	5bFTB9A5cqMwrm8ufS2qj5qbYvzrT9kcWseEHh+dL3ljVJw/oQGhcEh3lvFX3z3e6JvDfhZL1kW4B
	d6I7nvKzo7WBlv4SRfGhu4hkRn+8OSpymXg738wxEnB/CsGWBDCgf8bSCsjDxZjbO3lSL/03yXhcQ
	ptlIvYoIGsgOO5G8N1QHuTXU0D/by3UCFhgOJQbzYjrbP/6Wn2JSJDGY4Qqo9w3t8/AKLWdFCy9UO
	Og1m1XQfh+0RXTvC7HCfJKCWVeVu0BHXihWiKqoi84XqVN2gu481UGJ/7JFvEatASmEqZ1L3YnU77
	9l2DFvUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVUTi-00000003fN9-0Gxp;
	Mon, 23 Nov 2026 13:53:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVUTg-00000003fMa-0JXY;
	Mon, 23 Nov 2026 13:53:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6EB7840A03;
	Mon, 23 Nov 2026 13:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0C11F000C6;
	Mon, 23 Nov 2026 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795441983;
	bh=w7l6GOVj1ta19VMv5L9sRcj+U6VdIqUJoDJrYzcoSww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YvgjBJDeY6bRVM//Ef/CR3wqhigSAXRBKPMQZnFSl5rRLTYBReyZxGh4KYDN8PZjg
	 e1+q37zjOWNa/zW6PenUUWn4c+VSxL3VGzz/+YMEB6zdCxuNSRKkYB0fP4i+Q14BwT
	 C/JymHhoTW1bVfQOv01xOXfAgeEuNJ0kuGBFXXQmTrpRqNPhoqIr3HHlAdhY+r4bUD
	 O/4WA+RiRgRRCs1i/0nEIMC5nXuVPNWyHrrDqCwNAZDqOsUYPVCgi46EHQtaywgH7d
	 t/KS4bMveDBrIxMGKCwvWZuMAhNU1gWeMuXMmM73wRDtKsvO63AyJoLgR4ttgh5g7b
	 E3/6pDDp/TlTQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  robin.murphy@arm.com,  maz@kernel.org,
  will@kernel.org,  David Matlack <dmatlack@google.com>,  Alexander Graf
 <graf@amazon.com>,  seanjc@google.com,  jgg@nvidia.com,
  loganodell@google.com,  arnd@arndb.de,  dwmw2@infradead.org,
  baolu.lu@linux.intel.com,  Bjorn Helgaas <bhelgaas@google.com>,
  oupton@kernel.org,  alex@shazbot.org,  gle.com@google.com,
  pbonzini@redhat.com,  Andrew Morton <akpm@linux-foundation.org>,
  kevin.tian@intel.com,  joro@8bytes.org,  kvmarm@lists.linux.dev,
  linux-pci@vger.kernel.org,  Pratyush Yadav <pratyush@kernel.org>,
  kexec@lists.infradead.org,  kvm@vger.kernel.org,  iommu@lists.linux.dev,
  linux-arm-kernel@lists.infradead.org,  skhawaja@google.com,
  sagis@google.com,  linux-arch@vger.kernel.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/19] liveupdate: Reference struct luo_file_set_ser
 via serialized pointer
In-Reply-To: <20261110050202.529473-5-tarunsahu@google.com> (Tarun Sahu's
	message of "Tue, 10 Nov 2026 05:01:47 +0000")
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-5-tarunsahu@google.com>
Date: Mon, 23 Nov 2026 13:52:55 +0000
Message-ID: <2vxzwlq3zmbs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10 2026, Tarun Sahu wrote:

> struct luo_session_ser currently embeds struct luo_file_set_ser directly
> by value. Embedding struct luo_file_set_ser couples the session layout's
> size and field offsets to struct luo_file_set_ser, preventing either
> structure from appending fields independently across kexec.
>
> Convert struct luo_session_ser to hold a DECLARE_KHOSER_PTR pointer to
> struct luo_file_set_ser instead of embedding it by value. Reserve space
> for both structures in each session block-set entry, placing struct
> luo_file_set_ser immediately after struct luo_session_ser, and bump
> LUO_ABI_COMPATIBLE from luo-v5 to luo-v6.
>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Apart from the static asserts,

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

