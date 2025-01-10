Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902A7E7719D
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 09:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ZjpKehOtHC5qkYry/2xS79wePNMJtKjfmLm74RohwE=; b=uEfKRFDD7/9PxdpJcKwnhQHzXE
	j28XffAnyBkw4vLD+TXNrARILp39rewXLDzP4LQWBlauC3GfChB1/5QKRkO91KeQ/qn5NpTXaEr1J
	X9RXVSDC136jgY/Yn9hrSF9ykVSSQpUH5T5SSt1pNiaazMsjA19vkDC/rs6yQxXNZP3mtn7a0cVhf
	d3w3EOSRkWLh4vPdYvqGS5+YePPVw6dWTXBAyOIqXMmRGSqRn67oHBG+DBW2++wFqvoL9HGetppVE
	04a6N8N8I4uTxp0VKJwfQLct12DEEuPQ2luwI4Y/TUmuBDvFE6t2SsNuXELwjJMWjCxtHSF7wWSrV
	o3yFAzxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBOJ-0000000Ek2m-0SqJ;
	Fri, 10 Jan 2025 09:33:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBED-0000000EgRa-1TEh
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 09:22:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736500971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZjpKehOtHC5qkYry/2xS79wePNMJtKjfmLm74RohwE=;
	b=jIK98APTg7CWgxUfcU9RFKnUbdl7riHuxSsnNUTqS6aWwZhqxRs+dhQnHJ+WOsZ5YObSrF
	p5UgZD9mMe9B4yBz6KgH6+StdX3H9/XoXjlEuqZkdCvXjRIwjI0bO+GnS9Yus3Er+enQCL
	9GKVnTW9nN5LqwecgwppnuhJLOlhWdo=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-BAE4wnFwP1GkDF7oC0YfIg-1; Fri, 10 Jan 2025 04:22:49 -0500
X-MC-Unique: BAE4wnFwP1GkDF7oC0YfIg-1
X-Mimecast-MFC-AGG-ID: BAE4wnFwP1GkDF7oC0YfIg
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a78c40fa96so13585815ab.3
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 01:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736500969; x=1737105769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZjpKehOtHC5qkYry/2xS79wePNMJtKjfmLm74RohwE=;
        b=bH1Tt9If2v8TF+EMbp4ZgR+pieuFofuFs9u+Wt/zKOeC7L9dojN4V+TCbsrq3r3HiO
         /Q7+raoRNOFwHxkE3UuekRMDj8GE35kp5hUaJZlnM5kUJsM4EovNUe5JLLmtZP9Yp7S2
         kx+tCgS4M01vh51CERiKwfc+Uq1ali7ijummd6zILkUf57eHtH8oii9PfDBvHHQVvHm3
         0ry8E+ZcDr65sRUYqUcFynQpb1f98Zonb35BPk+e3G7bgFCPy37Gvi5UCvUSNeaMORkM
         gqScOpHCyHWcG5oqzwRJPiNOl+eVT4NBt01NxAo2TfRZIR8urvLUiCU/xHtNh+5+OF3V
         o5AA==
X-Forwarded-Encrypted: i=1; AJvYcCUrRkh/6WXNXMCNcDzsVAlYuFQcLlbQdzKcOH0QLwtrTPHo5x9hd/SOj1hbXE+3YEPETAmO3g==@lists.infradead.org
X-Gm-Message-State: AOJu0YysAuUhI0ITTMEv6tCN8Y6sLWSGius07ms8h2Xj0HicNnVxA+tC
	XDLVNwGnFtVIX9j4EJRXNMypyREiXyNFqTHl3gdMPALBlAFkKFrOVHxe9mOgqtwdhTtw1MYTZsN
	3kVIp8Ilm4Jgwqb8eUxfSUot1RT0AqvZv9DFwsBrRvsKUht4udseK39KEF8ZZC8iOfv/mfK7/b7
	CzmWxID0JiD2WTeZ/hKH2RQtSMn1fHJglR
X-Gm-Gg: ASbGnctiHXXNmXZC2K/aR0LOit5k4oOzuorn3NgXNeAyNjj3OKk8YeUzGc0h4h66fRq
	iYb8KvmcGwHAyYHiazaenkm5SJHvLVrYf56jBXAc=
X-Received: by 2002:a05:6e02:1d0a:b0:3a7:a553:72f with SMTP id e9e14a558f8ab-3ce3aa5b1ddmr73319725ab.18.1736500969125;
        Fri, 10 Jan 2025 01:22:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZPBLoOgF/w7LAXCeJHG8+rXEgrBNBJ+ZjTuYwAwxQ9wqV6jcnanChGwwjC8+FizLEPCmzZ3MuoI1M+qOs8ik=
X-Received: by 2002:a05:6e02:1d0a:b0:3a7:a553:72f with SMTP id
 e9e14a558f8ab-3ce3aa5b1ddmr73319595ab.18.1736500968804; Fri, 10 Jan 2025
 01:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
 <20230920115634.GG224399@kernel.org> <DA84A55096BADE15+594e239a-ff6a-368f-ae92-b6cfebbf8dc0@tinylab.org>
 <CALu+AoSr+an7Ps-jhcSbvrq4E4FnqkiNZVH-2BhV_3=B+oDcFQ@mail.gmail.com>
 <20240518083304.GD475595@kernel.org> <20240812163633.098f8f07@mordecai.tesarici.cz>
 <CALu+AoSmG9eehL+udT2KHzn4H5Gq9eJ_t-C_H8mkJMhvB3VpPQ@mail.gmail.com>
In-Reply-To: <CALu+AoSmG9eehL+udT2KHzn4H5Gq9eJ_t-C_H8mkJMhvB3VpPQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 10 Jan 2025 17:22:54 +0800
X-Gm-Features: AbW1kvZpAMIcdQxAdswCJo-qVHiJaK8CPVkY_OQ4GsqEBgDGEU_VS_T0f3FvfZ4
Message-ID: <CALu+AoQ6g3BXhYEx0b0AwfOHGVCzZhwbUwjWtakyRwng-OYo8Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] Kexec-tools: Improve RISC-V port
To: Petr Tesarik <ptesarik@suse.com>
Cc: Simon Horman <horms@kernel.org>, Song Shuai <songshuaishuai@tinylab.org>, mick@ics.forth.gr, 
	lizhengyu3@huawei.com, liaochang1@huawei.com, xianting.tian@linux.alibaba.com, 
	guoren@kernel.org, huanyi.xj@alibaba-inc.com, yixun.lan@gmail.com, 
	kexec@lists.infradead.org, hursand@fedoraproject.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gpQDszaO7TY-do9RYncpRugQL-OMVind25axIUoNUE4_1736500969
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_012253_463323_4B756DF8 
X-CRM114-Status: GOOD (  41.66  )
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

On Wed, 14 Aug 2024 at 16:23, Dave Young <dyoung@redhat.com> wrote:
>
> On Mon, 12 Aug 2024 at 22:36, Petr Tesarik <ptesarik@suse.com> wrote:
> >
> > Hi,
> >
> > On Sat, 18 May 2024 09:33:04 +0100
> > Simon Horman <horms@kernel.org> wrote:
> >
> > > On Sat, May 18, 2024 at 11:39:18AM +0800, Dave Young wrote:
> > > > On Wed, 11 Oct 2023 at 13:24, Song Shuai <songshuaishuai@tinylab.or=
g> wrote:
> > > > >
> > > > >
> > > > >
> > > > > =E5=9C=A8 2023/9/20 19:56, Simon Horman =E5=86=99=E9=81=93:
> > > > > > On Fri, Sep 15, 2023 at 11:50:06AM +0800, Song Shuai wrote:
> > > > > >> Hi,
> > > > > >>
> > > > > >> This series is created to improve RISC-V port of kexec-tools,
> > > > > >> and is based on the horms/kexec-tools:build-test-riscv-v2 bran=
ch.
> > > > > >
> > > > > > In my mind the big question is how to move RISC-V support
> > > > > > from that branch, to being merged into main.
> > > > > >
> > > > > > IIRC there were some issues that needed to be addressed.
> > > > > > Perhaps they are all addressed by this series, and with
> > > > > > some appropriate squashing we can move forwards with a series
> > > > > > based on main?
> > > > >
> > > > > Hi, Simon and Nick:
> > > > >
> > > > > I squashed the first four patches as a "RISC-V: Some fixes for ri=
scv
> > > > > port" patch and then took the horms/main as the base to collect t=
he 2
> > > > > patches from horms/build-test-riscv-v2 branch and this series tog=
other.
> > > > > These are the Github link and all commits for RISC-V.
> > > > >
> > > > > https://github.com/sugarfillet/kexec-tools/commits/main_rv
> > > > >
> > > > > 5dc133e RISC-V: Support loading Image binary file
> > > > > b042f6d RISC-V: Separate elf_riscv_find_pbase out
> > > > > 8f344c7 RISC-V: Enable kexec_file_load syscall
> > > > > 7d4b982 RISC-V: Some fixes for riscv port
> > > > > 3205c1c local: RISC-V: distribute purgatory/riscv/Makefile
> > > > > 54f9daf RISC-V: Add support for riscv kexec/kdump on kexec-tools
> > > > >
> > > > > Since I didn't found the issues/fixes as Nick mentioned with thes=
e
> > > > > commits, I prefer to merge them into horms/main and let more kexe=
c/kdump
> > > > > users to help improve/fixup RISC-V port.
> > > >
> > > > Hi,  I noticed another pr for Fedora kexec-tools:
> > > > https://src.fedoraproject.org/rpms/kexec-tools/pull-request/24
> > > >
> > > > It is bad to take it as Fedora only,   I would suggest posting all =
the
> > > > refreshed patches together here again for review.
> > > >
> > > > If no enough reviewers can review them my another suggestion is to
> > > > drop the kexec_load support code for the time being, and only enabl=
e
> > > > the kexec_file_load support code in kexec-tools, and I assume below
> > > > kernel commit make the kexec_file_load kernel piece of work done.
> > > > Then it will be easier to review and make something working at leas=
t.
> > > > commit 6261586e0c91db14c34f894f4bc48f2300cff1d4
> > > > Author: Liao Chang <liaochang1@huawei.com>
> > > > Date:   Fri Apr 8 18:09:11 2022 +0800
> > > >
> > > >     RISC-V: Add kexec_file support
> > >
> > > Hi,
> > >
> > > I would gladly take a patchset for kexec-tools that adds RISC-V suppo=
rt in
> > > a coherent manner.
> >
> > Have I missed some progress on this topic? FWIW I can take care of
> > RISC-V support in kexec-tools, I even received a VisionFive 2 board
> > from RVI last year specifically to help with kexec.
> >
> > I merely don't want to duplicate efforts or "steal" someone else's
> > project. Is RISC-V support in kexec-tools an orphaned project now?
> >
>
> I thought about a simple kexec_file_load only approach previously but
> I have no time to work on it actually.  In theory I think a simple
> kexec_file_load implementation should only share some common functions
> eg. arguments parsing, file reading etc. and load the kernel and
> initrd into memory, pass the fds and cmdline buffer into kernel,
> that's all,  Even no need to have the arch specific file format
> checking as they should have been done in the related kernel code.
> But looking at the code it is not easy.  Currently the kexec_load and
> kexec_file_load implementations are not logically separate in the code
> and the cleanup is hard.

Hi,

My concept is like below (an ugly draft, not polished and well tested,
also missing zboot/uki decompressing), maybe people can use it
temporarily before a full support code is ready:
https://github.com/daveyoung/kexecfile

Thanks
Dave


