Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F19C4452B
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 21:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/L09p9hjhfnJuq67NKuGgM+hS4Xq9h8jqqROmbVMupo=; b=DCKFn7urfAZs68akXla1pWR4wN
	JNTTIOJ12HwT+TQ3q2bYITi8C91+vlVc7+Bs3H8+L6DdwQafIG+p/NgvSEs0fCJKsFIxMQSX+ZwL6
	13ZIEMt/fpa1+dPijnPuZCzozs6NI1uaF0lelZlViswaeYfIxaCrhMnbqKXWvGEoeB8wwSzhr1WuW
	3k5rlSedgevSgvhaNxQdCeF5MyD+6pHaQoQpsWOS9PVHJu0HKAojIl8nfrqmxuapUNpj0uOQah9J8
	c83AL3von5bQJBmWY2IdTSI+RlVSyXg+PuYOKz/8ZO/VzvjlUTJ9FHc/DeeLnjoBnpVXJFtvvTckz
	aCkkG/rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmI7t-0000000ASbU-1bw3;
	Tue, 21 Jul 2026 21:35:45 +0000
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmI7r-0000000ASaC-1Ycb
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 21:35:44 +0000
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-92e53581361so920013885a.1
        for <kexec@lists.infradead.org>; Tue, 21 Jul 2026 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784669742; x=1785274542; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/L09p9hjhfnJuq67NKuGgM+hS4Xq9h8jqqROmbVMupo=;
        b=RYjgIle1G1HfjCmGNgyRwV4cAhax9zHcVT9igtkCmlACEUMWJg0guXWz7YD1D24AtT
         F4KGefuBzAn5uvhOLZ06lWO/8BGMfJNmHtXrYmQXoznB22z/lNhiThNbLkwk1MF6YqLv
         NXoDpNXuWh3eGvsvXVusL9fBIJBB8uDKSjcg44R+/Ngk6OfXwlZlwim81CI1nRN9xKlR
         Qo0QRMDysW01zo/wZWD0Mbyb8wE858bgfYUzJVnpQeuafdLr6I+ihLALEsC1sxQsEFtt
         51bluTUT53cojOemnOVANwOFBsc53CIECEeXfWey5sRxF/hvRw8Akg79q/x4l1z9BBfU
         vqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784669742; x=1785274542;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/L09p9hjhfnJuq67NKuGgM+hS4Xq9h8jqqROmbVMupo=;
        b=jVBK6lfu++uwSjvAEDZGA6+485D32bxYqXoWzDZiEkxETpARFBpMDg9vEofCFLx8lN
         wfsx3RBmOXN101yID+qO3JpS62nHucZM6ZhFqov3L7C4mKKXYedElU4c/PNsnSTVcX69
         Mo4x/eB+Z0Go55YaaQueEbKps77e3jgTWP8IT+sJNpjBqGI0rZk0zdThBE0NkSx2kAVq
         F79sQZxlFI+ayxDGfviJE5ED24UHW7RLLpjYGwnndZYyIOBTZs7mskLeQKrT1Yre9c4r
         OWWUJ2IpIs/066cIcJS0FZpQVQw0Qvcda6AwBAXnAf/67QkfAaxry1TMfombpw6IjGNr
         KPEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqoI1IDioebP0OzwEcJxYRHXqJgKyfNrnAtLzdqJQRTqe5kMEhXEiPGolQe2WwmPFVYXJFuxg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzjLDWsOexqD4PEYHZ3rgZCjgn+3aiKYNrjixEOEe3P1tzP+plR
	7qgelUyHzXqJGDNkEzOXLUGbx2hxMSvuVwlev3/Q3VhLCzPz5fCjmcwOIP0wD07f0gA=
X-Gm-Gg: AfdE7clD2zw4HR8aWWikyR/h8Q6cQ0EFsRUTM1DnEj5X/I1eAFbHI3MGbRAI9TJJCyJ
	QP4KM90MOn9OBmcq6Dg/jIPwTHJZCvm0SowxU9RXzP4e9WXKfyJ6q2XEOqSFHRDQSOgZUXJFrNr
	DBitbJ9xrWErX6DirZEalZSxdH2BYIoLHKzmKSdlzzn8WvLu/VVJhkesMi9NB8t/TPvJcEOwt5R
	hAa1BWWmBO+5sW633rn5EBdoQ6y36E4uKBTrn3AlVVchmj/vjeMCWcYxI1lYzUghYRlv2o+TDph
	P1kLg+ynyNf4NBCvt5z7HtzGpX9y36+Lx1thxEcc7EiYnBWC/vZ4yIDGws6bzNlFy/V6+ZUV5Q2
	P8yME6mIPWENE9B3zMd4brHzuPpkkN0FgYESdyQj2/ccAWDpsoGJ6BIdOMAPArgGsg3GX+z6L6U
	isENwlsHcLJrWcNiwxV5thh3oPlcT7L/eoQCAhSAg=
X-Received: by 2002:a05:620a:2b82:b0:92e:fc42:2c1d with SMTP id af79cd13be357-930b3ec9e69mr1935028585a.20.1784669741912;
        Tue, 21 Jul 2026 14:35:41 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b54773fbsm1200457785a.39.2026.07.21.14.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 14:35:40 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
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
In-Reply-To: <al_VrpvPE-RLCF5X@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4>
 <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
 <178458744511.332171.13770778781241262180.b4-reply@b4>
 <CALzav=fjTOnyg2++GFFe5B17rHqNCWW=afjsD0A=EEjycPW7Sg@mail.gmail.com>
 <178465652971.412167.17838319728990505256.b4-reply@b4>
 <al_VrpvPE-RLCF5X@google.com>
Date: Tue, 21 Jul 2026 21:35:38 +0000
Message-Id: <178466973829.1257886.900641450757526076.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3133;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=n9GCy6FourVHMw42pszPZ/kxYjrtx0ToMvEFR8X96Jo=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqX+YrXoUG+/twOz13pZ+ErnnGUFKhvMcK9TUHm
 5U4aFzfcD+JAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCal/mKwAKCRC7dyhM23N6
 3h7TD/4mAowZzUytWw/GBQF/1nJIoe+y01Mpv8f7eHQexJ7iATsttb+FbfYLpomH6zguTcBsIoW
 91QFuHteD+mVmq6lMNDVxqr8K693bfjCPLXN5Yscg9ZF7cQ25fLLtxm5K8f1iQ9lYd9lRKq032E
 bx9u4OycAUnkuka7y3ETFu9ILaNao+94NQxkZXKetmUfOj2Zz1N2sxm7lbEMnLru1NFm9ZcyGp9
 1ytJ+H9MG3aafd5hmEB2IAZjS2BBgeB5SFG6rsJgcyd8OWKjWfsxvsY6PnvPeI2F+dEF2sM5wOX
 FQehPH+uHOqKk+AGUFUaPR8riMnzcbRju3SGFc3oJfz0BwGEokGw+DydfGI1bdP7qQd6aNL/2IJ
 /oKDcb131mYKVvU/sNoEjbbEHAO1W0Ikr70/GJ+LK7bki9dd/f2BcCrB9t2AuIcJfDDJxViqOEG
 b87uMr6gD7FDN0UHaiiFE22QN/rS3oA32+ABhGQumkv0QRBKnkS6s1wMo+56rTyxpa7ifn5oYRC
 B/DIkST6h/nSQazKrWUGhUoecK0s/AZgViO/YvZCJSYUqPh9noqC7hBiYGoXcmGAKZV0YjRqJpz
 GQ/C03e3p+3cug90wTpUluvrVrvZ1jal6JH6wzs0MBiaxFP24X1zUtHUitFs3Qj8g0M/aSUW7Hd
 g5Jx4S1u6NpTsjA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_143543_432615_13DBC2C4 
X-CRM114-Status: GOOD (  27.43  )
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

On 2026-07-21 20:25:18+00:00, David Matlack wrote:
> On 2026-07-21 05:55 PM, Pasha Tatashin wrote:
> 
> > On 2026-07-20 16:07:47-07:00, David Matlack wrote:
> > 
> > From a design perspective, liveupdate_flb_get/put_incoming() is a 
> > logical read-lock/unlock pair on the FLB data. We use a refcount for 
> > optimization and sharing, but holding a get over a long asynchronous gap 
> > (from boot-time device setup to driver probe) is essentially holding an 
> > unbound lock.
> > 
> > Unbound locks make it difficult to trace refcount leaks or debug 
> > lifecycle issues.
> 
> It's very standard for refcounts to be held for a long time, e.g. file
> refcounts and device refcounts. LUO FLBs themselves already have
> long-lived refcounts taken by each file that depends on themm, which
> aren't released until that file handler's finish callback runs. The PCI
> core is just doing the same thing.

That is right, but that refcount is tracked internally by LUO and 
follows the design of File-Lifecycle-Bound objects, not the lifecycle of 
the FLB's users.

It really seems backward to me to force FLB objects to have a different 
lifecycle. Let's start with a concise lifecycle without setting a 
precedent where clients of FLB try to control the duration for which 
objects exist.

> 
> > Can we do a fast-path check first?
> > 
> > static struct pci_flb_incoming *pci_liveupdate_get_incoming(struct pci_dev *dev)
> > {
> > 	struct pci_flb_incoming *incoming;
> > 
> > 	/* Fast-path to avoid unnecessary FLB querying */
> > 	if (!dev->liveupdate.incoming)
> > 		return NULL;
> > 
> > 	incoming = pci_liveupdate_flb_get_incoming();
> > 	if (!incoming)
> > 		return NULL;
> > 
> > 	/* Check again, now that FLB is acquired */
> > 	if (dev->liveupdate.incoming)
> > 		return incoming;
> > 
> > 	pci_liveupdate_flb_put_incoming();
> > 	return NULL;
> > }
> > 
> > This seems to gives us the best of both worlds: robust refcount hygiene 
> > and a sane fast path.
> > 
> > What do you think?
> 
> It still seems like an overall worse approach to me.
> 
>  * From a performance perspective, the PCI core would still have to
>    acquire the FLB mutex twice every time it needs to use the device's
>    serialized state (once to acquire a new reference and once to release
>    it).

I suspect, acquiring/releasing the FLB mutex in this case is trivial and 
won't be noticeable in any  real-world scenario.

> 
>  * From a locking perspective, the refcount doesn't actually protect
>    against the device itself going through finish. So we still need the
>    pci_liveupdate.rwsem.
> 
>  * From a hygiene perspective, each reference is held for less time yes,
>    but there will more places in the code that need to acquire and
>    release a refcount.  That is more room for bugs to leak a refcount.
>    So I'm not sure taking more small refcounts is an improvement.

IMO, short-scoped acquire/release helpers around actual usage are much 
easier to audit than holding a refcount open across an arbitrary, 
asynchronous gap waiting for driver probe.


