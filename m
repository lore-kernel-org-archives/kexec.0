Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116B60A2636
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WBZ+cO0C;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MNS7fsHQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1uW5sdRp5YWPj/rz8uudGhABXbeY/lZgJ5YVMOGqNdk=; b=WBZ+cO0CXwPDOcHRAuJglslUb7
	fQd2nYNsUvBsHRnQPG5w65WwW3LCyYFujosgCL7DlZ/aa/RGtN3+ZIMdsltabJzyzjp/EBlicga5b
	7Trnwk3pbfnaLvr/MIMwpor3Wlop6DDPfkSMZMwvakfqqqysiGdxaUOt1oDglIlKZsagw7tT12jun
	qhhUYVbp5t04CtSRzZUCx/zom6VLRS26kWVrIVlj+QBsMttJJpx2b2Tf5ZhXpBUadMPckx1MUc3Iw
	ppeafP8z84785eVh93HZpek2URkMADVg8n6+4qTUkvbhYggW6Xoy7EB39oh79KszTA9O5T31GYtTZ
	lheYB7QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHZ-0000000AQM2-3KMf;
	Wed, 18 Nov 2026 22:37:37 +0000
Received: from mail-ot1-x348.google.com ([2607:f8b0:4864:20::348])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHM-0000000AQ7V-3QyG
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 22:37:27 +0000
Received: by mail-ot1-x348.google.com with SMTP id 46e09a7af769-862bca06702so2134360a34.0
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 14:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041443; x=1795646243; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1uW5sdRp5YWPj/rz8uudGhABXbeY/lZgJ5YVMOGqNdk=;
        b=MNS7fsHQTbLE0KSgn+nrWb5TsYCIDqXkGXXK1hCioAtAag+I21FvlcbqriPR+egLLE
         +JpxF/Z0D3lC4PRhMgPzSRoH+AcDXqJdDc49FCicmz011FgQ4H5FszVUBBBPgHotZ8ag
         +ovumi1Z7kFr5xx8w1PtVOjXLLq6oiBXzzGMNf8+e7J0DExtuaskbkxXDlh8r+GJKplV
         0XwV9J4hLdecRot9Q1RSbwKgPJuevZbkJvYU5Y/fGJaGgjwzvv28/5pIcFI6ahIVRbtD
         IyUnHJN1c6+cy666fV3VmhhIru/Fr2NCvYubcLFHh9OdmIoy4kV80K4yZ4pPKD98hbmo
         yqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041443; x=1795646243;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1uW5sdRp5YWPj/rz8uudGhABXbeY/lZgJ5YVMOGqNdk=;
        b=OZqsj7qpr5zlo+/nAV2/7HibclLh10XLtxvXYifEQ12b8VVB+C+l3pzjm8k6pWRNHc
         xn0vNQMru2tJJ9RGF0SNChkjejXDOogh+EobsDXUGD2Vl0NyqXP3ChRrJcqGkH1IYdrW
         IF0+ZsqK/s+px8b8xqz4ECfIdnBzngFIIVFSc191GIqAwfKjdBv+v1ZT01igxKTHpAe8
         sS/HuwbIw6QdXsuPGi6Ukfo/vtrXEz6FWLnSKZxJNbz5oJUxigbKBNTb3OtJmWQFEXmG
         1La4p5vw2kTVVXkC/1cVrw2V2rv3cv3zuZsHK7KAS2uMUA860nRkb/a1rcGXuClzqBDl
         YE8w==
X-Gm-Message-State: APuU4Z+5wFKxqQp1y53exITVNoSPhrQa50f7mrEpGKDOaE7KM3ReF5h+
	Cav29uLtssD2l5G4JeG4pe7Z+FFivOi/bpuEHX9Hwsm/lhhJFhZ0udEaFsIm78+yl+AihZpL5vz
	17ZiQf/4/Hf+kf0oi8X+k0zC6EdXtI7lM+gKrP5u6P0/j9FUL7aTxZA9ifqFBGulhlTOjleW4dw
	CEICT4VB4BbUOUIhE/1VJG0QLxyjk6UI6DSPtNtZX1v5mjCCVEPeQ=
X-Received: from iocou22-n1.prod.google.com ([2002:a05:6602:c316:10b0:9ca:dc6e:2262])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:182a:b0:4cb:f21b:6f91 with SMTP id 5614622812f47-57742936db2mr4808486b6e.36.1795041442511;
 Wed, 18 Nov 2026 14:37:22 -0800 (PST)
Date: Wed, 18 Nov 2026 22:37:03 +0000
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-13-dmatlack@google.com>
Subject: [PATCH v11 12/13] PCI: liveupdate: Do not disable bus mastering on
 preserved devices during kexec
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
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
X-CRM114-CacheID: sfid-20261118_143724_888213_F728C306 
X-CRM114-Status: GOOD (  15.70  )
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
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Do not disable bus mastering on outgoing preserved devices during
pci_device_shutdown() for kexec.

Preserved devices must keep performing memory transactions during a Live
Update. Clearing the Bus Master Enable bit would prevent these devices
from issuing any memory requests while the new kernel boots.

Because bridges upstream of preserved endpoint devices are also
automatically preserved, this change also avoids clearing bus mastering
on them. Clearing Bus Master Enable on an upstream bridge prevents the
bridge from forwarding memory requests upstream (i.e. it would prevent
the endpoint device from accessing system RAM and doing peer-to-peer
transactions with devices not downstream of the bridge).

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/liveupdate.c | 11 +++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci-driver.c |  6 ++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index e26d2f5c2338..493576119a76 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -196,6 +196,10 @@
  *    preserved devices, even with pci=noari, until all preserved devices below
  *    the bridge have finished. This keeps the preserved devices on the bridge's
  *    secondary bus addressable with the same function numbers.
+ *
+ *  * The PCI core does not disable bus mastering on outgoing preserved devices
+ *    during kexec. This allows preserved devices to issue memory transactions
+ *    throughout the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -946,6 +950,13 @@ int pci_liveupdate_adopt_ari(struct pci_dev *dev)
 	return 0;
 }
 
+bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
+{
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+	pci_WARN_ONCE(dev, !dev->liveupdate.frozen, "Preservation status is unstable!\n");
+	return dev->liveupdate.outgoing;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 03211dbebc7b..e0c21c1f7e78 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -18,6 +18,7 @@ bool pci_liveupdate_preserve_bus_numbers(void);
 bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
 int pci_liveupdate_adopt_acs(struct pci_dev *dev);
 int pci_liveupdate_adopt_ari(struct pci_dev *dev);
+bool pci_liveupdate_is_outgoing(struct pci_dev *dev);
 
 static inline bool pci_liveupdate_was_incoming(struct pci_dev *dev)
 {
@@ -57,6 +58,11 @@ static inline int pci_liveupdate_adopt_ari(struct pci_dev *dev)
 	return -EINVAL;
 }
 
+static inline bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
+{
+	return false;
+}
+
 static inline bool pci_liveupdate_was_incoming(struct pci_dev *dev)
 {
 	return false;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 8b11bd3dc5bc..08b768b9e905 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -569,11 +569,13 @@ static void pci_device_shutdown(struct device *dev)
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
-	 * devices in D3cold or unknown states.
+	 * devices being preserved for Live Update or in D3cold or
+	 * unknown states.
 	 * If it is not a kexec reboot, firmware will hit the PCI
 	 * devices with big hammer and stop their DMA any way.
 	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
+	if (kexec_in_progress && !pci_liveupdate_is_outgoing(pci_dev) &&
+	    pci_dev->current_state <= PCI_D3hot)
 		pci_clear_master(pci_dev);
 }
 
-- 
2.56.1.703.gf848ed807c-goog


