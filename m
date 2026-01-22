Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61998D6CFA4
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 19:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gyEozQAGUN8eF/HmAuTFVwwVCihu7gPto1FFI8JxTmg=; b=nHS+6KgITe8GVT/XBYKnjXh+WE
	Ggcl9M+fy0tL3LS0jwkyYz6R/LGem/5KXVEUSyrxMW++zJ75f7e9ENBStFevM7k6fi5d6iP2UGzYs
	lK4xo2lHnTE93A/AacrmWZssQCR7CbwRJvNHJLACYQB4QjNb4uFd+FUCtRsfJfB4lslyFJDdwl6sf
	MfRBxGoCxBRMelolbxqM9y3k2Riwl6+XOVdDupqfg3h73+yFyZptHVt48f49GHN5rRn9aQmihbIYK
	Qs/fZjyx+6SonM2oOehzA1vGQ35K+15dpIgH6leQ6vxbPJbqoTQU613wDVryw2ZYRK6aWCGJjd2v2
	3ZSesU/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj0TE-00000007i63-0ngX;
	Thu, 22 Jan 2026 19:35:56 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj0TC-00000007i5V-1JSX
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 19:35:55 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso2342657a12.2
        for <kexec@lists.infradead.org>; Thu, 22 Jan 2026 11:35:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769110552; cv=none;
        d=google.com; s=arc-20240605;
        b=h5Y44r3Lxw8n2Ra2TtDvNS1qMD1jnma3itlJfPUFGvhE/utu8ysPGUUhBKRTJ/DiKm
         +MW+MXtLy3Sz6i0kI7r3u5YkQoAz2ckUOV455LctbEscRAlFxk14Z9R9m4tOVWAC0reT
         m5aXvWVdcrkRCcLfQPXu7A7lx7/KnCIxEGvZwRNh/A+UjaIU6o77uZ60NFJg8J6XwoHK
         d4Z0AYcLHCw+JkVNLsXJ/5Nshnezzvdb68FL2u/0vRN/x8fMduuRtZDYf+eEjmHu0HrL
         rTiwTvAS7tettK7yWD45RWxg4sR3kDj+GnBMFexb/D/9acMDLtUPNK9J9jLntyJ3KSRd
         EcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gyEozQAGUN8eF/HmAuTFVwwVCihu7gPto1FFI8JxTmg=;
        fh=VWuoj8CRIhXIVM4k3a5pGfj4Mmfw3cYNWehKu9WsUiY=;
        b=cChk9DBzzBwtyXTmASifXOXS28ZuW+F2xO0mAFxlC65N5T847PWwclfYH6+kjQLEUl
         EN1AMqwCFWnIpKBZ1BpQKS3bkrlbQ8CyGkUAJF7d8Lx2ScmPAlAkZPiHbeu2NBvom/dS
         lIGF7Rm+gYWjnH1micP87g2NL4AGseq3km3nK6NxIhR7MrSsxYJ2ZZKrkvOzlVSXq+MF
         8NqY/v7iuFPbsMyTOBnVbGdv09NIES7K29t/6619OuhAV4Ub5TmwGeWS2BpoYgaqUSfj
         6qlAjSGmKuXzFnuyp+BopCSzzlTX/4gpARH0XDM+mzg5STCX+OzxIn8btRShPQ9EWBm4
         JzjQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1769110552; x=1769715352; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyEozQAGUN8eF/HmAuTFVwwVCihu7gPto1FFI8JxTmg=;
        b=hYfsQWNiPbQ6avcortc62FFQJhK36NG0K3la51zWnpCh/TQd+DWU8Uunn6X01lwkG+
         HsTHbDzL6svs52jyXUJ56odXytOFXVMXOBI2klyy9MTToQyooYhm4lAmnrJexX5HtYKq
         spNJBTn8LdELrsZzHwu4VUWvA2kKzer6m2WPFMMv7VZn4PBfEqhZxUV7KaAXoQSIV7s/
         vaLeJYAD6rWqjy0tjff7oOVqkDzLmGGB1BtNBr7boZhkJSNs1nWQuuRarRunx784+6V4
         fzQrW7X5RPl2WYM5ckqDxR6Vn0Bc+RtBmiEIKqlVZZv/yZBe2b352oeA13VL37kHzacK
         Z9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110552; x=1769715352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gyEozQAGUN8eF/HmAuTFVwwVCihu7gPto1FFI8JxTmg=;
        b=Z4mIqiKPB+o/F16wYf1VLtd8nXfYLnY24b8dpVzCpSE6OLH5D9lPiH2aMZl/KsEKy0
         aE0yL2tB7/X07ytqiFB9qT9WDlTZzakAs+3fVj+OlaUeqPYsrCjHy1cBf0ecfnAibAtq
         /YnvB30UJTzY4JM28hr56oL9Kh79Q0cmWP3OpGeUzfbTrhrRBDobBJYBHENS9tLB5pXs
         9n14p7s9oB+b360JlycffUKJpO5939ySsHNpX/lovV360PtPAytZlGrzV4KIjz4bE3Tr
         QoCBGSMoye/i5YymlQHYdqyr4PLh6kTP5RwD7YKwkTL+TTA+1LsfnmLRanlSjEvE3t7J
         NBzA==
X-Forwarded-Encrypted: i=1; AJvYcCWqrOm3YTSlbKjqoHbrA9phWG8y6bK3m8C5jSz4VguEzb14VMys59D2nfuAIhzwp9lkn2/vrA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzFNgdIMDQ31mDXcqbrK1WNkKGiiag9OtNq6qqfHh+1rucrSxdf
	VnKFuz33YQF5t8L5Yb2zx+hFx+wa7xJfXapPQ02t01F3X/yWo1sUp3Yx9URMKzRqYWtUfy60C4y
	KzVcJimaZrfRJynqCIrz0gi2Z/I0HMeJKvlqd+GpfOA==
X-Gm-Gg: AZuq6aI7eYEYS3C13+AjNs0f8nZBNICyXTdHJCyZniITRMBpni/aYdCtVI6itELgKKc
	MsKvq8w6UBkU+6a3sxn2oMLupjDNdLWqSD7fbcr7fx49Itz0Z5vQhBP6gishLgjQ4QT1yvM/qGY
	k90v1sCdKhwHPM46Xdl0gEFpGP3m01lOD+xtBCJkTlDvckMEetYw///fhKYBMp0YmVbo7xuEIrq
	JDjAm3T02w44SYSZiom5ndcr5XuNeJSDzNCmET7AM/pOmd010SKloUATrW99gFANiA/Oad/mSmU
	XFB7scU8w5my8eNf+QiGyytCdQ==
X-Received: by 2002:a05:6402:3491:b0:64d:1762:9be3 with SMTP id
 4fb4d7f45d1cf-65848762657mr439621a12.8.1769110552424; Thu, 22 Jan 2026
 11:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20260116165416.1262531-1-pratyush@kernel.org>
In-Reply-To: <20260116165416.1262531-1-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Jan 2026 14:35:15 -0500
X-Gm-Features: AZwV_QhXxubGRdqSX0oxMXkz26trejH0_IxVvQl1zrw9g2D_bxj_PjBh-rntby4
Message-ID: <CA+CK2bAG0byyZ0CF+jHq2m8bAMq2ACxtGrtQV2XvP8i=UH04Sg@mail.gmail.com>
Subject: Re: [PATCH] kho: print which scratch buffer failed to be reserved
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, Jason Miu <jasonmiu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_113554_385669_37085524 
X-CRM114-Status: UNSURE (   9.62  )
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

On Fri, Jan 16, 2026 at 11:54=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
> When scratch area fails to reserve, KHO prints a message indicating
> that. But it doesn't say which scratch failed to allocate. This can be
> useful information for debugging. Even more so when the failure is hard
> to reproduce.
>
> Along with the current message, also print which exact scratch area
> failed to be reserved.
>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

