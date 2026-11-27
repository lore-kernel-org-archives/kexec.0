Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE2606A327
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IM+1wTnt;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JB1zssfY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gnDEMS0iHt15gL5KaJ+Nn57X9otTzk+I58v16QdRYcc=; b=IM+1wTntFxgF7T
	POQT18lIbjMwAnZFVa8FptdQkpObX4pAONMZl79F8sYoapOP58JHRgvrV7sCK8Au0iLEKMEUU0kJL
	Cq4pN433bAZ9p2C9rnMJwYVyD7De1nHfbxS0QFTBoLqt8urb1ErQrOFF2QhgVDxFF6wrV4Zjco55Z
	E/8pYJ1FsnbPZ+ZYwpoHZIaIL1mqo8YseFG2MbFCGPV6fKt6NoW7l2ryiFgi+lufMpAgnfeei1/+6
	KRFED4/q3wOM2hvV6U3IbKWIIDKqM393qFgEEQmGZR4qzuMoqZWl4P1WOi/yVAJBX3YwPsebOsZu0
	UnYylxep9/u67SozqnHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWy8Z-0000000GtiY-3tCv;
	Fri, 27 Nov 2026 15:45:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWy8W-0000000GthY-2Hzl
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 15:45:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A42DB61F8B;
	Fri, 27 Nov 2026 15:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0664F1F00898;
	Fri, 27 Nov 2026 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794319;
	bh=gnDEMS0iHt15gL5KaJ+Nn57X9otTzk+I58v16QdRYcc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=JB1zssfYw+imHpGzqwtC5bxeRAT3TilT/4N6aggkc/2aQrIFfSKYPjPnNGrDnNuCD
	 i6Q3iaDTFqGIsVtaIEed0I+jvbQmNjOGY0hNBmtE6voI8JTkFcYDjmfcF92t2aRQN+
	 ENcGwC6L1Hmee6FlpOuUsmYvSvvIMUcYf885vMlscaWmV719ZBNjtMUuQus6NE4q+1
	 GuDMExlzxK9s0A0z0wzpLqi6uXoEDtouKh3pCKrlizfJO+Peo0U2usbiuYYHnWVCuf
	 b3Wmdnn8kJMsf1oSSjL+Rjjv+3RkqB2T8knDrwlRloS6lt1DluS9/MFbEx3LpgZ2JN
	 Xe/yFxDspXKbg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 3DDC4198003A;
	Fri, 27 Nov 2026 10:45:16 -0500 (EST)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Fri, 27 Nov 2026 10:45:16 -0500
X-ME-Sender: <xms:iKUJa5AkdJxnKccLXcMCurc131x9BzxkyDtyblVcz7UTk0qCfK6l8Q>
    <xme:iKUJayXFm2YhzIgi9SPInDUX-UJiV53UZOU4RVdrD_eqdQDtpoqTcX_P3iLfD7CKv
    TjTZCJ83aqifQrHscXBVAfYTsDfYsa4nS7m01fyEiM889CWl_Fv8CmX>
X-ME-Proxy-Cause: dmFkZTFMcXaa74Ww3Kiq0njNmC6WTjACVv1LMbtEsqeSpRVSFbR/Ii5MZNWGX9Zt0PDC4H
    QxR9lt1bmXDfrRIrCorv6+5mFL40Wh4Sb/IbRj/BEfQvKKf2rrQS9jZJs2KpQ++T3wSoLD
    HNqyZ0pThIqEcsGyNXKeRbGfLfgvIjr5ltrRA4kRQMAh57Sv/vW40wLB5ugCQoAwYP+yDn
    mqcN6PXz8tAquh0HX0rjDTsI5AoO0CDjNZ9dJZhAXhuICxzq9EfL7Fytc6bGOS0h+qgiFD
    r4m02mBJrAEFL2pn0rfl2R8X7FfezgjnyIqIWsi8BdeUbjGCeYNUokspCipztY5uB13oL4
    YuyWH8KtSnS4uQoxE7PMGHY1LlmlFxxm1KE3zJprK9tqrPEVmOck569OEc4Z34p1jVo+q2
    3ivF3fonc3VfONZur+ttGBJiQPDOFX7bO7YbRRwS90s8oKkKqrAOSAp+bDHExf7PFpN9/2
    MYSpyRRZaH5knqwf1zivHKPr3PkJ8A/L4rbGoWpOAQEudRzQJbmBkT/2j4k+aBm4BxMI8/
    7ie4vqieF2IT3VtbrVvRPx/II5OdY1AE31VoMtNRQFbUR9Jq9KMDKqtqe5GqBnHYYI6KCZ
    Osa26CLih0vjr119q8j7LlNbXu+EoLzZC+4Ve+yd15O4D/joKlh0TnVomAvg
X-ME-Proxy: <xmx:jKUJa_qdFYIe-J18cgVIcEIWWYMT9YX8BlOTTPoAY2dY5zm3U0iWFg>
    <xmx:jKUJawt29v05zGj1N-U8j50ppQcmBWYQ0-C0cQ6JoAXHx8VrtcezgA>
    <xmx:jKUJaz5G7PV1fTi4fQ5s08qRx5AGl_yw_XHl41HZSDv4ismPsQ3SZw>
    <xmx:jKUJa5RQ7EvBTiz9Kx9a6LpxkswJ6z8kJ7JlqwouQwm3fnLCCmpRLg>
    <xmx:jKUJa7lULcOKouAxtdiZ0dgPwmK6qX1xlLeMs44QyW3EBqEInflytp2p>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5658AF80093; Fri, 27 Nov 2026 10:45:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Nov 2026 16:44:51 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "George Guo" <dongtai.guo@linux.dev>,
 "Huacai Chen" <chenhuacai@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>
Cc: "Mike Rapoport" <rppt@kernel.org>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, shuah@kernel.org,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, baoquan.he@linux.dev,
 ruirui.yang@linux.dev, guodongtai@kylinos.cn,
 "WANG Xuerui" <kernel@xen0n.name>, "Alexander Graf" <graf@amazon.com>,
 liukexin@kylinos.cn, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-efi@vger.kernel.org
Message-Id: <976f1220-a259-4bad-9eb4-ae1cc78a79a7@app.fastmail.com>
In-Reply-To: <20261119082252.9120-1-dongtai.guo@linux.dev>
References: <CAAhV-H5Vse=pKC3Beqhqxa7fqadiGVNqkSy_06HZ3Luw2Pmj5Q@mail.gmail.com>
 <20261119082252.9120-1-dongtai.guo@linux.dev>
Subject: Re: [PATCH v6 1/8] efi: Pass KHO state to the next kernel in a configuration
 table
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Thu, 19 Nov 2026, at 09:22, George Guo wrote:
> Hi Huacai, Ard, Pratyush,
>
> On Wed, Nov 04 2026, Huacai Chen wrote:
>> I prefer to keep it in LoongArch until a second architecture, and I
>> think Ard is the same. But this is not a strong objection to Pratyush.
>
> Kexin Liu and I have tried x86 as the second user, to see whether the
> common table holds up. It needed only small changes:
>
> - The x86 EFI stub installs the table, as the LoongArch stub does.
>   install_kho_table() moves from efi-stub.c to efi-stub-helper.c so
>   that the x86 stub can call it.
>
> - kexec_file_load() skips the SETUP_KEXEC_KHO record when the table
>   exists and the next kernel will get efi_info. Otherwise, for example
>   on a legacy BIOS boot or with noefi, it falls back to setup_data.
>
> - When there is no SETUP_KEXEC_KHO record, the decompressor's KASLR
>   code looks up the KHO bootmem areas in the table, so the kernel is
>   not decompressed onto preserved memory.
>
> The table layout did not change. The only change to the common code is
> that efi_kho_table_found() is no longer __init, since x86 calls it at
> kexec load time.
>
> Tested in QEMU on x86_64. With OVMF, the KHO vmtest and
> luo_kexec_simple pass, and the second kernel finds the KHO state
> through the table. With SeaBIOS, the KHO vmtest passes through
> setup_data.
>
> So I would like to keep the table common in v7.

Fair enough.

> Would you prefer the
> x86 patches in the same series, so that the generic code comes with a
> second user, or as a separate series on top?
>

I'd like to see both tbh, but only if it is not too much of a hassle.

