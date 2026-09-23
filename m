Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA62CC98304
	for <kexec@archiver.kernel.org>; Wed, 23 Sep 2026 22:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y/8cCai3+gMWO6LIo701U/Zh4RgUpa9pwpp5h99P4sw=; b=nzs6WtDzNGIhy1HHBwkPoh3zIR
	ZHQHHVH3RbYnEe6mmIzpaWhbxEV0N1v18Yebhjr3tRvweNTrkjtIgBuGKslsojXuJKkq8A2x0SoZw
	zD8odaojddaiXgnW9WaVLlO6c5pSp2pm5TqkY5ht7/VXZMGIIwgf4biCAI+guIGjTHuFMSidiL/Br
	sc2NOdTEMEaWGu7CZghvraBhHZumq/Wqd9CkU5mU3LMGN6fsOrwbhqDLp8XGpwJacTyJWtQ6Jqc9y
	A/F24TvjYIh2fF+W3c8MKvp7UvYdt15NvgAztyBhq9gHRS4bX4C4aO32HkXF5GvwTD8tz1JYfpnMf
	wb969irg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9VsW-00000009gUt-1rmU;
	Wed, 23 Sep 2026 22:55:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9VsV-00000009gUm-2HAk
	for kexec@lists.infradead.org;
	Wed, 23 Sep 2026 22:55:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 05FF341A08;
	Wed, 23 Sep 2026 22:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AC21F00898;
	Wed, 23 Sep 2026 22:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790204150;
	bh=Y/8cCai3+gMWO6LIo701U/Zh4RgUpa9pwpp5h99P4sw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CsCpPBhUck5u9x5fqVL0K/bW6iAUQ97QJJMFy1hh6nDVhkPc77hjwuwNSu3o3/98A
	 fgk6cddigQYs+obUykSIkWJeH3tjG6j7cJmd6aLY3VpU9bH/XAQVff/t/3Pk8gwxAL
	 KD1ck/Yubn1NJCbxKm6s8RcwpyW8yn8/21uwh0wXi38NgncvXpKgOB6U2Ng1lGbnSE
	 Mye7fHN/UA/h1vLqlt0v3wJr+17DZC8pRp3WSsIPERTefWpHHIf0EqvAQugfGEbRgH
	 3MxDk4HzIMoRUK3eRXuLqtbIIRVHpFEqYbxoK2kQWMoqvW6M6r+gZfmmPzG+DyBSmz
	 WEAzPHfNEjGZw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/6] liveupdate: luo_file: look up outgoing tokens
 by id
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Pratyush Yadav" <pratyush@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "Alexander Graf" <graf@amazon.com>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Mike Rapoport" <rppt@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Hugh Dickins" <hughd@google.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
In-Reply-To: <20260923224408.3745689-2-pratyush@kernel.org>
References: <20260923224408.3745689-1-pratyush@kernel.org>
 <20260923224408.3745689-2-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:55:49 +0000
Message-Id: <20260923225550.32AC21F00898@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] liveupdate: NULL pointer dereference in liveupdate_get_token_outgo=
ing() on incoming sessions
- [Medium] liveupdate: flat ID namespace in liveupdate_get_token_outgoing()=
 risks cross-handler collisions
- [Low] liveupdate: O(N) indirect function calls in liveupdate_get_token_ou=
tgoing() list traversal
--

commit 17b042e4901cfc25a86dec1038092fbe1eb5d060
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

liveupdate: luo_file: look up outgoing tokens by id

liveupdate_get_token_outgoing() is used to look up tokens of dependencies.
It does the search based on struct file. LUO provides file handlers a
get_id callback that can return the unique identifier of a resource. This
patch uses ID to look up dependencies in liveupdate_get_token_outgoing()
instead of struct file.

> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index a39992da504fb..51817d202ce26 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
[ ... ]
>  int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> -				  struct file *file, u64 *tokenp)
> +				  unsigned long id, u64 *tokenp)

[Severity: Medium]
Will this flat ID namespace risk cross-handler collisions?

Because liveupdate_get_token_outgoing() searches across all preserved files
using just an unsigned long id, it loses the context of which file handler
the ID belongs to.

If different handlers use overlapping namespaces, such as IDR indices or
pointers that might alias depending on object lifetime, a lookup intended
for one handler's object could incorrectly match an object from a different
handler that happens to appear earlier in the list.

Could the API require the expected file handler context to scope the search
safely?

>  {
>  	struct luo_file_set *file_set =3D luo_file_set_from_session_locked(s);
>  	struct luo_file *luo_file;
>  	int err =3D -ENOENT;
> =20
>  	list_for_each_entry(luo_file, &file_set->files_list, list) {
> -		if (luo_file->file =3D=3D file) {
> +		if (luo_get_id(luo_file->fh, luo_file->file) =3D=3D id) {

[Severity: High]
Can this cause a NULL pointer dereference on incoming sessions?

In an incoming session after deserialization, luo_file->file is initialized
to NULL and remains NULL until the file is explicitly retrieved.

Because liveupdate_get_token_outgoing() is an exported API that accepts a
generic struct liveupdate_session, an in-kernel caller could mistakenly pass
an incoming session.

Prior to this patch, doing so would safely return -ENOENT because NULL =3D=
=3D file
is false. With this patch, luo_get_id() will blindly pass the NULL file
pointer to the handler's get_id callback.

Handlers like memfd_luo call file_inode(file), which would cause an
immediate NULL pointer dereference and kernel crash.

[Severity: Low]
Are these indirect function calls necessary during the list traversal?

Replacing the direct pointer comparison with luo_get_id() performs an indir=
ect
function call (fh->ops->get_id) if defined, on every iteration of the
files_list traversal.

Because this function is used to look up tokens for dependencies, it can be
called for every dependency of every preserved object, resulting in O(N * M)
indirect calls.

Since the ID is a constant property of the preserved file, could it be
evaluated exactly once during luo_preserve_file() and cached directly in
struct luo_file?

>  			if (tokenp)
>  				*tokenp =3D luo_file->token;
>  			err =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923224408.3745=
689-1-pratyush@kernel.org?part=3D1

