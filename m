Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B060A2631
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ye80qQ0L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ly7lH7v+VDMueqPU2p6d5ywLJuHuLtyXRWe/1IaQkk=; b=ye80qQ0LXxoX/swQe5S18cynkD
	qfwH/2+OODTKr6YsdzjxS2YNbx/WsZC16hYz58QZpJ+Zo57jmtSgJnU8RI+BiheXIDwdnkyUuuSnB
	l+ag612UA+45V8RQqD3pPLcEQNIPs7XPTPZYvl0HhS8ETyQ1QwP1fVHW2727knWY9DuW2KUd98z0m
	2lLNZC8d4vOiKJUg+/s51FIiPXHaGPsmJBPtiMWTccSIX5wQLjQC2BuH6ym/CVhkC2Q0Y8UzrukYt
	R2P5wW6c1nOpJ2I/jFBD5XDwiqFWRbJA1EOMCDhu2/nacxNeiSWWWEcbdIHb8s0VUDSrIYKXtCuSV
	RltyaY7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJDGD-0000000AJ10-1325;
	Tue, 20 Oct 2026 17:04:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJDGC-0000000AJ0a-08ew
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 17:04:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C4FF643A12;
	Tue, 20 Oct 2026 17:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91201F000CA;
	Tue, 20 Oct 2026 17:04:22 +0000 (UTC)
Message-ID: <sashiko-outbox-179396@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] driver core: prevent device_add() during system
 shutdown
To: "David Jeffery" <djeffery@redhat.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, "Tarun Sahu" <tarunsahu@google.com>, "Stuart
 Hayes" <stuart.w.hayes@gmail.com>, "Laurence Oberman" <loberman@redhat.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, kexec@lists.infradead.org, "Ewan Milne" <emilne@redhat.com>, "John
 Meneghini" <jmeneghi@redhat.com>, =?utf-8?b?TG9tYmFyZGksIE1hdXJpemlv?= <mlombard@redhat.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "John Garry" <john.g.garry@oracle.com>, "Jeremy
 Allison" <jallison@ciq.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, "Pasha
 Tatashin" <tatashin@google.com>
In-Reply-To: <20261020164435.80499-3-djeffery@redhat.com>
References: <20261020164435.80499-1-djeffery@redhat.com>
 <20261020164435.80499-3-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:03:52 +0000
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
- [High] driver core: device_shutdown() calls synchronize_srcu() after bloc=
king probes
- [High] driver core: device_add() blocks nested device_link_add() during s=
hutdown
--

commit fff836fc21ae90945fdc03da97b97959ca2c2584
Author: Tarun Sahu <tarunsahu@google.com>

driver core: prevent device_add() during system shutdown

This commit prevents new devices from being registered during system
shutdown by checking system_is_shutting_down() in device_add() and
synchronizing in-flight device_add() calls in device_shutdown() using SRCU.

> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 83263e3fa5d44..bce555dd74f69 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c

[ ... ]

> @@ -3647,13 +3666,20 @@ int device_add(struct device *dev)
>  	struct device *parent;
>  	struct kobject *kobj;
>  	struct class_interface *class_intf;
> -	int error =3D -EINVAL;
> +	int idx, error =3D -EINVAL;
>  	struct kobject *glue_dir =3D NULL;
> =20
> +	idx =3D srcu_read_lock(&device_add_srcu);
> +
>  	dev =3D get_device(dev);
>  	if (!dev)
>  		goto done;
> =20
> +	if (unlikely(system_is_shutting_down())) {
> +		error =3D -ESHUTDOWN;
> +		goto done;
> +	}

[Severity: High]
Can this check in device_add() break nested device_link_add() calls for an
in-flight supplier registration when system_state transitions to a shutdown
state?

Suppose a consumer device is already registered in devices_kset->list, and
its supplier device is being registered in thread A:

Thread A:
device_add(sup_dev)
  srcu_read_lock(&device_add_srcu)
  system_is_shutting_down() -> false
  kobject_add(&sup_dev->kobj, ...)
    -> appends sup_dev to the tail of devices_kset->list (after con_dev)

If thread B now initiates shutdown, sets system_state to SYSTEM_RESTART,
SYSTEM_HALT, or SYSTEM_POWER_OFF, and waits in device_shutdown() at
synchronize_srcu(&device_add_srcu), thread A continues in device_add():

  if (dev->fwnode && !dev->fwnode->dev) {
          dev->fwnode->dev =3D dev;
          fw_devlink_link_device(dev);
  }

fw_devlink_link_device() walks the fwnode links and calls
device_link_add(), which registers the link device via device_register():

drivers/base/core.c:device_link_add() {
    ...
	if (device_register(&link->link_dev)) {
		put_device(&link->link_dev);
		link =3D NULL;
		goto out;
	}
    ...
reorder:
	device_reorder_to_tail(consumer, NULL);
    ...
}

Because system_is_shutting_down() is now true, the nested
device_register(&link->link_dev) -> device_add(&link->link_dev) fails with
-ESHUTDOWN.

As a result, device_link_add() returns NULL without creating the device
link and without calling device_reorder_to_tail(consumer, NULL) to move the
consumer after the supplier in devices_kset->list (and
__fw_devlink_link_to_consumers() / __fw_devlink_link_to_suppliers() drop
the fwnode_link when fw_devlink_create_devlink() returns -EINVAL).

When synchronize_srcu(&device_add_srcu) completes and device_shutdown()
walks devices_kset->list backward from tail to head, wouldn't the supplier
sup_dev be shut down before its consumer con_dev?

> +
>  	if (!dev->p) {
>  		error =3D device_private_init(dev);
>  		if (error)
> @@ -3803,6 +3829,7 @@ int device_add(struct device *dev)
>  	}
>  done:
>  	put_device(dev);
> +	srcu_read_unlock(&device_add_srcu, idx);
>  	return error;
>   SysEntryError:
>  	if (MAJOR(dev->devt))
> @@ -4877,6 +4904,7 @@ void device_shutdown(void)
> =20
>  	wait_for_device_probe();
>  	device_block_probing();
> +	synchronize_srcu(&device_add_srcu);

[Severity: High]
Should synchronize_srcu(&device_add_srcu) be called before
wait_for_device_probe() and device_block_probing() instead of after them?

If thread A is inside device_add(dev) and has already passed
system_is_shutting_down() before system_state is updated, but has not yet
reached bus_probe_device(dev), thread B can run wait_for_device_probe() and
device_block_probing() to completion and then block in
synchronize_srcu(&device_add_srcu).

While thread B is waiting in synchronize_srcu(&device_add_srcu), thread A
reaches:

device_add(dev)
  bus_probe_device(dev)
    device_initial_probe(dev)
      __device_attach(dev, true)

In drivers/base/dd.c:__device_attach(), if dev matches an asynchronous
driver on the bus, __device_attach_driver() sets data.have_async =3D true a=
nd
returns 0 before reaching driver_probe_device() / really_probe() (where
defer_all_probes is checked), and __device_attach() then schedules async
probing without checking defer_all_probes:

drivers/base/dd.c:__device_attach() {
    ...
		ret =3D bus_for_each_drv(dev->bus, NULL, &data,
					__device_attach_driver);
		if (!ret && allow_async && data.have_async) {
			dev_dbg(dev, "scheduling asynchronous probe\n");
			get_device(dev);
			async =3D true;
		} else {
			pm_request_idle(dev);
		}

		if (dev->parent)
			pm_runtime_put(dev->parent);
	}
out_unlock:
	device_unlock(dev);
	if (async)
		async_schedule_dev(__device_attach_async_helper, dev);
    ...
}

Similarly, if dev->driver was already set prior to device_add(dev),
__device_attach() calls device_bind_driver(dev) -> driver_bound(dev) ->
driver_deferred_probe_trigger(), queuing deferred_probe_work on
system_dfl_wq.

Once thread A calls srcu_read_unlock(&device_add_srcu, idx),
synchronize_srcu(&device_add_srcu) in device_shutdown() returns without
waiting for probes again. Can this allow __device_attach_async_helper()
(which performs runtime PM calls on dev and dev->parent) or
deferred_probe_work_func() (which reorders devices_kset->list via
device_pm_move_to_tail()) to run concurrently with device_shutdown()?

> =20
>  	cpufreq_suspend();
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020164435.8049=
9-1-djeffery@redhat.com?part=3D2

