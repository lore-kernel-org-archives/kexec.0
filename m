Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B5DC87FDB
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 14:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fTn74kXTenCe2+mpLi8VY9GhjVyOuZE2DKDiF5RvCuI=; b=JamXr04/Yb8m1xjY41r7XlMnZr
	MKsgtpYAMyWvODo4QCCeO4tedw8bBsPIrOJxRHwoU1n13aWkoEBhAgZo9CWEAdIA7NJQB7OfokOnM
	BMlwiMKXijreG9JFVbiMMtu2ueEES5+EWhEhMWdw/T0xRjfGWoSHuWqxhSXHPxwofzr9ZTz2dJ3hE
	m+GpnKurrrlhu9UmhCcQJN1rAnqgfsjAcZZaZrAtkXlok5ky/lgXqiBP/v8bQxImzYona8agGumUG
	CsPxbwZL1dOHU0JDtWD76oy+9eMpZ6enP5t/CEwNTRBeJNa7al0YZRbPxOiHc4T4sytDy7JaJSVqz
	xwGsKSJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulTKo-00000007zap-0wTI;
	Mon, 11 Aug 2025 14:17:10 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSwZ-00000007t7j-0ySV
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 13:52:08 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4af156685e2so67185401cf.1
        for <kexec@lists.infradead.org>; Mon, 11 Aug 2025 06:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754920326; x=1755525126; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fTn74kXTenCe2+mpLi8VY9GhjVyOuZE2DKDiF5RvCuI=;
        b=G1WAcacHJLBm/wZlIKKrSa2o0a+QciWjrPyLpZW2OLFFVIZqpn0hvT0t+fDAsJzix7
         SBX87awqdMH5KrXxA7WWyfwim2jigVSopnnoDXO+SucixCVYLU1KCjDJxBhrKYb8E+d/
         Le9tKjvd409PWyq9Q90EwsMaboNiSD2TrY45VeolJgoegyGcYrhaZEAUZbBXjDjeQ1Qx
         48AviCBl+TPGjygQ3TggyLZyqsMHJSAGe9eazILlEsSnD7OjVmAvl+5CdqhBFRNTI7CV
         NlSMiPnDFElCCbn1xucL87d+vuXvUtdEZwqPT6OCJHQFVrKLGfSWJYGo7z/tBuExqWbl
         t4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920326; x=1755525126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTn74kXTenCe2+mpLi8VY9GhjVyOuZE2DKDiF5RvCuI=;
        b=fMUe5DfeXCzf74bam+pNX6gTAny92kz39vMMIJ8WYuKcp0G2zMOPLnVTX9nrIzZXmz
         QHZwlM0qj3yOOs2xgiIMlB72JhlTuh0K16uqCJEPX330sHIGQxuDvsrwtMdZVJMLcb2O
         Iro4FCYaeS5Olqi4MJ9X3T52qCsw4eboB5zOIYYYcwHaCtOFJxST33oAMCqf0xqLhvTM
         VFrJaPuOB+T4e2bNaFV3cCnUYsbMvlrZ4POqTbggDuT1aQQiTHOJqxrc9vV7qovG/0Az
         QCf3Y1T8ukCvDDUh+LbzAZl36fzhrRc0MeCXKqolPABsoLq2cb6EUC2fsnNscLLGNk4S
         SyNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcRFebtzsS9UUdPenHLsX3Y+jKoF1STOUBrIYUeF4FV5PLuVwAzK1Fokxki6Vbv27Fp/FUUQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywa4UpAvo55hoP7BKk+7ynFy0U071zOlkQtBPHgVcsu70SbzDUH
	hWKPuuikep6kaCou1JMrDLAhbjfFPqRXTTDd7b/FObjGlS/6T7Fo7n8KmT4+rF05hVFSUMVI/4+
	Dwvz6Z/ApkZi9i/Uds86eb/xQMbJXk4B/pvMpKZZ/EA==
X-Gm-Gg: ASbGncuD3EhrXLcyaAI3emQD9kv2nsDKs/o0Xr5zg0JQ6CKInZSPz0Sl8hqir8sFFAt
	fTRMRC3/Vd6nuY2lA6s+Zy2igOct7/A0n9YKS4Wlpd/jhiLtHKZtnBU8YDgrQpdNeIOFVBg6Ss5
	ll2GOEDHqAD0B4z0QK5X+7u4Mc8gCbrkfugGMDALLEsZNS5NgyRJ8c+kDIVcyVxlNOCQTgu/It9
	tHS
X-Google-Smtp-Source: AGHT+IFjGZMR0QC3maskM6Ppr2PsYUBGxXmOyXxknJLVF0Guw0qbzv3Uek3nZlX+0Fi9TLwpQwmiNNtUihpuPqK37/s=
X-Received: by 2002:ac8:5d07:0:b0:4ab:63b8:3320 with SMTP id
 d75a77b69052e-4b0a0814fa0mr205321201cf.23.1754920325560; Mon, 11 Aug 2025
 06:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <05f47f4f-524e-0925-9e23-bfa7286d455c@google.com>
In-Reply-To: <05f47f4f-524e-0925-9e23-bfa7286d455c@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 11 Aug 2025 09:51:27 -0400
X-Gm-Features: Ac12FXxgVHHQR2XNHo6Ln5u1bpFpbMFBWMIT_RQnUZCHHdyi-Fvosfa6QFSyvoA
Message-ID: <CA+CK2bAC84Kmov3+zHjMnH38Ux8kgyxPqeptg01mYCUhzYRpqw@mail.gmail.com>
Subject: Re: [Hypervisor Live Update] Notes from July 28, 2025
To: David Rientjes <rientjes@google.com>
Cc: Alexander Graf <graf@amazon.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
	David Matlack <dmatlack@google.com>, Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jork Loeser <jork.loeser@microsoft.com>, 
	Junaid Shahid <junaids@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Pasha Tatashin <tatashin@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Praveen Kumar <kpraveen.lkml@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	"Woodhouse, David" <dwmw@amazon.co.uk>, linux-mm@kvack.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_065207_274189_6B7F8BFD 
X-CRM114-Status: GOOD (  15.16  )
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

> ----->o-----
> Next meeting will be on Monday, August 11 at 8am PDT (UTC-7), everybody is
> welcome: https://meet.google.com/rjn-dmzu-hgq
>
> Topics for the next meeting:
>
>  - follow-up on sticky preservations with KHO, any additional insight
>    provided for MSHV use cases
>  - update on LUO v3 and akpm's request to rebase on top of 6.17-rc1 and
>    send v3
>  - discuss enforcing single open in LUO and also support for using the
>    ioctl to get an fd with a session label
>  - design discussion for luod, the agent previously referred to as
>    LiveupdateD

luod design: https://tinyurl.com/luoddesign

Comments are greatly appreciated.

>  - update on physical pool allocator wrt folio support and the ability to
>    pfnmap from within the range of memory
>  - update on PCI preservation, registration, and initialization, and the
>    RFC patch series posted previously
>  - later: testing methodology to allow downstream consumers to qualify
>    that live update works from one version to another
>  - later: reducing blackout window during live update
>
> Please let me know if you'd like to propose additional topics for
> discussion, thank you!
>

