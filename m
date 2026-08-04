Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318D7C55184
	for <kexec@archiver.kernel.org>; Tue,  4 Aug 2026 04:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P2hWmXEYKLdR1l/opMy7YgCtg3M2pMsrmlq69E10bs0=; b=XbeFz2y9sOUgvNGkRMihYmKr0i
	ItMPtCHelGiqRGE4w4W69Nvqew8mK+9JQrQ5TwWpYJ4nPx9aQ9OjlUDxFeN46ve2KHOq3wYqMdBCB
	lASlKv0YhWVt7MTyUAzRUET+ZZ414JafW5GPKAFfKvpKloAIgvJgb9mQS9SEbi0PSNWTroPHLAZ28
	Z6L2IXJhTvPYF3h108r6Cf//bVRPWJ5kBCPNC6C3zLYH7MrHKgXWVys770IgPJdvrw43XI3FvE0SR
	U8GhLsSJrqfyTppPT2ODY5S0JN/GrB8omdZi3BlVvdb5jYX8IbGCirzo1Av7jO2NvMqwTKQQrnCWq
	QKPS4W/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr70X-0000000104l-49V8;
	Tue, 04 Aug 2026 04:44:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr70S-0000000104I-1Yiu
	for kexec@lists.infradead.org;
	Tue, 04 Aug 2026 04:44:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785818638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2hWmXEYKLdR1l/opMy7YgCtg3M2pMsrmlq69E10bs0=;
	b=LmUf8gw55op+VTY8hWX9DIygRiwTOPs2ccAR/hKLQXISwwCvHm7BHZjiD6KhxzNeC/ksDZ
	qkEqIq9rC3i/tbBxfTgGEenDBvYP/C/bJt+qOoIlHrAiYWQ0Pqsy6/DI/2GgXDp6uAywEj
	vM7Yh7J8oK87P14nAq1ZqGEWlKLqJAc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-_SC0T7ZVPACTSpxhkVrB9w-1; Tue, 04 Aug 2026 00:43:51 -0400
X-MC-Unique: _SC0T7ZVPACTSpxhkVrB9w-1
X-Mimecast-MFC-AGG-ID: _SC0T7ZVPACTSpxhkVrB9w_1785818631
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c21c01cf3so74699121cf.2
        for <kexec@lists.infradead.org>; Mon, 03 Aug 2026 21:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785818631; x=1786423431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2hWmXEYKLdR1l/opMy7YgCtg3M2pMsrmlq69E10bs0=;
        b=M/SEYeedti6xqTNKyi6ITvM9ILbR1IXriq1S1/MzphjAq7DdlbDjzINGoBzE3Qi+H4
         Gju/KZZKaqOzU5Vk1EVKU9vw3x7F2OQdMm9bp4Efn295a9R8+3p2M0i3teNxftvGWrRT
         0cGOkSdO6eqzf606jMAyIrbUrdxeB+OJb65FbybhPE0x4ar/DeawdbCTl0A0c/GyMk84
         o+Grjl6OPHpgt0SxjEw8KcSZI6x+8FONAHvTG2Mh8m29T33QclEfV7DoYxqQviArg0Df
         RUtza9xFLK6kruijwpwVoXR9cqqJF0xx0XJWmx4WxWHak3iwU67D7odnk4PD8BX+z/Ej
         /HQA==
X-Forwarded-Encrypted: i=1; AHgh+RrBbTmRdl+ywaZYsk/VqdHzfm65MvVZgTm974YtR4g6VAA7vz+AOwfyY1rhvyArj6SjYoyGrg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzT6ngFtlLY/kUJNFFt1Hg/JSmPJYQizGQ3LHvs7PqFOfdBErAw
	3YoR71X92Z0ziSa5VhwVpsfKPVoGMqhgKVJAyCMTeyU6KC2If4rCWUrkBuk+EoBOzvBaYLuYaQA
	S2JUy8LQj6boP1XnCmyJlSdtvG3HOkmJy1nmbqz3Zhxc3s3i6q53J6m3+bpyVimpzkPyQ4whh+W
	NMUiZikdDeyw3OnbCzXz8f3xQUu2OlUbtfKOCt
X-Gm-Gg: AR+sD122XLhK53O85TwwHvx6fyp8k3SV4kxCe3IOTTZQT3lZddloVdZuoi/ZhYA3GTZ
	Z7VWi4gYUDzJ1grht0GIUAaLRjcYuuJ/bj/Mridm7EUYQ+0vAtU54xhb3Qwrs1uN7mFKuWBtKpq
	/+HSs4qRanbcuCNMrFOwIz/TF965mCaQIzPJQxl+W0jSVul1pQuvaXbQNp
X-Received: by 2002:a05:622a:53c4:b0:519:5680:1b5 with SMTP id d75a77b69052e-52b5674be9cmr282673681cf.21.1785818630680;
        Mon, 03 Aug 2026 21:43:50 -0700 (PDT)
X-Received: by 2002:a05:622a:53c4:b0:519:5680:1b5 with SMTP id
 d75a77b69052e-52b5674be9cmr282673331cf.21.1785818630128; Mon, 03 Aug 2026
 21:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com> <8733wv42ri.fsf@oracle.com>
In-Reply-To: <8733wv42ri.fsf@oracle.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 4 Aug 2026 16:43:13 +1200
X-Gm-Features: AUfX_mzc-E9tMPpbU8El2PdAkXfMmXe1V4rg8mIV5ILNXJ0Othe5mU025YmMzbI
Message-ID: <CAO7dBbW_EvAHJ3AoZEVXeNon=N-RtVpyy5bHwgs1k7zyh00c6g@mail.gmail.com>
Subject: Re: [PATCH makedumpfile 0/9] Improvements to makedumpfile extensions,
 plus userspace stack tracing extension
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JuF_X_58Y8G-1pu3tK-gf7D_1coJnkVunoZSOi2qgTg_1785818631
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_214400_487599_02B4D648 
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

Hi Stephen,

On Tue, Aug 4, 2026 at 4:14=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Hello all,
>
> Just a gentle ping on this series.

Sorry I was busy recently due to some internal team issues. Anyway I
will review the patchset, it's on my queue.

Thanks,
Tao Liu

>
> Thanks,
> Stephen
>
> Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> > Hello all,
> >
> > Building on Tao Liu's excellent work for makedumpfile extensions, I'd l=
ike to
> > share some incremental improvements to the extension system, as well as=
 my own
> > two extensions which enable userspace stack tracing. There are three to=
pics
> > related to the core makedumpfile extension system which are addressed h=
ere:
> >
> > 1. Tail pages handling. As patch 1 explains, extensions currently get c=
alled for
> > tail pages, but their decisions are not respected. I believe the best a=
pproach
> > is to only call extensions for the head page, but allow extensions to r=
eturn a
> > decision related to just a subset of the pages. To this end, patch 7 ad=
ds
> > PG_INCLUDE_HEAD to include just the head page (leaving the rest up to t=
he
> > default policy), and patch 9 shows the elfheader extension which uses t=
hat
> > functionality.
> >
> > 2. Counting pages included by extensions. This is done by patch 4. It a=
lters the
> > logic because it's really helpful to know whether a page would have bee=
n
> > included by makedumpfile's dump-level filtering anyway, so we only coun=
t the
> > additional pages.
> >
> > 3. Sharing makedumpfile's logic and knowledge about page metadata. Curr=
ently,
> > extensions just get a "pcache" pointer, which means they must redo what=
ever
> > logic makedumpfile has already done, in order to get information like
> > compound_order. Patches 3, 5, and 6 factor out the page metadata into a=
 new
> > struct pginfo, which gets passed to extensions, and it also makes more =
of the
> > helpers like "isSlab()" usable with this pointer.
> >
> > With those improvements, the final two patches (8 & 9) implement a pair=
 of
> > extensions that are useful for including a minimal amount of informatio=
n which
> > can be used to do stack traces of the userspace processes in a vmcore. =
The
> > "userstack" extension includes the stack memory itself for each thread,=
 and the
> > "elfheader" extension includes the first page of mapped ELF files, so t=
hat ELF
> > build IDs can be identified from the vmcore.
> >
> > My testing so far:
> > - Live testing (/proc/kcore) x86_64 on Oracle UEK 8 (6.12.x based)
> > - Refiltering on vmcores generated from UEK8, 7 (5.15.x based), 6 (5.4.=
x based)
> > - Using the resulting filtered vmcores with drgn's contrib/pstack.py to=
 generate
> >   userspace stack traces.
> >
> > I still have significantly more testing to do and then share out:
> > - Testing in kexec environment
> > - Testing with upstream kernels, also verifying in a Fedora userspace
> > - Sharing runtime and size comparisons with different workloads
> >
> > Despite the limited testing, I wanted to share these patches as they ar=
e,
> > because I think the improvements for the core extensions framework are =
useful
> > already, and don't require as much verification.
> >
> > For the extensions themselves, I would like to consider merging them as=
 well, if
> > there is interest. I think it would be useful for makedumpfile to conta=
in shared
> > extensions, including those for the GPU buffers which Tao Liu was worki=
ng on, as
> > well as the userspace stack tracing ones which I'm sharing.
> >
> > Thanks,
> > Stephen
> >
> > Stephen Brennan (9):
> >   Do not call extensions for tail pages
> >   Honor CFLAGS in extension/Makefile
> >   Share page information with extension callbacks
> >   Introduce a stat for pages retained by extension
> >   Move page checks into makedumpfile.h
> >   Simplify arguments for page checks
> >   Add PG_INCLUDE_HEAD extension return status
> >   Add userstack extension
> >   Add elfheader extension
> >
> >  extension.c             |  10 +-
> >  extension.h             |  10 +-
> >  extensions/Makefile     |   8 +-
> >  extensions/elfheader.c  |  93 ++++++++++++
> >  extensions/userstack.c  | 325 ++++++++++++++++++++++++++++++++++++++++
> >  extensions/vma_mtree.c  | 140 +++++++++++++++++
> >  extensions/vma_mtree.h  |   7 +
> >  extensions/vma_rbtree.c |  56 +++++++
> >  extensions/vma_rbtree.h |  12 ++
> >  makedumpfile.c          | 188 +++++++++--------------
> >  makedumpfile.h          |  78 +++++++++-
> >  11 files changed, 798 insertions(+), 129 deletions(-)
> >  create mode 100644 extensions/elfheader.c
> >  create mode 100644 extensions/userstack.c
> >  create mode 100644 extensions/vma_mtree.c
> >  create mode 100644 extensions/vma_mtree.h
> >  create mode 100644 extensions/vma_rbtree.c
> >  create mode 100644 extensions/vma_rbtree.h
> >
> > --
> > 2.47.3
>


