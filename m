Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CB5C982DD
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IdDvdVBUP9dI0We8t/DLRSXpGyJGcqmjaxTczi9FQIk=; b=juueMG/OVHSLg9aSQA0OtsPKsO
	ruQ6NUmPGlt7lsHrn1gd63EvwQdKEyHRvepIyEum3Cfziv62Upgbfhv7Cs4jT6uylKfus1BYoiht8
	fPQnQoflxv193SN+zInwbyfDM+CPM3mWHeoEYKA3Y0TWXYRAFdPL0wD8O/7OS4TWB1hzYz0UDV7IX
	j3H0SPDokjZmbI/sUEd1g/6yhPI6Bk/Heyd8vFDmF2gX8JE2HgMQ+6erMDTEp+JPUJB97bOP4cC+2
	p7lSGf+2U68/fiWZDRHCKj4cfpkX8wAS8oK5E136g/SFAEUHBPqzAY9bQ5bwbQcUiwbEurZBTEK1U
	fZk1Fsgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7exi-0000000FUZV-03b1;
	Fri, 18 Sep 2026 20:13:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7exg-0000000FUZI-1kCb
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:13:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2DFC6404EB;
	Fri, 18 Sep 2026 20:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56931F00898;
	Fri, 18 Sep 2026 20:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762412;
	bh=IdDvdVBUP9dI0We8t/DLRSXpGyJGcqmjaxTczi9FQIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mAw5UlvuSYKxbaxLCoAdn3B+ntHZiwR/3D2Ji+Fn0ZYKJwHYM8ZnlI2lT9lc6eb7A
	 JjVJDX7cv5qlgm8kMuylieYao30s6Af5TxWMQiJEToD9w/W8doPLT49tEFpV5faalO
	 e4dd4qJ/t0EnNhNTBjNF7Z7pkYdEurfIwnCwwR1jh/5z1uu5TJiV6qV2CDbJtowFRi
	 y4OCFgD/LrEhJJBx7yNMbEypfKALMLRBMdGc30aUkMmy+IZSKcFV14ouvIQE6Xn0cM
	 D5TpUnHhBJeSt1EhOMj9QrfXH2NLa+MBO+9DwxRHNR0liwtuGRHjPBQq/FYnwYAxIh
	 nxHv56C4VlqWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/13] PCI: Refactor matching logic for
 pci_dev_acs_ops
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, "David Matlack" <dmatlack@google.com>, linux-mm@kvack.org
Cc: kexec@lists.infradead.org, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Parav
 Pandit" <parav@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, "Randy Dunlap" <rdunlap@infradead.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Alex Williamson" <alex@shazbot.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Pranjal Shrivastava" <praan@google.com>, "Alexander
 Graf" <graf@amazon.com>, "Josh Hilke" <jrhilke@google.com>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Vipin
 Sharma" <vipinsh@google.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, linux-pci@vger.kernel.org, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20260918200640.887030-8-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-8-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:13:30 +0000
Message-Id: <20260918201330.A56931F00898@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> the device matching loop into its own routine, pci_dev_acs_ops_get().
> This eliminates duplicate code between pci_dev_specific_enable_acs() and
> pci_dev_specific_disable_acs_redir(), and will also be used in a
> subsequent commit to check if a device requires device-specific
> enable_acs() during a Live Update.
>=20
> No functional change intended.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D7


