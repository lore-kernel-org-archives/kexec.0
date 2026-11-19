Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44614606A339
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Got9SxIr;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=GK3XiyZ3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5otj8LqXuoFRDCfkaEq/wgjl2OHeIJseXXzietozvC4=; b=Got9SxIrelCSiC
	UMjVHM+5cCMt9RS2V7aQKiJhDILEVGTHoZPJyklNnJLd+NemDO5Phap+lviInATTuNzU9VNEe+X6u
	QSsLWEsYmHljDX/G3SiO9T9YprYERTX4cj0viXv2sstkc2vVlZjs66lVnkHQ+MAU5q4U6jb1PHk7r
	LzHyi8IeLxMuKyUwO7i0cPOkO4zQUX84DVkXBn7xj5ETYI3pYL+zJfnUKnUonLV/szqW/W7ruR1yf
	u4WvPFgY1zDHRYI2sP1NOGP2Iud3GuMtT8iFCJGbyhNyH3W1USZ+e+LZYli6060OnwPk2lQF/DqZH
	0r8/snlHyIKON5QXonGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTyCq-0000000BMX3-06bD;
	Thu, 19 Nov 2026 09:13:24 +0000
Received: from canpmsgout01.his.huawei.com ([113.46.200.216])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTyCm-0000000BMVQ-3AkX
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 09:13:22 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5otj8LqXuoFRDCfkaEq/wgjl2OHeIJseXXzietozvC4=;
	b=GK3XiyZ3IW4xxvuorR9RNJih0Lpv7RqAAGTqcDKRnsRseb27i/YtNCZbqZfhHLNqYM+CxPvR/
	qGEFJzt9DKKgSirKs2IfFS8TygX4xkfzY6xKHTru62jgy0YeGvwtp+eOv1X1uOQ8Qt7fZfm+qYY
	KmvYI9xY/heD9XRwmsQvveA=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jVXmf1gGGz1T4Fp;
	Thu, 19 Nov 2026 17:12:34 +0800 (CST)
Received: from kwepemo200009.china.huawei.com (unknown [7.202.195.26])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C6C04057D;
	Thu, 19 Nov 2026 17:13:15 +0800 (CST)
Received: from [10.174.185.4] (10.174.185.4) by kwepemo200009.china.huawei.com
 (7.202.195.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 19 Nov
 2026 17:13:14 +0800
Message-ID: <4550c77f-aecd-4d6a-963f-fdaa2c243100@huawei.com>
Date: Thu, 19 Nov 2026 17:11:37 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] kho: drop the incoming sub-blob debugfs view
To: Mike Rapoport <rppt@kernel.org>
CC: <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<akpm@linux-foundation.org>, <graf@amazon.com>, <leitao@debian.org>,
	<corbet@lwn.net>, <rdunlap@infradead.org>, <linux-mm@kvack.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <hewenliang4@huawei.com>
References: <20261117092951.4017931-1-longwei27@huawei.com>
 <20261119063800.698863-1-longwei27@huawei.com>
 <179507678647.425130.13205346175314463200.b4-review@b4>
From: "longwei (I)" <longwei27@huawei.com>
In-Reply-To: <179507678647.425130.13205346175314463200.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo200009.china.huawei.com (7.202.195.26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_011320_981307_D18E135B 
X-CRM114-Status: GOOD (  10.01  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mike,

Thanks for the detailed explanation! I now understand why c609c144b0e8
is not the right Fixes target =E2=80=94 the pages weren't freed back then=
, so
there was no UAF. The kho_restore_free() path in d376e4b55c9a0 is what
actually made it reachable.

I will send v3 with the following changes:

- Fold patch 2 (documentation removal) into patch 1, so stable
  backports pick up both code and docs together
- Update Fixes tag to d376e4b55c9a0 ("liveupdate: centralize state
  management into struct luo_ser")

Best,
Long Wei

=E5=9C=A8 2026/11/19 16:26, Mike Rapoport =E5=86=99=E9=81=93:
> Hi,
>=20
> Please don't send vN+1 as a reply to vN.
>=20
>> kho/in/sub_fdts exposes the raw contents of the sub-blobs described by=

>> the incoming KHO FDT.  KHO does not own those pages: they belong to th=
e
>> producers' consumers and have independent lifetimes.  LUO, for example=
,
>> restores and frees its state in early_initcall, before kho_init()
>> (fs_initcall) creates the debugfs view, so the blobs point at pages th=
at
>> are already back in the buddy allocator.  Reading them triggers a KASA=
N
>> use-after-free in _copy_to_user().
>>
>> The same information is already available to user space from in/fdt,
>> which KHO does own and which stays reserved.  Drop the directory rathe=
r
>> than adding another interface to describe it, keeping the -rc fix smal=
l.
>>
>> Patch 1 removes the interface, patch 2 drops its documentation.
>=20
> Patch 2 is only four lines of documentation for the interface patch 1
> removes. It could be folded into patch 1 so that a stable backport
> removes the documentation together with the code.
>=20


