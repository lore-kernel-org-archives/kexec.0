Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E21CD98EF
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ZboXXhSPW6+dD4pxDQDq+/2Nr1RExG44843PmiSexM=; b=wgrR5VqT1YwJjPYqrTYurVMQ34
	bNW6CkcF4zIsZvtfholaNJX17LjqklZ1m93noMe3mN4FlGWsdC286aBTm+LInpBsQczoHYOOn6ZPH
	mwGQRa4B++DCf2q6dXuq2KVrPzR01xuekpMrDbyv4v1UevZ4+ElW+NmW7LU6Hb5buhZSocZfVG7kf
	fyEUVLTJoRvSyYVGAvg6XntrlyMVbBfG5zMoaXOisiLY+6nJWaw3PldFQm/2CuG53j0CTl5yPYt/t
	K6h/zXupV5Cv6On4/NxTFSJ2KED5TQgUfHgv6t8TqOrCoFIX8lbo8Wn4xEMKRRvI7fCACtie/UDKu
	dKiPnANA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZa6g-0000000GHLg-2SQD;
	Tue, 16 Jun 2026 20:09:58 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZa6d-0000000GHLL-3JCz
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 20:09:57 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2c69fa0b1f8so16715ad.0
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781640595; x=1782245395; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZboXXhSPW6+dD4pxDQDq+/2Nr1RExG44843PmiSexM=;
        b=QrszzZFJQ9I4D5Goo1UFTzaUOlsTkQzCX2krISHtB4T+mvRENwvCX3Pi78/idPlSGR
         XK2oq6k/177Xlb/LjObKT+TchQrrNOVVa5/rmQ6QmZy1Rqoxpp2JIuTNajIJL4Fwh6Gc
         3g003N81sxW3ZfZzMqyczlVVCLhVehD5RqEI9od3PjFnRGeMm9F5Oh8J6ao532bnJzwT
         hg0v571Vgt+L4fX4uDSyi8Qjri+h82Hh1xnZVauCrG1j+8vgrrgBa/iNckQJi653gV8D
         GLpAO8UtZSStnoeN+Qs8GVdwz2cMLeV8/3UwtBaAiW+VIFHBD4W5AMZEr+xg59ouTune
         ZF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781640595; x=1782245395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZboXXhSPW6+dD4pxDQDq+/2Nr1RExG44843PmiSexM=;
        b=YQcbgAJX/2JX6EMpFzLwr2hV2c9hAypJP3eABj68tFM/c0miNan1Z0MiQQ2f4M6wcC
         Yz5QCMX3bxLD9klF+4tgI2SltkLBKVowNbplcBvdKVYiTw0dQCN31O1YGAoVvLUBhWg7
         T51HfgX0CFwARTnloPZddckk18LILwrB6kd2erL+zYE2f4+9+lpJ8O4O3W4E1DER429p
         GFU93PpvC9gQbdLiPK3Cj9dyJY0zRzRKjlVcnd2KoybcZ2h+7r72haIbz9HoEnRn58uf
         ku5oVDMZnPRP2N1hS9kxm/Pz7Np0hN3mtomHQ96/yfT0x2oAyQVJtp4P9uc3G0tYxkRb
         bQ6w==
X-Gm-Message-State: AOJu0YxFnRu5sUSoO6mlaW5rbJ7SDgKWW8Lsm5rnU7u4fsbVob/c8nOr
	AC4DKrd+4vEzmiElvvRtmbvhHUZ8xIsFHzZZ+u6zIOKsYetAtvCSMOTVwm3Tqr2NQQ==
X-Gm-Gg: AfdE7cmyNT4AhdY7oJXryfjCHhZnfQOolLTB+PV7y13Ve/DjJZSpmLNAsRkmKJc7bW8
	a4uTh6huJQn4bR8CtwMkBpoxswZmVGH4Zw+q8rzChV4/8lG8q7vx+iiePRNsBdCMiilSZ21jwCb
	c1gP2tDe4YQh5XewYrmozeica2ob/+nddWjkkVp7oQmCpetNaSqjLh/vWeiZVPCQc1lqSfNLlv+
	v0GAtxhnB/SKecwpy6e5FbrRCFn8VMXxwd1MACxXvnIBegyahgzeQgywRA04OyY8t1MUL2M2AR6
	22QauHZOCOilTYkVMPP1Ber/J+IkJ+UinnIfFM3n0J/t9vpoR7Ek+3JIhVcbXvP03EU4fbSKCBy
	KbkxvyievNj03e8n49IB9QSzOlnm6yeSXiJx8yGpIruDT7kmp4DEF9lJui6ZGqZZj6AQLR1GYZW
	bAcuYSZCRlxkJv/9p1m+0kTmnD7iIE4KcbbVgAgNlDtUUbPbzpxFGa7NWmMb4oVExHUBblnZOOn
	v4b63WdcjyEAhhFNis=
X-Received: by 2002:a17:903:2307:b0:2c1:ee6e:be1c with SMTP id d9443c01a7336-2c6bbb0fd15mr461975ad.26.1781640594220;
        Tue, 16 Jun 2026 13:09:54 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9c016sm13938380b3a.8.2026.06.16.13.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 13:09:53 -0700 (PDT)
Date: Tue, 16 Jun 2026 20:09:49 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <ajGpxMXk9iyXLzC4@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-4-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-4-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_130955_874769_4245F9E3 
X-CRM114-Status: GOOD (  30.53  )
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

On Fri, May 22, 2026 at 08:24:01PM +0000, David Matlack wrote:
>During PCI enumeration, the previous kernel might have passed state about
>devices that were preserved across kexec. The PCI core needs to fetch
>this state to identify which devices are "incoming" and require special
>handling.
>
>Add pci_liveupdate_setup_device() which is called during device setup
>to fetch the serialized state (struct pci_ser) from the Live Update
>Orchestrator. The first time this happens, pci_flb_retrieve() will run
>and convert the array of pci_dev_ser structs into an xarray so that it
>can be looked up efficiently.
>
>If a device is found in the xarray, the PCI core stores a pointer to its
>state in dev->liveupdate_incoming and holds a reference to the incoming
>FLB until pci_liveupdate_finish() is called by the driver.
>
>This ensures proper lifecycle management for incoming preserved devices
>and allows the PCI core and drivers to apply specific Live Update
>logic to them in subsequent commits.
>
>Drivers can check if a device is an incoming preserved device (e.g.
>during probe) by calling pci_liveupdate_is_incoming().
>
>CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that the
>domain and bdf can be guaranteed to fit in an unsigned long and be used
>as the xarray key.
>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> MAINTAINERS                    |   1 +
> drivers/pci/Kconfig            |   2 +-
> drivers/pci/liveupdate.c       | 230 ++++++++++++++++++++++++++++++++-
> drivers/pci/liveupdate.h       |   5 +
> drivers/pci/probe.c            |   3 +
> include/linux/pci_liveupdate.h |  13 ++
> 6 files changed, 251 insertions(+), 3 deletions(-)
>

[snip]
>
> static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
> {
>-	args->obj = phys_to_virt(args->data);
>+	struct pci_ser *ser = phys_to_virt(args->data);
>+	struct pci_flb_incoming *incoming;
>+	int ret = -ENOMEM;
>+	u32 i;
>+
>+	incoming = kmalloc_obj(*incoming);
>+	if (!incoming)
>+		goto err_restore_free;
>+
>+	incoming->ser = ser;
>+	xa_init(&incoming->xa);
>+
>+	for (i = 0; i < incoming->ser->max_nr_devices; i++) {
>+		struct pci_dev_ser *dev_ser = &incoming->ser->devices[i];
>+		unsigned long key;
>+
>+		if (!dev_ser->refcount)
>+			continue;
>+
>+		key = pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
>+		ret = xa_insert(&incoming->xa, key, dev_ser, GFP_KERNEL);
>+		if (ret)
>+			goto err_xa_destroy;
>+	}
>+
>+	args->obj = incoming;
> 	return 0;
>+
>+err_xa_destroy:
>+	xa_destroy(&incoming->xa);
>+	kfree(incoming);
>+err_restore_free:
>+	kho_restore_free(ser);
>+	return ret;

Hmm.. This is interesting, so the KHO state is freed and it cannot be
reused. I see you already pointed out that we are putting an LUO policy
to say that the retry is not allowed.

But what should be the behaviour of liveupdate in this regard? Let the
system boot in a normal way? This might break other subsystems as they
might depend on PCIe restoring state properly. Also I think some of the
PCIe state, like device-id, BAR addresses, ACLs etc, might be used as
source of truth by other components.

For example, lets say FLB retrieve() of PCIe fails, but succeeds for
VFIO/IOMMU, now VFIO/IOMMU are restoring state of a device that is not
restored/preserved?

Should this be considered fatal?
> }
>
> static void pci_flb_finish(struct liveupdate_flb_op_args *args)
> {
>-	kho_restore_free(args->obj);
>+	struct pci_flb_incoming *incoming = args->obj;
>+
>+	xa_destroy(&incoming->xa);
>+	kho_restore_free(incoming->ser);
>+	kfree(incoming);
> }
>
> static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
>@@ -270,6 +335,91 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
> }
> EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
>
>+static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
>+{
>+	struct pci_flb_incoming *incoming = NULL;
>+	int ret;
>+
>+	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&incoming);
>+
>+	/* Live Update is not enabled. */
>+	if (ret == -EOPNOTSUPP)
>+		return NULL;
>+
>+	/* Live Update is enabled, but there is no incoming FLB data. */
>+	if (ret == -ENODATA)
>+		return NULL;
>+
>+	/*
>+	 * Live Update is enabled and there is incoming FLB data, but none of it
>+	 * matches pci_liveupdate_flb.compatible.
>+	 *
>+	 * This could mean that no PCI FLB data was passed by the previous
>+	 * kernel, but it could also mean the previous kernel used a different
>+	 * compatibility string (i.e. a different ABI).
>+	 */
>+	if (ret == -ENOENT) {
>+		pr_info_once("No incoming FLB matched %s\n", pci_liveupdate_flb.compatible);
>+		return NULL;
>+	}
>+
>+	/*
>+	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
>+	 * but it cannot be retrieved.
>+	 */
>+	if (ret) {
>+		WARN_ONCE(ret, "Failed to retrieve incoming FLB data\n");

I think this should probably be considered fatal as mentioned above or
the caller of this function should get an error so it can fail. I think
retrievel of preserved state should generally not fail unless there is
memory corruption or ABI is incompatible.
>+		return NULL;
>+	}
>+
>+	return incoming;
>+}
>+

[snip]
>+
>+static inline bool pci_liveupdate_is_incoming(struct pci_dev *dev)
>+{
>+	return false;
>+}
> #endif
>
> #endif /* LINUX_PCI_LIVEUPDATE_H */
>-- 
>2.54.0.746.g67dd491aae-goog
>

Sami

