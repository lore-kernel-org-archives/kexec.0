Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690BFE9A03B
	for <kexec@archiver.kernel.org>; Tue, 17 Feb 2026 21:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CrejTwC6HRXWqV3w5dWaP4svnxkBSXMzKVd6LUpxqiI=; b=u+6bAMKsazpeAB4eP66OiF9N1H
	W+1pbkJuG9Mk1JsHTDcqGqpja97yohs4xSlz9pZakQWJVSQhSA3dbH94gkYlZnaPC27KubwUg75dh
	WxERiHhAoDTZK9osuLovHaHjauEps9jERGKJn6saMhK4vGLoy0eIEe7cv9sJM+zKmC5JnHNsgCFRc
	7sDyBPzHPHnx3YVX3SLG4aQkA9hzzbDkwU46JcZuV2Hlc3EnBR0FrN6izo1lmb57u11ID8bRYkKtP
	uUrd94vInZ7LRCjIn5+A3YSCPSvSkt/RIo9aHKV4rX8yzvI54wp3wBROcml+xtGW0bf8xzOCFT2Kb
	Tfnb1I2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsSyW-00000008wgo-1bKr;
	Tue, 17 Feb 2026 21:51:20 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsSyR-00000008wgE-1mc7
	for kexec@lists.infradead.org;
	Tue, 17 Feb 2026 21:51:18 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-5033b64256dso184681cf.0
        for <kexec@lists.infradead.org>; Tue, 17 Feb 2026 13:51:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771365073; cv=none;
        d=google.com; s=arc-20240605;
        b=g8Uh5bY43EPwEHdLK09SHO5cHjK+xXyST4/srz9B25lZgUInACbNk3T9gTuLy3um3C
         my41IOQRpPExWz9kbQJK6zNWPd4SxoPFHaqeaHtJwvo4l73vs8BhSxG7anCxJPTpsj/A
         WNxQAKpSGGr/+i3DbmdOJbkv0fpF1hJN5LVgvF/W/tDnq8F51gKYciCaKWvddnlX0m7f
         K339FTHEoTcBFReTKNhNQZW7Fs8+FwuMdOhofm+5xUvTStnDlbqc3HcVFVSglTRGLkm6
         FF5c/9PZgsD8Xr75oGvxQCvVk4oJnPMgr+orZQvh47hG/MtTuXIUPLlf3S1kgmKac2te
         C+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CrejTwC6HRXWqV3w5dWaP4svnxkBSXMzKVd6LUpxqiI=;
        fh=YYuOIDQYPOds8zPprz38qdiQpO6iPUC+t0ddt4rgH2w=;
        b=PSgqr8HdIErFlpdexnHsprBGl/tCHg0Ah7G4XY0TPZpl31yqme6X1YMCti+SyBkbcc
         Z5hN2+hEhR0DRrOGM4UOEfNwqBwx/skyEoX8FyBEPnqa0JXHwMzDCirKXKSbTTZS5gzZ
         Bt4YgO/7pahgFZEcrio/yIKFVsIeOs7ggjXzNBHnmhilQ4p77T60v52QoX3nVdnUEH4s
         rRe4GXjioRDfOSdjn/ONV5vgdhC4KSMZ10sYkhB1sTj9BbzlJutb+i+qgJqAd6W+AL3M
         KwMzkpVzZDzWkTwjLy/Coid9WZIleJpx2vIZ1E+GPW7Vep0ugceHupW4d0/GszQa/Di1
         BDSg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771365073; x=1771969873; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrejTwC6HRXWqV3w5dWaP4svnxkBSXMzKVd6LUpxqiI=;
        b=vPQeVsWstNvnzd7wqN+SzeZAZP+N/p5D5eDULRVWuQvWQRVm1ATo/4KpiHfwft/9dt
         QGvhEodktJk6sCm78iHcY60zq26ECLcL6rmOk2ZG5Gvwnd4+58HQT+Md7Rby63gSZipF
         l6rupbjhWrEfkrlRb1NyXTXuX1i9XXrOdJ4vYmg8egL4m9MmrOGya7UHPA8J2kktDFF9
         6yhvFm1RGZUC8QFi5OdpODrHrqq1ba5jL1/ESwGEgHrE88vfrL/AlVbVg32ykbc6Pymj
         hFnq6pkIYvHm+sQAJhKlek/TPvtbdmeJ8hOnXLy4bQcaYmaaruIbg5omd24bay0IEE2F
         Yz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771365073; x=1771969873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CrejTwC6HRXWqV3w5dWaP4svnxkBSXMzKVd6LUpxqiI=;
        b=wgQS4ThVs9o0INMRK9ii23OgI5TIItn6ovglV1x5tAdHjki9ZAtPsOxrWpVDdgg86V
         SQENWXmZXBp2Of4pUzLT3d7LQGtAlerCpOxeGr/cJ3NpDdY5V8Hl3hCALExZs9S0ASwm
         Pex1ns96w5NG9apSlWahVLTb1Xozg07I18k7VJOjW6iJ0cYP5xEkuAl/kYL9QS4WY9tR
         ic4tiElrwRiKMtJVtjyNyouIh6LKVv8NepxdfHcdDujZ4g4ZM3rnxgmJOtRbCU1eaq4Y
         sHg4Ojyh8C9ojVL7VS1nntqYWJPFtyQZl86YiWZ0jRsvzeGc8EmwkqZ8j2kkd7o5NpM3
         ac6w==
X-Forwarded-Encrypted: i=1; AJvYcCVlfsXUNiiVPcLUSJKQN4N3W4p1fXHfqyWuHv1/ULwcno1av60P0qQmeXqfnOk5H7Azb7Wcwg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxKhU6dBhNis3ap9y3hMx4D8O5Fyq6ZHlOsdP218RCSZDnqIeL4
	knTuadCUBaNbjMGfxOFm6or9hy7IzvaszviSOopAq2yKHzUM0ZJRcdiNR9DI1h+fG7sQeTZM1Sd
	SHBX11mmDeb6aQzztTNXjfjxiA1/bkbrchx24WSbx
X-Gm-Gg: AZuq6aJz/xns3JQGoTFE09+n83Z7G2phgjJb0fL4phdiaIjfvn6GkZdXUg8iLKO9Tqk
	hMHBacwp23+7bLFoP+zy7DmyoEz82wf/THQpTLJYkVFX7oPn33K6kyOI2Tm8oN/z/PbMyRVDURW
	YU8q0+1RL+70m1ML51SHlu8ytNAngRk5xL3xoxNqUyLfCxywtKoCI8/hJg69pZSZBvflL4i55cL
	/dZbH+tSj059mAimN5vJSHQj1DG2PFQ1mQK7m2AoN1WpfJFFDzkJJihZ83SjfnR2YCY9LQgt/SU
	aAEjC85y85cKrgP0UjB66P0eQXcTYvj1dwDrsb3Oyg==
X-Received: by 2002:ac8:5906:0:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-506cdb209demr23925201cf.8.1771365072676; Tue, 17 Feb 2026
 13:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20260216185946.1215770-1-pratyush@kernel.org>
In-Reply-To: <20260216185946.1215770-1-pratyush@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 17 Feb 2026 13:51:01 -0800
X-Gm-Features: AaiRm50qzGC3jHt4XCZiiavo0osc_e8UI64qPm53ZIqIovdo_Uo-mwrhf_TY6CI
Message-ID: <CAAywjhQ77zcA1wwf=i8vwG_FTtzJWc4d0MXz9aOuog7LgSSU6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm: memfd_luo: preserve file seals
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_135115_475310_6ED99771 
X-CRM114-Status: GOOD (  17.40  )
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

On Mon, Feb 16, 2026 at 11:00=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
> Hi,
>
> This series adds support for preserving file seals when preserving a
> memfd using LUO. Patch 1 exports some memfd seal manipulation functions
> and patch 2 adds support for preserving them. Since it makes changes to
> the serialized data structure for memfd, it also bumps the version
> number.
>
> Changes in v2:
> - Define the set of seals supported by this version. Support for any
>   other seal would need a version bump. Make sure the memfd only has
>   this set of seals. Reject any that don't.
>
> - Make seals a u32 since uABI defined it as an int. Change the
>   __reserved into flags.
>
> Pratyush Yadav (Google) (2):
>   memfd: export memfd_{add,get}_seals()
>   mm: memfd_luo: preserve file seals
>
>  include/linux/kho/abi/memfd.h | 18 +++++++++++++++++-
>  include/linux/memfd.h         | 12 ++++++++++++
>  mm/memfd.c                    |  4 ++--
>  mm/memfd_luo.c                | 35 +++++++++++++++++++++++++++++++++--
>  4 files changed, 64 insertions(+), 5 deletions(-)
>
> --
> 2.53.0.335.g19a08e0c02-goog
>

Tested-by: Samiullah Khawaja <skhawaja@google.com>

Tested with IOMMU persistence patch series using iommufd_liveupdate test.

