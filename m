Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B55606A326
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 00:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3xPMqxrH;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Zt4M2vga
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=n7l+AyO/cRMVQJwJa64VigJKwgCGiEZe5FhWi4AHvFM=; b=3xPMqxrH5DVXl7
	rBdywiPvhZaAaX4sDdCOHJl6ZpoB5S5XR/r8w5Pd/5vtZQEb9gyWrDTCla/zfCwZbtY81CkmSGPep
	WprtlncPaz2xssUeVuZu0YwveyMXZJF34WbpjX/pu2hzjGb+gYAXd0W+z22Yt0IYKbxjSusT44c+f
	5H3cF1z4BzMMyFcizxRSSs45LWwzYv4p9vhxpKYgNWrt/3Qi54dFhOf7vcLPGeX9YO/Lss3uqzWf9
	n5ejsWENncP/Snmi1hM2dWih1m+dH6kgAx0WnJ0Mwg00Vfk4fBwBQk+jr34UJOphW69c11tG8pe0t
	td/HiTPO7YOIUPX1cIzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUCLs-0000000Djjb-2exo;
	Fri, 20 Nov 2026 00:19:40 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUCLp-0000000DjjF-26Kg
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 00:19:38 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2ed408b0d9dso1312925ad.2
        for <kexec@lists.infradead.org>; Thu, 19 Nov 2026 16:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795133976; x=1795738776; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n7l+AyO/cRMVQJwJa64VigJKwgCGiEZe5FhWi4AHvFM=;
        b=Zt4M2vgaB75l7bkf27czqwoLFrQDnFArJqbUpsWuSiHYp5C9DRuJJXxQ6f8uvZ8xLP
         t0nOUE/tm0zS5ONIKaNFhnUBVU+GIpasvpVLIw29PNL795EM6iltXx8ZVjpKKrEFKLSL
         t6WeFhWBIFSYocO3gq/KIYkQAKL8TcUWAVo69yp9BGBHzL15vTJNnrgRLJGaF+kn/iVw
         75TbhNDnkms/3nnlCJiWxgiytrHW1eyNeSZ7UhxqVXNRrgVMs+zbnQwLg1jQdKYyDrDh
         9Dipb9Y895BSy44cl2n+oTKSvCnF81WZr7jygeM0GMg0Pg9CVOyxmzizvOjTPIBWHX8A
         8UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133976; x=1795738776;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7l+AyO/cRMVQJwJa64VigJKwgCGiEZe5FhWi4AHvFM=;
        b=tHR9kqMyTzzoN8pI3jstVH9FOS3OvmAbtrUhbjJt1VJlI6sVjP3crioS0LQnzZwYhb
         DcGzKCE0I7/CyedbtVqcH5xsSf/LBzmNgNAQrXrF11DqwZ6EpXaKDX92U183X6I0upNg
         Z9VB/wvlcFGhVnaHYuKKr0v46IWQ8524MXvJ1uNiIEd+pYOQ5TrhFYVhOeoC5Selvn/E
         hR7dup8Fn+O6Cy/0OpCYBSEOS3SL0FjVFcDlpma9kks5uNgXbbLi+4ad54Mpq+r6m8yw
         8prB+ZW2WjalFa+j/modbEUbQj93+WAxIJOBtYGn+etaxKLmSlUrvc4CzjSBzxfNAFV6
         qCKg==
X-Forwarded-Encrypted: i=1; AL+hErH9BNqchQJ4YGD15sGslvVUu4h5LtW0df5ZGYHlDBLRHVfrYXlmpe/uAlJee5PnIXaef66jWA==@lists.infradead.org
X-Gm-Message-State: APuU4Z9OElexo6d4ymKKs3DV2gNzrR13jv1GSdw0whxHxFVhoFt4qWwW
	3ZhJlXFenK3A8TyBBTtiON97eqgEC1LOZxYcjxGV+j8pDj+eobkk9Xvuef5OnHKDdg==
X-Gm-Gg: AZFdTZf77cyyyVfOq5ceF38uPyMcHQtmW9xJSGpLnSq30Li8oXje4Ep6taPQ9vOx4lZ
	+XT1p8kcteKyFw+rthmLrPsoCPryai+MFjEZTdRyd4HcyENgTEGWoE7mZeBSjfxW+u/4+F9aWhd
	itOc1QnPI2w4uLN5lcvVKhig/rLkn9dbaqhiYNN8bwqWNiNPPbw1UjEKwaioA7Mj64hcRhewZmM
	ejMOlzpULpsp9TVEIdRCWISU4i5uPk+1Ge802lpWmSGo92uWu59srb3Cj+WtGlA2Ec66A4N3HF7
	GNJ4YsAwDPXQosoKtkUfAT4LVmDs3TVcMq8xp5+MEUKFLTZ0dgwNk92CpoVU74fWNDnjp/h9k0l
	PuPN5KgFe/AKruMC2QxcvO96llQF+RybWGS1fPGzCmKEIuWzW9M0kZJfFpok7LvjSqQ4Pjjme23
	U8k9Y63+jSy0KNe+t/0IV/kojgDCiy+pTTrdq/gYNRepyVa+QsJmMdivPM0f5SZg4hSHpG437cM
	yxgvCJbkoiUagZYz6WviNkMAkx5dhdy3VO6w6OXa7OgDua5tQiJUyE+PZ/Nrv0OR9bw4WKQptE/
	+0To9ltqF3MUYctMNIXR7dwgYUdxNsqIYK4RtkUoyDIJXViFWxPiPV1P+hDyrcQI
X-Received: by 2002:a17:902:e542:b0:2e9:6b5b:3db6 with SMTP id d9443c01a7336-2f03f1a4967mr13941365ad.30.1795133975980;
        Thu, 19 Nov 2026 16:19:35 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0ddf40sm5969655ad.37.2026.11.19.16.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 16:19:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 16:19:34 -0800
Message-Id: <DMZLVV5YW6GW.1HMW8L8NIQ1XR@google.com>
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
Subject: Re: [PATCH v6 12/27] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, <kexec@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-13-vipinsh@google.com>
In-Reply-To: <20261102153656.1431701-13-vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_161937_545732_039E1C48 
X-CRM114-Status: GOOD (  13.53  )
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

On Mon Nov 2, 2026 at 7:36 AM PST, Vipin Sharma wrote:
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 12557d45dfee..e6ca4c3fda06 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -11,6 +11,7 @@
>  #include <linux/cdev.h>
>  #include <linux/module.h>
>  #include <linux/vfio.h>
> +#include <linux/pci.h>
> =20
>  struct iommufd_ctx;
>  struct iommu_group;
> @@ -446,4 +447,21 @@ static inline void vfio_device_debugfs_init(struct v=
fio_device *vdev) { }
>  static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { =
}
>  #endif /* CONFIG_VFIO_DEBUGFS */
> =20
> +#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
> +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_dev=
ice *device)
> +{
> +	struct device *d =3D device->dev;
> +
> +	if (dev_is_pci(d))
> +		return pci_liveupdate_is_incoming(to_pci_dev(d));
> +
> +	return false;
> +}
> +#else
> +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_dev=
ice *device)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_VFIO_PCI_LIVEUPDATE */

No need for the ifdef here and 2 definitions here. If
CONFIG_PCI_LIVEUPDATE is not enabled then the compiler should be able to
optimize vfio_liveupdate_incoming_is_preserved() to false.

