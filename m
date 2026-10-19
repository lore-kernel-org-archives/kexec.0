Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B46CCF2D5
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y/dn3N5mqpHjq+shCtEHgOpc2o04PAGgqs4mHj+X6eQ=; b=FKxksFtJwpp6QbdU+YkD7IMKYp
	q/9BEXTFJnvAhgeggK4ZtyqpC/F8rvyX1+N21m1Ard3OuxNYpX0fLYjLZ09iVWIvAD2sTeoxdHzP7
	DDVOoZgLMKIKsaIF/ASpvCDYrIXRg3yKUva4LOpk/rHeSqgB7uWwZynlO6ty090l9Y+tIbGx9NTdd
	u0Gr5nhpicgBfZMCEwE0i8iZcgRXgDW+pkt/+JxftdRTftEHqfY83ERnIknOdohzUX/GssdkYjDAc
	qfl2yj5zeLGpvTDgw5lbQwkJjpP2JNyrosPKB+om41hvsiIGk8MId+tsGq1gYiv2etrcu88js/BPe
	0mS9QYpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxs-00000006STH-1kOF;
	Mon, 19 Oct 2026 02:19:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxr-00000006SRt-1EZX
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:19:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B82BF60DA8;
	Mon, 19 Oct 2026 02:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB891F000C4;
	Mon, 19 Oct 2026 02:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792376342;
	bh=y/dn3N5mqpHjq+shCtEHgOpc2o04PAGgqs4mHj+X6eQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aq40aHatS0aa5/X0EyrFGcNnw87b6/JgbUFMrPwtM7PwYaeieR4zi03tfwctMzlAo
	 lGFQShlI7usCpGkf44DCPIwuvtPcNoUH7rP+Jgje2Cc+bL4T5DIEzsngs2IlBpD5Pm
	 LczxOunnFNdtu7X8OZwj5faLfr2bbWMahbgP6H+HV+RUbBWEqdd+Iz8GZjkoE05vib
	 rpAuSyBuKkjBruKT9uBinarfiS+gC25DVd5T9p60yBHebGSpd3tKDRdnXYyVH3Awh7
	 N/M5/kkFI1PyNCD7B1HTZrKFbe/KkAvi57eNA+6WHOl9V10RapqrnaisI5KVxKfxsB
	 6BaHVbjErpLjg==
Message-ID: <sashiko-outbox-176524@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/8] kho: test: support read-only KHO mode in
 test_kho
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261019021111.990394-8-pasha.tatashin@soleen.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
 <20261019021111.990394-8-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 02:19:00 +0000
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

> Allow CONFIG_TEST_KEXEC_HANDOVER to be enabled with
> CONFIG_KEXEC_HANDOVER_READONLY and update test_kho to verify preserved
> state when booted in read-only KHO mode.
>=20
> In read-only mode, test_kho retrieves the test FDT subtree, maps the FDT
> folio via kho_ro_map_folio(..., PAGE_KERNEL_RO), restores the preserved
> vmalloc folio descriptor array via kho_restore_vmalloc(), verifies each
> folio's preserved order in the KHO radix tree via
> kho_ro_lookup_folio_order(), maps each folio via kho_ro_map_folio() (and
> unmaps via kho_ro_unmap()), and verifies the checksum over all preserved
> pages.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019021111.9903=
94-1-pasha.tatashin@soleen.com?part=3D7


