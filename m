Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AFEF5A8C3
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 20:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=86B2EppM//v3TWmEymAoj6QAs94Bt1WYW2cmbvlwvO8=; b=VgcJDmh7bumF7mDSdBtA2Ml+hq
	iWsIDJ028rvXDdA+0cnRqpl+yPaU+W57pgFLc/G8H0CThb3KExnMDHP9TidzydLTezJ75bZu/s0AD
	jkcqkcAJiFzal+nvIoa+gv35z/KE7d5RovD4VpNTdasFiidhjMruHCD0UPCxMz+BpVM/tNneLDR2x
	fjT7QImhUv49xaofg5B6rxqs4AYWjWvuDC2hEKvS/LtfgIOJnSCnp/eJc4lQy0wFylRnlISvR4Y1x
	UjMjCL7ZzM/aHAWKHCqP7jdnQpdIJO93vXRIOtAYbc+jPVnqEhW42pVf+sBUOA39hzO8CehDEcnV0
	vdVVFDGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEvBe-00000007cu5-12yr;
	Mon, 20 Apr 2026 20:25:42 +0000
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEvBb-00000007ctk-1y3s
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 20:25:40 +0000
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-8a1e1817db6so28965876d6.2
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 13:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776716738; x=1777321538; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=86B2EppM//v3TWmEymAoj6QAs94Bt1WYW2cmbvlwvO8=;
        b=WGNhz2J52TYPuHc4Fwou0vYuIgqgHHR3CXAY01YzzMJk5HVKK9oMicfk67ycZSJlsC
         l8Uqw1gEAHYoEwiUbuYC4PBYYfyMcUVM53jR967lwjS0xR+iVx8H62mLTPZcWfhDvFqm
         bcvcf9/CcHGMMWeyue2ik77zljkJ8nSaO4Hfi8Nj8OdQEemhReakhIB8RuX9M5Wrz1v9
         AZrjMxzxYNm8/MzpZLI8cl4/t23jbvPnJOgetecbVUJJusaLWBg6NR+z5/v8e5mIWTZ9
         sScppZ5WpkZE5ofo1IXLIvEvt8WEcftBwb7tmxlzZu7RSOUauWjPUwPim95P4iopDH5c
         yQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776716738; x=1777321538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86B2EppM//v3TWmEymAoj6QAs94Bt1WYW2cmbvlwvO8=;
        b=A5XaAC/w7VgOoi+xaDD8mVTjfer5GC+boiRGZKauL2uz7K93C6/LR58d4u+AIOCn5c
         7flfmRi7byb+5sOtVzt/gSwkb1W7gxRgidKDsFlYg19jg2ZLCfjbpcaev4hEEgumbL0+
         fU3yXtM+mq3s32C+PpTOWd/AMgVygAYrqvjJCLEbXZi/+dzCBxOU9qasSyUrSVnGsxaQ
         kekf6bFaFQdYad8b6DQAx0XFIR6HxqMlQzKI5BAue3Htf8vnp1YAGW4rW4EUQUlA/EYc
         I9UMxw/2xD+4EVFy16HkLIWJ3ogfKuotdWf0pO1IqDYkq+n9/4N2T+U5AGrBqw/4SJfP
         ky3A==
X-Forwarded-Encrypted: i=1; AFNElJ9n3xry/I5Hwk1uihDzGqIweAwKPcckM4G73EsY/O2Rxg/vBKwCAsuQQVKGLzMTdFNOF8cn+A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxs0Lih/33kAFHwBd8VGRS0SQIrJlhYzGli9I8lh2YP/xAjsmPM
	nqDiOJFk6eQ9k9gQzxNdaR2yABWN/Ny8GYkQ99lIyGQaL/zDJbXE0LaSuSB6VpUoMS0=
X-Gm-Gg: AeBDievkTE3aHb3bKk9IXatv5IirzLLN2VtnH1h6QJ1LvksIV9XanSCqnPzko2LfBCY
	IWBV29p9iAOW+677Zc/HbpjZIeBWgRHm7yTgJRMgI5L2PJ2+vaIDf/wyDMr1ok3552FYv68zpwL
	mt+P5CLEelbnfNRjmXixYzgX+OudlbwE3HwY5KeP9jRuTUhNOgh6mad/7MiVTZzFfZpOY8wBON3
	L7o+U/D3vhLduQoMwzFSS9JSkXovaUWYXOgCJovzTa9D7XSDDCZOM33vPf1pcFsrQcdiUXx1DDX
	l6PbKijMVn0q4oEiXxdi9osFudBb0i48qHTZeEeSzLfDLP3Ff3EEcD/GeTc6yzpXYM9ZXk68v8/
	GtQaLgIK9STA3HgUU/4yGFsPCVy3oEZkQpbk6N7Af7RDyl6XXFjWBO5lBRnize13PTPlj1vdIrz
	pc0CTi7roUiLp1bo2ZaWdEqwlQOSyo1QJidIFHaaF74di5f+mW3PJ/yMfYGpXp
X-Received: by 2002:a05:6214:3209:b0:8ac:ab90:d764 with SMTP id 6a1803df08f44-8b0281653a5mr266452836d6.48.1776716737948;
        Mon, 20 Apr 2026 13:25:37 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac6c3e7sm85895836d6.13.2026.04.20.13.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 13:25:36 -0700 (PDT)
Date: Mon, 20 Apr 2026 20:25:34 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Jeffery <djeffery@redhat.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, John Garry <john.g.garry@oracle.com>, kexec@lists.infradead.org
Subject: Re: [PATCH 1/5] driver core: separate function to shutdown one device
Message-ID: <h2r2jv4g2tednrybrmkn4d2dus3oalqsk3r2q4xrbuivucefon@n6vvx5bl5cm5>
References: <20260420152608.6244-1-djeffery@redhat.com>
 <20260420152608.6244-2-djeffery@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420152608.6244-2-djeffery@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_132539_521051_91559AA2 
X-CRM114-Status: GOOD (  18.73  )
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

On 04-20 11:26, David Jeffery wrote:
> Make a separate function for the part of device_shutdown() that does the
> shutown for a single device.  This is in preparation for making device
> shutdown asynchronous.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Tested-by: Laurence Oberman <loberman@redhat.com>
> ---
>  drivers/base/core.c | 71 +++++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 0613de0fbe44..5353c6c22d49 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4783,12 +4783,48 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
>  	return error;
>  }
>  
> +static void shutdown_one_device(struct device *dev)
> +{
> +	struct device *parent = dev->parent;
> +
> +	/* hold lock to avoid race with probe/release */
> +	if (parent)
> +		device_lock(parent);
> +	device_lock(dev);
> +
> +	/* Don't allow any more runtime suspends */
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_barrier(dev);
> +
> +	if (dev->class && dev->class->shutdown_pre) {
> +		if (initcall_debug)
> +			dev_info(dev, "shutdown_pre\n");
> +		dev->class->shutdown_pre(dev);
> +	}
> +	if (dev->bus && dev->bus->shutdown) {
> +		if (initcall_debug)
> +			dev_info(dev, "shutdown\n");
> +		dev->bus->shutdown(dev);
> +	} else if (dev->driver && dev->driver->shutdown) {
> +		if (initcall_debug)
> +			dev_info(dev, "shutdown\n");
> +		dev->driver->shutdown(dev);
> +	}
> +
> +	device_unlock(dev);
> +	if (parent)
> +		device_unlock(parent);
> +
> +	put_device(parent);
> +	put_device(dev);
> +}

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

Also, please CC: kexec@lists.infradead.org, this series helps the live 
update, and kexec performance.

Pasha

