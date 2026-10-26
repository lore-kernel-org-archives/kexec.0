Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7E606A31E
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DcwYwOFM;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7XCOgXK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Nenbtg7RecnAjtwj7EyPmRobeXQxMITJx26NXIoTwv8=; b=DcwYwOFMmnx9A0PRymi5QA8nFU
	2lsNdJX8yzYtM77ddfGzpH2NqDF67UFBE7TTteOqhn+L6w8wT3gZ91u3IqedIptdRdWy1F57p/9k8
	h3Brb5KgPJ7CsOkUoLc+5CZdI+qhAqot9p/JhyKxj1F00NSvNTWHcAnzc8pRoyuTZ1aNKObKdtsiI
	5Zw3PO5q//cdNNDCHtzU3JBPyDlNaGEV9pW3Q0kvLrU8dMPdOzeZlGVPcUCNreP9LuFyP7N8PVuuU
	v9/18593FnGgLyyLqCFLfHfM69QIc7Fo4Sf0mQBSA6VjMLf/hlB3QwXLavsTR24FHb2ioRmONv9KD
	2Ni+6ZPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLINv-00000002J1h-0dxK;
	Mon, 26 Oct 2026 10:56:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLINt-00000002J1H-2kvM
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 10:56:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C0A08600CB;
	Mon, 26 Oct 2026 10:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFA91F01825;
	Mon, 26 Oct 2026 10:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012216;
	bh=Nenbtg7RecnAjtwj7EyPmRobeXQxMITJx26NXIoTwv8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=l7XCOgXKvAT/4OWM8KH6xFbGi/gV4LKUDNDDop+DBOe9a6Um0X3SuWVN4AJMgGWXk
	 C2vjVewT4715XRhbx354xQT2zZJ7LBMxf6ythaMccVlkFM5ItXhZq2ljn/Pq2psBJo
	 /3X4kHOTFHEaeCxHzXmPhmg7EZ1lkf5QACrdzvM9HfxciNOqFKbOFP+RhI4SPQUySJ
	 2auOlDssDJMZpzlniU3iH5LKk1atqpyAl1TZFJPrwE0z382Ru2HPM4EwHYjExZsiTm
	 HBRj63vXB3yCNqrianUG1SO9CNDHP4F5Tj/qEG1mw8B9WB2DlXw1z9qSR54aBXSSKj
	 UHW5zKaw+cSPA==
Message-ID: <sashiko-outbox-185028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/15] kexec: Add kexec_load_other_segments() helper
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, vishal.l.verma@intel.co
 m, piliu@redhat.com, jbouron@amazon.com, mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-13-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-13-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:56:53 +0000
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> arm64, LoongArch and RISC-V duplicate the elf core header and initrd
> loading.  Move it into a common helper with one arch hook for the boot
> parameters; a failure releases everything added for the attempt.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026075201.6995=
50-1-ruanjinjie@huawei.com?part=3D12


