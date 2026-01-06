Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87726CE9D63
	for <kexec@archiver.kernel.org>; Tue,  6 Jan 2026 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d3BPDyxdSzmRlY82TYRVSEMIt1MGjPO4hr8vKGfT55g=; b=LYowVZnDREQObAZAkUMJouItxd
	SuaTFd4KpNW3+HKRDy25Qp0SsYcr4bzBYrhFugE0g9Z8qMBEHjylxpDnieKV+tI8b8DO/9nRoiBhd
	lSAji5D48pEYfjcZLSTB81JNynfmy5hNLRzmIw7Qr+pqVWDrvPvlN9PV8EczpeJ9xC58quvsGN9ov
	QXX2eUkEbSvZ3vlhLHOr0RU7QFCNepCogfvjwBxlRK5Nw5yrSdlV5DEojZ9WfoKBnYW/Injo3aBnH
	AEq9ZPk8LRH2wowki04gPXSfXKZb5JWxt558FbjYbEPi5NG6AqXxhltOar4Q1NgNhj2ooN5VSG98M
	GF/DPz4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd9Er-0000000DQZH-2TIh;
	Tue, 06 Jan 2026 15:44:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd9Ep-0000000DQXu-2dxy
	for kexec@lists.infradead.org;
	Tue, 06 Jan 2026 15:44:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0EA3E4436F
	for <kexec@lists.infradead.org>; Tue,  6 Jan 2026 15:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E315AC16AAE
	for <kexec@lists.infradead.org>; Tue,  6 Jan 2026 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767714290;
	bh=46IA74TgsYCX1Wdt8aKcLKb4RYOUhDJz4Bq8eqM3rvM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M8aqSayh9x7eugOCav2bUStC3irU102ypWSH1a6+VxK2JM94lSG/3mPDBBxdNg9dB
	 9caq4toXi+Ry3NHUpkGyP1fQsyXrE/u/eg6vxmWii3ry1BRwJeD/GYRdrDlQYq3p8b
	 blArfXe2ZBxKN9qSAGwjrnmeGrKQoLrpyXvsBlgJ0C1U1koKUQuVL2I0Da2AHS9/2Q
	 nHmJYt5vnHBuYlKzJja8nOpzuFBgsi3KUjttuiq5obuTJOTtU9Er9Jap/arRWt7EYL
	 B95bFMEQ5Gj9f72+BsMunNYp1hqO/Cs/89rPiVCyWV5ZtDeuHGPqu9dw1Tqrr7VgMi
	 Pbm03B+uBiMsA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8440cb2dbeso27468866b.3
        for <kexec@lists.infradead.org>; Tue, 06 Jan 2026 07:44:50 -0800 (PST)
X-Gm-Message-State: AOJu0Yz4cV3TJzHmfod5qAY2lL8n8jeL+DEcM0JHhNKZl4GA7I8zUtq0
	IQbZeXo2/1lE4q3WIzHlsCBc4QJQgxrsi13Z808ysgyXn4cQVfXxUa6uYf6xKXWoHQQZGLbG/lK
	LW3F++HoEQkOpCwHz2EOJ7PmuNqR11Q==
X-Google-Smtp-Source: AGHT+IHFeow7GaX738Pcre7r5od5Yqad8UB8G/TYGPsM6GH9pPZ2ShOPoXiLIEj59XKYnsYmNR7ZxCR17dGzQ8eR6p8=
X-Received: by 2002:a17:907:d7c9:b0:b84:1fef:32a0 with SMTP id
 a640c23a62f3a-b8426a422femr330026266b.6.1767714289311; Tue, 06 Jan 2026
 07:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20251226141116.1379601-1-coxu@redhat.com>
In-Reply-To: <20251226141116.1379601-1-coxu@redhat.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 6 Jan 2026 09:44:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLEsUV34tMZWSMc6w-xDV=M0JpOmS95TxrtbbBMRoD3Jw@mail.gmail.com>
X-Gm-Features: AQt7F2oZXv_EGI4J1ibbdla2HKndc4TqmJiiAssIWbaMzvfSFkjDSKLgEAqcVKc
Message-ID: <CAL_JsqLEsUV34tMZWSMc6w-xDV=M0JpOmS95TxrtbbBMRoD3Jw@mail.gmail.com>
Subject: Re: [PATCH] arm64/kdump: pass dm-crypt keys to kdump kernel
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_074451_683631_D46DEC14 
X-CRM114-Status: GOOD (  16.55  )
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

On Fri, Dec 26, 2025 at 8:11=E2=80=AFAM Coiby Xu <coxu@redhat.com> wrote:
>
> Based on the CONFIG_CRASH_DM_CRYPT feature, this patch adds
> LUKS-encrypted device dump target support to ARM64 by addressing two
> challenges [1],
>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>    machines, a system administrator may not have a chance to enter the
>    password to decrypt the device in kdump initramfs after the 1st kernel
>    crashes
>
>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>    which is quite memory-consuming compared to the limited memory reserve=
d
>    for kdump.
>
> 1st kernel will add device tree property dmcryptkeys as similar to
> elfcorehdr to pass the memory address of the stored info of dm-crypt
> keys to the kdump kernel.

Is there not any security issue with putting the key into the DT? The
DT is provided to userspace. There's provisions already to not expose
"security-*" properties to userspace (see __of_add_property_sysfs).
Though I think that has a hole in that the FDT is also provided as-is.
However, I don't even know who or what uses these properties.

Rob

