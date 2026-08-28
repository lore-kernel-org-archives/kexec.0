Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B391C61DBD
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uNXgP9aiWGCY8sBDBkxQ5jGmQfHLh/8XePeePdlfGZw=; b=DtFALuut/nGJsIlMOJzi2onHGE
	P9/2wS808DdjfsE1oJqoU1iBS0UXoHUPeolsuQqsL5MKx92oPZ6sDll3NIdYUmhqDFhLLkZ/n9QsB
	5GWq7mkGAoJPl3PZ2iDQWso1H512DMDzQLgHSl9v/VFvQCicCMH1RUHzgWRT+KhHlAgh64DnoVgFu
	RboMfYTkhzzeOzSRIx5mO8L8KLw5foXOijt0AxbpUTSjrHzzpceih6UPnlFrGec+4T5fiQn9Z1lbf
	kyvp1LBYScUlSxqfi0ifpM0/+xX/Z41nsCDX1HC5QG/Y6YEnXia70B90GX8SOwjTHpwEvipaJEoIK
	BKR6jQaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzyr7-000000068FD-0ooC;
	Fri, 28 Aug 2026 15:51:01 +0000
Received: from mail-ed1-x547.google.com ([2a00:1450:4864:20::547])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzyr5-000000068Eg-0E7F
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 15:51:00 +0000
Received: by mail-ed1-x547.google.com with SMTP id 4fb4d7f45d1cf-6a14f2e8c47so1143953a12.3
        for <kexec@lists.infradead.org>; Fri, 28 Aug 2026 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787932256; x=1788537056; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uNXgP9aiWGCY8sBDBkxQ5jGmQfHLh/8XePeePdlfGZw=;
        b=YLBNwd8HXzKRj2wo5p9/QjHAz76y0poxIsH8ckXMQywWOfRWHJQsMzmpVhokMsoF+g
         QWAtKoOD7hCowrWE+MVRtRh4s5nGPmOHvbX5HHUBqR0Gl1DDKsrJZBioj6jAoFYGGcKJ
         y/439cLd/kqKZY8ry2w3DCFuPAmhmZli+Xk8seDhXR5uS7AyHqy2NMnv6NHZ8oBcVI2p
         ZMMP7U3qCV+9BkUof7oRFL0QpSfMCd7gv6NEDjKfN1Orr6AVyFi3/5m/9iMzVbMwH5Rk
         Ut0th5b3y+6yLk6dfUQNXoS/apcdPxyNZLPsd5sVV8kzv28bh/vFco9vI5tw+QzpMlWL
         rT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932256; x=1788537056;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNXgP9aiWGCY8sBDBkxQ5jGmQfHLh/8XePeePdlfGZw=;
        b=eh2XtdXtdkZWFtavtM/CoHOVUuiBbg3GUD8nfy/uHccV6J3nImm/d2SYLDo2qugFbv
         6dS3dXB+QaEh4pPfdV2dcBO9WpvZOBvPGxvAbVNgJywVnEM24I+uTRlK56kSGdVTnowt
         cMe1jSIG5auzf1ER+PokAd8FIpSFH/H2cXl7thI90g1JT5qXmwb/w6quCpS3A1Ez/SFk
         /BEoXQCL3mc4zNWJK2EDAPWL79wkyp8WbvW5GUbMvRZ8diM2jVH7BH4nyjZEWC/ywgtf
         43ZiykQ++W5gqn5T8epJ1LjsgYjLTkYav5v1KTw2sz3pDzRdaM73OUiYRUXM/3Uxg15F
         hAJg==
X-Forwarded-Encrypted: i=1; AHgh+RpKEQyqMB2poe1/G3dRBeU8LJmA/sxMu3rjUFpH2Cb5K7qcG0ImazshmkGNeSXPpeUVhl0fJg==@lists.infradead.org
X-Gm-Message-State: AFuF++n544ecdf/JB9Zede1VIHCGf1a8pXbgbJPlRS4z8rUU7L3tSQDM
	oDQMCAhMCXD5y1L/R4rQjQkgNfGCWrrRnPVGMDAnuB4F8qca8wJAarc8icOs9xRc2IlUbDSXEQL
	6FxQXjk/5R/qdP5gNXA==
X-Received: from edrb21.prod.google.com ([2002:aa7:d495:0:b0:6a6:a82:8b98])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5286:b0:6a6:1c30:bc4c with SMTP id 4fb4d7f45d1cf-6a61c30c3cfmr2134011a12.5.1787932256221;
 Fri, 28 Aug 2026 08:50:56 -0700 (PDT)
Date: Fri, 28 Aug 2026 15:50:55 +0000
In-Reply-To: <20260821142414.150892-4-djeffery@redhat.com>
Mime-Version: 1.0
References: <20260821142414.150892-1-djeffery@redhat.com> <20260821142414.150892-4-djeffery@redhat.com>
Message-ID: <9huzjypaz1k0.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH 3/9] driver core: warn should device_move try to move a
 need_parent_lock device
From: tarunsahu@google.com
To: David Jeffery <djeffery@redhat.com>, driver-core@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Stuart Hayes <stuart.w.hayes@gmail.com>, 
	Laurence Oberman <loberman@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, kexec@lists.infradead.org, 
	David Jeffery <djeffery@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_085059_138760_6EA698DB 
X-CRM114-Status: GOOD (  23.01  )
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

David Jeffery <djeffery@redhat.com> writes:

> Currently, no device has need_parent_lock set and is moved by
> device_move. need_parent_lock is only set by the usb bus and very
> few device types ever use device_move.
>
> Add a warning to device_move to catch should it ever be used on a
> device with need_parent_lock set. The combination would break
> the immutable relationship needed between parent and child for
> need_parent_lock when locking and unlocking both.
>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Tested-by: Laurence Oberman <loberman@redhat.com>
> ---
>  drivers/base/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index bd9c2921e326..75f5931165a8 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4712,6 +4712,14 @@ int device_move(struct device *dev, struct device *new_parent,
>  	if (!dev)
>  		return -EINVAL;
>  
> +	/*
> +	 * device_move() should not be used on devices with need_parent_lock
> +	 * set. Concurrent reparenting will violate the immutable
> +	 * relationship needed while locking and unlocking both parent and
> +	 * child.
> +	 */
> +	WARN_ON(dev->bus && dev->bus->need_parent_lock);
> +
>  	device_pm_lock();
>  	new_parent = get_device(new_parent);
>  	new_parent_kobj = get_device_parent(dev, new_parent);
> -- 

Thankyou for adding this, Please feel free to add
Suggested-by: Tarun Sahu <tarunsahu@google.com>

Also, I have seen sashiko complaining about another problem with
device_move which is impractical/impossible. So I mentioning it below
for discussion/information.

Sashiko Claim: There is potential deadlock if a device is being
registered with DL_FLAG_STATELESS which skips the reordering of
the list so device_kset->list will have device dependent devices out of
order. Also same problem can be create by device_move.

=> This is impractical because a device being registered with
DL_FLAG_STATELESS must have its supplier already registered first
(Documentation/driver-api/device_link.rst) which inherently puts
them in the order.

Similarily for device_move() affecting topological order is very
impractical. Unless someone mis-use the API
device_move(..., DPM_ORDER_NONE). Which, as well, not favourable
on upstream.

Once topological order is messed up, neither async shutdown nor serial
(sync) shutdown can work. As it is precondition for it. except
DL_FLAG_SYNC_STATE_ONLY, which is handled in both implementation.


~Tarun

> 2.55.0

