Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A9BCE79C3
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 10:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+UR/NMGo5+IceERvDWoJJvJXOMTWSVudNX+Opr8wYaU=; b=GyqsHh7AX5/bOK
	VBp2sfZzstoFiiftokXmDGDuP7fMRlRNMYFQOVz1pZ07NIbZySWiRPwq9k37iiKk3nAiM1yWQsPDy
	UdUBvcuR1353z3ZtbsQVJJ4Y+nlcOQVLivJ3Wsf4FyPTUBp0zbNNERMtGtFGhpLjNxY3FAGKUWPaL
	fLe9gL1Z7qZsSkx88bsPHznr0vWuIEuWj4vYjid62X+AlU40Ju+6GBsRxczUXrNL/5Dwjxp51CWyE
	/FZ/Yde6/jRBC8BOYkyBHLc5Pqan2ftLEVeWvf/PsjITl8TyihEPP1Hlj6Vlf4so/UaVecHHeNmQC
	8QsLatAYzjwsxiGbzYcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiunD-002fkN-0N;
	Wed, 20 Sep 2023 10:50:51 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiun9-002fjL-16
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 10:50:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D4572B81C97
	for <kexec@lists.infradead.org>; Wed, 20 Sep 2023 10:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8228EC433C8
	for <kexec@lists.infradead.org>; Wed, 20 Sep 2023 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695207044;
	bh=bIXhOQis1Sn3vDslhC5JOJ46taY/IsHYFumVE4W8Y80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VXqJG4lV3wtMjenjbKnz4AsLWvuuyyOBcDoFkIXAx3ndSX+O49DrlYN1AqVyqX4PU
	 QXSS5Bg8hKoR/QVFgvpH0fjCclcmCfzRCxUrD9TSgcCC79ofxZdWT8qPRmN9jXAdXM
	 lgdug6jqMidDA+9D+lycVhB/tiadWlYrg41eb6q8Pm5DEqS+fnIFUundXOL+JEAEY5
	 5nMdbQszsrad83IuEmIReGPc2N9dhNAfboNZlzbrHI90mSQnAZEyMi2LLAdGT5QoXK
	 CCjGrUcxHYC14nbFOePBYzOMi47JSYtSEasazxqIbtVgtZ7YOALF03bd4JNal/qJwS
	 gdzCflxF3WNKw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2bffa8578feso61283231fa.2
        for <kexec@lists.infradead.org>; Wed, 20 Sep 2023 03:50:44 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx/UVx37w1Kw2yt17CS6mggK6uUKcd2KXE8ggbLhWMhyHX6F0/S
	91rRAkULtwz122lMvyiNXMogQdX85idb9Yp9v6k=
X-Google-Smtp-Source: AGHT+IHfM05co9ZEeBSxDjJRZrcRdy68odWxBS48uGxXpH1ue24f8M12y+gEOGX0fSu6rxr+dxPeMYdxQNv8JVZ2Hhc=
X-Received: by 2002:a2e:86d6:0:b0:2bc:cc1a:139c with SMTP id
 n22-20020a2e86d6000000b002bccc1a139cmr1796132ljj.11.1695207042721; Wed, 20
 Sep 2023 03:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230911052535.335770-1-kernel@jfarr.cc> <20230913160045.40d377f9@rotkaeppchen>
 <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com> <CALu+AoTAUWWtx8yChQMKF9J5X_Qd8+x0hz0jzVwoOvAvh5VmHA@mail.gmail.com>
 <CALu+AoRiok-bzM4OQbiix44O-PUgO2N6Yi+_qTOn4iWtk_u4cg@mail.gmail.com>
In-Reply-To: <CALu+AoRiok-bzM4OQbiix44O-PUgO2N6Yi+_qTOn4iWtk_u4cg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 20 Sep 2023 10:50:31 +0000
X-Gmail-Original-Message-ID: <CAMj1kXFkQ+T9OjK6NkKjfyR8gW4EZKFw5rEk0rgrzkHyK2BNXQ@mail.gmail.com>
Message-ID: <CAMj1kXFkQ+T9OjK6NkKjfyR8gW4EZKFw5rEk0rgrzkHyK2BNXQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
To: Dave Young <dyoung@redhat.com>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de, 
	dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org, 
	akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>, bhelgaas@google.com, 
	Luca Boccassi <bluca@debian.org>, lennart@poettering.net, 
	"Liu, Pingfan" <piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_035047_650389_5BD0D173 
X-CRM114-Status: GOOD (  27.94  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, 20 Sept 2023 at 08:40, Dave Young <dyoung@redhat.com> wrote:
>
> On Wed, 20 Sept 2023 at 15:43, Dave Young <dyoung@redhat.com> wrote:
> >
> > > > In the end the only benefit this series brings is to extend the
> > > > signature checking on the whole UKI except of just the kernel image.
> > > > Everything else can also be done in user space. Compared to the
> > > > problems described above this is a very small gain for me.
> > >
> > > Correct. That is the benefit of pulling the UKI apart in the
> > > kernel. However having to sign the kernel inside the UKI defeats
> > > the whole point.
> >
> >
> > Pingfan added the zboot load support in kexec-tools, I know that he is
> > trying to sign the zboot image and the inside kernel twice. So
> > probably there are some common areas which can be discussed.
> > Added Ard and Pingfan in cc.
> > http://lists.infradead.org/pipermail/kexec/2023-August/027674.html
> >
>
> Here is another thread of the initial try in kernel with a few more
> options eg. some fake efi service helpers.
> https://lore.kernel.org/linux-arm-kernel/ZBvKSis+dfnqa+Vz@piliu.users.ipa.redhat.com/T/#m42abb0ad3c10126b8b3bfae8a596deb707d6f76e
>

Currently, UKI's external interface is defined in terms of EFI
services, i.e., it is an executable PE/COFF binary that encapsulates
all the logic that performs the unpacking of the individual sections,
and loads the kernel as a PE/COFF binary as well (i.e., via
LoadImage/StartImage)

As soon as we add support to Linux to unpack a UKI and boot the
encapsulated kernel using a boot protocol other than EFI, we are
painting ourselves into a corner, severely limiting the freedom of the
UKI effort to make changes to the interfaces that were implementation
details up to this point.

It also means that UKI handling in kexec will need to be taught about
every individual architecture again, which is something we are trying
to avoid with EFI support in general. Breaking the abstraction like
this lets the cat out of the bag, and will add yet another variation
of kexec that we will need to support and maintain forever.

So the only way to do this properly and portably is to implement the
minimal set of EFI boot services [0] that Linux actually needs to run
its EFI stub (which is mostly identical to the set that UKI relies on
afaict), and expose them to the kexec image as it is being loaded.
This is not as bad as it sounds - I have some Rust code that could be
used as an inspiration [1] and which could be reused and shared
between architectures.

This would also reduce/remove the need for a purgatory: loading a EFI
binary in this way would run it up to the point were it calls
ExitBootServices(), and the actual kexec would invoke the image as if
it was returning from ExitBootServices().

The only fundamental problem here is the need to allocate large chunks
of physical memory, which would need some kind of CMA support, I
imagine?

Maybe we should do a BoF at LPC to discuss this further?

[0] this is not as bad as it sounds: beyond a protocol database, a
heap allocator and a memory map, there is actually very little needed
to boot Linux via the EFI stub (although UKI needs
LoadImage/StartImage as well)

[1] https://github.com/ardbiesheuvel/efilite

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
