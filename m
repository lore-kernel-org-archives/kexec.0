Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A5606A33B
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TNjgBRFh;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NNOB6ST/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/RuK77T8Pc2yA26RkCicA7q1V6UBHbE6inBIYLOkP8Y=; b=TNjgBRFhXM4bzG
	6z2GC0/HQe7/mRpcumZEruGOrYuHFuM4935tWwS9TuVwHQXITQ/Wgm2bF5t+7DOCKt1yt23Mp46fU
	4KxAb/ztGNNGDbvFBaR34aKO81xaP7qm6gN/KpyfKsNRakoKRKzs2GYJnPbVep2lGXro7Y7flp+5J
	zZ5nI3Ja4YxQebX/ivMgAbAKAjwPSq/L9YdGLHXpYYyyNw/lezFH+Uyb3dnlnfsfxD13L43XHOcN1
	R5Gv6FGP25CixcqAjMWkEGJSNhO8Y36hI8Xt7htfV+5Nslo6VBLM9HUY7W5XaTf3jjKQGRXflpWgS
	bQx1m8nSZUFfWFfHcYRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUEn-0000000G5Hw-0zIu;
	Fri, 20 Nov 2026 19:25:33 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUEM-0000000G5Am-1FvY
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 19:25:30 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so526167b3a.1
        for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 11:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795202704; x=1795807504; darn=lists.infradead.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/RuK77T8Pc2yA26RkCicA7q1V6UBHbE6inBIYLOkP8Y=;
        b=NNOB6ST/6Bfny4SlJY4e8nmUszySXgS0RgsYpG50qTUjYDYjPhQGCLJEOsxranaTG9
         oylhME/zfwHuCPZKacdWwvbdaCX0RPw6MiVXe1WU59lbdA9cgDxza1m7LKrl7k6w9KMG
         NFaM4/EJ4jcKFHtHPJ0xJ9uTwWbHcvQlY8eG2CJ/BTNuLFkzmtaf0+Uj65yRbtVtvBZk
         Az+Esm1AZCn2h37wtzRWjRjRFEpRqzePm1UJdv/aZp0Po1N6XT3XrsOypYwQKYOBPlrS
         FQ7HL3BwwiALLD/ouNu1D4dN3z20VGoQ6mjoZ7+Mp/FJRwSMUyXJ6BNJVCwXP9D+wt1Y
         Sf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202704; x=1795807504;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/RuK77T8Pc2yA26RkCicA7q1V6UBHbE6inBIYLOkP8Y=;
        b=vLkN+l8vXBrhgCqZgvKI8bNxZfTVIihnTe5HFg4vwkxxdlorx0DOw19pgdhWIQZswX
         wQwh70l67DWuPj9ANwXU+FLSAsZtABUC5HBlGQknYCuMdj5c3C5bQGEu+N2Y+OyZcx4U
         dMmRB+sF0tW4RO1jhLdoHLDy9mevjccTFknhA1l1jzWxrMsAYnVM4X2TWy+7x4g+zgvR
         MjaD+9qIkALLesFR/34OdzSI2KHEc/ShGEcCwNlQWpIwp6U/x+hzzZvfMSK/Zm+LcUC9
         peZmxxlTXvd4P8SpALxkN32SZapH2yJZwg0PvB1CzjQoUjMn/t6huGZ6aL19pwKSqMbC
         BN/A==
X-Forwarded-Encrypted: i=1; AL+hErG5u52hG+WdD243g4zlye+qQCJ22EzOTmOEfwv29zq1sHU50EsfVITujVLNjAEXD369sWQoMA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/99PVEv3Ha6zP1wE8GPWZZkylC0cVmkLK8mye/lyKpWTXcA5be
	iqsuU4gCvKxmWFviLGeVuGqEJbhNZFbiL8ujxdsjFmJ6mEl4J8ypngUMK8QtKoy5ag==
X-Gm-Gg: AZFdTZf5VSbAe9DuGJ/RZ/NvkPxILmZLxAgpcYykh9dlwp4qyGbu+gq5LbozfkDSUpS
	r3xeHoOqNtgM+qT12f+l4G4WmI2Ljkh23V91xTXOeDkWu3U+QBCCw7BVJFRkeq4J8I6THakDn5S
	/e/rDscxuYDN6IbElPyGDSwO1oDk1q5G7Ljlyx4PjfJ99uWOJf9mD76Lf5opRHCHCG9yoHXCEjG
	m0YFLz4LICnkjLrKNWRRKcjeR5utVAX0YJYlwNhKsG/my9af7pOhOaM3rgpUohJ8t3/QefVUDs8
	WaLe5N/dSc22eLAH1BUuV3uLlv7BibCzC6V3BD+KF1uzX+PhMkUuAEN0/IRsWpBN0f9bbMLPU6I
	eKVRwE7i1XwtpFmjbXFHn4X1jkn86uA6lV8x9u35pKe7PD+V+05k3gEmO7vQctJ9MMaLplRLNzG
	dk96+8l9caaCuXw4FKBUZ9JX6GBAWYtxZ8nReU9SV3itA4yyTUInoVHBGJ1VqEGRPD/eVq3d3O1
	cyYfKWjLmgpkMC8OaLxq/R1eO1GhcIcYn8JARo72cousL3kI+ctqoD6GAO3mk2VMN6xddoB8qn8
	R6HEs6QWPF3jyiIx9ek1W4W5v6HRrkcvxiBpRT+KI5jrGMr0ujpsxz6FxUUJzqJoWQ==
X-Received: by 2002:a05:6a00:f8e:b0:89f:d620:232 with SMTP id d2e1a72fcca58-8c87c864543mr3577508b3a.35.1795202703993;
        Fri, 20 Nov 2026 11:25:03 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343f83dsm1923249b3a.39.2026.11.20.11.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:25:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 11:25:01 -0800
Message-Id: <DN0A8VWPLTYF.3Q0MIEDWLJYN4@google.com>
Subject: Re: [PATCH v11 10/13] PCI: liveupdate: Adopt ARI Forwarding Enable
 on preserved bridges
From: "David Matlack" <dmatlack@google.com>
To: <sashiko-reviews@lists.linux.dev>, "David Matlack"
 <dmatlack@google.com>, <kexec@lists.infradead.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf"
 <graf@amazon.com>, "Alex Williamson" <alex@shazbot.org>, "Alex Williamson"
 <alex.williamson@nvidia.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Down" <chris@chrisdown.name>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan"
 <jacob.pan@linux.microsoft.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Josh Hilke" <jrhilke@google.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava"
 <praan@google.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Vipin Sharma" <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Yi
 Liu" <yi.l.liu@intel.com>
X-Mailer: aerc 0.21.0
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-11-dmatlack@google.com>
 <sashiko-outbox-224145@kernel.org>
In-Reply-To: <sashiko-outbox-224145@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_112506_351093_34B00847 
X-CRM114-Status: GOOD (  25.71  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 19, 2026 at 2:38 PM PST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] PCI: liveupdate: stale ARI state in pci_configure_ari() with
>   pci=3Dnoari
> --
>
> commit ee2b5e1cebde3231a1c9acaaf68c272dbf3c6e8e
> Author: David Matlack <dmatlack@google.com>
>
> PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
>
> This commit adopts the ARI Forwarding Enable bit from hardware on
> incoming-preserved bridges during a Live Update, even when pci=3Dnoari is
> passed on the kernel command line.
>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index ebc565b4780a1..b5b578355a1b6 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3748,7 +3748,7 @@ void pci_configure_ari(struct pci_dev *dev)
>>  	u32 cap;
>>  	struct pci_dev *bridge;
>> =20
>> -	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
>> +	if (!pci_is_pcie(dev) || dev->devfn)
>>  		return;
>> =20
>>  	bridge =3D dev->bus->self;
>> @@ -3759,6 +3759,12 @@ void pci_configure_ari(struct pci_dev *dev)
>>  	if (!(cap & PCI_EXP_DEVCAP2_ARI))
>>  		return;
>> =20
>> +	if (!pci_liveupdate_adopt_ari(bridge))
>> +		return;
>> +
>> +	if (pcie_ari_disabled)
>> +		return;
>> +
>>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
>>  		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
>>  					 PCI_EXP_DEVCTL2_ARI);
>
> [Severity: Medium]
> Does returning early on pcie_ari_disabled leave PCI_EXP_DEVCTL2_ARI and
> bridge->ari_enabled set to 1 if a new device is hot-plugged after the
> preserved devices below the bridge have finished Live Update?
>
> When booting with pci=3Dnoari, pci_liveupdate_adopt_ari() sets
> bridge->ari_enabled =3D 1 while bridge->liveupdate.incoming is set.  Once
> the preserved devices finish Live Update and bridge->liveupdate.incoming
> is cleared, hot-plugging or rescanning a non-ARI multi-function device
> below the bridge causes pci_liveupdate_adopt_ari() to return -EINVAL and
> pci_configure_ari() to return at pcie_ari_disabled without reaching the
> else branch that clears PCI_EXP_DEVCTL2_ARI and bridge->ari_enabled.
> Because bridge->ari_enabled stays 1, next_fn() calls next_ari_fn(), which
> returns -ENODEV and skips enumerating functions 1..7 on the new device.
>
> Checking !pcie_ari_disabled alongside pci_find_ext_capability(dev,
> PCI_EXT_CAP_ID_ARI) instead of returning early would allow the else branc=
h
> to clear PCI_EXP_DEVCTL2_ARI and bridge->ari_enabled.

Yes, but only in a very narrow case: the next kernel is booted with
pci=3Dnoari, the previous kernel enabled ARI Forwarding on a bridge above
a preserved device, the preserved devices below that bridge finish, and
then a _different_ multi-function device without ARI is hot-plugged below
the same bridge. The only impact is that functions 1-7 of the
hot-plugged device are not enumerated. There is no corruption or crash.

I don't think this is worth changing more PCI core code in
pci_configure_ari() for in this series. It can be addressed in a future
patch if someone really wants to do that.

The comment in pci_liveupdate_adopt_ari() can be improved though, since
it claims ARI Forwarding Enable is always recomputed after the preserved
devices finish. I will update it in v12 to document the pci=3Dnoari
behavior:

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 493576119a76..7582b87df3ad 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -937,9 +937,14 @@ int pci_liveupdate_adopt_ari(struct pci_dev *dev)
=20
 	/*
 	 * Unlike ACS, only adopt ARI while the bridge is incoming-preserved.
-	 * Once all devices below the bridge have finished, recomputing ARI
-	 * Forwarding Enable yields the same result for the same device, and
-	 * must be allowed to change if a different device is hot-plugged.
+	 * Once all devices below the bridge have finished, pci_configure_ari()
+	 * configures ARI Forwarding Enable as usual the next time a device is
+	 * added below the bridge, e.g. if a different device is hot-plugged.
+	 *
+	 * The exception is pci=3Dnoari, where pci_configure_ari() does not touch
+	 * the bridge, so the adopted ARI Forwarding Enable persists after the
+	 * preserved devices finish, even if a device without ARI is later
+	 * hot-plugged below the bridge.
 	 */
 	if (!dev->liveupdate.incoming)
 		return -EINVAL;

