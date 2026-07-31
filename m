Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48F5C55177
	for <kexec@archiver.kernel.org>; Fri, 31 Jul 2026 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QMT8aJxPN69Dyrd3LsDwUHfdRMUYihjZGyjp7f0vmTQ=; b=K0Pz3A53c87qbYpS/Mbx2cwT70
	4db4nB0v7EawJwkYWa0oqF0e0YpB2Uo8VKm87vE+2gRuxaXBDDXuywZJDIiBUsKMJVNwy1GzrRmHv
	vjTdWfsVEbDsnX6gXuBhjJFrfB+vxMgDI1oVJeKIGRnoNa1MENVtQzMsw43MGm1Yrh9JAAp+PfPek
	o60Aqg9sRVgZA7a4EvCZydMLSyi0RronGmHFwUGxxa7a3+1Ezi4Ykz0C7T5WLP9MiCYTqmcCMNxaf
	H2w/5SvS6BFVpAZcuiMWYJ2l+8xlPNxDVUmIPFV3rxd6MkHvEgaCFgqPA+7flt9Zl1A6tGFP2+7Oa
	RQN+77HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpvAT-0000000DdtI-2eZP;
	Fri, 31 Jul 2026 21:53:25 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpvAR-0000000Ddr6-0bHI
	for kexec@lists.infradead.org;
	Fri, 31 Jul 2026 21:53:24 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2ce8a76df2dso22948485ad.2
        for <kexec@lists.infradead.org>; Fri, 31 Jul 2026 14:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785534801; x=1786139601; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QMT8aJxPN69Dyrd3LsDwUHfdRMUYihjZGyjp7f0vmTQ=;
        b=J4/Qgil3bt0m0o1oThMPCbsxw64/05xkLtTaENBS8ZWQ4Ask2fs/Syf4kZoCbUKn/J
         yuEvdU/WeB/oOaSPHTDCH7516PhqJuW8tM4/f9ca3ABU3t9b1DssRf3zw2XKmq8VHm15
         OjciuFC4nQxXYBhJyU42NpSKM9C960FE+rJCdc44j+Q7kZT/Q/SLkmGtEvbtryQYB1kU
         9wgPy3b1RMDI/SeBTrzr9BvUfPqP8O6URS5xX2FK00+UNzqycduLFCZLi9iLiWUgsEeR
         1spLLpn3tKCRDt3U/OI1gji+HCyYlywr5iWyyyHtzP6H4fVRDC1O64lQdZsEI682pGTm
         5hVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534801; x=1786139601;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QMT8aJxPN69Dyrd3LsDwUHfdRMUYihjZGyjp7f0vmTQ=;
        b=XsdyOURjciXnJBOkBsJ0iksp7DlHCIWMmtdYP/jV2vNDXymquYgRjTdG2LPg6j1+zB
         5pQfI5Qtywqlmydy7YcUBjnJtW/xGiitj7IsUCqG4sHezsjuVFbQlGR3opws2+bUrRX8
         pME0i/UmEhp6gfQJP7QkNFUan5S2OmRaD3d0NotzHd+T+eFxvV8B/FkbG0oqiUcdDmG7
         itC1a1Vi5cpuGZLvt/J+ZXtpz1tVmkKjNYUF7PTv6Pe2c/AO2ifBOCpFQgg2VpGRCVle
         DYQi4khLU3jeCXFYl1la0RgwA8bxkNcrXgrkfV1J8LE7s5VwNBPzA3ugaU4SWoqEKodh
         9NMg==
X-Forwarded-Encrypted: i=1; AHgh+RoxoxDmhQ1SRmHGKLojAnAqKIAyur3YBedur4Pel9L3voktKeEa3RyZxPipaTuxxyXTm4fMIA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxcvjivaq2w8aBNN4Gf+3C+65oHfMm+7NHkOxoCiqJpp/2WH259
	nEgEVFKkmcegLFnhfeWjWRnNoyWSb93VDKl5Jug/uuNreDfwrrdfb84yZMo9i/thfNQ0gqCBPLu
	2e4fPp6a67lPasEGZYS5M8w==
X-Received: from dybhd40.prod.google.com ([2002:a05:7300:e128:b0:30c:5a76:5abe])
 (user=loganodell job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6f07:b0:3b4:7e2d:a3c2 with SMTP id adf61e73a8af0-3c92a52a045mr1268067637.18.1785534800614;
 Fri, 31 Jul 2026 14:53:20 -0700 (PDT)
Date: Fri, 31 Jul 2026 14:52:20 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731215224.831696-1-loganodell@google.com>
Subject: [RFC PATCH 0/2] Add support for multiple versions to KHO
From: Logan Odell <loganodell@google.com>
To: graf@amazon.com, rppt@kernel.org, pasha.tatashin@soleen.com
Cc: pratyush@kernel.org, akpm@linux-foundation.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Logan Odell <loganodell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_145323_189304_8D00CD8B 
X-CRM114-Status: GOOD (  12.15  )
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

The format of the preserved-data blob that LUO saves to KHO is expected
to change as new features are added, bugs are fixed, etc. Currently,
LUO handles this by embedding a compatibility string into struct luo_ser
which can be used to compare two kernels. This works if the changes
between kernels are fundamentally incompatible. In a case where a new
feature is added, we may want to support both versions in the new
kernel to retain compatibility.

This series adds a KHO interface to embed multiple versions under a
single node in a subtree.=20

We go from something like:

       / (Root Node)
       =E2=94=94=E2=94=80=E2=94=80 LUO (Legacy Parent Node)
           =E2=94=9C=E2=94=80=E2=94=80 preserved-data =3D <0xphys_luo>
           =E2=94=94=E2=94=80=E2=94=80 blob-size =3D <0xsize_luo>

To something like this:

       / (Root Node)
       =E2=94=94=E2=94=80=E2=94=80 LUO (Versioned Parent Node)
           =E2=94=9C=E2=94=80=E2=94=80 1 (Version 1 Node)
           =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 preserved-data =3D <0xph=
ys_luo_v1>
           =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 blob-size =3D <0xsize_lu=
o_v1>
           =E2=94=94=E2=94=80=E2=94=80 2 (Version 2 Node)
               =E2=94=9C=E2=94=80=E2=94=80 preserved-data =3D <0xphys_luo_v=
2>
               =E2=94=94=E2=94=80=E2=94=80 blob-size =3D <0xsize_luo_v2>

We can also support mixed mode, allowing backwards compatibility in case
of a roll-back to a pre-multi version kernel:

       / (Root Node)
       =E2=94=94=E2=94=80=E2=94=80 LUO (Versioned Parent Node)
           =E2=94=9C=E2=94=80=E2=94=80 preserved-data =3D <0xphys_luo>
           =E2=94=9C=E2=94=80=E2=94=80 blob-size =3D <0xphys_luo>
           =E2=94=9C=E2=94=80=E2=94=80 1 (Version 1 Node)
           =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 preserved-data =3D <0xph=
ys_luo_v1>
           =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 blob-size =3D <0xsize_lu=
o_v1>
           =E2=94=94=E2=94=80=E2=94=80 2 (Version 2 Node)
               =E2=94=9C=E2=94=80=E2=94=80 preserved-data =3D <0xphys_luo_v=
2>
               =E2=94=94=E2=94=80=E2=94=80 blob-size =3D <0xsize_luo_v2>

The first patch moves some common functionality for preserving a node
into a separate function. The second patch adds our new APIs. The third
patch adds support for multiple versions to the debugfs entries. The
forth patch adds new test cases to test_kho.

Logan Odell (4):
  kho: Move subtree blob logic to separate function
  kho: Add support for multiple versions in subtrees
  kho: Add support for multiple versions to debugfs
  kho: Add test cases for versioned subtrees

 include/linux/kexec_handover.h             |  14 ++
 include/linux/kho/abi/kexec_handover.h     |  16 ++
 kernel/liveupdate/kexec_handover.c         | 234 +++++++++++++++++-
 kernel/liveupdate/kexec_handover_debugfs.c |  57 ++++-
 lib/test_kho.c                             | 266 +++++++++++++++++++--
 5 files changed, 540 insertions(+), 47 deletions(-)

--=20
2.55.0.508.g3f0d502094-goog


