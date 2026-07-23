Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2B1C531D1
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 23:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=RdLv00N7jX58E8HADs11ire5JMHBSKT9IgqUk1JawYw=; b=UvImk9yFy/DVCw
	O+DaeoKtcnA+2UrTVsTCiT+a5zYZoeqvW25/MDQ6bM8nEtFCpnl7YoCZqraFgQlIgIvbhqEN0/oGf
	luJUQIqHtyX5kpUen/CFcoQZhpFm3Js6vNiJ22iU9oMQc8L0SHQeEbX55f7Reto4rRjaW+1a6sQ7y
	Olyl6Wfys8/fO8w7Eg1SuwHpkrZJ/eUmBwntLtaQT9OtxC8agOxqiG5jW05g5LdDK93QPFhq19ksN
	iRB9cunOn+YrDUCzSkUpuN88WV2o4O82z56CABiwIUWcvb7ElNH6/Y6qae9zka02121AbdsQDEaSC
	nxR5R7Na7vaZUZczEn6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn2Q0-0000000FEom-1Mbx;
	Thu, 23 Jul 2026 23:01:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn2Py-0000000FEog-2Ohu
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 23:01:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9BB95600AA;
	Thu, 23 Jul 2026 23:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C181F000E9;
	Thu, 23 Jul 2026 23:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784847689;
	bh=RdLv00N7jX58E8HADs11ire5JMHBSKT9IgqUk1JawYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=eAEFQJJrZ7uwgqf0SgHo59C09zS97IR7/DOJa9wnEhNJHsi/MrkVGb5B4fpFV2gH9
	 gQoMFN9p8WCk0BnTxe6oAiNlMc7l7E1fdeB6k6zOpKGBxd9IpltA4M2cpnBLTgx9ND
	 s9SevN7RMHz3dtI6CumsFLt/WX6o2AdxtlaQGfwZUC7YQ3hJZrUu2ZtSVr9NtrdtNa
	 7QxgfYUt5cDaogs4th4zU4gzR+2fYpW3UUrHQZCyLJ3QEqVxYaDRpT9FrGiiw8IzAf
	 UPq0t40emte7mzuq2mEcT//7iVtv5WasN7ES9ptQPBCbkDoRRCAUPiDNjmXzAcdNJr
	 dRuw+3ML3Ootg==
Date: Thu, 23 Jul 2026 18:01:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
Message-ID: <20260723230127.GA869843@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710212616.1351130-6-dmatlack@google.com>
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

On Fri, Jul 10, 2026 at 09:26:08PM +0000, David Matlack wrote:
> During a Live Update, preserved devices must be allowed to continue
> performing memory transactions so the kernel cannot change the fabric
> topology, including bus numbers, since that would require disabling
> and flushing any memory transactions first.
> 
> To keep bus numbers constant, always inherit the secondary and
> subordinate bus numbers assigned to bridges during scanning, instead of
> assigning new ones, if any PCI devices are being preserved. Note that
> the kernel inherits bus numbers even on bridges without any downstream
> endpoints that were preserved. This avoids accidentally assigning a
> bridge a new window that overlaps with a preserved device that is
> downstream of a different bridge.

I know there are many references already, but I think "preserve"
conveys more of the meaning here than "inherit".

> + * pci_liveupdate_scan_bridge_begin() - Determine if a bridge should inherit bus numbers

Wrap to fit in 80 columns.

> + * @bus: The parent bus of the bridge.
> + * @dev: The PCI bridge device.
> + * @pass: The scan pass (0 for first pass, 1 for second pass).
> + *
> + * This function is called by the PCI core when it begins scanning a bridge.
> + * It determines whether the bridge should inherit the secondary and subordinate
> + * bus numbers assigned to it by the previous kernel. This is necessary to
> + * keep bus numbers constant for preserved devices downstream of the bridge.
> + *
> + * Return: True if bus numbers should be inherited, false otherwise.
> + */
> +bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
> +				      int pass)

I see that you named it this way to have a begin/end pair, but I think
this function name should be a predicate, i.e., it should ask a
question with a yes/no or true/false answer.  Something like
"preserve_bus_numbers".

> + * pci_liveupdate_scan_bridge_end() - Finish scanning a PCI bridge
> + * @dev: The PCI bridge device.
> + * @pass: The scan pass (0 for first pass, 1 for second pass).
> + *
> + * This function is called by the PCI core when it finishes scanning a bridge.
> + * It clears the inheritance status after the second pass so it can be
> + * re-evaluated on future scans.
> + */
> +void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass)
> +{
> +	/*
> +	 * Clear inherit_buses after the second pass so it can be re-evaluated
> +	 * on future scans.
> +	 */
> +	if (pass)

I think the decision based on "pass" belongs in the caller because
it's really an implementation detail of the pci_scan_bridge*() code,
and I think it's important that readers of that code understand that
we no longer need to preserve bus numbers without having to follow the
chain into liveupdate.

I guess the point here is that we've always known to preserve bus
numbers of existing devices, so after we've enumerated all the
liveupdate-preserved devices, it's safe to assign new bus numbers for
hot-adds, bus rescans, etc.  Right?

> @@ -1397,6 +1397,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  				  int max, unsigned int available_buses,
>  				  int pass)
>  {
> +	bool liveupdate, assign_new_buses = pcibios_assign_all_busses();

I have a pretty strong preference for non-negated booleans, but I also
think "assign_buses" is an unfortunate historical choice.  By default
Linux owns all resources, including bus numbers, so the exception case
is that we need to *preserve* things that were previously configured.
Especially in liveupdate, "assign buses" is the wrong sense -- the
requirement is that we preserve them.

So I think here a name like "preserve_buses" will express the intent
better even though it will lead to negation here and in tests of
"!preserve_buses" below.

>  	struct pci_bus *child;
>  	u32 buses;
>  	u16 bctl;
> @@ -1406,6 +1407,10 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  	u8 fixed_sec, fixed_sub;
>  	int next_busnr;
>  
> +	liveupdate = pci_liveupdate_scan_bridge_begin(bus, dev, pass);
> +	if (liveupdate)
> +		assign_new_buses = false;
> +
>  	/*
>  	 * Make sure the bridge is powered on to be able to access config
>  	 * space of devices below it.
> @@ -1449,8 +1454,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  		goto out;
>  	}
>  
> -	if ((secondary || subordinate) &&
> -	    !pcibios_assign_all_busses() && !broken) {
> +	if ((secondary || subordinate) && !assign_new_buses && !broken) {
>  		unsigned int cmax, buses;
>  
>  		/*
> @@ -1492,8 +1496,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  		 * do in the second pass.
>  		 */
>  		if (!pass) {
> -			if (pcibios_assign_all_busses() || broken)
> -
> +			if (assign_new_buses || broken)
>  				/*
>  				 * Temporarily disable forwarding of the
>  				 * configuration cycles on all bridges in
> @@ -1507,6 +1510,11 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  			goto out;
>  		}
>  
> +		if (liveupdate) {
> +			pci_err(dev, "Cannot reconfigure bridge during Live Update, skipping\n");
> +			goto out;
> +		}
> +
>  		/* Clear errors */
>  		pci_write_config_word(dev, PCI_STATUS, 0xffff);
>  
> @@ -1567,6 +1575,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
>  
>  	pm_runtime_put(&dev->dev);
> +	pci_liveupdate_scan_bridge_end(dev, pass);
>  
>  	return max;
>  }
> diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
> index cfdc3d62ec02..2be98819e313 100644
> --- a/include/linux/pci_liveupdate.h
> +++ b/include/linux/pci_liveupdate.h
> @@ -17,10 +17,14 @@
>   * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
>   * @outgoing: State preserved for the next kernel.
>   * @incoming: State preserved by the previous kernel.
> + * @inherit_buses: True if the PCI core should inherit the secondary and
> + *                 subordinate bus numbers assigned to this device due to
> + *                 an ongoing Live Update.
>   */
>  struct pci_liveupdate {
>  	struct pci_dev_ser *outgoing;
>  	struct pci_dev_ser *incoming;
> +	bool inherit_buses;
>  };
>  
>  struct pci_dev;
> -- 
> 2.55.0.795.g602f6c329a-goog
> 

