Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2C60A3831
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=h7XFUBhb;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VohWEj11
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ad5b7cD20gHMOhZMyF8+WzruE7aQOBAM0dk/O+UacAU=; b=h7XFUBhbz52d2a1FoR4HwAgJWx
	ZpBJ3xJHI6dFGYhuvOJjhns89hc7iX6j7zg+cds7wVluxDHfSwEDKGkXTpvEm9uhOk+Wl47LACJE2
	MfkUCvqK2k4Q4eOznyZZ+qFei/o5nklrWaP9DtvXykwURYthB3wyE/0aaiWJu8cyT1SfiPLuBFwtD
	fMOqxaVf47xjcSuxysBcPCXNKVwj5PRIf9GoXmHqpD4QxfgfjqMTC1G57mTAZzdJRcFqeW7jp2W81
	cGivO8BmZlACIyDnrwQ/PZrSUD4lBdE0Zqi9T89BGZvpErLXhiffYYQDm2k3tBmUBhax7zoTPJNGk
	MP4De2ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHF-0000000APw7-1NoW;
	Wed, 18 Nov 2026 22:37:17 +0000
Received: from mail-oa1-x47.google.com ([2001:4860:4864:20::47])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHC-0000000APrP-2jYB
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 22:37:15 +0000
Received: by mail-oa1-x47.google.com with SMTP id 586e51a60fabf-45a07949855so1532914fac.2
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 14:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041433; x=1795646233; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ad5b7cD20gHMOhZMyF8+WzruE7aQOBAM0dk/O+UacAU=;
        b=VohWEj113m0H2JQWiT6kT68W9DJmdb4+PH/RdfCEMyv7TJifS8+P9UFHdMpoYqSSwf
         hfRwbdSAU05u8LX69Rn33dnl5yHND1jftZjZYwJ0ALG4KF1lmtTCm8HBgAw6uSWbN+9c
         mH6Rt2XfNCqF94p5i/zkN0UMdnm6xgmWjN50AwmJqfmrpKP1MWwONpE9OYAvQzQBIWiv
         +W69W1xSQ8Easi5UGCeTnUY5ZgDz7FqRW+wls+f6eQbtRo2Fi3sQMvA281t/11qz8/lU
         KY8NZjEH8bgoZPVXelsdmqkcZOYKnY2m21pda6SqQCfuQbxm8MOMbzmJfD1gT9IPalqb
         Ed0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041433; x=1795646233;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ad5b7cD20gHMOhZMyF8+WzruE7aQOBAM0dk/O+UacAU=;
        b=nnst3Hqp5Ko6FO1TLBUXxVYkDdiD7zZGCRTu78ea327DnvWwJ7tYvErJ7DNpYEHLoi
         wmQ4IbE1cugCbdZcJtgq3UYTU6xdVQM8E46ntSyeoFN6dmzGhFfLc+fCPS2/b19R6cDN
         jDGScQmljOkX1BFQ+e3LkeDo7le5jZI7rImDhSWwlv10fXr6vUuB49FuYM9Kide4q33X
         h637CmDGBLEwbhrGWPwHx9rf9Li3sflAVOfDrr1i5/ya8Sp4wmaeBHNatxPBQZrbdewa
         K99eA9aznSDkP3vNAKCyqFF6zFkmChXksJkX+WkCBnfFcqaMPwZDFfVBNTbPRnDV0tDs
         aLLg==
X-Gm-Message-State: APuU4Z8cUGs9MJgD3Lp4GaullsRdbuKo6QSbl2TTWPY/7R2FBT8TRPvj
	QimFVn8VvOHLIq4fQCl4oUiZ7grRc3F7k38SkkXY1BCUtIG2EEC9b1/ONj9n0cy3oZLyijzlCSM
	p4bB5wJ/Ysz48aClwcqgWp76vYnFj7RpR18A7BActHQXjwBPOjXhYCGBCywoQIBoG/AQsoOXMb3
	lUM5utVDKsBIyNEGLk3qbKVlG4aSrVzRU84ZPs+2vXdT5VvIn9fNk=
X-Received: from ilqe2.prod.google.com ([2002:a92:d742:0:b0:53c:2d10:3af1])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6401:b0:572:8a:59e8 with SMTP id 5614622812f47-5773d72c450mr4859784b6e.55.1795041432243;
 Wed, 18 Nov 2026 14:37:12 -0800 (PST)
Date: Wed, 18 Nov 2026 22:36:55 +0000
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-5-dmatlack@google.com>
Subject: [PATCH v11 04/13] PCI: liveupdate: Document driver binding responsibilities
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
X-CRM114-CacheID: sfid-20261118_143714_736887_D78851F1 
X-CRM114-Status: GOOD (  11.42  )
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

Document how driver binding works during a Live Update and what the PCI
core expects of drivers and users.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/liveupdate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index b569093bea75..d1b4000c3e78 100644
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
+ * In the outgoing kernel, the driver must ensure that it does not unbind from a
+ * device between pci_liveupdate_preserve() and pci_liveupdate_unpreserve().
+ *
+ * In the incoming kernel, the driver must ensure that it does not unbind from a
+ * preserved device between probe() and pci_liveupdate_finish().
+ *
+ * It is the user's responsibility to ensure that incoming preserved devices are
+ * bound to the correct driver. The PCI core does not protect against a device
+ * getting preserved by driver A in the outgoing kernel and then getting bound
+ * to driver B in the incoming kernel.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
-- 
2.56.1.703.gf848ed807c-goog


