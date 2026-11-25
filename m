Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC08606A327
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wKmb1AQK;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iQTIcM38
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=; b=wKmb1AQKjCUvDl
	Ag/jcTmaDZuJgycxeVTPUvmDja/hoUgX/aiJikRFIcgeyxs3coNiwupeIWskWwGVmuixsFzcSix07
	27XOAqVhYmRMXzqs5/TAgaKrywNZn3of2/Y1LPl4v9ZypAYSkDiup/opJhRwKG9FFa7MZVhuLLyV8
	M3kGS2vDyJy+ldRqbvbVqVt/1YikNHcDKo0nBA8DrmS0pMrp+kMGRsuiUDSWwUpH3rYfHn0qlpZuE
	vHBXStL+UydkBCw9qmgVTUF9SCzUyGft/r/IvV88EVww5icJXCKA2aZHNk9RHw9035LN1oq/xz7VV
	UCu6ExEoTP58YLzPgj9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWGzK-0000000AlfS-3XW1;
	Wed, 25 Nov 2026 17:40:58 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWGzC-0000000AldU-1e9v
	for kexec@lists.infradead.org;
	Wed, 25 Nov 2026 17:40:56 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-cde1479f76fso3405772a12.0
        for <kexec@lists.infradead.org>; Wed, 25 Nov 2026 09:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795628449; x=1796233249; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=;
        b=iQTIcM38KYTc2l5/SJ0hgwkNdV8utL2N/rxQowY/LCJyb5Ubbb73VBkG3+hZkiy+DY
         1N09uFSoY1QWaXCjZC530YRDJ5JB04csFB60Ob+P+WghfUfCwp5isZSOVZcBCWJSBgZ6
         3PE6CrTvQP+yNq5n4z0RljvJQKYjaKgpaZ+nNG24rLCuW2CF5mhOdM1rDSvP+36NjQ18
         6f61BcwBhlTe7T/FD6+DuMJdWJwqPmeAk0y4RKbwtDaNn7Npj9/zTTdS5VeELrVj/qyQ
         RiUQYxd97n+sLrZV8KIXe2/vQTQYeReSyBXrnNUVzgKJXkml5kZA02nUs42Faq8nmDYw
         +FLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795628449; x=1796233249;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=;
        b=i/dUwj/FX5dDFxTyj3Cz7GRqZi1GScnjcnlt3C/byaIY05PNgTO5XtO/yWmHb+RnLz
         FxC7GDIzQWFwAl0eb4f5xqCbyrR9iwuMVHC9El7jUvnGOFJX+H1ZFIGuklcjrpDHyCXu
         PkAfyndNSaGswt6cZnhFeMHwK1P6rXc5adhU4EP1ghS7RnUvP+Uxb+xg5Sp4JcZjQDrP
         m5dRXYveWdlcKrsKLf0CiFELpeAu3iOoXwn4obN1QuY/AzkGQCgL1RcM5cOp7w1g3Psd
         WMV5mjL2OtVxe0IOUZD/slhg7Gixna/5b7Lo8re/4oQ0pgv15tXcq70Yw6k9MQkIxFGH
         GxuA==
X-Forwarded-Encrypted: i=1; AL+hErE54eBPs2p5Tp2uLW5iEQOixSQJDZG0288ehSGgDBOTysZerPU/XJbYJttLCJmQDdrBo6HDgw==@lists.infradead.org
X-Gm-Message-State: APuU4Z8eocdZ45cyupGnwsrZQuo+LeXIoE8yI+rF1LEc6UcPnM3TiejW
	tos5TWb8c022X8kQn5GzMObw1D1T0KqBcOpfdFa43RGMFhqWNzENhPBdHJbcvt25HA==
X-Gm-Gg: AZFdTZcMIyrAJH5PJYAcTMoL+4k4SDUxL74y+Jbnquu7P/+huDNk4ZOkP+cneVa3mxb
	fD6F08vXmZlFw4inh9VKsc/VvFHI8Icm9xt2eowAfhyH3+DKTSRcvIo8Rl9LgHMTpkMva6aPQMB
	BFUM63YPvrSZZiSK9UoOFh0rwCDmPAy4qjwAl637AOrpu5h6GNRUfyWXk1RhhPJ9C4d9vJVaY9F
	VLeTu3qUxf1iSqHK5JGkjRYBZoxqSmwZ/mxAymphgE2XuDqDk3zpWys6mFoCDhOhcEhmNGwUcxn
	dV6fatDfvKrSG+k9xInqvo2t81Kzd6W4F2L1iH/IqWdfBEEbXrz5e2zLUCNskKrvgIe6kh2CPRr
	OKVYUaEA4XJjmhok/Ar6vtzYstr2PaWfMkrL++R5QmRSRVlRf8zdDptOhvLUAVeQHOUSMOGOGuT
	Y380JWDUc9CxJFxBU0/IyvwMAPSAKb0mf6c/z2UZ+w5QwVwzJYklrBY50VV8GP2xjtibkSgpx1R
	x4jArCrz6gjbHv8b5oAAZhwr4AZFyF2Yva22qMHKOQU8AmzdckWjv3weH45HUjAL3bGlvoSfzdJ
	2sE/2KhESq6Hd6cfbF401A0+qlv2TvPe/6YN2rqOoYS4dLnVbNqKLRTlG2J9c7Pj
X-Received: by 2002:a17:90b:390b:b0:3b3:fe22:2745 with SMTP id 98e67ed59e1d1-3b41c933edamr18216503a91.45.1795628448898;
        Wed, 25 Nov 2026 09:40:48 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm31676002a91.15.2026.11.25.09.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 09:40:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 09:40:47 -0800
Message-Id: <DN4H5ST3X9L1.3IUEC1CA5QI8H@google.com>
Cc: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
 <loganodell@google.com>, <arnd@arndb.de>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <oupton@kernel.org>, <alex@shazbot.org>, <gle.com@google.com>,
 <pbonzini@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <kevin.tian@intel.com>, <joro@8bytes.org>, <kvmarm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
 <kvm@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <skhawaja@google.com>,
 <sagis@google.com>, <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-4-tarunsahu@google.com>
 <2vxz4idb1i2w.fsf@kernel.org> <DN3VG4JCILOO.YN40XHHSWRPH@google.com>
 <2vxzld6hx97g.fsf@kernel.org>
In-Reply-To: <2vxzld6hx97g.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_094055_544344_99AD2A8F 
X-CRM114-Status: UNSURE (   9.99  )
X-CRM114-Notice: Please train this message.
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

On Wed Nov 25, 2026 at 6:43 AM PST, Pratyush Yadav wrote:
[...]

> So I wouldn't want to support slab until we have file handlers that
> churn through a lot of preserved objects.

Makes sense. If KHO slab isn't coming, then I'm fine with the arena.

One thing I realized is that the choice between the two is visible to
the incoming kernel. With separate allocations, the incoming kernel has
to free struct kho_vmalloc and struct memfd_luo_ser separately. With
the arena, it must only free the top-level allocation. So we should
pick one now (while memfd is bumping its compatible string anyway)
rather than switching later.

Separate allocations leaves the door open to KHO slab but wastes memory
in the short term. It's not obvious to me which direction to go :)

