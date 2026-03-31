Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB5910F92EB
	for <kexec@archiver.kernel.org>; Tue, 31 Mar 2026 19:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WNrspuYtGpLQj+NkezxGKMIJ1rBS9R7nl7zWYbPt1p0=; b=SHAP+b0GhLIYwznbDlLUHH1SmV
	h8JNg5T7Ihr/XPqJVHPk8nD2fmnrA5+G9Zw1ObtnJW1rUojkxtsPN7a23nPONG6miiq4EcOI2SXEH
	hcxgE6ae2FnYmLWAqWO5qDMpfZP286Jnt1r1tkcWvu40Vcyzy7bfIG2zd/oAD4xUGR6RwBT7TnM0k
	ijU+tJuLfKXlgUgTM1tB0hECWB7kLXZ3xT9FzFm23iV9UWfkc8drI+/BctFg/RuFSP1awY4zLh7cH
	PiUM+pCx832p7K5h336ZHOI5zLlaBdbLI8/dpsgxwEIRJ5o39U0sSwE7VuT5IwMUGULdtyZtAz2fH
	Pt+CNhIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7elF-0000000DTqn-2r6C;
	Tue, 31 Mar 2026 19:28:25 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7elD-0000000DTqS-0mJq
	for kexec@lists.infradead.org;
	Tue, 31 Mar 2026 19:28:24 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-66beb35caafso4615490a12.2
        for <kexec@lists.infradead.org>; Tue, 31 Mar 2026 12:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774985301; cv=none;
        d=google.com; s=arc-20240605;
        b=iDIAXTQq3a63stYbeYU30n013j7ha4nopMgBOwDhr5cFu4A6NBMRZ8kzSr6WMrpPOr
         +OsuEQPcGtNcPR3ufLvNmz5MD0/oL/ns/BSZvt6eslM4pPc2gLK0ZAbW3vMEOGCpS4Vc
         WSR0RSSYf/U1n2THZSFoHgEwb8p0GSLRA1ShMXhQdI3zDyDwYSEpPbO1wv70OlT+QBnw
         k03TxugtLXIcTmCITGmPI6cUDgPVf/3jdz0Iq/BYhdkOHe8r0jkpt4aJIDIqYp0FYBjs
         na1cALA2qP7qYpULnaH+hRHKnelTgAdW5hyU6Mx8RIJcU2qE9oMJTx56p095H21v5yzs
         MTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WNrspuYtGpLQj+NkezxGKMIJ1rBS9R7nl7zWYbPt1p0=;
        fh=apjNyDS0MOMifIuRBEkWLAFe4SK8L5j7/hR3n0HjLwY=;
        b=ed5vggY6f16FTAhOeiBWY5t1gbjgiNllflztnQI6BcPzNZN0BIEQ3pzZvFW2GaPGgW
         tRy3hBOI8c3RNGWPb+3nyai7dmU+MgMJLg8ltg+Ko52U4DdTl0pcNOdTB5a2rmdyZcas
         LKZYUImfQo4gNanesgDIyK9EyrLNAPwEsQ/gT0bUOpFnnZJSzFDKsS7YB8PZh8G1AIbW
         qRZ0CJIuHx1vQKpv1izK7H5tKW0fuTiFPRdazjOZfNCqWQ1BXod99kzRV6og/V3VBUUf
         ik93hc7Cy33ZXGWVkL8K+CdCbE/knHP0tZTQFPs4puqV1ySpXx31P/fNSL+mQM0fUeap
         8RcA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774985301; x=1775590101; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNrspuYtGpLQj+NkezxGKMIJ1rBS9R7nl7zWYbPt1p0=;
        b=Rso7WCUq3fcjM2GL6bseB6lSlv4dHW8ORgZwLhh/7gpbCoITlnhgMiM6sILfrD4Z2a
         JLeqS4Vag+jRbxmk5x3u+5m/3F/0mjQLCM4IETQmpdYti68qSFcQ6m1iYTMl8JHBRPUd
         P9U3NG7J+k8tM/BOt7rWx06uBnVBGrHKdc3suSaGo6eN9rUqYZ/vXdaCPOH8bfJgNZmp
         41hfSKQ9fOZDYEwutdDzvxWqioVfYVETYqQZH9lwgz2+s8QMcAMHZrZS/P5wZGBFwDkh
         BIC7n3cXYxYwDMt0SpNeBsw8CAkEGZ+rw4+F0dlu40OLuup2WIurR6W1rt0G606MdoWU
         VCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774985301; x=1775590101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WNrspuYtGpLQj+NkezxGKMIJ1rBS9R7nl7zWYbPt1p0=;
        b=enQZzRUTWnRCGB7kKy8oM46DKGCDPV+jCq4RAMO68fLF+Q3epu6cwGK9lB2nNqKrJO
         AyYcZnHPz0XqtdSMKKSb4n//R/Q0AA4sinzNrJHCKaKTl0oiaWg1gJQ2oDFX2kMEVulT
         f08p4Wc2kxAb+fjSKFG1KwsgNONH/TgeVXEe+KERJBB/KITUuhaiuLDLV7PYGiX2SolG
         XV52cfFOkAQeyubPenQVex6zN8pqEzcGEyxduI/vr5VwtDMJhg90avDOFu2O9v+tB5c8
         6l5Cd9+E28uU9FP32DZktf40+HbbSu+eI6QzT1sg8IrRxuENpBU8mPZzK+ppDUStD8q3
         TUvQ==
X-Gm-Message-State: AOJu0Yyy8soEsO4a6A50Ob2Wi+lli7ufHAPxES2mEWrKNO+Vl5wQ/KEZ
	Z7pnODzhjjguqIxqdthZvDWVJeU2jHQuNFF6AGbwwQ0dD/foZN87IPP6XAAMkewd/Hcmqm5Ablw
	YRNPRdTtjWHDtATYydmlCM1XaAfoaqwACrj81E0TKeQ==
X-Gm-Gg: ATEYQzx3gEsvaeZ1HomRUmt/8aNCmKWyHPiJ+83EF/K8ZXdLzz6ePqpDvCPIcqSQECH
	AHvCXgfwYraSC2swuXNPKn9YXaROoEHW0gKO3bTIXLHh9cyMzbUJeCvZ3pDC3NaEFlThVVNWy1Y
	iiDcrpTNQnU35LoqR1pyBgCgB1Jly2E2uPKlBaR0coEjwoevatu3OLKvz3wgz9Rd/Sxsu/stxkD
	OwtLvcRj53BDXql0eVbSJPgwa949RT3LE/BD7b6nDJ0UrkjmX48zuoD9jUsavVLF96+a46x+mdh
	9QeJGQbqgURLWRd3nOyDNkutKHhWSBjfd7NRiw==
X-Received: by 2002:aa7:d8c5:0:b0:66d:ce0a:2589 with SMTP id
 4fb4d7f45d1cf-66dce0a2664mr215108a12.18.1774985300846; Tue, 31 Mar 2026
 12:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260331175639.4066033-1-luca.boccassi@gmail.com>
 <CA+CK2bCKJ8rkJ_onp9Za0KNuWujH4Gzue3a=HvwOJAK2tYhReA@mail.gmail.com> <CAMw=ZnQcAggXOXY2s77qtgTS_d4td-5PXeMXEkMEVwnMFUrGPw@mail.gmail.com>
In-Reply-To: <CAMw=ZnQcAggXOXY2s77qtgTS_d4td-5PXeMXEkMEVwnMFUrGPw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 31 Mar 2026 15:27:43 -0400
X-Gm-Features: AQROBzD_cmcyX3I7_Q-hpxpZ7m3linx6OUGK94mkQkw4O6IVQgnm7N_y1t610xE
Message-ID: <CA+CK2bDB1Z9tsv7dHGHGnfRcSyYZ7MTsCXtvJYVMAmgRZyZ=PQ@mail.gmail.com>
Subject: Re: [PATCH] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pratyush@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_122823_264231_82841F6E 
X-CRM114-Status: GOOD (  30.21  )
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

On Tue, Mar 31, 2026 at 3:07=E2=80=AFPM Luca Boccassi <luca.boccassi@gmail.=
com> wrote:
>
> On Tue, 31 Mar 2026 at 19:34, Pasha Tatashin <pasha.tatashin@soleen.com> =
wrote:
> >
> > On Tue, Mar 31, 2026 at 1:56=E2=80=AFPM <luca.boccassi@gmail.com> wrote=
:
> > >
> > > From: Luca Boccassi <luca.boccassi@gmail.com>
> > >
> > > Userspace when requesting a session specifies a name and gets a FD,
> > > but then there is no way to go back the other way and get the name
> > > given a LUO session FD. This is problematic especially when there
> > > is a userspace orchestrator that wants to check what FDs it is
> > > handling for clients.
> > >
> > > Resolving the /proc/self/fd/X is lossy as that has a hard limit
> > > of characters, so names might be truncated. Also requiring going
> > > through procfs and doing manual string mangling is not a nice
> > > pattern.
> >
> > Hi Luca,
> >
> > Thank you for working on this.
> >
> > This needs more explanation. The way I see it, the user orchestrator
> > can be the only one that has access to /dev/liveupdate (and this is
> > actually enforced by kernel). It opens it and creates session_fds for
> > any client out there. So, the orchestrator already has the FDs and
> > sends them to clients(e.g. via SCM_RIGHTS). It then monitors the PIDs
> > of the clients, and if they die, it closes the session_fds for them,
> > as their data does not need to be preserved.
> >
> > Could you please explain why the user orchestrator would need to query
> > the session_fds, since it is the one that creates them in the first
> > place and has to keep them open in order to preserve them during a
> > live update?
>
> The orchestrator cannot and will not hold on to all this state, that
> is not possible. It will simply hand out session FDs on-demand via an
> IPC, enforcing a naming convention for the client, and immediately
> forget about them. Clients will hold them and use them as they see
> fit, and then store them in the FD store on shutdown if they want to
> commit them, and that's where the orchestrator will get them back, and

I see. The idea is to expand the LUO Session API to be compatible with
the systemd FD store API.

> they need to be verified that they come from the right cgroup, what
> the client's portion of the name is to be able to hand them back after
> reboot, and so on.

So, if I understand correctly, the enforcement of who gets a systemd
stored fd returned to them is based on the cgroup name, right?
Presumably, after a reboot, each VMM would have to start in a separate
cgroup (using the same name as in the previous kernel) and request its
session FDs back from systemd. That is what will be used to verify
ownership, am I correct?

