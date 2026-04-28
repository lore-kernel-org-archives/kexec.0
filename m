Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BBBFF886D
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ygmvO+HjfQ/QIT3NrCn1jU7XYrLjEGC/1MHEcBERi+E=; b=K1tYS5vTcdeKppyclbS5xzcAnO
	uJY3bLuvomuueV0xvHveHAc81OE/F76RRxI7ZiyyYRo6t1PQkuNYUy3xqmq4TVPpO9+LKKiMD60wC
	dz49cXfnpjNi8LDdf6otpOHnMlzWo+IRwenbe6x+nRkRnu2sld1bGELgm7AaEoEh9/HVoCMacAOlE
	urNojCvMfVhpe9GM0JxVj3GqTO1IP3orFFQOZ9Q2VQvlq2BSKPizRdot4NRoTpT8evVkLkl5iF0SA
	qnSA1Cons0KXOwy9x0tjzr6bNmjByvFAzvKEDtJ1Cl4iG/diZWEhFWcBAiJXZrVH9/bznO9ZxpE2T
	Aevfsiyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHmmw-000000023OS-298M;
	Tue, 28 Apr 2026 18:04:02 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHmmu-000000023O3-47qQ
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 18:04:02 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-506251815a3so98296171cf.0
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777399439; x=1778004239; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ygmvO+HjfQ/QIT3NrCn1jU7XYrLjEGC/1MHEcBERi+E=;
        b=cS/GVodA46sfjpReUlUuRriZ2FWeFHipq546nLQjl9py1Eljrr7ebZmZzMk8xkl0Y+
         e2fHLzkQQtfYejrcmSNiAihhKtqvs6+3n2znL9U0Mi6WhCHvr/88gtHU64PJVexM2waJ
         9O+pp5XNOdjC66wMvAjrGlvXqYeJCCq5Lh4/8XIY/NqlOVYHKLUJwVIW2kdOYOqrKwQb
         DM0qT8Bt3eGAvzjFfXbs1AaVOuhlLAygOg4Z1cldEXs4ckO+te4oT0DZJESeyOkW7uhW
         6bxxmPWYWG22exhid2S1fQo12RWA1UQBFk/G2gp+7oFhdJFpibCHcRAE0RX7K6HqTlqc
         ZQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777399439; x=1778004239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygmvO+HjfQ/QIT3NrCn1jU7XYrLjEGC/1MHEcBERi+E=;
        b=rnvusZOLnmoK8XEd3k7XOJwMZFVz5EP7dxJ2TfDiVCMV40AYQnxPOcvN/uOix3/VaC
         TsDTAvB4hRnvjdaEk1O0TEVBL7fMVllb95SH3nerVeLcdHjYymHZuUTBvHKyDnruqjuU
         b5RxtLsqpWC2Dfu81TyKOYOdMyJ2YS7lml1hbGTUPMhYjL7N7Pd7WcE2lFhxLmo2wS5k
         kTxIuYZF2M33dZc9YER9mHXFC3bRIkqkXoYXjTH4PGr38//yYmUm2t2BJ6wHeM0ebWkE
         aoDNvQSF6qRbFoQwBdOHLGX/c4js4ui/n38p9wwWsZeVEEnyYeRUj1u0vv7a3ZDX3Tj3
         lUoQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OGVsXpkx8Ah5K7kk1FtI2TcbJv3+RLKBJoXf8s8IVi4VcA9x6B57Iw8AQ+0x8Zjxzl7nebg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxO81iaODx7zoOCuP9j6UcrBApmDm5EUo2s1yd8ZMoPO0bsICHD
	uFRSkh5U+JsymHxPMCfk6xwlUy0fExfJ6sEpwdC0sdI4QxDnVpO2xo6FGVgpSXVLqNoCfR/ises
	8LVAzJgc=
X-Gm-Gg: AeBDievRMjZPq8pxPQQJbjy4SPVYFmiL8nlKOkkWPiKKd6SA9oUJkIVrBjmyxKKFR1p
	0zsrClaT/JL1Ie1qchD3HFgWZRZpDEE8BholL/VUre1riAdZhv3kSVibvBNpiTTuitXby9o20o7
	stadAUwLLOIWntG9exll5zyApKrmWU1GU4gH5sQWw9ADs/OrzS0xTbG77WsKo+Fo++u+PkKZmnM
	Cnhl/PeAhwcqm0u6M0Ir7LH3GeveXOTcH2JKU/GqY4Wdsixk8L1nZ9Vf6uyfz5rX6u1/d8/jP7o
	hNsE3p1yfo8c5S5wYcJ6/ekUDPZD7FyItvM/ci0azKWoB2W7FLEWC50E1yUID+TCIgnx4mjcHDR
	spl7v8evOj8KaU3HHzjyXxJRq/15AoDCXJ7pok9ajXd3iWOzCdAMRVvsct3Q1FFZiztjmoZIT7P
	E0sd+XEaEdziCaU7SzEhnmOUlx/xCB4I8jptwDEyN6Zbuzo6Jhns945pOeB3qrWA==
X-Received: by 2002:a05:622a:2b46:b0:50d:72e4:6df9 with SMTP id d75a77b69052e-5100e1d5947mr53671811cf.50.1777399439130;
        Tue, 28 Apr 2026 11:03:59 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5100db4d0d6sm23431901cf.24.2026.04.28.11.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 11:03:58 -0700 (PDT)
Date: Tue, 28 Apr 2026 18:03:57 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: add kexec@ list to LIVE UPDATE ENTRY
Message-ID: <afD2eRh4yxP6Fq9g@plex>
References: <20260428124833.1903302-1-rppt@kernel.org>
 <20260428124833.1903302-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428124833.1903302-3-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_110401_026814_FCC1D945 
X-CRM114-Status: GOOD (  12.40  )
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

On 04-28 15:48, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2685cbf89b5e..1be7d97bdd8c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14895,6 +14895,7 @@ LIVE UPDATE
>  M:	Pasha Tatashin <pasha.tatashin@soleen.com>
>  M:	Mike Rapoport <rppt@kernel.org>
>  M:	Pratyush Yadav <pratyush@kernel.org>
> +L:	kexec@lists.infradead.org
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
> -- 
> 2.53.0
> 

