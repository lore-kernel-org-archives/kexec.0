Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC24C79F8B
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 22:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eSoy4tzP5/vZd/n79Ub53Qw/sODynJmx2A4LOY3bVO0=; b=TmcUcUSBfpYkbIIsnOU7G5tPz+
	HFcZe950ElctfFmHFXjAHC6qXDB+eTI3Z+hu1BkHq3ezGK6cQsDPsluWYaspm8s35HobGkDAwT24/
	yUNt30yemv8ySGg++RrRHnR6tZOrE8lYs5J34ZlIEAPMKd/0m+mTgkk4++L5tho6JFtRWFawftjnT
	QE5222sWUc752psKFh1VWMFzOzDh6onDRzIiRaicxE+S00B/CxICyPFBX2Qhisz/8vqDknAvCDIMz
	XWlYuRiO6zdfTiCON1zcoKF18sz2ezTJMxenOLfx6MPAabOQshsIlrkmJIIiyQbwuHoV3KA8dSV0y
	nKX1QL9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2cKl-00000003NpC-0znB;
	Fri, 04 Sep 2026 22:24:31 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2cKi-00000003NoC-064G
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 22:24:29 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so1304800a12.2
        for <kexec@lists.infradead.org>; Fri, 04 Sep 2026 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788560667; x=1789165467; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eSoy4tzP5/vZd/n79Ub53Qw/sODynJmx2A4LOY3bVO0=;
        b=oyho/LgHsB+V3cdNGQboVNO1+/9x4jR69Obr8Ykma3cI6Ptu9dA4ME/UaHXt5OKTOI
         yDa5nfGTTZAfkzggWLAXNfVJpLxzU1b96+Z1O9Ps+cmIg91k6X0i4QRziTSuKqsp2vQy
         rcn4SngVAx/QDdxKQOITSHE42hgHdEypBc+ak+YfXaN/aA2M779IJJ827lL5lB36cQ4+
         Q08yMfTBHLle6c4D4vtyIm1Qp91cnMcCjc4qLMJF8pG214q0vIlWeowxGbX3tv0lzSG1
         GvkX71yu33SHXXtylyfiF/YBWsmpnDpKjZeP90k7SV7xhNUrHAw3n/YJz1AsuYq3V3XR
         J/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788560667; x=1789165467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eSoy4tzP5/vZd/n79Ub53Qw/sODynJmx2A4LOY3bVO0=;
        b=U3IM3OsPxzN2TpHeW+UCSByYU0XFH0CEvb1Qsl52L5NiiPkcNnhEZKG/Xzx4TmONIu
         RAm1IOGqYKDhCt4MqzgqkURfqo55GoELZz0MYZiWYQffcAqZslvUA2HwmY08kkJKPKiZ
         onKosKT498ceiAKf3YDQ0blTxEXDn+pgKOJ4HdLpfOI8/Klz02f0W3qba0OYz+Wk24w6
         R4Q9TLPsdK/JF8HkmjVjUVTMbfIfhpHqxU4Qrx9LgQOH+6vOyFxCoPpM8letpqVASV0O
         bsjR+52FzU0Vha+CKQWamvLptNzzvSdL7EFLLFUsAGTg0GHGTKZxpe7nIDa6qqVIKF7T
         9//Q==
X-Forwarded-Encrypted: i=1; AKwUvByEuF5pXEsMBDv96Ny/UUUuk1AiH0KXw3Lmu1zVg6arSnd6V/JR31kNXEk1oOcxIYNzpagfrQ==@lists.infradead.org
X-Gm-Message-State: AFuF++k0d7AXSLOL/TJm6h/CSMNgxcORYuII+PwXPhyX8BxelEUPp64z
	iqOfoDJm8x7OH5drXgl0L0JIwCAnqVTvhBtpr9P/PVl48RBCWZsc7jZJAS2JxerbbQ==
X-Gm-Gg: AYBFou2Cg/GNKiUzf+SHJiR/p4cblQLKUtKMal2vNgj7qmqf0NOX+rhyRiMvVGdO1yf
	l34EN/XsMKYi3MwWjAd6o7+xQH2ZRSdNizF+BTtIPEIsBDFy4Ka/TrPg+qhcQeEJG2v9bD1mN8b
	3Vb/mogc9Hl8IR5r8gflpkK6y4gQC9LWK+ZrnjIsP0KFNTYwpTFCxkFY2zxymdGRlyBDHUinjzj
	q7Qop8B/sTsXWoBzYOqJogsVSL7Bit2z3KIxrv6J1wcSPI8jr84BI2RJAnU7Ko484qAaF11VZ9n
	0QMcwtJ6SZcZIYi8gmeXRo9wYSocKA09W2DCV1mB1KIos0RGV5IHglwr2dp0BulBcxIwe/7/fgX
	7EgVuY5epn9h+l5W/t7KaW5ut69wF/U3k1DuRLmWdbjMVBnTRYu987Ynl/ie557Kqljyu96aicx
	azKJNQ17+ekfIB0eO6dnAAEUXIIhP8XRQraKfYUy6Y7O7VdjD/bfhs3XJg+/v2twj+9LWzsd8QP
	Nud9RIUcMnGTBfxU35lAwQdTkU5eQ==
X-Received: by 2002:a05:6a00:2e99:b0:84c:4b58:2cec with SMTP id d2e1a72fcca58-8616b26f6bfmr12056954b3a.15.1788560666130;
        Fri, 04 Sep 2026 15:24:26 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86153a1c1basm1621740b3a.52.2026.09.04.15.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:24:25 -0700 (PDT)
Date: Fri, 4 Sep 2026 22:24:21 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Odell <loganodell@google.com>, arnd@arndb.de,
	pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, pbonzini@redhat.com,
	maz@kernel.org, oupton@kernel.org, seanjc@google.com,
	bhelgaas@google.com, alex@shazbot.org, kevin.tian@intel.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and
 memfd ABI compatibility
Message-ID: <aptFFYqcSiBdMLE8@google.com>
References: <20260903023452.721732-1-loganodell@google.com>
 <20260904160009.GV4157646@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904160009.GV4157646@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_152428_066538_6B9EFE34 
X-CRM114-Status: GOOD (  24.04  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2026-09-04 01:00 PM, Jason Gunthorpe wrote:
> On Wed, Sep 02, 2026 at 07:34:49PM -0700, Logan Odell wrote:
> > We're including maintainers from all subsystems that currently is or
> > will be expected to participate in live update to ensure alignment on
> > the path forward for compatibility.
> > 
> > Currently, Live Update Orchestrator (LUO) and its file handlers rely on
> > monolithic compatibility strings (such as "luo-v5" and "memfd-v1") to
> > validate ABI compatibility across kexec live updates. Any modification
> > to serialized structures requires bumping the version string, which
> > strictly breaks compatibility between adjacent kernels even when changes
> > are additive, backwards-compatible, or optional.
> 
> That was the intention, I aruged strongly that upstream does not want
> to maintain a CSP matrix of endless kernel version combinations. That
> is far too much work to push on maintainers. Upstream would do much
> less, maybe only same-version, depending.

We received basically the opposite stance from Sean regarding the KVM
LUO ABI:

  https://lore.kernel.org/kvm/aoSCCTTBn9D5hqzk@google.com/

So we're trying to use this series to get some alignment across LUO
ABIs.

> > This RFC series transitions LUO and subsystem file handlers to use
> > granular feature bitmasks instead of compatibility strings. We replace
> > the compatibility string with a header structure that includes some
> > reserved space to define the features that are included after the
> > feature.
> 
> The compatability string is only a small part of it, you also need a
> serializing ABI that can handle some random mixmash of these
> features. Ie the various TLV schemes that were all proposed. What is
> the plan here?

The proposal here (which is inspired by the KVM UAPI) is to ensure every
LUO ABI struct has 2 properties:

 1. A field to encode options/features (e.g. u64 flags).
 2. A way way to grow without breaking backward compatibility (e.g. so
    we can add new fields).

Each flag can mean whatever it needs to. e.g. It can indicate the
precence of one or more fields (i.e. new fields in the struct), or it
can mean a field now has a different meaning (i.e. union in the struct).

This would enable adding support for new features without breaking
backward compatibility. Downstream users would have to ensure their
kernel does not start using a new feature while it can still rollback to
a version that does not support the new feature.

