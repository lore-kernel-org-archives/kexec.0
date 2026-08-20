Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BA2C5DF89
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 19:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JltQ6Mhzamu5iKOEvRgy+JKSzJMl+WcJVP1h+ocPhQo=; b=V7L0b33Q/Wiu/X37wFfOR4ZKb/
	I9Tg/hHnR3BjdvFwdRcnk7KtmaQn+UpCFbn5a/xix1b+lf56ZvjlcDdAZgHfM//mkcP7lYkVU1OzC
	TVxC98V3R7ml/xhDNusiPq8SG+saH65oa3uy7xU5+SjdM7YJww4KkUzd8jg1Mh3Q/Z7beaGW3FbCI
	/pX96baNuQXgau1q8ZlhrUBYKFGahc+wVZ9u3LSffw3EUd5R+vmwZBbBxuN3waya209meNuHIkm7P
	aUjgoTJBfmzNzNjdc++0GlPZaYr4sI0qCmNtmJ6V8/7rt5OWxRBO/cfPlIbtw96aOUCG3bKEG+jrR
	YB/zMiqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx8I9-0000000C6TU-3IQ6;
	Thu, 20 Aug 2026 19:19:09 +0000
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx8I6-0000000C6Sp-0beE
	for kexec@lists.infradead.org;
	Thu, 20 Aug 2026 19:19:07 +0000
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2d004f13426so2933265ad.3
        for <kexec@lists.infradead.org>; Thu, 20 Aug 2026 12:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787253545; x=1787858345; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JltQ6Mhzamu5iKOEvRgy+JKSzJMl+WcJVP1h+ocPhQo=;
        b=RrjuJOVy4OhUwnA2OFF9HTscAUuUiWmkMiX4aGd2VySiCtumECxfsBLu3H7A3O0ji2
         sExR1cAkc+fTkaQPowYcCXNzCBVH2sYi6TKYdM1Hk/qi6LZ3VIwV0nPWex5zjTPcjYrc
         IlCMzuZQZgEBTha78ICyrYn2CeDdjFc8WeXFUcGRdQdXiY0Mnua0dxFuzBZdDarutRIw
         2+bQmEZM2Kv0pmL9AuxLQfHsRBKlZkHLVYMFP0p5bbJCeE51P/06J+NzB+8EC7MURDcw
         ZQAfxtjLA3Vx1D4XtRXLKXWBM+nQ9AGSg4bNDspUzYqmyGmseT5WKyZSFxP4KtWvnHhV
         QDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787253545; x=1787858345;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JltQ6Mhzamu5iKOEvRgy+JKSzJMl+WcJVP1h+ocPhQo=;
        b=TSg1sqpz0DygXIye5qRIy4rkieab3Z8TeZLnClFzDEafmJhyKp9csZPFrFs7ho5uSU
         9hlkUyF3jyK1/TA0kbKzW0bWABUQIp+x7laCMBIS8vbbPkLmhNrA7N+nbQzizP1T0qH1
         LHvYVBvchOTAjdYUWL5yag1+RcWwyR7L0G3fI2PjYl63XVsWamFrE98CLmR5IRCyRDqG
         4aw0XoIW+nXrmI7jCqX12RLEa0DaW/ks8gLWlx0ota6TnV/VVL2GTiuw/WsDZpM0bBiA
         gcuPT0xFClHSpkIU/8Dui96RhPOwjmpzqihmcnMiDdzp56Sepiu21gwPWlaQBkI2c4ag
         Nd1w==
X-Forwarded-Encrypted: i=1; AHgh+Rqz+onoUe6dmvo/U2LLBLS9w6bCnpH6B9hVq249JdeilgphiMPpQIdo0lbQvxuyaGMg+VRwxQ==@lists.infradead.org
X-Gm-Message-State: AFuF++n3Qx2yJRFkE0YyZ3zT1a0VVefR7kG9CZQqEbMpUjYgMmXunhMY
	nIlY6UKpHDBkpHO0E5qIFzZWFcOxcySbOYUit1hG+am8YyjwEAHQX70ObRavpjVwXd1aIELXZK4
	RNAEW3qDf1JOTfg==
X-Received: from plox6.prod.google.com ([2002:a17:902:8ec6:b0:2ce:d12d:d6f5])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:32cc:b0:2cc:f5b8:4c2e with SMTP id d9443c01a7336-2d64b0cd474mr16550235ad.9.1787253544418;
 Thu, 20 Aug 2026 12:19:04 -0700 (PDT)
Date: Thu, 20 Aug 2026 19:18:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260820191854.1642931-1-skhawaja@google.com>
Subject: [PATCH v3 0/1] liveupdate: Add internal APIs for file preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_121906_188172_9B8AC88A 
X-CRM114-Status: GOOD (  10.17  )
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

Note: Sending v3 of this as it was requested to document some of the
discussion we had on the email.

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

v3:
- Add File Handler dependency documentation.

v2:
- rebased on liveupdate/next to resolve conflicts
- Added a note about resolution of dependencies based on offline
  discussion with Pasha and David.

Pasha Tatashin (1):
  liveupdate: luo_file: Add internal APIs for file preservation

 include/linux/liveupdate.h       | 22 +++++++++
 kernel/liveupdate/luo_file.c     | 84 ++++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h | 17 +++++++
 3 files changed, 123 insertions(+)


base-commit: 3a0b8fa2eb36afc88b62a95f33f0c77c71fa5ded
-- 
2.55.0.766.g2966f0265a-goog


