Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FB9CD5BB4
	for <kexec@archiver.kernel.org>; Tue, 26 May 2026 08:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9VfrhdPCKB6wZtOv0TCXHtVXnKJzthg/PA3HN52ynpk=; b=FXYT7SV8hJOc4FNNLSqSEwepc5
	OzmR8vBio+H3CmF+4H0mNkAGlJiyd9Fm9G9JOlATfjP/YpBuh/dsrRto3IppM/5yGe/w+B93OsIUJ
	rc5UhSAaUoyekiMW2ZuCUzwT3adrMgQaj1DWJ2TOTwgOzU4ynTmzaR+vMuYVxi4hOerJ7w1eonMG6
	M7zQo77D9ORuAOFyHazd3xB8qTgCN5zEjAnhetlmDElN00ifW8nvnu+ecIP/SndDtODRwfGO+PYTn
	Tzw0R0lBkug5IvzDuB6g0J5NAy+mwv0Uu/TUwGhvgr2IyxdmpqRIAhXm/ZXTstPZ3SB5PvQnGqyXR
	9z84LFEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRmut-00000001LtE-0uie;
	Tue, 26 May 2026 08:13:35 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRmuo-00000001Ls0-2fVc
	for kexec@lists.infradead.org;
	Tue, 26 May 2026 08:13:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 223BF42BCE;
	Tue, 26 May 2026 08:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA23F1F000E9;
	Tue, 26 May 2026 08:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779783209;
	bh=9VfrhdPCKB6wZtOv0TCXHtVXnKJzthg/PA3HN52ynpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kj7A7cr/O5YRznNGiCke31+F3QzAX30XYATNgSuqJ3tffmO/SgkbjcCfagokkQHLP
	 q5RYYTOEnvaCQvc6hUZy0k3gSYgKEfpyZM/aQMj4LBm9k3ZGsRqtxmLSegvftT51hp
	 YxARg9ouzjB1rH8ZjT2/lYwBiCMVyrvZKY4DuY5Ay9cS3PAZ1MNqe3RbAECzf6Saya
	 m4FlUgWKQUBrxxIifHvxXMNij/9flLcDRu0ytj8KQXdCQruo6x7sWwCpF/gLT8XzpB
	 nq9iWUxzU+TccGDPSQ54+4Hvx+UNjFcmUFSQwoZQ/PDoJOerPMKvzdbaCgvseWoG//
	 Yenh2M6oJWyxw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Pratyush Yadav <pratyush@kernel.org>,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] liveupdate: validate session type before performing
 operation
In-Reply-To: <177978294141.4088010.16047486364171482805.b4-ty@b4> (Mike
	Rapoport's message of "Tue, 26 May 2026 11:09:24 +0300")
References: <20260519122428.2378446-1-pratyush@kernel.org>
	<177978294141.4088010.16047486364171482805.b4-ty@b4>
Date: Tue, 26 May 2026 10:13:26 +0200
Message-ID: <2vxzldd66121.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_011330_698229_C9E78C1B 
X-CRM114-Status: GOOD (  12.18  )
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

On Tue, May 26 2026, Mike Rapoport wrote:

> From: Mike Rapoport (Microsoft) <rppt@kernel.org>
>
> On Tue, 19 May 2026 14:24:26 +0200, Pratyush Yadav wrote:
>> The sessions ioctls are not applicable to all session types. PRESERVE_FD
>> is only applicable to outgoing sessions. RETRIEVE_FD and FINISH are only
>> valid for incoming session. Calling a incoming ioctl on an outgoing
>> session is invalid and can cause file handlers to run into unexpected
>> errors.
>> 
>> For example, a user can create a (outgoing) session, preserve a memfd,
>> and then immediately do a retrieve without doing a kexec in between.
>> This would result in memfd's retrieve handler to run. The handlers
>> expects to be called from a post-kexec context, and will try to do a
>> kho_restore_vmalloc() or kho_restore_folio() to try and restore memory.
>> 
>> [...]
>
> Applied to fixes branch of liveupdate/linux.git tree, thanks!

Thanks! I will test the selftest update that Pasha suggested as a follow
up, since that will be content for liveupdate/next.

>
> [1/1] liveupdate: validate session type before performing operation
>       commit: da7f658ccc8da60d836051a7af1c53e643f4bd11
>
> tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
> branch: fixes
>
> --
> Sincerely yours,
> Mike.
>

-- 
Regards,
Pratyush Yadav

