Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE57C606A32A
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Lq2LaarW;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XOZR6QIA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Ays1EfzTLcRjTY+4yI71x15YxEo2laYpKiSTCWHUOoo=; b=Lq2LaarWuePHMy
	Zyj3xsGbRQhhA+4i00m1s0AdUj3x/Wvr5AhOeAywXDwoY41/0G5K3wzGtwqeQM1jqtT1tQJw+GVom
	KQiKXWeYoi0lLGIc1sQ6EVRQ4nrXmEw9CfXOjIFZUFdEidNdjYxOZ8aFRlqxNBge5xBAR+ic1mTea
	ybY5zhAW5n+3c01Fi8SXuMuYYvpKwfDJOxbIhQ2PRvz1QxLdP8fCFpuhxilWgNYL9F1yh4yHL2U+9
	bTUWcrOXhr14z7Rpo9eLkxPfigBlFe3+A4VrmMgrJxiBasbh/ssYtzfBmjvSIxfLdkJzDqFJwRF3M
	YcOUEsHdcsbo4zUli4/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTQXZ-000000076SL-1IlN;
	Tue, 17 Nov 2026 21:16:33 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTQXR-000000076Rt-2odM
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 21:16:27 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2e977109392so1601295ad.0
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 13:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794950184; x=1795554984; darn=lists.infradead.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ays1EfzTLcRjTY+4yI71x15YxEo2laYpKiSTCWHUOoo=;
        b=XOZR6QIAcuXFNX3BkN/aCzeMRBvYKW//eUNvijx+jHF5W9OQ11zaadg8FymIRZaXwl
         ueY/gHnnwvrdEkzVGZggreKMFv68c83quPuV42+yBtwoUkv2PbuecaKUB/m0E0T+kacW
         ygTUga5x92Q4RFFBhwS8FJYUNCizV3QWO1JzbijW0ExiZ4D+D4ZtxspnpVJsbpMW4I75
         ErOAXIutP2Cwf+IIdN+fmFAEhNKjHk6lgGPFlvvWmL4D5sHOj5PVzxolaLbdEBI+tPtD
         /5z/cnGygdjkEBdiaPtcsCpywrVmMhdtY03ph6Cvotuv6ugBBbZfTvpsmzit3menC/8A
         7UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794950184; x=1795554984;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ays1EfzTLcRjTY+4yI71x15YxEo2laYpKiSTCWHUOoo=;
        b=KstjbgIOl1HYwdZ/wClDuEkuXpn/IP9gyjv+ZUcl01YQbI2G+W1+1Amu5d2yUyFTQh
         CUc+Px670H6tbUx532VZK4uNm7yIjVCqQfFEZNxtBvv5KPnGsBTOdNEuCJRnmHHnfzvP
         rEUKdvjt9XwWbX5WXtMX0uX4OFVIQaz8kAi4EfOilGTs1j2WxyAD0OsNKOBBvU72nR5P
         nhS58ftQG5Qrl/iCx//nGcePbFSVXMZ98lYruMUt8J8qlmkzcv+f/eNhAenvdzEAJLxh
         sqKju37owiC48Hw6D0GN8Yq8TGT5bXE9EhTiyjbh3gHqAEH0+UjgcirFyZiJysLDCh9k
         iurA==
X-Gm-Message-State: APuU4Z9Qw/jn63ATI1VS49KVnpmyFBlpMdhmzmGc/Ds6F3qVB0ECz3TA
	S+sk0Oo3JHzQ37ldqQGroInVn/Ol8ZTgqVbB3FB0nRwmglpmpFsIFDn9+wSoH066eKcf1vIAJng
	cZykKVHzd
X-Gm-Gg: AZFdTZe4ssoQSrlfICCQsi8aZcjGY/gEXkh8ApOwA9S1rnz2RwlNIGNYDH+HMe+rw7L
	CrkYywMQFm7fUp+ndpqA0YngXCDMtlFqmWf8K2RPo2mm1XZ9Kj12O/vnwGN7lraHnF/AjwwMDRV
	upcAtSM8VASv7Dbhg0cBwhppo+Te79wYRQsEsRjfwCHX8fDcQEmKLKrTKdl3V3QaQB+eMrOkC5j
	XLvI1XZlsJIcvqiB6RyuR3iUGXbtwrf7B2Eh7OA/bmcWxKdmPS8bvMXrFq7y5UmeKu9DtNoeRYB
	Eq1RplNRMvkFdxNWaSwt5jKvAkaIcvti6nAKN4eKxpfoKlssqTGufT+98DpwntqIlEFTwqGnZDa
	9Uet8aU8k+ug3GQWSOZ9bWq/7pNJf5x1n/VcGWKoa+XW/nK7LLpbYVx2vHj0knUMSz/Akjw5IIC
	X9WNPtv5pJQNmOlOaoRTUv67JtLdQjOfPAbY8o+R63Fhl6dwFnWUOaVqR/vOaDGu5awnqMjKRZn
	L50D1Hgtlk6YHNSQ3VSnGia/JCUgCj9wLfqsRZjWq9VoXRA1V1/T/fsc/TlvzT4e8YH+x3LIvrJ
	vjCbFXxrBFWZtJ6oDUNuUUAP1FvVM/4zq5VpybCO49tKnVXb1AXMMboTGisbu9JQ/POXMI5geqc
	RKuF3kKpNOg==
X-Received: by 2002:a17:902:f790:b0:2e9:460e:ca57 with SMTP id d9443c01a7336-2eff7529757mr5030915ad.15.1794950183338;
        Tue, 17 Nov 2026 13:16:23 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff61841aasm2714705ad.34.2026.11.17.13.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 13:16:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 13:16:21 -0800
Message-Id: <DMXSQHZG5L27.2NIIT7F6FW0ME@google.com>
To: "Alex Williamson" <alex@shazbot.org>, "David Matlack"
 <dmatlack@google.com>
Cc: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>, "Adithya Jayachandran"
 <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Li" <chrisl@kernel.org>, "David
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
Subject: Re: [PATCH v10 09/13] PCI: liveupdate: Adopt ACS controls in
 incoming preserved devices
From: "David Matlack" <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-10-dmatlack@google.com>
 <20261116170942.720b06fd@shazbot.org>
In-Reply-To: <20261116170942.720b06fd@shazbot.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_131625_744046_AE3E0118 
X-CRM114-Status: GOOD (  24.85  )
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 16, 2026 at 5:09 PM PST, Alex Williamson wrote:
> On Tue, 13 Oct 2026 16:25:25 +0000
> David Matlack <dmatlack@google.com> wrote:
>> +int pci_liveupdate_adopt_acs(struct pci_dev *dev)
>> +{
>> +	/*
>> +	 * Check if the device was preserved over a previous Live Update (even
>> +	 * if it has already gone through pci_liveupdate_finish()). This ensur=
es
>> +	 * that the device continues to use the ACS controls established by th=
e
>> +	 * previous kernel.
>> +	 */
>> +	if (!dev->liveupdate.was_incoming)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * The previous kernel should not have preserved any devices that
>> +	 * require device-specific quirks to enable ACS, but if such a device =
is
>> +	 * detected (e.g. new device-specific ACS quirk in the current kernel)=
,
>> +	 * log a big warning and fall back to the normal enable ACS path.
>> +	 */
>> +	if (pci_need_dev_specific_enable_acs(dev)) {
>> +		pci_warn(dev, "Device-specific quirk required to enable ACS!\n");
>> +		WARN_ON_ONCE(true);
>> +		return -EINVAL;
>> +	}
>
> This looks pretty unsafe and the comment is only explaining how we
> might get here, not why we shouldn't panic.  IIUC, the IOMMU lho
> support requires singleton groups, but I'm not sure what it does if a
> group becomes non-singleton in the new kernel (such as via a new quirk).
>
> Is a warning related to what might be a parent bridge rather than the
> endpoint device, really sufficient here?  Thanks,

It's not necessarily safe. The new quirk could change how TLPs are being
routed while a downstream preserved device is still sending memory
transactions.

I think a better approach would be for a preserved device to always
adopt the ACS controls left by the previous kernel, and keep them
across resets through the ACS save state. So a new device-specific quirk
for the device is ignored, apart from logging a warning. IOW, new ACS
quirks only take effect on cold boot.

If a preserved device has an ACS capability but no save state (i.e. the
allocation failed), then we can panic, since its adopted controls would
be lost by the first reset..

Roughly:

	int pci_liveupdate_adopt_acs(struct pci_dev *dev)
	{
		if (!dev->liveupdate.was_incoming)
			return -EINVAL;

		if (pci_need_dev_specific_enable_acs(dev))
			pci_warn(dev, "Ignoring ACS quirk, adopting ACS controls from previous k=
ernel\n");

		if (dev->acs_cap && !pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS))
			panic("%s: No ACS save state for preserved device\n",
			      pci_name(dev));

		return 0;
	}

The panic would only happen if allocating the save state fails. Ideally
I'd like save state allocation failures to cause the whole device setup
to fail. That's something I'm hoping to do in the future on top of the
pci_save_state rework [1], and then we can remove this panic. Until
then, the panic is constrained to Live Update, and the allocation
shouldn't fail in practice.

As for IOMMU groups: Sami's IOMMU Live Update series refuses to let any
device join a group that contains a preserved device, in both the
outgoing and incoming kernel (__iommu_probe_device() fails with -EBUSY)
[2][3]. So if the new kernel considers the path less isolated than the
previous kernel did, e.g. because of a new quirk, the group grows and
the IOMMU core refuses the second device rather than putting both in
one group. The system comes up with that device unavailable, which can
be debugged and recovered by rebooting, instead of panicking.

[1] https://lore.kernel.org/linux-pci/20261106004218.604799-1-dmatlack@goog=
le.com/
[2] https://lore.kernel.org/linux-iommu/20261110040828.1774343-6-skhawaja@g=
oogle.com/
[3] https://lore.kernel.org/linux-iommu/20261110040828.1774343-13-skhawaja@=
google.com/

Does that sound reasonable?

