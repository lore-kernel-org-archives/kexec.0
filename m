Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4736FD73E9C
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 22:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l69U1dIrB2ccHzImzegm889MzCj0l8Bz/N1WHXvfoHo=; b=KXCBRwXmxa661D4z6AX4PBfL8f
	6eZkdW8WlrveEqNnXl5vSkpt8IlYvigwU8balWrEQSrfEXptS7gk6rHQ77ebRvtxzdskAIKdXtMSd
	7zQSM+ugqB67eqHgmvRPaDr0TTNCKzRVmADyIXrJep1hz7n6VGLWwuQwZHwZpxxJjVPT8C3hXI3Kd
	XQpNwFms1BUJ1tup2OMXy5LJv9PDe0fM68FElzSY7yAWxBqiXYCnLK1kNlwzAKe+b6mK0Bxnkadso
	lyLZerXojevae6l4Y0Hda/Wh9wUufIfw5VSDgB1DavUfh0FsmkwbFqQodCO+H23tjJR9qKrKAgpGl
	Gkkag1RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlaOr-00000000jMJ-3c0Q;
	Thu, 29 Jan 2026 22:22:05 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlaOo-00000000jLt-2trz
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 22:22:03 +0000
Received: from localhost (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5D12120B7168;
	Thu, 29 Jan 2026 14:22:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D12120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769725321;
	bh=l69U1dIrB2ccHzImzegm889MzCj0l8Bz/N1WHXvfoHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JFbmvvQbSZuWgKtGygvkszx2JeEWdtJpgkKy9JrbMd/Wd5/9p+qh8F8DQZUL3TZRu
	 2F9IotVi63Q1+5xtXPAj5Z5VpgM5SnxXvlYLMhpARcjtNuquJ02rdkhqPezl4x+bzG
	 YQ4Gy7p2dGglcG8jvPE5kn+665aOMwS0WLDY/OxQ=
Date: Thu, 29 Jan 2026 14:21:58 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro
 <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, David Rientjes
 <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke
 <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
 kexec@lists.infradead.org, kvm@vger.kernel.org, Leon Romanovsky
 <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, "=?UTF-8?Q?Mic?=
 =?UTF-8?Q?ha=C5=82?= Winiarski" <michal.winiarski@intel.com>, Mike Rapoport
 <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>,
 Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta
 <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan
 <skhan@linuxfoundation.org>, "Thomas =?UTF-8?Q?Hellstr=C3=B6m?="
 <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu
 <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <20260129142158.00004cdc@linux.microsoft.com>
In-Reply-To: <20260129212510.967611-11-dmatlack@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
	<20260129212510.967611-11-dmatlack@google.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_142202_778263_7C86464E 
X-CRM114-Status: GOOD (  24.36  )
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

Hi David,

On Thu, 29 Jan 2026 21:24:57 +0000
David Matlack <dmatlack@google.com> wrote:

> From: Vipin Sharma <vipinsh@google.com>
>=20
> Do not reset the device when a Live Update preserved vfio-pci device
> is retrieved and first enabled. vfio_pci_liveupdate_freeze()
> guarantees the device is reset prior to Live Update, so there's no
> reason to reset it again after Live Update.
>=20
> Since VFIO normally uses the initial reset to detect if the device
> supports function resets, pass that from the previous kernel via
> struct vfio_pci_core_dev_ser.
>=20
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c       | 22 +++++++++++++++++-----
>  drivers/vfio/pci/vfio_pci_liveupdate.c |  1 +
>  include/linux/kho/abi/vfio_pci.h       |  2 ++
>  include/linux/vfio_pci_core.h          |  1 +
>  4 files changed, 21 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/vfio/pci/vfio_pci_core.c
> b/drivers/vfio/pci/vfio_pci_core.c index b01b94d81e28..c9f73f597797
> 100644 --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -515,12 +515,24 @@ int vfio_pci_core_enable(struct
> vfio_pci_core_device *vdev) if (ret)
>  		goto out_power;
> =20
> -	/* If reset fails because of the device lock, fail this path
> entirely */
> -	ret =3D pci_try_reset_function(pdev);
> -	if (ret =3D=3D -EAGAIN)
> -		goto out_disable_device;
> +	if (vdev->liveupdate_incoming_state) {
> +		/*
> +		 * This device was preserved by the previous kernel
> across a
> +		 * Live Update, so it does not need to be reset.
> +		 */
> +		vdev->reset_works =3D
> vdev->liveupdate_incoming_state->reset_works;
Just wondering what happened to skipping the bus master clearing. I
understand this version does not preserve the device itself yet; I=E2=80=99m
just curious whether there were specific difficulties that led to
dropping the earlier patch which skipped clearing bus master.

> +	} else {
> +		/*
> +		 * If reset fails because of the device lock, fail
> this path
> +		 * entirely.
> +		 */
> +		ret =3D pci_try_reset_function(pdev);
> +		if (ret =3D=3D -EAGAIN)
> +			goto out_disable_device;
> +
> +		vdev->reset_works =3D !ret;
> +	}
> =20
> -	vdev->reset_works =3D !ret;
>  	pci_save_state(pdev);
>  	vdev->pci_saved_state =3D pci_store_saved_state(pdev);
>  	if (!vdev->pci_saved_state)
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c
> b/drivers/vfio/pci/vfio_pci_liveupdate.c index
> 1ad7379c70c4..c52d6bdb455f 100644 ---
> a/drivers/vfio/pci/vfio_pci_liveupdate.c +++
> b/drivers/vfio/pci/vfio_pci_liveupdate.c @@ -57,6 +57,7 @@ static int
> vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)=20
>  	ser->bdf =3D pci_dev_id(pdev);
>  	ser->domain =3D pci_domain_nr(pdev->bus);
> +	ser->reset_works =3D vdev->reset_works;
> =20
>  	args->serialized_data =3D virt_to_phys(ser);
>  	return 0;
> diff --git a/include/linux/kho/abi/vfio_pci.h
> b/include/linux/kho/abi/vfio_pci.h index 9bf58a2f3820..6c3d3c6dfc09
> 100644 --- a/include/linux/kho/abi/vfio_pci.h
> +++ b/include/linux/kho/abi/vfio_pci.h
> @@ -34,10 +34,12 @@
>   *
>   * @bdf: The device's PCI bus, device, and function number.
>   * @domain: The device's PCI domain number (segment).
> + * @reset_works: Non-zero if the device supports function resets.
>   */
>  struct vfio_pci_core_device_ser {
>  	u16 bdf;
>  	u16 domain;
> +	u8 reset_works;
>  } __packed;
> =20
>  #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
> diff --git a/include/linux/vfio_pci_core.h
> b/include/linux/vfio_pci_core.h index 350c30f84a13..95835298e29e
> 100644 --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -16,6 +16,7 @@
>  #include <linux/types.h>
>  #include <linux/uuid.h>
>  #include <linux/notifier.h>
> +#include <linux/kho/abi/vfio_pci.h>
> =20
>  #ifndef VFIO_PCI_CORE_H
>  #define VFIO_PCI_CORE_H


