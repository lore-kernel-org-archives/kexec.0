Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CADE60A2631
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=n2vPRR2J;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F283+8KC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6fq/GPepzkTLXxM8Wn2MMXhIXKeiLSAPdWNcRYRGgzY=; b=n2vPRR2JoNQOdV
	GZNlPuTzyz7Wi2bCahB9nWLSDx0Qu7/AUblpSq/4Vi22JoYIKCLu351gRS1u01taGnQxBJjOujW+z
	Lp+qzcX5tvuwFdjrkTsegaeQuDucYzsi0sWBiZoaeDDMg9qwsxYEQiSTA9R908DP8wpsbdlSBCiHF
	5/+0NmeJQRWCXI1x/pgA76rSmvvkljgD54ZrcuqI6bv+itX0vw7xwcDCYzmGFKduSy8EPmeKnK/mi
	29ARJQd6Ohy8jlMkXzwCCHdjpUUo6sLymV0NYaM+wYMcgJ2ZzWBw79oPh7dwlwtRXvN4ho+GDlJKM
	vUys/EkjhOOut0dz2Mdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUY9L-0000000GQi8-0qTm;
	Fri, 20 Nov 2026 23:36:11 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUY9F-0000000GQh9-1mux
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 23:36:06 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2efddf749e5so11683105ad.1
        for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 15:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795217764; x=1795822564; darn=lists.infradead.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6fq/GPepzkTLXxM8Wn2MMXhIXKeiLSAPdWNcRYRGgzY=;
        b=F283+8KCIwp4yGTFXkgVBLq+ojnxDC2umPScDQFcAvq2gd6Gvv5jc39TEd2XqHaa5j
         mzPv9K5KoB8kEHLeIjoTeYldsaHu78yK9EeCOo7333iq9wjkkk8vIwbsazJV8wLUO5CX
         EpwhSU4Gi9ra7exrZ7JzxMeQW2RZheoAEQh9yMmUl4gc0f4FlRL9UpLVUy0+V0Yjt68p
         5Tm+Iccxa0aLElbgF9ezNyj7B2ZA1vAb/2lqq7H+DACJxFP2COrcHqgwssN8oHsjPed4
         Jn1beZ93DpjfGUJCt79nEnF2D7tpPxyZre04f73Y5oLiFOJLuI/db5/OwG+c6OdukuRc
         Gh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795217764; x=1795822564;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6fq/GPepzkTLXxM8Wn2MMXhIXKeiLSAPdWNcRYRGgzY=;
        b=EIgKWD7XsJKR5pDTGV0W5Krl1nBzrojSfCR/fGgCqBwVOrQQKxWmQ9QjOCQuMUarct
         y2TDe+6t+YNK0TVSMKiz6Srce96g+LGybm0WgNaeah4zR45PkbIwQtfo2IWXte8ycI5z
         kFPv+6qQpjIdH8TVFX4WHk7qUFByXNr7OV8Qc0LiqyEgPH4iAHxhy283+YETYo7nOLDF
         7qcOGII+fCRNAtgrFN4KiOPF2Pl+FsYwR2H2yKW8PouprV5iwWHjuTlm1856XlGzai9t
         y3lryFDKDK9AYR0OSbaQSF3pLWauaJP8k1UoPVvGzHerHZm+eeQ0lXUnY0v2X/WSi8JU
         H6gw==
X-Forwarded-Encrypted: i=1; AL+hErGiiEQmsERjm0Id9qQCk2BIQvtfulhKnPxRdG+5QuRZpKxhgvt/2DDsb1JX/j05G3Y1E5pcaA==@lists.infradead.org
X-Gm-Message-State: APuU4Z+4tOZUwXGYCXLVTtMZ8RHfp7FRSz0V5HtX6GeM32n3YvW31hUs
	rhFYvSNePiIflrVDPEa0NamWSBamdkm0bh56h8w/RsZzSKJxXp2J9DKkuELgdWaFzA==
X-Gm-Gg: AZFdTZfCSJAoROeyeUe9j6RgUWtqUQKy60KFOI9CLz/3pIsRZxMMZoDiDchfJDNSk/W
	PinlFDvZJiFAuzMPYMWHrXHaOMUsFnMIX+e0d/oGjX6WfilME7aChL2a1kHOXE4G57EFbm1fqxq
	n8atZVx21YRg6fBMGCS7T1u5B0FPIDLG/TRWKjnCRrtTSlmPEOiDMg120uSR62ROdEl5vdgbbDB
	SEockNHUvB/wG2CSF03wncQNBDnoitGClh3TN/O3Je/4qIsS19HV25qsGkIshmGZrB4rl6waZtL
	TJsvyBnht153jU+EMVXyYJiHhXuEO6NmokqdbqwKKE8OSzuAuoqcG1XL98xHCTwFrM98730x5ak
	lsijz/ZlmuiUk4PG735gP6KSM++5mG70TAfU+4M2AaNoio9XK0O9m8ZPN7Ecxt9gisdHbzHtVaT
	te3VLI9vrmtsjDdSRwiO4XHmTqMRj70GcCibdes3n0bQZXZ+neqZrng1kU3AMb76tInNj1tniB9
	SMbPt47gRJhP7EvqULiG4a+meb9p3PKqU0KKBY0PyNew2BcnvKvPlJAzsa1zO0vKTCZ76oMDssg
	0NLIBrwRtXiahWK5UGFexknm2aY2NSiLDukOEZFz43bT7ShMQ9o1BoWynYZIlBRd
X-Received: by 2002:a17:90b:3c11:b0:3a7:9ec3:ea0e with SMTP id 98e67ed59e1d1-3b41c908114mr2771810a91.22.1795217763469;
        Fri, 20 Nov 2026 15:36:03 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41aab4729sm5906545a91.0.2026.11.20.15.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 15:36:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 15:35:58 -0800
Message-Id: <DN0FL1752MH5.1FSZE620OJBM0@google.com>
From: "David Matlack" <dmatlack@google.com>
To: "David Matlack" <dmatlack@google.com>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pci@vger.kernel.org>
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf"
 <graf@amazon.com>, "Alex Williamson" <alex@shazbot.org>, "Alex Williamson"
 <alex.williamson@nvidia.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Down" <chris@chrisdown.name>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan"
 <jacob.pan@linux.microsoft.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Josh Hilke" <jrhilke@google.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava"
 <praan@google.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Vipin Sharma" <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Yi
 Liu" <yi.l.liu@intel.com>
Subject: Re: [PATCH v11 00/13] PCI: liveupdate: PCI core support for Live
 Update
X-Mailer: aerc 0.21.0
References: <20261118223704.3286085-1-dmatlack@google.com>
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_153605_492341_42030BF4 
X-CRM114-Status: GOOD (  19.60  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 18, 2026 at 2:36 PM PST, David Matlack wrote:
> Merge Plan
> ----------
>
> This series is intended to go through liveupdate.git, the tree listed in
> the new PCI LIVE UPDATE MAINTAINERS entry.
>
> v10 and a follow-up patch were applied to the lu-pci-preservation branch
> of liveupdate.git. This version is meant to replace them, and applies on
> v7.4-rc1, the base of that branch.

Patches 08 and 09 have Reviewed-by tags from Alex now. I have a v12
prepped with some small fixes from Sashiko and a comment cleanup from
Pranjal.

Mike do you want me to send a v12 with these changes or send separate
fixes for you to apply on top?

Here is the diff from v11 to v12:

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 493576119a76..76e939ea52eb 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -127,7 +127,7 @@
  *    Control Services (ACS).
  *
  * In addition, a device cannot be preserved or unpreserved once the PCI c=
ore
- * has started shutting it down (pci_device_shutdown()).
+ * has started shutting it down for kexec (pci_device_shutdown()).
  *
  * Driver Binding
  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -409,7 +409,8 @@ static void pci_flb_finish(struct liveupdate_flb_op_arg=
s *args)
 {
        struct pci_flb_incoming *incoming =3D args->obj;

-       pr_debug("Finished struct pci_ser (0x%llx)\n", args->data);
+       pr_debug("Finished struct pci_ser (0x%llx)\n",
+                (u64)virt_to_phys(incoming->ser));
        pci_check_all_devices_released(incoming->ser, &incoming->block_set)=
;

        xa_destroy(&incoming->xa);
@@ -937,9 +938,14 @@ int pci_liveupdate_adopt_ari(struct pci_dev *dev)

        /*
         * Unlike ACS, only adopt ARI while the bridge is incoming-preserve=
d.
-        * Once all devices below the bridge have finished, recomputing ARI
-        * Forwarding Enable yields the same result for the same device, an=
d
-        * must be allowed to change if a different device is hot-plugged.
+        * Once all devices below the bridge have finished, pci_configure_a=
ri()
+        * configures ARI Forwarding Enable as usual the next time a device=
 is
+        * added below the bridge, e.g. if a different device is hot-plugge=
d.
+        *
+        * The exception is pci=3Dnoari, where pci_configure_ari() does not=
 touch
+        * the bridge, so the adopted ARI Forwarding Enable persists after =
the
+        * preserved devices finish, even if a device without ARI is later
+        * hot-plugged below the bridge.
         */
        if (!dev->liveupdate.incoming)
                return -EINVAL;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 08b768b9e905..2748ca22e9cf 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -560,7 +560,8 @@ static void pci_device_shutdown(struct device *dev)
        struct pci_dev *pci_dev =3D to_pci_dev(dev);
        struct pci_driver *drv =3D pci_dev->driver;

-       pci_liveupdate_freeze(pci_dev);
+       if (kexec_in_progress)
+               pci_liveupdate_freeze(pci_dev);
        pm_runtime_resume(dev);

        if (drv && drv->shutdown)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b5b578355a1b..f3d58b5e7a5d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1073,10 +1073,14 @@ static void pci_allocate_acs_save_buffer(struct pci=
_dev *dev)
        /*
         * Devices that rely on device-specific quirks to enable an ACS
         * equivalent keep that configuration outside of the ACS Control
-        * register, so they are configured from scratch on restore. The
-        * exception is devices preserved across a Live Update, which alway=
s
-        * adopt the ACS controls established by the previous kernel and ne=
ed
-        * the buffer to keep them across resets.
+        * register, so they are configured from scratch on restore.
+        *
+        * The exception is devices preserved across a Live Update. The
+        * previous kernel refuses to preserve devices that need such a qui=
rk,
+        * so a quirk can only match here if the previous kernel did not ap=
ply
+        * it (e.g. the quirk is new in this kernel). The previous kernel t=
hen
+        * programmed the standard ACS Control register, so save it to keep
+        * the adopted controls across resets.
         */
        if (pci_need_dev_specific_enable_acs(dev) &&
            !pci_liveupdate_was_incoming(dev))


