Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85391CCFA18
	for <kexec@archiver.kernel.org>; Sun,  9 Nov 2025 01:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WTA68YLUrvv1QwWT0WiwLCQWXoEE69/jtOIrBRItPTE=; b=A/yDG/wbnMGTMH0uutsiG6p9Nh
	weH6Uk66wNg4g1bNkSZusiSrJpoAkSNP6HFlkly2ng4T+JLYDMkjo9VH9HanXn+JMP+lOzX3VlHGW
	8jAnjP5NT9IGq7d/EQxYt+4ABe3puy824pThc0c298Y8kP4R4KE7KUrU5/tGLyLQu0V5I9n4MXNgM
	wccrK24xzH/21xMCcI9uOeeXKHN+SWTFvCA65tE9C/bJRZtkvkVnfUylGzA7YrCbz0OKOhACHa3if
	GFN5CsrBqnqW/Y2fyVXiQZN911BEHhmUpX3AeJOHNiEDGvnuKQsmgRwE/tKJXvYB2Tztx4OUBL1bg
	5jtZmJVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHudc-00000003e73-10JA;
	Sun, 09 Nov 2025 01:54:40 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHudZ-00000003e6g-1LGL
	for kexec@lists.infradead.org;
	Sun, 09 Nov 2025 01:54:38 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so3026953a12.0
        for <kexec@lists.infradead.org>; Sat, 08 Nov 2025 17:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762653274; x=1763258074; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTA68YLUrvv1QwWT0WiwLCQWXoEE69/jtOIrBRItPTE=;
        b=f6E+JT94whIkQDa+njZVDmIfpCbzqKXcPgWcYYPfcQjAPwacdpwsYVgstUMCPhz2dj
         UoXVJdGdT+ggoT7J4PHJaY79PgLexqrk+pbdejBNREW1h0H5YPnQ2Lq3x/ZKCPeC3Wlu
         JONcCZF2M2hR5IRhUL/8IpCzWas6k9DfJVQuWGVxQgxHp4curQluGufkeCGDvDBx/p44
         JEO9DuS/u5geAQTqBUX8mk46vKNpk6EkmortoUWxJhFMGoT2Sl1vmN+1qvb1BDtuRWBA
         xlyCOEa8AzF0x2gZ3+tPcwrLutdCGDGAsVynQ+uP48rqvafrYbds8LBsRsfe1Xv4GhYn
         s7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762653274; x=1763258074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WTA68YLUrvv1QwWT0WiwLCQWXoEE69/jtOIrBRItPTE=;
        b=I7u3GdZaIoFXmwZhgHVzGPGU9qliSyMhDxtj68ooCfbrLQG99QZTkrAdkzVJLmyARc
         yqtgUNakg2CyeXbBajLUjeZsl86Q3LIIg0Rc+E85ngO5AVHYKlbKsucn+fec5cFOPsF9
         kepMkhvMqnO6sKJ+ufwjF/ICVBPJRkg8I/+lhWuozZHe2OsadpoMcUZIKCAG0H0RFSek
         oWWpQCw9ANp5P22iy12UW6o1kQInap2vPo8z1X4HZQrZYczlUvx18eLRH1isHZbNoV2T
         Rh5uioe5meDX7Sx6XrP7TXKFloEbKoksZbuStBdJG+qD73L/yK5PCf2nUNIpXIMLYPoQ
         LgFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqUFEhfePPLcIoey2L2y+lZB+Lj9VQTGSJZUsruEXQw6ukKpGsmOXZY1wpuZMABYy21tVbuA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzuO45/996TZwdUYrMen0x93g1xpfevDlBdexdXmiuKq9FIatP0
	d9i1MvFf2yDvRqUDGaJ6jSqH31RTWlHSsaCGbQLaabrN126yuzWmrcf2YQJz0nSssGcTMYwVwxH
	FiKhODkzSy79HDmEODr99R/l8F5kELDSGLjuGEoyPbg==
X-Gm-Gg: ASbGncv760xLxCUDTJprQI9Ipp5MCvMAxkSofHJoQK7l4R+75kR4c95xIdZtNY2OjO/
	CKkLw1uAItp7qTcAn5wKGwqe9ucQ47ARPRXiThQuDgm3aW2COVU4un6dJzcE5i67mkVdaYiDxbF
	iXWsz8n/mrrMRTxhewnRaVeWwGUUTWXiCGQVsJPypmTEcHlq6/axhFMcLoow47RCMeXXQryxMvd
	yixaRZPFLcT9sAig11Mm3s0mu3eu90rqOSCbpnytKegjnazB/CMb8KV5w==
X-Google-Smtp-Source: AGHT+IG65TefAfGFjfDn06mL+BHVcWewTC7OuXAXAWjbdoMW1FgcHSrFYAKWxturLKEwciGsYq0R5hsc5Ht7xlI2p9o=
X-Received: by 2002:a05:6402:1474:b0:640:a836:eaca with SMTP id
 4fb4d7f45d1cf-6415db532c9mr3165400a12.0.1762653274048; Sat, 08 Nov 2025
 17:54:34 -0800 (PST)
MIME-Version: 1.0
References: <7742456c-b248-04cc-0e1a-9da7d0546f1a@google.com>
In-Reply-To: <7742456c-b248-04cc-0e1a-9da7d0546f1a@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 8 Nov 2025 20:53:58 -0500
X-Gm-Features: AWmQ_blXD3pPkkLiQpz_4mPHNurHAjwPwSz8SvzU3BTsnNgEyjskvz8dFO-YRg8
Message-ID: <CA+CK2bAB84ziS1wWf08U5BbDO48uNqBDz6vtR7hxjakOGhEN+A@mail.gmail.com>
Subject: Re: [Hypervisor Live Update] Notes from November 3, 2025
To: David Rientjes <rientjes@google.com>
Cc: Alexander Graf <graf@amazon.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	David Hildenbrand <david@redhat.com>, David Matlack <dmatlack@google.com>, 
	Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Junaid Shahid <junaids@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Pasha Tatashin <tatashin@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Praveen Kumar <kpraveen.lkml@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	"Woodhouse, David" <dwmw@amazon.co.uk>, linux-mm@kvack.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_175437_467311_E3A81450 
X-CRM114-Status: GOOD (  45.45  )
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

On Sat, Nov 8, 2025 at 6:48=E2=80=AFPM David Rientjes <rientjes@google.com>=
 wrote:
>
> Hi everybody,
>
> Here are the notes from the last Hypervisor Live Update call that happene=
d
> on Monday, November 3.  Thanks to everybody who was involved!
>
> These notes are intended to bring people up to speed who could not attend
> the call as well as keep the conversation going in between meetings.
>
> ----->o-----
> We chatted briefly about the status of the stateless KHO RFC patch series
> intended to simply LUO support.
>
> Pasha started us off by updating that Jason Miu will be updating his patc=
h
> series and is expected to send those patches to the mailing list after
> some more internal code review.  That would be expected to be posted
> either this week or next week.
>
> Pasha also updated that is plan is to remove subsystems to simply the
> state machine and the UAPI; this would be replaced by the file lifecycle
> bound global data created and destroyed automatically based on reserved
> file state.  He was also simplifying the state machine to keep the minimu=
m
> needed support in the initial version, but with extensibility for the
> future.  No exact timeline although it is currently ~90% ready.

Thank you David for running this meeting. The LUOv5 + memfd
preservation from Pratyush was posted yesterday:

https://lore.kernel.org/all/20251107210526.257742-1-pasha.tatashin@soleen.c=
om

Pasha

> ----->o-----
> Pratyush discussed the global file based state and how it may circumvent
> the LUO state machine; it's an implicit preserve of the subsystem
> completely independent of global state.  Pasha said the state is now boun=
d
> to the state of the preserved files only based on sessions.  We're gettin=
g
> rid of global state for now.
>
> Pratyush suggested to tie subsystems with the file handler but this would
> not be possible if subsystems are going away.  Pasha said the new global
> state is flexible and can share multiple file handlers; one global state
> can be bound to multiple file handlers.
>
> ----->o-----
> Jork Loeser as if there is a design/API link for the memfd and whether
> this is something a driver could use to persistently holding data.  He wa=
s
> asking if a driver could associate arbitrary pages with a preserved memfd=
.
>
> Pratyush said the memfd preservation was part of the LUO patch series at
> the end.  A driver can pass a memfd to LUO after creating an fd.  Pratyus=
h
> suggested using KHO to preserve data; the data may moved at runtime but
> would need to be unmovable during preservation across kexec.
>
> Jason Gunthorpe suggested using APIs to get a page from a memfd at a
> specific offset.
>
> ----->o-----
> Vipin Sharma had posted a recent patch series for VFIO[1], David Matlack
> will be working on v2 of this will Vipin is on leave.  Feedback was
> received about not moving the PCI save state and making them public, so
> that's work in progress.  More feedback said there was missing bits and w=
e
> need more PCI core changes that would be updated in v2 to be more complet=
e
> (but also include more PCI changes).  No specific timeline yet on v2, but
> it will be based on LUO v5.
>
> David said the VFIO patches are using an anonymous inode to recreate the
> file after live update and asked if we care about associating recreated
> fds for userspace after live update with a particular inode.  Jason said
> that VFIO would care because it uses the inode to get an address space
> which it uses with an unmapped mapping range and this must work correctly=
.
>
> ----->o-----
> Sami summarized the discussion on IOMMU persistence.  He was working on
> updating the patch series to v2 based on the feedback from v1.  He talked
> about restoration of the HWPTs on the restore side.  Jason thought that w=
e
> wouldn't have an IOAS for the restored domains and suggested it could be
> null instead.  Sami thought this may be slightly invasive including where
> we are taking locks; Jason suggested against a dummy IOAS.
>
> ----->o-----
> We discussed briefly about deferred struct page initialization support
> with KHO.  Pasha said KHO isn't compatible with deferred struct pages
> although when using KHO we definitely want fast reboot performance.  We
> decided to discuss this more later after LPC where there will be some
> discussion about reboot performance.
>
> ----->o-----
> Pratyush noted that he is working on the 1GB preservation but will take
> some more time to clean up and have it working properly.  He said
> guest_memfd would use hugetlb for 1GB pages so he's working on hugetlb
> preservation.  Pratyush was focusing on generic hugetlb support that coul=
d
> be ported for use with guest_memfd when it supports hugetlb.  He's aiming
> for an RFC to be ready by the time of LPC.
>
> Ackerley updated that the hugetlb support for guest_memfd is currently in
> RFC patches posted upstream.
>
> ----->o-----
> Next meeting will be on Monday, November 17 at 8am PST (UTC-8), everybody
> is welcome: https://meet.google.com/rjn-dmzu-hgq
>
> Topics for the next meeting:
>
>  - update on the status of stateless KHO RFC patches that should simplify
>    LUO support
>  - update on the status of LUO v5 overall
>  - follow up on the status of iommu persistence and its v2 patches based
>    on v1 feedback
>  - update on the v2 of the VFIO patch series based on LUO v5 and expected
>    timelines
>  - discuss status of hugetlb preservation, specifically 1GB support, with
>    regular memfd, aiming for an RFC by the time of LPC
>  - update on status of guest_memfd support for 1GB hugetlb pages
>  - discuss any use cases for Confidential Computing where folios may need
>    to be split after being marked as preserved during brown out
>  - later: testing methodology to allow downstream consumers to qualify
>    that live update works from one version to another
>  - later: reducing blackout window during live update, including deferred
>    struct page initialization
>
> Please let me know if you'd like to propose additional topics for
> discussion, thank you!
>
> [1] https://marc.info/?l=3Dlinux-kernel&m=3D176074589311102&w=3D2
>

