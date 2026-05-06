Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7895CD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 18:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=fIaMoZAFPoptutV/byzcr7dLXQk0sTik7MpruNCabzE=; b=Idg3N6sLQDpiCW
	p86BRKuO134aGAvx1SoZaovqfVlJirS6w13FN2G3O5LAOMfrIRYFqduqDF0qcwOyvg7nwg/M3indu
	sEaYEkMzpo5m/aP6SU10iAqNxaPx+2Iz/QmvvkZcDwpPgfAA8GN7xv918odyd88uWJEtF9xZqrRSj
	5qXzwOR+SGmUeE9+2u6nz7lssR3jzWo4lWr8wsM9QcEVPR4WdDYEyk/ikoN8gQiLLJDoDBEmyBBLw
	wb0Wqyt2Z8WbBEDlGlJMXh+Tlm4+jAaWlhOA5/U95ZQPFUH3k5zBAZ8EnIO3u7sCyIADCF8mK/eqX
	wIknRlB0sCBqdVfINWcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKgyb-00000001m8e-3gAp;
	Wed, 06 May 2026 18:28:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKgya-00000001m8R-1ScE
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 18:28:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7D95D6014B;
	Wed,  6 May 2026 18:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03ABFC2BCB0;
	Wed,  6 May 2026 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778092083;
	bh=jlQrcIbWomenhNoj/8xHLnSkp47Vutmn92tD24BRgHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V80eYLLvvYNvUDbpR0K4vfgvU37Du3P8q/mYdWap7aJMgYwDVfSO4wTCRAtDACD0h
	 if8CYVD1r+xRoM++8D5IRg2t6KdADvfkZ7Us4L9lL0g++faf+Avpg+E1BxS5O6Xzml
	 Ay3LeydT62BJan98OtknbEk9aIakGsdHkB4MfbajWSXZZseGtyJdg4X9G4Bc8Xl3L+
	 rh0RYgEgL0iEwPXt/YMWkj3rYtadi5KX5AqnxYROIBso6XsW186SWwX7wpJemQMiXE
	 7Z+lDPWBGitu+v/QDhOV3zcum8sBM9VdkmzvoUu4XzpmzA5fgse/7h3s6wcXDoSVx6
	 lQpbgbv+9SoDQ==
Date: Wed, 6 May 2026 13:28:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Jeffery <djeffery@redhat.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Tarun Sahu <tarunsahu@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	=?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
	Jordan Richards <jordanrichards@google.com>,
	Ewan Milne <emilne@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>,
	"Lombardi, Maurizio" <mlombard@redhat.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Laurence Oberman <loberman@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>, kexec@lists.infradead.org,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 4/5] PCI: Enable async shutdown support
Message-ID: <20260506182801.GA805231@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429175016.7915-5-djeffery@redhat.com>
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

On Wed, Apr 29, 2026 at 01:50:15PM -0400, David Jeffery wrote:
> Like its async suspend support, allow PCI device shutdown to be performed
> asynchronously to reduce shutdown time.
> 
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Tested-by: Laurence Oberman <loberman@redhat.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

I'm concerned about tripping over driver issues, but it's a pretty big
benefit.  I think it's worth mentioning the "async_shutdown" module
parameter somewhere in the commit logs and putting an example in
Documentation/admin-guide/kernel-parameters.txt.

Might even consider keeping in -next for a cycle+ and targeting v7.3.

> ---
>  drivers/pci/probe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b63cd0c310bc..86e855090553 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1045,6 +1045,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  
>  	bus->bridge = get_device(&bridge->dev);
>  	device_enable_async_suspend(bus->bridge);
> +	device_enable_async_shutdown(bus->bridge);
>  	pci_set_bus_of_node(bus);
>  	pci_set_bus_msi_domain(bus);
>  	if (bridge->msi_domain && !dev_get_msi_domain(&bus->dev) &&
> @@ -2753,6 +2754,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	pci_reassigndev_resource_alignment(dev);
>  
>  	pci_init_capabilities(dev);
> +	device_enable_async_shutdown(&dev->dev);
>  
>  	/*
>  	 * Add the device to our list of discovered devices
> -- 
> 2.53.0
> 

