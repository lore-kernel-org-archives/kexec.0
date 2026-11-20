Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E2B606A320
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RZkshWvE;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MnzalJel
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qAjYne+BgcE8DA63sQsMZ990H8S9yK78zgr2NZdv76Y=; b=RZkshWvENze7p0UCvXu642SO7d
	5PVIcvgGSYnviRxjOdoRMCD/z5lt52kxiE2Pw91gxHy8Enh5q+XWDIdin3FCe4596h3ITiEHeGwGd
	1nRh0YEyVo+fs+VT60hLlhHjB7EtaKzCJYibXt3ifmreqGTQcEy2rM/K/aPeyuEDJhwl6aREmM0fb
	Cw8u1zMwTVS4dWEzra4narF7MxXk9rgeFvkUlVwrn0d9N+OH9YLNZTrpcgq0Fd3i1uv4AuRQUfQwR
	Eo+rNNM1YN7pqHBuKgAJeSvI5tJoSzNnOprXSRnUZO+sju60ObOTbApiWsQWyGEtUmGFegaAs7RCn
	7p6nLYqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQMu-0000000FO2o-0q4z;
	Fri, 20 Nov 2026 15:17:40 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQMo-0000000FO2F-3BAl
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 15:17:37 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-150ef97e790so7391c88.1
        for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 07:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795187854; x=1795792654; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qAjYne+BgcE8DA63sQsMZ990H8S9yK78zgr2NZdv76Y=;
        b=MnzalJelDmdH/nPJOxmSwnhIJGchyUhKOaqeIsP7PaTNUOmmr4J/Vjz6Yjim5I4OEU
         HnqHyqRr6dI5J5AprAziExi01XbNsq912rH+KFnLRY6gINycGXdnvkT+BIMDgxNoJLhr
         4dk4oE/abfaeYHD/TN35633vdn4XgI2FwMAt0BHLXYJl1HubhxazrRsb+KB3oTVKSut/
         D7uczAlEe1Q7SLnf+R2ocr8RxvTITJc5QQeffGhTTzceWwBCr86bl82uUIV1N61gvzjE
         YtSqUljdbXKgl2jG2Yurtnin6mvU4GpHiF/SbxzoTUfJU5P/alNJdooNvPruwAaZJSb8
         rLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187854; x=1795792654;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qAjYne+BgcE8DA63sQsMZ990H8S9yK78zgr2NZdv76Y=;
        b=sqxUxCYP/6SkeIJXz28ZJBd336Hduk/C5SxvjQla/rZ7YLRvYiW3PAzAvJE7vVXbsh
         hsSpKdytbRS75GDwPjW0P2sVXDd4CH+CLQt9y4/rn2NAr2eA4QwdmnEoZzfX6986rAfD
         T4Nj+fS22NA5WgWQnhnx1+cNiIUg0rR2t4Ifd2Bv2e+jsVR/8J1+OcLMZoI5QxmIAbdi
         0HvVFqn4oLBqX2f3RmBcZdh34/DM4hqPTmgBt2u+Yz32qrxlkn+Of9qUyvpJXmV7m0QB
         1q/kL4wroWrBvA89vHiHerF6AskmEJ5fQBmmvRK8Ll2H7j8o/TCZVZX/aNY7uoe1VS0d
         Ktxg==
X-Gm-Message-State: APuU4Z/DfP2QJYsqUkjmI7ItUWQXnVcspDSFNQ1vmBMCumUks8Il2BUJ
	9pZ0dZdchm38FeszMNI/PNS9/xrYKh1xMoBfqZ6haOkrV+0gygHOMiGWONlk/BHIhA==
X-Gm-Gg: AYBFou3ELBbK4JKRHlZsTq6UrQgISGJZTCAYrPegNdCeWtWe7jl6uS6izxv938xt09X
	QR5JjD+up5OcPKhas368q5aDnknt3HgNrJ4XD6p9rvmS+zaL9RQN8Yt0Hh6Z44aseHPhG4kzRqr
	bWhABh6c7KeNhA7KgvJKz2RKCH6jEFaI1qB/3Z7YSAf2LToEhvkt25obOEoYV+Lv51uYd95CEJJ
	w3mf9ofqEF38Ql+Z8Pwqx9oe0+PHK9mlQUwHyWrBXe2lStZlJhvIuodWHEHqWLcqJ69y7SKztZw
	95pfbanwk+FN0rs2Oxwtli3UHas/o05Hn9YYjNkJ4pt8HRAy1CbOysgG7S00p1NWSXiP89Jmbee
	JgrPDxPhM5mIHZJZsBIkZfFqL0ylknfO/eJnHX4pdiDsSjSiPdXow0U/XbqFcxqsHYmuXf/yVFP
	nWCVyrTvoBhBRaoCFtGgUp0DnUCrPoDYvBQ2QZP5ELu/G03JVSaOeTo9ltlrluEQ0ytBMDNAAvL
	VjvEuBwt0juEFT+mNvFG2fHo15zBEixUERWDPOB6gTcT2bR5VBPKrsfCIWWyzpgd+n2gHoXMBEE
	azfQvGpqT2bzPEqDCQWhZggK6iSnTeQxA1N4/x1fZPbzJEBBnQjRB+VxBb49PD75jeu54K5NZyT
	bpmvyKdXLGzwV
X-Received: by 2002:a05:701b:4516:20b0:1b3:c4ba:8e0b with SMTP id a92af1059eb24-1b557b69270mr1215594c88.2.1795187852837;
        Fri, 20 Nov 2026 07:17:32 -0800 (PST)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e2bd1sm7441365c88.3.2026.11.20.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:17:32 -0800 (PST)
Date: Fri, 20 Nov 2026 15:17:23 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v11 09/13] PCI: liveupdate: Adopt ACS controls in
 incoming preserved devices
Message-ID: <awBkg0ODE436CZy0@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-10-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118223704.3286085-10-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_071735_600333_2C11A801 
X-CRM114-Status: GOOD (  29.23  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 10:37:00PM +0000, David Matlack wrote:
> Adopt Access Control Services (ACS) controls on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
> 
> Adopting ACS controls avoids changing routing rules while memory
> transactions are in flight from preserved devices. It also keeps IOMMU
> groups from changing during or after Live Update.
> 
> The adopted controls are recorded by the pci_save_state() call in
> pci_bus_add_device(), which runs before drivers bind, so they are
> reapplied by pci_restore_state() if the device is reset. Allocate the
> ACS save buffer for incoming preserved devices even if they match a
> device-specific ACS quirk, since their adopted controls live in the ACS
> capability, and panic if it could not be allocated.
> 
> To simplify ACS adoption, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account. If such a quirk matches an incoming preserved device
> anyway, e.g. because it was added in the new kernel, log a warning and
> adopt the device's ACS controls regardless, rather than reprogram a
> device in the path of a preserved device's memory transactions.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c | 75 ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/liveupdate.h | 16 +++++++++
>  drivers/pci/pci.c        | 13 +++++--
>  3 files changed, 102 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 00d6fa5236e9..b99a88c2c199 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -123,6 +123,9 @@
>   *
>   *  * The device cannot be a Virtual Function (VF).
>   *
> + *  * The device cannot require device-specific quirks to enable Access
> + *    Control Services (ACS).
> + * 

[...]

> +#include "liveupdate.h"
>  #include "pci.h"
>  
>  DEFINE_MUTEX(pci_slot_mutex);
> @@ -1071,9 +1073,13 @@ static void pci_allocate_acs_save_buffer(struct pci_dev *dev)
>  	/*
>  	 * Devices that rely on device-specific quirks to enable an ACS
>  	 * equivalent keep that configuration outside of the ACS Control
> -	 * register, so they are configured from scratch on restore.
> +	 * register, so they are configured from scratch on restore. The
> +	 * exception is devices preserved across a Live Update, which always
> +	 * adopt the ACS controls established by the previous kernel and need
> +	 * the buffer to keep them across resets.
>  	 */
> -	if (pci_need_dev_specific_enable_acs(dev))
> +	if (pci_need_dev_specific_enable_acs(dev) &&
> +	    !pci_liveupdate_was_incoming(dev))
>  		return;
>  

The ACS save buffer is forced for incoming devices that match an
enable_acs quirk, but neither existing quirk keeps its controls where
the generic code saves them (Intel PCH Root Ports have no ACS cap, 
SPT/UPT has the Control register at +8, not +6). Is the intent that 
such devices just lose their adopted controls if they ever lose config
state later? (e.g. a Root Port D3 cycle after pci_liveupdate_finish())
If so, maybe worth calling it out in a comment?

Apart from that:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

