Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEEFCD98ED
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 21:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVgu7F5iihyCKu/G4stgDOvBtLDNemb1ZVF8TxvBGyg=; b=AaF5emfvdnsAwBHI1oUIyCRUhj
	5X9hAP3ttN1p5WGvntL83Y7Ue0Bk7ykijbHIoieJGi5dBkK4SSpA8oCfD7FI85WPDRI13oVm8B1fh
	KSuIaaJwPo0eo3OpzGjKCMOjaWDMATkp5Fv9pTybxwl7a3zMpUYjfdBbRAgZRVbaPD8+DgtpNGZzd
	p6Mz4AkiCS3eZGDrVda8WhO7CzL+DEW+Nf49HaMLC9BvnUcEZGIdsMlMBDReB8wUDCwpFhXqeQByq
	3k2KG/jhoMhwpbRK2+GFl0kPtfDZEhyrZMEglrsFVCHwiQFBfGJy39u3WzSVYXLA02GVBuOodhqp0
	IhwgQvtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZy3Z-00000000MoA-2W92;
	Wed, 17 Jun 2026 21:44:21 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZy3X-00000000Mnn-0UDX
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 21:44:20 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-9158fbaa4bbso33307885a.1
        for <kexec@lists.infradead.org>; Wed, 17 Jun 2026 14:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781732657; x=1782337457; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVgu7F5iihyCKu/G4stgDOvBtLDNemb1ZVF8TxvBGyg=;
        b=VWqaWiE2sKAhtjRCvkDue2QsvhCmyPQBoS2S3HhmAxPcZDAe8z2zlXHvf+xiHucPe/
         4CkmzU9Dc/D8taGKRvmBeDzzMnVDWDzohQ4027haq6H5b5kqYJ21ociShExEmStBwiH7
         K4G6DfJfY8ABRn28H/PkS+MN+G56naFVqkVyYyLDbWhYWx+h5AYhaxEdq2Mw6lRconPo
         VFrZ8VsmD0NLiSyhrDQ2W/Fl5SEaamaaCEKhf9wnGVxPR0B9gzEAwWlhIh8jPZdIQK8Y
         HppVnbzxAemSLKZQ89uMdPr/vQTRIwFyutBPgtuKhN6z9YXH/yO6dsEH7AI3N4FMrCrA
         yItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781732657; x=1782337457;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mVgu7F5iihyCKu/G4stgDOvBtLDNemb1ZVF8TxvBGyg=;
        b=QctqP9rqNtIXuQyFg6PltTdcmUlDXo5ntEtDydpFOy4tRMa/VuSz2Wzj9X8NYtPC2a
         5/4NnF3rEG5Wt0aeIVa27fkLDVSDWDG1m4OEBVuWlvxPTqPdJ9p+Cwvu6PiXcisoKZ6z
         jP3iJBdWBgEbbgLx+XpjOX5yQwkdibB2qutrrViaeCwFw9hiZuE4g5idngZCsatmLakJ
         VfvYz+AUZqIhFcp0lqjyGY/1cFUWXbKq0bcOrcFXO4GxpHvDCaQjNGn74Z1CuGayeuEZ
         x8hacPgV3WVTlfZGyqskuqtbXXB0MSQOG1Kr+8x1U+uDkBE6McVJouJ5ZES7E214BE32
         16wA==
X-Forwarded-Encrypted: i=1; AFNElJ/oQ2Z9S+I3jjZiB/peL9zjgXnyAJnrbFYu7fVSg7HaQnZLpRtD6KeQz+AsWAbYGrIyI2v39w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwSSe/59r8lYexLaPcCQtlgNnAb87ArHnjXZF3UaxGHX2CGp3Bl
	i9Q9pBqvscr9ZzWbePckC5ncYc4p3g7sj11dB9AjVb2OM5lb7vBYA3trKo+9aZ+cBZg=
X-Gm-Gg: Acq92OGDXDCiMlDd0f0cNtcHkF0LFxlmFX9JTeGq0dZ2u4IiitI8h7/a+iCmsHU/jp7
	mDaM+G7vsawnITOXzHlzFPRVQDnSc13wkfIc+wW3Upg3pQm02jaZnM8JyNgXs4Otf+n60P7j4ym
	qaUq/3Af5HtSFP1SPqDJaNO91M+bXvjLwfRagZNnaYuUhUzwLJxEYSQdq46UdwnseGHHx8WFtIh
	k80qxEDGJbfwhwYqvmcC49C9qnfYuPHBtFysAggDzqQrpblceg2h0mFrjv81k/NTzQWbRFQB5aB
	sYt+gcHne0xiZFndtv9gGEh9R/vIfjiZbWKgSHsdaU9qbfCHJbN88Y4REiPSanWSRRWxAWhCgcI
	CVCOIvtxAa+QrjBxTyhFr1hxoeacxC85uI/Lnudkqo9nf7jPwjE+OI4LRVpKVKej8cLeg4bOy9a
	holTOWIrzm/oXroxVNbJv61ExzP0NgptC9efgTbO8jJdIp0kgr/7oeZdbnnOwY
X-Received: by 2002:a05:620a:4710:b0:915:7c1a:1387 with SMTP id af79cd13be357-91d8b4b82d3mr974163985a.38.1781732657342;
        Wed, 17 Jun 2026 14:44:17 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f3c324sm1871381085a.21.2026.06.17.14.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 14:44:16 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the
 PCI core
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ajB7EA4tAKqj5XV0@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
 <178124130274.908199.14827357870284807134.b4-review@b4>
 <ajB7EA4tAKqj5XV0@google.com>
Date: Wed, 17 Jun 2026 21:44:14 +0000
Message-Id: <178173265446.1266136.13359060486033428626.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2540;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=QZkluUiynr9FNYxq4HTOycC4NrsYyGj2uEdu6jqluEM=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqMxUvPSD7ryLWoiq0RP6QzEW7bPRTwRVRK1iGh
 4D9ux7x6z6JAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCajMVLwAKCRC7dyhM23N6
 3nBkEACIr+qaiFDURkLLKmlla4feY3MYdO7YczubseLaSQZvERTE2vIj19GVL+rKpHxOQTGKjdZ
 6x4uuQzZ1P/ZhxH0s02iqkxWZaYln8HlySKfJ/yRRSj4Md9jM+ui4VxXSMdaEPmxaHTn5xpasmr
 08wdcAPQu9z55T2Bx3Qokb6IF73WyIUIQROgK8q2E54RVuu1OnA14jbvCxyUwY6TTg5MiPHoqAo
 XeBjnZRpboyLxod5YlWDalguHWvvUODhNr3JCmQakJh0xzlC4m1tKgaU+DqgjnSco1PJQMMEgLU
 m5HRtfrrVci4ONbgHzaLQ7y6Rnw/X4gaS+3Ygz+jwYxxFHPGYbUCba/8f1sbRMPknCZhXjjNAS9
 5qRcK97cF6j8aqGrVz+VzKp+z8E6XlWdZXI7Obrcq8C3iCZbvkrNvPcrIAlpx/1x9QmosSMGrpd
 Em28VGCwMHhk0wMDJjvRQ4a0B7+Royl5PzbuLa2m2gxPfLDrjrxkyvHkPydL8A9Tzkp97XCgZQ8
 oMpmW3oXUmYg7Dep1lgEOdQgWiaW57ZS+s83v+pA87Zizu9zGVXVCSZD37h/nVmk5clhlqiH0po
 lcn9njTOGIFROCuQWZBh8jWGH2hMvIdPgL4UpOd7oEauXLnkDvjTcBR29cu6ThJH5cUTDeLIrFy
 VqYf2itiyoZMCqQ==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_144419_200466_6FB3391B 
X-CRM114-Status: GOOD (  23.48  )
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

On 2026-06-15 22:22:08+00:00, David Matlack wrote:
> On 2026-06-12 05:15 AM, Pasha Tatashin wrote:
> 
> > On Fri, 22 May 2026 20:23:59 +0000, David Matlack <dmatlack@google.com> wrote:
> 
> 
> 
> > > + * PCI device preservation across Live Update is built on top of the Live Update
> > 
> > I prefer to just use acronyms FLB, and LUO, but have links to the actual 
> > documentations about them.
> > 
> > So, something like this:
> > 
> >   * :ref:`FLB <flb>` Data
> >   * =====================
> >   *
> >   * PCI device preservation across Live Update is built on top of the
> >   * :ref:`LUO <luo>` support for file preservation across kexec. Drivers
> > 
> > And also add _luo and _flb to Documentation/core-api/liveupdate.rst
> > 
> > .. _luo:
> > 
> >  ========================
> >  Live Update Orchestrator
> >  ========================
> > 
> > .. _flb:
> 
> Will do.
> 
> I guess I will need to add another patch to add the link references to
> liveupdate.rst?

Yes, it can be a separate patch, but adding to this patch is also, OK.

> >  LUO File Lifecycle Bound Global Data
> >  ====================================
> > 
> > 
> > Nit, may be:
> 
> Did you have a suggestion here that got lost?

Yeah, I meant:
#define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt

> 
> > Please sort alphabetically.
> 
> Will do.
> 
> > I think, we want to use kho_block [1] (it is in liveupdate/next branch) 
> > to allow number of supported devices to be dynamic.
> > 
> > To support this, we would redefine the ABI and tracking structures like 
> > so:
> > 
> > /* include/linux/kho/abi/pci.h */
> > struct pci_ser {
> > 	u64 devices;      /* Phys address of the first block header of kho_block_set */
> > 	u64 nr_devices;   /* Total count of active preserved devices */
> > } __packed;
> > 
> > /* drivers/pci/liveupdate.c */
> > struct pci_flb_outgoing {
> > 	struct pci_ser *ser;            /* Points to the FDT/KHO-allocated ABI struct */
> > 	struct kho_block_set block_set;  /* Controls the active blocks on the fly */
> > };
> > 
> > In  __pci_liveupdate_preserve_device() , we would search for 
> > and reuse any inactive  pci_dev_ser  slot first, and only call 
> > kho_block_set_grow() to expand if no inactive slots are available.
> > 
> > In pci_liveupdate_unpreserve_device(), we would simply 
> > mark the  pci_dev_ser as inactive.
> 
> Makes sense at a high level. I'll work on switching kho_block for v7 and
> get back to you if I hit any issues.



