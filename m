Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F5CE92FDA
	for <kexec@archiver.kernel.org>; Mon, 29 Dec 2025 21:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VUVk1CmbFBfYMnd+onKI6dHabioivTyCBsvilOrGEbo=; b=3CwY3F6orEaXiPQwyqRpcMn1LW
	8jZjYLAw64TsdYnDvewx9o5rWTR2GS9EaIfj2LmnCIpeWV3iw/IhpBmb+KfC2K+e3NDMWXq2sdQik
	1omHAy4KkRkI4a8rhRbQGbnRK+LXg0Y+IjeWLY8+7Xh+xFofimnPvUQggX5Oaj1k2v9beaf5GEp0J
	frg/qSQAoofGx1EQWJKSctx3Dd8srpnDhqOWXOkr5TyR+D7v96ehyzLZfRUs8BEPiU+BIvcQG+jrc
	BPDfriE75qDUy3B5B/u/UdJSroqNsdGY2woQlCpLYbxSGAyxW1vCZx7wJqNWIxNxEdU+VbUc/rltT
	F1tdYwxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaKUe-000000044WU-0fkR;
	Mon, 29 Dec 2025 21:09:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaKUa-000000044W6-1SPP
	for kexec@lists.infradead.org;
	Mon, 29 Dec 2025 21:09:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7FD78440B1;
	Mon, 29 Dec 2025 21:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4386CC116D0;
	Mon, 29 Dec 2025 21:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767042567;
	bh=VUVk1CmbFBfYMnd+onKI6dHabioivTyCBsvilOrGEbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=N9e8bCrVuBEncQY6DY/pq7L587pcxnuZNkUiX7jAH7g7gNTO0y0pXZPeInuYaf0m9
	 812ZhsV0+TyJogWbd9NPmIeqMpvofs98qURaj9WiG48AwIN7WvvmvCmSzSWgXie0KA
	 CCAy5b26YL9gzrOmAo6bPMUaYRtYNsuJiVy5YWpxZpJRA+eh0vBVaHHKkn+5dTKB9q
	 XCga1hD5U5zBXosGvPjHHU92N6xxbsFtWsf+67cUv/sWP/Ntbxl5dUA7cPwVE3XsMH
	 a77CArbgngll92iBlUHc4ILjqjWsepe7/hqHpU9yHYBS6tEI+xdWwAPg1YhKoLEg35
	 nTP6Pz7wt0lBQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Fadouse <fadouse@proton.me>
Cc: Evangelos Petrongonas <epetron@amazon.de>,  Mike Rapoport
 <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,  Andrew
 Morton <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
In-Reply-To: <7024cefd-bf27-430b-b8fa-04e1457e0eb8@proton.me>
	(fadouse@proton.me's message of "Wed, 24 Dec 2025 07:34:04 +0000")
References: <7024cefd-bf27-430b-b8fa-04e1457e0eb8@proton.me>
Date: Mon, 29 Dec 2025 22:09:21 +0100
Message-ID: <86zf718072.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251229_130929_964281_7FE914E8 
X-CRM114-Status: GOOD (  12.64  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Dec 24 2025, Fadouse wrote:

> Hi Evangelos, Mike, Pasha, Pratyush,
>
> I independently hit a crash in the LUO/memfd restore path with
> CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy, on a local build based on dd9b004b7=
ff3
> (x86_64 QEMU, 6.19.0-rc1 timeframe).

How? config KEXEC_HANDOVER depends on !DEFERRED_STRUCT_PAGE_INIT. So you
shouldn't even be able to enable KHO or LUO with
CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy. Are you sure it is enabled?

>
> In my reproducer, stage1 preserves a memfd via LUO and kexecs into stage2;
> stage2 calls LIVEUPDATE_SESSION_FINISH without retrieving files. I observ=
ed
> a reliable crash in adjust_managed_page_count() from kho_restore_page().
>
> Minimal excerpt:
>
> stage2: start
> stage2: retrieved session fd=3D4
> BUG: unable to handle page fault for address: 0000000000001410
> RIP: adjust_managed_page_count+0x29/0x40
> Call Trace:
> =C2=A0 kho_restore_page+0x18a/0x1c0
> =C2=A0 kho_restore_folio+0xe/0x60
> =C2=A0 memfd_luo_finish+0xe6/0x160
> =C2=A0 luo_file_finish+0x188/0x240
> =C2=A0 luo_session_finish+0x2c/0x80
> =C2=A0 luo_session_ioctl+0xf5/0x170
> =C2=A0 __x64_sys_ioctl+0x91/0xe0
>
> Applying the patch in <20251216084913.86342-1-epetron@amazon.de> makes the
> issue no longer reproduce for me.
>
> I can share full logs and the small two-stage initramfs reproducer if nee=
ded.
>
> Thanks,
> YanXin Li
>
> Tested-by: YanXin Li <fadouse@proton.me>
>
[...]

--=20
Regards,
Pratyush Yadav

