Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B03CD5BC8
	for <kexec@archiver.kernel.org>; Tue, 26 May 2026 18:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9od+UEVQVZlO/XwHDI7UZ3wm6Q6HteW9V6Ue0btO0nw=; b=aUpp2xFJ4ffrGGFf3ZhsHMGfSc
	e3+XxzCN82dsAM9ORvFQQ0I34MFkk5oQKzKeA7PTBMdD9OOqVXEAIPqKn/x3SJFcMzXdpY2gEiVYp
	955oyYt8gOAGazFjshsTTlEBpWxN8X1qN5b96bUs7rfWd1OIDjYLdZIdgQtradvaWWyjiXRXwX4wP
	sVda5hpuC6q6Zm6lTbhcRQ82cJGUqIkcltsFGJt/4+ypepJrukRI6LAk2z7w3kG2jYrTvJ5lyzrFn
	DZ3vhzbuOPA/XvfzO7sprtio8QCnIA9RGPt6VMUMcZg6uDmrBuCt6s8lKYMKyqVCnAZ5Z3vWmIoNe
	Pk2UAPGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRwuV-00000002sTr-1sVK;
	Tue, 26 May 2026 18:53:51 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRwuS-00000002sTV-3nX6
	for kexec@lists.infradead.org;
	Tue, 26 May 2026 18:53:50 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-132830d8281so2788278c88.1
        for <kexec@lists.infradead.org>; Tue, 26 May 2026 11:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779821627; cv=none;
        d=google.com; s=arc-20240605;
        b=F/5K6x8M9bIxApjsRH7whphCt9/iN5OoC/P791kaAZcaYn/CEMIaD+CyeZanhTc0Zc
         VTHa6hDDyE+kac+7bfeRpY0ra0mGwmkdaqkLfAIHo5vWQSWk32uLWHVAgZTIh/5NRn/1
         PhEh4V8g+kYPWNbT8fpLOIEOEXzaw27v0ybjgaEwaZV5e1KGk00TBQqZXbW6YMY4n8yQ
         UOCSo75wkfuAE+68TRtk/qVq2bZtJU2rSkqvDDO4m4CZBUBodX5dpC+B88Cb80ip3mhX
         VfTMLhk9E5FYe4xLW/8vOFhKLa+84gl24ZGEx51unfFDLa4KlQc1IfLJmcZn+yPHefaW
         wzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9od+UEVQVZlO/XwHDI7UZ3wm6Q6HteW9V6Ue0btO0nw=;
        fh=mDtXO0YKJ5dh1upOuC0gw0SDtxEw5f0ucC3sxyB7vvM=;
        b=YLRz1UlSAdMMxuR4VB/Mgg7Br2F1uD62xxOk/+oJYbL3q2lP5ozl0TthuaOOiLDsqu
         STuDAOE0qaW57ZnaRAllui1A3Qp4piiiuYn+xMU1n8V92zxMuJEj288ovr2qOd6p0oFt
         MFsEeoU/txUf6f56GJZtlwhXnumslqPnGUoZDCT5FrAFzIOU+a06dP+qivf6eyFQqSD4
         JMj8pP268O+FYioaDweLYQZKg3TBsvobXquz3fbD9pnDy14m68iACLdRAzuyC0GLnUZH
         6HYfjgeB3RSIO8v1Belh7Y0Qvqxadmn2cbBiK9SYPSGQ/UhyljItQTtYspRYqPU8VlLn
         7gWQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779821627; x=1780426427; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9od+UEVQVZlO/XwHDI7UZ3wm6Q6HteW9V6Ue0btO0nw=;
        b=I6xh8iORWI/Fek+WnDX4go20UNaT0Yj0UM6lRAVDqURxCg7yjpzmW8qFFpa2dPAPc1
         KthMUBpD7bQuTsnZdLGHLr0U4OW46s1oRBQuItYNPSmJtHAQnsihSNYIbiU9y9b4pn0l
         FiupovIsWSbWNtRQKLf4aYoc3/dbo21nOYWc5LItwzv1qDROon+OUiEQOdRvDbTqyj85
         BtG7ffNdE0lQQUPxx8YWVSLMR2KGKL+HxeLwwvVPgUHeCbO9UumQr5Nz/cQ5tbl2vMTn
         qK8EdBBzdWsRMKNRRrHu+fZJ6jtTZpQlTm+jr/lmZJdwTefBuEE7cv5p7OpYftmtLg9o
         193Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779821627; x=1780426427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9od+UEVQVZlO/XwHDI7UZ3wm6Q6HteW9V6Ue0btO0nw=;
        b=HQ9VgSCzxvKnwncfYuUhV61igqZZSyDRGc28j6muXQifECVObfB1UdQYzx8fh38z4E
         cPfAidpSQG4AgCSpLtVZRo7kEKOwQErfOS7DGnHyZk4ICRZNiqxMtsLDUCN59HPQPwbu
         0HOC6HJPWZ0wcybSdF1QBvfiSDJN0ljaJFT6SLHMyBDLKC8IpxwzVhVmY/PMh2ltqnLj
         7cMdw0LIbkacVD9kf4lOR51eCgyi952bGR0Pl89QI+fvnV/zVz7vvrgRAX7C5G//JOCP
         MaNOab4OZHjOvSOBwHB9uEQHRqiQIS0ohiuKWlinLHC+qBOhdOzqPv5UYMJ6BrhQItYz
         aKlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+efsuY5SXPf/ZwnblxlK5/aduidTTNMnXI7w9b113Ep6ZmS1i3kls3Fj4pvynDQTJ1X86Okw==@lists.infradead.org
X-Gm-Message-State: AOJu0YynZAw1EgATZ5fIMGdcizibWwIL386thL07UY5kxkPwK9NrLYNd
	AXDzjZhVDYaKHE3Vv7S5k4B+HakYlSkpCPBRkevQzJ8h34bfi1NAxpKF+TGjiG7v/GRI293JDC6
	o0au3K53o2d/SVf9heGsnG/oP9Gk8IIgmp/XlAbTy
X-Gm-Gg: Acq92OEr3/g0kBZ6XR/psStwvuKfJMVkcrq1Dl5MbEGayYeRIqe6uYmnUU5RxAAURiU
	tD/7/im2wvZfLzUIfJNB0E8nPsS//2yFtUQUyW06AfiRIsmNHJRQEMsIUAh07SYbvVNVigGEhxf
	TBFNhOb41988/iSTZt+a80HSaUwaCXtoz0bVfjNwfI5YMK46cyTf7Vu3W9988npJ1AZYGaQLUKL
	8bNyHRJUXXpMEcA0UfXTbl4d94fyTloiOxbQL9da56zX/9SIo2nlQGMmXsjjVfJmj2eif3NJVJt
	z4hYPm0rTlfk7nl5CQ==
X-Received: by 2002:a05:7022:22b:b0:12d:fda1:e640 with SMTP id
 a92af1059eb24-1365fc7761amr8178711c88.41.1779821626769; Tue, 26 May 2026
 11:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <ahXiYGo-IWI94IVP@google.com>
In-Reply-To: <ahXiYGo-IWI94IVP@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 26 May 2026 11:53:20 -0700
X-Gm-Features: AVHnY4L77MAmu1Xjz_rxrbFy9L1T1tFPPVFOlZ6iqPzPQMXKQnayC6moEjvx8Nw
Message-ID: <CALzav=dkVWYmbWCO6wDuQrxetAcqYkitJiRF_BhDDGqn2_-RKA@mail.gmail.com>
Subject: Re: [Hypervisor Live Update] Notes from May 18, 2026
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Alexander Graf <graf@amazon.com>, "Andersen, Tycho" <Tycho.Andersen@amd.com>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, "Heyne, Maximillian" <mheyne@amazon.de>, James Gowans <jgowans@amazon.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, 
	Luca Boccassi <luca.boccassi@gmail.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Jork Loeser <jloeser@linux.microsoft.com>, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_115348_950007_AE9586D1 
X-CRM114-Status: GOOD (  12.25  )
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

On Tue, May 26, 2026 at 11:37=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:

> Next meeting will be on Monday, June 1 at 8am PDT (UTC-7), everybody is
> welcome: https://meet.google.com/rjn-dmzu-hgq
>
> Topics for the next meeting:
> - Vipin and David Matlack roadmap for PCI and VFIO changes to solicit
>   upstream feedback

Hey Pasha,

We'll need to push this back by one meeting (June 15th) due to the US
holiday and some out-of-office leave we didn't account for.

> - Status of I/O freezing implementations and HugeTLB fallback allocation
>   patches
> - PCI core changes v6 review and next steps
> - IOMMU persistence v3 and roadmap progress
> - Updates on vm_splice investigations for CRIU memory preservation
> - later: KHO support for Confidential VMs including page table
>   preservation and pinning
> - later: versioning support for luo to negotiate
> - later: KHO enlightenment for ASI
> - later: testing methodology to allow downstream consumers to qualify
>   that live update works from one version to another
> - later: reducing blackout window during live update

