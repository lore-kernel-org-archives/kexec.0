Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AE3C43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 20:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wwR3+tAmZvna5GpBM6IknnMly0341sDm9GPfoI+7yn8=; b=AZfkZXsBM38BJbxTBkgzYw52BA
	/k94JU0TNNx78X3LA+vmNVivSscMAUbHTAwhh0fbCJDZLMnLBQAZ7F0PeNEm+cfMsPCLjxuiD8qjp
	DYNEo7dV3uJ9l/fBUZdiuKVU7JMmyi1Y2fEhaMntrRTyzF6lKp98W2KPAxkGxtkQb4VC2SrhSuyns
	KlJLTf6sLksZN6R3f/vbV6RmN5NElTjgROx9RYkV0L2o5Yg4KFmPMbqcnrNBg8gWJbS9lGF9c5gU9
	wlQUx9FHE/uHDQHrxImTJYjVrS8k5TbXpX2HE2DPbylTe3kgHKahtVICHhHzj/fhNhscbSJAQQngU
	IsnT7y9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whvjA-00000003dph-2t89;
	Thu, 09 Jul 2026 20:52:12 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whvj7-00000003dov-2ht6
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 20:52:10 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2cac59f8b64so2642385ad.0
        for <kexec@lists.infradead.org>; Thu, 09 Jul 2026 13:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783630328; cv=none;
        d=google.com; s=arc-20260327;
        b=gn/tsG4U12vtJZsE90ghpWL88AtNi7tssLdh4uaWcas+soaaYEWc/KrUSN9JWFpSM9
         jnsJSC8Wio2dF1ibfI2zFUV2C/KRhECVUap34fzcrztlILavQ/Fh9poh5YH4Z5EdxbLV
         Ql7glIvJUDvTaekM9/PFvaHK/WRDOyybBjhbQwLamvcPfaRDC9VaOEsr+k7yXOkJTZDY
         KkRJLVLfR6vB2yKBb654LiaOxpzNLVoUiZ1JC1Uzurp+WHLjolBSJK7/PVi/51tHCRMa
         rO2yxqN7FrJ7z92C1VfiB9o6NuA7yzu2UnshyybU1P+w1IVehG4xfvdfT+f/UfkbJuQV
         ARDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wwR3+tAmZvna5GpBM6IknnMly0341sDm9GPfoI+7yn8=;
        fh=Gor/JO3ALVm8C9VVYEa8xejxkRvJTIlWgyQlf40fAj0=;
        b=Hmrkk+AllSp4vbC+ZGz8HCqrt+fSe11Cynt/DM3xKRIedzDllUu6V0rTcQ8M+Q1dYq
         s+NWQhwwBVvxeb7qNcPMC0djkfTL0320FqExWDpQIqG/YBLGPpHvXJa3akEQpTr/cV0/
         6Ew1CQSojeqtSErqLniYozi7tHheC9WyYdv+ui+YeP03f1C44ZE3r1nkMQ2RVJBq4jvJ
         bpyHTJrullqVmbASeWRDL2KgNOeMHeNW2EXofmf8MpxZCS4aenxgwxiw9nX+aMt2p8Yy
         NEL5+zssYYTKTe0searFqGzuw6o1NyUszTVXXfF1OyBl4A7U3ReYBqZvh5RC/dGUr0GF
         TFsA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630328; x=1784235128; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wwR3+tAmZvna5GpBM6IknnMly0341sDm9GPfoI+7yn8=;
        b=m5BkO6R+JqR0OUPVwamuN8v7o6MwJo45hBhOFXOmen4G8lBQGLJNf7JKc7CP4rOjzr
         nHB83dLo1CpN4hgc5CE8Nc8zc0OvWces+7kJe3ATHBm+gfJTuHhA1PHY3ggT5Uq5aLH8
         wWfiUe/psRAelvpPG5MejCzVcGm79Z0ERvK9vjec7ssowMBSSvswtrwWkHOY864j/xoi
         yww+ZRdqODfBsNVdmcdhrGR32xrGJnie+MU2cR8AqXt1FnHqVAPAzmXnQBTzJ+hz4mTu
         NX4s/IORt8lmlUg2Kdwz+9lPmHU4N8eSxFr6IPmJg4NbEGZHOHNvuO9aC/g4XJX1hkQr
         yTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630328; x=1784235128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wwR3+tAmZvna5GpBM6IknnMly0341sDm9GPfoI+7yn8=;
        b=l1iGGUfo+bRYXNSib1T++T+mW639EYWIY0/4t3qmctTUcK8NrFJz2qp152DgAP/x51
         +VRy+MJIpxk68nxiECbqIOMnXpHFRS80bdVRAkFri4iW/gUTPYa7xWYYNwjTK2JN9YQ9
         uxSnGm8eF4ZxoVv/bDzapMfzlTSectWgiwiVZ6wbd9RVF+wsoG/BHIitbmx1oFfTm5uO
         79eg0/gvBh7k3+joR2BFmF0Ux/ZPMmNJbpc51awv36FSL16uqcwL+/41a+AypXdgLS8g
         JRiJWZfS9drKSHmRMIoEz7UGob4hDEmWOPsHvh733QBZ+PiGAZQmHJUw9wuexQFcm5nz
         OspA==
X-Gm-Message-State: AOJu0Yzp0KF3g4gpV2FGxLynT1L3Rmq52kcFenBTQR/YDraCJM/HxoBF
	msXW88V+Le1Ms1UfdijoPJ/eR6gCkiGMk1yx+7o7Ml/0l1tub5H2a2cUNgPBL1PII2rQj312YRw
	vuIPAaMxaBZ5VWqPZWIYuGmuBtAoiBV4DyKQfF3v9lRJSzC27xWZ6dpYI
X-Gm-Gg: AfdE7cltfADO1rL/umI4dHY1B3u/Vh6NcABdwLXJYMrgb3QexeSMd1sa1JZHXaNDSqz
	qt3w+jdluCjruNleuZlvx/8ElkJk3+5Dc1/SwgT2l6crJM6j/TVYJx7TPcV+pKwA4fsx0HVqOI9
	CJ1Hs79yMQvUvHIQrmYexlCruZ48LO6vrk6kJMB5ajpnPd39aKAHJklin76JcfSv4OJpEhkAKhJ
	PeUcKVwSJw4RZNfK5iKYH7lH34IPxFzFC/lBQ3FA/NjrhtATnzy0c6vTewB53NHQYRAD3Bm
X-Received: by 2002:a05:6a21:4d8d:b0:3bf:6c08:fb88 with SMTP id
 adf61e73a8af0-3c0bd313075mr9686335637.56.1783630327482; Thu, 09 Jul 2026
 13:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260528174140.1921129-1-dmatlack@google.com>
In-Reply-To: <20260528174140.1921129-1-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 9 Jul 2026 13:51:40 -0700
X-Gm-Features: AVVi8CdhJLwo6sRrGOXr_e_pr3F9cmxcWsxeSsKwSQ6kjaqHTtDzZY559HPvSCw
Message-ID: <CALzav=diio783dFmPGYp9Uvov2HBWv_EQLoNjnM=qBWzwU5tCA@mail.gmail.com>
Subject: Re: [PATCH 0/2] liveupdate: Small FLB fixes
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_135209_686759_5AD5A844 
X-CRM114-Status: GOOD (  16.96  )
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

On Thu, May 28, 2026 at 10:41=E2=80=AFAM David Matlack <dmatlack@google.com=
> wrote:
>
> This series has 2 small fixes to how FLBs are managed. First is to
> increase the outgoing FLB refcount during liveupdate_flb_get_outgoing()
> so it cannot be freed while the caller is using it, and to align with
> the semantics of liveupdate_flb_get_incoming(). The second is to prevent
> FLB retrieve() from being called multiple times if the first attempt
> fails.
>
> Both of these changes are needed for the correctness of the PCI core
> support for Live Update:
>
>   https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@goo=
gle.com/

I'm wondering if we still want this series. After discussions with
Pratyush and Sami (some on-list, some off-list) the v7 of the PCI
series (which I haven't sent yet) does not depend on these changes for
correctness.

Patch 1: PCI core no longer calls get_outgoing() outside the scope of
file handler callbacks. So there is no need to increment the reference
count. We could still keep this to make get_outgoing behave the same
way as get_incoming for consisteny at the cost of some extra
complexity to manage outgoing FLB refcoutn.

Patch 2: PCI core panics if retrieve fails (proceeding without the PCI
FLB can lead to memory corruption due to ongoing DMA). So the behavior
of LUO on retrieve() errors does not matter.

Should we drop this series?

