Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E73C44515
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 22:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sZotz6DMr/KESNQHMebtxodvrKo450DHNTkidmosnVY=; b=tToA09vawLAjUQWjnoucVeKWat
	qeOVoVId6e8/s/QhRjHHODhp2/ZMa4u2v/7iATMwgnl8RVYQqKvgzvxuyfy8qwBkGL+RISDxuc65Y
	1VJGDW5gaYFinbDJxfLTBzHCU/9JIg3Y8R4wZMhsviwtptXk508Voc8VpFP7LKgQOdVU5St+kE3EX
	wZ0uuf/VTCHQvO+SdDLH31oStDFpj1yRtdQLRKhiYK88bQHDxzzZYojxl2uBtwjFAoNsU2BEC3Hsm
	QVlCox+GRHp1hcjgDZ5h/ngTirXeh3bZVdKVSIfAgY4pQUUMdNm55Ysr8paQoTpnXlSE+U35y5ViD
	ozu0kAGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlwiZ-000000083CD-32qE;
	Mon, 20 Jul 2026 22:44:11 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlwiX-000000083BX-3MfZ
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 22:44:11 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-92c7a0a701aso829975185a.3
        for <kexec@lists.infradead.org>; Mon, 20 Jul 2026 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784587448; x=1785192248; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sZotz6DMr/KESNQHMebtxodvrKo450DHNTkidmosnVY=;
        b=WV/w4a/E66QWaP1G1QS4OCnw1Q6YWAXwv7aiL1LoPaL97+p6euuie5Ml+Yhn9T0KaE
         B+fJ5VhObZKeLO/mCf1c3sCNwd4jWhAhbyEUokWPtu4P/oDkcQ7HvcVfrVlFvFByv5Ut
         IAik0Oge8OlZK+psdkzj17H8z1CgTvufQU6IDGI7+4i7ocWuBPmPvpKsmv23wzLID15b
         7QsUF5zNoqyep0BFjX9kLuDULwn8zwAPg9Jo9KCLpJ/7IKNXIggAyTgUYfjaBGrLnHPT
         /G10bDuVZGQ1J/Lq33BJ1M2L4043Yzr5D/3HC1lX1DN9y/sNMUynbd/CoDTGqpyy4+V3
         dgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784587448; x=1785192248;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sZotz6DMr/KESNQHMebtxodvrKo450DHNTkidmosnVY=;
        b=PofXYqsDqbf8SXFTn+SC5Wg5831Nai/d7eu8rQThdS2iWOZn6d86GdzjX+JNQazKOZ
         JvBa405/3l6eXcss1jRAeiJSy8GfN0Iks/fHrwPrlrL5kswkOoOTn0nvb6xVMUEtQisd
         /1hxC4iX70zCVtrqvfKaA5+oMBmqkSpZK4Ua+HVgb12HxVaBSRx58/0L9Etrgn7NP4OA
         TYp4SItXCJnCOCIzjbUVGhxbZWDFCTz+LNVjhA/3bsLRTxJNrmaqsSDckvCRB/549Fvq
         ZrbKA8WJ7AC9rOZijS9MmG12e83iEljNWGEVF4VmF72o5pXqxkM9gqJSHPyjbMpK3zue
         H8TQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEsqOrbiffyJP+qxqfahvQ5flPvVjXAgdsj43BnFteTl2kh210es38aLI9x8IWq9JgEKpyJA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzny/gMQLmLoAcYtpKR/dePm4LD7r6Q+q1NCySIjBCwX9N8J8k5
	sznPo6126aFne7MeLX9FNXUmfw5569DejrglCvsDoMnQcMu+EZ8t4OlG4OYpxW42J2I=
X-Gm-Gg: AfdE7ckUgCrpkzZWaIOp86Yr77QuZMrKKqPSO17AYMSTP3Hfv4iUINlJX0CMLemmGQR
	tRKSYDUQJsuo3hGKXhbC399zotYZiJtZaIp3s3I5IfiTp4/TbFMBT/lCWeOie5e/Yk3eWOkluBX
	0DZfgpbcHJ1Ol/zmIfE7QJ8lkAWH3g3EcR+AFO+j/SYYOaZo9+CADQ++l+OYANwR+YS6j7uYzvN
	OBuaZGWZa6pg6q/On+4NZHKk+F+I+UHLRYQN0SScGyEG6hIHGHhdbfNBBhCJ8jOJwTs0BR1jUyu
	XAiRUXzy+h2XHYFZFs3w5KF1AetTL4arUUAsDw2+p2v/V9Xi+hxL9pEUHz98tKqAgM/15p7I1EI
	TXNTHikJXbvSRUDm90I2MQRjagSoz1wgJyYKWGH/h/Ivs/Hf/W29Oqr6mrBj7FBNwjzKwEZvITX
	lmOwFMPU67EuI4OfPC79NlVXCFAAC6a2pHe/ms2aI=
X-Received: by 2002:a05:620a:1b8c:b0:92e:d677:45c8 with SMTP id af79cd13be357-930b3f10083mr1694446385a.25.1784587447916;
        Mon, 20 Jul 2026 15:44:07 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b5491329sm966366685a.44.2026.07.20.15.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 15:44:07 -0700 (PDT)
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
In-Reply-To: <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4>
 <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
Date: Mon, 20 Jul 2026 22:44:05 +0000
Message-Id: <178458744511.332171.13770778781241262180.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3475;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=ebC5xGcTEOi4wVqJ6ncnnXXiXaqDe2gAf8jcsdg4FFI=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqXqS1187zj8JXRe5lB5izbKlBKLqvYbVVBleoX
 4T2/h8BcwaJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCal6ktQAKCRC7dyhM23N6
 3t1OD/9Y1PR1oUKi0SDKwGc07m5QU9YJW4ylOoJhQmKBciDPc56xSO13GmZAfrbnoRNuEHy0WfZ
 T6WL+ngFtThbo8xKTV3r0pcKUNB0fuwCnI3x9Zw8CUDvHFEK6vS7Udecjo7dR9a1JLz761f7bM+
 12ImK0lfNaicDnArmbfqVQUZNpMPgdmK+CZXn7ps8uDGxF0IsSEhyuYhYJkhdoy94yjcRRrt2Zj
 g69n+kkIpTaDMvonbwXST5HwZTAjyIYDhQIP9IDt2Vnyd2+TWMrzNM9qVhyZjjrSwQ1GgV1MvOa
 jvy/0LcvwvUkcNGBNveq1/SrKCeS2+jijiLh/QmzloLFwyKAUOl98M9KaAaPMF6v1fHwAJhAY9m
 rilvw4STMhIk2+9yVSYSbxN1kBuPIwnwPodx6yjpYXsRdwr8TWEq3MAQ/07q7gArC8vtVFeZNIl
 GaAHAlFaMKl515UiO1uoW6JQxduFrwo/D1DtNaBca10N7bziwpVRj6pHXUMajydMBMoeJWOfrPz
 XOTLQBQYk9q+oZZPSV/fHFWIHlF1e3cocmdYNdnUwDNyZf+Mets1iR0Su9j7rbe1zSW1tgSuLgX
 nE8RRMA+RyH7M6lkvSgFkzdIBtfu1B1URfbD+EDaIzeqVHJAwYbjo7sEfPI46GMBtnmVSeum85X
 aSNOxJOHr7j1oBA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_154409_864578_C7221F35 
X-CRM114-Status: GOOD (  24.83  )
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

On 2026-07-20 14:54:51-07:00, David Matlack wrote:
> On Fri, Jul 17, 2026 at 2:47 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> 
> > On Fri, 10 Jul 2026 21:26:06 +0000, David Matlack <dmatlack@google.com> wrote:
> >
> > I am confused by this. Each preserved PCI device must have an associated
> > FD preserved with it via LUO. I.e., vfiofd would need to be preserved. If
> > the vfiofd was not reclaimed, and finish is not possible, that vfiofd
> > would still be owned by LUO, and therefore PCI FLB refcount would stay
> > positive.
> >
> > However, if finish is possible, and this is the last vfiofd that is
> > finished, FLB will be freed as soon as the reference count reaches zero,
> > which I would think is the expected behavior.
> >
> > What is the point of holding a reference here, instead of only for the
> > duration of FLB access, i.e. to make sure we are accessing a valid data?
> 
> The duration of the access is from here until pci_liveupdate_finish()
> because that it when the pointer (dev->liveupdate.incoming) is
> cleared. So that is why the PCI core holds the reference from here
> until pci_liveupdate_finish().
> 
> We could avoid this by deleteing dev->liveupdate.incoming and,
> instead, fetching the incoming FLB and doing the xarray lookup every
> atime the PCI core needs to access the device's incoming ser struct,
> but that would be inefficient.

Thanks for the explanation. As I understand, the most straightforward 
way to avoid holding the permanent reference is indeed to delete 
dev->liveupdate.incoming entirely and perform an xarray lookup on every 
access, like this:

bool pci_liveupdate_is_incoming(struct pci_dev *dev)
{
	...
	incoming = pci_liveupdate_flb_get_incoming();
	...
	dev_ser = xa_load(&incoming->xa, key);
	...
	pci_liveupdate_flb_put_incoming();
	return dev_ser && dev_ser->refcount > 0;
}

However, as you note, this is inefficient because it affects every 
single device and adds lookup overhead to every access (not sure about 
the actual cost though, xarray access is pretty fast!).

We can, however, still avoid tinkering with the lifecycle of the FLB, 
and instead treat dev->liveupdate.incoming as a "hint" that we validate 
on access with a fast, liveness check:

1. At Setup: In pci_liveupdate_setup_device(), we do the xarray lookup 
once, cache the pointer in dev->liveupdate.incoming, and immediately 
call pci_liveupdate_flb_put_incoming(). We do not hold a permanent 
reference.

2. On Access: When an accessor runs, instead of doing a full xarray 
lookup, it just validates the cached pointer's liveness by temporarily 
securing the FLB:

static struct pci_flb_incoming *pci_liveupdate_get_incoming(struct pci_dev *dev)
{
	struct pci_flb_incoming *incoming;

	incoming = pci_liveupdate_flb_get_incoming();
	if (!incoming)
		return NULL;

	if (dev->liveupdate.incoming)
		return incoming;

	pci_liveupdate_flb_put_incoming();
	return NULL;
}

* If get_incoming() returns NULL (the FLB has already finished/freed), 
  the hint is invalid and the device is no longer incoming.

* If it returns a valid pointer, the FLB is guaranteed to be alive, so 
  we can immediately use the cached dev->liveupdate.incoming pointer 
  without xarray lookups. The accessor then puts the transient 
  reference when done.

3. In Finish/Cleanup: We can simply clear dev->liveupdate.incoming,
and decrement ser->nr_devices.


