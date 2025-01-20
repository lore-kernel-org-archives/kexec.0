Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE9AC02182
	for <kexec@archiver.kernel.org>; Mon, 20 Jan 2025 11:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bkOG/wiavVoSPZmvBGUylFMX2LgSHcSIzuKHpjcrowQ=; b=juxqAywDzc2cr8zipqHxOFasul
	krsGHBBZT6IMHjGMeFF4Tm6FZitHs9js+hhEZEmQcbziG6rmrlybI6yTOTvZgjGYfBxlgwyUktJr7
	s3fFKGZufsA17/95Bs1h1RjDG5NMZhal91dwRHwRyCmk6ExDpfgtlTCXVBt4SnwpEc4G9wVV6Oxfe
	AULMQmtHExzt1rxmuboRcrtoaOBOFe3Bw49wQMT51nPrtx9QngIjpbfDq+nUfWrWob/i5QG3BeHwA
	t2xLuVVd4XZVEcz3AcswEkWfRr1Dss89dZ4cUDBM2G4WB+p+ghmc5cUoY0dCGkr/8AFUqYQ9n7JA3
	2SjqSnYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZq4i-00000005SEo-04Dv;
	Mon, 20 Jan 2025 11:36:12 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZpyf-00000005RGe-0MU1
	for kexec@lists.infradead.org;
	Mon, 20 Jan 2025 11:29:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 97F93A4077C
	for <kexec@lists.infradead.org>; Mon, 20 Jan 2025 11:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED066C4CEE6
	for <kexec@lists.infradead.org>; Mon, 20 Jan 2025 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737372596;
	bh=bkOG/wiavVoSPZmvBGUylFMX2LgSHcSIzuKHpjcrowQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J46hOJZmDcw4u6FV2T1LWfQziBa9Zd7xUHuayXU7T5TzZXFLs9RubNUDp+3NWjonJ
	 OXn2U6R3+v9pW7N1ovZRxHpYaZd2CpGHt1UQhcXoNko3o0AMbxNcUJ0hH7Zh6/udiW
	 G+rTZIgZqr2t/Y88wDPIlsZ1wQHzAHgLRQoPOQaY90o1fzgDCNjmepsSPXM+lCeAiI
	 ajF803WU91ypoVO3/9KqQMyE620bvhzOwayXdNFxGnhGvnGYrGbRS07ozQ+G1x0Fj3
	 AlGCwO8Dvsz2Kr1jOGWhwH/zNh6epNPjJypdiwp2uLz6CPsfL/JNdSLxpxKZeGwKar
	 ZHD4gZOUJHt5g==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30229d5b229so43701141fa.0
        for <kexec@lists.infradead.org>; Mon, 20 Jan 2025 03:29:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWT5fej94FJGa7WkX8g0kp+3yA7/kIvXjozKLSaXfmwKuP4DOE+s2E9sMxTPw0ot4qP6AAvAw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5cmXssINfNSaY6E8TrpxweCfTvFMji8pUa3zxgGtgdGsRN6ZV
	MTUJMN3gQe88XX/652sIJt0FPoZScQ1N/iU3w+ecvpn03lOYyKqIV21uo3UnIb7Z1Z4BDLGRsFq
	8w9BF2k1OT9GSWo0mHiUDCq/Xei0=
X-Google-Smtp-Source: AGHT+IGNxrMOnOIAWE/wFoL5lfSdbC9E8swPrDYTeFRacrHO/Py3Bl/Wke94VpS8fEIG5mlWiSxjrfr3K7Vc/jvFUv0=
X-Received: by 2002:a2e:bc18:0:b0:302:1e65:f2ab with SMTP id
 38308e7fff4ca-3072caa13b5mr49028121fa.20.1737372594247; Mon, 20 Jan 2025
 03:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com> <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com> <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com> <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
 <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com> <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
 <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com> <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
 <029cff22-f2e0-4796-9c27-1df056e08f8f@gmail.com>
In-Reply-To: <029cff22-f2e0-4796-9c27-1df056e08f8f@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 20 Jan 2025 12:29:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEhKbuqVz9paggxQQz1Wyk_UNRvWZ46X7YKx9b-xMfWyQ@mail.gmail.com>
X-Gm-Features: AbW1kvYdsQPQ_3t732WmECe_gD4pITHs-agDHxVG4Hyf2tsLvavhpYRZ3h6XkUQ
Message-ID: <CAMj1kXEhKbuqVz9paggxQQz1Wyk_UNRvWZ46X7YKx9b-xMfWyQ@mail.gmail.com>
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	hannes@cmpxchg.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	leitao@debian.org, gourry@gourry.net, kernel-team@meta.com, 
	Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250120_032957_312732_8685D975 
X-CRM114-Status: GOOD (  17.62  )
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

On Mon, 20 Jan 2025 at 11:50, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 20/01/2025 10:32, Ard Biesheuvel wrote:
> > On Mon, 20 Jan 2025 at 11:27, Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >>
> > ...
> >> Hi Ard,
> >>
> >> Just wanted to check how should we proceed forward? Should we try and fix the warning
> >> and corruption during kexec as done in this series or not initialize memory attributes
> >> table at all in kexec boot? I would prefer fixing the issues as in this series.
> >>
> >
> > I would prefer kexec boot on x86 to disregard the memory attributes
> > table entirely.
>
> Would you like Dave to send something like
> https://lore.kernel.org/all/CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com/
> on the mailing list (wrapped in ifdef CONFIG_X86_64)
>

I prefer this approach. and no need for the ifdef, this is x86
specific code, and the memory attributes table is already ignored
entirely on 32-bit x86 iirc

