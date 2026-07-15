Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9830AC44507
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 23:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qLeRdnIYqFL2ZkvvJB0Jh6+9BtBNZEB47wJZNGFb0wU=; b=xfmOLr+EOYuJKtQO2J+tI64USK
	cvzvHaTSZuge3vfVy7Di3owvFzOKV2RqwPSomg1tkcIIFORpS54KBqTgAWbxzbmdgf2dPEwu1wyxs
	E36iuTrOKBKM46LbmTJHIumwVEuK9R7m3r+M8iJ3WwW3mxCF8S3anKyoKDVBdhiS1Ytu7jNNGkbem
	zdlL134v2R++jonXQEdNRhzv9EWA7PGvRnsHW+qaXeSCZ+C+b56hYrD2PbyiyU9yI0Nnyp87e8GBR
	x9jpiMTczj19EisWPMYymptOYLL154PZAm1OD9nzPaJYl91elIMNrR2WPGb9YBZgz+dGkXlp15nWz
	7nWR02xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk92F-0000000G4q6-0rYd;
	Wed, 15 Jul 2026 23:29:03 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk92C-0000000G4pS-0vEO
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 23:29:01 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-51c10e86e52so59321cf.1
        for <kexec@lists.infradead.org>; Wed, 15 Jul 2026 16:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784158138; cv=none;
        d=google.com; s=arc-20260327;
        b=Y5vx8wW/A0ohNnoZFz0MabnVm76HhZUlmNqZ97ZmAgmdYzRq4QXTuNBwCPkLOfznJ8
         AufxsPKpPcWNRAsV83hR/e/CGAA39pMJJInEtQ51ff+Ey6bCzER8sSgql3B6CZCiWNBw
         KYxbmwJjixpxzum68SzvSK08hPh48iQ2qBlDMP6wFl0aPZSJfUFbnfQHD6AeMV7IDTr2
         yX9IB0S+8bwWKIHiUXMwOdEjXGkjW0cYMG51FjTmXXgE44jR4gZ3SVwBj32HuoZFkp3y
         O6tGKrBIeT0NW2pedxMgcrLYHErCDaLOu7OioGs/O6MfIpf2n28LCIlnMBP/rkKj6/hY
         KnfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qLeRdnIYqFL2ZkvvJB0Jh6+9BtBNZEB47wJZNGFb0wU=;
        fh=kvIr09DbSeRMAahvoimdIWsug2RsCHx9ekXyEoGCY6k=;
        b=Ra0b9J0dUlgypvxZFZ2sDZKqTcu/6dJwly/rjEZKnp0QOw+/Bujuz5EiBB0YNsKg+/
         l8C2FoQpXcgxG0Y4wLPYxuECakqpLIJSkaHzguyCb7okl3VIsQxEPEw7UmqUgTBpWz0A
         eeX+kRC4GcflCkUyeRGRuqjgpG9eZf1+cy2SnvNJ2qu8M6OKOop8415N2oKs+f1IC3/U
         uEv2f7B3iE1qyc9BbEXmot4Z0sa8gzJxLiYO8LKG/FMND9Y/+f/H1XxmSR2QMtRmqtD0
         7lRqn4BR2MZf/0M/cFjOouDhff0imPL5A4x9AYI+O4pyNLmmzDi/qfKhkAhRSdqI5IGW
         kpgQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784158138; x=1784762938; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qLeRdnIYqFL2ZkvvJB0Jh6+9BtBNZEB47wJZNGFb0wU=;
        b=nIhT8rXMMFnOhGwZuJEJObDNmEkU80LxREOPvUQkeagaEImaM5q0TN46/8ohKy5aoN
         F1KhavNYc7nfXyprmlU11cI6u1CI9nBqwDLeX9nbfZq6VmBz/Bi5EvJJWIM7n5q5BW3j
         88EaAAvD1DTFAveTxKz2qKVGg5qr62TBXfFkM0s78FOkKWurXyw7nE4wGuIZkvWHbeqC
         qziS9VGeEeMccB7mEU9sWQmiiz6Q0apM52hYI4R3neiO8C6uhEKPhIrgFZYSmO//mHYJ
         oDdL/Uddhgvz7V56+7ZZSZEtbpXwaTCZdK6jDyxRbMNOtVKVxacmFWx3a4W/EjewRfFr
         j6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784158138; x=1784762938;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qLeRdnIYqFL2ZkvvJB0Jh6+9BtBNZEB47wJZNGFb0wU=;
        b=eGMgT4CBjwWEKOX7DLM28zJKQInsfSzj0lG9Ldk0X/+xCFYiD0kvY8vbKFgrmF+pOe
         n1d18NluD4/civ6IQzWyhYqzJ6x8r4XtUTwfmZB6828RstmiDbn2RaeBwho0FrGEUIfK
         QzJ5pRfrmZBF1WMdzJZrqj5jFUml+dcjWhfeWmFVW/3l4vcnkFEyp8cX4hOTkbiyf9pb
         EsJwEXdS/avKA6d42+BICQGt7i1Jyl4T+vfUPitKJyQulINzlqkM8WYu08R9w73ggqoF
         G/8fdEmCi5xJXr4VktA01k/SVnewYy+V6l0Ja58+Ys6DzAbwIvlUQ6MWYvJYXVvTQpev
         dn6A==
X-Forwarded-Encrypted: i=1; AHgh+RpHJi9w74i4pobQQCVSEX7+C2VFP0cIuEVTf5Xz9QeqF18cMoszyyt9D+h7StMTF66uOm0Gcw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz2OBV8m2RgZ+kiFJmlFhjEpSWzX0q9Ff7Mc7C6UMUN7WVsjW0B
	ZO6Fqs45jyiIBblPnjYj1RLYHdmhuJSnF8ky9eqUt3mRJQpcdDBcF+qdjVceHSNXhjMLIjeO+OT
	ciYHFHnrb+PeyPuduiYmpbDH0zs16Rcve10a6V910
X-Gm-Gg: AfdE7cmYQrkRDS3CYYONRK5odiKkhVSYi9PLLquS3wvF5mopfOiX0zDNBP330LucVwt
	tbyem6zM7gvF8M9Ay/TcXWTasWUne8j0xzfxzdG46KcOdjsbV5RMo5Hn+bGhj2trqQnJtGrWmCt
	0bOFA956/EcuG/oaLm3zVvWUnrMFgGDCvBcTb/71X+jsbcO5LfgCUj3uMJ4QNIj9fNjEaXW5Uka
	K7MGFNF4u99O78YECktISfCpTQSbHo7p3xCyNneYF+yGYLNAe/c857Zvy3drp8BzaqCO4n0Btk2
	5tTXXm9sGpGsffdX5P0=
X-Received: by 2002:ac8:584e:0:b0:51b:fe30:b8c5 with SMTP id
 d75a77b69052e-51f7d273d83mr3129991cf.6.1784158137304; Wed, 15 Jul 2026
 16:28:57 -0700 (PDT)
MIME-Version: 1.0
From: Sagi Shahar <sagis@google.com>
Date: Wed, 15 Jul 2026 18:28:45 -0500
X-Gm-Features: AUfX_mw5IkLq6HBWbNyFqtB_FJLQY-ss8e5iexyKJ5DFpuVyQE-Godhtk7slzLo
Message-ID: <CAAhR5DGpL6_ViMwQ0nKzTgOoziE_oq8JofpO-VtHBXK37uO-FA@mail.gmail.com>
Subject: Preserving TDX module during kexec with live update
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	"Andersen, Tycho" <Tycho.Andersen@amd.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, David Hildenbrand <david@kernel.org>, 
	David Matlack <dmatlack@google.com>, "Heyne, Maximillian" <mheyne@amazon.de>, 
	James Gowans <jgowans@amazon.com>, Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, 
	Luca Boccassi <luca.boccassi@gmail.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Jork Loeser <jloeser@linux.microsoft.com>, Chenghao Duan <duanchenghao@kylinos.cn>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	"Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_162900_308170_5302D017 
X-CRM114-Status: GOOD (  16.82  )
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

Hi,

I started looking into preserving the TDX module across live updates
and I'm not sure what the best approach is. I tried looking into using
flb as David M suggested but I don't think this approach works for the
TDX module.

Right now the way that TDX supports kexec is by disabling the TDX
module on kexec and then reinitilizing it on the next boot [1]. This
approach clears the TDX module state so any TDX VM from the source
kernel won't be able to resume running on the destination kernel.

In order to support live update while keeping the VMs alive we need to
skip the TDH_SYS_DISABLE call and instead preserve pages used by the
TDX module such as the TDMR pages from the source kernel.

From what I understand, using flb will tie the TDX module save/restore
to the lifecycle of the VMs depending on it. This means the module
will be restored too late during kernel boot, after the VMs are
restored using the live update IOCTLs.

I'm thinking we should preserve the TDX module during the shutdown
stage of the source kernel. Perhaps we can preserve the pages used by
the TDX module as we allocate them on the source kernel and pass
pointers and additional metadata during KHO. Then on the destination
we need to pipe this information to where the TDX module gets
initialized during the KVM module initialization.

I haven't found a device that acts in a similar way so I'm not sure
how complicated this will be or if there's a better approach.

I would love to hear your thoughts and if you have any pointers on
where this code can be implemented.

Thanks,
Sagi

[1] https://lore.kernel.org/all/20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com/

