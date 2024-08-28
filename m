Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A41C636EE
	for <kexec@archiver.kernel.org>; Wed, 28 Aug 2024 17:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sTqJOTlgYAEw2IiZtUDrROZ9q4pq1E8SJ2M39g61i1I=; b=IDkMujLl3uuc21
	BL6ooz+2UKCoy4zetx+Q7kHkHLj3FjxnPAlucSzuqZxzCkwnZ5QDPFTeVOEwQ3nb5nv9+tukXQmS4
	tOkVDdm8HTKz1kPQsRcZRuDpwS/KpJdNscSfQ2ckOnU+VOC2Ixp20UonrPWK4ZCau44j1Cqac5XBa
	ckldEThUAfOpYa3t2/lefQURy0JZefmxBJiT8hL5OkiESYI/JibMnBGvxAs0e9FRmNn5qOhJQ3YsC
	9gkvg3Y73OnojwsTgWrNJiA2PIyTIJus6YX9mvKb7P66ppccMBFUuo5dFTt2t5CirL74QGN/Suru1
	MoJmDDVgYneKNsYya8mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjMjW-0000000GQ8H-3KcS;
	Wed, 28 Aug 2024 17:45:26 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjMjT-0000000GQ6v-3kGS
	for kexec@lists.infradead.org;
	Wed, 28 Aug 2024 17:45:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0A915A428DC
	for <kexec@lists.infradead.org>; Wed, 28 Aug 2024 17:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF811C4CED2
	for <kexec@lists.infradead.org>; Wed, 28 Aug 2024 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724867122;
	bh=G9QT0vPfao0O0lwDuOgePtuOTxFGY2xhec23X8b5r3c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SHmG7I1AqNhnQBidq2BCot4ejAL+TzMllfS2rv3qkf+lElNlaaHqHWHiOCKivyXyC
	 TzFTphymTh9XH159FympnbYfJx62unid9Qv9eAbiS/n+DjC9fCEcTF3or7HiGqneOd
	 6YWcbHm6IsHp16uteCBB2Em71ZKYMH37JfojTKFFli0XQwq7jXhO3keSssf7lt2p2a
	 nexLta3iWnFo1/tclYsogHocm8wp7TDayc3ekXmACvwi3BbPRA0wuOaOgYHSRV4zhd
	 jL+KVompujrPQ/3PvhWFYoabKrE8t8s9GjPBUrQzB1AfsrlUJ3xaZG92KXGXBJHj87
	 kGVLVVpOJTGLQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-533463f6b16so8268355e87.1
        for <kexec@lists.infradead.org>; Wed, 28 Aug 2024 10:45:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXM9lLQtW5e5jZWIc6NG8LegoHeAlPCNZUeKXUB2YUL/dCMeUScqhcF4icEznHqRPgCfbaKFA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwbrLc/i09z9xhams4cV4PS0ME15ltBREhmFEwMPMyUw+EHrpCb
	Wp7WEzLoJEPoudlxaHPJOfWXl/vXDZojVmEL/90Bzq9cTgd3GZZaBDZHwXLMgGJPxu6PMOfkKCB
	FUn4eJS45xmItOCQw+1B4CNltWCc=
X-Google-Smtp-Source: AGHT+IGaVTdJ/LHztg5boQQvEQD2uV+Xdg8ZsjilzNuNZwL1c7aotEe1qcRRan6SrgWsXGUOuRs+QonsXS8FUfmscYw=
X-Received: by 2002:a05:6512:b98:b0:530:bbe7:4db3 with SMTP id
 2adb3069b0e04-5353e5b81e8mr28078e87.39.1724867120119; Wed, 28 Aug 2024
 10:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-2-ross.philipson@oracle.com> <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com>
 <9d01a6d2-4dd9-4331-8fc9-b01c07cfdbb5@apertussolutions.com>
In-Reply-To: <9d01a6d2-4dd9-4331-8fc9-b01c07cfdbb5@apertussolutions.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 28 Aug 2024 19:45:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHn6xeAskWiDLvvA4oG3j9_tqx+iMYJXMqmgvyX4pMzgg@mail.gmail.com>
Message-ID: <CAMj1kXHn6xeAskWiDLvvA4oG3j9_tqx+iMYJXMqmgvyX4pMzgg@mail.gmail.com>
Subject: Re: [PATCH v8 01/15] x86/boot: Place kernel_info at a fixed offset
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, Stuart Yoder <stuart.yoder@arm.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_104524_078980_BF7A62A2 
X-CRM114-Status: GOOD (  17.62  )
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

(cc Stuart)

On Thu, 21 Mar 2024 at 15:46, Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
>
> Hi Ard!
>
> On 2/15/24 02:56, Ard Biesheuvel wrote:
> > On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
> >>
> >> From: Arvind Sankar <nivedita@alum.mit.edu>
> >>
> >> There are use cases for storing the offset of a symbol in kernel_info.
> >> For example, the trenchboot series [0] needs to store the offset of the
> >> Measured Launch Environment header in kernel_info.
> >>
> >
> > Why? Is this information consumed by the bootloader?
>
> Yes, the bootloader needs a standardized means to find the offset of the
> MLE header, which communicates a set of meta-data needed by the DCE in
> order to set up for and start the loaded kernel. Arm will also need to
> provide a similar metadata structure and alternative entry point (or a
> complete rewrite of the existing entry point), as the current Arm entry
> point is in direct conflict with Arm DRTM specification.
>

Digging up an old thread here: could you elaborate on this? What do
you mean by 'Arm entry point' and how does it conflict directly with
the Arm DRTM specification? The Linux/arm64 port predates that spec by
about 10 years, so I would expect the latter to take the former into
account. If that failed to happen, we should fix the spec while we
still can.

Thanks,
Ard.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
