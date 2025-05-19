Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A96C2D0CD
	for <kexec@archiver.kernel.org>; Mon, 19 May 2025 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C5RY0yee8AXlczdySDXd4xrCiHllv9TM3XPXAEo3M/Q=; b=UuZdjJuQXw4026EP/MbtyQ89Jn
	koTNKI1RVtK2Ts3EWtoUG9wN1vXekkeTxa2GPV3POq07JdwUlpACMPYS0s6r4AdRocfxEAgxM7nvM
	6FoR1A9XYtf5QFY2sG/6tLOf70shCS5nbJPqcd+jopwSkstmcDFkOWE3MdXMXzKZsOMl4b8ZTTYIn
	uQStLIDB7/m7WgCsQRK3G/zl3JKElS6dd2o+1hnwndP3n91ro8I9D/29F9gyPJN4FTndh4CYXo5hS
	nkw3Ed0nN9aWiKN1DsIu042V9lsNUaNa+tLfU5Uz6E/PE+wTms/fpeNOPsXvxU3rPjxICtDw0fhl4
	t2TB2V9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH2k3-00000009fj6-0P5H;
	Mon, 19 May 2025 15:49:27 +0000
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH1t4-00000009VPU-2xO9
	for kexec@lists.infradead.org;
	Mon, 19 May 2025 14:54:44 +0000
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-2da3c5729fcso2115896fac.0
        for <kexec@lists.infradead.org>; Mon, 19 May 2025 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1747666481; x=1748271281; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C5RY0yee8AXlczdySDXd4xrCiHllv9TM3XPXAEo3M/Q=;
        b=fUtzmNXLnm2z5dVMw6jZ6sX8mwG9AIie51R7efMSZ1xv0D5+OiOQWtemDgf7Mp1ULr
         sKEg6XcAw2jKu6WRBP5P3GHly0cWPvGIR9BGGCC37o/whxLFQE5QjFbgXFLIWps53r7r
         iCeiAJKUJy1JhjGqWrxIQm+xeRiuJOTxcMEZnOAx9Ty3Lr5yuDh1poZAKhM8ahKLpPCo
         kSt8ZyLhM7M7OVQ5LUTac2anVHnT6LIGG9+SQK0Fi0TWFxQVGTYrizW3GghuJtQC84l6
         Zg584A88A8LViD5VRKWYw1mzhS+zTB6Ca+j3yynEZDm8f1SoNMe0xgjXqH9slBNb46cx
         GJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747666481; x=1748271281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5RY0yee8AXlczdySDXd4xrCiHllv9TM3XPXAEo3M/Q=;
        b=M6KGhbvRrZOaXEugciut6Pp1GtUhwhZrJ8KRplt+Hk70gHSRJpubMHzPqqNmy1Xiks
         kjuun+ekngUNFcOC4qSEdkvvTngMT7ol7n3E5lwPRzl/LySudy6Gid1Qg9M/jXg41tqb
         523ivKBb1WgepsepzwWdcCZd/B9Pvyvrs7rYQsKTWJ1Z41PK5sJrbBGs/SHK73n6HSWC
         /ZscDGzAaxfB4PgP6RCBo/F12yzI1duse3mdX/NBsHKI5qIfM9X0CdhFiPa08qEY+90x
         IzQ+hN1dzsdvObsq2aDlfC9WYaK6Fc4kdBsn4chpZFWay9VMsg24MGQOnFwgqssIKEOb
         pPBg==
X-Forwarded-Encrypted: i=1; AJvYcCX6H+H8DsugFLPlIY9DrgtM9HMpkUh/JC9UvRiN9XHcEUBr+cgRiM3TbJ+yKojSQLDTukqBvQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxRc27d+t7Dj9OcKL2bY1lASnqT6AQs09xT+4xu9hanT11pKBRt
	wIXcMqHH4YuL0NZZRoJFDIFFQPt17XKuxzIRIpBK7b/WCh2+FmWM9cfetwZEV0ShAgK6RDj4DLt
	Gql55AC0Ygbe9sRUVwDwWS3/VeqC12uYSTauBTe94EwNaZa8fGyyGMCM=
X-Gm-Gg: ASbGnctj2G6Gug0YIdiy7CUbca11i6NkxoJxgfjV8+85GA1WF2mL0EutPCRyalCntPu
	bWMmr+n+IiSBX69ocgbalww4wu1C4uIM4Yvlk/rbDh8xU2E43yPVXLZBbejMZM5543rg2ofOh5q
	12IbkD3Zz/pPdaiZKFu3NImED2IKZQ4Q==
X-Google-Smtp-Source: AGHT+IHY+s/pxl8Wm0AmPNexcqZxRL/7O/b0czr1GbqEi1R3W+gT9DWsS7sJnhkHzK0YqxtH8uY+NRsB2bc9oEpw9Fo=
X-Received: by 2002:a05:622a:1f9b:b0:494:a01d:a912 with SMTP id
 d75a77b69052e-494ae358549mr285354061cf.13.1747666471020; Mon, 19 May 2025
 07:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <f35359d5-63e1-8390-619f-67961443bfe1@google.com>
In-Reply-To: <f35359d5-63e1-8390-619f-67961443bfe1@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 19 May 2025 10:53:52 -0400
X-Gm-Features: AX0GCFuK1Uf-sIumFIAPWvO-DRou6DMnk0ysddb-8DdagbG7QKODtYAZqvQIRxA
Message-ID: <CA+CK2bAZEgTg4qGy9j3Tm1nerJP0M-30EKUxOuS5Us81XXtGag@mail.gmail.com>
Subject: Re: [Hypervisor Live Update] Notes from May 5, 2025
To: David Rientjes <rientjes@google.com>
Cc: Alexander Graf <graf@amazon.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
	David Matlack <dmatlack@google.com>, Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Junaid Shahid <junaids@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Pasha Tatashin <tatashin@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, linux-mm@kvack.org, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_075442_938723_222ADE59 
X-CRM114-Status: GOOD (  13.86  )
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

> Topics for the next meeting:
>
>  - 20 min: presentation of LUO v2 design
Slides:
https://docs.google.com/presentation/d/17uYuw_KkD-gOiA6a6vDgHGzj-gDbmj7mjAb7ENlkZ5o/edit?slide=id.p#slide=id.p

>  - check back on latest status of KHO series in mm staging trees and any
>    pending concerns
>    + including possible refcount issues for compound folios across KHO
>  - possibility of a Live Update Microconference for LPC this year
>  - discuss support for sharding of dax devices into arbitrary lengths
>  - discuss support for defaulting to fsdax and with optional devdax as
>    needed, provisioned by the kernel, on the command line without
>    additional tooling (ndctl)
>  - update on physical pool allocator that can be used to provide pages
>    for hugetlb, guest_memfd, and memfds
>  - SEV-SNP support for preserving guest memory and what foundational
>    components AMD can depend on, building on top of KHO v6 or KSTATE
>  - later: testing methodology to allow downstream consumers to qualify
>    that live update works from one version to another
>  - later: reducing blackout window during live update
>
> Please let me know if you'd like to propose additional topics for
> discussion, thank you!
>
> [1] https://marc.info/?l=linux-doc&m=174645437711873&q=mbox
>

