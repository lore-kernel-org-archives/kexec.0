Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBBCC531CC
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 20:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a2KNuiqZLV3X87jdwCQu+pUu3Q/Kmj/vy5AMT72i4f0=; b=GD3I19NJ636fOIqfABW4wYmjbo
	DeReff47+h5E82Ukl42Y+GDZDSEA8Ho8UMzpnGa0c5UERYK0TL3KfEpjw1pAdNveJGa2Z7G+qDo8O
	saBb5dOAmT9pfmf5wCV9BCTeKq0NPTn+l0vo7X4KvYBuD7Hysjym94/4wlr2eNa3IJt8asr0JyPJG
	ATZYVosHyrcSnjw2td6Z/LPmHEpT5c6TztpkEpEPr0Hrh9Xh/+5GT1kbo0ZJaWsooZn68afPcSyzU
	B868giGVrVL/2DYBGOhDrmcZ2CV2vcOlcYUuazvxAqPdfvSw6mENN3qGgS+dKUVnNDZOPGefjhcvy
	JbIF9tgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn02v-0000000F2dS-06Q0;
	Thu, 23 Jul 2026 20:29:33 +0000
Received: from mail-pj1-x1048.google.com ([2607:f8b0:4864:20::1048])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn02p-0000000F2ch-1OKy
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 20:29:28 +0000
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-38dbf293831so2608550a91.3
        for <kexec@lists.infradead.org>; Thu, 23 Jul 2026 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784838566; x=1785443366; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a2KNuiqZLV3X87jdwCQu+pUu3Q/Kmj/vy5AMT72i4f0=;
        b=JHtSPTd3HVOh+o3/MBTiUjX1A5ljzT3bkTxUIOVN/gMdh9pZxYSIHRcAVi4McXeV3P
         glfIwzakC5MDJ7s+hgZdX1/wuMdhwsSeIoiZ9hLS1tar7quxIK2WJHY+Puhy/MiLpYns
         coVRemyINDgQVn8zOj6BsFmSKcEt/nMMPKp6GeyXgSZgHniMQYo9cOasjrwTCUNeJ9l6
         SSMBtTfvYJ9HycHRoXB5VKfJMqSi6JIvqAVUKCq1VMh/WMt74plxKtjH9B5L143/hmtg
         xn0I1RMiio6qkoCoqjzJb1m4UJMSa7EJsoeteUCZhHqR8xXwkYN/v/9B79ZaP/xo39p2
         mg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784838566; x=1785443366;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a2KNuiqZLV3X87jdwCQu+pUu3Q/Kmj/vy5AMT72i4f0=;
        b=Wv5jTk5o1EbOnTkZPQWT6rMQg+yTeg3h8BC3VLWBMXyg/zPcAWyyLtks5YJGjY15G0
         IvJk26O7iPA2SzZlHhzdkWGYqgcWqdb/dGpCa8dczvg6SUhU2cb5kFu7X/Jpg7OF8A38
         2eiNmZax6tDctOzzflFWoKF9JvAkEEmEOVt49KILbm66poWPMAEjWuRE2+AHGRXbM4jX
         gagitNbGA5adtYVnWo8Cx0n1IXVWOTy/aWykthF2j5yRN5/42zXmSMMwoYtcmOY2LNEp
         29oHdmRfmE8KepNsOsPf5010C3M2gh3q/KOEsHvKTp/77lL5FhZp2Li0atOueF6d6ETs
         fxaA==
X-Forwarded-Encrypted: i=1; AHgh+RqAgpZtLjz51Wufx9K0WMKmUBEvmd3l1bMU4Na/zaFRzWL2gdO+s7oVsFd7jNhtob8FtV0G+w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwGSQXFvdNR59QFE5i/HBGqKmhHgZFaqzsZI1Qya7NDGeuLOY/l
	1BvFEAPvlqnGFx7eID4GThqrsWGS0LKSgl09EFwr8IGRJ2a/Oihjr+Nn+n2Plmddgwj5gJc661t
	YYUNjpM4QDE/Mvw==
X-Received: from pjbmh15.prod.google.com ([2002:a17:90b:4acf:b0:38e:ba48:b0cc])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:134d:b0:37f:9ce1:cda4 with SMTP id 98e67ed59e1d1-38ec6650501mr4883813a91.26.1784838565570;
 Thu, 23 Jul 2026 13:29:25 -0700 (PDT)
Date: Thu, 23 Jul 2026 20:29:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723202912.1467112-1-skhawaja@google.com>
Subject: [PATCH v2 0/1] liveupdate: Add internal APIs for file preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_132927_400687_E566E4EE 
X-CRM114-Status: UNSURE (   9.91  )
X-CRM114-Notice: Please train this message.
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

Live update orchestrator file handlers depend on the preservation of
other files. To make sure that the dependency is preserved, the file
handlers needs to fetch the preservation token of the preserved
dependency. Similarly during restore, a file handler wants to fetch the
restored file of the dependency.

There are two known usecases of this,

- VFIO-Cdev preservation requires the preservation of iommufd. This is
  required by the IOMMU preservation series:
  https://lore.kernel.org/all/20260427175633.1978233-1-skhawaja@google.com/
- guest_memfd preservation requires the preservation of kvmfd. This is
  required by the guest_memfd preservation series:
  https://lore.kernel.org/all/20ae20f9d1a198b289444ebb4c824314cbba1bcf.1780676742.git.tarunsahu@google.com/

This patch was being sent as part of the IOMMU preservation series, but
now it is being sent separately.

Note that LUO File Handlers may resolve the dependencies during
preserve() as freeze() is very late and past the point of no return.
Also FH might have preservation requirements on dependencies due to
immutability, security and performance reasons.

v2:
- rebased on liveupdate/next to resolve conflicts
- Added a note about resolution of dependencies based on offline
  discussion with Pasha and David.

Pasha Tatashin (1):
  liveupdate: luo_file: Add internal APIs for file preservation

 include/linux/liveupdate.h       | 22 ++++++++++
 kernel/liveupdate/luo_file.c     | 69 ++++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h | 17 ++++++++
 3 files changed, 108 insertions(+)


base-commit: cecfb90c5f2cc0622b363c2291b69d6cad272897
-- 
2.55.0.229.g6434b31f56-goog


