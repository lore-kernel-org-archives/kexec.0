Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E12606A32E
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4xKYlvBP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bD78txjVe7XGBIsptpU3tzd0BEuwDgRAjGdsmV0nEpk=; b=4xKYlvBP2BNAFbtoBgGYRA2ni/
	bozlnS1Bs57uvTenaPtAArvrJNLbqwJ4cru0+nlsWhffrjdlxinBVKiWIbl+lE8YxvHzBCHjlBMDa
	eprUTsJTbsp71/9Y/g9w5JGf4tPb+5fUZbf+2TYw3p1Itx+vfk9OxKw/EpY4OObjyu6RGR6q11HN+
	m7v9qZaCUSpNuYWMo8GrUdljxV/bIAJ2u3nv4LgT7TZov5Yj9yw6LMoZ7yHNKm3HwvFc/PPz0wa/H
	q7PVES0GnrtlcKnQjtXpEvvQHgLLJmPEwEp9SwnGKv3DmpyItsS2DUqusUz7/m0wcnMt5N+zc+eOs
	BK97rJjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJDV8-0000000AKYW-2h2q;
	Tue, 20 Oct 2026 17:19:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJDV7-0000000AKYO-0bFh
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 17:19:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 84CF443D61;
	Tue, 20 Oct 2026 17:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9F41F000C9;
	Tue, 20 Oct 2026 17:19:47 +0000 (UTC)
Message-ID: <sashiko-outbox-179411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] driver core: async device shutdown infrastructure
To: "David Jeffery" <djeffery@redhat.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, "Tarun Sahu" <tarunsahu@google.com>, "Stuart
 Hayes" <stuart.w.hayes@gmail.com>, "Laurence Oberman" <loberman@redhat.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, kexec@lists.infradead.org, "Ewan Milne" <emilne@redhat.com>, "John
 Meneghini" <jmeneghi@redhat.com>, =?utf-8?b?TG9tYmFyZGksIE1hdXJpemlv?= <mlombard@redhat.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "John Garry" <john.g.garry@oracle.com>, "Jeremy
 Allison" <jallison@ciq.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, "Pasha
 Tatashin" <tatashin@google.com>
In-Reply-To: <20261020164435.80499-7-djeffery@redhat.com>
References: <20261020164435.80499-1-djeffery@redhat.com>
 <20261020164435.80499-7-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:19:17 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] driver core: premature completion in kill_device() races with devi=
ce_del()
- [Low] driver core: missing kernel-doc for DEV_FLAG_ASYNC_SHUTDOWN
--

commit 82979b053d4cad6e7ae5134feb8f79f9f979e23e
Author: David Jeffery <djeffery@redhat.com>

driver core: async device shutdown infrastructure

This commit introduces asynchronous device shutdown support, allowing
devices flagged with DEV_FLAG_ASYNC_SHUTDOWN to execute their shutdown
callbacks in parallel after waiting for their child and consumer
dependencies to finish shutting down.

> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 93605698affcc..7fee6043dd375 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c

[ ... ]

> @@ -3925,6 +3932,7 @@ bool kill_device(struct device *dev)
>  	if (dev->p->dead)
>  		return false;
>  	dev->p->dead =3D true;
> +	complete_all(&dev->p->complete);
>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(kill_device);

[Severity: High]
Does signaling dev->p->complete in kill_device() wake parent and supplier
devices too early when a child or consumer device is concurrently removed
via device_del()?

In device_del(), kill_device() is called right at the start before dropping
device_lock(dev), while the actual driver unbinding and resource release
happen later:

drivers/base/core.c:device_del() {
	device_lock(dev);
	kill_device(dev);
	device_unlock(dev);
	...
		list_for_each_entry(class_intf, &sp->interfaces, node)
			if (class_intf->remove_dev)
				class_intf->remove_dev(dev);
	...
	bus_remove_device(dev);
	device_pm_remove(dev);
	...
	devres_release_all(dev);
}

During device_shutdown(), parent and supplier devices wait for child and
consumer devices in wait_for_shutdown_dependencies() ->
wait_for_device_shutdown(), which only waits on dev->p->complete:

	if (async || wants_async_shutdown(dev))
		wait_for_completion(&dev->p->complete);

Meanwhile, __shutdown_one_device() returns immediately without waiting if
dev->p->dead is set:

	if (!dev->p || dev->p->dead)
		return;

Before this change, a deleting child or consumer stayed on
devices_kset->list until kobject_del() at the end of device_del(), and
shutdown_one_device() serialized on device_lock(dev) against
bus_remove_device() -> device_release_driver() before device_shutdown()
moved on to the parent or supplier. Similarly, for async suspend,
device_pm_remove() does not call complete_all(&dev->power.completion) until
after bus_remove_device() has completed.

By completing dev->p->complete inside kill_device(), can a parent or
supplier proceed with its ->shutdown() callback and shut down a bus or
controller while its child or consumer is still executing
class_intf->remove_dev(), ->remove(), or devres_release_all()?

[ ... ]

> diff --git a/include/linux/device.h b/include/linux/device.h
> index aee79fd6b32b4..1ebafa7984621 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -612,6 +612,7 @@ enum struct_device_flags {
>  	DEV_FLAG_OF_NODE_REUSED =3D 7,
>  	DEV_FLAG_OFFLINE_DISABLED =3D 8,
>  	DEV_FLAG_OFFLINE =3D 9,
> +	DEV_FLAG_ASYNC_SHUTDOWN =3D 10,
> =20
>  	DEV_FLAG_COUNT
>  };

[Severity: Low]
enum struct_device_flags has a kernel-doc comment immediately above it (whi=
ch
is parsed via the :internal: directive in
Documentation/driver-api/infrastructure.rst). Should an entry for
@DEV_FLAG_ASYNC_SHUTDOWN be added to that comment to avoid a kernel-doc
warning?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020164435.8049=
9-1-djeffery@redhat.com?part=3D6

