Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B7AC5DF7D
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 19:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Subject:CC:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=jIZvfTBmv7kxMWgBP10qlLdQUm/oMhrYSlhXAeuBuJA=; b=2jmoCFpUuNVQrOgAwktOadO4ik
	aPZj78BsP+zAV+Zmqzkc6PulZGkCHSdhSBLlbOw8LIYRwFC2Bwy2l32iCVBmRgTE5kLWIgYpGMyGT
	IOHb2PlhRtZeUEq6akLwsRkaT2zsw5Ho0AHlkDstW59xY/hqKBg9gKYqdwQmPgszrPctsGo6OTgW/
	v6LeoLBkn5KVrGaw5hojXGRX+gQL9YUmr//BJFVWybGo7ikQJXLLuq1qX4pEar3dXm3dUtZBO5ZHR
	m+A3uaepMxvE3IFI4OD8c96/QTg5peMKzAfadfQKIEI01zb/1TQxArMCZxBP9g1ttpULffU+9zQij
	rKfCREug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxUhB-0000000E0HQ-1yxP;
	Fri, 21 Aug 2026 19:14:29 +0000
Received: from confino.investici.org ([93.190.126.19])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxUh7-0000000E0H2-41x0
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 19:14:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787339658;
	bh=jIZvfTBmv7kxMWgBP10qlLdQUm/oMhrYSlhXAeuBuJA=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=fyKEVOqi6yLCS1BxB2jI8bWqLvVoHyqXOfyiRwCDwHKtlcWs6dFVY7wynuuD/GNY+
	 w8bMcdWQJ+KqAN6MCVTtW0s1c8G6HD/SX9gt6pKxxx7zrdS02NSn0nC3TaIciNzbsX
	 gtFvRUWuD8lZOw5OnIKTZjO/tJnsoBV4GbRk1M3M=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hRVNV4F5kz110G;
	Fri, 21 Aug 2026 19:14:18 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hRVNV1Ng5z10yw;
	Fri, 21 Aug 2026 19:14:18 +0000 (UTC)
Date: Fri, 21 Aug 2026 20:14:18 +0100
From: Bradley Morgan <include@grrlz.net>
To: mpilaniy@redhat.com
CC: horms@kernel.org, kexec@lists.infradead.org, ltao@redhat.com,
 prudo@redhat.com
Subject: Re: [PATCH] kexec: fix kexec_file_load fallback error handling
In-Reply-To: <20260814075329.30203-1-mpilaniy@redhat.com>
Message-ID: <AD2F7A1F-3D15-424E-9F3A-6E8D2A937E6F@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_121426_475018_51A728BE 
X-CRM114-Status: GOOD (  10.14  )
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

On 14 August 2026 08:53:29 BST, Mukesh Pilaniya <mpilaniy@redhat.com>
wrote:
>With the default -a (--kexec-syscall-auto) option, kexec-tools first
>tries kexec_file_load() and falls back to kexec_load() when the syscall
>is not implemented (ENOSYS) or the kernel does not have a loader for the
>image format (ENOEXEC/ENOTSUP). [...] Falling back on EINVAL hides the
>real error, because EINVAL means something went wrong during loading.
>
>Remove EINVAL from the fallback path.

Hiding the real error behind a fallback is exactly what makes this one
hurt to debug, so good direction.

>Several kexec_file_load() image probe functions incorrectly return
>-EINVAL rather than -ENOEXEC when encountering an unrecognized image
>format. This kernel patch fixes the issue:
>https://lore.kernel.org/all/20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com/

That one is still being reworked, Pratyush just LGTM'd the
probe_default change a couple days ago and the fix isn't in any tree
yet. And until it is, the arm64 probe and the riscv image probe still
return -EINVAL, and that last errno is what kexec_image_probe_default()
leaks to userspace (I checked the loader lists in the tree). So if this
lands on tools before the kernel fix lands, an image that used to
silently fall back to kexec_load() on those arches now just fails with
EINVAL.

Is the plan to hold this one until the kernel side is in? Because right
now it looks like it can race ahead of its dependency.

>Print the actual errno for ENOEXEC/ENOTSUP before falling back

Good, that is the part that makes the s390 command line case visible.

The my_load/k_unload ENOSYS message hunks are unrelated cosmetics, fine
but could be their own patch if you feel like splitting.

Its a good patch, I just want the ordering question answered first.

Thanks!

