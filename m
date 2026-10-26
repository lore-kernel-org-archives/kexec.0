Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C50606A31E
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=canq+PHO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n55tyCWt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vIns6gQotxrwW0RMGSZeRvTbNckDh4WjkgLqKGMbrpE=; b=canq+PHO673KNVKYTC7na+M2Td
	kpfNvUx8KCcyziunpdZEHlGAOHAepyIphPpPgSyDWXMTzVLwurWhBqy2Icg6tFniR3vjtPUmK922y
	wA9JOlj3qKa4wvuEEkIqU138b5DZJOUAuG9w9CCOvOEYwWwSx6/7e2l5MlrL7dPQVpQlXSVKSK9Af
	wpdovSuhCiyvfHuIW6QNkcmpWqQPmPbR5CrZdfO8Ctvnl0ho1fevLNOgciZ4rIwiUsT+dna0Geo1s
	xMAkkSL59wBj7bqCBMn1DbsEJhcUzRWA432iPrTIZDjOdOSBATfRsiKTIpv46tcrlUYzRRx/7/du6
	gcB9TNVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLOtU-000000031em-1Ydk;
	Mon, 26 Oct 2026 17:54:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLOtS-000000031cK-1z47
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 17:53:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DEA6F60A6B;
	Mon, 26 Oct 2026 17:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E011F01825;
	Mon, 26 Oct 2026 17:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793037237;
	bh=vIns6gQotxrwW0RMGSZeRvTbNckDh4WjkgLqKGMbrpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n55tyCWte8q3NOWMofsnLwfHCSxjEeXI6sI9cxoCtGeg8qXJP3rgbQzVXagXiuFZw
	 UwLKSlp426WdfRXmTlT/kZ7P09h0T6175x60FWUUeAH5aaOCKvcs81ssz7B9dB+6Hx
	 sjRricSdfIYeBqbH2Kwwm/x3VcYJjrZ/aPqrT0/PuumA0Y9nqSMJu/d1drzB29WLKb
	 V5nmLtyR8EbdM/akHRDuu1F/Q3OntQ/xSNn7J+LR4qQPjeHLEMjlmlSRiuBjMUfnPu
	 FjVOYy7wfy4qNijZj3hxUJnfEWJdBMEmxx9O7vb7Pqdv39P6kf7+sg1BMI7cBp406J
	 bAtHYyz4/axug==
Message-ID: <sashiko-outbox-185601@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 4/4] liveupdate: Add KUnit test for the feature
 header helpers
To: "Tarun Sahu" <tarunsahu@google.com>, loganodell@google.com, alex@shazbot.org, dwmw2@infradead.org, seanjc@google.com, "Mike
 Rapoport" <rppt@kernel.org>, will@kernel.org, pbonzini@redhat.com, jgg@nvidia.com, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, arnd@arndb.de, "Andrew Morton" <akpm@linux-foundation.org>, oupton@kernel.org, baolu.lu@linux.intel.com, "David
 Matlack" <dmatlack@google.com>, robin.murphy@arm.com, maz@kernel.org, "Alexander
 Graf" <graf@amazon.com>, joro@8bytes.org, "Bjorn Helgaas" <bhelgaas@google.com>, kevin.tian@intel.com, "Pratyush
 Yadav" <pratyush@kernel.org>
Cc: kexec@lists.infradead.org
In-Reply-To: <20261026174217.603114-5-tarunsahu@google.com>
References: <20261026174217.603114-1-tarunsahu@google.com>
 <20261026174217.603114-5-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 17:53:55 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Add a KUnit test suite in lib/tests/liveupdate_feature_kunit.c covering
> the Live Update feature header declared in include/linux/kho/abi/luo.h.
>=20
> The suite contains two focused test cases:
> - luo_ser_hdr_set_get_test: verifies DECLARE_LUO_SER_WRAP structure
>   sizing, header initialization, payload pointer resolution, and 2-bit
>   feature flag setting and retrieval across flags entry boundaries,
>   including out-of-range queries.
> - luo_ser_hdr_truth_table_test: verifies luo_ser_hdr_validate against
>   all rows of the feature state truth table (absent, optional,
>   required, and reserved 0b10 encodings), as well as empty supported
>   tables.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026174217.6031=
14-1-tarunsahu@google.com?part=3D4


