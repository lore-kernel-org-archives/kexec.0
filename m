Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47901106B53B
	for <kexec@archiver.kernel.org>; Wed, 25 Mar 2026 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=faA6mSGMnx6rDUpnfk0PZMG7cUv6wd8U0MzReApShCA=; b=TblaDg4RZit5259g3xLoAi/wdu
	0YgMj7Hpz63RJ3YCmF6PbgpA0j6/dp0cQcief+TSW3ktYt8t+H/+O8bBLugRN2C8AuGQFA8njhESO
	bj3tgLmynlWU1jm9liNB54ZZAO+mBP6gX8zjAeyTqvwDaLvMXqBYWC0lFptXXFTUdOCkwt/djNN0g
	c4mLFqPkrmjifk4ONOLJBfsRROVVhcVMxTbiqcIR6inmADi2w0bevoCrd/+GRPtECie7qVV53QX0Z
	yYPAb2airvYWbUcdOVmhyK8a1appM/i1XX0Nr26WISuaJ5LfPZh4It5QmzJ2Xz5FC7zq5xDf1Nawk
	KX3I0Uwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5OSL-00000003Tmj-0UNJ;
	Wed, 25 Mar 2026 13:39:33 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5OSI-00000003Tm2-0bls
	for kexec@lists.infradead.org;
	Wed, 25 Mar 2026 13:39:31 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-660a58841d4so3520223a12.0
        for <kexec@lists.infradead.org>; Wed, 25 Mar 2026 06:39:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774445968; cv=none;
        d=google.com; s=arc-20240605;
        b=cEFu/LiTyy/0pwFpW3pRUSgRjXmNGI3zYP3uluu00iQLfSseBybx4WVFIUuJi+1A2E
         YcFPG4PcBnGUMBfp9I7HcoGIx/zfHUbLBQomKtbKv8pksEoxxkO5T1Km5y4nxjvB8FZv
         9aiWSW0Bb4efqqN7Uz2mCVxTs5Pyh6p/5Kvf8mZ+H+387ZxG7ozc5gGAA3tdi9vm439W
         d8wVv+6f6kNZBbDP5ue08EaDB3lEsW6vnWlb6A0rlSZD49V2Ls538teJUQ+VrM904wn+
         Pp+YEKWvA1srXdO2KaKCSMzVzXhC8/sG+x2GcOClUzOqd7uXciZG2wgYnv/qrdJF+MbK
         hlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=faA6mSGMnx6rDUpnfk0PZMG7cUv6wd8U0MzReApShCA=;
        fh=Xe31LK1TGj4DbWza/fkoG11Z3tLS3EqUbQZSJP6CSH0=;
        b=aTk+u7jANhhuzwRiUdwXE7+m+yI5DJfazNJ96CTitBg4UKuBvrnVhueuuieoaaaDvn
         laeCs92HLmShVx9gNygyFk4L2l4Yjeq9t1ecM2wGREboOykVfGm/DebW+5JiV7b14kxx
         pyMiwLb58RdgaYo6Kma/8V6lQEVyrefyVGxMkH8skuw1Eyknk0TFWrgO5i9a9Ik5WXAx
         FoLhVVZLVun0AsP3C5MLwx25wF6loPAJnC/d4DlHDCDDo6lpm2DjvUUANAueobesm2Qh
         ngNTFZLVU16jiscf8q4eXihSteoXNCg9QX20zE1+bdlC2yJmU8ykNsSY77096uFaQh5o
         4SGA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774445968; x=1775050768; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faA6mSGMnx6rDUpnfk0PZMG7cUv6wd8U0MzReApShCA=;
        b=JCTqtEt407fMoARri6yeUz34rmyq+UeXmllLMBbYJbAnbWEJRz3t3UJcjM23n518zx
         xEji5IfwMbAdjkNxnGpxkB/tQeSLxPCxjhv3LtclYWH7QrZALB4goY+Rs7C71+PRAnO9
         IVsc7kIl14YJLb78pVu5EN+Bi0Hcoi4hfswT1ed1Ug3noOosoOF/Rlv/JB9DPZyG7scF
         s61HsRxhJv29GlQr/tamw/Vw0gaACI2F3jRzqvT+QnUOsfgELSqZ6ngraXHI9Maei1Il
         ltGLnF0Z5/FgbccREmNsSvitz2wIw7huc+AhxJG4UNlYTff58/JLDLbJou15GBYGxYTJ
         AM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774445968; x=1775050768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=faA6mSGMnx6rDUpnfk0PZMG7cUv6wd8U0MzReApShCA=;
        b=AcnUwEt6iLBxc44HahLbahJN/WJoOTQLhN7jnKZBPEB4H8Ator2qSwWWwLhVIjUSpo
         PwGXeNUcNzwMO3TExgqIWgwlvtl8kF21Odx2V5mP+3iF+7FqXOa6EskCnbnGfB7WBLag
         n7sL/M0F9ucKz0Hw0XjhRDHv8VNv0DHPHm4P9UHcGiXgmJogUQN0/HgMgkt06r5Q7JFq
         I8dhGpabswNjbvfKYpB7N97yXL2KXDkirOCggbDjoJMiA8CH5tCbcYDQDZshluJNCj9p
         PqqkcEw64jyLaggjqyGUsjUF/MfKje6s+TE77ce4Gd0uZYgnXgALpqa/NaBgCE7S8qRm
         dOTw==
X-Forwarded-Encrypted: i=1; AJvYcCVm0EtXSepYyi2ahk8pSOnkB02ZDE0gbi625iCj6C0rVBPJ8YkdnF1u8aED9ZSTVw6KHRVzrg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyvEfuwo4ggx7YGpDmT6+6qQKFlkNe3wUvk+Q7GZypGzgeg2lfv
	D0z9MdYCES70DHU+7N8eaTxrorQXOkSbWlC8IARObw9frmakEDNjR+RaymdaSnB5xiYmaZgdIim
	K4eW4S3jIwOS8EUOhPZBUaa/P1J2q3JT0ak10u1M0bA==
X-Gm-Gg: ATEYQzzsxK0UOps7G6f95FRtPpbfYBkqkS7WYzgzvAj5G2bfr6hrtJcsVl3T63lB8Pn
	c0syhY9wEJNH7LmVcSy/DLuLapF7u/XCNqN7ouHsdrqX8lNUcBXR+MC2ty5k3sb8Gt5xFr38kzC
	Yer8qZ8RJUarWZMMJjraBxE/U4YzWkAktoY6KFsKLqaDb85b08YSY77tIFaZPOVqfj5dnbPDgWo
	YqUY+v2KAXErMM4saP8v1vg4nI11squsapa2oGrS2TKum8h6s8qjVjd1SLSi038AZjhRsiCC6Jo
	KrSY9bXNOZiTYQ05WNme2wX7hVeEslhaDm0www==
X-Received: by 2002:a05:6402:1912:b0:662:fad8:4a9f with SMTP id
 4fb4d7f45d1cf-66a8262df57mr2229663a12.9.1774445967511; Wed, 25 Mar 2026
 06:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260324212730.65290-1-oskar@gerlicz.space>
In-Reply-To: <20260324212730.65290-1-oskar@gerlicz.space>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 25 Mar 2026 09:38:50 -0400
X-Gm-Features: AQROBzANxvahMrwgqF65m0uu8wFijNd2nMQVhGo85hpt9Z6ibVgi4ycmBx884KY
Message-ID: <CA+CK2bCiqCg1Tt0WgP3KszrK96Qahcgfyfige4eUQOkMVyLUqg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] liveupdate: tighten handover cleanup and session lifetime
To: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Cc: Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_063930_250063_DDAB5403 
X-CRM114-Status: GOOD (  28.37  )
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

On Tue, Mar 24, 2026 at 5:29=E2=80=AFPM Oskar Gerlicz Kowalczuk
<oskar@gerlicz.space> wrote:
>
> Hi Pasha,
>
> this v4 keeps the simpler direction from your mail: outgoing handover is
> still driven by a boolean rebooting gate, refcount pinning of outgoing
> sessions during serialization, and session->mutex as the serialization
> point for in-flight mutations. There is no return to the earlier closing
> counter or a larger session state machine.
>
> The main changes in this respin are:
>
> - reshape the series into five commits, each building and standing on its
>   own
> - keep incoming session origin immutable and use retrieved only as the
>   checked-out bit
> - make FINISH and implicit close consume incoming sessions without
>   reopening races through retrieve-by-name
> - route deserialize failures through explicit rollback paths for
>   sessions, files, and serialized memfd state
> - validate KHO-preserved extents before walking serialized metadata
> - harden incoming FLB lifetime and remaining teardown paths
>
> Patches 1-4 keep the core session, kexec, deserialize and validation work
> separate. Patch 5 carries the remaining FLB and teardown fixes needed to
> match the final tree.
>
> Oskar Gerlicz Kowalczuk (5):
>   liveupdate: block outgoing session updates during reboot
>   kexec: abort liveupdate handover on kernel_kexec() unwind
>   liveupdate: fail session restore on file deserialization errors
>   liveupdate: validate handover metadata before using it
>   liveupdate: harden FLB lifetime and remaining teardown paths
>
>  include/linux/kexec_handover.h     |  13 +
>  include/linux/liveupdate.h         |  17 +-
>  kernel/kexec_core.c                |   4 +
>  kernel/liveupdate/kexec_handover.c |  22 ++
>  kernel/liveupdate/luo_core.c       |  16 +-
>  kernel/liveupdate/luo_file.c       | 237 ++++++++++++--
>  kernel/liveupdate/luo_flb.c        | 116 +++++--
>  kernel/liveupdate/luo_internal.h   |  14 +-
>  kernel/liveupdate/luo_session.c    | 500 ++++++++++++++++++++++++-----
>  lib/tests/liveupdate.c             |   2 +
>  mm/memfd_luo.c                     | 160 +++++++--
>  11 files changed, 934 insertions(+), 167 deletions(-)

Hi Oskar,

This is a NAK.

This patch series is still significantly over-engineering solutions to
straightforward problems, and the patches read as if they were
mechanically generated rather than thoughtfully designed. The sheer
volume of changes (nearly 1,000 lines) is unnecessary for what we are
trying to achieve.

As I pointed out previously, we need to keep this simple. For example,
the problem of preventing a return to userspace after a successful
liveupdate_reboot() does not require inventing a new
liveupdate_reboot_abort() function. It just requires placing the call
where it's the last function allowed to return, with a simple
exception for context-preserved kexec jumps. That is a trivial change:

-       error =3D liveupdate_reboot();
-       if (error)
-               goto Unlock;
+       if (!kexec_image->preserve_context) {
+               error =3D liveupdate_reboot();
+               if (error)
+                       goto Unlock;
+       }

The same principle applies to the other issues. You are doing rewrites
when targeted fixes should be applied:
- Sessions mutating after entering the reboot() syscall?: This is a
14-line fix [1].
- Destroyed serialization race during liveupdate_reboot()? This is a
70-line fix [2].

I was hoping that v4 (BTW, why are we at v4 in just a week?) would
include the patches I already provided, along with similarly scoped,
minimal fixes for the deserialization path if needed. Instead, I am
seeing another over-complicated rewrite.

Looking at deserialization, I am seeing, you are deleting a comment
that explicitly explains our error-handling design:
-       /*
-        * Note on error handling:
-        *
-        * If deserialization fails (e.g., allocation failure or corrupt da=
ta),
-        * we intentionally skip cleanup of files that were already restore=
d.
-        *
-        * A partial failure leaves the preserved state inconsistent.
-        * Implementing a safe "undo" to unwind complex dependencies (sessi=
ons,
-        * files, hardware state) is error-prone and provides little value,=
 as
-        * the system is effectively in a broken state.
-        *
-        * We treat these resources as leaked. The expected recovery path i=
s for
-        * userspace to detect the failure and trigger a reboot, which will
-        * reliably reset devices and reclaim memory.
-        */

You are adding a bunch of new functions to solve something we
intentionally chose not to solve. Attempting to cleanly unwind and
release incorrectly deserialized resources back to userspace is
dangerous. It risks security violations and, in the worst-case
scenario, customer data leaks. A failed deserialization means the
system is broken; we leak the resources (make them unavailable) and
rely on a reboot to reliably sanitize the state.

Please drop the over-engineered approaches. Use the patches provided,
keep the fixes minimal, and do not alter established security
boundaries like the deserialization error paths. Take your time to
manually self-review your work, do not rely on AI to do everything for
you.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git/comm=
it/?h=3Dluo-reboot-sync/rfc/1&id=3Dd47b76707c4f352c3f70384d3d6a818e2875439a
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git/comm=
it/?h=3Dluo-reboot-sync/rfc/1&id=3Df27a6a9364cd0a19067734eeb24ea4d290b72139

Pasha

>
> --
> 2.53.0
>

