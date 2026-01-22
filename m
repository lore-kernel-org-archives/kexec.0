Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57CDD6CFA2
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mouF04Fjg8ir5c/+5/uLoczeIu6+gVBtr+E4eejz/fc=; b=r6eTnvnWzDqHUjHUyz1AYaEEgV
	mEZry/eeZwI/RSYXu88zWS8nXbN8gMDdNh0CglMv7mcxw9THoMc25ecY7NbbK87ozinS0pWqL8bUs
	gd03mxIK2Ww7kah/h87dizwAYr9UkavL9gVT32uc5P16TauKYpLHEP9ZBMLSadcAU+xpwppEIjzPt
	URgcRSHrS5OZuaQuOPaxZ3a7ADZ3SPLXp3gKqZ/hFbHXaCa349EmEW+vJSzUEHHm84lIEB4BmrEhx
	fCzBiYI+pkj3l7rWRX1k2vHUmGyEwe4jiQA3+O4s51fsdt2NnATaAwdiawRm4ZGUzuAgJuQPmHary
	9DPr6VAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizPT-00000007dKA-23Se;
	Thu, 22 Jan 2026 18:27:59 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizPR-00000007dJo-22on
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 18:27:58 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-655af782859so2547451a12.2
        for <kexec@lists.infradead.org>; Thu, 22 Jan 2026 10:27:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769106475; cv=none;
        d=google.com; s=arc-20240605;
        b=Bp5zQp74vn5orEKzRmIlHa6Kp6/nP9cTflHj4PHhDB3F2WHfIn/jgqhLWw28+uz0gl
         N/rgujStVjGP5pf2HXmMZmioRX69mSXfwmFM/7JT/mUXflIlNmo3Lq1LdboAZvv45AEt
         Cei7laWNpRQUxKIpF1pFxCgZPfOThYdseOC5EN1S1QbkbBlwZWJkvHAJINbmzJ0V0sBh
         2GlAiLQc1itwPvf7uWxeu59YxhtVPiRYoI/Ct2vvx+pAVofid1pxBWl5zM1t4m8jNJKf
         aC6NUpYWzRw5NH5koHPl0nm8f2xteEfa299gH2wr+q4SOjD2mbw9/KwWkrYrpOzCHvTl
         2qJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mouF04Fjg8ir5c/+5/uLoczeIu6+gVBtr+E4eejz/fc=;
        fh=UPVAay0FewVq/A4HCGaReJKXYU62xPGAcxjwN5IGV/E=;
        b=fgwD2U5GAJFyAyf87+g8JUQDxeeeDZJH4AGGcaY3qXaN/Gsq+w47jlRxUWgtuFsjJc
         UIYM8jStRgo2ZWol+F88vNLfWQtH195rRLx1pQ6OTctcv6UjXY5OnaLPMUZ2lEAmdKvc
         0jVk52VkDuUWau7qVM6TlziKBwtyf47UGiX051PD/P23Cq1ue6Sok9egltE15XKUpp/u
         gHWj+XYoKsXYvEWRasSW/nRM6lVT15yA+/HBWFgK3l4iJ6I3t56+qIvd+iYW4hw0eE7j
         J9pzjIR0Flz2kDiLI2guNu7qrBPLKfLofTcYUL5K7OGL3vFSWkCU2ZKTl06+9D1IulOz
         zeCQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1769106475; x=1769711275; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mouF04Fjg8ir5c/+5/uLoczeIu6+gVBtr+E4eejz/fc=;
        b=LtV4I49QU+KDQB7s2KnYMTiEIEQQeZ2dOSDRvkd1KecgKsWVtifceMmvmyeXrLBgyn
         vtmKv8hKwrqtCsva5+CflmF8RwCkXCf1RBjQxaEo7DSMJt7gnPfqfz6RYiKDRMd97Q6S
         rNJ++ePoei1hJjokCllKjju9b3XPxLg6CTME6+2S51ea+x5NZ9SPw4kv3hyxYIVG3llr
         oB1YW9yczLYkMlxScOmChq0bD3DC5/9fg0x8ZSKhJbrkN8jo+X4EszXNGv3JDVkjW6lZ
         sh4rKiMnL3vPdKDp8OivRKgPCxc5ZVMUbXpCnlm6CbgvkfFRbMzYyQuGhdUVCmhhuCam
         nMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769106475; x=1769711275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mouF04Fjg8ir5c/+5/uLoczeIu6+gVBtr+E4eejz/fc=;
        b=vKyggcsDQkpoHHD3yBK33+/vDZ6svGYE18KLmShHCJNGL0Ns3P/37KUficlwkgIxRP
         gTF5990332EArzuhIsV2QINahEOHjZ9T2s0BydnX1c3tKvPUCitdL8wWzH4FoVzXXhqp
         gkgjjxF9H+jjot/Xj1BSwCObP43WQQ+CwJcExkG4hVtIewHLnSk9TkjbEAJK9yIEmynO
         SIOigIGtJlS8iWg2jncBlkhPAUY9j38UUS/yjH24hkdn8ZddoNrrYAsRn8HK/7JKPs0+
         AAXgdMFnAaQ6Qa+yJmTugn39LhqBOxNkGQTVG6o07bQn7KYCDY5KVdxqCK/oNTv6ZScB
         LYhw==
X-Forwarded-Encrypted: i=1; AJvYcCUFmB2VVpHk2RBdCMXHI5nDqnUzXy2GXHPdpKbs+okwZg2ell1MooyPL6x17UbEz80IYev73w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZ8fnPNaV6qUetL0Mja+Cy3gEDTw1mLTLlLPHF5rKxVaJWP0Bv
	Y00o8wmIDqpTybAgG7sBNwTacHiO07Vuo75oXpRrUTCfJa0MUyPPfEExugnbgUOUATOWkhPWryG
	o8autPWsJmM0UuQhEJOEqXeF54xDQuUZqL3gCrz9+zOPRzwOPWAG8
X-Gm-Gg: AZuq6aL85rkydioiM3v+7HeptUCAQHMAi6lRd5TNz0F5lCovf1lwfy51z9KBHMkPSmT
	aLIEhPfkusk6xRetcaLeaV8kSFVErTUDSo2DIcHSL1mzpvzU5LNLMyJfms/wSXHS2Kfxo8XOmwo
	tDtr7+96X7VH5keLwn1xnThnY69fOqfs9kYqxm1t+9Zk4CwpS9RztPsb5bgo30y5U35UP0mSw0a
	oKoEEBGv07nMuhthPWPPx75a/jKX+qPOWBNrywI55QKUIS8rf4XUGV0Cmg9BbquscgGNRBO1dDX
	sxpwd6SWjFMpBKp8tGHE5m88gw==
X-Received: by 2002:a17:907:787:b0:b87:bb45:bd5c with SMTP id
 a640c23a62f3a-b885aeea0demr12601766b.58.1769106475582; Thu, 22 Jan 2026
 10:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20260105165839.285270-1-rppt@kernel.org> <20260105165839.285270-4-rppt@kernel.org>
In-Reply-To: <20260105165839.285270-4-rppt@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Jan 2026 13:27:19 -0500
X-Gm-Features: AZwV_Qh5OQxnhkP1BE91ywGY4oJqPabhz38UybbAGCSh0mnJSMFxpX6QR-TTRaM
Message-ID: <CA+CK2bBzv4mLEmFSQszHdcO9x+YJ+UA001KNvS2of8o_Wa6itA@mail.gmail.com>
Subject: Re: [PATCH 3/6] kho: docs: combine concepts and FDT documentation
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Jason Miu <jasonmiu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_102757_544212_BC59C83B 
X-CRM114-Status: UNSURE (   7.56  )
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

On Mon, Jan 5, 2026 at 11:58=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Currently index.rst in KHO documentation looks empty and sad as it only
> contains links to "Kexec Handover Concepts" and "KHO FDT" chapters.
>
> Inline contents of these chapters into index.rst to provide a single
> coherent chapter describing KHO.
>
> While on it, drop parts of the KHO FDT description that will be supersede=
d
> by addition of KHO ABI documentation.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

