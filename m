Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7E4CD8CAD
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 18:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rp2AVHnvaLdz2Pq3FiqBKoQWbYzwYe73io7ef1uKgPQ=; b=fhreqXsVeufXbQZWF+H7YuVO4z
	Om2gXZNyTspFL4dRUiZ/yXvpsNBI+Hgo9kD7dvUv7s3Xrwgvv1s72oUYd1cx57DjwMpnNFRKay5yp
	ycpfxR78fPOXtYkjPdm+ATTOfQzGfVKABpMgLy0dkfQ5kkeGkWR4miDBlEHxeEWbGBxH/htLyUPOA
	+w9CqO+RtymcuiFcod1Gi/na4e7wi2ZO/IL4jG6xMtUQJaSCTl5nfEmYWv20SmZPsRapyxQWn8DKc
	oAViH3AxFZDElYl1q8duhgsHwF+F3RJZeEsEx1HQ+OQ+wYQ5zbNY3Bbf60w2C7hK9qGmyMJKg5xC6
	Xuk0vM4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX1Nu-00000006DCU-1qE6;
	Tue, 09 Jun 2026 18:41:10 +0000
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX1Nr-00000006DBv-3YcM
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 18:41:09 +0000
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-137dd4cc208so3804078c88.1
        for <kexec@lists.infradead.org>; Tue, 09 Jun 2026 11:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781030467; cv=none;
        d=google.com; s=arc-20240605;
        b=VlDLfgO4vGdSK1IpuZNhYP9uHhXfKFe1gspMo6EcmtaAgVJP/8KbQBYLEWp2Vsam8y
         b6h58TEi4r2kJV0eFSVwBLbM8XajDbjbrBM+Cimn/bHCfd8A0T9ASUEPdcOwVgek7sVi
         IIsfH9NtxAqZcA1SqWQ3bH5FLX1rQ3w76q85/rj5cl8UhiIPPlI2NpXUq5iRVeAbhFBQ
         3449FNeFbSLpmILGG+Z7no081LrdYbyZ3gBeWdgRqo9iMxjYKZl7FgAOQcKzt/lf3Qkt
         anwOtPb4s+5XCMEZZgOdvIZYdZkd0Mw7Fid9mQ/Fw9e5AOUOJ+LhHpKe5ie2SRJli/uS
         p1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rp2AVHnvaLdz2Pq3FiqBKoQWbYzwYe73io7ef1uKgPQ=;
        fh=53rW6S1q3lNh3DoxkKmhwZm2aJNiTTwMohlFJ6Xe2K8=;
        b=JquwYlTnD9PbKgyyt0AzcRsRPoMQwDdgmiVHmgsrKRsPKdrQfSDJwoSGNEkRyKbDh9
         YZcsbczwajbmNCHHD4BHYle95ZDfxCISfrcw4OKkOANlmOHYL0WaF19tKbZy6K+H1OcH
         ZYK0zmggnBfo/+N4VdbtsjJOfrj/jZaRsTbtAgW4Y6k0fzaXK618Gm1cEXwOmtt4Evp1
         fHGjURECJ1u7wifwAu6mxRDNs1bX+04KY7vkhxK6tNZgzgt2EYwCe8WW31CFZnt5wDs1
         kVx3xeaBjEXyDoPX7abkIGDGz+N54pAoMe3atZWffZtAbT8AHIwkZn41hDuFM8vPOGWh
         EJag==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781030467; x=1781635267; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rp2AVHnvaLdz2Pq3FiqBKoQWbYzwYe73io7ef1uKgPQ=;
        b=wcVa6UL1JJdc5gPcUQCIFTvPkNg4TuPlDlfzAvYhJTVvmDDxiP2dzQZSymSsKxsKn1
         4iQXUd7q8YgWAVlTpzEnfqrhvTIa9XJXs4GjIymE356IyQwMDx0Kkqr7mAiPekXvDhMD
         JN16IoAOGmJxDYzYYjpy8G2n2CgCTOg+DFxvRJYJULeyejJdS7sxkhO0bc3SNkB0qShI
         mXbZ/pQfJPQl4HFMCae0uHvtG1H/MLHjN6ulVMunTYXlTstfEWBeUtXxjj4sjfEWMB1w
         3Q/vhC/E6U3d6IjuvQTba1aXRofbU13OnOHDpHOI01/k29t4HNAoYvnO+KQ4e1S4dVF2
         59Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781030467; x=1781635267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rp2AVHnvaLdz2Pq3FiqBKoQWbYzwYe73io7ef1uKgPQ=;
        b=g0DIeggiAqA9SZl8mR5kcWVvmjd7/l+0mxyiMHIP3srJbdrTjRiJ3GesRf1ifdUpeH
         Plk5ByLJRr7g6qEyA5NymZ5s8tOQSS26bgLKC+KhklOUNgESeewU33x/2FKhZcshdRh9
         sBxnNs3zKm/DCF03qbEPlNmKY/UQvWDSxsAScZXdsyyJjszDYOJZuWiqJXiPQHJWKF0/
         MYLOAw/qCncgii6WvLI2zgD1dovqKTHzw1pTqrPhPKzN2NgOxv18mutPgNmWrFlxzdM1
         l+2P8IYhLhR6I3BgF4DBMQ7llRhbN+5mBENV5F9GHh8EAHC/m/+3XjduGfdII/ewgEt1
         Bwig==
X-Gm-Message-State: AOJu0YyfDYG/eAngL/f2FdGZTtUpCNqz65rkjacGBacKHPC3XJ0UBQvw
	t+wmNgyhsv3TYkiSP0Z+RUZusau+wEpPokqtxDf9FqWRWJgfjWxBEi2VKsM4GXargh2VXinaW7X
	YGmmtWQVXCbIYYb7zc0J41iwW3nJJHthPW8Xcu5M2
X-Gm-Gg: Acq92OHCA1javCM28lCalq+EBQfFLLQCe0lE4MJd4XVgeHD7sZ3rTc0KH+idWXeZQLC
	kYFXvUZS1uAj2rSpCgnsuOCwUHR/RUzQTVnm2/Y97FQzni/6wUrKCGhas3LD7BjwU1wiy6pdjiE
	vwSKsLW5huau7YPhaXiN2ADM65r7rqVkUBTuEQ7qe02W3bEvzeD2yivlvfaioHIFSUV/dLKoR08
	64m9EKQ/vJOTBvdfcHyAmk/qWe9sFhFMAH7YGXkAlDDJvY9opjiZ1ACH0pNmTrgT6FeyyNcwS26
	qRea8zkv6H400BgG1QmodxbQv6xw
X-Received: by 2002:a05:7022:327:b0:133:39b9:9720 with SMTP id
 a92af1059eb24-13807d7f8a8mr10097032c88.16.1781030466370; Tue, 09 Jun 2026
 11:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com> <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com> <aic6mdiZ0qUJpFca@google.com> <aihLTgs1Y49OXQaV@google.com>
In-Reply-To: <aihLTgs1Y49OXQaV@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 9 Jun 2026 11:40:39 -0700
X-Gm-Features: AVVi8CfFJIkIzWoDM1n34NzkGcY8xgKn7goqY8e0r212_RJvyRI4sWlWr6KLrxY
Message-ID: <CALzav=dagHvcS8kbTti5rmMoks9DXuCpO3AjptkQ8z_PdG9JyQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
To: Pranjal Shrivastava <praan@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_114107_892226_E168237B 
X-CRM114-Status: GOOD (  34.61  )
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

On Tue, Jun 9, 2026 at 10:20=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Mon, Jun 08, 2026 at 09:56:41PM +0000, David Matlack wrote:
> > On 2026-06-07 08:37 PM, Pranjal Shrivastava wrote:
> > > On Fri, May 22, 2026 at 08:24:06PM +0000, David Matlack wrote:
> > > > Inherit Access Control Services (ACS) flags on all incoming preserv=
ed
> > > > devices (endpoints and upstream bridges) during a Live Update.
> > > >
> > > > Inheriting ACS flags avoids changing routing rules while memory
> > > > transactions are in flight from preserved devices. This is also str=
ictly
> > > > necessary to ensure that IOMMU group assignments do not change acro=
ss
> > > > a Live Update for preserved devices, as changing ACS configurations=
 can
> > > > split or merge IOMMU groups.
> > > >
> > > > Cache the inherited ACS controls established by the previous kernel=
 in
> > > > struct pci_dev so that ACS controls do not change after a reset
> > > > (pci_restore_state() calls pci_enable_acs()).
> > > >
> > > > To simplify ACS inheritance, reject preserving any devices that req=
uire
> > > > quirks to enable ACS as those quirks would also have to take Live U=
pdate
> > > > into account.
> > > >
> > > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > > ---
> > > >  drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++=
++++
> > > >  drivers/pci/liveupdate.h       | 11 ++++++
> > > >  drivers/pci/pci.c              |  5 +++
> > > >  drivers/pci/pci.h              |  5 +++
> > > >  drivers/pci/quirks.c           |  7 ++++
> > > >  include/linux/pci_liveupdate.h |  6 +++
> > > >  6 files changed, 102 insertions(+)
> > > >
> > >
> > > [...]
> > >
> > > >
> > > > +void pci_liveupdate_init_acs(struct pci_dev *dev)
> > > > +{
> > > > + guard(rwsem_read)(&pci_liveupdate.rwsem);
> > > > +
> > > > + if (!dev->acs_cap || !dev->liveupdate.incoming)
> > > > +         return;
> > > > +
> > > > + pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->live=
update.acs_ctrl);
> > >
> > > I might be thinking out loud here, but as an attacker, this motivates=
 me
> > > to somehow hack the EP FW to mis-report the PCI_ACS_CTRL register acr=
oss
> > > a liveupdate to fool the incoming kernel. If the FW feeds a 0, it sil=
ently
> > > strips ACS protections.
> > >
> > > Should we also serialize ACS state in ser somehow to ensure we aren't
> > > fooled by something like this?
> >
> > What does "EP FW" mean?
>
> I was referring to the Endpoint Firmware (basically any SW running on
> a downstream device)
>
> >
> > Does such an attacker even need Live Update to attack the system? It
> > seems like such an attacker could route TLPs in whatever malicious way
> > they want regardless of Live Update.
> >
>
> I agree that compromised PCIe devices are a menace anyway. But I was
> talking about the potential window opened up by Live Update here,
> suppose we have Device A & B assigned to 2 different VMs (implying they
> are in separate IOMMU groups because the switch set ACS_RR =3D 1).
>
> Now, the attacker has an opportunity with Liveupdate, since the devices
> are already assigned, if *somehow* it flips a bit like ACS_RR, the
> incoming kernel might see both the devices in the same IOMMU group.
> Who detects this case and what happens if this happens if the devices
> are kept assigned to these VMs?

I suspect that would be caught during the restore of the iommufds to
which those devices are attached.

The kernel would attempt to restore each device into a separate domain
(since that's how they were preserved before the Live Update) but that
will fail because they are in the same group now. Even if one of the
devices was not preserved, that will still cause a failure when a user
tries to start using that device (e.g. to try to attach it to a
different VM).

