Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA08606A31A
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=I5JN36yS;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQ1WyOP3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FQIuU5kODKSuh5udmlPz6E6unOug2cwuAOBYgYqN3Gk=; b=I5JN36ySd4z9H+Cj27iONvq3pL
	rz8udQfpps8h+jmen7HWvfzpklVV6gWaEES+Ot/AHu6I+X0TXuvGacVXeBKG9Rz81E/8UAqX25tY+
	U9WfW+nNx8phg9geZqmzhuYasudJDH9GvJAgB+SENHcF+Px8z9j21ihJ/QI0pEdWAHIgWQILCSpNh
	2NWTnyVKdbdvX5tQirfk5Z8HZUsNMX5vi70JOITRVBokmz6AciWL3pLIleCKEoClIj7Y4jE5tw/4E
	mY3VfOoxjqvyIsfgkECOrh2Ho+ndmVFA74fiG/XnltOG79+rQRFJw/OcHtIpCDES+vIrr3xZdNCN6
	UvIBCxyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Sp-00000001Gg5-2DZD;
	Sun, 25 Oct 2026 17:56:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2So-00000001Gfl-29DC
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:56:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A1B17600CB;
	Sun, 25 Oct 2026 17:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFBE1F01825;
	Sun, 25 Oct 2026 17:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792951017;
	bh=FQIuU5kODKSuh5udmlPz6E6unOug2cwuAOBYgYqN3Gk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YQ1WyOP3a/DAkEwQZPpQo4B2nzqecTe6Q6pNW7STnt2QjnCkTi7Xqz58hWruZ5YN4
	 9uPsJV2uPffx7sb7cN4i5a110LDpyRhCQA4vZiPIF15MQljDK+iaRQc/00isxrZJ6g
	 8yAbZfv2Hq+wS4YkA4kENq6VdB1UNl4/lAWnrRnpAbLoKeuTvBIqsY8dwaBW92XkAC
	 DkkSLnbWxNHEnCG9ykJg3Ygv4G6pmaAaGQEUZBw6s/FP4n7WunR4jO0E2S9+e+Qajf
	 cNofZ/g8mV+4YBw+A46KSnbJmEK14yUtvQxjeDXvyNrnXcSRk1Y0mgP55sio/iOG76
	 dk/Bp56sTA+8A==
Message-ID: <sashiko-outbox-184302@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/9] kho: move radix tree and FDT helpers to common
 file
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261025174017.3870481-3-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
 <20261025174017.3870481-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 17:56:56 +0000
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

> Read-only KHO mode needs to traverse preserved KHO radix trees and FDT
> subtrees without duplicating the parsing and key-encoding implementation
> in kexec_handover.c.
>=20
> Move the shared KHO radix tree key encoding and indexing helpers, FDT
> validation and lookup helpers, and kho_retrieve_subtree() from
> kexec_handover.c into a shared compilation unit
> kernel/liveupdate/kexec_handover_common.c with prototypes in
> kexec_handover_internal.h, and factor kho_radix_find_leaf() for use by
> kho_radix_del_key() and the upcoming read-only KHO backend.
>=20
> While factoring kho_check_fdt() from kho_populate(), drop the "setup: "
> prefix from the FDT validation warnings and verify that
> fdt_totalsize(fdt) does not exceed PAGE_SIZE, which is safe for
> kho_populate() as both the x86 and device-tree kexec paths allocate and
> pass a single-page FDT. Also use get_unaligned() in
> kho_retrieve_subtree() when reading 64-bit FDT properties, matching
> kho_get_mem_map_phys(), since FDT property values are 4-byte aligned.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025174017.3870=
481-1-pasha.tatashin@soleen.com?part=3D2


