Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB0F10F92F8
	for <kexec@archiver.kernel.org>; Tue, 31 Mar 2026 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P6pVCvPmJ8zZo4wz569DUvEXPXLd6B6BfKDtUFU2IIE=; b=3nWrewaV/6hinNXw1YwLwHt/VK
	u218FWbDhGbTlSmshvcnXRsxFt0ZPeAo3MQs9gGZXS2VJC0iiVX9zGZpmP+KjZUpAGyLxRdry4pnZ
	VzCoHxlkYruo593iswrP8SA8Ev2clAMaKp8DM8W6UZKL94WIxmADNuql9RKJ3REe5oeOxz98kQBVT
	7oG+I7tM71rlLSsqSU9DYuVwqUrN8IPQY3iXpq3R4n60D5paH5aWkNMX2WxIbgAsvUupc/MXNFapm
	V5Qu+qb4kc0kM/34gEwA8PcawjvNU6yKgWMsrJIWrp3ZY1BrUnJdFTX0zJNBHpvn4mkuBfIvml/Ft
	dYyzx2OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7f3O-0000000DUsy-3KdD;
	Tue, 31 Mar 2026 19:47:10 +0000
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7f3M-0000000DUsa-343k
	for kexec@lists.infradead.org;
	Tue, 31 Mar 2026 19:47:09 +0000
Received: by mail-yx1-xb12f.google.com with SMTP id 956f58d0204a3-64d5a7926cfso9218336d50.2
        for <kexec@lists.infradead.org>; Tue, 31 Mar 2026 12:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774986427; cv=none;
        d=google.com; s=arc-20240605;
        b=F0VBddpumW2P+fnsMntejkGTAVwaHgXfIUQmc0vDLx7AvmcEzufEymdI0OeVXt7z6C
         Fbf15gCfW3eVLa9jEuW1nOqC3/IvKzRKY75xzVZ3rkWQHcDLDZfR3cC0SNAKGcXLua+9
         /SKSZFt1fbEBD91fVpORYF5/UackIJmr3B4pcrhBETVFEjEi7LkcNOKCA2IWc8hx6Gha
         u/QotdtNDzl/6T5bBWoVv75yAJ74x9xwHAqQuDv54jwCceVQs7M08Py06L9zwkTi+dnU
         Fg5pacjr40WwLeTp4RWo26SVSYbOnsy1iL3WeSnevHWe+8MncEGWaZvhUoxfV3PvyEUp
         +n8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P6pVCvPmJ8zZo4wz569DUvEXPXLd6B6BfKDtUFU2IIE=;
        fh=YVJ4hsELCKgDqXx2GU/NVlA92oEIniguYCDFSY+GV6A=;
        b=W1WH126j5X+Fk952w1TrlEUq6cIX5MnVmZJtK+/Tusb2FmqSG0NwVmkHc6mcyPkgWl
         kKuChq3Jh0Zm082qDjEBh7wJxB5e3YLCDcVUITDLYekX2GRmK57ikp7YhFxt73YvU/Ht
         yvpzZOXL9fjNTN7fhTxdTu/nIRqu9U2kvTYsNF91jwIoWWsUace1mHDYsRCioaClOfPF
         5xujBukiEwHae4HBoX7sh4qMmXOfWzt6cPNnC/ArvGv/c3JcBtp0iPPt1CKTs/LueFN8
         nPO9sDRhPUWK7dUpRRCsqswi/eniuuHaOo/dWvf+EiM9a39BWTvG9wcPk5WYoPflEhJf
         bmUA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774986427; x=1775591227; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6pVCvPmJ8zZo4wz569DUvEXPXLd6B6BfKDtUFU2IIE=;
        b=acaZpVAg4aR6oB99iT2Mee4VIxEX+PdJFeYqpETIR/+wqUuZnaYnUgCwea12B+HjhZ
         syOALZiJ8gKVbQqIrixPxn0LkAdudVZ0HH022la8V8vPRaCj1yHUlMdSJR3IAgOYdm91
         LQ1y/RfvVcTpoXQb6qk5lvGlJjasJHq6q0+tBaWXRdry2zk6B2rqB+Pdw2+XcZDA0Wpa
         UqHWwl3sIH855m0vKM/pM55OmtvzNSg3IO/PR6a5sd8y+dwECp3L90UbHBOyLD6xKkVk
         IrljdLlWjZ63j+F/Ht0I7VgIHW8v09d466eXm1v7qxWg6v98qy23V25GKq/7q4AyQjrn
         +dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986427; x=1775591227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6pVCvPmJ8zZo4wz569DUvEXPXLd6B6BfKDtUFU2IIE=;
        b=TwHdg+cUa/OF+9RagZ2Lk+WTHL3Gl4+tKGe3iwbO2ZtRx7JEaYd+ugkzLi8ey8KHyy
         +/CHl88m7hCTR9+T9lQ5bziRccQyf8G793j5QHUGGkzmz5sERiJv30xtTO122n610Qdp
         SrFqnEgN1MfCYC64thCVihQtE5XXe2ZejY7LsrcG90qjQiKZhy8NAy9UFY+R4K2TLeSR
         TT68YpbjB4NHOfkx5i7QSLuUzwAXG6o0N7sULXO53HOfqz0zr+cgS117Sf1lRQKo9krb
         tJp3G54+MvisxxuunFxDoyxKPNJqHWSaA7UOTTfW8npPexG+bby72sa6zYv3QNGJhljm
         fIPw==
X-Gm-Message-State: AOJu0YyHIUj6CxuCh6yTkhM1weuZrtcC9YOiDotkfX9Jla/0OclzV+Zv
	9ZphtaxuB4g6+0ghEGul/bFzaA+LvuGr6fxkB6eeaOM6PE7td+7IimPo4buftueQW5ySPXI20cr
	8/vL43b7W254/kVcoroF1HqxbuQsA6jM=
X-Gm-Gg: ATEYQzyBgH8MPezvsp8FdUJutCkHy+uoMl14+gs90WaH5LXR0kUnWiLxZbD85MXYOcB
	KHmb5nmeFLR0xElZW+jFizU1engmeVuDrmvy8LtUQdtu7cRuzzwVPPFpZnVSUgsrA5sBe40vcho
	w9yWiPuJuuj+z6q5aCZ7ousJJg32NmmyZHaZ/mrHXl25ACMtqEZcRlzg9Zx1sPyhn6cE7DZGPPz
	NIEJCFCFVZTGGY0drWWePNhEZf/+/xDRf6bAzjEdIDi/Nd5TGGf1ef1yVR8d7xH4jAFPynmV2+6
	dK3b4h3B1Wc6TAwbcuUnF476oVErNTvI+h6RXcWaEQ==
X-Received: by 2002:a53:adce:0:b0:64f:1278:e7b3 with SMTP id
 956f58d0204a3-6502fdc14aemr517173d50.22.1774986427400; Tue, 31 Mar 2026
 12:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260331175639.4066033-1-luca.boccassi@gmail.com>
 <CA+CK2bCKJ8rkJ_onp9Za0KNuWujH4Gzue3a=HvwOJAK2tYhReA@mail.gmail.com>
 <CAMw=ZnQcAggXOXY2s77qtgTS_d4td-5PXeMXEkMEVwnMFUrGPw@mail.gmail.com> <CA+CK2bDB1Z9tsv7dHGHGnfRcSyYZ7MTsCXtvJYVMAmgRZyZ=PQ@mail.gmail.com>
In-Reply-To: <CA+CK2bDB1Z9tsv7dHGHGnfRcSyYZ7MTsCXtvJYVMAmgRZyZ=PQ@mail.gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 31 Mar 2026 20:46:56 +0100
X-Gm-Features: AQROBzCZMrg1QaVOm36h96ccl-T60eQ_EqWFDMABE8fw_zScwCx681KFLt1TMfk
Message-ID: <CAMw=ZnQEuYrti57ZRXRUYXVryyBRwQgaU_7Moc5R4zaUHjYSGw@mail.gmail.com>
Subject: Re: [PATCH] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pratyush@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_124708_787239_CB569AE7 
X-CRM114-Status: GOOD (  38.64  )
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

On Tue, 31 Mar 2026 at 20:28, Pasha Tatashin <pasha.tatashin@soleen.com> wr=
ote:
>
> On Tue, Mar 31, 2026 at 3:07=E2=80=AFPM Luca Boccassi <luca.boccassi@gmai=
l.com> wrote:
> >
> > On Tue, 31 Mar 2026 at 19:34, Pasha Tatashin <pasha.tatashin@soleen.com=
> wrote:
> > >
> > > On Tue, Mar 31, 2026 at 1:56=E2=80=AFPM <luca.boccassi@gmail.com> wro=
te:
> > > >
> > > > From: Luca Boccassi <luca.boccassi@gmail.com>
> > > >
> > > > Userspace when requesting a session specifies a name and gets a FD,
> > > > but then there is no way to go back the other way and get the name
> > > > given a LUO session FD. This is problematic especially when there
> > > > is a userspace orchestrator that wants to check what FDs it is
> > > > handling for clients.
> > > >
> > > > Resolving the /proc/self/fd/X is lossy as that has a hard limit
> > > > of characters, so names might be truncated. Also requiring going
> > > > through procfs and doing manual string mangling is not a nice
> > > > pattern.
> > >
> > > Hi Luca,
> > >
> > > Thank you for working on this.
> > >
> > > This needs more explanation. The way I see it, the user orchestrator
> > > can be the only one that has access to /dev/liveupdate (and this is
> > > actually enforced by kernel). It opens it and creates session_fds for
> > > any client out there. So, the orchestrator already has the FDs and
> > > sends them to clients(e.g. via SCM_RIGHTS). It then monitors the PIDs
> > > of the clients, and if they die, it closes the session_fds for them,
> > > as their data does not need to be preserved.
> > >
> > > Could you please explain why the user orchestrator would need to quer=
y
> > > the session_fds, since it is the one that creates them in the first
> > > place and has to keep them open in order to preserve them during a
> > > live update?
> >
> > The orchestrator cannot and will not hold on to all this state, that
> > is not possible. It will simply hand out session FDs on-demand via an
> > IPC, enforcing a naming convention for the client, and immediately
> > forget about them. Clients will hold them and use them as they see
> > fit, and then store them in the FD store on shutdown if they want to
> > commit them, and that's where the orchestrator will get them back, and
>
> I see. The idea is to expand the LUO Session API to be compatible with
> the systemd FD store API.
>
> > they need to be verified that they come from the right cgroup, what
> > the client's portion of the name is to be able to hand them back after
> > reboot, and so on.
>
> So, if I understand correctly, the enforcement of who gets a systemd
> stored fd returned to them is based on the cgroup name, right?
> Presumably, after a reboot, each VMM would have to start in a separate
> cgroup (using the same name as in the previous kernel) and request its
> session FDs back from systemd. That is what will be used to verify
> ownership, am I correct?

It could work either way, it depends on what the client wants to do
w.r.t state separation. If the client is fine with having a single
service being in charge of all sessions, that's of course ok, it can
have as many as it wants to.
But this also makes it possible to have strict state separation
enforced when that is instead desired. I intend to make the interface
to request a session privileged by default, but also gated by polkit,
so that it is easy to make it unprivileged and scoped to specific
uid/gid/services/etc if one wants to, with a simple polkit rule, and
in that case we really want to be sure that nobody is playing games
with other cgroups' sessions, as a precaution.

I haven't finished getting this part going, but I'm close - the client
asks for a session and provides a name, and the cgroup path of the
caller is prefixed to it when creating the session. That way they are
all tagged in a way that is immutable and unique, and that clients
cannot mess with. If the client wants multiple sessions they'll all
have the same prefix.

