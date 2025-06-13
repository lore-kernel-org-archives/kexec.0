Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8290C71151
	for <kexec@archiver.kernel.org>; Fri, 13 Jun 2025 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uhAeS2/IvRl+3Bzj9D4bvlYHg9ng/8TcHwD+T7mUEOQ=; b=QmBreSgwu/WLup7cO1Pg5ua4Aq
	QbBuUBpzvnzVL4qHZwHL9Ztb4hWoX2okmUx721D3CVDnFzClQ3XzRCVFv+dQ+LYZ+hD0iGiMhVvyy
	F/Am3tNRhk9F6iTBIU7lzotpqwJnULPWnvuLgz/xQKqYo0RuPxq9PfJdNFZXK2YUmaFB3ZOm01uEV
	Tv+q9938JnUnazNim0QdY059erbMgeUb6O5qVau/fK8Wm9hoyFsCB1F8RkAmwgD3WWkgJ/coHdf7D
	xvOnp4Zf5erZuY413BSRsWOTliISqTghAgku4oXxrkynsTEtefLPOlBS8DfUxqe5UaPfi6FH2UyiH
	qaeLPwRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ68p-0000000Gq8F-1lHm;
	Fri, 13 Jun 2025 15:16:27 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ4oI-0000000GZOB-43Lj
	for kexec@lists.infradead.org;
	Fri, 13 Jun 2025 13:51:12 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-48d71b77cc0so26838401cf.1
        for <kexec@lists.infradead.org>; Fri, 13 Jun 2025 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1749822669; x=1750427469; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhAeS2/IvRl+3Bzj9D4bvlYHg9ng/8TcHwD+T7mUEOQ=;
        b=Q3R2fM9HU68Q9XbFsJLOG2e1iuyEg6dCNWwrEt1h0kt8tg1yJ3dINPb76fQ4L7lnsJ
         ipo9x+o7LcheDZ7EDvR/UlLYX3RFMh/VgKuREqqcHJ+JPTO267T//ZUSn3Mx7Fdvwd2r
         mzXFZ7090XfSaE9gd7D6pEv1c9+SwEVlKF6HLC8hJXf1mGz/ZDbIMDjQuy7zZTmGIO/z
         Ye4ADFXQKV2QoujnVBe4NEDT9G3RYnEVPSgxdK4iwWzjdJEHjx5V/7lS6ZYPA0HSluxY
         q/adseeyN9aVv8ps6SiNa9G9NeUbvq3gW4SuNM89kf7vYC6AARp0NBMxtYotbOIAB1J3
         X34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749822669; x=1750427469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhAeS2/IvRl+3Bzj9D4bvlYHg9ng/8TcHwD+T7mUEOQ=;
        b=CTthiUadcS3dHJWbfP/8om5YEbtDNgNCBIY1s9G9L8w2yDuCd/DyW9lKSTF1vcEFjB
         WUAlHJZm8Fqh3noukb2POb6adDj3CRhyMrbVFMWUEXtBrxMbk/guAtDDdI6KFvnNjbeF
         9z5gzPiy8fHPJ7uipmWNVW/7BIgM5Il/zLGCKaOUkUMP5oqUGgYktScEeVSE6s04mf/F
         9BYUunBV4a2yfYOZoMKF8D1oQwPa2A1mxmXb3mom95snG+pCvRPZAVG4Aptlh7srkqJP
         e58WARdBp3anE5L6FpqTJfac3gG7EO1cIEy6hmkvc5i+H0SjEWZzj/RqsrTAkPduXV+s
         K2cg==
X-Forwarded-Encrypted: i=1; AJvYcCVyOYgu926Yz9JtFxPocleuAaHNDbOnzszpqNy9VMj4eejiz2C7XGKi+iZlrjHgRkkrz4e82w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw3qMzOxsONKf0xfs0HsLY7dQFuwYG1HEMpG8Vi5UYjLjCXJvS9
	Eb7Jq71o9dFfM/cdSuFCRm0TqmnKP58XME5+TlPnV1DxODSpPC/XlWUUV+7m7hn+kAuxX7KVTdW
	5Q1Hfzb5ZfOYDkWBm2Ipr69Qig8wx8OVaG8yqIkR1AA==
X-Gm-Gg: ASbGnctBmT1mT2uwqdTk8yLx08dLeY16nOCovfzJBVl2vifazqllHT7nfVWTMnr+/Gb
	xaQ5P77wMShmmeDlYSpXPAp631gSOD33Vn4sgVeqoyziS0hB7NBrjarnc9vCZDfAVN3siI0dswq
	rskgSszrryaOkVB8zUc3zMdJqwtxsY7HCLmEDLND7C
X-Google-Smtp-Source: AGHT+IFYcaXWQwJ8CBpk9W1pt46Bf4+vPWaFiVIFLbCoUB7H481bLuHjLj5oM5Papt7OZLf3AWNII0ghPNALr5CtPag=
X-Received: by 2002:a05:622a:1f8a:b0:4a4:30e7:77a with SMTP id
 d75a77b69052e-4a72fed8a6fmr52111111cf.15.1749822669449; Fri, 13 Jun 2025
 06:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250613131917.4488-1-pratyush@kernel.org>
In-Reply-To: <20250613131917.4488-1-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 13 Jun 2025 09:50:32 -0400
X-Gm-Features: AX0GCFvePpc0ixNyG8y1MRzHM9QVpjSrRM-vz2PlJH3pXBP9NTCDv51Jt8TZsu4
Message-ID: <CA+CK2bD_+0a_Z9R+0O9ZCc-30PP4U9rbxXVaenx=S2r3W1kV0w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add linux-mm@ list to Kexec Handover
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Pratyush Yadav <ptyadav@amazon.de>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_065111_239051_3B3B198C 
X-CRM114-Status: UNSURE (   8.86  )
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

On Fri, Jun 13, 2025 at 9:19=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> From: Pratyush Yadav <ptyadav@amazon.de>
>
> Along with kexec, KHO also has parts dealing with memory management,
> like page/folio initialization, memblock, and preserving/unpreserving
> memory for next kernel. Copy linux-mm@ to KHO patches so the right set
> of eyes can look at changes to those parts.
>
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Pasha

