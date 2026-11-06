Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C8606EE97
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1QWc1yID;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RSs8Bw4T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tEaeh2MQM8Yqh+InUxWcP/c3Ugn8r1gCgilB/e+XZTU=; b=1QWc1yIDrXHIEU
	h8y5w14wR2TMW2cl6QyiCg29YMLM3NrYb+kNBCYs/rkTQFPk3hci8KA4tDRAmbTcDt+NMPsgmhPe1
	4UbxfCAwU676noYT9L+sIw1O4HCrgGaCI4rb1sReBZuVZseF8EUUrv/ZEncR9dX4hwmfLtXv/A7Q6
	Z1Z/xxqirKNF0Zi18vNEiQnOntZZoHOY+aSNrarjbSqRtL13PPeaYP9ZeZ1qqtFW4B+CzgX/XjUcq
	Sb5n4srJZUQdY7feCEqwxvmrPKrGACVNdyJHwbE7xCTtYXiK82IM3TRHrkcjqW9eIuHi8iLaOAaz+
	vjwpFbMALSjXyjNsAJdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPNbE-0000000DCpO-2Juq;
	Fri, 06 Nov 2026 17:19:36 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPNbB-0000000DCoU-0Oqk
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 17:19:34 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso555619a91.3
        for <kexec@lists.infradead.org>; Fri, 06 Nov 2026 09:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793985572; x=1794590372; darn=lists.infradead.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tEaeh2MQM8Yqh+InUxWcP/c3Ugn8r1gCgilB/e+XZTU=;
        b=RSs8Bw4Tr0pYgriMyg9LVPEQ3FYQCPIhj7eYP51taf1SuYoOrEVtxap3w6WCmuHUYL
         sFCd/q/blrKITsQ9uqgPtvBlsGL55p2rlbp+800SYHhpHuwcNh3UZOM+zbEnqxJFpX5/
         MRykEDzlgjHGQPmx6dChtoc1LpcT7n2ZXKVhTl45T8s/sF60qDx4J/s77G4IEoiG/wWF
         DP5FzwqyFgHmA9ZePl3vvvlqn/Bk4idnaTvzUmj3wIU4f8GmK6i7/TUSVBWh4DQRRB2H
         JMySSXtWTMkQTogfW6/iAC7NtWrKJMqJ9tfNVERM1VPgRtxDNKpDGzFhGuKdnTBxfmm4
         4z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985572; x=1794590372;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tEaeh2MQM8Yqh+InUxWcP/c3Ugn8r1gCgilB/e+XZTU=;
        b=EzeQpN2no7jihmGWbVE5i3teIKIs/sMWGQ6nkeJLQQysvceebdSYOiVTQeEHrxiRPH
         wXGfwKlThNvFzykrXC6rPJQo47nYRuo5CA4KKZbl+9EgQhntKeGktsUEqDvaOia2tIOA
         07jdGFzGMKEMDMXa+6STUzfSQCYpWQyRzT6nfL+s692pHTZO3PPSMw6i8/UBibjB99e8
         W0fIONLF2vtQ3nn2nK4GjaPhOV6+1GNdwR9ePBV1bfpnAUgsyFpOpQL4kSSdTPNhcvkQ
         z8sD/d8dgHzHBof0pfXGLz9ObWlJJGeJace2sSGVhVN9a2e3VOLg68wMJtCYbGdad0mg
         9g6g==
X-Forwarded-Encrypted: i=1; AL+hErHzkN/xIDjkGNV2wORrTObri7dSggIxnfN+6n0Ny98YJIMQupAsA1MnkbGTpFV+Bn5kFqy4Qw==@lists.infradead.org
X-Gm-Message-State: APuU4Z9AWK7Zbw33QSrSv9EoJZligldRR44B15y03TGbNDm3GqFkDDPZ
	TRGCuBbdc4JywZnU101kKYa2MuOcJtmM+2k7sRfgXnBO2929uHxeeGwOJp8jMJT4Xw==
X-Gm-Gg: AYBFou0clmCBzXs8fRjz3qukj5MOxtqpIDoFQXTKTPqx7G1bjTjsVywa5uem206wXIh
	hee6yVDzjqOFPztz359iAtHOfszLo47v882h9mnBJf3UgBspiNktLVrqbANkzmsg55S3fMngSKI
	dbZBjwI/TUCQyWFrOg+cIdG6CCD+tw7uD7psGEDnil2AOcGn3GNqLxYwNaGCK9ZQylqvRCXGgrr
	yXuRlKK5EEnvcfS5WOrP4J7eGVlT3G9MS7fCu776K9ueI62aNA0JWg6tLxR0hGnWUbmw0LRjScf
	UkwVrEvksZpSl/90WS4Q1OSu31TCPNFg3ttwCdJM279KWBSR0T8pOKAYl1A4waWN0tLNmfLp7YL
	3QrzP46UDmLEZL7A2KAI/evoA7v7X/syPDiRdi2db7+/8ge6C1kzgAQuL6h8mS1aQuRybJEBflk
	2/8byYYqLjaGecH7yN8mD8dlW3G28wWoU5ItvrL+Exhv17xoElSbAFKd8ORn547NdgnWTousHTx
	G7hG2Y9qvYEl7luEb9XbELOCoJLKgSwc7CfTnztAZvpUvWSeNstG5IJ3moiiXqx7syr87YB5WOt
	xVl3zfP6uRG/59WYiII6U2B6NpwqzuZ8W0kP1yCDNF8CBQT5ortAdv2xHFSuDDHQ
X-Received: by 2002:a17:90b:554d:b0:3ac:bfa7:b079 with SMTP id 98e67ed59e1d1-3b0db5edb73mr3411640a91.7.1793985571464;
        Fri, 06 Nov 2026 09:19:31 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a7fbcbsm795231a12.25.2026.11.06.09.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 09:19:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 17:19:28 +0000
Message-Id: <DMOAT4VV939P.2DI8CEOMMSKMY@google.com>
Subject: Re: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files
 after Live Update
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, <kexec@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>
Cc: <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <dmatlack@google.com>, <graf@amazon.com>, <jacob.pan@linux.microsoft.com>,
 <jgg@nvidia.com>, <jgg@ziepe.ca>, <jrhilke@google.com>,
 <julianr@linux.ibm.com>, <kees@kernel.org>, <kevin.tian@intel.com>,
 <leon@kernel.org>, <leonro@nvidia.com>, <lukas@wunner.de>,
 <mattev@meta.com>, <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-12-vipinsh@google.com>
In-Reply-To: <20261102153656.1431701-12-vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_091933_179986_7710DEC1 
X-CRM114-Status: GOOD (  24.96  )
X-Spam-Score: -13.3 (-------------)
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NEW_PRODUCTS,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 2, 2026 at 3:36 PM UTC, Vipin Sharma wrote:
> During retrieve():
>  * Validate the handed-over struct vfio_pci_core_device_ser header,
>    sizes, and flags.
>  * Locate the registered vfio-pci device matching the serialized domain
>    and BDF (requiring device->ops =3D=3D &vfio_pci_ops) under the device
>    lock. vfio-pci registers the vfio device before its probe completes,
>    and the probe holds that lock, so a device that is still being probed
>    is not returned.
[...]
>  * Open and return an anonymous VFIO cdev file via
>    vfio_device_liveupdate_cdev_open().

Here's an idea for how the device file could be created on retrieve,
which I'd like to hear your thoughts on.

The patches from Pasha at [1] lets userspace pass a
file-handler-specific argument to LIVEUPDATE_SESSION_RETRIEVE_FD. In the
next version of the tmpfs series, I'm planning to use that to have
userspace create the file and pass it in the argument, and the kernel
then restores the preserved file into it.

I wonder if VFIO should work the same way, e.g.:

  struct liveupdate_vfio_retrieve_arg {
          __u32 size;
          __s32 fd;
  };

Userspace would open /dev/vfio/devices/noiommu-vfioX itself and pass
the fd. retrieve() would check that it's an unbound vfio-pci cdev file
for the preserved device (domain/BDF, noiommu, incoming, cfg_size),
attach the incoming state to that file, and LUO would track that file
as the retrieved file. VFIO_DEVICE_BIND_IOMMUFD would then take over the
device as it does now. Since VFIO preservation is new, the argument
could simply be required.

I think this could get rid of some of the special handling:

 - There'd be no need to fake a cdev open with an anonymous inode, so
   PATCH 09 and PATCH 10 could probably be dropped.

 - retrieve() wouldn't need to look up the device by BDF, or reason
   about racing with probe under the device lock. If userspace was able
   to open the cdev, the device is registered and probed.

 - The device file would be opened through the normal cdev path, so the
   usual permission and LSM checks on the device node would apply.

 - It would be the same model across file types.

A few things I think would need care if you go this way. The file check
and the attach would need to happen under dev_set->lock so they can't
race with a concurrent VFIO_DEVICE_BIND_IOMMUFD on the same fd. And the
incoming state should probably be tied to that specific
vfio_device_file rather than just the vdev, so only the file passed to
RETRIEVE_FD can take over the device.

It would also change PATCH 12. Opening the cdev of an incoming device
would have to succeed, so the check would move to the first open of the
device instead: fail with -EBUSY if the device is incoming and the file
being bound doesn't have the incoming state attached. That one check in
vfio-pci would also cover VFIO_GROUP_GET_DEVICE_FD, which opens the
device right away, so vfio_liveupdate_incoming_is_preserved() and its
dev_is_pci() special case could be dropped from the VFIO core.

The next tmpfs version will also add a way for a file handler to say a
failed retrieve can be retried, and a helper to claim an existing file
before restoring into it (so a file LUO already manages, e.g. one that
is preserved in an outgoing session, is rejected). Both seem useful
here too, e.g. so that a mistake in the argument (wrong fd, an fd for
another device, an already bound fd) doesn't make the device
unretrievable. I'll Cc you when I send it, and I'm happy to share the
branch before then.

What do you think?

[1] https://lore.kernel.org/kexec/20261103010216.3447716-1-dmatlack@google.=
com/

