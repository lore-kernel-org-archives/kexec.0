Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A3ECCF2D6
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IaMHOaCF9qKahgBmNzjExLM3+cMiS8xPZoJLsbFvUPM=; b=byTOEx6VekS7xrjBtQOyhDSPUR
	2m/llKXFxKnYX3J6az1r/yx3IHByeiZjmu2gkH7DFJD/aTG831iOd00bUH6OtYPEEQlRhauekAoFh
	VQte87M40p/6hoabsmMMzWSElq7IQi06J7ZbFNCui0yvzqmXXTzYAnS1DK1EZei1TvcC2TAqdXAJD
	TKGu86XkjUq+HP/Wilak5buK52tvGmYPLdg2ACZaggSgzniZrScu+S3Fy9q67qGR7/89CUdCPa31k
	+xCynzfZoeUG1coxU+leDzMr7S+ME/dbPkau31cCx5H0HJUCBF/VO/WXwnQQXv++dzAR7jTDGLQzD
	qaDaBRwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xImFN-00000007M9g-3baL;
	Mon, 19 Oct 2026 12:13:45 +0000
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xImFL-00000007M8Y-0a1j
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 12:13:44 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-8b0a28a720aso14621687b3.2
        for <kexec@lists.infradead.org>; Mon, 19 Oct 2026 05:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792412020; cv=none;
        d=google.com; s=arc-20260327;
        b=NRj0HLr1jAX3vQJ3ucvO9/Gx6hkyMrzN8MWEiZdXrY6mevS/JYfr65kZyJt9dzbgpB
         PKCPWLxsVrD9bLXVafHU/4kF486Xu1EmhZqZWwcPbd57hxKf/S8cyw5STNfFJG+TjHwf
         wklHRgwYOi010crmRAw6FqjG6IOfQTZPqtmMK3qUxxtZlRLyQLsw2hDb2JagIXLgjxGO
         b3npZBy/0zoSfFNatJDU4ahJ/cfqzUIsK+mKeycqs9fXANGfvw78KMDoFt+B02eCBsno
         cCnHGMebzDXRwy+cKTE8ESkRbTqDzcyBOI27gk9KQdg0xOFb+kKzUdfIQi1q9vMkevnx
         H5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IaMHOaCF9qKahgBmNzjExLM3+cMiS8xPZoJLsbFvUPM=;
        fh=eCEdaeUO3AV5TQDmi5YVLEH1otroKljyjDaEelVJhyE=;
        b=GUCIPOqKrOe++sLAey0xgNHFJHY29RmPbq8x/SjhPm8G6UmEkWfe5pkoBlpEU4ReAH
         zg1WwWx1mkDH+CD75Rgp+HWl74hwh+5OD5TI4ebRaCIJATjmlRXSvqGiA6hEbTubOSto
         KFL0QzK9YsdJml0ymwJXXx2NVyoAFyu8usr2yEYY/YGvj3H/+bdLi9cjDlxmTXxDzpyd
         4z5ij0koQMS5meQN/F6rB2Nb9f5uOhPX6VrBqqQHZ+QFGtedQ7vVfsdZ7kgyqEUBooie
         6sAsOJU2/6YHmf/ltbw5bo6Fs1eYlbxRa2jQSrBy7UiG2hYCyDMCXlnchviOTeNwvymr
         aOkA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792412020; x=1793016820; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IaMHOaCF9qKahgBmNzjExLM3+cMiS8xPZoJLsbFvUPM=;
        b=nH7Ts2gLyscNCrxT1L9G5lRDOTbOQxvHItrez1V4+3kDhBNr7AaG45i6cET5G6TWJI
         70CtKf697Sg6Wlu6Pdc4rho/rBPr5OKHBbcPNAgOMVbJCWVB1p5IYjjf91Xce+EkrJBc
         U5y7nJ4iXSjTRqs8iB4Qaz3b0kP+I7ibbF54mxgUL9IFS4g+HNf2qIYfaHcWBUjjLjG6
         8N+WDamU7QBL+5g0t26UMkZ+4SM/i/cPLW67iL5JvhnrgG13Ca0bo+erkkYuwShWWr/k
         Y1l+XMZX/Hi70+QUjJ4G35oG2ZKqFTtfrlCYmCdeN4bLAEMiXjQjbOhU08p8FPb2UHZr
         NpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792412020; x=1793016820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IaMHOaCF9qKahgBmNzjExLM3+cMiS8xPZoJLsbFvUPM=;
        b=R5emKwnUjDRqIzVPfNJqtjHFxOZ84bylWz89GHMYypiCO9OWsCcIukaJqnAU3BEeRA
         q2I5cT9K9t26pzJnDDl98EAI9zUoN/ZvmC+3Q2qnX2bHc4s6lpDAKC8YMDvJfRGBkEPF
         YNLJKjVQ7IXhYySVXztNGBBFhBqr+xlik8I9bdu6+WPra67HAv8dkYo0ZBY1C6R3SCNg
         0T9ArvN8hUM5vDyT90yiHUJ/Ey70X7Z6PU0vxwCOaNO8ByqHV0E+5svoNq031FM4wTkH
         DLEcYgLImxqNy1C/YprdbaDb9GpNjXfj/MIouxRZQSLtPcTIIDc1kGmDmAn4nDWEvbTQ
         5wAw==
X-Forwarded-Encrypted: i=1; AKwUvBycL9DERbn2Rr9XJUnZoJCsp1YmYjKJEpg+2Pbs7hEJaOLBUPVCoAd2Ms1Sqn/3V5x+r+Epsw==@lists.infradead.org
X-Gm-Message-State: AFq9FYKL592Ei4JpZXhpq8t3ZL72TZd9wkoLuYPQAP5GFJ6H0a0k1ily
	S0QfqAQG1O5cDXHVaP9nLJ+8/zN64ck3WYowrkxrSAC/mz+dH450KALyjPV54tU/g1rVzQaupdN
	f/3wVHh/JhcHjAfGN7lgoQMhRDT5G9z4=
X-Gm-Gg: AYBFou3SlQ/mfsgbdCShjGOF0grb+nXe90Or+g+r5Ej8GVrbHOP+hUYwUuG+qZ5jhrM
	6VNVtgU0biC+62wC9mlzj4U+z/phTlQHuxlib9p1oLisWhNIhgS1YIjvex97zlZ5AH8AzQHbO7w
	48fq17czMbypeacH/LuSFvJ9gVHKQPxP/bkmgeJUV25pASw1LaIei5E7AwkLjHXaUpZ42TvXmQO
	lYic7Wh3013Dl4qTWt2akrEexCOm99FqkWErSEyBI+FXT6IOdQ3uX7FKjAazyijR9eKKWntbzRc
	49C+t1P9/+dW+pdXWzBHXquIq3jcigAKPUuV06GyZlpbnKvm9Pt5yycNB3xERKXDf3KuwYwZJWE
	ucnQMF+4pUC0M0Q==
X-Received: by 2002:a05:690c:4802:b0:8b0:a857:654f with SMTP id
 00721157ae682-8b0f222e1f1mr24697237b3.63.1792412019904; Mon, 19 Oct 2026
 05:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <6ac99eb9.6b935c14.1905ce.7c50SMTPIN_ADDED_MISSING@mx.google.com>
 <CAMw=ZnTTUxO2ZCobEDTQUY7OZxmyJUQxg4DkhC9gTWXaDaK1dQ@mail.gmail.com> <20261013110237.GA836401@chenghao-pc>
In-Reply-To: <20261013110237.GA836401@chenghao-pc>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 19 Oct 2026 13:13:28 +0100
X-Gm-Features: AclHuK_bmEUQOsQIU6VRKds3I_yd9xZsuOO4tGVmB2Rnh13ICGRCJP9TMe8I_xk
Message-ID: <CAMw=ZnTksVT1wuQwAjzz_2tYSCvLSxeUBa3mYQvCFuKUtcydaA@mail.gmail.com>
Subject: Re: Question about obtaining LUO session FD for non-systemd-managed service
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: jianghaoran@kylinos.cn, avagin@gmail.com, linux-mm@kvack.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_051343_199939_7EFD78D1 
X-CRM114-Status: GOOD (  34.05  )
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

On Tue, 13 Oct 2026 at 12:02, Chenghao Duan <duanchenghao@kylinos.cn> wrote=
:
>
> On Sat, Oct 10, 2026 at 03:05:40PM +0200, Luca Boccassi wrote:
> > On Sat, 10 Oct 2026 at 04:11, Chenghao Duan <duanchenghao@kylinos.cn> w=
rote:
> > >
> > > Hi Luca,
> > >
> > > I watched your excellent presentation from the LPC conference in Prag=
ue.
> > >
> > > I have a question I=E2=80=99d like to consult with you.
> > >
> > > I am currently working on the `memfd_luo` feature in CRIU. My goal is=
 to
> > > leverage the LUO capability to store checkpoint images inside memfds.
> > > After a kexec reboot, the image data will be retrieved directly from
> > > memory instead of from disk.
> > >
> > > Here is my pull request on the CRIU GitHub repository:
> > > https://github.com/checkpoint-restore/criu/pull/3152
> > >
> > > In the PR discussion, avagin suggested using systemd as the CRIU daem=
on
> > > to centrally manage LUO sessions and access to `/dev/liveupdate`. I h=
ave
> > > watched your talk and read parts of the systemd source code.
> > >
> > > From my understanding, systemd currently provides a unit=E2=80=91base=
d solution
> > > where child processes can inherit LUO session file descriptors. Howev=
er,
> > > this approach requires the target service to run as a child of a syst=
emd
> > > unit. As far as I know, CRIU does not run as a systemd=E2=80=91manage=
d service.
> > >
> > > So my question is: for services such as CRIU that are **not systemd=
=E2=80=91managed
> > > child services**, how can they obtain LUO=E2=80=91session=E2=80=91rel=
ated file descriptors
> > > managed by systemd?
> > >
> > > Thank you very much for reading this email. My knowledge of systemd i=
s still
> > > limited, so please feel free to correct me if I have misunderstood an=
ything.
> > >
> > > Thanks & best regards,
> > > Chenghao Duan <duanchenghao@kylinos.cn>
> >
> > Hi,
> >
> > At some point up in the stack, everything runs as a systemd unit, so
> > it's only a question of figuring out in your setup how to pass the
> > FD(s) up and down the stack.
>
> Hi Luca,
>
> Thanks for your reply.
>
> The `LUOSession=3D` configuration only takes effect for services managed
> by the system manager. If I run the CRIU command from an SSH login shell
> as I am doing now, the environment belongs to a transient unit under the
> user manager. In this case, we cannot use `LUOSession=3D` to obtain the
> LUO session fd via systemd. Does this mean the process needs to open
> `/dev/liveupdate` by itself to create the session fd?
>
> Below is the attached service of the process found via `systemctl status`=
.
>
> [root@localhost criu]# ps -ef |grep criu
> root       57589    7729  0 18:25 pts/2    00:00:00 ./criu/criu dump -D .=
./test -t 52922 -j --memfd-images -v4
> root       57784    7571  0 18:27 pts/0    00:00:00 grep --color=3Dauto c=
riu
> [root@localhost criu]# systemctl status 57589
> =E2=97=8F session-5.scope - Session 5 of User root
>      Loaded: loaded (/run/systemd/transient/session-5.scope; transient)
>   Transient: yes
>      Active: active (running) since Tue 2026-10-13 10:03:55 CST; 8h ago
>       Tasks: 4
>      Memory: 148.9M (peak: 1.3G)
>         CPU: 47.000s
>      CGroup: /user.slice/user-0.slice/session-5.scope
>              =E2=94=9C=E2=94=80 7712 "sshd: root [priv]"
>              =E2=94=9C=E2=94=80 7724 "sshd: root@pts/2"
>              =E2=94=9C=E2=94=80 7729 -bash
>              =E2=94=94=E2=94=8057589 ./criu/criu dump -D ../test -t 52922=
 -j --memfd-images -v4
>
> I'm not sure whether my understanding is correct. Could you please
> provide your feedback?

That's a user unit, and as per the documentation LUOSession=3D is only
supported for system units. So yes you have to provide your program
with privileged access to the character device and create the session
yourself, and then stash it in the FD Store as normal.

