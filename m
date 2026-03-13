Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AF7105F7AE
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 14:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3DhJJ93cKQQk3SpyT61kIFsBKzCFpwnhRvsErphsARo=; b=rcnpR9WhjX3cUFY/n8Nmq0FpGi
	sao4P53ZS/XwUhai6FUIXyOkil9cBUqfEvP1fsu8SD/kum4f7THYqT1UQuQSP/95R956QwtpLNUTx
	7krQbIwcJovRPmw1b7X/qlL02edzLEqz3maSW68AKeyZDq14nKOhkwuBEAqdfRGGAAF2rZkED7o8F
	RTYHJH/G9y2cX8jJxma/rh7SMgAG0zmaY6NbhVJ6ODvg7sMc6N6VUs2tvy35X1rL3u64XHEBfu2/O
	kLOxKGNmuHGzvPV2I8gMf4y+KhFY3QbJtbJADePdkMRrIvy1N5i3ACw+s9hGRlHKnqswVI6ymrSwv
	kfAqSJCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w13Ut-00000000OCf-1iwV;
	Fri, 13 Mar 2026 14:28:15 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w13Uq-00000000OBg-3daM
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 14:28:14 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-660dcafc85aso4222419a12.0
        for <kexec@lists.infradead.org>; Fri, 13 Mar 2026 07:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773412090; cv=none;
        d=google.com; s=arc-20240605;
        b=F8L8a0DgT/0JjUm4Iwe+TUdJtcpVfFXJ5AsgEpCbHOZIYoIB1MIBBorsIk/TvXhFWa
         xHrxaTQhnfwlIpCSISG7xID6rFGqWJixrGod1u7E7R4FJqavMTNAU4Iv8KRUhK2Qt6yh
         +3RjtJ2/N2q4MiKvaXSA/5JK0ENotR7k3PB2T9R0uKfNDDPJYbyqGe+Dc0uUq4Ew08Nn
         ZCjqdUl8ejkrkiGhjwG0VjZvXMZhnFmy/MiRjhUm87WhRGmME4zF+zOWnF2w05R+jidX
         5JYpoALNY5dMQRRr0UU8qs4RsQERCFjIGqb+Pc9yu0D0Ss2/UbcUNpGmhZmA47G6uImj
         fy1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3DhJJ93cKQQk3SpyT61kIFsBKzCFpwnhRvsErphsARo=;
        fh=BV0coQspfv4DwPkanfeWlco/GWr8rJfbv1aO8MDHKOY=;
        b=Wzq93Vn8cycJpIr8oafh21yiwD0/FsU3MXBt1HnFz64NLTqDLuGzqQXSbkJwHm3f1i
         gCQVFXCu9Il/LH58G8K833byirYCUROGJAaD0XW05rIIVCuic5hpwVp65KbvjHgC0gjc
         m5GDlF6pqpeQGkAb5/nOazgtafJFW5V34ozAd2vNHHpTmhbZBQbHgcLkgol0IosyXGKb
         Ofp6oWn0BENSRFOk9k2XDqcokDT9VphAbxKBbnLymUZPqBJEk9p91JvvMH4k6sb1/lh5
         vCjhRPW8oLJJLlHCykPsnEi+LSO2ySSmjSKm/6fDCxiRXTqDSv3TCgzpeyC3B4PiO9Sn
         QHGg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1773412090; x=1774016890; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DhJJ93cKQQk3SpyT61kIFsBKzCFpwnhRvsErphsARo=;
        b=i8aHLUUKenIRP55MupF8f5RkvoSMicVN1qgVsvCWFNVx1BfTQr2CS/tUCMGvOIXiub
         E9Nvaco5jv5/Z1RCFNvrocUqd1JU0Wp56/NCzYnIFMZSxhd6JLzuGHCIUgSy58eT8MtP
         2jL+qaaFAje7oJVT6d3own28Kvf/O++D3vltUcTAusK9W3elfS1/Z6rwHY4iCbL3u6TC
         xyRo8xLMBZ2lHyvFSbV4OkKLB58Ys2CUHlQ2fyR+QSGfu4p6idHCeX7OcxiOKU8RhesS
         mNb8BUsnryssGbqmTESKEigo+C6XuGKaVXl3oTNgP20NqqrhQALvBysD1/ASMYb9BZmR
         r6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773412090; x=1774016890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3DhJJ93cKQQk3SpyT61kIFsBKzCFpwnhRvsErphsARo=;
        b=WO7aQn6DOZLbqsc412LUwrtGeF8++0woWcP7i4+0slex9JekzfaYoNcGZ9RGsA4jBo
         buZMBdz8+7/fV21S1Jg5sVHhGnCe6FNTFznZTCkgo9sM18FelVgI0ZYU/7SmY1Ygkhr/
         FvxnWbHvHcbYViNj/FeJcSyKPgijNB3YO/2+WTl44HJsRiJvY9An3oBPPLwgGFExdMsx
         WYuMo8yfABx1/AI88W53ae+lP/bbxscwqOW/FY7Jg9l5OFZAaHIZRSzFQn4lz14pmOmP
         hJTW2u3nIsEf8Xs78qNpJKhFrFRgNobWy2WBjxFtJ+5RVrXPJV+czh32iVsHbdgwICqQ
         Y0xg==
X-Forwarded-Encrypted: i=1; AJvYcCW4IkYwp+JlTqjPGiZB7M/CMKU8/HT6kiO8teiDERvYSFsOdOIkJssBQp/DZGboH8FWyaFYHA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzJ7LIrWfi9zFqhwjwxuDA7KiA8uqemTR6T//Y6C+0JRv0fRjlM
	VYAkSn4K4NP0neNGmybxtKMjIbSiCqoeq9/kVphogY8xgji+oKFefjWPj4X6KVaqY+B9jk/YPlo
	9JWrJsdLzTv6ZQSXxIoiS0/8ahzafGdbmf/5CIK77Dg==
X-Gm-Gg: ATEYQzzyq+H8Pa+f927+AxZ6N/6KrAC6b/lTgfiT7asC5W+c3ShO1VXmBlHu5BLvJem
	TiSR6ibvXPGWg97fRtmHxO4qp8BYK8OQNkQGyl6GHIf/7Ki6R8zZIJTkKMfPzdoyXDjwqpRGVPB
	Q7fAvU75S5PlyckQN6fhtAcewwuT8l1sVTt938xLD5pGlzGHnw181ZKdaZVZ46BGci8hkN6+Nsw
	nNOuO1tqmKIPb0pVw6Ut+5Bsc92zvgCxmCk8qicl1n4zb6fWdzk7BgeFQsUkicGmENU1UVyewAc
	mPUQ8OkBdku6bobiPzuws0Yx0pqIopemXieSqg==
X-Received: by 2002:a05:6402:35cd:b0:663:8be1:3649 with SMTP id
 4fb4d7f45d1cf-663ba9b776dmr1936388a12.3.1773412090104; Fri, 13 Mar 2026
 07:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-8-dmatlack@google.com>
 <20260226160353.6f3371bc@shazbot.org> <20260303210733.GG972761@nvidia.com>
 <CA+CK2bDADhFcMVGoJew9RoJ-DsVhYhiZJGJVwfzTBZdGX++8Ng@mail.gmail.com> <20260313122525.GB1586734@nvidia.com>
In-Reply-To: <20260313122525.GB1586734@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 13 Mar 2026 10:27:33 -0400
X-Gm-Features: AaiRm524CkK4OBTNvXFWcAvWcl42dW_YCeYpiFYkXzW17TUn9itgLI7yXbb39d4
Message-ID: <CA+CK2bD2ryZsvgono-5Yg0jwwCa-p55wefT=hn3DRsDJVc0ADg@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_072813_047412_4E5646EB 
X-CRM114-Status: GOOD (  14.57  )
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

On Fri, Mar 13, 2026 at 8:25=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Mar 12, 2026 at 08:33:27PM -0400, Pasha Tatashin wrote:
>
> > If there are active sessions (incoming or outgoing) with preserved
> > data, how can we safely unregister while they are in-flight? It is a
> > rare condition, but since the user can cause it, they need to be
> > notified that unloading the module right now is not a good idea.
>
> IMHO blow up the kernel or something in the core code, you can't stop
> module unloading once it starts so it is pointless to propogate this

I see, I will send a separate LUO patches to make unregister functions
return void.

Pasha

>
> Jason

