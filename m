Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7D2CCD187
	for <kexec@archiver.kernel.org>; Tue, 14 Oct 2025 05:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ptPHbzU60TAIm8mnnxk2ahAv+Cxa99UUvkWsQlBP2xU=; b=RsljjIzNYosRNolv0qICNo7gSt
	nuTK3FZfdgHBmlj7LFsnOew8vgdAYdWM6WPUeUbev2myvebTbRSmQyl3jSNpgavBIyXPLADQWLB3R
	ktX+X99y3QtDd2NOCis5xEDCa42wKWD+y7f7sAxP4oEVMeqgn4+WnA7KvstVGK8CpU1YdHjoc64+E
	j/9RbSNkDrS259rgWQ4phYQ9wB6VfyMGqzjyGVX1Kv7JACQpy73+My3ZAJPvkovBlcweNulcpYp+n
	CpQSVkAFgYOnv+s67hzr3oD35r68OowFulfJUx1FSjN26RtjhkPxyn2AnoG6Hyeo7wU4/vXsf9Tvs
	w94nDEzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8XaB-0000000FD5k-3f6S;
	Tue, 14 Oct 2025 05:28:23 +0000
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Xa7-0000000FD4S-24SD
	for kexec@lists.infradead.org;
	Tue, 14 Oct 2025 05:28:20 +0000
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-36a6a39752bso46670481fa.0
        for <kexec@lists.infradead.org>; Mon, 13 Oct 2025 22:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760419697; x=1761024497; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptPHbzU60TAIm8mnnxk2ahAv+Cxa99UUvkWsQlBP2xU=;
        b=jlUiLvTVtnFW1J8PM+WyWrXlKUKxft8kJ2ZuTetm8M4PXaHSL5nwGO66wbGX2OOmVv
         wWWsBySy2ePn+9cw40zKRd8Igfa1jpzaX9bwrhx5tWJiL8sB6Yw5AzMrd1m9TTmmVGRB
         2B6AEXbBEACuEP2gM4FQ89GMvfTByWdr2Yac9Aw5GtQjDzC5mGzkPOyVBZUCvRYWj2hI
         Mpr2XxNlHiop6bYhv8P+TrE3/iO7HaFtHd227+L/YPe2PsypIa/UM4sE83I1TixrAOpg
         b88c7lctTvT1N4yPnxpJd9fbYI+4yheq+GzwCKb+3ASVhR4+A3KMpsh1pKfAKTcLkxnC
         k4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760419697; x=1761024497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptPHbzU60TAIm8mnnxk2ahAv+Cxa99UUvkWsQlBP2xU=;
        b=pEqtsYm+A/FaI0v4G31IdV9NDpDloKJm2BMfMmwatl8+2f3QfPW5OADXzhFk/skWo+
         tzIlfNPpiw4ce2uLtsq1pWyp3DHkMY/Vd7uszngolNSfktDsC4NPMSMBsWJ4qgvQkrZw
         /pm7+meDB6eXGkow0V4gW1z2TZX62GqbXEoEA4etc1lZF9PViQb3ZqSfB+K8wpdfR255
         A9l9XJA0SIoQBd+Fbb+y5l6Ydb0D7By2IYmYuwy6rxM5N9tO8vxuNiqHAWXy1RJ4LIAt
         wdZMo9PXz7bl2eK/cNbYlL3sw2HQXfIhka5uY1VP836vCtnYFjqHkgYsR0diu+0jD8NH
         MAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGSJRoN82B73aXLyT5bfy7nDPDmHvSwiXqDiC4fPWWmgMyRUPZW4iL56EGQA9WvXUOhjgukw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4Nx9Xz/vF3pWtqG+XzNRhw4gyg7PcUJiHhvsONt1RHrhhCmGP
	u0udUzhk3rNx/X5klCu611uORT0wdK2148m+0g8GMXY1+RDSP8FCi0N8ngStgdTuX16PFZYhTfL
	ipVmSYDsKlkJvjRVlbYyoEyKLmFSleow=
X-Gm-Gg: ASbGncvITyA93lQeoOOuerD2uSURF5cn5OKEmIxFf/bV3oICmtKpgkfsoK6CBRSTYiV
	PZYt+KfoEzgqOP5uMygW6HJ0qyUvfbiXb9OMB3yg6WirEHeC2lt13iYxWk3gpMuMfCUwZzB+/is
	sz12ki6EARVptiHS8M962Y8rhLPaK19TsT2Xu/Ze/w9aqDICJN4VmlvXRZSRGIhDrZ5hoW0fAuk
	HzGhngW/M0hHnfHn13CDGhO/A==
X-Google-Smtp-Source: AGHT+IGdjfNUCN4gunItNKInWlyxyXS9VWDbMBSmmBL39oiGRrNBNxoCrVW6HmO4TTj1J7zFqIEW6QQm2vhVXKpWfzQ=
X-Received: by 2002:a2e:bcc7:0:b0:372:950f:2aff with SMTP id
 38308e7fff4ca-37609e0ed4emr64933311fa.27.1760419696692; Mon, 13 Oct 2025
 22:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv> <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com> <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
 <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv> <CA+fCnZcWEuBerMeS4RCXQtged06MJhY=55KsYeJEOJn3K0psXQ@mail.gmail.com>
 <aNNY1AzfGua3Kk3S@MiWiFi-R3L-srv> <CACzwLxh10=H5LE0p86xKqfvObqq+6ZN5Cs0hJ9i1MKJHWnNx2w@mail.gmail.com>
 <aNTfPjS2buXMI46D@MiWiFi-R3L-srv>
In-Reply-To: <aNTfPjS2buXMI46D@MiWiFi-R3L-srv>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Tue, 14 Oct 2025 10:27:59 +0500
X-Gm-Features: AS18NWDpoAnK8X4S74wzUC_xmUwiiptVaXx4Fi_Po4Ht89THf-aVMKFaVW0-Q-g
Message-ID: <CACzwLxiJ0pGur42Vigq=JnYecyZn-Z5BC3VcqxSUttT54kEusA@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, glider@google.com, 
	dvyukov@google.com, elver@google.com, linux-mm@kvack.org, 
	vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_222819_547092_2CDB7E80 
X-CRM114-Status: GOOD (  21.77  )
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

On Thu, Sep 25, 2025 at 11:21=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 09/25/25 at 12:07am, Sabyrzhan Tasbolatov wrote:
> > On Wed, Sep 24, 2025 at 5:35=E2=80=AFAM Baoquan He <bhe@redhat.com> wro=
te:
> > >
> > > On 09/23/25 at 07:49pm, Andrey Konovalov wrote:
> > > > Since the Sabyrzhan's patches are already in mm-stable (and I assum=
e
> > > > will be merged during the next merge window), just rebase your chan=
ges
> > > > on top.
> > >
> > > That's fine, I will rebase.
> > >
> > > >
> > > > But also note that Sabyrzhan is planning to move out the
> > > > kasan_enabled() checks into include/linux/kasan.h (which is a clean=
-up
> > > > I would have also asked you to do with the kasan=3Doff patches), so
> > > > maybe you should sync up with him wrt these changes.
> > >
> > > Hi Sabyrzhan,
> > >
> > > What's your thought? You want to do the cleanup after my rebasing on
> > > your merged patches or you prefer to do it ahead of time? Please let =
me
> > > know so that I can adjust my posting accordingly. Thanks.
> > >
> >
> > Hello,
> >
> > I can make all necessary changes only next week. Currently, traveling.
> > I will send the fix-up patch Andrey has described somewhere next week.
> > Please let me know if it's ok.
>
> Please take it easy, today is Thursday, I will wait for your clean up
> patch next week and post. I can do some preparation work for rebasing on
> your merged patches. Thanks.

Hello,

Just heads up that I've already sent cleanup patches [1] and
Andrew has merged them into mm-new tree.
Hopefully, one week's delay wasn't a problem.

[1] https://lore.kernel.org/all/20251009155403.1379150-1-snovitoll@gmail.co=
m/

