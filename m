Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768FEC7EE30
	for <kexec@archiver.kernel.org>; Thu, 26 Jun 2025 18:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WOaf27H9b0f67C97B7foSPXRCiauHiab08IxrS27XkE=; b=qhahjDFel/D1RGvDbhhMXeCF/c
	E8EHUWlPN0JaQZp6Aq/b2/daOVcZ/F+pDaI/FkNR2W27+e7MeD8r22aSjYVMDdbvcHhG+UtKRbLum
	ZGqsVVUpybdaI3Xp2cYEZPHFDwAQx6B1vrc1xxNrW73/lolEtNEHfLuWuIrPOyArchzepzGfb2Fsc
	Q9UghiTidamOAe5tGkGvGmpCKn1p9WsLDoIkeZeuo5KGp7VymcZqPdeNTg4m3rGH8h7xjUlgWqF/L
	csGwFKdBIyE7YAUvw5Uw/aNmURlrriiSzBaJXj9+AO/kOuchMkPOeyhoFe5Q6tolhq2RKtheSmPdp
	2OgGLBsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUrXz-0000000CTmQ-0OCJ;
	Thu, 26 Jun 2025 18:42:07 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUrXx-0000000CTm4-0lMw
	for kexec@lists.infradead.org;
	Thu, 26 Jun 2025 18:42:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DEDCB4539D
	for <kexec@lists.infradead.org>; Thu, 26 Jun 2025 18:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78BBC4CEF4
	for <kexec@lists.infradead.org>; Thu, 26 Jun 2025 18:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750963322;
	bh=oSH+uyYEs2L275InMRgKzvBdu+ZCytwzQlrMPmj47Ac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FlDlwvX0LQKyKpT+nMX2MfKzk3Z7TSau5v5AEYk0dsQr3HBFyaqgMNtBPcL4eaf5R
	 xForqYsi22B19BHWAuvAEkmHgpbmTHO6d2iPaHNAHb/GlWn3XyRD5URBINumKxkc3E
	 i3g5XcJCyochVHvin8+Dv5SE2p0V5E4PYEUzWCKmEnL/nJjhrqAGO9+AULAInCsc0a
	 /kuUi/zFjReMPtLpdGfKnKVJLIBh0lrdbNYfsucd65VkcB3PJX1sD9ysc3bGVzzTYB
	 NIrqg28edmh1g2sDhddM5oaCqcUFukXwO7bgtWR/GEa3dNpUe0mXryLznEN5jma2Fi
	 Ou5dVA2KsiiDA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-60ef850d5fbso432378eaf.1
        for <kexec@lists.infradead.org>; Thu, 26 Jun 2025 11:42:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUG8J1d7lOX9XMBfru9o3jULUhVGkGEQiZ62p9qSA9teSCRRe4D9K64EHjiixHIU1oG8F9oKQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwdTfyLKZrnPC9rCFsypq0fqG1hrb+MLIN6y/Y6Ig+aJFbQZvFj
	5NlCyb+iix61nZZ4tubvfhQDItJjyJyiODrGbP9mtnelDwmtyM7FG0OUd2zdHvdAp83Mg+xJtVE
	p7YiI5Q+VAeZY1tlfq0NI5A0Te/i/5go=
X-Google-Smtp-Source: AGHT+IEmrPAdUCMPURIBxZDmifSkHLhGZoub/t1yDrvW+aUfIqoH2qX2gOtyAVWMmYsx3fb9j9P8rfCoElzDJiap+rU=
X-Received: by 2002:a05:6820:3093:b0:611:ac4e:f140 with SMTP id
 006d021491bc7-611b901a6admr315943eaf.2.1750963321999; Thu, 26 Jun 2025
 11:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250613214413.4127087-1-superm1@kernel.org> <dn6yc4swdyek4gz3bv7g4y5e6xzmo6vm5gkqqhmhbdhomnglbt@nsepw42i6hwz>
In-Reply-To: <dn6yc4swdyek4gz3bv7g4y5e6xzmo6vm5gkqqhmhbdhomnglbt@nsepw42i6hwz>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 20:41:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hAxF0Rt3Xv+CySa3-rwWkODwG3mmSYxWQs-F3cqkZ-JA@mail.gmail.com>
X-Gm-Features: Ac12FXzJaY7TW7u8BsjbJtS8Xn0Ot9Y1XPuprFTic9mdQXn_mrlZ8A79MOn8K18
Message-ID: <CAJZ5v0hAxF0Rt3Xv+CySa3-rwWkODwG3mmSYxWQs-F3cqkZ-JA@mail.gmail.com>
Subject: Re: [PATCH] PM: Restrict swap use to later in the suspend sequence
To: Lucian Langa <lucilanga@7pot.org>
Cc: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com, rafael@kernel.org, 
	len.brown@intel.com, pavel@kernel.org, gregkh@linuxfoundation.org, 
	dakr@kernel.org, Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com, 
	christian.koenig@amd.com, linux-pm@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_114205_239953_EDC931A6 
X-CRM114-Status: GOOD (  14.82  )
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

On Mon, Jun 23, 2025 at 8:25=E2=80=AFAM Lucian Langa <lucilanga@7pot.org> w=
rote:
>
> On 13.06.2025 16:43, Mario Limonciello wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Currently swap is restricted before drivers have had a chance to do the=
ir
> > prepare() PM callbacks. Restricting swap this early means that if a dri=
ver
> > needs to evict some content from memory into sawp in it's prepare callb=
ack
> > it won't be able to.
> >
> > On AMD dGPUs this can lead to failed suspends under memory pressure
> > situations as all VRAM must be evicted to system memory or swap.
> >
> > Move the swap restriction to right after all devices have had a chance =
to
> > do the prepare() callback.  If there is any problem with the sequence,
> > restore swap in the appropriate dpm resume callbacks or error handling
> > paths.
> >
> > Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Tested this against 6.15.3 and 6.16-rc3.
> Adding my tag.
>
> Tested-by: Lucian Langa <lucilanga@7pot.org>

Applied as 6.16-rc material, thanks!

