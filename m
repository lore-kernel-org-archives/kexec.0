Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20A4606A32F
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FINdzM5H;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dRaCdBbb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9qaZQMzb7DXoF7l3soDYlbhGMbKj+MV76UM39vsbcMY=; b=FINdzM5H+hRvEY
	DhmT5hO2beAX9lZKsU1mopoCKwE1TK+m8MTeRnfecbZtNb6uHc9PEIeO+FEq8oZxqHeRAKocqa7A6
	m49S1vHx1/CX1eks+6d2afgcmY+JrxSgAr1qQtmiKqQ8XiLF1DKQZsssao+6QCM2OKDC0Vuv7ow1b
	Wj7lToTx19UmPT4Dvzl3MdMrFU3mJY79LYYE0wZgVmH4ZKgo7YtmavHy70agCiX2wXO4EC10tCBRW
	5JOEnNw5NChITQWkYHQkV9hVyWIetJAyoZkud2coCnERL8lVqeX2sCwUhimDEPm4ekDqDsr605E+M
	bQpG6xVGvwyC5bJu65Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPOYN-0000000DO9K-2Zme;
	Fri, 06 Nov 2026 18:20:43 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPOYL-0000000DO8m-08iC
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 18:20:42 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-8a594d313a3so527403b3a.1
        for <kexec@lists.infradead.org>; Fri, 06 Nov 2026 10:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793989240; x=1794594040; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9qaZQMzb7DXoF7l3soDYlbhGMbKj+MV76UM39vsbcMY=;
        b=dRaCdBbbZUWMuA5bu7KBAldpX8Gk98On1HISVg+qfb7xAzlhxyZsw3ILZ0j20kcLQP
         EaTD2lMzQu8bepDX1SI25PKUuVvmjLaJpUiSpJhKCTm4flMsVg0EA1DsqT3BWDSHoYuL
         DwWolKAf5fGwvHSGkIuyDdLHDt24IzNnn8+tfo1dszYIwOdVWSLr7mSnyrqhakaqlhsj
         f5nKJs+4bK0te50iukqd6l3B6JqN4kfyeiqOV8pkXMe4PsIXN5RUq+syPfcybnWm+C7N
         tBQFjsdI98XG2Ini5a8myXpL5+eAfLivWvKwTXPJiuNeESbPHbhBzQAUrBAMXxz5M8fm
         jZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989240; x=1794594040;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9qaZQMzb7DXoF7l3soDYlbhGMbKj+MV76UM39vsbcMY=;
        b=SPPsJeWnKYoSW4VlkRCrhWlT+LlTaGpCuJJyUsrHgWMOPDB4jDsTnqXZ2UOZiiIjeR
         HiX+oc2JDnmZ5iz+ncST2jDF/Q72N01yjNN21f29NyjC2456FFYYsAESzQzwA0zac3HZ
         SrDZeOCUTX8pcInZfdK+Zf+GTaPD23DqdiczmVYRysSmRVcj101K4EtJBg4iz5oqN6rH
         ypgMI4a4g/lIUSyZFUfp9Ada1fgPu98GYz8wG5KEzOL9g9axEWrsC3hZxVpgXElhZre+
         nyXtJVY9587L41yacQvDVMcg4htIF4qfi5GGLyAmuSJSV9Dhp28oDhsaFKdJ9cn7zE3N
         hF2g==
X-Gm-Message-State: APuU4Z/gS89/juQQUv/1d26ozrW5YGDDm9OeKTLsE0dle7ItATZNpGtL
	UeJthK9DeeMnoOSchngcX98eydO9SkoViqWO36MtjeUWEGCd3v0QkiHf6cBcGX5nKw==
X-Gm-Gg: AYBFou3kx2e5iaS3eJUzm+9VGj1uC57rzKKR+TOHPam0u4aHTbgrwCKxtOexDCW0yNC
	LGUBx5s09Y0fzkrpbx6TvAhJVwfJH/DrPwd64Gnr7MhUvYEN7pXglHlH+P9mFrVGtymJcrzw1HT
	aoLeRuywFz/xnodb7ecJ43QNcBn5I4H99sCjbljQpstQEv+/WTQIYoZn2C/Q/DvkUt/A67Hp0dW
	QkW1ZFZSF7b7rEAM4GlyM6wsaKoGCwqus2FMGwq+K9m3sUdRRD+fu5bzdk9Ddy67ktPYJ1skEQR
	wyAPi8u2Z7uq+bystGS5fWF0mWzGpNRvLLD3HW0nuSBZmpnOZAtW/OXw8GTJvGbfIYaODLOb2Au
	/906T1NaO97q6oHHf8GxZtwl20jjiQMY/RpVQRfmDSCcBbLdUQrA2kIGYdt6vwGX7PUQI1KqbOJ
	gIqX1V1clDJ7nApondl8SELTQ0oVCE4jyXk9MuDcSAL+6jfAzHlrETP7JzlNL15iWNqP8dBvv5v
	sW5un+B4oxYuMZvQkt1U9HrEB3Tt1gcRXzCSZZkF6ExUTqsfqnEfGNfPmGaT+sDwODTs95UMGzP
	FJnlwKVosuOvefXpXF6vbIkF0hJkbRtToMGLIh5grSk9vc98prgH4TWsWb1CaQ1K
X-Received: by 2002:a05:6a00:2188:b0:8a0:3483:51ec with SMTP id d2e1a72fcca58-8b37cdfd31bmr3344310b3a.58.1793989239208;
        Fri, 06 Nov 2026 10:20:39 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b359128352sm848989b3a.13.2026.11.06.10.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 10:20:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 18:20:36 +0000
Message-Id: <DMOC3XV68W0K.3FGK4UZ87838R@google.com>
Cc: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>, "Adithya Jayachandran"
 <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Chris Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>,
 "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason Gunthorpe"
 <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh Hilke"
 <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas Wunner"
 <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit"
 <parav@nvidia.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pranjal
 Shrivastava" <praan@google.com>, "Pratyush Yadav" <pratyush@kernel.org>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Saeed Mahameed"
 <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>,
 "William Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 05/13] PCI: liveupdate: Auto-preserve upstream
 bridges across Live Update
From: "David Matlack" <dmatlack@google.com>
To: "Bjorn Helgaas" <helgaas@kernel.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261013162529.1928093-6-dmatlack@google.com>
 <20261106173427.GA1633106@bhelgaas>
In-Reply-To: <20261106173427.GA1633106@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_102041_076919_38F11871 
X-CRM114-Status: GOOD (  26.51  )
X-Spam-Score: -14.3 (--------------)
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

On Fri Nov 6, 2026 at 5:34 PM UTC, Bjorn Helgaas wrote:
> On Tue, Oct 13, 2026 at 04:25:21PM +0000, David Matlack wrote:
>>  static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outg=
oing,
>>  					  struct pci_dev *dev)
>>  {
>> -	struct pci_dev_ser *dev_ser;
>> -
>>  	if (dev->is_virtfn) {
>>  		pci_warn(dev, "Cannot preserve Virtual Functions\n");
>>  		return -EINVAL;
>>  	}
>> =20
>> -	if (dev->liveupdate.outgoing) {
>> +	/*
>> +	 * Endpoint devices should not be preserved more than once.
>> +	 * Bridges are preserved once for every downstream device that
>> +	 * is preserved.
>> +	 */
>> +	if (dev->liveupdate.outgoing && !dev->subordinate) {
>>  		pci_warn(dev, "Device is already preserved\n");
>>  		return -EBUSY;
>>  	}
>> =20
>> -	if (!pci_is_root_bus(dev->bus)) {
>> -		pci_warn(dev, "Cannot preserve devices behind bridges\n");
>> +	if (dev->liveupdate.outgoing && !dev->liveupdate.outgoing->refcount) {
>> +		pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
>>  		return -EINVAL;
>>  	}
>> =20
>> -	dev_ser =3D pci_flb_alloc_dev_ser(outgoing);
>> -	if (IS_ERR(dev_ser))
>> -		return PTR_ERR(dev_ser);
>> +	if (!dev->liveupdate.outgoing) {
>> +		struct pci_dev_ser *dev_ser;
>> =20
>> -	pci_info(dev, "Device will be preserved across next Live Update\n");
>> -	outgoing->ser->nr_devices++;
>> -	outgoing->ser->devices =3D kho_block_set_head_pa(&outgoing->block_set)=
;
>> +		dev_ser =3D pci_flb_alloc_dev_ser(outgoing);
>> +		if (IS_ERR(dev_ser))
>> +			return PTR_ERR(dev_ser);
>> =20
>> -	dev_ser->domain =3D pci_domain_nr(dev->bus);
>> -	dev_ser->bdf =3D pci_dev_id(dev);
>> -	dev_ser->refcount++;
>> +		pci_info(dev, "Device will be preserved across next Live Update\n");
>> +		outgoing->ser->nr_devices++;
>
> This looks a little funny because prior to this patch, nr_devices was
> always incremented in pci_liveupdate_preserve_device() and always
> decremented in pci_liveupdate_unpreserve_device().  Now it's only
> incremented once (per device) in pci_liveupdate_preserve_device(), so
> it looks unbalanced.
>
> My guess is this is because previously we didn't expect to preserve
> bridges at all, and now pci_liveupdate_preserve_device() might be
> called several times for a bridge, and it's all just fine, but it's a
> little subtle.

Right. nr_devices counts struct pci_dev_ser entries that are in use, so
it goes up when a device's refcount goes from 0 to 1 (the entry is
allocated) and down when it goes from 1 to 0 (the entry is released).
For endpoints that is every preserve/unpreserve call, but a bridge is
preserved once per preserved device below it, so most calls for a
bridge only change its refcount.

> I suppose the "(dev->liveupdate.outgoing && !dev->subordinate)" test
> above is what allows us to just increment refcount each time a bridge
> is preserved.  And the test around pci_flb_alloc_dev_ser() is doing
> basically the same thing.  I wonder if there's a way to connect them
> more explicitly.

Agreed, both points come from the same thing being spread out. I think
both can be fixed by splitting pci_liveupdate_preserve_device() into
"already preserved" and "first preservation" cases, and moving the
nr_devices accounting into helpers that allocate and release the
struct pci_dev_ser, so it is visibly paired:

	if (dev_ser) {
		/*
		 * Endpoints can only be preserved once. Bridges are
		 * preserved once for every preserved device below them.
		 */
		if (!dev->subordinate) {
			pci_warn(dev, "Device is already preserved\n");
			return -EBUSY;
		}
		...
	} else {
		dev_ser =3D pci_liveupdate_alloc_dev_ser(outgoing, dev);
		if (IS_ERR(dev_ser))
			return PTR_ERR(dev_ser);
	}

	dev_ser->refcount++;

with pci_liveupdate_unpreserve_device() calling a matching
pci_liveupdate_free_dev_ser() when the refcount drops to 0.

The helpers would only manage the entry and nr_devices, not the
refcount, so there would still be a single refcount++ shared by both
paths, as you asked for in v8.

Since the series is already in liveupdate.git, I'll send that as a
follow-up patch on top of lu-pci-preservation. If you are ok with that,
then an R-b or A-b tag on this patch would still be needed.

Otherwise, happy to send a v11.

Thanks for the review!

