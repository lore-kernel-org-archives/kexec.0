Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745E6CE79CF
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PUBQDtsRGPmF+b3K48cmpEYUyQqC8mU+BPanKWcSpdA=; b=D4s7blFgsNgwIk
	FwlTAKPwvjSGpW9eGwz1UooWAofxGfuJOQ5DLHxr6eCt99ebC0A1YVttCgEvNJz3etPF/Casy5yMW
	kiI2FQUeJY+wAPiGZ6J74qmByvOmSEtVTMZDD7GTha583p0iJIIJ8GgUD8wZm4rdKtM1xwfrN0QK3
	TjhO7BGScOUKs+t1zNp3jGUDJg99QqvJDVjEa/+Zo9irsjNOGGrXJUJwzqQiffFIeF2BZVMqtgpm7
	zkTX+mNbDN0mw1H09GPnm9Z9EeAuR9ukhJ6W6+CnFU30P9Z4E5i+0vNakSyxD3NVnxyH+W8PZkqC8
	sv5uQuJ/l3kdyln+Gr7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiw0G-002yWb-31;
	Wed, 20 Sep 2023 12:08:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiw0E-002yVi-0l
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 12:08:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695211701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9gjTDHVASAKCokWMOtiChMaZbc6RktsbuYFIDgKDVpo=;
	b=UkssILkWloE2Ytoq7rbya3G+IRJAHpZ9mu72n3hFxbQcrveE2UzWYyncdxG8tD9qupGKX/
	GcO3AKwKIUvx0uwlqLt+HjWqWXI8CSsWXHH5yO24lFwzx7ihEVLUJddDpF1j+Xam2KIbpy
	Zn/0IySETQ8zviWSZNUTyk86zODfMhI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-rBOJoS74NvGYDWLiGyjgnA-1; Wed, 20 Sep 2023 08:08:19 -0400
X-MC-Unique: rBOJoS74NvGYDWLiGyjgnA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-34fc0587f6aso2801205ab.1
        for <kexec@lists.infradead.org>; Wed, 20 Sep 2023 05:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695211699; x=1695816499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gjTDHVASAKCokWMOtiChMaZbc6RktsbuYFIDgKDVpo=;
        b=EHjKWUBx41+saDIwlNDVZEDlYQBQVoFElbuLwfCLeQnXZW5DOb2KWsHoPl6IOlcH36
         uMibOJ1XevU4oiPwKPj4exiaOhnLLiP1hZh9zEnYAooyV/rWkTevyUB3JfgSBqXqLrZE
         v7bSgHyVXF/RO7t7Jnn/DM/iJMQSon/4lLQ0VytWQOfnRDQ8ANtDgKCyFmUYijIHj7Z+
         Eh61+sMbY99lVgoWdfTC1X2DZXIybi5FNSW/KNLPdXJ9F5wqtHu1zXbjt8qyS2kQNKJr
         ylE4PvwzM0pBC9s6g6CKLSzHjLfOGYIE5VDq7aKsy2ais/jt/4oMjMJmzKsbQT/Y+Ns7
         ub0w==
X-Gm-Message-State: AOJu0Yytr+WqPgkNoUwbngs4C4haDAsId03eZo8MYpHqJ4lCQERmBr4C
	tPr0x0dJyFAGcSg5u7tvMhcdsWGOmc2ThFCENl5a+adoIkaYMFCJYCUlg6iDnJc6Bn8n/nFQQZm
	qX3QE0hxByraffKuD1W3QmfOzhrQQn15YM1cA
X-Received: by 2002:a92:d58d:0:b0:34c:d535:9f9d with SMTP id a13-20020a92d58d000000b0034cd5359f9dmr2779627iln.1.1695211699038;
        Wed, 20 Sep 2023 05:08:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEndobUX1kqTE6fsmuTy1rK/EW3Xe3ZPyXIJ4TN3BgZiZSImYUMvuETvHMY+D4sdfIqWtrCxyByQJkrBu0Nu0k=
X-Received: by 2002:a92:d58d:0:b0:34c:d535:9f9d with SMTP id
 a13-20020a92d58d000000b0034cd5359f9dmr2779602iln.1.1695211698772; Wed, 20 Sep
 2023 05:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230911052535.335770-1-kernel@jfarr.cc> <20230913160045.40d377f9@rotkaeppchen>
 <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com> <CALu+AoTAUWWtx8yChQMKF9J5X_Qd8+x0hz0jzVwoOvAvh5VmHA@mail.gmail.com>
 <CALu+AoRiok-bzM4OQbiix44O-PUgO2N6Yi+_qTOn4iWtk_u4cg@mail.gmail.com> <CAMj1kXFkQ+T9OjK6NkKjfyR8gW4EZKFw5rEk0rgrzkHyK2BNXQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFkQ+T9OjK6NkKjfyR8gW4EZKFw5rEk0rgrzkHyK2BNXQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 20 Sep 2023 20:07:58 +0800
Message-ID: <CALu+AoTwqL3y=NhojN2Sb=Ms33id9Nco9QU8JccFrJ_nza5jAQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de, 
	dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org, 
	akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>, bhelgaas@google.com, 
	Luca Boccassi <bluca@debian.org>, lennart@poettering.net, 
	"Liu, Pingfan" <piliu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_050822_356433_82CB3AC9 
X-CRM114-Status: GOOD (  38.75  )
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

On Wed, 20 Sept 2023 at 18:50, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 20 Sept 2023 at 08:40, Dave Young <dyoung@redhat.com> wrote:
> >
> > On Wed, 20 Sept 2023 at 15:43, Dave Young <dyoung@redhat.com> wrote:
> > >
> > > > > In the end the only benefit this series brings is to extend the
> > > > > signature checking on the whole UKI except of just the kernel image.
> > > > > Everything else can also be done in user space. Compared to the
> > > > > problems described above this is a very small gain for me.
> > > >
> > > > Correct. That is the benefit of pulling the UKI apart in the
> > > > kernel. However having to sign the kernel inside the UKI defeats
> > > > the whole point.
> > >
> > >
> > > Pingfan added the zboot load support in kexec-tools, I know that he is
> > > trying to sign the zboot image and the inside kernel twice. So
> > > probably there are some common areas which can be discussed.
> > > Added Ard and Pingfan in cc.
> > > http://lists.infradead.org/pipermail/kexec/2023-August/027674.html
> > >
> >
> > Here is another thread of the initial try in kernel with a few more
> > options eg. some fake efi service helpers.
> > https://lore.kernel.org/linux-arm-kernel/ZBvKSis+dfnqa+Vz@piliu.users.ipa.redhat.com/T/#m42abb0ad3c10126b8b3bfae8a596deb707d6f76e
> >
>

Ard, thanks for the comments.

> Currently, UKI's external interface is defined in terms of EFI
> services, i.e., it is an executable PE/COFF binary that encapsulates
> all the logic that performs the unpacking of the individual sections,
> and loads the kernel as a PE/COFF binary as well (i.e., via
> LoadImage/StartImage)
>
> As soon as we add support to Linux to unpack a UKI and boot the
> encapsulated kernel using a boot protocol other than EFI, we are
> painting ourselves into a corner, severely limiting the freedom of the
> UKI effort to make changes to the interfaces that were implementation
> details up to this point.

Agreed, it seems UKI is more flexible and complex than the zboot,
we do need to carefully think about a better solution.

>
> It also means that UKI handling in kexec will need to be taught about
> every individual architecture again, which is something we are trying
> to avoid with EFI support in general. Breaking the abstraction like
> this lets the cat out of the bag, and will add yet another variation
> of kexec that we will need to support and maintain forever.
>
> So the only way to do this properly and portably is to implement the
> minimal set of EFI boot services [0] that Linux actually needs to run
> its EFI stub (which is mostly identical to the set that UKI relies on
> afaict), and expose them to the kexec image as it is being loaded.
> This is not as bad as it sounds - I have some Rust code that could be
> used as an inspiration [1] and which could be reused and shared
> between architectures.

Great!

>
> This would also reduce/remove the need for a purgatory: loading a EFI
> binary in this way would run it up to the point were it calls
> ExitBootServices(), and the actual kexec would invoke the image as if
> it was returning from ExitBootServices().
>
> The only fundamental problem here is the need to allocate large chunks
> of physical memory, which would need some kind of CMA support, I
> imagine?

Hmm, I thought that your idea is to write the efi stub code in "purgatory"
so kexec can jump to it while rebooting then it will be able to access the
whole usable memory, but it seems you want an efi app run under linux
and somehow provide services to kexec?  My EFI knowledge is incomplete
and outdated,  If my understanding of your proposal is true how can it keep
running after switching to the new kernel stub?

>
> Maybe we should do a BoF at LPC to discuss this further?

It does deserve more discussion, unfortunately I will not be able to join LPC,
Philipp Rudo (cced) planned attend the conf, so I think you guys can
discuss together with
other people interested. I think I will watch the recordings or
joining virtually if possible.

>
> [0] this is not as bad as it sounds: beyond a protocol database, a
> heap allocator and a memory map, there is actually very little needed
> to boot Linux via the EFI stub (although UKI needs
> LoadImage/StartImage as well)
>
> [1] https://github.com/ardbiesheuvel/efilite
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
