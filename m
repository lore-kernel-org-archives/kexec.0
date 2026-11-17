Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8C8606A31C
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 01:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1Eyvbjck;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=Yv7w+f4a;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Z6Bw6rdn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tixrKvDlE8HOBCT+YKZFYawn5B7wVxaXbSBVfB7YWRc=; b=1EyvbjckinJdhq
	zKm2nXrARjdnydMAZIyphdkYRcnWZuh1dyJ2hHxb7rNXApeNTEpZxQLejpaS354k3dcJgzSsII2Gn
	iUwXh+nfCxwdSlQwjvbX3cw9cZ4NqzLW8hPJ6Q5994vZpLcX57VZcTMcajnqTiAG2FtsvyAgiqvL2
	7EQkDcSNuFSTIv9RzHLs6v/HufJnbOLHNXCes0RS7o7aD6Lh4HYDvL7bmsXEgdRJXTvEGAiWx0YtR
	rlbbj1dbDDWFONou/DheNH/jRAOZz7LeX6LEKEYMaP8zBth5hSRwrlypxjT5UUVQg1zlqA84no3zL
	e2MxAtHgiGovvOHGUv7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT7hw-00000004HtV-0BWG;
	Tue, 17 Nov 2026 01:10:00 +0000
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT7hs-00000004Hsx-1qsR
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 01:09:58 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F4281D001A4
	for <kexec@lists.infradead.org>; Mon, 16 Nov 2026 20:09:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 16 Nov 2026 20:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794877792;
	 x=1794964192; bh=tixrKvDlE8HOBCT+YKZFYawn5B7wVxaXbSBVfB7YWRc=; b=
	Yv7w+f4a7yLZ7pS+fyZ1mVYAgiXOLpWpxo2CVDHwqDXl1vmhcWHDd7sJ3U3MKPPw
	b900vTAsW6wjs4L2LutPUaxBWa/Qn+BQmwQd/m6zPjDPzFUpnv94lexz09UlBaPB
	4jIQgonKLK1QAPiav7YLgLYJWarwcoFH9yajuhIMpvgJQOo+zHcp31DR4kECfsGq
	xjuHkHZ/GM04/N1ow/0nrNVJU/0z4RVhJfWNOvZW2BR8OJxVRAihb2Zj+41v4g9b
	w9ntpIBlfE4+I6F2d3K2aw01bleVd2TVKA5f1LtVf+X0tilSuWr5qJfPtIppMWEg
	m+FKe7rKC1vJcfJ1ec01Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794877792; x=
	1794964192; bh=tixrKvDlE8HOBCT+YKZFYawn5B7wVxaXbSBVfB7YWRc=; b=Z
	6Bw6rdny28CStS9ZT3Ge1pcIJzCxZPjOGEeotkhaDXB76lZzXQVOEEA9uz69AlmO
	ktDLvuJFsZIstAbTniNobym5xQsD14TsOxA7omojaqc/7hQdqIyQnpoW7p7Z9UHr
	xzk1bQMh3ZH0/pgyLEcpUO5OjRCps5DdizS4UplTSSn7ILKmeLeNwywTb1YnIT16
	FhQeMiUzYg8PU9PXtOUfyZDQKMZ4Bc7EiO/QztVEfSkcw8ppZqUHXBpqORuiyiox
	Dg/fxONsnp/GfEL9detq2rE2hNQzhZSIqdfzWe5oKF/Z3kjT3cdySUJLJ3tWLOta
	82YUe9SKSzCoIYwFd5G2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794877792; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm2:rsa-sha256:MyjvGovxKLCo6Ps7rr0XJRCZmlKbLBnVKOCTuWrayKEWsbo
	9TgR7W0ExcwbntqqzwQ80OrWCzUFLfpUVNT3+7G/rS6lY/dg+UyqMVLdr1m4G3Ts
	GwpG0a32r0c/GDcsaYywUixqGYrLzFaqNlTHEJbWItO+gBWkrQgVT46VsCchtUzK
	7ZmHyfRnYLMhphniHwo4B3pXvtMJDOjpVSLAK2tAx8AE7xm3oB0NS6/eYb6Sgz/Z
	ddvViUxLm7CU8Sc6EYEo9i3Vf7Iv4A/Si57WIFAsvQ2XdLL9TDxkpRxAocLQ0QMS
	UkE1wiOETUpCY85Pkawla9Zt2Fo7npTSaNQAixA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:D0E/4PDZJPnu1t1li8k5W6N3FEXxA0th0UdXIYFCnkI=:SydkCMeTxoLNHBfx2E/TOjZe/1v8iut1quLwh6idvL4=;
X-ME-Sender: <xms:X6n7aq-MELGOqApgzAuMrkTsb2N0K7bxZ-PDs_CLglWbaWoElny0zg>
    <xme:X6n7ahoiWK_hO5Os-hng9Ddr4HcKn0SYwJ1jtC5ZKj9Ign1n0JkCKjjC0Sd59vI-l
    6Yt9XzAYSZlK65O9ldNC6hrpsnuqUavUm2gcXsv_9wYYACkKHjHgw>
X-ME-Received: <xmr:X6n7ameM4l76dFyIO59e4sdYekMZU0fiH62OC-VQXZBZ2WsCgX31D5cQxLe-Cg>
X-ME-Proxy-Cause: dmFkZTEgxcyEJ/ZnG+FHJ0CeWRTo2IzLSs3YDikR2toXXr8YQ23eVsIcbtKGIr8dsYfpSa
    LXeDk0iE0EXpMXzwzGTeRQ9j5J9u+Y/kN5PEXjXKhAxlrQ+XnOqTVfcXWKSTj9ZwQI6NFt
    nWkN/0BGkOxhAFMzEq7TJyoPp0a5IKkOnAKFKvLkihhprjY/MxysB59sktE1WCqtN5PgTQ
    SnTb80Z9a/uOlWSDz/15bhAxELk/SWPPs2ghsECGsLkSVuycQlhdSpe8VXxyfPXAW75WaW
    frJZw3qgLH2lC2BdrR3XorZoD8XBtGOBwHPMDhK96xr9VsEfauZHSr0oy9IaOexJSDcAjw
    xN7TBzFE5JNfdE1GIgrSJZi1xzEFa9rGHe5zVJbssExAzaS/Lt3+Py/6fNwLNIitko60X1
    4rH21PkMwyD1ZtUoIHjwuRAXXAJoeks6OsVwhy45gpOOCNYW8+yBLZXr07sq1BwvBQQo0P
    T6PzYSWDajzebmuer1vwRzMIVtiFClpaccd6SwneVO4nHIEG510UwwcK16+Lw28lgHVUgt
    WuLvcZUtCFDiOW4pfYOCunMmCmDJr9Xji5ak/6Tcjshf9GoUA+Bwpv8eEqnt0C9z/covJe
    Rp/YI+G59Qqt/9h7XifbSXO9yrFLdiJlZjWF1ItoCZkyTNHqeVh0pZrW4liA
X-ME-Proxy: <xmx:X6n7ag9bAfMSkHhDhUH57dOOoFU9HsD08wM3T6A4pGeVFSXqzzQd_w>
    <xmx:X6n7agZv_NBVVCgjpSpQvnMGPdhb_azohY2xBadIeMpTqr_DNVQtig>
    <xmx:X6n7ar0_YZomJQm4F8zl_QTYN74iEKENrohAmiuueEJ5iBSUKIQX5Q>
    <xmx:X6n7ah00up13RCEJtSlDuJomE_dnJdnVfPC6NeFhBgJKtp8Xq_HdGA>
    <xmx:YKn7agwWCfdaBDaP3evcCkByMYUCzWlaYiqTrO-xd1Zgv8YME2QH-Sra>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 20:09:45 -0500 (EST)
Date: Mon, 16 Nov 2026 17:09:42 -0800
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, Jacob
 Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon
 Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike
 Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>,
 Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja
 <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma
 <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu
 <yi.l.liu@intel.com>, alex@shazbot.org
Subject: Re: [PATCH v10 09/13] PCI: liveupdate: Adopt ACS controls in
 incoming preserved devices
Message-ID: <20261116170942.720b06fd@shazbot.org>
In-Reply-To: <20261013162529.1928093-10-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
	<20261013162529.1928093-10-dmatlack@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_170957_057422_FDA31A88 
X-CRM114-Status: GOOD (  43.14  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 13 Oct 2026 16:25:25 +0000
David Matlack <dmatlack@google.com> wrote:

> Adopt Access Control Services (ACS) controls on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
> 
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change during or
> after Live Update.
> 
> The adopted controls are recorded by the pci_save_state() call in
> pci_bus_add_device(), which runs before drivers bind, so they are
> automatically reapplied by pci_restore_state() if the device is reset.
> If that save buffer could not be allocated there is nowhere to record
> the adopted controls, and they would be silently lost by the first
> reset. Program ACS from scratch in that case, which is a better outcome
> than leaving ACS disabled.
> 
> To simplify ACS inheritance, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c | 78 ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/liveupdate.h |  6 ++++
>  drivers/pci/pci.c        |  5 +++
>  3 files changed, 89 insertions(+)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 8d5ad26e948c..1d2324d339da 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -123,6 +123,9 @@
>   *
>   *  * The device cannot be a Virtual Function (VF).
>   *
> + *  * The device cannot require device-specific quirks to enable Access
> + *    Control Services (ACS).
> + *
>   * Driver Binding
>   * ==============
>   *
> @@ -174,6 +177,18 @@
>   * bus, since the bus numbers of the failed bridge can no longer be read from
>   * hardware and handing them to another bridge would let an unrelated device
>   * inherit the BDF of a preserved device.
> + *
> + * Handling Preserved Devices
> + * ==========================
> + *
> + * The PCI core treats preserved devices differently than non-preserved devices.
> + * This section enumerates those differences.
> + *
> + *  * The PCI core adopts all ACS controls enabled on incoming preserved devices
> + *    rather than assigning new ones. This ensures that TLPs are routed the same
> + *    way after Live Update and ensures that IOMMU groups do not change. Note
> + *    that a device will use its adopted ACS controls for the lifetime of its
> + *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
>   */
>  
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> @@ -189,6 +204,7 @@
>  #include <linux/slab.h>
>  
>  #include "liveupdate.h"
> +#include "pci.h"
>  
>  /**
>   * struct pci_liveupdate_global - Global state for PCI Live Update support
> @@ -520,6 +536,16 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * Do not preserve devices that rely on device-specific ACS equivalents
> +	 * (for now) since that would complicate keeping ACS constant across
> +	 * Live Update.
> +	 */
> +	if (pci_need_dev_specific_enable_acs(dev)) {
> +		pci_warn(dev, "Refusing to preserve device that relies on ACS quirks\n");
> +		return -EINVAL;
> +	}
> +
>  	/*
>  	 * Endpoint devices should not be preserved more than once.
>  	 * Bridges are preserved once for every downstream device that
> @@ -844,6 +870,58 @@ void pci_liveupdate_finish(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
>  
> +/**
> + * pci_liveupdate_adopt_acs() - Adopt ACS controls
> + * @dev: The PCI device to adopt ACS controls for
> + *
> + * For devices preserved across a Live Update, leave the ACS controls
> + * established by the previous kernel alone instead of programming new ones.
> + * The adopted controls are recorded by the pci_save_state() call in
> + * pci_bus_add_device(), so they are reapplied by pci_restore_state() if the
> + * device is subsequently reset.
> + *
> + * Return: 0 on success, or -EINVAL if the device was not preserved, requires
> + * device-specific quirks, or has nowhere to record the adopted controls.
> + */
> +int pci_liveupdate_adopt_acs(struct pci_dev *dev)
> +{
> +	/*
> +	 * Check if the device was preserved over a previous Live Update (even
> +	 * if it has already gone through pci_liveupdate_finish()). This ensures
> +	 * that the device continues to use the ACS controls established by the
> +	 * previous kernel.
> +	 */
> +	if (!dev->liveupdate.was_incoming)
> +		return -EINVAL;
> +
> +	/*
> +	 * The previous kernel should not have preserved any devices that
> +	 * require device-specific quirks to enable ACS, but if such a device is
> +	 * detected (e.g. new device-specific ACS quirk in the current kernel),
> +	 * log a big warning and fall back to the normal enable ACS path.
> +	 */
> +	if (pci_need_dev_specific_enable_acs(dev)) {
> +		pci_warn(dev, "Device-specific quirk required to enable ACS!\n");
> +		WARN_ON_ONCE(true);
> +		return -EINVAL;
> +	}

This looks pretty unsafe and the comment is only explaining how we
might get here, not why we shouldn't panic.  IIUC, the IOMMU lho
support requires singleton groups, but I'm not sure what it does if a
group becomes non-singleton in the new kernel (such as via a new quirk).

Is a warning related to what might be a parent bridge rather than the
endpoint device, really sufficient here?  Thanks,

Alex

> +
> +	/*
> +	 * Adopting the previous kernel's controls depends on them being
> +	 * captured in the ACS save buffer, so that they are reapplied if the
> +	 * device is later reset. Without that buffer, e.g. because it could
> +	 * not be allocated under memory pressure, the adopted controls would
> +	 * be silently lost by the first reset. Program ACS from scratch
> +	 * instead, which is a better outcome than leaving ACS disabled.
> +	 */
> +	if (dev->acs_cap && !pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS)) {
> +		pci_err(dev, "No ACS save buffer, not adopting ACS controls\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
>   * @dev: The PCI device to check
> diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> index e5d2a19d2ca2..d4721ffcecb2 100644
> --- a/drivers/pci/liveupdate.h
> +++ b/drivers/pci/liveupdate.h
> @@ -15,6 +15,7 @@ void pci_liveupdate_setup_device(struct pci_dev *dev);
>  void pci_liveupdate_cleanup_device(struct pci_dev *dev);
>  bool pci_liveupdate_preserve_bus_numbers(void);
>  bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
> +int pci_liveupdate_adopt_acs(struct pci_dev *dev);
>  #else
>  static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
>  {
> @@ -34,6 +35,11 @@ static inline bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus,
>  {
>  	return false;
>  }
> +
> +static inline int pci_liveupdate_adopt_acs(struct pci_dev *dev)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  #endif /* DRIVERS_PCI_LIVEUPDATE_H */
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 944590fdef48..650d7f92f93a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -35,6 +35,8 @@
>  #include <linux/aer.h>
>  #include <linux/bitfield.h>
>  #include <linux/suspend.h>
> +
> +#include "liveupdate.h"
>  #include "pci.h"
>  
>  DEFINE_MUTEX(pci_slot_mutex);
> @@ -1164,6 +1166,9 @@ void pci_enable_acs(struct pci_dev *dev)
>  	bool enable_acs = false;
>  	int pos;
>  
> +	if (!pci_liveupdate_adopt_acs(dev))
> +		return;
> +
>  	/* If an iommu is present we start with kernel default caps */
>  	if (pci_acs_enable) {
>  		if (pci_dev_specific_enable_acs(dev))


