Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B891C624D6
	for <kexec@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=r4JP7hdJDIoyNzBn71IHHKs1H6EQq5IVkqb5Ov73g6U=; b=l/FcF3XF9vXh0t
	YWjFraTQ5fmfDeF2CP9Vx9CkVHSH8usACpbDp9HzBJFHKpfbtnl9t/BenI0H8WSaKM+zG6XX6lIsO
	AQsK8PtTuILU2ev9r87cMPuoKTvMEG0OR7mjX+i6rmb6NLwPT+3SnuMmfCjFcDBzqQc3fp+c460vH
	SiJsG8hneNWmiPkTk9dSZhC9Nyt+86AJLZ5AgHJ6uAkW6crjfCASxV+eAwfV2JcIZSpTHXWI1Pa4r
	BgvFgHrgHJ5yg1cXxWleeTziDutOyW+K6eafrQkoPBrtLMZeLgiXITS29Xo9Eyjo1pY9hnVfIhUTj
	SKv4GjW8GiNfkEbfkbQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Fg6-00000000hR4-2dri;
	Thu, 03 Sep 2026 22:13:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Fg4-00000000hQy-2rqa
	for kexec@lists.infradead.org;
	Thu, 03 Sep 2026 22:13:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8145360234;
	Thu,  3 Sep 2026 22:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101961F000E9;
	Thu,  3 Sep 2026 22:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788473579;
	bh=r4JP7hdJDIoyNzBn71IHHKs1H6EQq5IVkqb5Ov73g6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=GJbE3cMiwk2m+HTjQDkXjeKFS1E9AOG2SjJmPZTC26+oeO6fguOgmcx6t05wmLZai
	 NaxyHbQlDgCP80WxyJ9W65Jt/LhlnDfUBGEHDS7W+YiwpVt9cVe77eoHumW43S1OJR
	 dToq0t3VuQllguK2eIVHdcJgALU73wI7aFzKvPcWl3poD4Yq3PLlStZC2CrLXiXoB9
	 QTTVtYv9I3ih4/W5mWvF4X0QgWYNpFBcBSQDZdc65Di4GUvzN4ZbUh0l7ItHnSKqxX
	 Bn+UH+0dODxrLrg/IUaiuzbpf4GNesb0sIV1mKjlga06zFtkfbW79CJ1rCYvqo1ytn
	 7RUUoCcX/ayMg==
Date: Thu, 3 Sep 2026 17:12:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Jeffery <djeffery@redhat.com>
Cc: driver-core@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	Tarun Sahu <tarunsahu@google.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Laurence Oberman <loberman@redhat.com>, kexec@lists.infradead.org,
	Ewan Milne <emilne@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>,
	"Lombardi, Maurizio" <mlombard@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	Jeremy Allison <jallison@ciq.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Pasha Tatashin <tatashin@google.com>
Subject: Re: [PATCH 7/9] PCI: Link a virtual function to its physical function
Message-ID: <20260903221258.GA2263962@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902170734.95504-8-djeffery@redhat.com>
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

On Wed, Sep 02, 2026 at 01:07:32PM -0400, David Jeffery wrote:
> With a PCI virtual function having the same bus for its parent
> as the physical function it is associated with, there is no
> explicit dependency between the two in the device tree. With
> async shutdown, this can result in the PF being shutdown before the
> VF has an opportunity to shutdown.
> 
> Link the VF as a consumer of the PF to note its dependency and
> ensure clean shutdown ordering.
> 
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Tested-by: Laurence Oberman <loberman@redhat.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/iov.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 9d408fb8ac25..9b74211c6ab4 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -382,14 +382,20 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  	}
>  
>  	pci_device_add(virtfn, virtfn->bus);
> +	if (!device_link_add(&virtfn->dev, &dev->dev, DL_FLAG_STATELESS)) {
> +		rc = -ENOMEM;
> +		goto failed1;
> +	}
> +
>  	rc = pci_iov_sysfs_link(dev, virtfn, id);
>  	if (rc)
> -		goto failed1;
> +		goto unlink;
>  
>  	pci_bus_add_device(virtfn);
>  
>  	return 0;
> -
> +unlink:
> +	device_link_remove(&virtfn->dev, &dev->dev);
>  failed1:
>  	pci_stop_and_remove_bus_device(virtfn);
>  	pci_dev_put(dev);
> @@ -421,6 +427,7 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
>  	if (virtfn->dev.kobj.sd)
>  		sysfs_remove_link(&virtfn->dev.kobj, "physfn");
>  
> +	device_link_remove(&virtfn->dev, &dev->dev);
>  	pci_stop_and_remove_bus_device(virtfn);
>  	virtfn_remove_bus(dev->bus, virtfn->bus);
>  
> -- 
> 2.55.0
> 

