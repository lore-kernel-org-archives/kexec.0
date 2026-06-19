Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1753FCDB466
	for <kexec@archiver.kernel.org>; Fri, 19 Jun 2026 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ipm4VnnCUVKjt+hErgryje+qavsLSdr26B/MMNK2kNQ=; b=VxD8OW+GIbGJY5hKJ8+wepl2MK
	L5QPlPIWKFl1vAMNdICko3DG54m0doEUmr1h+XCb+ZG6Le423MBS7jn9t+tM9wWNwwSJhshOrmFvA
	VwD+Rpfg9KnQ2fKbHGUgIQWz61DkEaXqLiIVx7G0BWe5xknfqN7PgY1K952oC51H9xoBFDQ20zds9
	o08mtBC+9u0ANMs+uFOkwohj52n99MtYauoioxCcTS1vqeuTj2TOclVUF6G7yxzNZ678KVS2bpr6c
	AtIYyt1FTT+w+vOpiJVtRIsL8qCSlTKbP1oUwCi5c926iHsqhKNhtnTRv9GQBs2WUBLpJbTgAsB6M
	A3G98Nqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waZwY-00000002Y7l-48XO;
	Fri, 19 Jun 2026 14:11:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waZwW-00000002Y68-2BHY
	for kexec@lists.infradead.org;
	Fri, 19 Jun 2026 14:11:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E30246020A;
	Fri, 19 Jun 2026 14:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4A31F00ACA;
	Fri, 19 Jun 2026 14:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781878295;
	bh=Ipm4VnnCUVKjt+hErgryje+qavsLSdr26B/MMNK2kNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=L+HldSM1+o+tWkDbIG8K43jsuVzgtp7NdNSEk+Jfu5jaNR8rxpCcgZQ1MW+aX0c84
	 ouXIbhwhAm5lGTM1WmZActEB2i26IaKhRotfbVrV6y7ZtrJFbUSh8fyun8qtAftWem
	 /zWPuOMsg5zELZf+0Ns/LUncVu87F4uUCHkmHWFSedkUVNDkXLW3w30OT/4k/nxMx0
	 uWnROWM2Wa1zp5kmF86bOyH8vgVmiXn6lepY2aJlhkfkhLCJpu9AT1MjcbTcVQZ66u
	 5ZOTyvO9Gx5ZSwSrtrL8e8MfzACbVoRLnAmhuTcrUtEsF94lZ7t3KEtMpEPmkIrYne
	 G74ICyfzZFn2A==
From: Pratyush Yadav <pratyush@kernel.org>
To: tarunsahu@google.com
Cc: Alexander Graf <graf@amazon.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Mike Rapoport <rppt@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  kexec@lists.infradead.org
Subject: Re: [PATCH v2 0/2] luo: migrate serialized_data to type-safe KHO
 pointers
In-Reply-To: <9huzv7beloza.fsf@tarunix.c.googlers.com> (tarunsahu@google.com's
	message of "Fri, 19 Jun 2026 12:00:09 +0000")
References: <cover.1781615759.git.tarunsahu@google.com>
	<9huzv7beloza.fsf@tarunix.c.googlers.com>
Date: Fri, 19 Jun 2026 16:11:32 +0200
Message-ID: <2vxzmrwqoc17.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Jun 19 2026, tarunsahu@google.com wrote:

> +Mike, +Pasha
>
> This is currently rebased on top of mailine, also can be applied to
> liveupdate/fixes with no conflict. I would like to know which release
> cycle we are targeting for this, so That I can rebase it accordingly?
>
> As for liveupdate/next, it needs some conlfict resolution.

Base it on liveupdate/next after the merge window. Since nothing is
actively broken (as far as I can tell), I don't think we should take it
via fixes. We should do it via the 7.3 merge window.

>
> Tarun Sahu <tarunsahu@google.com> writes:
>
>> Covvert raw serialized_data to KHO serializeable pointer (KHOSER_PTR).
>> This series also takes care of resolving the bug with memfd of using
>> phys_to_virt before checking the args->serialized_data value.
[...]

-- 
Regards,
Pratyush Yadav

