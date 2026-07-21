Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2409C4452B
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ea/F6w9Zt+Er+ldXlrQTi7dDqHaImBI68nyXrbPqNKM=; b=X4T6oPmquCIj/369HBHvF1gdPu
	DLYsRp0ljlFA0W3Dt/jnzjfP+NY22y6Z0OZhJ6aQTY5DebOkYwGFiKt+BsH+3sYNLnijIhqKfDTtq
	3IyvdAz1OkzlbJUPIv6MspFMEFS1VX+4S3unsqQNQuQBEgWnoP+VwA7L3ly+01/KyAsU9ZSz9vOq5
	r6++FMxyxqP+A1KDrYy+LQXVnWmJGqYXaiawXX1bwe91AWPgLzGQ5iItlS2nMha+lDQFI2ttswg5W
	l63otj0Yb68u2DH0RTAH994gGJDsQLEyLC3B/EubvWDKn6D0BDJk9wCUlnxOfOoGg3qqYIR+mQhke
	EIYDA9qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEgs-0000000A8PU-2q8G;
	Tue, 21 Jul 2026 17:55:38 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEgo-0000000A8Oi-0VT6
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 17:55:35 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-8ee6912d86dso58238296d6.1
        for <kexec@lists.infradead.org>; Tue, 21 Jul 2026 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784656533; x=1785261333; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ea/F6w9Zt+Er+ldXlrQTi7dDqHaImBI68nyXrbPqNKM=;
        b=gdST3nVrTj22m1aToDHss2JkpXw+rmjPvEM2kTF0uzzmDJFX5NMzzbLFlxmlu73Nfv
         nY5WkehBh5bKLdsxY8BCEbVuXs0f1PrbdS41HpvbtRBwnSPoi2SwT8bvKbAF0Yx+Vorg
         0tytOEFq1l9TQZKEHOz+DJWUE6aa9kb4BZCy8mEWb8AJmNj/FixmLEYBrw2u4VV84foM
         zxzrUaCrYebB8uQUG5bMHNJZWlC+3S/Dr8Pvyf7QTl4ZC8ajhtSZjmncYm+FI7WR54/X
         cpVwWI2CiutL4wdCc4lFWuVVeszRAZfzg0J1EaTjbH2T47vYQSZoTmMBLafGmAOyPlRk
         PLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656533; x=1785261333;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ea/F6w9Zt+Er+ldXlrQTi7dDqHaImBI68nyXrbPqNKM=;
        b=AEZRumbWeX2K8cYiKTaBdVMAAMe+KS8bJGxdwBJGvOTB/YQ80P3Zatikeqb9OYKNlo
         PKvtZxQkfX8AojZzYwDd0yjPZmw7G13wG2Qz9vcnf3GD7BmoJM4KGyntTypxzniMYr+0
         tldGMltqvDj01mN4NB8LGWmTPCUTIdz4HYQXlEDa0tdLFN2RV1utqP3quIns5k+BW6lz
         7gxZ1QV/X2CFL1CvE/2TBFZLnCD0NqSwFpsDGeCd4RkTFalY6bRlS0+agRhmQyfYrjuN
         Q01hlCabCGkyP1vj0nPW4IJKawjY5o71jxsNMHbUhZGfZM/KGzDitvruhRPzkc9qhIdw
         GeuQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNq+MA87gsm14t4sW+/6h0W7M/rCbvQjNSwB7N5rO4zhvD5Bw6P9hIozR1+WS+lk7npKYINQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyilkiCQMJP0OgJwn8fImsQFbsHQRfK8eY04MC1VviI2MBdoO/5
	Upn45u+lxvEJ8oXe8MqEWIfTluU8B0TIybtHJsoRnKtb48n8ZTUtxXFYBjYA7btdUCg=
X-Gm-Gg: AR+sD10yNPm9OpViHQ4+WS4WGxjlK/gDRNM1bFKJlTtSMplWbbIJkB74zqoT4syiooo
	8xekrqsVTeXVev1/+bCW/hHBexigDoYbhx8d9fniAdC9Q0IRtcJ9IsZdJX0BjcNYTaWaS95omPO
	c4+9ahz0QdwcNRToN7BxzqUzk+8OHeamMEOEfjmyD3tl5PaohhQcsAfwjCYHADHzfGXleEf1MEb
	FkNz5y/YQNJVoOT5vQbEnUq951UUoOWJz+vNbykyNQl4V+7F/WQ5ds9QhlioPiwyZdw8/vm2l2Z
	Fw0fsqHkWWY549MHfTZ/O6YHZz40kMhOJ871C/hU7SfS04NKG3B16dHMAGISYguUMFJsIy/jtlR
	wZhyAz/eJFgzFE9ilgJOQt+S5PLnR/bEbOya75/Qrd+qx+A3RyHuYLlFs7oWLhNoEVXvZ/1SEKJ
	TuWoNFDl//u2Cza9Y99F23i3STUbJECrMS7EoLUyc=
X-Received: by 2002:a05:6214:2269:b0:8f1:8937:5dc7 with SMTP id 6a1803df08f44-907784ddf91mr239817166d6.56.1784656532475;
        Tue, 21 Jul 2026 10:55:32 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8df5d0sm1663826d6.18.2026.07.21.10.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:55:31 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
In-Reply-To: <CALzav=fjTOnyg2++GFFe5B17rHqNCWW=afjsD0A=EEjycPW7Sg@mail.gmail.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4>
 <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
 <178458744511.332171.13770778781241262180.b4-reply@b4>
 <CALzav=fjTOnyg2++GFFe5B17rHqNCWW=afjsD0A=EEjycPW7Sg@mail.gmail.com>
Date: Tue, 21 Jul 2026 17:55:29 +0000
Message-Id: <178465652971.412167.17838319728990505256.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3765;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=fzgF3V5HF54yEqsnjagon7PnrwUxx4c7CuxO/Uie8BY=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqX7KSG2dHPEQ6Mkut+xegrodYi1A9KSpnUO3pn
 xL+SSaK1qOJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCal+ykgAKCRC7dyhM23N6
 3sbLD/9VJw+QusBVAbX9+6asMemVQiDftMc/hr+I22YGh5yCipWq3pZjfM7mP8bljemHy6oIbj+
 eg+gEXv7pWzzQ+8GV3PpuOBYxkjLRkI0gemShPjl4DIrRF1i5QKtbirG+j8HJShkbA0MUFQYF4w
 etoSvEkZ5OowXog4ZxpFFJrtp949gwoLonQntZS2YEdepjeuQ6O5+29aDjXTwrqt8dr3iq97QY7
 PEegM9HW0HVvWmt7PoJ0dx0EEaKZJ0GqMpr9O8W2GdxDoZXl+Sk9BxKiwyOX4J5Jz7rdQAn/o7I
 Ns4QUk/VtBQL/1irI528G9H+z0gGxw4nCxP8fANN7VQW2Y68d+e7tNZOgJEXmtgQe6lh2ihna3W
 AJSXMdazYky84+h1aAgVPom/cLGQhgzwHgZSps6nDG9qMSTLZGGAP5VPvHpjCAt1MsLtajskJ9m
 Pzp1qdozYbecunkANckh7aN32FTvRvmPFrVjU4a/bjB1bsG9O6ocEd2lvY5VLJoI/7EpNjFQENT
 gzqd9ygy3xIcDV9ifvMhU0XWWUteFUjC96g3UGsi04IcPbR5Oe4Fe0S0UiiqqUxgncTyddsTlmF
 IyJ5BW5Xc76J0oYVAhS14CIxQNY+9LXWUbBAgmqx4XEDE427j+I0Ic4eKf2seStQEq8rQZ1xQbi
 o4SPKFvgFZN6Jyg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_105534_190795_3755FDF2 
X-CRM114-Status: GOOD (  30.50  )
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

On 2026-07-20 16:07:47-07:00, David Matlack wrote:
> On Mon, Jul 20, 2026 at 3:44 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> 
> > On 2026-07-20 14:54:51-07:00, David Matlack wrote:
> >
> > Thanks for the explanation. As I understand, the most straightforward
> > way to avoid holding the permanent reference is indeed to delete
> > dev->liveupdate.incoming entirely and perform an xarray lookup on every
> > access, like this:
> >
> > bool pci_liveupdate_is_incoming(struct pci_dev *dev)
> > {
> >         ...
> >         incoming = pci_liveupdate_flb_get_incoming();
> >         ...
> >         dev_ser = xa_load(&incoming->xa, key);
> >         ...
> >         pci_liveupdate_flb_put_incoming();
> >         return dev_ser && dev_ser->refcount > 0;
> > }
> >
> > However, as you note, this is inefficient because it affects every
> > single device and adds lookup overhead to every access (not sure about
> > the actual cost though, xarray access is pretty fast!).
> >
> > We can, however, still avoid tinkering with the lifecycle of the FLB,
> > and instead treat dev->liveupdate.incoming as a "hint" that we validate
> > on access with a fast, liveness check:
> 
> Can you tell me more about your concern about FLB lifetime?
> 
> The lifetime of the FLB will not be affected by this reference unless
> there is a bug in the driver where it fails to call
> pci_liveupdate_finish() during it's file handler finish callback.

From a design perspective, liveupdate_flb_get/put_incoming() is a 
logical read-lock/unlock pair on the FLB data. We use a refcount for 
optimization and sharing, but holding a get over a long asynchronous gap 
(from boot-time device setup to driver probe) is essentially holding an 
unbound lock.

Unbound locks make it difficult to trace refcount leaks or debug 
lifecycle issues.

> 
> > 1. At Setup: In pci_liveupdate_setup_device(), we do the xarray lookup
> > once, cache the pointer in dev->liveupdate.incoming, and immediately
> > call pci_liveupdate_flb_put_incoming(). We do not hold a permanent
> > reference.
> >
> > 2. On Access: When an accessor runs, instead of doing a full xarray
> > lookup, it just validates the cached pointer's liveness by temporarily
> > securing the FLB:
> >
> > static struct pci_flb_incoming *pci_liveupdate_get_incoming(struct pci_dev *dev)
> > {
> >         struct pci_flb_incoming *incoming;
> >
> >         incoming = pci_liveupdate_flb_get_incoming();
> >         if (!incoming)
> >                 return NULL;
> >
> >         if (dev->liveupdate.incoming)
> >                 return incoming;
> >
> >         pci_liveupdate_flb_put_incoming();
> >         return NULL;
> > }
> >
> > * If get_incoming() returns NULL (the FLB has already finished/freed),
> >   the hint is invalid and the device is no longer incoming.
> 
> This avoids the xarray lookup but still requires taking the incoming
> FLB mutex twice (once for get and once for put) on every access. And
> if there's no incoming PCI FLB, the LUO will iterate over all incoming
> FLBs under the mutex to find it.

Can we do a fast-path check first?

static struct pci_flb_incoming *pci_liveupdate_get_incoming(struct pci_dev *dev)
{
	struct pci_flb_incoming *incoming;

	/* Fast-path to avoid unnecessary FLB querying */
	if (!dev->liveupdate.incoming)
		return NULL;

	incoming = pci_liveupdate_flb_get_incoming();
	if (!incoming)
		return NULL;

	/* Check again, now that FLB is acquired */
	if (dev->liveupdate.incoming)
		return incoming;

	pci_liveupdate_flb_put_incoming();
	return NULL;
}

This seems to gives us the best of both worlds: robust refcount hygiene 
and a sane fast path.

What do you think?


