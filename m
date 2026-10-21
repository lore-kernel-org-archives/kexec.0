Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F5606A321
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4l9SmV19;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OUFTvcsu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xqmI5oTYDX1SfPqyVBb8xiQJ7sNcHlpo9oEZ0gRtz5M=; b=4l9SmV199f2Oh9yc9R55IuOw30
	3KtUJlxtq9Sg+BkHRv+3PxzKnWK1oyYjIXAz70EwxiEEoHqs9x5G6T9MrQXJ87940AMNWmRMEQxg/
	otnLfr/VjWvxEhF/sfn34YqbuEBHksGcGx9Tdd82gNhc2K9G1fhPRftTLgJEaL8QwQOCh/kPVtSiZ
	C8PjTEHwtDzBtYLel9r/alHRH6lpt2Y/gqCAwvF1I6wuiCxKVOOmdnDwsJnha1FkNIPj6ZE1Mgg3s
	otjAWo+2viqvEUrps2y34mUyEszRXQlnyD2QnK5ElU7unAx9Ds4yzXR7ZgiSM0MfgJm0+0hLjEmyE
	PDF0vC5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJOk8-0000000B5QE-3eTc;
	Wed, 21 Oct 2026 05:20:04 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJOk6-0000000B5Pr-1O1c
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 05:20:03 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-150ef97e790so3420c88.1
        for <kexec@lists.infradead.org>; Tue, 20 Oct 2026 22:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792560000; cv=none;
        d=google.com; s=arc-20260327;
        b=E31ao+qNGAjwhexWsnha87Fo+tn3VqSfniXfM+llbOiZRe6WtCZB1umhVd0RJQEfxI
         4p0BVKan1Zu1ICcyysl8af4RqAu7kXul2WLa0sGR8DhAvXDPV2vZoh7tTPi/4VNdY53u
         3tiE9G0N5uiZXgFNfW/Wo8SRtHrlTOWmgIJyU9jFtlxFUF26X2WGMZpFoMR4iyvFUeJV
         8cOzjmoM+XjgGtDTfOIbIgm6AUtzvShsRo8k/DhCEvdt9kG1NizeCNlq2t4CrphGT0UG
         SHGA3WpNe6vlb8fTGQtBDB7WwVkrNl8k8w5OD3SXtY3jZ29okks2rufqeRXck3e9R/AP
         a53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xqmI5oTYDX1SfPqyVBb8xiQJ7sNcHlpo9oEZ0gRtz5M=;
        fh=eGMcKTCyeiXxmzsPtzJIbzvEwtelVQaF6/wA0e85918=;
        b=JveK4xz3r/W0XiYvp3uIZj8ZTuJU0SBt7oI8np6lfyJF0vp8j6XYQNAFz9FLEkrcF3
         TagcSza30HIO8xSibHnE5RyqtbWZpBExOPdTGEwzZMEwlqAbu6CysIbuSywhS/LZy/kP
         0juXRrXppjQjvvvMRbajpETC6RozQLKYtd4BIVF6ScxFYf9MqKEvpGx1mnZVTy8eRR68
         WUyCOBGGLv9Ej87LDJw5Srfi8TkC7S9GqYhMDWGYzyewKMlKCFgaN84rs2QGCGDrrScl
         aGMVpM9q4zoX4PWnK17Og/DpvVW2ub9X3UJfEOMQ/gqLd61JDzxEpGAMbC51LJaG71iv
         Qwvg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792560000; x=1793164800; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xqmI5oTYDX1SfPqyVBb8xiQJ7sNcHlpo9oEZ0gRtz5M=;
        b=OUFTvcsuuLOxeIVjV6NQrbn21E8C/YK11rMnZXR+35Y+8UkteW88rXUFlFG/1Z3ynY
         uHSKWAIhw6MxyR3hP/YEOiANo2ta3NMbYD5ORaGeO3kvAbyjCVt0WlWSC0VCERoXCD3K
         WBHNODMl7wN2MbkF6oKqRIZ7wInb+644TrxlxOC7m3bQ9vFXFkDIgkUiQJX3YFko479b
         TrGkmpm5TcoktZqq81+OrlldyoC8JQqGC8MwQ/fzUPJuIGHHdubIVFhkB8nLvbBwMira
         srU2IuRmmhZCqiNGyYM6mWlvPupD4RKqAMbHv/SmkPCwmFSpLktSXaB/KcyRKYa/biR+
         dMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792560000; x=1793164800;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xqmI5oTYDX1SfPqyVBb8xiQJ7sNcHlpo9oEZ0gRtz5M=;
        b=hygP2GQfSvzBQ5l9420CO5svavom9QRFFKFKzFQnX72Kt+/eW4xKCyvX0bU8E6GhWp
         6dc42ZerXMPexWAbzvoFk1ukgm89pcvG5PD5W97vWc81CW7oQjAjRK1PtqqDkfQb6JOS
         6zALgAS5o4oDWRO/401XYe3XSUk/KJ+U3zAsOd776lWoyf0apM+fsDUndsLenk4iYPKf
         YqmwprnmOd6w4lHDkPNI/fXbL2M5c9n9HGnZK8d/L1UPQs8RUuvmw+u/EbJGxBg1/M1F
         58M1OUhnBmS41KC9hloNRD3vTWRwrFQnV5zMLHPbAfSJ7nW0X4qW2hgkNu7Ram/druob
         UpKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxT551/0CHKnD72mQcAFJ2saBU8eXKQ/g+nVOWwbKJ+HMqeAcmUXv6OGDQ/ZIbhSwe/VD2wwQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYKTYysb0Ijfb5R33FkXtxUqqYAmrwb2w1V90dmuefJk0pgBIs3g
	e9mr2nHJ9Ad1/yjpgZEXrJ59axarSIdxWSc7NA2jfEDhT+A6nkWnBOmBYkYagLMzWjQ2ZIWvuf0
	b4h8z+8qUs857MKGcaCt1mABcXbdyHAS5G2+Ho9A=
X-Gm-Gg: AYBFou0446al4dpk5esThMrsI0P28s6A0evJbb/u7u+AgwOkq6Qe8cO4vCdBErZ20Mp
	ZaqB5achvtwlVtt81e8ycG/kpzmitP5MT2IeZfcNXNvNPLwxn1e7HBkdZQ2Cy6dc1I3uIEL/Pxy
	ATsLyiUsehAJnqmSSdPHTX6fyt0jVseuqOavmYjyujvq2GoQYoKSRSD4MfdJkZHnQnnnNNNnXY6
	FJLpuhN1614l5AyCjI468pDzc0jhorS+NjsRH7qVICka9ZBGmLfYSjFx/4E6/u/eLfhDtSqNzPd
	uvJoW7ihfJ/zEbWK8XohR/d7/QLwgJdoxucDxfF9rVdSs6WjJfiFTGQ6sjgETmgRQlxsoyt5vmJ
	NnDSfr0nANuY4xR69rc6GKYC/lvTd22HuVuB6v/MXgWrQmsXR5L9veWk6sasLpxVKNjOJYZAhk8
	dzvLxPuBAfb+YKMRECQg==
X-Received: by 2002:a05:7022:5f1a:b0:18a:392f:abb4 with SMTP id
 a92af1059eb24-18dca4525e1mr532164c88.8.1792559998707; Tue, 20 Oct 2026
 22:19:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com> <20261019213054.3157159-4-dmatlack@google.com>
In-Reply-To: <20261019213054.3157159-4-dmatlack@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 20 Oct 2026 22:19:46 -0700
X-Gm-Features: AclHuK8_I0lbhT2Ykck25LC8FtHxcLqDsxEKAtZfCcYcVX3702p2AtjdvdGdqto
Message-ID: <CAAdrzjuxL-RCLUK33WYpdvDV38+kFTmoTBVoxK9cw9Voj38wcw@mail.gmail.com>
Subject: Re: [PATCH 03/10] PCI: Factor out bridge window probing from pci_read_bridge_windows()
To: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_222002_373568_6E1E7C49 
X-CRM114-Status: UNSURE (   8.53  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 09:30:47PM +0000, David Matlack wrote:
> +     pci_probe_bridge_windows(bridge);
> +
> +     if (bridge->io_window)
> +             pci_read_bridge_io(bridge, &res, true);
> +
> +     pci_read_bridge_mmio(bridge, &res, true);
>
> -     pci_read_bridge_mmio_pref(bridge, &res, true);
> +     if (bridge->pref_window)
> +             pci_read_bridge_mmio_pref(bridge, &res, true);

These two if-statements are redundant and can be removed.
pci_read_bridge_io() and pci_read_bridge_mmio_pref() already return
early when io_window and pref_window are 0.

Thanks,
Josh Hilke

