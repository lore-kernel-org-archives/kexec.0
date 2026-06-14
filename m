Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778FBCD98D2
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fF8u6DKkckQuJavK70W0G+qrxbgEHWN1DTuCSFFIGv8=; b=F7f89Lm1mkEbVHcDUL93p32XWc
	O84VJDlx6us/Y8ctXhzC9Fpj61mJxfyVSODjBtpZpyC0nwDQPob+22B3hAIVysQ/kGneDFbOfA/Qa
	FWz4KIRmrhzijIx1AiHPYXRcwW/sEL+6f4FH9pMIz6O9XYwDr1rTFhu1Y8NHUCL1FYqL9dBcA72CR
	VRoEK3RJ9DjT/1EI1uqt+j42WEQFEPzz8Z/qytB4d2f1EKXqCL0bRghsINut36Cdqkasd4OWBaSSZ
	LuPtr7pc4niUpp9LBFqsvpeWplEV3qtozUfFAFP8/dIKs2xd6mVkDWoC3Z9qW1IEX2p8rCZPYz2eb
	e46G0GDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYlOj-0000000D3qV-16DH;
	Sun, 14 Jun 2026 14:01:13 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYlOh-0000000D3q3-0LqX
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 14:01:12 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-915c36e32abso222910585a.2
        for <kexec@lists.infradead.org>; Sun, 14 Jun 2026 07:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781445670; x=1782050470; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fF8u6DKkckQuJavK70W0G+qrxbgEHWN1DTuCSFFIGv8=;
        b=J0sxX6B3rK7AzSSAIQDGkx1riggDmH/nAFWVkvoiVC3wul1vvFOFegF4PiAB4Y0k8L
         DEmQ8Xag0mGOoSq7e53VpJYssOBpVwQbXzEDVSL7wqszZdfds2Plci9paptxpuH3xfuV
         6zqnZpW7uLq56sKh/VGCs2bIF8n+iHGo17JmOgqbiHXWHsjCNVUMj6kStcRYPpxcRxbB
         psDkmOie2zvCz6sZRgjGqSxcfNB/7sigyd32i1ct7WGIa/yCTLkTISOiJ6YdhqnLI+Eg
         2nh2BItXFeYLz6RbIlziRlm/8LXRf8iOjmKbDE8mdPZh3d4MtYcepNl3KGcIlzTerFtF
         9ZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781445670; x=1782050470;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fF8u6DKkckQuJavK70W0G+qrxbgEHWN1DTuCSFFIGv8=;
        b=p8V9l8d2B2COI/oEW0bhqwJODPyqw/gPa6azvwxTZmqu0e9FFjTikmKrJm1BLI5HTh
         AuqCQ3Rj8PS44WzfKmyu1XJwThAu0PyeR3ZeRcy0FKxM+Nk0zgf3EqWAZX/oZamcQp6a
         xzDBy4enqjDjOjRSDgdRZ98T43Jtw2++GdwmtSKVmeigI777DaKwLDoZ0MlCh2D3aTl6
         4GOj+A+GL5MldTqvmANomcS5UfIALGDQs5CywNGDOh+rwSd6Ds3aGldYruG8ajugU2v0
         C18lH8c9H/e0mLwMfnKHZrFxvWhQHSxBfcirWLKhbLk20ODjoWFpmZijtGEnYWBVIMEt
         y86w==
X-Forwarded-Encrypted: i=1; AFNElJ/KGZVhnDI3TWAh7ZLtB9Wz1O5jgERjGL0IfpuNx5JKgFinhqD7UxGbTuNX4K6R58r8RPsVcg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyjKqDS8iFtJzFYTeda2mNko4B0+QV6hJywHoA9u001dcropjHT
	/sXCJaUHZawVmObDCYic3NcArJUnxfDgKTCl2OQmzoJeF9fXY3xPnKPLE3cLZWuKpfU=
X-Gm-Gg: Acq92OFoJ7pN+u8yCanhAvVrURbrMj5vWNCUUeNJvFVRimZmOxGZC6grUTGHSrltrXV
	tnMjfequpusjaS9lPnykNNeY63M3JAEd18zK8NnWJZm+gJ6djxgbkVrVirrkN0AaC2d+meC/Z+b
	fpJ7OlkJLIf3HQVfhuCAq3ApzLpB4rAhLnnCOd49MOsrDE1no3m2VibwrspkhnlHELg4/j5JNaJ
	mBKGV0sqJ3CmbzTsU0WY9Qtyi0cyvQVyygWtKoKY/LSHTd0pV9RSREfVv273nINdXvAX02wxO21
	VP/xcxC3YnxhCzAyQuxTiYZmI3XayUCffR7uKYdm0k05HMps5qzdNgfDKhbt+QOye6uhcS7r/bl
	8IFWor9WwDcExJuaTApe2tqC1QLxUu4wqg/a8OZWiDg6pvAWvcPx4aOrdw3pg5wrcZ4+5Gt+b2P
	xOGuHafsNJlCigRgWpkT5jx49WNc2Di7DIIABzVEF1EH8y5gMxsdA+IkfKXqoFjvlsZBYhSQg=
X-Received: by 2002:a05:620a:3705:b0:914:ac45:a98 with SMTP id af79cd13be357-9161bb03ad9mr1608583285a.17.1781445669356;
        Sun, 14 Jun 2026 07:01:09 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f05fe7sm806892185a.12.2026.06.14.07.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 07:01:08 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <aiQAJRINEKiwCmVm@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-6-dmatlack@google.com>
 <aiQAJRINEKiwCmVm@google.com>
Date: Sun, 14 Jun 2026 14:01:06 +0000
Message-Id: <178144566685.1266136.10385355007970146916.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4053;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=0/f3k6YhFFNYqylgqcMG4vpeDMtx34OA88JRI3jDl7g=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqLrQjWixclC4MmfNpLIwWFqBCFzofhX0Jr8QQJ
 bpVL95JpeyJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCai60IwAKCRC7dyhM23N6
 3kUaEACol4WdgDqN/9YA64JobY3TtWyKckwy4VgKxaRGy/1HiRGiXX5khGnvPxf/QUt2GqkrOAD
 9bfcRjR/HmwRhjEO8hkWUhHd5uwowgrsW2sn3Y0fs3qD3jwY1OCZ9WdrkMReE8b3B3ii5wzbOQd
 +dlUHARMl3hjaiT9TSaHtHOkmSDKHM1UKPlzTWRDrCmh6+LnpuOakhfPOKFldJYDgw/YIBKmZQG
 +YIWAWmBPRFGkUgCD9FoglbeuyIym39QFmBpPde0isIetl86PwQReKOb5H2Zi+aD+mm4ine49jq
 KLbeKAxjqxMj1cXWKk84Xe40fr4H4wkU4vsfGH/eGK1o3wiQVoBbu2TPp1LCeB9N0cNWCVE9DH0
 7EizDfLEBK/1DKZaUprLyucUu/eA2S/S254GS3Jn5LDRzlNOj1al3yHR68VyCLeMWcZA/VgxYI5
 dqQYd/bN6gOvwDlFB/xexPatXErOhIo0iGC1i84tXL4C1OQEi9uIY1CtDZ+Ztv0pgUNlVOhFyGb
 kqDZniluCNmnn8OGPvNMZz+sCPJtmqQBEATH2Hv8dlOdlb4s8lSUeGD1aBMvKPKB5Bh0hAczvNh
 Sj5W6biG4ZUAj1L8BivCr0gTvsEJ2WSr9VMRTzsZ+0+dMV96HGvU4RyHQY7IY0Mx6kLObjr8TRS
 KOqR+oScoluku5w==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_070111_144740_526703D7 
X-CRM114-Status: GOOD (  31.98  )
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

On 2026-06-06 11:10:29+00:00, Pranjal Shrivastava wrote:
> On Fri, May 22, 2026 at 08:24:03PM +0000, David Matlack wrote:
> 
> > During a Live Update, preserved devices must be allowed to continue
> > performing memory transactions so the kernel cannot change the fabric
> > topology, including bus numbers, since that would require disabling
> > and flushing any memory transactions first.
> > 
> > To keep bus numbers constant, always inherit the secondary and
> > subordinate bus numbers assigned to bridges during scanning, instead of
> > assigning new ones, if any PCI devices are being preserved. Note that
> > the kernel inherits bus numbers even on bridges without any downstream
> > endpoints that were preserved. This avoids accidentally assigning a
> > bridge a new window that overlaps with a preserved device that is
> > downstream of a different bridge.
> > 
> > If a bridge is scanned with a broken topology or has no bus numbers
> > set during a Live Update, refuse to assign it new bus numbers and refuse
> > to enumerate devices below it until the Live Update is finished. This is
> > a safety measure to prevent topology conflicts.
> > 
> > Require that CONFIG_CARDBUS is not enabled to enable
> > CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
> > bridges requires additional work but is not a priority at the moment.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  6 +-
> >  drivers/pci/Kconfig                           |  2 +-
> >  drivers/pci/liveupdate.c                      | 83 ++++++++++++++++++-
> >  drivers/pci/liveupdate.h                      | 14 ++++
> >  drivers/pci/probe.c                           | 17 +++-
> >  include/linux/pci_liveupdate.h                |  4 +
> >  6 files changed, 119 insertions(+), 7 deletions(-)
> 
> [...]
> 
> > +		incoming = pci_liveupdate_flb_get_incoming();
> > +		if (!incoming) {
> > +			dev->liveupdate.inherit_buses = false;
> > +			goto out;
> > +		}
> > +
> > +		/*
> > +		 * It is safe to sample incoming->ser->nr_devices and then
> > +		 * drop the rwsem since nr_devices will only decrease. Thus the
> > +		 * only "race" is that the current scan will be overly
> > +		 * conservative and force bus inheritance.
> > +		 */
> > +		dev->liveupdate.inherit_buses = incoming->ser->nr_devices;
> 
> Nit: inherit_buses is a bool, while compiler will handle it correctly,
> maybe we could:
> 
> dev->liveupdate.inherit_buses = !!incoming->ser->nr_devices 

+1

> 
> OR
> 
> dev->liveupdate.inherit_buses = (incoming->ser->nr_devices > 0)
> 
> for readability?
> 
> > +		pci_liveupdate_flb_put_incoming();
> > +	}
> > +
> > +out:
> > +	return dev->liveupdate.inherit_buses;
> > +}
> > +
> 
> [...]
> 
> >  		/*
> > @@ -1497,8 +1501,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >  		 * do in the second pass.
> >  		 */
> >  		if (!pass) {
> > -			if (pcibios_assign_all_busses() || broken)
> > -
> > +			if (assign_new_buses || broken)
> >  				/*
> >  				 * Temporarily disable forwarding of the
> >  				 * configuration cycles on all bridges in
> > @@ -1512,6 +1515,11 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >  			goto out;
> >  		}
> >  
> > +		if (liveupdate) {
> > +			pci_err(dev, "Cannot reconfigure bridge during Live Update, skipping\n");
> > +			goto out;
> > +		}
> 
> Quite helpful! Thanks :)
> 
> > +
> >  		/* Clear errors */
> >  		pci_write_config_word(dev, PCI_STATUS, 0xffff);
> >  
> > @@ -1572,6 +1580,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
> >  
> >  	pm_runtime_put(&dev->dev);
> > +	pci_liveupdate_scan_bridge_end(dev, pass);
> >  
> >  	return max;
> >  }
> 
> With the minor nit above,
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> 
> Thanks,
> Praan



