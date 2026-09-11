Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E09C88E59
	for <kexec@archiver.kernel.org>; Fri, 11 Sep 2026 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sNNu1TO589CWD7onDuXMEv1eJ3q2rtxkDJ3Q314d4zo=; b=RhuzAExyKZoI3v8b4a4gOARExn
	UQeXvklfPlM5pRtyVJ19L5LFzmf2zLdUBfKZioJbraZrrHftY2wBLQ2dvR5tYPwnMWGmegzR5M/Cv
	oS7pumsMpX3p8uRVTp/OfYa1PB8PzxxmeEBacTy6XQfWJ4yvJG6rStYpr7NW5ZWfes7rGTXF+AiXN
	brDSBHkkbwvCCr2+xRsx8NT711QxANgPx4oFJ2iQbYVOR3Q1HDD0ICbeESLCGAEOCF9JsHNWAPxBS
	uZtDr5r3c1iPDjRnX7Xop4C7cCcsDPS0HuppClUUUH/X7ueN/j67PI8l3gTAzKcxWvpHJac459WGw
	uyoy/HhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x54MM-0000000HFSv-1hGX;
	Fri, 11 Sep 2026 16:44:18 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x54MI-0000000HFSE-48gR
	for kexec@lists.infradead.org;
	Fri, 11 Sep 2026 16:44:16 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2d9520b9155so11560275ad.3
        for <kexec@lists.infradead.org>; Fri, 11 Sep 2026 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789145054; x=1789749854; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sNNu1TO589CWD7onDuXMEv1eJ3q2rtxkDJ3Q314d4zo=;
        b=j0HKFndX+UYy0eSguiLL5Kx8Dxq9kTXTh1xnlOz05y0cNDKG+0GUtCcpnsMPdJGst0
         YMd+zCsJgi8VuQxOC+lxoNzcu/dNWxTj4iWpvzIIVqZNfsoACFKEFZRauL4GYqmaYYBI
         mHi3v/6WMOdfHV2J1YndIGLlhoutdj/CkGwe7SlS8lr85PosfsffARlDECV47d3gBbNR
         5EYNcZL6v3GXPxRcqt3XOfe9TIIJ+9rH0lFGnK38ld4P2rnbOrxp1S7E+FEQ7ksS/Rgv
         QJeVG2ypUnpMygZ5o5WYD+Bx94dxcR39DERvi4YARrybN1kzF16GlO7k4y2f4uLrlDXy
         7QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789145054; x=1789749854;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sNNu1TO589CWD7onDuXMEv1eJ3q2rtxkDJ3Q314d4zo=;
        b=n6X/yauFzZFVdPxF/yJFEVIUa/PjMTOvGIwvzZ1BRpLj6RgM4FDXi0AhdNEiJP2yq6
         7RLDjdtEv/IMz0q8+P8MFvho05C9YcoY9WLgsf+MBCeJxBRp4TtVoqp33pctsDXqBx5W
         /RG2nueaZodQNYDUXZOShxH5mvDbcjfQB7tX+Doh0FWvcVrWPJgg6bM9DWduOo8w1YfV
         8XR9BHwM5ajU6o5PyI0v2SwBiuc16zWNeGqSYwTpT8wCvG85zy/MOoiJiRWGdAXrRzUB
         r0P2IIfDvTUTPeGsSXitJZiWLKx1yes1ZNsjUoGP0mz28dPJsmVMB4PPRhqHilm5KE7o
         C2cw==
X-Gm-Message-State: AFuF++nGkUrgFnNs17rDPICM0xZzfjhfpATnoiE/FJ6G5NAdUXc9Mk8M
	XYd7IgZ+KfwJcHeHHpQIRzYyVqbKH4OKRh2QTElodGM9WKz6/6qKJLrf4l3KQlf9AwXgmfTfAuA
	NWqEX1f+I
X-Gm-Gg: AYBFou2/hdrChKbea5pMdYmcfSM1mGVoA7WmHUgxwJoT4AZ6fgeHJjqR6cdZtF/nFS8
	lylJOLwqPHlOCzeAc9NlNVmNQ9VtYr7jbCrCnLiQNT5fiED90CkF/BQQ3HTIhh1N5AIeNxW9CcE
	Br+MzuOgraZI2lXI7YUoYoO2pM8YOp4T1PfT5CfwUbHd/37LR4q4ItJpxMGppUMHIb/qTZ/o1AV
	mq9az2mbnswyN40N8zBeFW6Ew2f5v6JDlqiGCnc+8zvXXX3oVNz4yYdV4ln2WZj8v0fhDD//9Oz
	esPcd3Ra4ZzvdHJcIiHaEmr5NNO19ZYu8eRTh5u6UVz7p4psGNLksr2dglg2ZJvX/Cy4HPnEPGH
	7A9P0yMbTn+s7/5wqz4Cgddg0JpR+HSNqY5WaIB4A5+N+z0HeuBmypTX2z5fLXG58DpTEWWwi5A
	mlO0ZY+D5P9wv0HKAmIFfRYmDlYLeuOeUWeeZI101g9OUW7KhKbtH8DuuEnk3Zq/pLx7PKGlBs2
	XVCQqgjz5H6teawUAou9E/8xJpuNdANcDoNkAkx
X-Received: by 2002:a17:902:f546:b0:2dd:40cb:a04c with SMTP id d9443c01a7336-2dd40cba291mr28022885ad.19.1789145053219;
        Fri, 11 Sep 2026 09:44:13 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca263fsm14640505ad.6.2026.09.11.09.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:44:12 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:44:02 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH v8 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aqQv0jJdT4xq6VWu@google.com>
References: <20260728221007.2098560-2-dmatlack@google.com>
 <20260910234824.GA366888@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910234824.GA366888@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_094415_034629_13F5EB8D 
X-CRM114-Status: GOOD (  46.26  )
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

On 2026-09-10 06:48 PM, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2026 at 10:09:55PM +0000, David Matlack wrote:
> > Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> > it to participate in the preservation of PCI devices across Live Update.
> > Essentially, this commit enables the PCI core to allocate a struct
> > (struct pci_ser) and preserve it across a Live Update whenever at least
> > one device is preserved.
> 
> I assume pci_ser is the state the PCI core needs to preserve across
> kexec so the new kernel's enumeration doesn't interrupt the device
> operation.  And that whatever state the endpoint drivers need to
> adopt/inherit the device in the new kernel is managed without any help
> from the PCI core?

Yes.

> > Preserving PCI devices across Live Update is built on top of the Live
> > Update Orchestrator's (LUO) support for file preservation. Drivers are
> > expected to expose a file to userspace to represent a single PCI device
> > and support preservation of that file. This is intended primarily to
> > support preservation of PCI devices bound to VFIO drivers.
> 
> Where do drivers expose this file?  sysfs?  I guess it's a file per
> preserved device?  Thinking like a driver writer, I'm expecting a hint
> about how to expose this file (should also be in the file doc somehere
> if it's not already).

There is no requirement about how drivers do this from the PCI core
perspective. For all intents and purposes, the VFIO PCI variant drivers
are the only drivers that are going to be supported in the next 1-2
years. They expose a misc character device for each file.

> 
> > This commit enables drivers to register their liveupdate_file_handler
> > with the PCI core so that the PCI core can do its own tracking and
> > enforcement of which devices are preserved.
> > 
> >   pci_liveupdate_register_flb(driver_file_handler);
> >   pci_liveupdate_unregister_flb(driver_file_handler);
> 
> So a driver calls pci_liveupdate_register_flb() once, then
> pci_liveupdate_preserve() once for each device it wants preserved?

Yes

> > When the first file (with a handler registered with the PCI core) is
> > preserved, the PCI core will be notified to allocate its tracking struct
> > (pci_ser).
> 
> The passive voice here makes the actors a bit obscure.  I guess a
> LIVEUPDATE_SESSION_PRESERVE_FD ioctl on some per-device file kicks
> this off?

Yes. (And I will reduce the passive voice in the next version.)

> I guess the pci_ser allocation is in
> pci_liveupdate_flb_ops.preserve(), i.e., pci_flb_preserve()?

Yes.

> So the PCI core tracker (pci_ser) isn't actually allocated at the time
> of pci_liveupdate_register_flb(); it's allocated on the first
> LIVEUPDATE_SESSION_PRESERVE_FD ioctl for a driver that has called
> pci_liveupdate_register_flb()?

Yes. The first device that gets preserved triggers the allocation of
struct pci_ser. And the last device that gets unpreserved (preservation
cancelled) triggers the freeing of struct pci_ser.

> IIUC the call tree for that ioctl looks something like this:
> 
>   <driver>
>     pci_liveupdate_register_flb
>       liveupdate_register_flb(fh, &pci_liveupdate_flb)
> 
>   luo_session_ioctl
>     op = &luo_session_ioctl_ops[...]
>     op->execute                               # eg luo_session_preserve_fd()
>       luo_session_preserve_fd
>         luo_preserve_file
>           luo_flb_file_preserve
>             luo_flb_file_preserve_one
>               if (outgoing_count == 0)        # only for first FLB device
>                 flb->ops->preserve            # eg pci_flb_preserve()
>                   pci_flb_preserve
>                     ser = kho_alloc_preserve  <-- alloc pci_ser
>                 outgoing.count = 1
>           fh->ops->preserve                   # something not included here
> 
>   pci_liveupdate_preserve
>     pci_liveupdate_preserve_device
>       dev_ser = pci_flb_alloc_dev_ser  <-- alloc per-dev PCI core serialized state
>       dev_ser->bdf = pci_dev_id(dev)
> 
> Seems like kind of an awkward way to allocate pci_ser.  Couldn't it be
> allocated on the first call to pci_liveupdate_register_flb()?  That
> would be a lot easier for driver writers to trace through.

I agree the LUO FLB API is a bit awkward, but this is how it works.

If we allocated it during pci_liveupdate_register_flb() we would then
need to stash it in a global variable to hand-off the LUO later. Despite
the awkwardness of FLBs, it is useful to avoid globals and have LUO
management the lifetime.

> > When the last file is unpreserved (i.e. preservation
> > cancelled) the PCI core will be notified to free struct pci_ser.
> 
> There's a lot going on behind "PCI core will be notified".  I assume
> these refer to the first-time behavior of luo_flb_file_preserve_one()
> and last-time behavior of liveupdate_flb_put_outgoing(), which is
> honestly kind of hard to suss out.
> 
> This series doesn't include a caller of pci_liveupdate_preserve() (or
> pci_liveupdate_register_flb()), so I can't figure out the ordering.
> Obviously pci_liveupdate_register_flb() must be first.

In every version of this patch series I have sent I included a link to
the vfio-pci driver changes that build on top of this, rebased that
series on top of this one, uploaded it to my GitHub, and included a link
in the cover letter. Here is the relevant section from the v8 cover
letter:

. This series was tested in conjunction with v5 of the VFIO PCI driver
. series:
.
.   https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/
.
. The full set of patches used for testing can be found on GitHub.
.
.   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v8-with-vfio


> I first thought pci_liveupdate_preserve() would be called via the
> fh->ops->preserve() in the luo_session_preserve_fd() ioctl path, but
> it's not.  pci_liveupdate_preserve() is intended for the driver to
> call it directly.  But it looks like it has to be called *after* the
> ioctl?  Obviously I'm confused :)

It is called by the driver during it's fh->ops->preserve() callback. In
other words, it is called during the ioctl by the driver.

LUO just knows that a file has been preserved and what preserve()
callback it needs to run to preserve that file. It is has no idea which
files correspond to devices or which devices. The file could be a memfd
for all LUO knows. That's why the driver has to call into the PCI core
via pci_liveupdate_preserve() to let it know that a device is being
preserved, and which.

