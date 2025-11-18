Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E87CEE343
	for <kexec@archiver.kernel.org>; Tue, 18 Nov 2025 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RyRTgkSKs87SB8s3jqLkcqh8DAVS3ymL4PEzUKP4wbY=; b=XCoILZanvGRlFY4/zsf+JKUFKG
	OiXYz+OmlxkFq7BtagL9/igHhws53txJScI0fw90V8wBjdyaFYyMYo+cqXY6AL1gvDFvGutNv8vdl
	y/WFWRvZ0iDRGZJjWDDPyVzinYO/O9lKqG6qukqq+Kq7wmA3nSq1jCs1CfvLC+y/X91ZnAMk24WEz
	yL4fV7xKplV1+7kkj5ICZm3CZznDW7ULSa4n8oN9V9oYR1tZeDw8dL32rjcuwCYomJ+kDy+7aWlNf
	drYIjRK3S8xS/BCMPZJEje/2EU7RDFGm//sRsW15hJEK45sLEPwZr1sHIh1LLytGvz+Tyy3DC04z4
	kL6zJfnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLQYg-00000000x8f-0E64;
	Tue, 18 Nov 2025 18:36:06 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLQYT-00000000x5x-3RNR
	for kexec@lists.infradead.org;
	Tue, 18 Nov 2025 18:36:04 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso233562a12.0
        for <kexec@lists.infradead.org>; Tue, 18 Nov 2025 10:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763490952; x=1764095752; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyRTgkSKs87SB8s3jqLkcqh8DAVS3ymL4PEzUKP4wbY=;
        b=IOKEpFaaadTdccnEeXtS4fYQoCh6PaNs64LYEoCuoV7TUNVbH4wQQPn73hM2D6jX3f
         MExD31USjvYPdJkhGZggL7Nq+B23lUbImwi5aNd/OmlOfMDgXCHVlYo8GuAxRaRc0uM3
         Ow+Drj7dBpxQ+EFdBhcP8wviL/XO7HELKyoXkz8Utijbi7GpxsJ1krmSwu+ifL4hoedU
         eyorMk80LLVLJiCBepRuK+6T5QeHixCkn1KMfXFr09U+Otdf8yK2LO38rVvXV2lY78XJ
         NiBddpJ+xcFUx0YN1v3m/BjdCQb6uwqOtUvethgY6RHE7Trq5mi+wFyOfQarCanZmFGw
         Almw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763490952; x=1764095752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RyRTgkSKs87SB8s3jqLkcqh8DAVS3ymL4PEzUKP4wbY=;
        b=IcDHOGLD8tYGc52Q9Supw1WSQx92y+Cgt2N37WLV4AfEX6tKLZjgwOM5rl5WOAE9cd
         osOvA5aQZ6HTZoTg3Pj3ikiH5OLIJEAWdmtQGcXBI+KfYfLIZ5e1XlKy9VqcpVo0gaZw
         1Zt87ZqS5z+ZtF+bH5JcFf8g7NIRE4s2a2Pc5Fag3VTeqyktYn1hBaBPuBrUkijqaiJv
         AsM9uxasgRj17SvYbe+V3wDouoSoFP3Rf8uPJmcQjOwLTOWIKxCFubTKEODWYdeg1PGC
         SZSq0tYLJ7V3XxYsBX73eSQ+De7mBD51kiOLTXJAzqIbhdWZ05xzMSQTn4nkPc8TtpD5
         Jd3A==
X-Forwarded-Encrypted: i=1; AJvYcCWw1FAEL8jsikJITScUhbCKZjzF0BQUfgcWYKIq2Zus5lDGv4cOy1ChFMVIvjdHrRQ+pTCvdw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzCQUs2s9h0gmnHBZTABL1+vbG1en6d0yYCCWbi7UcFTLmlyjlK
	vj1sYKsJ5dmcs9x0lEV6ewU0UHKyOmsV8mLisFgh2IrdpdlXP+cZ3NjO3dfG1W1Oc8pxDwQm5tY
	LBHA/xgb66Sgi+GetRxmoqF6hVOxQLOm8TNErkeAtaQ==
X-Gm-Gg: ASbGnct7wKzdZr430p4loIJi2MsTMiUduOuEtFqH481GzBfyY49dHmiAKynobntz0yx
	LjIR6sNMImyRhjycx2gDflOgASjeKV+r7hwJ53F7940ZqjEGIRWs4kSKtEeiWq3pbr24KNAVGRh
	aJZ39ZzlEgrl3c0ZrfSLFf7XIP+ugwhjEp8Ix3fcKdX06+yDTV754gBjS7VkscBGO7fSSLhS9vq
	rjj6uQ/SOTmWS5UHiKwdXw7CLHvnvxruwTOvSip/jrtj8Nx0B3HJ72kFZbdbS0IMWv+
X-Google-Smtp-Source: AGHT+IGY1b8vCf1fid4hLfUOxiAz8fmDTgBhQ1eRdZ4VYO7oROGSK3fr2sUwAVyfU+H5ZlCd9QfKeCG+BFuDsmYifK0=
X-Received: by 2002:aa7:cc92:0:b0:643:eae:b1b6 with SMTP id
 4fb4d7f45d1cf-6451a78c2a8mr289851a12.12.1763490951883; Tue, 18 Nov 2025
 10:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20251118182416.70660-1-pratyush@kernel.org>
In-Reply-To: <20251118182416.70660-1-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 13:35:15 -0500
X-Gm-Features: AWmQ_bn-9Az87x1D-uqAKwYqa32LAYYFMR57J5R9sIXwHik0qL2mN1dUbKo6LOY
Message-ID: <CA+CK2bCFxMvSsafk1VVQe=uUfFQMeDNtBSkTUexbfvpCeWocAQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add test_kho to KHO's entry
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_103554_319763_53B41B58 
X-CRM114-Status: UNSURE (   8.51  )
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

On Tue, Nov 18, 2025 at 1:24=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Commit b753522bed0b7 ("kho: add test for kexec handover") introduced the
> KHO test but missed adding it to KHO's MAINTAINERS entry. Add it so the
> KHO maintainers can get patches for its test.
>
> Cc: stable@vger.kernel.org
> Fixes: b753522bed0b7 ("kho: add test for kexec handover")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

