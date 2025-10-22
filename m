Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CACCCD1BB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 15:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cgJzKa03GZx576mtvOE16DNtsuFs0o60bnNsCmFfVIY=; b=C4VOdFAKs3cr8x3haBcXboKrn3
	jNugD4RnXDeC+ZebOyltlY5aXrLEfZ5Mvqrfrtz6Pj/HNRyJL0+l5M9Ks1CUAzrD2WL/2IJmGaO/A
	upJuiwPBaiMD72/xRBCwIm0h3hbtGFvvXMUWFpyJU6q124wG9kI5dhe58/M0C3nnyQ2h9jb/ii33Q
	0/OCz0ag50um3SQ9qPdQOP0h/B+hjKO3rAdk3KDDu9j/qnqrCuXjpoytaY6Ua8QGvg5IBbTEcszyu
	9nkY6Qd5wyRjogHhBQoiCQOa74j41iRm05N5rlnkuTgOeg+hZVqBL9pmoXuF/pGg/L2YNYbz9PKb/
	QU3vDKuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBb7z-00000003SHb-3Pd3;
	Wed, 22 Oct 2025 15:51:55 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBb7w-00000003SGl-35Gh
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 15:51:54 +0000
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1702452e87.0
        for <kexec@lists.infradead.org>; Wed, 22 Oct 2025 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761148310; x=1761753110; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgJzKa03GZx576mtvOE16DNtsuFs0o60bnNsCmFfVIY=;
        b=KpWeN/y+JoW8NufKd8WGts8Bd1oWrEjMYouzxfaEjcqxzCRI30hrRfR5hs1Whub9z/
         PYpJPtlXnmBUboyKVV9TW9JxxwfCXnlClsJ12HJ13x18TkIIX+hYUbJpO8H6dwZkMURt
         wNlfiXV9YBoHVssCCSiOrD0vlQ4PO5d0tssvCJB4U8xGCMW7pilfP/zLybFGINUBFquz
         RR6olQDbf1Olmz6MHl+T/KP7ZuWvI5xisnCboVKp+WR83dPZLNg5Qp6nZ8jGwsbd+6js
         hlCTw97Rlb5FrScTsAJsOLtDvX/1SebB/UTVApnQ3dCFr5vxpOLdviKRmGQ+vDBeHJ90
         aweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148310; x=1761753110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgJzKa03GZx576mtvOE16DNtsuFs0o60bnNsCmFfVIY=;
        b=qBRStLR4MuUtM3qFl23+rJKohk/e1d0VwXjIsbXOII9P4B4xC0L2UFN4X5eDTSzZld
         4EzFd1iQAcemRxQU5+HWtEyyDp+nqXie1O2CrzUO3/+/nGplsncBkD8tw3p4wiF0ZQDQ
         S0eDC3lPWCVmzChljxgKusdjTxFy78xFh+0i+eafXcxzNbRAJD9AhtaB9IGwEtu5MKYo
         icuS+yfBDVJG7T2BS1Zuti9ykZVSqWr8F7MtJLkcWd4KKMb9Ut7JfrukQe99IByZw70R
         rRpq2kloJGzkl/z9wVextM8pxq1YsfdztUqcwbJQpnwA3mNaFVD+0GNvxFXU145QMT87
         wBXg==
X-Forwarded-Encrypted: i=1; AJvYcCUS8fbKxrtphrsvbAe7BgNAlfMemmay//gFATrrBtUiRLaLl6hT4bV5W0GI4jTpDc0F1jejog==@lists.infradead.org
X-Gm-Message-State: AOJu0YymFaXtmBvG8rU/4F6wyLswGeg0LYwcp8zDuITF1MAJ1hqlBQ0N
	iWFKqOj7tfnG/ZyeblF2zsyxM4X4RpZ2V9FZ/Nr3EUg4moh9FXOrd606UNR4NkKA5qMaraMauuG
	v9dOpuBIpXkI5G2MlkljER6yKLsEtn3O7aRSOqcGS
X-Gm-Gg: ASbGnctDvwF53vCCsdJWqTdC+5PSr2jdwt8Ncd7j/Pb2L8Bws/KKls8O3R4sjNzzNrZ
	20LJMPDgySKpwWfy1n1SfcBbYeiCocqqwHLCwagFQbqdiEtIc3UqR/qnxD48gNVlAWFjcJwPBjB
	FAWxQLoykA4xMNVbxg7udOpmXPwAVDtDul/KSwDp/EvnvYl/eh50e9whuVLN4jaae2TOSrQaAH1
	VEHf9gS3Cz2YrFaH78lo7yJX0MBOpkpdk7jqLsRSaAJDrjDSkqXWfb0/cFp5mDYzzbnjqc43Xo8
	ftMzmFJMweC8TXeaqzGYg3d8s2AY/kMthWpR
X-Google-Smtp-Source: AGHT+IGSSZ7EkpARJ1sowKr4CL1x11+h9n8s+EYH3Pd7Tyt3wlYGrWJ8L7t1Eu8PFP6//7mTYXclA5aYbFj49+berZ0=
X-Received: by 2002:a05:6512:3b93:b0:592:ee37:935f with SMTP id
 2adb3069b0e04-592ee379490mr907046e87.23.1761148309624; Wed, 22 Oct 2025
 08:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251020100306.2709352-1-jasonmiu@google.com> <20251020100306.2709352-2-jasonmiu@google.com>
In-Reply-To: <20251020100306.2709352-2-jasonmiu@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 22 Oct 2025 08:51:20 -0700
X-Gm-Features: AS18NWBmyjziaOJx6tw5QC8WegdDZjZcbgLt9Q6UtW6D8PSJyvC5fCPozboF9U8
Message-ID: <CALzav=eqwTdzFhZLi_mWWXGuDBRwWQdBxQrzr4tN28ag8Zr_8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kho: Adopt KHO radix tree data structures
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vipin Sharma <vipinsh@google.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_085152_798077_3F9F57FA 
X-CRM114-Status: UNSURE (   8.12  )
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

On Mon, Oct 20, 2025 at 3:03=E2=80=AFAM Jason Miu <jasonmiu@google.com> wro=
te:
> diff --git a/include/linux/live_update/abi/kexec_handover.h b/include/lin=
ux/live_update/abi/kexec_handover.h
> new file mode 100644

The need for this directory also came up in Vipin's VFIO series [1],
so let's align on a directory we can all use.

Should we s/live_update/liveupdate/ to align with the file/directory
naming convention Pasha is using in LUO (no underscore)? [2]

Otherwise, LGTM.

[1] https://lore.kernel.org/kvm/20251018231126.GS3938986@ziepe.ca/
[2] https://lore.kernel.org/lkml/20250929010321.3462457-1-pasha.tatashin@so=
leen.com/

