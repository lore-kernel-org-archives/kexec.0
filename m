Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8830FC98302
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 04:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H8Sw7e86frpTB8DGnAC8KcCkQBMEmIhrJF2hdj56sGo=; b=IeJnTMErpu8NfvVrn2h1zlD43b
	q6M0cYjeCIyyUgzxcDg4/umufYq/OVpco4PjNnTCp5LL97F4X4rU0ybyC+OkfUvDXhNeBqeEHYKAK
	l0h5+q28rXUmly+ZXY8oydJ8dJ2UTyhrQjyBtMD/VAZqZBhCgm2JslbsLlcTvSjBzODRskRvMlbfE
	NCWS8LQfTFNbWrDcJaxTo29IYJYMqHu25m+zk0MCkz1fEoOePV2VxdJz1xML0Lq0OV5+CNRPee3Rp
	/IpVk4XUHtTVolb0q2wRgU2y7kBZ0E4W4HXUeO51nE24hah1oWWstX9ARLom42ywrECLaYG7ISKkp
	IOWxNX5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8rz2-00000004AQv-3qbJ;
	Tue, 22 Sep 2026 04:19:56 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8rz1-00000004AQm-2DdV
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 04:19:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 21EEB40314;
	Tue, 22 Sep 2026 04:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA701F000FF;
	Tue, 22 Sep 2026 04:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790050795;
	bh=H8Sw7e86frpTB8DGnAC8KcCkQBMEmIhrJF2hdj56sGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ccTXWVkHEb+h1bpy7+9f6lh1K4PvvzccB9NYyOXwkAV54BzWnMLSXLt4k5p/oKlvM
	 nTF0unkDISFj1iCut6TIrk4f84DKJKCn2dyC3glr7l2m1BUmNMeVS8AsFnKzYf+gRO
	 5yBagAwduhM+38NYbYaYIvJKeRIi11XG4+zJnDJjdAuPxMp2ek8hWZMaUKpiQARG4q
	 Cu4KMlT96Z8NvbnmzGUw1KfNaqXAnAeEDhdRMVx68BzpfKjjUffMAC8nLP6d4mOM/r
	 0ylvEv9zRb37RPaO4/kNHR99RovesLc0nvE6pT/c0O6a6AGV2zgivh0tpF3StirQYc
	 AU0ee+eJmj2NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] kho: rename kho_scratch= commandline parameter
 to kho_bootmem=
To: "H. Peter Anvin" <hpa@zytor.com>, "Arnd Bergmann" <arnd@arndb.de>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Baoquan He" <baoquan.he@linux.dev>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Alexander
 Graf" <graf@amazon.com>, "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Rob Herring" <robh@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Saravana
 Kannan" <saravanak@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Jonathan Corbet" <corbet@lwn.net>, "Mike
 Rapoport" <rppt@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, x86@kernel.org, devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20260922041321.233986-5-pratyush@kernel.org>
References: <20260922041321.233986-1-pratyush@kernel.org>
 <20260922041321.233986-5-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:19:53 +0000
Message-Id: <20260922041953.CFA701F000FF@smtp.kernel.org>
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

> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>=20
> KHO now no longer uses "scratch" to describe the memory areas passed by
> previous kernel. Instead, it calls them boot memory, or bootmem in
> short. Rename the kho_scratch=3D commandline parameter to reflect this
> terminology change.
>=20
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922041321.2339=
86-1-pratyush@kernel.org?part=3D4


