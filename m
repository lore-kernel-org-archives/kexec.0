Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365AB606A685
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ohKT8QyP;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l2QzmBUO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/qPu3il+pjsqwuiugOKKp5YPgP+PXsAspKhyyUg3SNA=; b=ohKT8QyP4IjCXUrYVLol3FaovJ
	xobPgARAQthzxH9aywya1pSPXKWtbyujxHeM62KQKiDBhpys5RBhIwcYbieyAjXTY978chlN2/jyL
	g6zyaNEaBPmCP75o6lqAmC4GjAzVWTWrH23vcDe3/cxREAEZGEMyAInSOxPenSYQSj5HG/TKryrHh
	xEjgxsaDPP9o1c32c7PRNPaOgs+vPDwS4k14p3J9DT18V3G05kZj+6wb8xNxj58OG5TSjAnZ28uMp
	rzk8gNBxqHs19z8VwW8wXu+lN+hZkJEZaasL3mgcMqIlMj/jGGwFcnvnH8Ww8z3Ay1g+Fs9V2BSbs
	5oNQKNfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZHu-00000004bG8-3pwo;
	Mon, 23 Nov 2026 19:01:14 +0000
Received: from mail-oi1-x247.google.com ([2607:f8b0:4864:20::247])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZHl-00000004bAS-1wim
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 19:01:13 +0000
Received: by mail-oi1-x247.google.com with SMTP id 5614622812f47-4dc57e2a3f2so4772023b6e.0
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 11:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795460460; x=1796065260; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qPu3il+pjsqwuiugOKKp5YPgP+PXsAspKhyyUg3SNA=;
        b=l2QzmBUOMsJqTepas2cxZWn53o5UL6od3nB3gQn5mPBg7MeiN5+XHPOZOmFxi9+0f9
         P+nXKQSLAqIZTE+zRFN6oy0niFtxuMd1yxpdamVbOETjn1/w+XFPrR03pGjW7SrMdgCT
         /8o9UK6pUukLGhsRu46eSOEyTaEHyJ1A1LEL/Vmt4FdcqwAOCP4n9Z19dZyx5SJNlW+M
         lib+k73JhgPLrM6dC4YOzmF1gTvY2YvrUXnQy1PWTJ+dqRhUjnU7/1oBEfABSIGZW2Xp
         JvhHH99El+Y0UuWElY5DL+jJgx7lhjynBS0Hhl0A3u48bAIY3mHUp6Th7DxhtTApvf6L
         TLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460460; x=1796065260;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/qPu3il+pjsqwuiugOKKp5YPgP+PXsAspKhyyUg3SNA=;
        b=n9CFFdkCp3XlYFrJ0fRXUwcMTlqm2t7cwEJZBk1DPexR0OJs4gPUQWl5+2abx9zsvB
         G5l+HmUo52dal1iqWDfKJC8lWkwVu55XNo8GRaehQ4obi4fzE2lLxsKWpDKzYtWboj/j
         Wv6mHE6IZ8EoQr/AG0zNu1lIOpPjHgRzNCDQONeNCzIqiu8Vs+iGAbEB8aAcB1RDxjDH
         IbBt1xkLs2VPVthOjqU2IfODZr60VzksngT7w03O2OQfoV7x60eIABHGXNo2u/Q3PSbH
         192C8IhwAPvuyvvLwCViQ+4m33TXRY8K4rwXSM+EZ6rh2m/bnGDy7KCfwTSZyL5S8EJX
         nnfA==
X-Gm-Message-State: APuU4Z/azdxJTb0M9vxNDhK2b7d/z2vxpk58Y4IP8spTzffh9mNIz2/L
	ZqeWS3Rf876PMr/H/7LA4ijp1gndx/3DifG1cTorq7g2G9f7JkBXZRtcrJbkaymZnopdaYoLyGq
	jSfZNm1kC5c7GbycoZP/6Pjn4CGmJEygl9zLPvT9aMWq5gIFLprdTd4QQHZsB7NY4wfZ7NbnS9Q
	7tWdGiCcvCJp66X/8IDg8g8Sx2/Ry++CBiO0iLMTuLANqWmiYGNNY=
X-Received: from jakj15.prod.google.com ([2002:a05:6638:148f:b0:61c:e96b:9d4d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:22a2:b0:572:d0fb:ae61 with SMTP id 5614622812f47-57a0a20e564mr12818304b6e.49.1795460459403;
 Mon, 23 Nov 2026 11:00:59 -0800 (PST)
Date: Mon, 23 Nov 2026 19:00:43 +0000
In-Reply-To: <20261118223704.3286085-10-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118223704.3286085-10-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123190045.2166865-2-dmatlack@google.com>
Subject: [PATCH] amend! PCI: liveupdate: Adopt ACS controls in incoming
 preserved devices
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
X-CRM114-CacheID: sfid-20261123_110105_931588_FE7348F3 
X-CRM114-Status: GOOD (  18.17  )
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

PCI: liveupdate: Adopt ACS controls in incoming preserved devices

Adopt Access Control Services (ACS) controls on all incoming preserved
devices (endpoints and upstream bridges) during a Live Update.

Adopting ACS controls avoids changing routing rules while memory
transactions are in flight from preserved devices. It also keeps IOMMU
groups from changing during or after Live Update.

The adopted controls are recorded by the pci_save_state() call in
pci_bus_add_device(), which runs before drivers bind, so they are
reapplied by pci_restore_state() if the device is reset. Panic if an
incoming preserved device has no ACS save buffer, since the adopted
controls would be silently lost by the first reset.

To simplify ACS adoption, reject preserving any devices that require
quirks to enable ACS as those quirks would also have to take Live Update
into account. If such a quirk matches an incoming preserved device
anyway, e.g. because it was added in the new kernel, log a warning and
adopt the device's ACS controls regardless, rather than reprogram a
device in the path of a preserved device's memory transactions. The
previous kernel did not apply such a quirk, so it programmed the
standard ACS Control register. Allocate the ACS save buffer for these
devices too, so that the adopted controls are kept across resets.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>
Link: https://patch.msgid.link/20261118223704.3286085-10-dmatlack@google.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---

Notes:
    This amend! also replaces the commit message when squashed with
    git rebase --autosquash: it explains the ACS quirk save buffer case
    (Pranjal) and collects the Reviewed-by tags from Pranjal and Alex. The
    message already includes your Link: and Signed-off-by: trailers from
    lu-pci-preservation.

 drivers/pci/pci.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b5b578355a1b..f3d58b5e7a5d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1073,10 +1073,14 @@ static void pci_allocate_acs_save_buffer(struct pci_dev *dev)
 	/*
 	 * Devices that rely on device-specific quirks to enable an ACS
 	 * equivalent keep that configuration outside of the ACS Control
-	 * register, so they are configured from scratch on restore. The
-	 * exception is devices preserved across a Live Update, which always
-	 * adopt the ACS controls established by the previous kernel and need
-	 * the buffer to keep them across resets.
+	 * register, so they are configured from scratch on restore.
+	 *
+	 * The exception is devices preserved across a Live Update. The
+	 * previous kernel refuses to preserve devices that need such a quirk,
+	 * so a quirk can only match here if the previous kernel did not apply
+	 * it (e.g. the quirk is new in this kernel). The previous kernel then
+	 * programmed the standard ACS Control register, so save it to keep
+	 * the adopted controls across resets.
 	 */
 	if (pci_need_dev_specific_enable_acs(dev) &&
 	    !pci_liveupdate_was_incoming(dev))

base-commit: fd54e32f7903199e8acb2762dd2debfffe4501c4
prerequisite-patch-id: ac616bdf67b652da754c7b00a368613d345ae384
-- 
2.56.1.809.ga0b61035b5-goog


