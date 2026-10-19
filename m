Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A05060A2631
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=q0nWITnY;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=BSMd62XS;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RwWjJpC4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ZTUYHR3qxY+N6QVtGUbGLJTaBCbudf2foNyHLXy9bs=; b=q0nWITnY1l/n5UbU99fTZKgDHz
	Uah/Jv49K0HeHhcSfKJveRijbgFM/RSLsYd/DHSm2V11bDdax+5Mgoa3BSydpaLdRNCzlUQ2fRlXK
	wirPG47pPjQ981ZYEhmpnVmaXCLpzu4qjtLgF/JZHnHgjsXpnUTh96XCLxvGq4K0eLQvn2+RR+v/e
	ELuQDi5CgwjwvRbjHDKk8jx0VtWV4lvWxmyN2wmy2lb419TgsmA0QEdSIIwwjPIOqqiaRkDzUQgkX
	TipD/OmebBI5k1SnIMztRolba0FjbtV3z/I+nmJ2uvjZDgM+70PY1XevSkhmX/Wx8hiM0ylmHl4kl
	Qgia3wmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIuxG-00000008OG7-1y9F;
	Mon, 19 Oct 2026 21:31:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIuxE-00000008OBl-3olp
	for kexec@bombadil.infradead.org;
	Mon, 19 Oct 2026 21:31:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4ZTUYHR3qxY+N6QVtGUbGLJTaBCbudf2foNyHLXy9bs=; b=BSMd62XSD01oxBCZCwI2JI6R+1
	Auyaisie+iPZMh5L9984aD7DVkHBCmeT7zesLWvGnlusr6tubID37QVAEYzJwv8F3nA6qCl5HKgJD
	pVo1OnDTXVvZJGyxtiYZ2Y+qKlQclbfAevWnuZnAcfePFEFgbVST5d8BKfrEZV7pzaegwQIUAzZix
	Ts/d8Ufvm7fVrUiaJZlys6qsj9qYgHynrOVCI6voOt17DLtp6KkIOsox2w6pJ61Jp3o1rtRM5NdQv
	3yAdWWJbeIPVSh7bOS5TJqeSOjBXxZDlXm3dWNaWA5r+RUwIbK8qdY61LDPZv0w2u67DrejlemLNo
	MH7MsArQ==;
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIuxA-000000046lN-2u61
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 21:31:35 +0000
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cd67466211bso965346a12.1
        for <kexec@lists.infradead.org>; Mon, 19 Oct 2026 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445489; x=1793050289; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ZTUYHR3qxY+N6QVtGUbGLJTaBCbudf2foNyHLXy9bs=;
        b=RwWjJpC4X/2T/+J0LEjJP7w9yQNNeGuf7QG04roZYWS6H8Ec5BqC+qi4PfaEBrbtjX
         FQdQdhMh9Ux8uLLO2CskXVOxNFc2JHZ2x/xaHlr3UXcVfHwt7J5sN/IpPPP/3MqNDp6S
         eYWORbUZeqnGKq8A/pXN/hlqYAV5wawgW3RKWD0citEGdmf72DODfv219tFu7f9zAwg+
         0kKCXRvT+anePb6OBvNeAUDShYdkKcSrXPCuCukUKH1XTevJlqJ5CXTztEuRUXBYNqcN
         4KrhsQuGi0NcoRl/j1z23dy4UjruBVjSKPXaJe244vtV3VBWBthIm6QtzFay5BAZB1Fd
         NRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445489; x=1793050289;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ZTUYHR3qxY+N6QVtGUbGLJTaBCbudf2foNyHLXy9bs=;
        b=pyerpNLvDXqhbkM7zlf6gZlD+vJwImo5NCozmlNUNQSMurla3CJZsjv+FtlHKk8t78
         1FM8f/UDNpGxwjbL6rJVPXnsg+LvpPjQH85YQSxsf3UNddwXEzsh+pg/ko8mW6vJX1I9
         MCAGyENR+Ss3QFL4/LaQRZ8KY4ReUpru84HU1LuIZzJI3RUfpbs7CgpOMi7CA/A7xB/u
         97c+jiWx27VRBefRAPOSj510rZhSzzgjeHXxPXop6BPD91ilrDmoiwf/EHTCnOSWsslr
         hL7weilvQXy2Q2gnXTpWfTkMNRV9bxlV/YuLrg3k2+VKUH/wTNFso8J1SQTxbsnhiwye
         NgrQ==
X-Gm-Message-State: AFq9FYJ1vgoeHU04J12MoI1CrVqJTibTZU1Xm8FZPcuy1PELfIIjDM/f
	8CNXwSs6+5G6Fx1W/1CcubAtXLLou9bd15eY2iQCYNx2K2NcLARHpdHZ55Rp8oydsLmhfbZnCB1
	4QUY6/E405dKMjxELGUOjNBmsGyhit6wa8EvoKZ726bmA5n9l7KWXNP0hcol64IW1zKWTIfgrk9
	4osz0PNjL6sN64t6mmcMjNL4R4jVuSVr/XxyXvxn9fPDvBfn3qMs8=
X-Received: from pgmo24.prod.google.com ([2002:a63:5d58:0:b0:cc7:a971:1982])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:2983:b0:3dd:a195:dd55 with SMTP id adf61e73a8af0-3e2260eb858mr6959751637.55.1792445488899;
 Mon, 19 Oct 2026 14:31:28 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:53 +0000
In-Reply-To: <20261019213054.3157159-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-10-dmatlack@google.com>
Subject: [PATCH 09/10] PCI: liveupdate: Don't realign resources of incoming devices
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
X-CRM114-CacheID: sfid-20261019_223134_034004_44A94969 
X-CRM114-Status: GOOD (  10.40  )
X-Spam-Score: -7.6 (-------)
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

Skip pci_reassigndev_resource_alignment() for incoming preserved devices
and log a warning instead.

When the "pci=resource_alignment=" kernel parameter matches a device,
pci_reassigndev_resource_alignment() disables Memory Space Enable, marks
the device's BARs as unassigned so they get reassigned, and disables
bridge windows. Doing this to a device preserved across Live Update
would disrupt any memory transactions targeting the device and change
the addresses of its BARs out from under anything still accessing them,
such as its driver, peers performing P2PDMA to it, or VMs whose vCPUs
keep running during kexec.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5b960ca26e6..853c84a2c782 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6750,6 +6750,16 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		return;
 	}
 
+	/*
+	 * Reassigning resources disables decoding and moves BARs and bridge
+	 * windows, which would break devices preserved across Live Update that
+	 * are still performing memory transactions.
+	 */
+	if (pci_liveupdate_is_incoming(dev)) {
+		pci_warn(dev, "Can't reassign resources of device preserved across Live Update\n");
+		return;
+	}
+
 	pci_read_config_word(dev, PCI_COMMAND, &command);
 	command &= ~PCI_COMMAND_MEMORY;
 	pci_write_config_word(dev, PCI_COMMAND, command);
-- 
2.56.0.212.g129ede20d9-goog


