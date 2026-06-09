Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A3ACD8CB2
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 19:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vpDQMG3B/X+zmrU+8qfo8gbz7yy+2Hc3r+dRrwN0wsk=; b=JlpVEpa3zsgzQDf8z3EC7Z/x93
	c4L3RmEGK4jecGHfABm2ZdU+fHp96ENQVB1GsyoUD+GWnFjTAeiC2JV/OlzPhmX0AVWZ2+HLlDZpQ
	yWMHltjDeNOMhBDT7tIMeIS6vfqaV60eF/fKLVy4aESfve+wX3hHg86TDK2M4tUjgUWNvhlOCmmH3
	EjWzmsT+jWqqx71H4ShfJocTaLRzolavxLmEgD+SaIXX5jkEaVcCYoEaHHoBNQad/SmoiQ3e53acg
	LCIAnbcMQUuPn2xMdciDehc0OaSlmLJjWDK8FA4zDftdhKjqYPQs3Ai0HtMqoX+Y34qKCMAq/4BkD
	RuBByVbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX25R-00000006HFf-2FPo;
	Tue, 09 Jun 2026 19:26:09 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX25P-00000006HF1-3htk
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 19:26:09 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2bf2d865383so505675ad.1
        for <kexec@lists.infradead.org>; Tue, 09 Jun 2026 12:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781033167; x=1781637967; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vpDQMG3B/X+zmrU+8qfo8gbz7yy+2Hc3r+dRrwN0wsk=;
        b=LNgsdWjFRG6bnRyNo32d4hS4gl9BrRnC4EImyh2Eyixx/2fvr83MA0kxXq1ruPDwRg
         +nzKmpRDuuYWi6J+TFy6pl1JIf2R1URNA9Yn0USqQgxuVm49HkSo+vupzlKb4gsm+Teo
         DVS3PQ22e9eO1WUkoujBlp4WXAEvJpFlBkzSLpZfCh7jBzUpCEd7p3oGa3TNr/VAruOS
         ts/Yw/tPBtq58giamyUrXhuywlWxPP9QtAxGUdcBl+EocAElacXZzr1dpZkihBNMwKVL
         aO3EQF+1py+zNnbD370Pt3DgTIfoDvUO1RTot4egs2h1LIPyj4F/Aoi4tY8XxUHmvrzF
         s/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033167; x=1781637967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vpDQMG3B/X+zmrU+8qfo8gbz7yy+2Hc3r+dRrwN0wsk=;
        b=D2o7S4hJrb4oSZv7xXmD2CutjEED9jhAlAf6eiFrXxl5NlKXfv77Ns0+zV3PRUEiRf
         K/NwoTCWQmlvdbqhjQkVwW7ygodITrV19GUiwv8XANcud4zGxi12lH+MXEhWMYod4AU4
         vfNmCqTgVUwz3AoUs5kOVkM6m2KfUfQIXULcuGv9kH6HNI4yMAj1qYvTC1oP3sHU/E23
         GUISqSvz16Ob+uuG3WSF+wZ4R8faQqemNRRJfS2e6vP9Vmm/4JSs016R5/9L4efnef1G
         mQ0Dy5wLQiHbfunPKvIIS5cgWJ4AUplNQuBo0QQON1eUJc8JjLHe4Hpm8H4/KZS6IDJb
         22LQ==
X-Gm-Message-State: AOJu0YwMzad7nfb7+yzllMj1PehvAigixeuw+/XHCZGPoaKJro1BgZOo
	Qjbf8QEfLonjrYeQBHm4+tOFImwXmDvKtx0taZyHj61yUfPcKG1B/OASDT1BcIU8Kg==
X-Gm-Gg: Acq92OH/eqq1inlaV9K3c4b8KqgZI1xq8SiFIuDUlPHWmGAxyZBWCR7m362CoXt18Hd
	lVBwAbJgM14H8FrYlqRwTC8eHjuGValQPdQgbTAg4inWNzZxg/WCY+2JeWPYx0OHb8WiHwCxFlz
	Ao3ABHP3uzosMKAKAR3+xIS62Ax34cBhjjcx+4Zi/rqkdbrlA2wjf8EjiIKoi5doceoY/055+uf
	XK6a16MsVZMWcsbj6l0fybNgPVJHydrpifstNxgPrUAl5x/Xrj9oCu03WIQNNuuv+XV4wX7JbrJ
	R1RIhLQkNMiLcIHPnmW2E6cZNIhkCzohGMNGhPj7H2Gc0vDIGwY4ti5Nt4pG5ZhziorXBH4v+y4
	3VuGVJsFlkIs3OFp1wdPiKHpQbfqSnCDE27PiATBhDDWt/ZfvWJoNmkjWkyLCoML9jt+iMQAy3/
	WApZIOZzLpD7T6co/O4WaR8UzmlDfT3bGOnvoAprDlK6yWOVjHJwqASLowlNb8SFPF3XqNyJ0=
X-Received: by 2002:a17:903:19ed:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2c1eb942782mr8088245ad.10.1781033166370;
        Tue, 09 Jun 2026 12:26:06 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428237430esm20445672b3a.21.2026.06.09.12.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:26:05 -0700 (PDT)
Date: Tue, 9 Jun 2026 19:25:56 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
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
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <aihoxGlb-ruwAaWC@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com>
 <aic6mdiZ0qUJpFca@google.com>
 <aihLTgs1Y49OXQaV@google.com>
 <CALzav=dagHvcS8kbTti5rmMoks9DXuCpO3AjptkQ8z_PdG9JyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=dagHvcS8kbTti5rmMoks9DXuCpO3AjptkQ8z_PdG9JyQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_122607_935740_7524D9D6 
X-CRM114-Status: GOOD (  40.73  )
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

On Tue, Jun 09, 2026 at 11:40:39AM -0700, David Matlack wrote:
> On Tue, Jun 9, 2026 at 10:20 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Mon, Jun 08, 2026 at 09:56:41PM +0000, David Matlack wrote:
> > > On 2026-06-07 08:37 PM, Pranjal Shrivastava wrote:
> > > > On Fri, May 22, 2026 at 08:24:06PM +0000, David Matlack wrote:
> > > > > Inherit Access Control Services (ACS) flags on all incoming preserved
> > > > > devices (endpoints and upstream bridges) during a Live Update.
> > > > >
> > > > > Inheriting ACS flags avoids changing routing rules while memory
> > > > > transactions are in flight from preserved devices. This is also strictly
> > > > > necessary to ensure that IOMMU group assignments do not change across
> > > > > a Live Update for preserved devices, as changing ACS configurations can
> > > > > split or merge IOMMU groups.
> > > > >
> > > > > Cache the inherited ACS controls established by the previous kernel in
> > > > > struct pci_dev so that ACS controls do not change after a reset
> > > > > (pci_restore_state() calls pci_enable_acs()).
> > > > >
> > > > > To simplify ACS inheritance, reject preserving any devices that require
> > > > > quirks to enable ACS as those quirks would also have to take Live Update
> > > > > into account.
> > > > >
> > > > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > > > ---
> > > > >  drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++++++
> > > > >  drivers/pci/liveupdate.h       | 11 ++++++
> > > > >  drivers/pci/pci.c              |  5 +++
> > > > >  drivers/pci/pci.h              |  5 +++
> > > > >  drivers/pci/quirks.c           |  7 ++++
> > > > >  include/linux/pci_liveupdate.h |  6 +++
> > > > >  6 files changed, 102 insertions(+)
> > > > >
> > > >
> > > > [...]
> > > >
> > > > >
> > > > > +void pci_liveupdate_init_acs(struct pci_dev *dev)
> > > > > +{
> > > > > + guard(rwsem_read)(&pci_liveupdate.rwsem);
> > > > > +
> > > > > + if (!dev->acs_cap || !dev->liveupdate.incoming)
> > > > > +         return;
> > > > > +
> > > > > + pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);
> > > >
> > > > I might be thinking out loud here, but as an attacker, this motivates me
> > > > to somehow hack the EP FW to mis-report the PCI_ACS_CTRL register across
> > > > a liveupdate to fool the incoming kernel. If the FW feeds a 0, it silently
> > > > strips ACS protections.
> > > >
> > > > Should we also serialize ACS state in ser somehow to ensure we aren't
> > > > fooled by something like this?
> > >
> > > What does "EP FW" mean?
> >
> > I was referring to the Endpoint Firmware (basically any SW running on
> > a downstream device)
> >
> > >
> > > Does such an attacker even need Live Update to attack the system? It
> > > seems like such an attacker could route TLPs in whatever malicious way
> > > they want regardless of Live Update.
> > >
> >
> > I agree that compromised PCIe devices are a menace anyway. But I was
> > talking about the potential window opened up by Live Update here,
> > suppose we have Device A & B assigned to 2 different VMs (implying they
> > are in separate IOMMU groups because the switch set ACS_RR = 1).
> >
> > Now, the attacker has an opportunity with Liveupdate, since the devices
> > are already assigned, if *somehow* it flips a bit like ACS_RR, the
> > incoming kernel might see both the devices in the same IOMMU group.
> > Who detects this case and what happens if this happens if the devices
> > are kept assigned to these VMs?
> 
> I suspect that would be caught during the restore of the iommufds to
> which those devices are attached.
> 
> The kernel would attempt to restore each device into a separate domain
> (since that's how they were preserved before the Live Update) but that
> will fail because they are in the same group now. Even if one of the
> devices was not preserved, that will still cause a failure when a user
> tries to start using that device (e.g. to try to attach it to a
> different VM).

Yes, IOMMU would eventually catch-up but what about the DMAs that were
done already? Say to an NVMe disk? We'll have to wipe the entire disk in
such a case? Also, we wouldn't know the offending device..

If such situations aren't a problem, then I guess it's fine.

Thanks,
Praan


