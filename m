Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD2AC5DF9C
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 23:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTeOTUFHiW1u4M+V9TEbXHSkqLH28/RZ5ap3kTNQUFE=; b=a88ZQ8z5mNP5pGYpBrIT9wox9K
	pTCObTWA31bDIWBu4B5u0q1jz7hJi+v5rinahXfoZPDx1WevaMnIMq0XbF0yTwbcWoyJtzy1GsIGE
	I76tdB3W8esPn7L/PJZKfko/tsh1GrwrZu1r+Ci4szwiqOdtJApoRQ69CRDrU2ndk4swTbR+fDia+
	LmUAHFxJtzrH81y2DcXFEnh2L3ntT/ctQgYh0EJgLTqAb+F8HiOpjBduw3H0rRsVcjfKLzAk9++of
	uekqIpHys1ehcarauZ3DLVZ+0XTKfTLoC3GZreUf27lqdqUVaGueDV/9vF5cAHSzAt6Kef9qwzOHo
	b2mA+vDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wydm8-0000000HTyC-37JQ;
	Mon, 24 Aug 2026 23:08:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wydm5-0000000HTxf-25OG
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 23:08:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787612893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTeOTUFHiW1u4M+V9TEbXHSkqLH28/RZ5ap3kTNQUFE=;
	b=XMVg0oP79VHxOY9VSbNjIb5C5u7eJHH76vTg4p/Bo0BAwWS25vGLguxkzgCN5cDk4Ub3/1
	KGURKaQ/GIi9jRNeEsJeTqiqgceiizcracw27YsdiuTwnBlOfLJYYQbhvVDyc/TUnM1GvH
	5nYxAESkRWV9y2e0cD+NyLmcKEEhFMY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-MLwI7GSwNyybA5aWsFDDOQ-1; Mon, 24 Aug 2026 19:08:09 -0400
X-MC-Unique: MLwI7GSwNyybA5aWsFDDOQ-1
X-Mimecast-MFC-AGG-ID: MLwI7GSwNyybA5aWsFDDOQ_1787612889
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1a9764f0so43617181cf.1
        for <kexec@lists.infradead.org>; Mon, 24 Aug 2026 16:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787612889; x=1788217689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qTeOTUFHiW1u4M+V9TEbXHSkqLH28/RZ5ap3kTNQUFE=;
        b=BiY7KTeBm9NCo5URsgbwGKf6THvV/8AmvOOJJzDGsn9E72upsjtWkcMfgBXnbv/LM+
         JJzSVnH0niTHlOWi+uyEySEq0a+IRWqFSlik1Zz8PfpxyyCecQMmPgCyNFvu4tFThPzI
         6h9ABOEMFgYRZmkH6KVjfue7+FD8tjy+gk8Wso3Vdltec7JLLaX0j8tWcG4rZL4oHC3a
         HBrrpnYP21qlcmpjHvBGoftpZSc3aakBffB8YmumnsrhuNMAO2ypPRDxVdgVCb32tCv0
         ArEDIXuJ+lwbhWmU6rnw3BFKZ/FRiqepMa3rVNcQHUOdG6wAKdkp9W2pZNbbcvGrQQdY
         ediA==
X-Forwarded-Encrypted: i=1; AHgh+RqFhowKtPLI0gghxJ8Lr6vVykbIai0iC41cqx+kea0qJcnExn3Kg5GKuAXUnX7mW5VnwtIMeA==@lists.infradead.org
X-Gm-Message-State: AFuF++kbhWb3Za6PMvqcvOIDsensH05fxMlY6OQM35fffdKruQizQM5/
	OG24Hw+lRc1O8vZEv7lHZ40Sth6sej7oxFfnOSGzpCRNlJVNBEmf3sQzkOhW7L7mMfCIkzNkXh3
	pdzfKZBvqzVLyHYeJNl/vKQ6KBld1VAm+SAGqZL5tXsRJGUxPzNiPSqTHVT/yXUD5kfQa3OXVvC
	7SfeX0y6bYW6jezFa3GSQjLUuEAWOaokSFfFVdxZpctafVLy0=
X-Gm-Gg: AR+sD12dpEYpSR2gkRv7YHdOQCB97ENX0x/sUhobOVJ6Du8H5IgvcmAFSHN5pQtnJ3P
	dQjKcq+favP9A8lwz3mcO+1+tBF9g5jbgCdFDkjlds/1ngOe4g3rccbwuyOXDwQGOeBLc7P1WEr
	iPh6u2y9cm5GW11qK95G1i2qtuIa80DjyIH4onCE4VSrGPup/jcEsJKw==
X-Received: by 2002:ac8:5a86:0:b0:51b:fcb4:7576 with SMTP id d75a77b69052e-52e2f08851bmr30064111cf.15.1787612889157;
        Mon, 24 Aug 2026 16:08:09 -0700 (PDT)
X-Received: by 2002:ac8:5a86:0:b0:51b:fcb4:7576 with SMTP id
 d75a77b69052e-52e2f08851bmr30063431cf.15.1787612888765; Mon, 24 Aug 2026
 16:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
In-Reply-To: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 25 Aug 2026 11:07:31 +1200
X-Gm-Features: AcwNN1ViML52hQQMVFbFMM1tUzQlmlZITc-Gz3XnQQsdRQGP9mgbMfhmNCiCiL8
Message-ID: <CAO7dBbXZ5VP=ProMR+mxJzh5RLJk8-eZE2rpo6rspVuLr4yqVw@mail.gmail.com>
Subject: Re: [PATCH makedumpfile v2 0/9] Improvements to makedumpfile
 extensions, plus userspace stack tracing extension
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: k-hagio-ab@nec.com, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zhhF-Qihbl3my6dvur-xFBZOZrnR_LzLbKCFgvgJRuQ_1787612889
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_160817_635783_AAEFD0E2 
X-CRM114-Status: GOOD (  31.65  )
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

I have tested the patchset upon my filtering extension, working good!
And I agree with your current PG_INCLUDE_HEAD design, let's go with
this.

Reviewed-by: Tao Liu <ltao@redhat.com>

Thanks,
Tao Liu

On Fri, Aug 21, 2026 at 11:31=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Hello all,
>
> This is v2 of my series of improvements for makedumpfile extensions.
> v1 can be found here: https://lore.kernel.org/kexec/20260714004550.369817=
5-1-stephen.s.brennan@oracle.com/
>
> There have only been a few changes from v1:
> - Updated extension/sample.c to use the new API in patch 3.
> - Reordered and reworded the extension retained pages statistic per Tao's
>   suggestion, so that it is more clear.
> - Included a more complete commit message in patch 7.
> - In patch 1, removed the "nr_pages =3D 1" when extensions return PG_EXCL=
UDE.
> - Significantly reworded patch 1's commit message to explain the differen=
t cases
>   and the alternative approach.
>
> Notable improvements in the "userstack.c" extension are:
> - Leverage "detect_cycle.h" API to apply Brent's algorithm for cycle dete=
ction
>   in linked list iteration, to avoid infinite loops while iterating tasks=
 &
>   threads on corrupt vmcores.
> - Set a limit to the number of retained anon_vma entries, to avoid hittin=
g OOM
>   issues in case of a huge vmcore or a bug in the extension.
>
> As discussed on v1, the final two patches containing the extensions are n=
ot to
> be merged. I will publish them in a Github repository as soon as I can ge=
t it
> arranged with my employer. They are more for demonstration of the API and
> continued sharing until the repository is available.
>
> The major discussion on v1 was on patch 4, dealing with how extensions ar=
e
> called, between:
>
> (a) Extensions are called for all base pages, and their decisions may con=
flict
> with the head page decision.
> (b) Extensions are not called for tail pages, and the head page decision =
is used
> instead.
>
> As I explained in my last reply, I believe that (b) is still the best way=
. It is
> less complex than (a). It is also more efficient, because makedumpfile to=
day
> skips processing many excluded tail pages, which adds up for large system=
s with
> many huge pages. We do not have any extension which requires any policy m=
ore
> complex than PG_INCLUDE_HEAD.
>
> - elfheader requires PG_INCLUDE_HEAD
> - userstack only uses PG_INCLUDE. I could imagine potentially wanting to =
include
>   just the sub-pages of compound pages that are actually used by the stac=
k. But
>   it hasn't been necessary so far.
> - amdgpu buffers may be compound pages but if they are, then the entire p=
age
>   would be excluded.
>
> I do have an implementation of (a) as I showed in the thread. If I'm wron=
g here,
> I can always fall back to that.
>
> Thank you,
> Stephen
>
>
> Stephen Brennan (9):
>   Do not call extensions for tail pages
>   Honor CFLAGS in extension/Makefile
>   Share page information with extension callbacks
>   Introduce a stat for pages retained by extension
>   Move page checks into makedumpfile.h
>   Simplify arguments for page checks
>   Add PG_INCLUDE_HEAD extension return status
>   Add userstack extension
>   Add elfheader extension
>
>  extension.c             |  10 +-
>  extension.h             |  10 +-
>  extensions/Makefile     |   8 +-
>  extensions/elfheader.c  |  93 +++++++++++
>  extensions/list.h       | 106 ++++++++++++
>  extensions/sample.c     |   2 +-
>  extensions/userstack.c  | 351 ++++++++++++++++++++++++++++++++++++++++
>  extensions/vma_mtree.c  | 140 ++++++++++++++++
>  extensions/vma_mtree.h  |   7 +
>  extensions/vma_rbtree.c |  56 +++++++
>  extensions/vma_rbtree.h |  12 ++
>  makedumpfile.c          | 189 +++++++++-------------
>  makedumpfile.h          |  78 ++++++++-
>  13 files changed, 931 insertions(+), 131 deletions(-)
>  create mode 100644 extensions/elfheader.c
>  create mode 100644 extensions/list.h
>  create mode 100644 extensions/userstack.c
>  create mode 100644 extensions/vma_mtree.c
>  create mode 100644 extensions/vma_mtree.h
>  create mode 100644 extensions/vma_rbtree.c
>  create mode 100644 extensions/vma_rbtree.h
>
> --
> 2.52.0
>


