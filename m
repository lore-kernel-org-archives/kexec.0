Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57C1C87FCA
	for <kexec@archiver.kernel.org>; Thu,  7 Aug 2025 21:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lmaL1qeIX6mdGDdbYfii2CxKmsjI+RXyM21bYE6XWMY=; b=AoOKhcDBrMsEMKf4ToSULJNdjJ
	mSodXlqvWnGGbCz1l/08edKR5JhLh4peGKmM20YPJeb5muK88XYtRPTx3wjfRdr57rFstP6HR9Re2
	R1bx5HdhLcbpoNzfUHJYBzMN4LDwnmZnzukuBTrO4MoGP9I5MCTv0QuTnwTc++ENpX4BskC9WffP0
	4eEkB+idhEa8+YxoDhgsXrax3leE7WoWn3RZ7HzUYYl0ZOoEEnsduhqoBr4kiaFwZNNM6ZL8wov6/
	/VMfd9VFgWDw+N8tiLNeUzuKJT8qmJsD22Nd/SaE9hJJ5Crws4sX3Zb9kfwp9MWM0C/sUqd/3zRZJ
	4aYJT2Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk8GY-00000001Zae-3bU5;
	Thu, 07 Aug 2025 21:35:14 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk8GW-00000001ZaM-47kW
	for kexec@lists.infradead.org;
	Thu, 07 Aug 2025 21:35:14 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-af9a25f091fso224740566b.0
        for <kexec@lists.infradead.org>; Thu, 07 Aug 2025 14:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754602511; x=1755207311; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmaL1qeIX6mdGDdbYfii2CxKmsjI+RXyM21bYE6XWMY=;
        b=SzWcbE30djZYuFIvqvQgYty1PX1OEyKmgxbvE6k6XfRFjmXNFLKGNJrZwULnVgdx3R
         eIqT1BB2RUCI714QIGHJLe9U9Mg5/yztK//D3iPnQKOXEz4dQy2WQ8Cq8MwcV3C8vcHx
         fscLdcxo5xfJvvizeg2HKvhIVfrWlbkTudbiuWcT1HWg+BDmjpYyoLpU97j+wcv0AVar
         /6U1fTq4qEm+I8dt3eAiGYR6G78mTtzjBceYoQjUXT7cousE9iTTbBt0tZgn/MJFbNXD
         UPigfHysGUpgNZJMe9LIF5dEwmWfWcLKtMTWuM0s2wyUEjETSER/WvhN2sqZF5ksFxIx
         gV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754602511; x=1755207311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmaL1qeIX6mdGDdbYfii2CxKmsjI+RXyM21bYE6XWMY=;
        b=hcupkpMAX/umRJsGaIJYwnko7YssJjXRAnNuNxNH2CJslr432+lNI1nncYfPzz65/c
         TwFJBJgibB+LUIDFcV0+mE/r8QOdk3QINmgFDMsAonOJkBHn+FndA6+4ebSjUQKAbCa7
         GCL0qOobHtSbXQjrqtQa4NgFSKDvlE9fTOMm/G7Be22GHHvYQf4POjqw3IJiOD4A/qH5
         Z68sWfqBorUQwuE4Q4n7utk8jqEdXoHJe2g7ReDss2EiprsjOz1d8qZjiuL3DaS+cM7m
         HVbq0WScQnyYQ1uBh1nxojuQ1Fhxbz7elgGUTVbDBaHbyPlqGD+grnRQblKtJoxpd+Tm
         4jiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWWWy1lYJpigZ39Ykn5eR5KRQlnj9ASRhTv7+sKuqWunuEVcrVGA1iJID0kyEbp+B5TeuWhQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw1Rj/JOcFKojMVLcdzBv9We7+nPhLqM6eT1snmjZn5d+EcV8Hv
	ROYLoet3BVTmL8Wb1i7nsQxe250VspIW6xXISSAcpUEDq/n+otD6GyA9+VVpzZBK8z88R1Tp2Lt
	NftWMdJU3iJR8w0m+kifvYBh7wcgSByU=
X-Gm-Gg: ASbGncu+bJHY6D3KDHFBx8hXU9Eek018KB39Nb5bQGoHO3fmTpGH9aZJyUxY45nDwCl
	d92qMYVLZ4ZKulxuqF8x0AZ1vsJMBFYDPGIf5uadCi+PKW9knJpmklDtlro9LVucjQwTyNiPw7q
	dkqUhMPSh94a8CFCOXO/VtXH9b9hH+N9HriigRldGPRvZteecLNFVUh9/vKIOwm2kDWlokT4FKB
	Yp+sVVFBA==
X-Google-Smtp-Source: AGHT+IE3PgV7JQ0jA7AfXMT8JVZ9a0wxQz4SkgV4QeBWrVoxKFPx69GnMtjz8pH96NjQkSuwpMj2SMv23zNjgi9OgGk=
X-Received: by 2002:a17:907:3e8d:b0:af9:b4e9:8677 with SMTP id
 a640c23a62f3a-af9c65b3ac3mr40460066b.40.1754602510986; Thu, 07 Aug 2025
 14:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250807032510.4211-1-safinaskar@zohomail.com> <20250807032510.4211-3-safinaskar@zohomail.com>
In-Reply-To: <20250807032510.4211-3-safinaskar@zohomail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 23:34:34 +0200
X-Gm-Features: Ac12FXx7REXqip_TCiEeSpB1_n8Q7lNhFeidzWZhBFQNZ1uEGRmhgachgtSZBh4
Message-ID: <CAHp75VeF8nSTrVPbvPP-SUP=OsvNSKCpDDSn30CO2UmENwMCHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] kexec/kexec-elf-exec.c: Replace %lux with %lx,
 this is what the author meant
To: Askar Safin <safinaskar@zohomail.com>
Cc: Simon Horman <horms@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_143513_021055_C621B1C5 
X-CRM114-Status: UNSURE (   8.91  )
X-CRM114-Notice: Please train this message.
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

On Thu, Aug 7, 2025 at 5:29=E2=80=AFAM Askar Safin <safinaskar@zohomail.com=
> wrote:

The commit message is always good to have as the Git summary sometimes
is not visible (some Web tools, for example) and usually assumed to be
max 72 characters.

Besides that, in this case it would be nice to add a sentence to
explain why you think that the author meant something that was not in
the original code. From the Subject I may not deduce it.

--=20
With Best Regards,
Andy Shevchenko

