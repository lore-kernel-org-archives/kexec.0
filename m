Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9531DC4452B
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 20:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bht7YFPW2nLJyME+XdIc/6Xfh+QtNInRSN0Il3SMOm4=; b=YwGAt8K9FhWvP8kxWpZMX6uYIb
	zv3Lceo/828IK7Wptye2PX6CgQvIAkeiBCEjV+4rku/5Txwn3oSlXf0CJbC6LepK1MvidJa0+dJ3P
	RgKiKfe3xO6mD+6k4Ysz2V+MAHUuuJdEz2o4YcenNe4PMpFKtlDUc75E/dtsKDyf0OQrIn/K/Itrs
	Bs7H6WcfijZtMAwjOm4uCb1WO5gBz/VbQr5n7Q4CJ2hqQcIo12h4QPC6O/QRf4G10jmcWIivgGI4w
	Px/eMWCY47Tug58CKVbpuufWIm37pi8uQ7n6G7t9kIa0U43n3SrVwx5EosV9/qOo+4XbPdxg5/v7B
	cAm12F1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmH3J-0000000ANWh-34lW;
	Tue, 21 Jul 2026 20:26:57 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmH3H-0000000ANVr-2qyU
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 20:26:56 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2cace91f112so122343955ad.0
        for <kexec@lists.infradead.org>; Tue, 21 Jul 2026 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784665615; x=1785270415; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bht7YFPW2nLJyME+XdIc/6Xfh+QtNInRSN0Il3SMOm4=;
        b=E9P5xsu9whx1wgRir50jkGCXJ9tCYNz2OdfGIjnCVM33P9I+AKq7orWES4EwU5/ZCP
         JOcBiAqo/jMSUS/XYdTBKUkpFssphbxv6dNkGhlZQEZzZLVycUgX5ELNivzLU108mqd2
         i4azXB3QjQ4uku8hfMjiG76avpaeTXsiUNFX/krlp1qvBVcdCJW3psIxI6V8LMPyHjZ8
         Mg+e7XELsOzbIbw6NSPOwy3K8OROpCe6r939EU7+IpKfFfkrcDzIEkK2NJa52PLEgDpx
         EfC9JbKCQtU0bZ82kuldsXo1qsuWl/kekxCc5HuG6Rt+VM+lTaF8Ia/oYjz2YQ20LzGx
         ELiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784665615; x=1785270415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bht7YFPW2nLJyME+XdIc/6Xfh+QtNInRSN0Il3SMOm4=;
        b=OfAxRGBJEG+easnPFK2XIGVjI8bx/2wHJxgECg7c6yZWk/4QGtC8cZyRxohqc10Y+D
         419WjeWlxIIB8XyYVLF9EDmx+IPypDkqu/qO2jErT4sf3I7zS5PruqV4U5R6lr9hpq/X
         IToi/la4aSGYpUpBQoNxfbbu1AuV2+BBF6/DuQaQIuZE9yMzNN1TaJFFzcjxh3RfQRac
         cS+u0kdDZG0IEeN33RcRVLYt8AHxDC8SijqpHJGhrBl4xjT8qFQttGaGD4uYVMUNG567
         lbUv98YoW44Ck3Mepx7+RC8sFhREc58Ii/q7gSUZMtuFRRMry63DAttvxHOwO/snj1nB
         tjcQ==
X-Gm-Message-State: AOJu0YyU0E2Utsj0l5XlI6+oRPb72eSnAT6qd0VwOjkoClESW2qV3ZLP
	8+GXi0I7NDnzL8f/Gf0W5+c5ohxmx4WXU2ToIq1bTHxQfuTInUhclbo3u8LUWd8tcQ==
X-Gm-Gg: AR+sD13BrZWbFsPig7tcNlyiZvBLFYqX/+VsdUdiHY2/4zwnvT8oqvjJATDMFSm+Uan
	Oj4Ynxa71kDNfUyz9byWPEYw4b4xNaS8Z0G535m7gjGF0Vd3e0vRApD0hAoWpCehxOzm5E2aQl6
	ZOc4j9BEndygfJuo6QLoX+wiV+rHE0piBCxfS1J80vlIRHm1PVqj6CgPSjBg3Etq3+XBSUQkvNn
	QF8+ZbVi+i1rBPteCxW0xRje1oY7KueFOyM68n1mOKIahjtPT9HDfobofuioGQ1WtGppyuPzx4L
	Ltyl8dtq6YrO2mcdFjLbhnIlNeM2I66JkankprH8c8HHAvDuFSp/veqFMUNplVQ9X7ZsRjAaSdr
	E6qbSNbpSyucQOfwvdHobegSujFZVcetxdUHUrjPSArCyQPoZsPnp+0Z5v924sc46ybCbSPPTNp
	yowriRA9j5JCOkiGsSuh0pCsrxQmxacfggqhW90gbd
X-Received: by 2002:a17:903:4b43:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2cf3481d1b6mr200020005ad.2.1784665614286;
        Tue, 21 Jul 2026 13:26:54 -0700 (PDT)
Received: from google.com (79.217.168.34.bc.googleusercontent.com. [34.168.217.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efde5cfsm2738235ad.31.2026.07.21.13.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:26:53 -0700 (PDT)
Date: Tue, 21 Jul 2026 20:26:50 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
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
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
Message-ID: <al_WCh-G-H1kDU1h@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-10-dmatlack@google.com>
 <178433098576.189683.2364970585754668266.b4-review@b4>
 <CALzav=eZYfYYKAGEzk4TsGFLp1TPb2iFePNmqGsjX4jEZNJ9XA@mail.gmail.com>
 <178465783370.437204.17382376546970842455.b4-reply@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178465783370.437204.17382376546970842455.b4-reply@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_132655_724548_1F7BF915 
X-CRM114-Status: GOOD (  28.59  )
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

On 2026-07-21 06:17 PM, Pasha Tatashin wrote:
> On 2026-07-20 16:19:00-07:00, David Matlack wrote:
> > On Fri, Jul 17, 2026 at 4:29 PM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > 
> > > On Fri, 10 Jul 2026 21:26:12 +0000, David Matlack <dmatlack@google.com> wrote:
> > >
> > > unsigned int    ari_enabled:1;
> > >
> > > Sashiko asks a valid question, what protects other bits in this word
> > > during modication?  At a very list a comment is needed.
> > 
> > This was my reply to Sashiko, not sure if you saw it:
> > 
> > .  pci_liveupdate_configure_ari() is called from pci_configure_ari()
> > .  which also sets dev->ari_enabled=1 and is pre-existing code.
> > .
> > .  If writing to dev->ari_enabled in this path is indeed unsafe then that
> > .  is a pre-existing bug.
> > 
> > I figured that a comment wouldn't be needed for continuing an
> > established precedent (it's ok to write to ari_enabled during this
> > path).
> 
> Overall, I agree that if there is a bug it is pre-existing. But we 
> should also take opportunities to improve existing code and make it 
> safer. In my opinion, Sashiko raises a valid concern that is not 
> obvious, since there is no comment explaining the access of non-atomic 
> bitfields in the header before the struct pci_dev definition.
> 
> In this path, it is safe because we run inside pci_device_add(), where 
> dev is brand new and has not yet been added to the public devices list.
> 
> However, it would be great to:
> 
> 1. Review the access patterns to ensure there are no concurrent writers 
>    on any other paths.
> 2. Add a brief comment in this patch right before setting ari:
> /* Safe to write without locking; device is not yet publicly visible */

Ack, will do this one in v8.

> 
> or:
> 
> 3. Create a new separate patch that adds a comment before the struct 
> pci_dev definition explaining the bitfield access pattern, and how 
> concurrent writes are avoided.

