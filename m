Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A6DC4450C
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NOi6e266Y3mSv+Tn1Q4zn00EKJBjh0V4SkK/1ApFkGE=; b=u9+GSge3T4IagjgjPEuFzqg+eK
	PE8/+8EXeJuYivGGUuRQRhYUwtYqb6nSo8LpTHpSofrAVCF18oAiAmkldn4w/bq40aY1G12PPiENT
	KcFIWarlZ8T53uKSDm7gkBMVs6OfVC439hX8UvIHhXVn3wHslwVK9DIFZ5kmfIAUwhumrgrxDOhHN
	8O4FrUvtBTRRgRz4VaSAm9lMsdd8dhGlJYdcGxEN22ATzYWWi9+NAqBAkWSkoaTlL2/hL6yYLBAI8
	HL9+AHgOBpmF6FKEKgniMEkUzO3R3m4kYTjJdAcSiNlRpN890di0V8aEmflheGaK87ctbPszy7852
	73RN9tyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqq-0000000CU4k-18eN;
	Tue, 14 Jul 2026 15:15:16 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqo-0000000CU2p-0Zts
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:15 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-84854c2f888so8130584b3a.3
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042113; x=1784646913; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NOi6e266Y3mSv+Tn1Q4zn00EKJBjh0V4SkK/1ApFkGE=;
        b=NwNCKAmxzoLhxaozEHlPNJt2s0nOG+gxOZrSDG8QqJ/AbOK0cAY2LSJweJ1nyNZ6BW
         6W+iEOSWqO0sQepauGdj4SDFxjHfIw+v2YAv01tZ6Jv2+qpfgtS0Jo+88qQZaP4b4ekL
         qH1R3eIi6ta6HHyDWgqrpykh7UDyTEo0EhitewrKj41aaf9aMSmsNr4hH33Us3fki0Bp
         eZTmmTHh0R+epOd2BE8kW95VD+Nvqnuh1xqtSN9lkKaWivSV4zIL0FQ5c8DXhv59a8TQ
         3l8hke+Fc1xsuSq47TfFqoTPGfU/a6APFUKpZtmWCy+WMQHn8iZnN2KuwZUAPLonH+Iy
         Cr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042113; x=1784646913;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NOi6e266Y3mSv+Tn1Q4zn00EKJBjh0V4SkK/1ApFkGE=;
        b=mm/oyokIKVV5/jq5nL6DaGGig9Zdmp9zfzYUCbMNUbuhUGbcGDPtH2fXepYxDaxBUm
         v5bedVoFdmY5x0xYzrgHiiZxttz7zXianzWXPLsEW/iFlhDcUwmm/YxeIs88dcpfI0bE
         Kej/NMo6BehBpdBpn2pqDrBdfpcutvQGHax4VgXdCBfMchnplF9NmCi/OqvQZGVV85Uw
         t21UMoVLL0oEZhFAS9s06xabCgZthZn5/SK/2HVI2ST7dVkVqYBVa24bxkP00I1b5rdB
         HtNeCQ342AMCPkFwwRfqc1jDHyfs3Yp8ZGrVgqy5udAshWRfOFZQ4Q7UFNk+nbWAHdlK
         g+Pg==
X-Gm-Message-State: AOJu0YxuHsOXkkSMKfXNCCttrnDMv8iysUYDXPJzI8IV2X1+TVOI+D7K
	qChL2njsuJ/sj8TqF7KN1ejOBRVzQ48bX4txY2un0PNL2hMxcuDUo84L3k0NEAr53FPAbTGcnXS
	t8izMNtW8XwrdS/jPbhvlUmYWeGv0KSSCuzHmhJ0TnMY7fLY0bd4BQEXrzbJVBmtqqb1Y9Sid4A
	7xdN6BcCQPM0V/zentvO1NQ1xCEiAnq5uV3kswUtZiKSL6Fg==
X-Received: from pfee10.prod.google.com ([2002:a05:6a00:bc8a:b0:847:a829:37d1])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a27:b0:848:2f7a:2e5e
 with SMTP id d2e1a72fcca58-8488976671amr13012571b3a.77.1784042112537; Tue, 14
 Jul 2026 08:15:12 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:48 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-4-vipinsh@google.com>
Subject: [PATCH v5 03/20] vfio/pci: Export vfio_pci_dma_buf_move for vfio-pci module
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_081514_219424_514505C1 
X-CRM114-Status: UNSURE (   8.42  )
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

VFIO Live update during freeze needs to reset the device before handing
over to next kernel.

Export DMA revoke function which VFIO Live Update will call in its
freeze before reset so that P2P DMA doesn't error out or cause some
other issue.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d6..2c05fb5a171a 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -376,6 +376,7 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 		fput(priv->dmabuf->file);
 	}
 }
+EXPORT_SYMBOL_GPL(vfio_pci_dma_buf_move);
 
 void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 {
-- 
2.55.0.795.g602f6c329a-goog


