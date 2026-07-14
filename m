Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68319C43458
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 01:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C+LtOw1NmXZBSXUehU4TQ+aS3E1k4d+esuXPBPSaUXo=; b=pfBaWVnYpHsESADPU3jlmOyz84
	ou08tmBlyFsdiBqQmK2jkss92IcCvqb9qLGQfFzL4cA64To97/ncnNkKDkGxfHc/kCtpu1Rm3l8EU
	IbHXZDtD/tQOuPIezqDYx1rMo4MzwwVQb3n4cxMirPvBe+dIUqyk3cHsrkn+UAq0T11QBlGeZKnz4
	fb+yZHslbtUVD2v0SYa6gHTgIVLZ4W3J/x7M1mXa3RiivxLi+6DOxnRghMGs0Jzmh6jhSX66koEpY
	v3AXToFBduQWuaGBYhF8v3HZkOaWKLuNpfh6OuJJgCJfJ5N/fyBq6VRz1U4xQKw2dsX6f5tHwRz/3
	o2Lr7N1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjS4V-0000000AgPO-18uM;
	Tue, 14 Jul 2026 01:36:31 +0000
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjS4S-0000000AgOl-15Xt
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 01:36:29 +0000
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-c162ff98c4fso272875766b.1
        for <kexec@lists.infradead.org>; Mon, 13 Jul 2026 18:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783992985; x=1784597785; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C+LtOw1NmXZBSXUehU4TQ+aS3E1k4d+esuXPBPSaUXo=;
        b=cB/rKdpTlb0XR8orNA4fjjHVFwyvLO4TGsi7ntJ76pSb9Ts/zgL+748LHyz4KUIt6L
         28VoRV825cMqaj5R/tsFKULnr3HVlaatOOsoqKl6FzF+oMmFqjmqzmoTypEKOboW4PUd
         Orkis+VQLv2z2V37SBjMYRFd1TZoTvXEnyQXBlVQq9EId9A3UfII+Xcv6XbvPI/qid/z
         3GH77gdNI4rqso4ifJuD/nf1V9pyZXfFOha0TMKbwJWJmKYz7+wdDWLFf3WCzBD9HJjN
         cVgq/wSRyZwQnTF+wJ/MdBubA81xeJrxQQCvEHstn0nhNH9APEX06iBAFDVUA+y/bCP2
         7ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783992985; x=1784597785;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C+LtOw1NmXZBSXUehU4TQ+aS3E1k4d+esuXPBPSaUXo=;
        b=MiTNMTvJex9tC0QF4+qHBudFusvCO2qnKdkcFxT1l82TRPWnt1bDOjrUT4Jl+wLNr5
         9UaSZLXiH5gAPhdGaWI1cAcJghR5lh4SjXHF3VuZkR/1uUjoZmiiX+dBKfKJX3Eu8Yee
         4NSryjoEpehPFS9/jz1IafJKlxdUZ9ejvgS2CNwg9ZLtPk7eSo0JhZj88ss2n6WI9eeX
         lGiQ1KtSMtIAR1MnXdvtVIqLToa2TKJkaYkNV/WcUR/N6S3YI+Zt5AOK85Pqh71UIDf2
         kPh2Idb0g+Zt4Dwz27SDG3Lq/Q/GADpB8exMxgab6MVypznaEYXoC7yEpMXfhSY4waCZ
         6lcg==
X-Forwarded-Encrypted: i=1; AHgh+RoJL1Z7GS7TJJz0AXBVrTFOxPNvLy2nTtAgKO82M9epCbgXH1mn0ChGjfqq/ru03Vj6unbpRA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzQr7lCnzJIMovrF99ofbkVURdaRRM97XG74gtIjDFbvPBLnxm3
	+F/BNcNglEW6Sqf+5HzLo2g12RzPfRA1b+ebJsnmfA/IxnaT68gfMMen6tE1Cw70xU2zp1i0hZU
	1uFc3U+uvxL6QGACKAQ==
X-Received: from ejcxo14.prod.google.com ([2002:a17:907:bb8e:b0:c16:2bc1:b997])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c18:b0:c15:f360:6f29 with SMTP id a640c23a62f3a-c16619d7dbbmr55427066b.65.1783992984836;
 Mon, 13 Jul 2026 18:36:24 -0700 (PDT)
Date: Tue, 14 Jul 2026 01:36:23 +0000
In-Reply-To: <9huzech6xsrb.fsf@tarunix.c.googlers.com>
Mime-Version: 1.0
References: <20260701135015.81937-1-djeffery@redhat.com> <20260701135015.81937-4-djeffery@redhat.com>
 <20260701141145.52A611F000E9@smtp.kernel.org> <9huzech6xsrb.fsf@tarunix.c.googlers.com>
Message-ID: <9huzbjcaxsh4.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH 3/5] driver core: async device shutdown infrastructure
From: tarunsahu@google.com
To: driver-core@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Jeffery <djeffery@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, 
	"=?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?=" <mclapinski@google.com>, Jordan Richards <jordanrichards@google.com>, 
	Ewan Milne <emilne@redhat.com>, John Meneghini <jmeneghi@redhat.com>, 
	"Lombardi, Maurizio" <mlombard@redhat.com>, Stuart Hayes <stuart.w.hayes@gmail.com>, 
	Laurence Oberman <loberman@redhat.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	John Garry <john.g.garry@oracle.com>, kexec@lists.infradead.org, 
	David Jeffery <djeffery@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_183628_360867_3B815E16 
X-CRM114-Status: GOOD (  37.42  )
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


+Adding folks from the original message. Unfortunately, Sashiko drops
the people from the original message.

Tarun Sahu <tarunsahu@google.com> writes:

> Hello,
>
> These most of the errors are due to the device_add concurrently can add
> the device and device_shutdown can access it. One of the reason I think
> a device_add will be triggered while being shutdown is inserting the
> physical PCI device or USB stick etc.
>
> But During shutdown, addition of a new device is not valid. So we can
> add a check something like
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 76ba02c26aa5..c3795fa1cc26 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3650,6 +3650,13 @@ int device_add(struct device *dev)
>         if (!dev)
>                 goto done;
>
> +       if (unlikely(system_state =3D=3D SYSTEM_HALT ||
> +                    system_state =3D=3D SYSTEM_POWER_OFF ||
> +                    system_state =3D=3D SYSTEM_RESTART)) {
> +               error =3D -ESHUTDOWN;
> +               goto done;
> +       }
> +
>         if (!dev->p) {
>                 error =3D device_private_init(dev);
>                 if (error)
>
> We can also partially resolve the races partially by removing the manual
> kfree(dev->p) from device_add() error path. As put_device free it
> anyway when reference to devices reaches to 0. So if device_shutdown
> path takes reference, dev->p will not be released. And few races will be
> taken care of. But this will not resolve the deadlock and other races
> like the above change.
>
> removing the kfree(dev->p) from device_add can be a independent patch.
> like:
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4d026682944f..76ba02c26aa5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2614,6 +2614,7 @@ static void device_release(struct kobject *kobj)
>         struct device *dev =3D kobj_to_dev(kobj);
>         struct device_private *p =3D dev->p;
>
> +       dev->p =3D NULL;
>         /*
>          * Some platform devices are driven without driver attached
>          * and managed resources may have been acquired.  Make sure
> @@ -3824,8 +3825,6 @@ int device_add(struct device *dev)
>  parent_error:
>         put_device(parent);
>  name_error:
> -       kfree(dev->p);
> -       dev->p =3D NULL;
>         goto done;
>  }
>  EXPORT_SYMBOL_GPL(device_add);
>
>
> ~Tarun
>
>
> sashiko-bot@kernel.org writes:
>
>> Thank you for your contribution! Sashiko AI review found 4 potential iss=
ue(s) to consider:
>> - [High] Modifying the core.async_shutdown module parameter during shutd=
own causes synchronous suppliers to skip waiting for asynchronous consumers=
.
>> - [High] Unregistered consumer devices will cause a NULL pointer derefer=
ence during async shutdown dependency waiting.
>> - [High] Adding a new device with async shutdown enabled while its synch=
ronous supplier is being processed leads to an unresolvable deadlock.
>> - [High] Dereferencing `dev->p->dead` without NULL checks causes a crash=
 if a concurrent `device_add()` fails.
>> --
>>
>> commit cf98cdf76df805443cc885868cb3d9e13da5501c
>> Author: David Jeffery <djeffery@redhat.com>
>>
>> driver core: async device shutdown infrastructure
>>
>> This commit allows devices to opt into asynchronous shutdown, executing =
in
>> parallel with unrelated devices after their dependencies shut down. Sync=
hronous
>> shutdown devices will wait for their asynchronous dependencies. The feat=
ure is
>> enabled by default and can be toggled via the core.async_shutdown parame=
ter.
>>
>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>> --- a/drivers/base/core.c
>>> +++ b/drivers/base/core.c
>> [ ... ]
>>> +static bool wants_async_shutdown(struct device *dev)
>>> +{
>>> +	return async_shutdown && dev_async_shutdown(dev);
>>> +}
>>> +
>>> +static int wait_for_device_shutdown(struct device *dev, void *data)
>>> +{
>>> +	bool async =3D *(bool *)data;
>>> +
>>> +	if (async || wants_async_shutdown(dev))
>>> +		wait_for_completion(&dev->p->complete);
>>> +
>>> +	return 0;
>>> +}
>>
>> [Severity: High]
>> If a user-space process toggles the 0644 core.async_shutdown sysfs param=
eter
>> from 1 to 0 during shutdown, could this cause synchronous suppliers to s=
kip
>> waiting for their asynchronous consumers?
>>
>> If start_async_shutdown_devices() schedules an async consumer, and then =
the
>> parameter is toggled before the sync loop processes its supplier, the ca=
ll to
>> wants_async_shutdown(dev) here would evaluate to false.=20
>>
>> This would skip the wait_for_completion(), potentially causing the suppl=
ier
>> (e.g., a PCI bus) to shut down while its consumer is still active.
>>
>> [Severity: High]
>> Could this result in a NULL pointer dereference if the consumer is not y=
et
>> registered?
>>
>> The device_link_add() function allows creating links to consumer devices=
 that
>> haven't been registered yet, meaning their dev->p is NULL because
>> device_private_init() hasn't run.
>>
>> If wait_for_shutdown_dependencies() is called from the async pool, where=
 the
>> async argument is forced to true, the wait_for_completion() will
>> unconditionally evaluate &dev->p->complete, crashing on the NULL pointer=
.
>>
>> [ ... ]
>>> +static void __shutdown_one_device(struct device *dev)
>>>  {
>>>  	if (dev->p->dead)
>>>  		return;
>>
>> [Severity: High]
>> Could this cause a NULL pointer dereference if a concurrent device_add()=
 fails?
>>
>> If a concurrent device_add() fails after calling kobject_add(), its erro=
r path
>> calls kobject_del() and then frees and nullifies dev->p. Evaluating
>> dev->p->dead without checking if dev->p is valid could crash here.
>>
>> [ ... ]
>>> +static void start_async_shutdown_devices(void)
>>> +{
>>> +	struct device *dev, *next, *ndev, *needs_put =3D NULL;
>> [ ... ]
>>> +			needs_put =3D ndev;
>>> +			spin_lock(&devices_kset->list_lock);
>>> +			/*
>>> +			 * If the next device has been marked dead while the
>>> +			 * spinlock was released, it may no longer be on the
>>> +			 * devices_kset list. Restart the list walk to be safe
>>> +			 */
>>> +			if (ndev && ndev->p->dead)
>>> +				goto restart;
>>
>> [Severity: High]
>> Could ndev->p be NULL if a concurrent device_add() fails?
>>
>> If start_async_shutdown_devices() obtains a reference to next via
>> get_device(), and concurrently device_add() fails and clears dev->p,
>> reacquiring the lock and evaluating ndev->p->dead here could result in a=
 NULL
>> pointer dereference.
>>
>> [ ... ]
>>>  void device_shutdown(void)
>>>  {
>> [ ... ]
>>> -		shutdown_one_device(dev);
>>> +		if (!wants_async_shutdown(dev) || !shutdown_device_async(dev)) {
>>> +			wait_for_shutdown_dependencies(dev, false);
>>> +			shutdown_one_device(dev);
>>> +		}
>>> =20
>>>  		spin_lock(&devices_kset->list_lock);
>>>  	}
>>>  	spin_unlock(&devices_kset->list_lock);
>>
>> [Severity: High]
>> Can this sequence lead to an unresolvable deadlock if a new device is ad=
ded
>> concurrently?
>>
>> If a new device 'C' with DEV_FLAG_ASYNC_SHUTDOWN is added via hotplug
>> after its synchronous supplier 'S' has already been popped from
>> devices_kset by this loop, 'C' is appended to devices_kset.
>>
>> 'S' will call wait_for_shutdown_dependencies() and find 'C', blocking on
>> wait_for_completion(&C->p->complete) because wants_async_shutdown(C) is =
true.
>>
>> Since 'C' was added after start_async_shutdown_devices() ran, it is not
>> running in the async pool. Because the sync loop is blocked on 'S', it w=
ill
>> never reach 'C' to start it, deadlocking the shutdown process permanentl=
y.
>>
>> --=20
>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701135015.8=
1937-1-djeffery@redhat.com?part=3D3

