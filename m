Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18655C982D7
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 23:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RQOshW1Wlhutz0RqxDn5T1g0vEprp2QiXpRdTBiiFYc=; b=h1zvY7A+SN04uEmeX780LGLNhk
	lQSY15D4f4+tFHwTr/zRuLb1zu3WVSya1vGY96HUBJ99PhA0TR+LlkhXvvIXn3eIzdjSxRL89TTkw
	c24J1sX7oXWQJ16o5P+vRfOP+qlHfZiMzo3VmIXzhW0eC1o0VolXdAlfT0rSohwpLmsp/XJSaS3UR
	TezIbLtTt7zVdpsUHuSfWVX4l1S0w9UpAOKZoQpO84UGqOxHbTZh9U/06aIzCs6KG+P2UhPO3+Rby
	tq24rY+4pJ+8j7pbjCq/smA8DZmYBik/ObiWMLe05MEnWDjbaCSkCoUGwyJspkuQNibkjVmrUVFKK
	az08JXSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7LcE-0000000Cn5a-1gYe;
	Thu, 17 Sep 2026 23:34:06 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7LcB-0000000Cn52-48YZ
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 23:34:05 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so706025ad.1
        for <kexec@lists.infradead.org>; Thu, 17 Sep 2026 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789688042; x=1790292842; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RQOshW1Wlhutz0RqxDn5T1g0vEprp2QiXpRdTBiiFYc=;
        b=bPNGcRgchpDg3JnhKDDWcfWju83QBzNy0mHdUTIrYNv57DLIf+3aiGjF19TGk3nP88
         pqw2wMpdp6fwsJKRsxXzQBI8pm9AZbjdMx3XFss0argvVAagHppYGIPkQrjh26S8M7Oq
         wWseeLtwwHlYp98JrJeR1LAyhByWlphi7PZRS2sjo9aUjnih7nyJ2GRaqmJAdC+du/Ao
         CVKXM4YeMtGi+MCvSjzHQDIOnLG3ZU5uKC6qtf6kS+T1PSyRML9fTg9TMQKjTIqsqb+q
         2hWlpfF5az/iwMyHMZnP9mUjwahN65uEFz7CpxxykdwTi+jVcXpsnRc6pTzVqXOdd7/R
         c2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789688042; x=1790292842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQOshW1Wlhutz0RqxDn5T1g0vEprp2QiXpRdTBiiFYc=;
        b=ICrutAdKAznW2+F3hl9WHkWpoOymbxoAEVGRcZiUVfKDfj3QZBZOwI0HqMhdH2xDAm
         8ZVXH0osPudtLejdG3aDjvUBm2ODaJvYMSaQlK8/YGkWKBD9s4vknNJez0WE8a5qnvxi
         WIgRVnVBmP/M8q0iLx74QfhpSe4jKJA3GgBbnuUZ2mQ7OhY71YGgELS6PTeFMOe+7a09
         Od9Q47kNhgI/I+h6hfYzyjiWiVA9F5+8THNh9W5Z5sqxKy7n3qfnRsPciG5M7vt6UmyA
         5wxJLoTDDENAUyn0/vEIeYUV4eBiQmqQeUCMtlifv26MiyXCBacpO9DBkt9E+QfU2PEM
         Mqlw==
X-Gm-Message-State: AFuF++l5DaT7tuKDDsH90TMdjQF/7qjKyoQp9HwjtpQtkQ9qNjzyNcNk
	AAtnmdqW2nYkPeZSusEhZ7fKyUvk/72DUADW1TJRWqFhe2bPyb3EYwm9bSlb5vYlv9ssGaTMIZ8
	NijaTHQ==
X-Gm-Gg: AYBFou14MRPFjXnyZvfTYsK0SynIxxzjST3kyuZ+tHbXjulDGJ+BlegsVfxxLc7Tf2S
	MN0V1Wr1/A0vlTU3uVP9PwnQI3N9jaMW2YYFc383KYlPMiIp4hb/AVyduXcJDzGH4x43A9NHCfC
	xE4dc5UmETMxt0vuzqmyc3ECZpw5oBrJHbeUrsV2stgY3OpUqVd+8PKDmzk56COfFu2X6z0gcTP
	5nVJ8umI9Lb2/SkwE0FRbbjH8N6p4RYqsdCL85kqj3DqKH4bhHuoZGCwCur2zOo6J3NsCJwrwuw
	jxAQ1kWg6pC2XGfUgpFH9RqiGaYqo3OF/xgadtwUzWcu5dS13O/DS6aZI1j9Z55CZgz2IipLnN7
	5O+sHeCjtoOKSQmpIRurtpPz7BZvG2Q3gDWkDp1gnPFz6GE9MTu4sPnxOMSaQEGRIOzVSBABiaS
	RKSSDYPCHRdKQcbh3RrePzjie3sWvG2h7/npRY/0Sw6E/CRNX63MNh6ScGjNMv7GeLctq5YPcw5
	RQWZH3dO5O2qGrBXK7BNEJpIxIMGEx55QsTUTUrn2JwG+My8qk=
X-Received: by 2002:a17:902:c410:b0:2dd:b442:ea48 with SMTP id d9443c01a7336-2ddb442ee33mr2803545ad.19.1789688041146;
        Thu, 17 Sep 2026 16:34:01 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd9e79bb2dsm16491025ad.25.2026.09.17.16.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:34:00 -0700 (PDT)
Date: Thu, 17 Sep 2026 23:33:56 +0000
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
Subject: Re: [PATCH v8 12/12] Documentation: PCI: Add documentation for Live
 Update
Message-ID: <aqx45FqmkRps0wCF@google.com>
References: <20260728221007.2098560-13-dmatlack@google.com>
 <20260917213912.GA1049556@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917213912.GA1049556@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_163404_054224_4CAC7503 
X-CRM114-Status: GOOD (  49.43  )
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

On 2026-09-17 04:39 PM, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2026 at 10:10:06PM +0000, David Matlack wrote:
> > Add documentation files for the PCI subsystem's participation in Live
> > Update.
> > 
> > These documentation files are generated from the kernel-doc comments
> > in the PCI Live Update source code. They describe the File-Lifecycle
> > Bound (FLB) API, the device tracking API, and the specific policies
> 
> Most uses fully hyphenate this: "File-Lifecycle-Bound" data, object,
> etc.

Ack, will fix.

> 
> > applied to preserved devices (such as bus number inheritance and bus
> > mastering preservation).
> > 
> > Reviewed-by: Pranjal Shrivastava <praan@google.com>
> > Signed-off-by: David Matlack <dmatlack@google.com>
> 
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> > ---
> >  Documentation/PCI/index.rst           |  1 +
> >  Documentation/PCI/liveupdate.rst      | 35 +++++++++++++++++++++++++++
> >  Documentation/core-api/liveupdate.rst |  1 +
> >  MAINTAINERS                           |  1 +
> >  4 files changed, 38 insertions(+)
> >  create mode 100644 Documentation/PCI/liveupdate.rst
> > 
> > diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> > index 5d720d2a415e..23fb737ac969 100644
> > --- a/Documentation/PCI/index.rst
> > +++ b/Documentation/PCI/index.rst
> > @@ -20,3 +20,4 @@ PCI Bus Subsystem
> >     controller/index
> >     boot-interrupts
> >     tph
> > +   liveupdate
> > diff --git a/Documentation/PCI/liveupdate.rst b/Documentation/PCI/liveupdate.rst
> > new file mode 100644
> > index 000000000000..96b1d7f5df3a
> > --- /dev/null
> > +++ b/Documentation/PCI/liveupdate.rst
> > @@ -0,0 +1,35 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +===========================
> > +PCI Support for Live Update
> > +===========================
> > +
> > +.. kernel-doc:: drivers/pci/liveupdate.c
> > +   :doc: PCI Live Update
> > +
> > +Driver API
> > +==========
> > +
> > +.. kernel-doc:: drivers/pci/liveupdate.c
> > +   :export:
> > +
> > +Internal API
> > +============
> > +
> > +.. kernel-doc:: drivers/pci/liveupdate.c
> > +   :internal:
> > +
> > +Live Update ABI
> > +===============
> > +
> > +.. kernel-doc:: include/linux/kho/abi/pci.h
> > +   :doc: PCI File-Lifecycle Bound (FLB) Live Update ABI
> 
> Ditto (and in include/linux/kho/abi/pci.h itself).
> 
> Trying to understand the FLB concept, I found
> kernel/liveupdate/luo_flb.c.  I know that's already merged so this
> isn't really the place to ask about it.  But FWIW here are some
> questions from this naive reader:
> 
>    File-Lifecycle-Bound (FLB) objects provide a mechanism for managing
>    global state that is shared across multiple live-updatable files.
>    The lifecycle of this shared state is tied to the preservation of
>    the files that depend on it.
> 
> I understand "global state", but I don't know whether "global" is
> relevant here.
> 
> I don't know what "shared across live-updatable files" means.  Is the
> sharing a fundamental aspect or just a typical use case reflecting the
> level the data is for (e.g., bus vs device)?

LUO is fundamentally a system for preserving files across a kexec. FLB
solves 2 related but independent problems that arise when trying to
preserve files:

 1. For certain types of files, there is some data that needs to be
 preserved that is not necessarily tied to one specific file. Instead it
 is shared across multiple files. FLB gives you a way to allocate and
 preserve such shared data. The association between FLB and file
 handlers tells LUO which types of files require which FLBs to be
 allocated.

 2. For certain types of files, the next kernel needs information about
 preserved state before userspace has come up and is ready to restore
 the preserved files. FLB solves this by existing separate from the
 preserved files and thus can be fetched during early boot.

For the PCI core we use FLB to solve both these problems.

 1. The files userspace is preserving are VFIO device files that
 correspond with endpoint PCI devices. Bridges can be shared across
 multiple endpoints so the PCI FLB gives us a way to track those
 independent of the VFIO endpoint state that is inside the file.

 2. The PCI core needs to know during enumeration which devices were
 preserved by the previous kernel so that it can set up those devices
 differently, e.g., adopt ACS controls instead of programming new ones.
 The PCI FLB contains the full list of preserved devices, making this
 possible.

> I'm imagining a *kernel* being "live-updated", i.e., a kernel being
> updated while things around it (devices, some user-space things) stay
> alive, so I guess "live-updatable files" would be preserved across a
> kexec?  I don't think of devices as being "live-updated" since they
> themselves aren't being updated; in fact, the whole point is that they
> *aren't* updated.

Yeah I think live-updatable is not an accurate way to describe these
files. I would say "preserved files" instead.

> Do these FLB objects appear in a filesystem?  Or are they merely blobs
> of data that are preserved across kexec?  I suppose there must be a
> mechanism for the new kernel to identify and request one of the
> several FLB objects saved by the pre-kexec kernel?

They are not exposed anywhere in the filesystem. They are blobs of data
(e.g. struct pci_ser) that the kernel hands off to the next kernel
across the kexec. To request a specific incoming FLB (i.e., FLB passed
by the previous kernel) liveupdate_flb_get_incoming(). Strings are used
to uniquely identify an FLB. PCI_LUO_FLB_COMPATIBLE ("pci") is the
string used for the PCI core's FLB.

> What does "lifecycle is tied to preservation of files" mean?  I
> expected to learn about the beginning and end of the object lifetime.

Specifically it means:

 - Just before the first file goes through liveupdate_file_ops::preserve(),
   the outgoing FLB is allocated (liveupdate_flb_ops::preserve()).

 - Just after the last file goes through liveupdate_file_ops::unpreserve(),
   the outgoing FLB is freed (liveupdate_flb_ops::unpreserve()).

 - Just after the last file goes through liveupdate_file_ops::finish(),
   the incoming FLB is freed (liveupdate_flb_ops::finish()).

>    An FLB represents a global resource, such as the IOMMU core state,
>    that is required by multiple file descriptors (e.g., all VFIO fds).
> 
> I have the impression that the important thing about FLB is the
> lifetime of some data, e.g., something that lasts longer than the
> kernel that produced it.

I think that is fair way to think about it.

>    The preservation of the FLB's state is triggered when the *first*
>    file depending on it is preserved. The cleanup of this state
>    (unpreserve or finish) is triggered when the *last* file depending
>    on it is unpreserved or finished.
> 
> Maybe this means .unpreserve() (in pre-kexec kernel) or .finish() (in
> new post-kexec kernel) is the end of an FLB object lifetime?

Hopefully my comment about explains this more clearly.

> > +.. kernel-doc:: include/linux/kho/abi/pci.h
> > +   :internal:
> > +
> > +See Also
> > +========
> > +
> > + * :doc:`/core-api/liveupdate`
> > + * :doc:`/core-api/kho/index`
> > diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
> > index b3c689e633c1..2bce2644eba2 100644
> > --- a/Documentation/core-api/liveupdate.rst
> > +++ b/Documentation/core-api/liveupdate.rst
> > @@ -74,3 +74,4 @@ See Also
> >  
> >  - :doc:`Live Update uAPI </userspace-api/liveupdate>`
> >  - :doc:`/core-api/kho/index`
> > +- :doc:`PCI </PCI/liveupdate>`
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 08a724b860dc..347c435ca404 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20833,6 +20833,7 @@ L:	kexec@lists.infradead.org
> >  L:	linux-pci@vger.kernel.org
> >  S:	Maintained
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
> > +F:	Documentation/PCI/liveupdate.rst
> >  F:	drivers/pci/liveupdate.c
> >  F:	drivers/pci/liveupdate.h
> >  F:	include/linux/kho/abi/pci.h
> > -- 
> > 2.55.0.487.gaf234c4eb3-goog
> > 
> 

