Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C49606A681
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3Fejj2vT;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JcGfXbX4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pH/xf3kQm7acLfNhYZrfRJLXvU+0NBXvSnbGGfIqejo=; b=3Fejj2vT/EBSK+TrrPtaTX4PL9
	aPnPsWM5snsce1UcmJchWwdeSHh0CBNc8hFlDI6T5TWu5Q20sUgJ3pDo/xLFaqCcPC7POXQBb8czY
	hfnpucGs01gkzYtvr6LwYIEYL/lrX/WJDxQwNwgHVKvwI7g61jfqSt75qUfEKm7HtYN/g2zlRITnH
	E1F2+dVOTpidJcX1ikE+6Vmw6/2HgTBASjpUvzaqamBA0F9s9eVupcN9sJFFwR1t2E9/+s72WNCBS
	3waW/pLEoEU2VfvQA4cNSQECbzU/ENqwtp+SZcH79r92J2A9vKR5t3NK2Qqr0koHzlQzdcnC0s3PA
	1UZ7Dfdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZHt-00000004bDQ-2cZN;
	Mon, 23 Nov 2026 19:01:13 +0000
Received: from mail-oa1-x48.google.com ([2001:4860:4864:20::48])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZHl-00000004bAt-2qUv
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 19:01:07 +0000
Received: by mail-oa1-x48.google.com with SMTP id 586e51a60fabf-4ab90cdf747so5831546fac.1
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 11:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795460461; x=1796065261; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pH/xf3kQm7acLfNhYZrfRJLXvU+0NBXvSnbGGfIqejo=;
        b=JcGfXbX4QdZgPeLQTrNP/KZYvLfmV9x9FOXidQPTrpeYTrrXYbTY35Q4gh7Mrfblv1
         ut4GXrcWfLmaYbelDN1LOm5vhPLb92obU83YfXNgXU89oXnaSExlKVOod+hgTYdZ68tb
         AWbWUC5rGOf0Ooz0eUaLYJ5ZN6/ytl2Jp68bw0oKRGPspVp9dBprvi2AOu+wWDUEmsGx
         RPjrimaVOU6YWlzUnbDkGGy1yybiEeCgtyV8y2wyWf1P8X9EO/q1EVqZrKoLYWBqJO85
         9LfZdRP5VYGLsv3AbTdLhTXzcGC+BYt1sZU9a47LhMwKTEm6kZvpSHmvgdEjcQ1Etk+p
         U3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460461; x=1796065261;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pH/xf3kQm7acLfNhYZrfRJLXvU+0NBXvSnbGGfIqejo=;
        b=QC10Gl0KeUz43SZ3gj32rQj7rBHpc6nO4d7FqbBVqm/FVezBMpSJJu4ewVKEAWcbeo
         bKBt+ytRZ+OymvI7XFMLxqIDhhXl+OdmD2bJmRtMqgSz+Lre/Yd/U62/O6mUj7FXSEeg
         /pRwNW73In63MKKmP5VLzUL6d372upA00+y7XgSDzp9vCZR+X/JxyqFK65mepU0ZWCdX
         A0vzVKZdgjm7BL38ZX6Y8fFeVnpgQi8TnM7W6wl/NP/KDODppB89qeY3pWIUEq96LA94
         DubpH3YttSSsPw4Wp9mCyoqdJULghqrRf1LKCeuHEBeG+yy7FrbVZUJFwR20iioeofPK
         z89Q==
X-Gm-Message-State: APuU4Z9QEB15n8iaUZ/8rqM3KIlq9fxyey2GobD5nYtjcMp+atw95u9W
	z1xkz9bvriUOxHlehZTRtQSr0JrylPhnIUfU05g5l1KXOd0B9gYLjZxjMQKSUrFGo3dhgUhYkX8
	TvsybPUyZasFg4EobcTgeQ1NQ7yeyB9dpRiLAagSdJJb4sOJSEUc/AgWOveQ3X75Mu6q7Qn+TQ6
	c6cn4NzjcdPvUHopS3V7EuXLJY7iI/Ew7mz7fxHy1VrwET87RGndY=
X-Received: from jajj12-n1.prod.google.com ([2002:a05:6639:18c:10b0:5fe:be7:9ab2])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6d93:b0:4f1:5068:b93b with SMTP id 5614622812f47-5797bb9fad7mr10333977b6e.14.1795460460873;
 Mon, 23 Nov 2026 11:01:00 -0800 (PST)
Date: Mon, 23 Nov 2026 19:00:44 +0000
In-Reply-To: <20261118223704.3286085-11-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118223704.3286085-11-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123190045.2166865-3-dmatlack@google.com>
Subject: [PATCH] fixup! PCI: liveupdate: Adopt ARI Forwarding Enable on
 preserved bridges
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Williamson <alex.williamson@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_110105_924526_B0B03B50 
X-CRM114-Status: GOOD (  13.69  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix the comment in pci_liveupdate_adopt_ari(), which claimed that ARI
Forwarding Enable is always recomputed after the preserved devices below
the bridge finish. That is not true with pci=noari, where
pci_configure_ari() leaves the bridge alone, so document that the adopted
setting persists in that case.

Reported by Sashiko.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 520c7530475c..08451452fa54 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -938,9 +938,14 @@ int pci_liveupdate_adopt_ari(struct pci_dev *dev)
 
 	/*
 	 * Unlike ACS, only adopt ARI while the bridge is incoming-preserved.
-	 * Once all devices below the bridge have finished, recomputing ARI
-	 * Forwarding Enable yields the same result for the same device, and
-	 * must be allowed to change if a different device is hot-plugged.
+	 * Once all devices below the bridge have finished, pci_configure_ari()
+	 * configures ARI Forwarding Enable as usual the next time a device is
+	 * added below the bridge, e.g. if a different device is hot-plugged.
+	 *
+	 * The exception is pci=noari, where pci_configure_ari() does not touch
+	 * the bridge, so the adopted ARI Forwarding Enable persists after the
+	 * preserved devices finish, even if a device without ARI is later
+	 * hot-plugged below the bridge.
 	 */
 	if (!dev->liveupdate.incoming)
 		return -EINVAL;

base-commit: fd54e32f7903199e8acb2762dd2debfffe4501c4
prerequisite-patch-id: ac616bdf67b652da754c7b00a368613d345ae384
prerequisite-patch-id: 9c324eb4a47b659efcf7c0c8bb14acfcbf5d615c
-- 
2.56.1.809.ga0b61035b5-goog


