Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB78C4451B
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 19:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XwmOrmcqXQWfj6rtFo+8pLNSVXYkj7WYHrCbKkDrWe8=; b=Hy2TKo09Z41YDLI2TFuaJuYJfw
	lVI3IrWZHDPJeDq4IHhjOf+Kcr2b0gCs0whLKkwNOfvHanslY8FhUtmmTVMcNJkZ+ImDXnpsn2x36
	hTlg0yGqUsF6/B3cNPngNPtbWD/BfqqdT1SK3xaiQVsqF2a+9wTnHbaV8UJad4hvOJWvrvchpI3Ur
	ymUEmtKuXHJ+8A577ex3jZJrWExvsPjWhpz6aF0ea4mHlJWWoNlxI0Rhrj79xJSNXMo50Ks4L8wrR
	earutHY7CVVl9fojTNyuuSSgnkjASRm99N0ptdJtkZZ6nTTPE92+7guThm1GZUanovU7JzU/QIKFT
	R5CXI6GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkoSI-000000039SP-41FW;
	Fri, 17 Jul 2026 19:42:42 +0000
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkoSH-000000039Rz-0UAA
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 19:42:42 +0000
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-92e53581361so625823485a.1
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784317360; x=1784922160; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XwmOrmcqXQWfj6rtFo+8pLNSVXYkj7WYHrCbKkDrWe8=;
        b=YA8LHi/tHt7EavKyP09aG4iqUKnGxt+70BxFUOtRz2gIZn5ozfZtUsvPkAh1w0VjcF
         6E7YEqhehnS8s8aaVLl+N32EMpy3HktWjmIv4/DGNCmcYMStrP5jb2k10GXw3bTWOkKk
         AvR12GumnbkyhLIZb/zJH/hoMI2/zuofvdJIt3qn1pGw/l9/HIirg3yuaXHhDOLddyCf
         9Yxxulu9wNwvEPYzIfZLt3EBjGs9k2lmyWNjxoMIYqCN+0Gip3po+uJj1zQ/JE98ini5
         tMDonCjNI1ybctjxhnrbmneaiV5oLLkePmpVKnb6B2OLi07kO5zwlRS25wKHhdIibHpX
         UE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784317360; x=1784922160;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XwmOrmcqXQWfj6rtFo+8pLNSVXYkj7WYHrCbKkDrWe8=;
        b=LsSmNwj6bu6dBm6s1vFOFtlqGq7XSrnYLAi9qDX0q+ldhfQsgQQZNvBg9lcJQa2sv4
         DacXhJRzWytNNZTXoLLgKQXebQGowfwWkhlnhjqF2WotqPfRkbLUWTxHm0dPKPQi8Qpk
         I7T2RC7ZhScgyaG7E7gETMP2TSGkNLM0OquXhAvSBIDUu0IuajOcrmiYNVJTeDf55hcs
         f1sei7MJI7WS80qOPfe2DO647pCqzHcl+WNe3DlfXsQCajUMVrsxdqvYVZnFeFPP5Cdp
         94zgqWAae01w7FFJu4RZ5Zfe6E0ieRArmuFJJ8BPJJS0U/HZlzOi39OEPuyj3gG5yWha
         bZBA==
X-Gm-Message-State: AOJu0YxPrxWx2KecpOkJis8m+07mzDQ7mkUuc8mQsh4DzrJNST8XiNAb
	2ODVHHXdyq0LIZjjF7BhccMkAUFAvIaqlUIXymOeI5+kaA7P9v2x9p10s42IlVt3SsI=
X-Gm-Gg: AfdE7cmxVRnqcg7MIi95qA2EES5G4c0oq5Q9v2JIywq/wZwyp7qhsLQgXcnaDMKSKnx
	WP5Vap1Gy7flBjr8VaqasVGqS1FxafegUJKGu4rCIGerFV34RgpYV3HHo9w6Lm/dqWMtrmKG2Eq
	RhcYGTCOfkNRAkFG3gDbrU8WnSDW6Ig7l1q7ssZkzNP5GRfAokFgHWdHJx1EJ+LLQGx1XuIXTcB
	HQLN28V/GbhtwCAE/Tc4kKNwUnttK/qV38kOT9T0MsB1crv/UADvH/TaHPCCWTT2LycgUBieoil
	Eirz239QUOiX6uP20f6vIV4Uw2AhI+jfj0ZDWS1pIYYkoQ+rp5ye48egOHgqf6eJPZKmPkKIOPl
	EmzRRGB6+4Yz9ZdKOIfptfNbxhRSsjLV78G6kYks2+oJthYUKk/Nakc+qcAtRZJOWwIbl37apXE
	Bme0S2lRWSpuFWhUB4BZ6TOfKWKtkmQQ==
X-Received: by 2002:a05:620a:4691:b0:92e:e125:55bb with SMTP id af79cd13be357-930b3e9c541mr429942685a.4.1784317359852;
        Fri, 17 Jul 2026 12:42:39 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52dd3easm225279585a.3.2026.07.17.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:42:39 -0700 (PDT)
Date: Fri, 17 Jul 2026 19:42:37 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <alqFcmDsFdjzNZQJ@plex>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-2-dmatlack@google.com>
 <178431652443.189683.17611165218179620081.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178431652443.189683.17611165218179620081.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_124241_169485_3C17EFC0 
X-CRM114-Status: GOOD (  22.73  )
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

On 07-17 19:28, Pasha Tatashin wrote:
> On Fri, 10 Jul 2026 21:26:04 +0000, David Matlack <dmatlack@google.com> wrote:
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > new file mode 100644
> > index 000000000000..899758883dd5
> > --- /dev/null
> > +++ b/drivers/pci/liveupdate.c
> > @@ -0,0 +1,155 @@
> > [ ... skip 50 lines ... ]
> > +#include <linux/slab.h>
> > +
> > +/**
> > + * struct pci_flb_outgoing - Outgoing PCI FLB object
> > + * @ser: Pointer to the preserved struct pci_ser.
> > + * @block_set: The KHO block set holding the outgoing devices.
> 
> AFAIK, these should be aligned after column:
> @ser:       Pointer to ...
> @block_set: The KHO block ...
> 
> > [ ... skip 26 lines ... ]
> > +	ser->devices = 0;
> > +
> > +	outgoing->ser = ser;
> > +	kho_block_set_init(&outgoing->block_set, sizeof(struct pci_dev_ser));
> > +
> > +	args->obj = outgoing;
> 
> Nit:
> You could re-write the above:
> 
> args->obj = no_free_ptr(outgoing);
> 
> And declare outgoing like this:
> struct pci_flb_outgoing *outgoing __free(kfree) = kzalloc_obj(*outgoing);
> 
> Also, remove kfree(outgoing) call.
> 
> >
> > diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> > new file mode 100644
> > index 000000000000..de549016807a
> > --- /dev/null
> > +++ b/include/linux/kho/abi/pci.h
> > @@ -0,0 +1,58 @@
> > [ ... skip 30 lines ... ]
> > + * @domain: The device's PCI domain number (segment).
> > + * @bdf: The device's PCI bus, device, and function number.
> > + * @refcount: Reference count used by the PCI core to keep track of whether it
> > + *            is done using a device's struct pci_dev_ser. The value of the
> > + *            refcount is equal to 1 when the struct pci_dev_ser is in use, and
> > + *            0 otherwise.
> 
> I believe descriptions must be aligned.
> 
> > + */
> > +struct pci_dev_ser {
> > +	u32 domain;
> > +	u16 bdf;
> > +	u16 refcount;
> > +} __packed;
> > +
> > +/**
> > + * struct pci_ser - PCI Subsystem Live Update State
> > + *
> > + * This struct tracks state about all devices that are being preserved across
> > + * a Live Update for the next kernel.
> > + *
> > + * @nr_devices: The number of devices that were preserved.
> > + * @devices: Physical address of the first KHO block containing pci_dev_ser.
> 
> I believe descriptions must be aligned.
> 
> Nit: Please order the included headers alphabetically.
> 
> Nit: Please order the included headers alphabetically.

The above was supposed to be right after #include, but b4 had a mind 
of its own.

> 
> -- 
> Pasha Tatashin <pasha.tatashin@soleen.com>

