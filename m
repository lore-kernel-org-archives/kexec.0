Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205F1606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Oou6tRIt;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SF4q+VFN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=sClihItsgegsMKKiMW0EDJ5IHIVhrTOtuDwhYJOOpz4=; b=Oou6tRItplrTsC
	hBpSDy+h2QjNClWuk2EcmjUfM7faRm3Uytun/xT07F0rz4WhstxFCzRh8PpW+13Vf7MUr5U9+PPVf
	lLRdbbFFDjzRqc+A889Ri/0vwaRuk7NxfXkI1BKcqRwCCxU9hxT9ncyigqrHGIIDb+gHwFWTvd1bg
	TpCBGLuy7tc8VhLMRFVdZswZDVvqLLwzNYpsl9gGb0CpJpBzc6obWDZLl41jDuOqaAw3TUMN/lhYE
	0dPv+BZ1viacm1kAm0yGIyTnqVM+9GtYwWCkoOfr8sDwcLu4warWlR/+hKbaWJsWSWA3AZrsqJOHu
	rDmSOjqmYqTZgqFMFdoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU1N-00000003Prr-3bAw;
	Mon, 26 Oct 2026 23:22:29 +0000
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU1K-00000003Pqa-1BCM
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 23:22:28 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-8ab395abf79so31697577b3.0
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 16:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793056944; cv=none;
        d=google.com; s=arc-20260327;
        b=Ue2sEm5ciYfbRFqdiwifDOmofJsWFMjtgaxcda9CF6JYN9KT9siDiiODpPHuQnyP+K
         7zBVKASfP3f092MdgUakkHj7mzCGh5zAnED7EjzsSZkiYobc36PM44EhGI6xQgNwRrBZ
         fukpBPOVcT7GBrl+REiYbMe3VqpMJwjDe7urkshSs94BwPx/6vS0o1g9i69DX1cYAXez
         RfxCx6YBN0ukpXz67SIfi7Hm6e4NRtbxtek7/QD3aOOGNyw5NYLT7SXgfHUrK2yCAT9Q
         ObSmWgTPdD2zsNB7Vsq5p+6jGY/kCLfz550PQAM4b9+hvpdVY4OKCu+BjNtjpvG8aw6B
         lIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sClihItsgegsMKKiMW0EDJ5IHIVhrTOtuDwhYJOOpz4=;
        fh=BeC3ZX+jun0Pg9MDxPsIfKtbLrUeCs5hhqy8yoiw3Jo=;
        b=NPaN/misyQGwZrWkf/tTyWi84Hj9R+wqMWtnd5aiRGbcGVU8EO/CUwx5v1eui78q9F
         xMp/+wwJCVanQXm1emP4ICHkM2K86ZUCOUnG96IhvlI4Tk5AlPL+ZO6FkDaGcb5A4Cu1
         T7/6MMDV+VujvgPocQTwjcTNYdC/fGUhob7RJo8ZOAryZPQfCLQdCr9XMw+kJPgRy/cg
         vWRtG3pJIynSH8phxTQ/Mr1pkp4H+fxAa1KYK0ktt2b0hZFHKzpc5EEAgU15zLHn4lbO
         rsHoeuQ1C5xbckUnZBHcY3c5D4x1y8AXOJo9+bds/4H3QgANwC39ulvI1vWlGW293RRN
         +7Og==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793056944; x=1793661744; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sClihItsgegsMKKiMW0EDJ5IHIVhrTOtuDwhYJOOpz4=;
        b=SF4q+VFNMr7p/v+r1rH/MncMYUPMkeK6yLROvOdegg46LL5bstXEbTQWYAcdfJrvUA
         xiGKYsVsP63aRneX7y2AtE0rPUndro8tC+PCcFX9TI+2t1ilGo/27CEIP8siPo0MPdFv
         P5S01Gl/bS1VkAtxmH7EFZLW02xb83s3W0bCkNuzR5ecxxoMGLs9DLikZaraGbWmDi0D
         2msPnfBMvCPQYlioNrN5L6SXXN3dlncrfFoop98E9TGyTgpZSKrgur96Uscvs7AtdwaL
         V/wrT19CqC7YbnVOUrbnjidv0g3SwNffQvxjiaIk4yywqcQ8Qk0Lp7gqBzs92SMeyP6i
         PLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793056944; x=1793661744;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sClihItsgegsMKKiMW0EDJ5IHIVhrTOtuDwhYJOOpz4=;
        b=miVYO6LYQ6E+XHRJS64Q9g/21X1+RFfN0f2KAQqAKJu2ncCDaKdbfVjGFGKgsILWJ+
         Xwqi/Y0iUIKRkVSg8DFz4AJprOm5+3mYKpryu5bD67gd4wfhOCP2WnBGWHeDKTHXadvJ
         mqLT/64GfIERmOP0tTgRAUb3MmNByQr2ATAbnVFcHtvwrniFMcw8tBlBTHMVNkyAbM/H
         SQV7WeB6P4OOwn2trpL5HQYK7SkFhSgBVLWVtvavYNUG0DZoBgRzp8cOq0H24tA1PYtx
         dn1V9afqZ4xneJG3cWxnfHos6Bhp28y00xo7QtkmeE74x2Tgr0mlyjrA+/XWi2OhId3F
         ckhQ==
X-Forwarded-Encrypted: i=1; AKwUvByV8pyq4Az0CbWrQSehARwJP4gGwDJo6Yq2IirYHQ3Cjy9U5tpsqk2lhca65FiOwGOpGqHGqA==@lists.infradead.org
X-Gm-Message-State: AFq9FYL7GCY2b8ZCjmJ1iRBx46yhNkXA4kYJzwIUKew715mxPY4xEBOG
	hiAMd/xCWW6Hyot6Ca/PsBx4hd5WwoNXgsj0ILu8gA95SeJmTovykHahFU6YUMB34Ajr4gie/eD
	Sa3Y9MBeOM2XPCR2fzL6Xzps1kitQU0o=
X-Gm-Gg: AYBFou3010CUGg9AUo9Q3MyPeJUNv5E75VsvQaYTWll98sHfFDnQlHDswK7yVjS8285
	B7+gjY+xaUjDmAiuJ+6nopj9FcPw69qIJ7r7Pd4C4M/epP3+g9+5ZZV2eCIFwWhPQ6FvjGlrh1y
	f2BYXYnITriddqXKToJ57bg5S0rzd2PrOvuMeaLdSeF4AYgUX3Axup2KmfqX80TpZI70yz+ocTc
	qMt8eCGH6cIQiyOUN78W5KHq1Lr1j3BOVJkRVqZUBIQQdJq59lV8DBeoYwCDYGPa5KaNONN+qcy
	KkXofi/cicYBxoOT+xBT7IwMViZQcyKFIg+MjhRCDvMPis2ySz78k45TjFffxWEprvqjKyE/IUT
	CwkkfgELZCJsbJxaB3BrpmbRPWVowXtRvg/tMg/wCV137NuAZf6gO7Yz+Q3c9n0Bz5qCwU3C2
X-Received: by 2002:a05:690c:6603:b0:8a9:8021:5cd1 with SMTP id
 00721157ae682-8b1669e6465mr70712677b3.6.1793056944432; Mon, 26 Oct 2026
 16:22:24 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <6ac99eb9.6b935c14.1905ce.7c50SMTPIN_ADDED_MISSING@mx.google.com>
 <CAMw=ZnTTUxO2ZCobEDTQUY7OZxmyJUQxg4DkhC9gTWXaDaK1dQ@mail.gmail.com>
 <20261013110237.GA836401@chenghao-pc> <CAMw=ZnTksVT1wuQwAjzz_2tYSCvLSxeUBa3mYQvCFuKUtcydaA@mail.gmail.com>
 <20261021103633.GA1324331@chenghao-pc>
In-Reply-To: <20261021103633.GA1324331@chenghao-pc>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 26 Oct 2026 23:22:13 +0000
X-Gm-Features: AclHuK-hwbYwy5ob9GAZTuHyNgSeoVljDHkkHHLA6n-8vBOmCS8V_bd2quxR25o
Message-ID: <CAMw=ZnRpDdqKDPbofeF=1U70Q0Ms0aniwA6OPF-paNZEb+k5bQ@mail.gmail.com>
Subject: Re: Question about obtaining LUO session FD for non-systemd-managed service
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: jianghaoran@kylinos.cn, avagin@gmail.com, linux-mm@kvack.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_162226_342162_FBD0034F 
X-CRM114-Status: GOOD (  40.42  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 11:36, Chenghao Duan <duanchenghao@kylinos.cn> wrote=
:
>
> On Mon, Oct 19, 2026 at 01:13:28PM +0100, Luca Boccassi wrote:
> > On Tue, 13 Oct 2026 at 12:02, Chenghao Duan <duanchenghao@kylinos.cn> w=
rote:
> > >
> > > On Sat, Oct 10, 2026 at 03:05:40PM +0200, Luca Boccassi wrote:
> > > > On Sat, 10 Oct 2026 at 04:11, Chenghao Duan <duanchenghao@kylinos.c=
n> wrote:
> > > > >
> > > > > Hi Luca,
> > > > >
> > > > > I watched your excellent presentation from the LPC conference in =
Prague.
> > > > >
> > > > > I have a question I=E2=80=99d like to consult with you.
> > > > >
> > > > > I am currently working on the `memfd_luo` feature in CRIU. My goa=
l is to
> > > > > leverage the LUO capability to store checkpoint images inside mem=
fds.
> > > > > After a kexec reboot, the image data will be retrieved directly f=
rom
> > > > > memory instead of from disk.
> > > > >
> > > > > Here is my pull request on the CRIU GitHub repository:
> > > > > https://github.com/checkpoint-restore/criu/pull/3152
> > > > >
> > > > > In the PR discussion, avagin suggested using systemd as the CRIU =
daemon
> > > > > to centrally manage LUO sessions and access to `/dev/liveupdate`.=
 I have
> > > > > watched your talk and read parts of the systemd source code.
> > > > >
> > > > > From my understanding, systemd currently provides a unit=E2=80=91=
based solution
> > > > > where child processes can inherit LUO session file descriptors. H=
owever,
> > > > > this approach requires the target service to run as a child of a =
systemd
> > > > > unit. As far as I know, CRIU does not run as a systemd=E2=80=91ma=
naged service.
> > > > >
> > > > > So my question is: for services such as CRIU that are **not syste=
md=E2=80=91managed
> > > > > child services**, how can they obtain LUO=E2=80=91session=E2=80=
=91related file descriptors
> > > > > managed by systemd?
> > > > >
> > > > > Thank you very much for reading this email. My knowledge of syste=
md is still
> > > > > limited, so please feel free to correct me if I have misunderstoo=
d anything.
> > > > >
> > > > > Thanks & best regards,
> > > > > Chenghao Duan <duanchenghao@kylinos.cn>
> > > >
> > > > Hi,
> > > >
> > > > At some point up in the stack, everything runs as a systemd unit, s=
o
> > > > it's only a question of figuring out in your setup how to pass the
> > > > FD(s) up and down the stack.
> > >
> > > Hi Luca,
> > >
> > > Thanks for your reply.
> > >
> > > The `LUOSession=3D` configuration only takes effect for services mana=
ged
> > > by the system manager. If I run the CRIU command from an SSH login sh=
ell
> > > as I am doing now, the environment belongs to a transient unit under =
the
> > > user manager. In this case, we cannot use `LUOSession=3D` to obtain t=
he
> > > LUO session fd via systemd. Does this mean the process needs to open
> > > `/dev/liveupdate` by itself to create the session fd?
> > >
> > > Below is the attached service of the process found via `systemctl sta=
tus`.
> > >
> > > [root@localhost criu]# ps -ef |grep criu
> > > root       57589    7729  0 18:25 pts/2    00:00:00 ./criu/criu dump =
-D ../test -t 52922 -j --memfd-images -v4
> > > root       57784    7571  0 18:27 pts/0    00:00:00 grep --color=3Dau=
to criu
> > > [root@localhost criu]# systemctl status 57589
> > > =E2=97=8F session-5.scope - Session 5 of User root
> > >      Loaded: loaded (/run/systemd/transient/session-5.scope; transien=
t)
> > >   Transient: yes
> > >      Active: active (running) since Tue 2026-10-13 10:03:55 CST; 8h a=
go
> > >       Tasks: 4
> > >      Memory: 148.9M (peak: 1.3G)
> > >         CPU: 47.000s
> > >      CGroup: /user.slice/user-0.slice/session-5.scope
> > >              =E2=94=9C=E2=94=80 7712 "sshd: root [priv]"
> > >              =E2=94=9C=E2=94=80 7724 "sshd: root@pts/2"
> > >              =E2=94=9C=E2=94=80 7729 -bash
> > >              =E2=94=94=E2=94=8057589 ./criu/criu dump -D ../test -t 5=
2922 -j --memfd-images -v4
> > >
> > > I'm not sure whether my understanding is correct. Could you please
> > > provide your feedback?
> >
> > That's a user unit, and as per the documentation LUOSession=3D is only
> > supported for system units. So yes you have to provide your program
> > with privileged access to the character device and create the session
> > yourself, and then stash it in the FD Store as normal.
> Hi Luca,
>
> Thanks for your clarification.
> I now have a rough idea for the implementation: CRIU will leverage the
> FD Store facility to deposit the memfd into systemd=E2=80=99s file descri=
ptor
> store. As FD Store is tied to a service unit, a criu.service is
> required. The unit file I intend to use is shown below:
>
> [Service]
> Type=3Doneshot
> RemainAfterExit=3Dyes
> FileDescriptorStoreMax=3D10
> FileDescriptorStorePreserve=3Dyes
> ExecStart=3Dcriu command
>
> Does this setup conform to the original design intent of systemd FD
> Store and LUO? Please feel free to point out any mistakes.

That looks about right. If it's a user unit, also remember to enable
fd store preservation on the user session via a drop-in, ie the
user@.service system unit

