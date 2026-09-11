Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9653CC88E4D
	for <kexec@archiver.kernel.org>; Fri, 11 Sep 2026 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=atdgksBYk103iq7faoi4jk9ATkMw9i3avFodOi108iA=; b=D9+twmSzeNAJ8GdNrGIVtQEdO/
	y+SZRcZR/4sALat1Merlk6lKf4ER1Z8NkbfyjF+2cbpK95M/uK/cbF0L3MWxbiOpmBtQOZTEKnf2Z
	NpMrpF/rhUCOGVDlgaxd3c+rhxIARgI1EnnPKwqh0g8TVvp/RJyPzQLjoSgSxV5cM4mrL6Zk6hd+b
	hXbkWlkjG7CZf1dNJ5DWRqctKtobjknzV7QBQOv4VESi/V8Bt5m83z+oMpOh9Gy6bGu3aNGU3oJno
	K4aRMGadRm/EqQnaBP/49ejIX389J7GJEPgwQra5JhWooU7rgCw3TbXl7jLLZF+Tvmz1syPPwtzQz
	mqzbSorQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x54Nx-0000000HFer-2Yxx;
	Fri, 11 Sep 2026 16:45:57 +0000
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x54Nv-0000000HFeA-17Yz
	for kexec@lists.infradead.org;
	Fri, 11 Sep 2026 16:45:56 +0000
Received: by mail-pz2-x0f.google.com with SMTP id d2e1a72fcca58-85469b2e1d5so136715b3a.1
        for <kexec@lists.infradead.org>; Fri, 11 Sep 2026 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789145154; x=1789749954; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=atdgksBYk103iq7faoi4jk9ATkMw9i3avFodOi108iA=;
        b=Y5XDyAm001KytCgIvZNjB7SsnZmN1xqDTy7T67IIYO9H/t68RqjfOQ2EpB1ATPR0bB
         fOPvl3lhv8kEB87XSf1lfmVbERKGi8ENRfwwGuIjYewtyuQNNA0ypbs5cs9fBXjlXDgM
         ynGPpl9Ha12ZZX7KHksoCN4zmC3xYu23csGD3BehGn7WbTLuixt8bEAIba11jdEYAbsa
         34zNkBEq+DNYyse/jlpsSpmfE+f99TXd72CnAxD3qdNYkC/L9poekd/gXj78eTGwcaGi
         scrNJi4fK+EoLuYg1I+ZYvnFV6NQE5Ig6uob6j8klIAkCV40u4gYGP+39/6bpil8VGr5
         o4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789145154; x=1789749954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=atdgksBYk103iq7faoi4jk9ATkMw9i3avFodOi108iA=;
        b=o0ZszEVq/R4W+2dwsBYdA9U7vWYWfrvgpPct4HfkXxBmVzDuCQ+jxGDtLn/1mAvSop
         1aSmKzPvbfNbhiH5+S0/4aSwc5S7s9SI80peepx4YjW8BI0HUihGu6LJ+CL7QzqHreJr
         QU9Su09VbxxX+cJW1cvorX5zJnFs+YWunHpZoZkXmizsB7h8r4GgfOQLmtAsOT4b943d
         4jE36g/exjtzH5ZNDl71YVWnZR1ClBfkKbFn1PU2mgx9mNos1u+xF64xuU2Pt3ScCc4h
         Wp65A2e/j+jeR/KCld2VfvOobU80Lw5pxpCXcPVSV6wSf0H4VOauxjcvvp4mvHw0SaK3
         QaJQ==
X-Gm-Message-State: AFuF++leeDXvuy1eNcX8EyBVUMfCw0gKWio+2GW1sSigYLCQ3lLIOEFg
	Q/QDpQ3bEIB1FPOjV9nDwG/JPoCPuCWX2SRGUp3fe+AF72ZxzMQ2TpDIWxeO92S4tA==
X-Gm-Gg: AYBFou2bSB1sOZAd4XEDgIKrLt1FHihTKNMkQUw6cs28EpPqLBNVRc0llBs+xPg+A1x
	yHuDqZ+dnditH/GNeHszn6nD/S/1JrC1ck6/pHrd5r3dgUyFeKsgsVVE08qeyHLh4JvrDwcT3Ek
	Tr74GIpXM6LrOtMH7weo5MlwlA4TP+HFMzl7hh8xywBSue8OEqwMSelU7vAga8LWJiDSMphh2DI
	NPU6QHoMwgCIxHZaGIkvW6bOpRej2d0jTgUWYqG73mReevOlIhMzv7RWrG0gnU4v5o+7e5wSl6B
	WWH6Q6ZAQm4OHPIoI3QbUJsiBMLL7YsCSkr/LAyUMH+27HVAWtmm08EJBUTxeKemy3LVbk5RsEo
	JBh5rbKwZMRmDMFbOBF7mmIPazsD5f+ON5Y5HLgR1JXWcCAQ4JQ8Qcckrx+YkGMJl0cEKqAuhFx
	EncRGm5T/sIMJx9iqJEBr0G2IDoY60jGq4uMJ+yijdGvgbaMRkQGmzgo5EcQj6X4c2ykZLDfB7J
	JsUDOEeMVwduKJuEVMF1KiDARdv8nE2OFsjZzHK
X-Received: by 2002:a05:6a00:4c9b:b0:857:72ba:ff0e with SMTP id d2e1a72fcca58-86b347ebbe6mr9035236b3a.22.1789145153852;
        Fri, 11 Sep 2026 09:45:53 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b286c3f5asm1472296b3a.12.2026.09.11.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:45:52 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:45:50 +0000
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
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <aqQwPn4XOxC58vU3@google.com>
References: <20260728221007.2098560-4-dmatlack@google.com>
 <20260910234956.GA367108@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910234956.GA367108@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_094555_312829_8D813A4F 
X-CRM114-Status: GOOD (  22.45  )
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

On 2026-09-10 06:49 PM, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2026 at 10:09:57PM +0000, David Matlack wrote:
> > During PCI enumeration, the previous kernel might have passed state about
> > devices that were preserved across kexec. The PCI core needs to fetch
> > this state to identify which devices are "incoming" and require special
> > handling.
> > 
> > Add pci_liveupdate_setup_device() which is called during device setup
> > to fetch the serialized state (struct pci_ser) from the Live Update
> > Orchestrator. The first time this happens, pci_flb_retrieve() will run
> > and convert the array of pci_dev_ser structs into an xarray so that it
> > can be looked up efficiently.
> 
> > + * The PCI core does not enforce any ordering of ``pci_liveupdate_finish()`` and
> > + * ``pci_liveupdate_preserve()``. i.e. A PCI device can be **outgoing**
> > + * (preserved for next kernel) and **incoming** (preserved by previous kernel)
> 
> Thinking about how this will be rendered in the formatted doc, I think
> "i.e." is really part of the sentence, so in U.S. usage this would be:
> 
>   ``pci_liveupdate_preserve()``, i.e., a PCI device can be ...
> 
> I understand British usage generally omits the comma after, so that's
> OK too, but IIUC the first part of the sentence shouldn't be
> terminated with a period, and the "A" shouldn't be capitalized as if
> it's a new sentence.
> 
> Similar issue in "PCI: liveupdate: Document driver binding
> responsibilities" later:
> 
>   bound to the correct driver. i.e. The PCI core does not protect ...

Ack I will fix up the use of "i.e." across the series.

> 
> > +static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
> > +{
> > +	return (unsigned long)domain << 16 | bdf;
> > +}
> 
> Add blank line.
> 
> >  static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> >  {

