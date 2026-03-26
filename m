Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA8D10AB827
	for <kexec@archiver.kernel.org>; Thu, 26 Mar 2026 21:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CCYpXjeLBBDyCBHQMCqV7APFrQnNkgT9+u/rvK+zGmE=; b=3q3CzqeD5yeZApPgSRebdWnPWm
	+vhEWfJ9JXRb8LHlEz/Dxzc7PynGmQmnejaU/Xc3BXCvbf6FWDZ27WImV1UaTUkxMWgOpZHbJOM8Z
	qNXSLliFi+8W3OPBpTJqQ2SjRITmDdt9+0kwFnhMtfxOTUStmTgTjFQFI5+XCTvS9cnX3C13p2cdH
	2NDZioggMCkz3U0enOpC823fyMGxfs4bAbIn5WfsjBccW24TGA6wZaE08K7nKK38Vo7GH37uk1Flc
	cvMEFFI6aJSK5znygMbKWLKd+f+3iLJLrKpM56Q3SeoQ7NFjUMlOgR9JWo0YqGUTkgotV19xqY5fb
	GGmMQpoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5sQC-00000006GON-3J8Q;
	Thu, 26 Mar 2026 21:39:20 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5sQ9-00000006GNj-3FDu
	for kexec@lists.infradead.org;
	Thu, 26 Mar 2026 21:39:19 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-359f35dfef6so867739a91.2
        for <kexec@lists.infradead.org>; Thu, 26 Mar 2026 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774561157; x=1775165957; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CCYpXjeLBBDyCBHQMCqV7APFrQnNkgT9+u/rvK+zGmE=;
        b=e7vFD7/58YWCLXsZJd8u7hJUOQCZHp3wAAb2AEyg3jWkmCA4+gr8Lke8vWEgDbtGjS
         8xV6U/tOQ3N+tKUAwdcqOZuQvwkMo4tgLFvmMyd3tQtp0r5HwD/+hQ7Zw7MUy4Xz/atY
         NkulZWV9b7Egmuhidu8f5U7ti6riWSoGu1KdQznG0zXCfSvh61A9TOgfFsziOmXkMukq
         R2iXqfn+JM/RL70tpaiaHoeIIQeJR825qC76S+qKOpllec6qOadW7n7dMW9W2nk52ZG9
         V51p/Qxj3aTG9sZ7WNCoaf6IBOQ3WlDR5cD7YcUX1HhzqsVBA5ca+qSn9yJnJneakIDo
         HszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774561157; x=1775165957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCYpXjeLBBDyCBHQMCqV7APFrQnNkgT9+u/rvK+zGmE=;
        b=fO0wmkrUYhaK6vBl7Ji1Fd0aImx0NrzfpGBaDRzm1yBWbG9v4+RCFJ1TRbbcEIxmem
         yGhVqXCxzTNT3bAhueKe9A2jUr66bDfu80+TND4k0M1fcYgRK+leIHAWO/Ed70Ib7CyZ
         Jv/kq2Z8MaFj8ekK0eh1wHOXkMsveAKDDrBaHU/Bn8Pu/s9JDuh0ejhwpCcai5xLQAE5
         EOtsr2KIuyS5FqoMtnUybtrx1sM+kBg4mUPYQ5pzH8h94TDtueySiOBaeDbvzWsDfJK6
         C9LJya4mj7Zz3T39AEYEmXbwu/Lx9Usr2mdiq+UKRI1dCBvYiJJDUAQU5ztfnIVi6+Je
         4xjg==
X-Forwarded-Encrypted: i=1; AJvYcCVgiGHE5MHsomgcCgp29VDF3DAtynmbNQvnG5nDOWlCTwKxBBGOBdPjdVFs+Ya9YAxqcCF7dQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxRWkLdFZDtwFVgGv5f8NipifMUrdRWp1se9E+Q4W+kExkbWLCL
	Jy59boVW0A/jtHSl6f3Tij0Nmtj+tb47CvBw9avDDYaDbS9vbN9hcjtbjbbzHxF3WA==
X-Gm-Gg: ATEYQzwc3aIkWHdsi3txBVA6kezyEw4qtUi2r7Hzza3ivkkKTALVWv8H2GzWDAw4nAX
	hKleN1yHyEtaYStijhILfRymEBd1AzAfz6uw/sqNwEdB5khxVO0lC9OACz8M51vov/owqmYTwEI
	qMNU4pdhiUi20iO2BuQqun2yX5Lm26Sz44zzIyG5+GTSECS+ewm0jEOaUjsmq+CjI5nbWk20tbb
	Z+WTM5/GaXcnJBP8Kp9QW3aeykcPxipMZLh6ALyYYCRjrIDSWmB9Q6VinjRPfO2CTxtfO6Jo3bH
	nkXe221gYWwuWVNADdLlp/HuA+5lFKI9E+gP97CUNmRJUb5awi/4FHeFbERLprnW7hBk9x49No6
	yQP3YUlm7TEsC3KqecEBxxiIhKezbmLGoSdOQ5jlAUjxsHvwNGSzom8MnXngEYLM64D1tDRiJsy
	ixgw5kYTVLZTKF0eH/033/9Nf/evIj44tM6S1Pto3M1CF92ol9UyOdg5Ohvp+qgRGk0q+nHUt6
X-Received: by 2002:a17:90b:164a:b0:359:f2e1:5906 with SMTP id 98e67ed59e1d1-35c2ffb6610mr150758a91.4.1774561156125;
        Thu, 26 Mar 2026 14:39:16 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a81744sm2682845a91.5.2026.03.26.14.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 14:39:11 -0700 (PDT)
Date: Thu, 26 Mar 2026 21:39:07 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Askar Safin <safinaskar@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Chris Li <chrisl@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	kexec@lists.infradead.org, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>,
	Marco Elver <elver@google.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3 02/24] PCI: Add API to track PCI devices preserved
 across Live Update
Message-ID: <acWne_ZCcF4YQN25@google.com>
References: <20260323235817.1960573-3-dmatlack@google.com>
 <20260325231207.GA1292813@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325231207.GA1292813@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_143917_842962_7FC925D2 
X-CRM114-Status: GOOD (  77.97  )
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

On 2026-03-25 06:12 PM, Bjorn Helgaas wrote:

Thank you for the thorough review Bjorn!

> On Mon, Mar 23, 2026 at 11:57:54PM +0000, David Matlack wrote:
> > Add an API to enable the PCI subsystem to participate in a Live Update
> > and track all devices that are being preserved by drivers. Since this
> > support is still under development, hide it behind a new Kconfig
> > PCI_LIVEUPDATE that is marked experimental.
> 
> Can you list the interfaces being added here

Yes will do.

> > +config PCI_LIVEUPDATE
> > +	bool "PCI Live Update Support (EXPERIMENTAL)"
> > +	depends on PCI && LIVEUPDATE
> > +	help
> > +	  Support for preserving PCI devices across a Live Update. This option
> > +	  should only be enabled by developers working on implementing this
> > +	  support. Once enough support as landed in the kernel, this option
> > +	  will no longer be marked EXPERIMENTAL.
> 
> This would be a good place for a one-sentence explanation of what
> "preserving PCI devices" means.  Obviously the physical devices stay
> there; what's interesting is that the hardware continues operating
> without interruption across the update.
> 
> s/support as landed/support has landed/ (maybe no need for this
> sentence at all)

Will do.

> > + * Driver API
> > + * ==========
> > + *
> > + * Drivers that support file-based device preservation must register their
> > + * ``liveupdate_file_handler`` with the PCI subsystem by calling
> > + * ``pci_liveupdate_register_flb()``. This ensures the PCI subsystem will be
> > + * notified whenever a device file is preserved so that ``struct pci_ser``
> > + * can be allocated to track all preserved devices. This struct is an ABI
> > + * and is eventually handed off to the next kernel via Kexec-Handover (KHO).
> > + *
> > + * In the "outgoing" kernel (before kexec), drivers should then notify the PCI
> > + * subsystem directly whenever the preservation status for a device changes:
> > + *
> > + *  * ``pci_liveupdate_preserve(pci_dev)``: The device is being preserved.
> > + *
> > + *  * ``pci_liveupdate_unpreserve(pci_dev)``: The device is no longer being
> > + *    preserved (preservation is cancelled).
> > + *
> > + * In the "incoming" kernel (after kexec), drivers should notify the PCI
> > + * subsystem with the following calls:
> > + *
> > + *  * ``pci_liveupdate_retrieve(pci_dev)``: The device file is being retrieved
> > + *    by userspace.
> 
> I'm not clear on what this means.  Is this telling the PCI core that
> somebody else (userspace?) is doing something?  Why does the PCI core
> care?  The name suggests that this interface would retrieve some data
> from the PCI core, but that doesn't seem to be what's happening.

I think this function can go away in the next version.

I added this so that the PCI core could prevent userspace from
retrieving the preserved file associated with the device from LUO if
the device is not in a singleton IOMMU group (see next patch). But per
the discussion with Yi I am going to move that check to probe time.

> > + *
> > + *  * ``pci_liveupdate_finish(pci_dev)``: The device is done participating in
> > + *    Live Update. After this point the device may no longer be even associated
> > + *    with the same driver.
> 
> This sets "dev->liveupdate_incoming = false", and the only place we
> check that is in pci_liveupdate_retrieve().  In particular, there's
> nothing in the driver bind/unbind paths that seems related.  I guess
> pci_liveupdate_finish() just means the driver can't call
> pci_liveupdate_retrieve() any more?

liveupdate_incoming is used by VFIO in patch 10:

  https://lore.kernel.org/kvm/20260323235817.1960573-11-dmatlack@google.com/

Fundamentally, I think drivers will need to know that the device they
are dealing with was preserved across the Live Update so they can react
accordingly and this is how they know. This feels like an appropriate
responsibility to delegate to the PCI core since it can be common across
all PCI devices, rather than requiring drivers to store their own state
about which devices were preserved. I suspect PCI core will also use
liveupdate_incoming in the future (e.g. to avoid assigning new BARs) as
we implement more of the device preservation.

And in case you are also wondering about liveupdate_outgoing, I forsee
that being used for things like skipping disabling bus mastering in
pci_device_shutdown().

I think it would be a good idea to try to split this patch up, so there
is more breathing room to explain this context in the commit messages.
> 
> > + * device file for as long as it is preserved.
> > + *
> > + * However, there is a window of time in the incoming kernel when a device is
> > + * first probed and when userspace retrieves the device file with
> > + * ``LIVEUPDATE_SESSION_RETRIEVE_FD`` when the device could be bound to any
> > + * driver.
> 
>   ... window of time in the incoming kernel between a device being
>   probed and userspace retrieving the device file ... when the device
>   could be bound ...
> 
> I'm not sure what it means to retrieve a device file.  It doesn't
> sound like the usual Unix "device file" or "special file" in /dev/,
> since those aren't "retrieved".

For the forseeable future, device preservation will be triggered by
userspace preserving a VFIO device file in a LUO session using the ioctl
LIVEUPDATE_SESSION_PRESERVE_FD.  After kexec, userspace retrieves the
preserved file with the ioctl LIVEUPDATE_SESSION_RETRIEVE_FD.

This section would probably make more sense if it talked about VFIO
specifically instead of abstract "files" since that is the currently the
only use-case.

I expect non-VFIO drivers (i.e. "in-kernel") drivers could be supported
eventually but they will likely need a different API.

> > +static DEFINE_MUTEX(pci_flb_outgoing_lock);
> 
> It'd be handy if there were some excuse to mention "FLB" and expand it
> once in the doc above, since I have no idea what it means or where to
> look for it.  Maybe unfortunate that it will be pronounced "flub" ;)

I will add a section explaining FLB to the kerneldoc above.

> > +static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> > +{
> > +	struct pci_dev *dev = NULL;
> > +	int max_nr_devices = 0;
> > +	struct pci_ser *ser;
> > +	unsigned long size;
> > +
> > +	/*
> > +	 * Don't both accounting for VFs that could be created after this
> > +	 * since preserving VFs is not supported yet. Also don't account
> > +	 * for devices that could be hot-plugged after this since preserving
> > +	 * hot-plugged devices across Live Update is not yet an expected
> > +	 * use-case.
> 
> s/Don't both accounting/Don't bother accounting/ ? not sure of intent

"Don't bother" was the intent.

> I suspect the important thing here is that this allocates space for
> preserving X devices, and each subsequent pci_liveupdate_preserve()
> call from a driver uses up one of those slots.
> 
> My guess is this is just an allocation issue and from that point of
> view there's no actual problem with enabling VFs or hot-adding devices
> after this point; it's just that pci_liveupdate_preserve() will fail
> after X calls.

Yes that is correct.

> > +static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> > +{
> > +	struct pci_ser *ser = args->obj;
> > +
> > +	WARN_ON_ONCE(ser->nr_devices);
> 
> I guess this means somebody (userspace?) called .unpreserve() before
> all the drivers that had called pci_liveupdate_preserve() have also
> called pci_liveupdate_unpreserve()?
> 
> If this is userspace-triggerable, maybe it's worth a meaningful
> message including one or more of the device IDs from ser->devices[]?

This is not userspace triggerable unless there is a bug in LUO and/or
the driver (VFIO). By the way, that is the case for all of the WARN_ONs
in this commit. They are no userspace-triggerable, they are just there
to catch "this should never happen, there must be a kernel bug" type
issues.

I see that a lot of your comments are about these WARN_ONs so do you
have any general guidance on how I should be handling them?

> > +static void pci_ser_delete(struct pci_ser *ser, struct pci_dev *dev)
> > +{
> > +	struct pci_dev_ser *dev_ser;
> > +	int i;
> > +
> > +	dev_ser = pci_ser_find(ser, dev);
> > +
> > +	/*
> > +	 * This should never happen unless there is a kernel bug or
> > +	 * corruption that causes the state in struct pci_ser to get
> > +	 * out of sync with struct pci_dev.
> 
> Corruption can be a bug anywhere and isn't really worth mentioning,
> but the "out of sync" part sounds like it glosses over something
> important.
> 
> I guess this happens if there was no successful
> pci_liveupdate_preserve(X) before calling
> pci_liveupdate_unpreserve(X)?  That does sound like a kernel bug (I
> suppose a VFIO or other driver bug?), and I would just say what
> happened directly instead of calling it "out of sync".

No not even that would cause this warning to fire because
pci_liveupdate_unpreserve() bails immediately if liveupdate_outgoing
isn't true. This truly should never happen, hence the WARN.

> 
> > +	 */
> > +	if (pci_WARN_ONCE(dev, !dev_ser, "Cannot find preserved device!"))
> 
> Seems like an every-time sort of message if this indicates a driver bug?
> 
> It's enough of a hassle to convince myself that pci_WARN_ONCE()
> returns the value that caused the warning that I would prefer:
> 
>   if (!dev_ser) {
>     pci_warn(...) or pci_WARN_ONCE(...)
>     return;
>   }

For "this should really never happen" warnings, which is the case here,
my preference is to use WARN_ON_ONCE() since you only need to see it
happen once to know there is a bug somewhere, and logging every time can
lead to overwhelmingly interleaved logs if it happens too many times.

> > +	for (i = ser->nr_devices; i > 0; i--) {
> > +		struct pci_dev_ser *prev = &ser->devices[i - 1];
> > +		int cmp = pci_dev_ser_cmp(&new, prev);
> > +
> > +		/*
> > +		 * This should never happen unless there is a kernel bug or
> > +		 * corruption that causes the state in struct pci_ser to get out
> > +		 * of sync with struct pci_dev.
> 
> Huh.  Same comment as above.  I don't think this is telling me
> anything useful.  I guess what happened is we're trying to preserve X
> and X is already in "ser", but we should have returned -EBUSY above
> for that case.  If we're just saying memory corruption could cause
> bugs, I think that's pointless.
> 
> Actually I'm not even sure we should check for this.
> 
> > +		 */
> > +		if (WARN_ON_ONCE(!cmp))
> > +			return -EBUSY;

This is another "this should really never happen" check. I could just
return without warning but this is a sign that something is very wrong
somewhere in the kernel and it is trivial to just add WARN_ON_ONCE() so
that it gets flagged in dmesg. In my experience that can be very helpful
to track down logic bugs during developemt and rare race conditions at
scale in production environments.

> > +void pci_liveupdate_unpreserve(struct pci_dev *dev)
> > +{
> > +	struct pci_ser *ser;
> > +	int ret;
> > +
> > +	/* This should never happen unless the caller (driver) is buggy */
> > +	if (WARN_ON_ONCE(!dev->liveupdate_outgoing))
> 
> Why once?  Is there some situation where we could get a flood?  Since
> we have a pci_dev, maybe a pci_warn() that would indicate the driver
> and device would be more useful?

ONCE because this is a sign of a kernel bug and one instance is enough
to warrant debugging and fixing. Allowing multiple could lead to logs
interleaving, log rotation, and other issues if there is an excessive
amount.

I also chose full WARN_ON_ONCE() over just a warning log line so that
the user gets a backtrace and can see the caller.

I agree that showing the PCI device and driver would be helpful so
pci_WARN_ONCE() would be better.

> > +	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
> > +
> > +	/* This should never happen unless there is a bug in LUO */
> > +	if (WARN_ON_ONCE(ret))
> 
> Is LUO completely in-kernel? 

Yes

> I think this warning message would be
> kind of obscure if this is something that could be triggered by a
> userspace bug.

This can only be triggered by a kernel bug.

> Also, we do have the pci_dev, which a WARN_ON_ONCE()
> doesn't take advantage of at all.

I'll switch to pci_WARN_ONCE().

> > +	/*
> > +	 * Live Update is enabled and there is incoming FLB data, but none of it
> > +	 * matches pci_liveupdate_flb.compatible.
> > +	 *
> > +	 * This could mean that no PCI FLB data was passed by the previous
> > +	 * kernel, but it could also mean the previous kernel used a different
> > +	 * compatibility string (i.e.a different ABI). The latter deserves at
> > +	 * least a WARN_ON_ONCE() but it cannot be distinguished from the
> > +	 * former.
> 
> This says both "there is incoming FLB data" and "no PCI FLB data".  I
> guess maybe it's possible to have FLB data but no *PCI* FLB data?

Yes, PCI is just the users of File-Lifecycle Bound (FLB) data to
preserve state across Live Update.

> s/i.e.a/i.e., /

Will do.


> > +	 */
> > +	if (ret == -ENOENT) {
> > +		pr_info_once("PCI: No incoming FLB data detected during Live Update");
> 
> Not sure "FLB" will be meaningful to users here.  Maybe we could say
> something like ("no FLB data compatible with %s\n", pci_liveupdate_flb.compatible)?

Good idea, will do!

> > +u32 pci_liveupdate_incoming_nr_devices(void)
> > +{
> > +	struct pci_ser *ser;
> > +
> > +	if (pci_liveupdate_flb_get_incoming(&ser))
> > +		return 0;
> 
> Seems slightly overcomplicated to return various error codes from
> pci_liveupdate_flb_get_incoming(), only to throw them away here and
> special-case the "return 0".  I think you *could* set
> "ser->nr_devices" to zero at entry to
> pci_liveupdate_flb_get_incoming() and make this just:
> 
>   pci_liveupdate_flb_get_incoming(&ser);
>   return ser->nr_devices;

pci_liveupdate_flb_get_incoming() fetches the preserved pci_ser struct
from LUO (the struct that the previous kernel allocated and populated).
If pci_liveupdate_flb_get_incoming() returns an error, it means there
was no struct pci_ser preserved by the previous kernel (or at least not
that the current kernel is compatible with), so we return 0 here to
indicate that 0 devices were preserved.

> > +void pci_liveupdate_setup_device(struct pci_dev *dev)
> > +{
> > +	struct pci_ser *ser;
> > +
> > +	if (pci_liveupdate_flb_get_incoming(&ser))
> > +		return;
> > +
> > +	if (!pci_ser_find(ser, dev))
> > +		return;
> 
> If pci_liveupdate_flb_get_incoming() set ser->nr_devices to zero at
> entry, the bsearch() in pci_ser_find() would return NULL if there were
> no devices to search:
> 
>   pci_liveupdate_flb_get_incoming(&ser);
>   if (!pci_ser_find(ser, dev))
>     return;

I think this is explained by my reply to the previous comment.  If
pci_liveupdate_flb_get_incoming() returns an error then there was no
pci_ser struct passed to use by the previous kernel. Thus we return.

> > diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> > new file mode 100644
> > index 000000000000..7764795f6818
> > --- /dev/null
> > +++ b/include/linux/kho/abi/pci.h
> 
> It seems like most of include/linux/ is ABI, so does kho/abi/ need to
> be separated out in its own directory?

include/linux/kho/abi/ contains all of the structs, enums, etc. that are
handed off between kernels during a Live Update. If almost anything
changes in this directory, it breaks our ability to upgrade/downgrade
via Live Update. That's why it's split off into its own directory.

include/linux/ is not part of the Live Update ABI. Changes to those
headers to not affect our ability to upgrade/downgrade via Live Update.

> It's kind of unusual for the hierarchy to be this deep, especially
> since abi/ is the only thing in include/linux/kho/.

Yes I agree, but that is outside the scope of this patchset I think.
This directory already exists.

