Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70607606A336
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KuOkf1+s;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=iliCfC8T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zjIHcsp6K5l9uxu4NW3RN2Ki168yByks7xW11UF++V8=; b=KuOkf1+sL26AymP/fvCV4m6+Q6
	0YCzNLT4Xva+Djb7HVmmU4U6RUeeaXemwBszrjlU1WqLDXqFCAdysprw5CyrC0D1ELMNz1DiOvzcv
	Tzxw2wj6hNuP32MOFenwLybB/1oh6uZT3quXr3gBQjM9+AKT285pGUZ/d5hwSx0YEavzxTj/GYCoi
	InMQLXBlAc2Iyecw/a+bLZLYx9L2Tw81oQzxfb1ZLMFoRSdLOgVYvv5Eym1MrPY60/w4JjrlVe9XY
	KUF1vkROnSooZ5L1h+rLiqDEN7Yiun19RvR242cVezQx3JKAeri4SQyHzcZCHcD1MEsMpGwH5C3cF
	6UxIEV6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIuxD-00000008OAX-0Hl8;
	Mon, 19 Oct 2026 21:31:35 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIux7-00000008O3N-1Mbv
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 21:31:31 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2ea0fe07201so5582965ad.1
        for <kexec@lists.infradead.org>; Mon, 19 Oct 2026 14:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445488; x=1793050288; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjIHcsp6K5l9uxu4NW3RN2Ki168yByks7xW11UF++V8=;
        b=iliCfC8T5T52LN3Ue19JWMZaM412AsSccWM5x5NgNXBcIYZ40U82ssa781snUrSXkN
         G4V8HxJFKohQjLgit/i1SxbM0U95aIFzQ4sJJq/6511VaT3cRoqxqe+1zsc5NBogRBvW
         86Vf+fWpbGXiUIvIML9OXylIzGZADo/LfwU2WhvfnWDBjpXJB7wFKc8KfnxxLwkStyji
         gk92PHBU5eKz3hktTfo2Xd3u8lBYW4o3LdKVFuYWriPK4NKdo/xFM5J8mXsDMmEOH5aL
         4hpxTGFi/hlhKn4hPX6x/eb92Jm04LJwc/vJ3EjhqqePBnxYdY4UBTsJfq9vwgV65uDz
         +GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445488; x=1793050288;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zjIHcsp6K5l9uxu4NW3RN2Ki168yByks7xW11UF++V8=;
        b=Fu9V7TaiyjIVZwy7DAwJSH5WCSM6Zeuso99enuXA6qAq/tkNoVCOOCp+7YjvfFSKCU
         /vXkue1nGXbJxdoWqeYAM6i620VuDGK5deSHurN9PfOaWv5edBVbffGnAw8z6n7kFoLP
         Q1iID1Ty1tjQiF43pN6ItVxLUXFzXIxnLS/SeKkR1qIgRwU0rBYhJSG/BWMxV7ENa6HJ
         x+GnlcJmGIEhSerESHtSTFntAuzAL1jUcFPI9+F97ebbB2xcdOzos76m23bOmSHfSq2n
         ZIXIw7rVZ3SKoVbGa0XNuduadewzVmcsaCZDajKxJSbq3EhlplIDaeOlZ9hNVwXBMcCn
         6i6A==
X-Gm-Message-State: AFq9FYKwO/XypSn4myVMIAgIT9SHeGszaDe53812S6CTOSHtsn6QHLYH
	d4hVX6dgK3+3hipntFskgcjYnRqIOS+SG4CmoLiQ0Chy/bHF/fLi5jXYXlQWOyQNRDilmBabSSH
	styulN9CDMmqQLSyLMk1Wvpwxncm+4SzB5eLvupsRS0wF/E9sb8P4VC0C/NZTqpp2S0pleh9K3z
	At5SuNemdldbsr0+/xcg7FY4uabR7nkOXPG+iqnGRJudpjxFssm6c=
X-Received: from plbkf3.prod.google.com ([2002:a17:903:5c3:b0:2e5:b8db:503])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f711:b0:2e5:dbbb:6c7f with SMTP id d9443c01a7336-2e9a68356a1mr74031665ad.1.1792445487379;
 Mon, 19 Oct 2026 14:31:27 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:51 +0000
In-Reply-To: <20261019213054.3157159-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-8-dmatlack@google.com>
Subject: [PATCH 07/10] PCI: liveupdate: Never assign resources of incoming devices
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Matlack <dmatlack@google.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_143129_373019_D45A4A93 
X-CRM114-Status: GOOD (  11.67  )
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
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Prevent the PCI core from sizing or assigning the resources of incoming
preserved devices by adding a check for pci_liveupdate_is_incoming() to
pdev_resource_assignable(). It is consulted for every resource when
sizing bridge windows, in pbus_size_io() and pbus_size_mem(), and when
building the list of resources to assign, in pdev_sort_resources().

The resources of incoming devices are claimed as programmed by the
previous kernel while scanning, and claimed resources are never sized
or reassigned. However, an incoming device may also have resources that
the previous kernel never assigned an address, e.g. a disabled ROM BAR,
which therefore cannot be claimed. Assigning one of those would write
to the device's BARs, and updating a 64-bit BAR temporarily disables
memory decoding (see pci_std_update_resource()), which would disrupt
memory transactions targeting the device's other BARs, such as P2PDMA,
or MMIO from VMs whose vCPUs keep running during kexec. Leave them
unassigned while the device is incoming instead.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/setup-bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4bec76950f46..b82440394ee2 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -311,6 +311,10 @@ static bool pdev_resource_assignable(struct pci_dev *dev, struct resource *res)
 	if (pci_resource_is_bridge_win(idx) && res->flags & IORESOURCE_DISABLED)
 		return false;
 
+	/* Devices preserved across Live Update keep their resources */
+	if (pci_liveupdate_is_incoming(dev))
+		return false;
+
 	return true;
 }
 
-- 
2.56.0.212.g129ede20d9-goog


