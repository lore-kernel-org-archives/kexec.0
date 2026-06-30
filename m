Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E56C43458
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 22:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ufRs7jbz+7zNErx/AfaA1flmtddekdRBnIktmT56h4=; b=vG4xRTfzTS/Kt+7beqfId3t56D
	qNPokMKIZW6IJxX+Ko/1Ip4OAEz2DsbxfvTO4PYQfUTje1MnVQjyKa2HcxGk9Zw4xS5e/SR6NwKAX
	+oAsmHSxctgFozV5t3Jt+P1odvkKpLLABasIEnuQ/Kl02flq6X00VG4UbnN44Tlyy4ZcW8S9TEiUe
	RbqisxOkS6ZIhjf9fIcwBfie2mohkPJRGnBXR779Q3F1Eokq4VzfjckREtq3X/+9VKc5pbzzl5Ka7
	g0f7iQ8nnER2QVhf0ME44kpcH2YfUGU16xrADmV1rYNk85hurljjy0MmdNlgIPdmF/iEH2EUYBXfR
	Iugc1bbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wehMs-00000000KqA-1FNM;
	Tue, 30 Jun 2026 22:55:50 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wehMh-00000000KpZ-2koB
	for kexec@lists.infradead.org;
	Tue, 30 Jun 2026 22:55:41 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-13b2b08a553so38596c88.0
        for <kexec@lists.infradead.org>; Tue, 30 Jun 2026 15:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782860139; cv=none;
        d=google.com; s=arc-20260327;
        b=qaPWT+Jq8W2n0ig9H5NbzmnO9F+1trjB80ujbm518s8wRPXhpk6+uEVmozpC6vjGgt
         02y747yzuL4Duw+XhIXeNbhblHEe4CduTZ3dExeEGOIU50kEtuoGV9c/hO1l73+ipU8C
         f/0+8qTtulf4oz2YKTB3CYc+NeC2vIpYlm37AyAkwHXm9yugNHfjiO8S+TJPDFBJlc9Z
         MlJMiQeNMQWj68jBDM5CDhLp91kiU1UKLkOlBAixMigHhDc4EqA6vPzGJu/fWijjxn2Q
         6tWpdacRBJy4662it6PS5JRcL4zZvqomDWE/zixi7ERQDkzPNFClUWDZqv0Cw6nyDXrg
         wbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0ufRs7jbz+7zNErx/AfaA1flmtddekdRBnIktmT56h4=;
        fh=cRzzaDLJQaFLF2FoTb1WZ3MqG55yjTUekmGv+TftpuE=;
        b=rcKZtZQ9ICPgQErrFl/ynIKXD4cgtuJqScVGF4nrxJ9y125vPPE27XPJUjX0UtCBZj
         9nRnvj+nu6x+seBvGWXzBRm0Nf1SIhpp6GZCblLOV7jAPUxkLJohudxE+0uiGyVQNAVA
         9WE8j7IB+f5N2bhYF0zsa8Lw9p6Jrz44u0a/Xk3WxNNhE2foCMnD2Zr31WAZ2bggcKOB
         tbvKshwP4PVtsv7wBmJjn7gEZ2p+UEDy15CzB+8VynJLJh6LNCX9ROK1j06PLRLaeSHs
         4DwUHfRhcvsQ0VYa7d3Iv52jV4s0lQayGHTmPQ2HxTyJnwzJn5tfr69dfK3PQS1lKTDw
         WZtw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782860139; x=1783464939; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ufRs7jbz+7zNErx/AfaA1flmtddekdRBnIktmT56h4=;
        b=qXWT8BMKRPJXc/yrJ7vfDcn3LoyL25GP3gJpZMoPFEA8GyqXe9LdLTmW3aZKIm6+6q
         HA2Y70z+Qum/FyadUdAV43YZewEvbwFBSaE2NFyR3Y74RP8JQmgPlLdsjlMNCOLhALAw
         i8f4bwY8qTWkdsyxGpKZhPDlydpPg6FMN1fmVmzs4WMoxwGXpwG3Nk9Zo+aykWb7LGXr
         n+YeP9wvgwhU1LH7PzzE061Hxvo3cdCDuKJS80Ufd9sp5K/lOzsF7IV/yYXoy5kXyBbo
         GDGfOHy6E159suQdmUC1jDWN7Tnl2tDpMxgweOQ4TQYss6fHMp8YXh7OWgMJPH5hblmm
         V0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782860139; x=1783464939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ufRs7jbz+7zNErx/AfaA1flmtddekdRBnIktmT56h4=;
        b=PPBWM6oXX2jzErnosNaigi+6S7JlbvV7emoMP25bY1qTWqIDjespKfWdmklBVx0m6V
         QpMNbfun0U9NVCthKU1BOJGLBs4qFZ2WyKgRCwPEsrdoR3NmGOc6EnZATVCxCt0Rj3Pf
         unMgpkI0FtVIy6wtKlPKYApraTQonaYhba3axVdUGApAYgIWhBWs5pbTovSTDTel68KE
         +R21LKG/KH8rIiSEeGYsOsWWH2XWrn1go1nWRynjO3TPXwtTeQFjOLvi3D3tgNTt5ue0
         PNWdkTIvvL4qGj5l+X5pS0TZ8iCKiFnUFzmJbMuS8eEsZjFVXMfiSKBa/oUzKHIlpg8F
         PGIw==
X-Forwarded-Encrypted: i=1; AFNElJ9O3nIxsszh8wczepGB88QKvyYiWZp6nfUDMHo3Z4p9JxBabtuoNYaZnpdN0EfJnvUlG7D0Fg==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywbbj28PBWvi49dJGGe76C0mS7swmJFl755lkcd/Y5500wOcg7R
	ts0Hn1J8Gun9aj/EwfovJutf9xR4G42MHt3HCFYs307IVb4rgIKXKUkzg4i9yjnAzKHzLgZORZc
	a3HVXFU6UKdO/fdmVRr9MI1AEr2KMOxZvroEICEIP
X-Gm-Gg: AfdE7clrjd63+EGwPg1dmETHur5xgeExw8QIFT5RXN4DLjBKOXBtMtCL7GiH70B2gLw
	Hyd7Y2KoSE98hr6TWC4uInX1ltaUvvXR1TY6qBbvhHEPIsMdNyK4PpgiqPdXt+T3jVLoTm5QpER
	X4/1z4lTXrNHq9htT+ZjWiTMc+WR2/BdNcdeiYnquqRxNrHa4l5RLMGYAjhXKOEbq9fxPeqN0cd
	XiSSXPl35/mneymjoemkB1UkP22vmvJQnIyXLf+VqRQJyC2kWoERARvf2fXLP4APTnzvbGd
X-Received: by 2002:a05:7022:60a:b0:139:ed5d:1b5a with SMTP id
 a92af1059eb24-13b2a1c0f41mr3645093c88.40.1782860138109; Tue, 30 Jun 2026
 15:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260625054946.73445-1-duanchenghao@kylinos.cn>
 <20260625054946.73445-2-duanchenghao@kylinos.cn> <2vxzfr2bkn0j.fsf@kernel.org>
 <20260629100621.GA215869@chenghao-pc>
In-Reply-To: <20260629100621.GA215869@chenghao-pc>
From: David Matlack <dmatlack@google.com>
Date: Tue, 30 Jun 2026 15:55:11 -0700
X-Gm-Features: AVVi8CdC-YicerQYwyKKogj1zQs5YRNCTCvCtXWkU5DiVwwhFHMSMIyXZ1dV4nA
Message-ID: <CALzav=c+RzWpJTrpsdwnHUT=EZCGv=FGtmDq9ipDE7jNuWNX0g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] eventfd: luo: luo support for preserving eventfd
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: Pratyush Yadav <pratyush@kernel.org>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, pasha.tatashin@soleen.com, 
	linux-kernel@vger.kernel.org, rppt@kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, jianghaoran@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_155539_707427_8D0FA681 
X-CRM114-Status: GOOD (  35.78  )
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

On Mon, Jun 29, 2026 at 3:06=E2=80=AFAM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> On Thu, Jun 25, 2026 at 11:06:04AM +0200, Pratyush Yadav wrote:
> > On Thu, Jun 25 2026, Chenghao Duan wrote:
> >
> > > This patch adds support for preserving eventfd file descriptors acros=
s
> > > kexec live updates using the Live Update Orchestrator (LUO) framework=
.
> > > Userspace applications using eventfd for event notification can now
> > > maintain their state across kernel updates.
> > >
> > > Preserved State:
> > > The following properties of the eventfd are preserved across kexec:
> > > - Counter Value: The current 64-bit counter value, including any pend=
ing
> > >   events that have been signaled but not yet consumed by readers.
> > > - File Flags: The creation flags (EFD_SEMAPHORE, EFD_CLOEXEC, EFD_NON=
BLOCK)
> > >   are preserved.
> > >
> > > Non-Preserved State:
> > > - File Descriptor Number: The eventfd will be assigned a new fd numbe=
r
> > >   in the target process after restore.
> > > - Wait Queue State: Any processes blocked on read() operations will b=
e
> > >   woken up and need to re-establish their blocking state.
> > > - All other internal state is reset to default.
> > >
> > > Changes:
> > > - fs/eventfd.c: Add eventfd_luo_get_state() to safely read eventfd st=
ate
> > >   (count and flags), and eventfd_create() helper function.
> > > - fs/eventfd_luo.c: New file implementing LUO file operations:
> > >   preserve, freeze, unpreserve, retrieve, and finish callbacks.
> > > - include/linux/eventfd.h: Export new functions.
> > > - include/linux/kho/abi/eventfd.h: Define the ABI contract with
> > >   eventfd_luo_ser structure for serialization.
> >
> > Why do you need to preserve this? Why don't you create a fresh one afte=
r
> > kexec? You just preserve the counter, which looks pretty much useless.
> > You can just as well open a new eventfd after kexec and set the counter
> > value if you care about it.
>
> Thank you very much for your review and suggestions.
>
> My original plan was to integrate KVM with eventfd. Eventfd serves as a
> critical notification mechanism between guest and host, and it is widely
> adopted in various scenarios such as networking, file systems, and
> interrupt handling.
>
> At present, however, I have only implemented the preserve and retrieve
> logic for eventfd, and the integration with KVM has not yet been
> completed.
>
> I have a question and would greatly appreciate your help with it.
> I have been closely following upstream developments for the liveupdate
> feature. As I understand it, liveupdate is primarily targeted at cloud
> virtual machine scenarios. The upstream community has completed the
> core framework for liveupdate and memfd, and ongoing discussions are
> focused on state preservation and restoration for VFIO and IOMMU.

Yes that's correct, but that work is to solve some very specific
problems for virtual machine scenarios:

 1. memfd preservation allows preserving guest memory and userspace
(e.g. VMM) state in-place across Live Update.
 2. VFIO/IOMMU preservation allows PCIe devices assigned to virtual
machines to keep running uninterrupted across Live Update.

I think this series is missing a description of the problem solved by
preserving eventfds. We don't want to preserve all types of fds just
for the sake of it. That will bloat the ABI (which will make
maintaining version compaitibility harder) without any gain.

>
> I would like to clarify the following points regarding upstream=E2=80=99s
> overall roadmap for the liveupdate feature:
> 1. What is the complete upstream plan for liveupdate?
> 2. What will the final deliverables look like once fully implemented?
> 3. Will any new kernel internal interfaces or dedicated userspace tools
> be introduced?
> 4.  Does the upstream community maintain an official TODO list tracking
> outstanding work items for liveupdate?

I don't think we have anything comprehensive but there is a ton of
work to be done if you are looking to help.

A good first step would be to attend the bi-weekly Hypervisor Live
Update meeting. See
https://lore.kernel.org/kexec/aiWW6ZwwalqQmVcB@google.com/. The next
one is on July 13th.

