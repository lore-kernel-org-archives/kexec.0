Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B417FFDEE45
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 18:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xz1kG4GLCvqQFzeXh7n8DWRNtWprzVemNcNEfPAsXwo=; b=fshrRtQx3ZRgqL2cwEouKJhX99
	waSqOcBVkbCjU+eSSdTSDf+zMxLVccezB3osm8euqim+qnjHJdvwlX94/DpMvp1+y+g4O2qoAUlg+
	XHIlU59FgCvHdWlEHgJ8k4CvuLzNx4RQl4AuNE1E/i6PzW0UxeRkHuPMH4oSq39+u6z4ryJcHciEF
	We0Y8VwKZKmvBIww2sKlVS4zEwBIxEPAAsBd0NjGpojfrknnb/fAArZzlZQOV21pLQedGZfyXT2EC
	qzl3hPJiSHGNjOx+FZh5pzq8jhbwFyEC/2lqWqLsxwyUSKNXBXlqA/pGDSKXOdwWuZJvfoeNHpt1J
	tpLm+ONg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFyzP-0000000C8M6-3VyJ;
	Thu, 23 Apr 2026 18:41:27 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFyzM-0000000C8Lm-3x0z
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 18:41:26 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-38e7b8e3f38so58723871fa.3
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 11:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776969682; cv=none;
        d=google.com; s=arc-20240605;
        b=VPcYbjM9T37oeLX1tE71Tvo3D9P87fvUs7kr88vQl4upQc43Bv9413RkxgO8wD3GUM
         4FYDY8Vu96mBlZW0tB2j8O0rcPmTFInVEGkMjgKUNQaUAkPOPArLVKzbD3FMYsU2lmoy
         efxr7/vBq9SDtbmWNjxJiLTepqARDIqx/BsHdluHrsp+jPbU892MyFO0aV8/TSXpnUTY
         3UQYLMdO/Et8rVR+ftmatxWdzXxiNvZ8Ij6UC6nTAmciMgI0SYHPSLLlqspB1YJUQdz9
         dhZbyg1OeiWCJ0cyy8OVJMHV4R2uTL4hz+E38Tbk3gMArInCS4hrQ5cRRfLcI2CBzG3o
         j2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xz1kG4GLCvqQFzeXh7n8DWRNtWprzVemNcNEfPAsXwo=;
        fh=DV1/oP9HWtj75pYOp1oVBaosaDkFBh1vyZrhfLSjZcw=;
        b=Zb7x4cYhTkPUsszgWyluGasZVEa5qzPSFcr9Zmtt1el/jgCUGbw48f2nJBtmVgRnzT
         7Ttr0PVx+CJxjvabjrhkj7Ug6VDJOV+7LgkxzBY8Pha5ZnQcC68CMoa45M3UzO1JXJ1a
         LSCUzxQi2sDAriBtuteo0K1vRUruxnMxM5/wxjLJpTWv4uMVYED51VbwpkWPQCtUsX89
         ub8wdGSoBWflNqLBVcdNNOjn3uMNNGeYV0lwYmPNX49JLQSJn9fChpgg5/monXKGWFyG
         fmhVkreT4/2iHg8V5+rgwMZu8jv1yCFCQiyKgep9vEM5ZvJuEH7zCjstfnF9KGWX3Xdl
         7xGg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776969682; x=1777574482; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz1kG4GLCvqQFzeXh7n8DWRNtWprzVemNcNEfPAsXwo=;
        b=ev3NJXVjdD1Q+Q4vuTtz2Vy3fc9amO9L/1Mi2jgudXK7xy96tHsH748p2IYREX6GP+
         OrBc0LczfSM036JCC8/Mza9aS19DUgwkwfxbAM75P6TNOUgcN4OBdo0O4aAYmc4pXzXf
         7sI3IRqbrFgaGNsvKBPnlbH+IrGV6n45azkA3mLvJnthmyb9vY69UTEb4hMHcg6Vwpdm
         sqjxN2s8VhAaqPhq7qFr/Rdppxex4CzmyTk7f8ga7HcvSZbQjHOFuhtQrPTWJlTmjuov
         TMAAFVcXhsTcKds8PSuo90FkArLAIrbYDTdmm5sJxMpqZ/jcQ9p725JWj0sYLvUcyQC3
         MDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776969682; x=1777574482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xz1kG4GLCvqQFzeXh7n8DWRNtWprzVemNcNEfPAsXwo=;
        b=SnWPAn6foGQzisarNUZf9L6+FmI+6hzdsUeSzcS0TVZgj9E7FLDxjJOw8U3sApr/eB
         gvWtLxHAoSGHzpx8ZCWamb3Y5VH6/BRNz992schW35Nfqk5xtLQEJpgwZI3g41JYgah5
         1GSH/hlyy5bQZllsdlMnoeeUJkbGaI4WhMsh3jXX1JnHRxhegVLR/InpoddTJenvCtAD
         B0muCYbaQXNaGBeDIoeBMFa9FDYk2LepNa6p6Oj+02Xoq8payI9GP93Zqoa5JCDt55BO
         l+zlvaYsDiOCHoPmCdLRHczcPrApPVdmzIoN+wln7k2YiwU6WGX7BUbuX6Mcn6MLgE+P
         XH5g==
X-Forwarded-Encrypted: i=1; AFNElJ9MDMX46QDDg+NoM/PPGKaefJ5iF5951s8vb8g7T2411zh2d0aRh1YY/a8jSGJPsMaSmSuw8g==@lists.infradead.org
X-Gm-Message-State: AOJu0YyDJeu/kkhF9M31I7msEcJ3TGbuCfH1BmBtxDgTALvNhh2KSgMv
	eEm8dHpr2KtWveuGEKBNSyu7xbs8jGCd6ENVKGcQt5gEr98QdkB50gpEuWmN/GM/oJH+2BqxzF8
	/1CahY+u1v0nWdhjpW6jeKAPChwTk3cskULj6Yvno
X-Gm-Gg: AeBDietLEVFiBmRf1Rd/Bhdzqx7imS7sIgjRfpQduiw6n7u/B00n/ZTkAbWGlTTTdSW
	2/2ksv+xi5xNEL9HRAG6RKZiX2JLTjs6H5AhroTaQURqeJexHo8LTzcj4ZZTowhTuCXtONn9k+P
	rTnsk+kC49XzaBBWoQZE39bvxlHJu4W9sR+FCGjA6MTWbLvHM7s6WrIIrkx0N4Uj9NrbCRDHbfF
	YjRI897zajt4fvTfuz7x/+8h2VcyUEzS0+sSJuajU1pIvnDF4ig89nHAS/5gBs6iFhK3bbgeTns
	5WXV1K6ugUBgEojymJ2Rw8AQsZ6BRef0/MXGbbyJ
X-Received: by 2002:a05:651c:e18:b0:38e:e6fd:65b2 with SMTP id
 38308e7fff4ca-38ee6fd6850mr73331981fa.21.1776969681282; Thu, 23 Apr 2026
 11:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260423174032.3140399-1-dmatlack@google.com> <aepgyxZDc4evs5ew@plex>
In-Reply-To: <aepgyxZDc4evs5ew@plex>
From: David Matlack <dmatlack@google.com>
Date: Thu, 23 Apr 2026 11:40:54 -0700
X-Gm-Features: AQROBzCqNMDGmFOr6lSRc3MqO7e6y4Kr9nG_nXzgrUF8aY4QyhS_mfqX85iMyuo
Message-ID: <CALzav=e0vCH-q+=W6p6yH54zOmxDJE-UXKhLpT3gdS_ao9Yh6g@mail.gmail.com>
Subject: Re: [PATCH 0/2] liveupdate: FLB refcounting improvements
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_114125_041370_E5425CDC 
X-CRM114-Status: UNSURE (   7.66  )
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

On Thu, Apr 23, 2026 at 11:13=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> Please include kexec@lists.infradead.org so the patches are tested by
> Sashiko, and added to patchwork that we are using to maintaine live
> update work.

Sure. Should we add kexec@lists.infradead.org to "LIVE UPDATE" in
MAINTAINERS then? That way scripts/get_maintainers.pl works.

