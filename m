Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7C606A336
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PiKRAoBd;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tU2By+eR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aQspCOyRyocPeuGvIH5YlNChv9LGZMbmr1LWcFqx0m4=; b=PiKRAoBdk8y7aLbRNqKANIbxrv
	tUKyrOBx1/f2maBmmexU8NlwEl8GX/hU/rGGzkug4bkklQTQjokxW0gPGFNFB8uJotqU8EyxKsJri
	ssXyAcq1rS+edpJXxQvHhswcwtQp1jEonP2QxwtWB1WKcpWXT0FiHfU8JR2qrvr58/H5CcfG7YP9e
	zig5CjqoR4uceei1dCTdUfXX7HGJajsx44TdlIry6gF7BlZjXp6UQgij8r1anJ4w/7POqIe3haGpe
	W+0XbKKCtz9GlBWsjRs+7zEdYE3YlihNRtJ0xf/Mt7Q9n3A0Dnaf0LffLAkCLxfipCJC/z7Ktf7ix
	a3GYaDqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIuxE-00000008OBL-0gzU;
	Mon, 19 Oct 2026 21:31:36 +0000
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIux8-00000008O46-40mB
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 21:31:32 +0000
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cd66551e02cso3076988a12.2
        for <kexec@lists.infradead.org>; Mon, 19 Oct 2026 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445488; x=1793050288; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aQspCOyRyocPeuGvIH5YlNChv9LGZMbmr1LWcFqx0m4=;
        b=tU2By+eR2yirTKbq1Jfs3Gygly4V1HUUrnfAcZzSmd1SwUTeV99P4xXoOwOBPWP9Ek
         rLXSazw2WI7CHV+Znkpxm6wpYC/8YdN7qJd/s1/n5BI6G3jQVUtFXPGHIGjPcIW+sA0K
         ap/esaZfYeuYGtiWhIhnCKpJaCr2nKNTd3co9TDweiZI03Gbmqxl5026VdBktTIs2krs
         1ucDBv5jabfoP+v/D+JekRc27b1Q2/dylnArhQJbKYu7hsLFCQvvtQOHu0Crm9YbNN5z
         wC+9eDNk6Wqua/ec9bdxW0ywLMGRW+gS0emfmte27ViD7VXF/kMRdDsFO4+Q3HaKL5Yj
         GLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445488; x=1793050288;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQspCOyRyocPeuGvIH5YlNChv9LGZMbmr1LWcFqx0m4=;
        b=ngRFSd37IAI0DYZVZifPFIarAaiLdaKRUryCiJoCK04aHVcDZZouOKz89KytYW38Bs
         k+N24I1e1pdRROzsRUvKYun6iErpM4/z6KE0b/F05f7mJBGkk7367lV4Ckd/nf9AEOaG
         7FHiQUlYQJRkMUFyqEb6q8lWbIXprrdOe5UmenN2HKRDq3JQawmfrn/WKjMaLlniQsOK
         ce2KZkiYcc0oal6JQNQQl8NZE3S+b5eIyewrX9V7u4+nwP39dm/4G6QXnp0q/g/3qutP
         VTPNM2LcfcIGDVO91nD6w2JxhqzlBEp7D20uQde8z/7DysLDp1HZqSZGFQdw2QnxQN/7
         +mNg==
X-Gm-Message-State: AFq9FYI9UF09NwpvsafUtIbd1l1LckrT7LWPKiDs9AcJLa3u1EOoO0dx
	aXpscdhO/DeZFkJ2ayRDkM4+zmFzD1Kq1n4b+M9sVHAlPNmWK30m0bav18eqZhoFjAPyFCRaiQD
	XNOl9gTtx+TciMoB2Tu0kutCbInrWorLqzfxBLrbz1UwDaNpkotx3LPcTDkW6FpgFSVolnqRbdq
	JeT35Zcru+/ljlaCLPkK15d3LM0D5L0nPP+CXnj01/TH5gK8DLSWI=
X-Received: from pgld2.prod.google.com ([2002:a63:e02:0:b0:cc9:f746:40bb])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6f89:b0:3e0:b937:883d with SMTP id adf61e73a8af0-3e225fe8995mr7731521637.25.1792445488192;
 Mon, 19 Oct 2026 14:31:28 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:52 +0000
In-Reply-To: <20261019213054.3157159-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-9-dmatlack@google.com>
Subject: [PATCH 08/10] PCI: liveupdate: Prevent releasing resource windows of
 incoming bridges
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
X-CRM114-CacheID: sfid-20261019_143131_065103_DF5A88FC 
X-CRM114-Status: GOOD (  12.08  )
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

Prevent the windows of bridges preserved across Live Update from being
released during the recursive "realloc" failure paths by adding a check
for pci_liveupdate_is_incoming() to pci_bridge_release_resources(), and
log that the window was not released, similar to the message that
pci_release_resource() logs when it releases a window.

This prevents the PCI core from forcibly releasing a preserved bridge
window to satisfy the resource needs of a failing child device.
Instead, the child's resources simply fail to be allocated. This should
never happen in practice though, since the previous kernel should have
established a sane resource allocation before kexec.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/setup-bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b82440394ee2..7283c4be803e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1700,6 +1700,12 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 
 	idx = pci_resource_num(dev, b_win);
 
+	if (pci_liveupdate_is_incoming(dev)) {
+		pci_info(dev, "%s %pR: not releasing window of bridge preserved across Live Update\n",
+			 pci_resource_name(dev, idx), b_win);
+		return;
+	}
+
 	/* If there are children, release them all */
 	release_child_resources(b_win);
 
-- 
2.56.0.212.g129ede20d9-goog


