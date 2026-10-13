Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5942CC6B1C
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WNT+jGdaf2aCsQv4VtyLG1DbArni/172oULb9VD6dek=; b=BholzoWYSTOYW6RT8sPPsMZr9B
	ZY2BV3WwLksp7U2X1cs6etDDDeL8OZBQP6VPX6GILjwxzs2KHVK3CiaZsYnebR9k6LUP3rfY6Scvq
	bo1yuL5LegAAZ7rnmEn1DoLkL9jZVUBU9JHa5hUc+F9gO7rAyPxRuoHeLoCc5BW+kFL+BdI8mVPST
	BObdJPDSZhkhy9sOKPOpfdsl9xxIbpwKSQCOCujfZjommGqxYarDokEIPwr7p0GL7VCch/W9DSc6H
	Ab82mWNDJOO0jsvyFN19JjSJTYG51Pu0u/tsqSJWKGs2r57Oc9y5xyQH3/6xrDsKUusVDRUqUpV8C
	+H5ydd+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfJv-0000000DUck-0RwK;
	Tue, 13 Oct 2026 16:25:43 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfJt-0000000DUaF-016V
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:25:42 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2e80f7acc67so33198265ad.2
        for <kexec@lists.infradead.org>; Tue, 13 Oct 2026 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908740; x=1792513540; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WNT+jGdaf2aCsQv4VtyLG1DbArni/172oULb9VD6dek=;
        b=vAULRUSK8JWa9Q99uJhjnjUzrHpPGOkZo4gJgQpPvkGmGDKpNUf0htuil3Lcum1AUU
         eLbdbDOYNguyvF5HfC30TxW0jByopQ4qjt3W2EZW0cRNHoNZrxiC8GsFSJSTqAUKXJB6
         QZTkBxAan8PXkTG4N/FtBo1Yo7Z1BczI3zuOddewes1l+T9z+YhImuBnZY0YRL8YikzF
         +yCMKeHsQfXNKyj5P7LJ4Img9CVyxLAWIth3sqnvCldT7l+Y+Jsh/NJTYKzcPPplitfv
         j7eZiHizKrhWsr5C424a0ZQfnghoutTJwGfxAD6KAK1hkiPMZYGQJeKX6ByrRWNxVJAm
         n/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908740; x=1792513540;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WNT+jGdaf2aCsQv4VtyLG1DbArni/172oULb9VD6dek=;
        b=gO0D97KX+Y7LwIdTQH0NSsyGehvQcvR/yr39emzXLt62XhzA0e3OYq5T9NO4cQmSlk
         iCbPEfX9d8QPB0NyroCB7xz7Gm/U/xNNg/uayXFOLfoQ0vP6X3Ei/GUAyY5BJaIz6TFC
         0PkddywwCMbJHOBOpp7WDFZDvKmJMYEfTOh3BWPYd7u0h8sv36DckuH6aSJY29WoIy1i
         06yYNZLuHtLg1HEhkDNCk6hTIgPw35S16Yfkc8qliTOVWgDKirp4CcNm+KUoI39+7FGt
         g9u8+mHCwoG/d/rsppNuqjw2j5Lpu/1ualFJ2rUj1VIl05PfZ7RxAz9NOumQOqaPPJ3y
         18Yg==
X-Gm-Message-State: AFq9FYKb54JVq0vOeSbw1qTCHIGvgYaqudRMZFjnwG74abJhWc2FcYIj
	4WQP1aEwcWECuFy0Gyy2dZ17UjRN/i4IRsNsYUaZf7P3B1m4jnzA6KbW//p+D4CaitWFKlBRrHg
	OCpP+vfrRNBO8n0S/ypiypt7FkkNwQ3sjdUGhv8zqNKil1LsVIt1v8X5i1mXwZVJGydhhCycOsg
	Dokle+FX8L0J6hAue1jnDvtQ3b7mU1arsubfvQWIFf68mW1aHQo1Y=
X-Received: from plmm17.prod.google.com ([2002:a17:902:c451:b0:2e8:d79d:4a41])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ecc3:b0:2dd:ad73:5b6b with SMTP id d9443c01a7336-2e8429ab7acmr112088205ad.27.1791908739540;
 Tue, 13 Oct 2026 09:25:39 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:20 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-5-dmatlack@google.com>
Subject: [PATCH v10 04/13] PCI: liveupdate: Document driver binding responsibilities
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
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
X-CRM114-CacheID: sfid-20261013_092541_048812_D8E74BE0 
X-CRM114-Status: GOOD (  12.71  )
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

Document how driver binding works during a Live Update and what the PCI
core expects of drivers and users. Note that this is only a description
of the current division of responsibilities. These can change in the
future if we decide.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index a1d9b2b1f9e3..d6b659b346bb 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -123,6 +123,20 @@
  *
  *  * The device cannot be a Virtual Function (VF).
  *  * The device cannot be behind a PCI-to-PCI bridge.
+ *
+ * Driver Binding
+ * ==============
+ *
+ * In the outgoing kernel, the driver must ensure that it does not release a
+ * device between pci_liveupdate_preserve() and pci_liveupdate_unpreserve().
+ *
+ * In the incoming kernel, the driver must ensure that it does not release a
+ * preserved device between probe() and pci_liveupdate_finish().
+ *
+ * It is the user's responsibility to ensure that incoming preserved devices are
+ * bound to the correct driver. The PCI core does not protect against a device
+ * getting preserved by driver A in the outgoing kernel and then getting bound
+ * to driver B in the incoming kernel.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
-- 
2.56.0.385.gd3acb90ef8-goog


