Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD027F34C49
	for <kexec@archiver.kernel.org>; Mon, 13 Apr 2026 13:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7sk8B83D/FDsvvlgwlqt0y1/UxLLINWzrbisbERlF/A=; b=dm9AJ7dKH+VrqIQbiD7PgfjKyH
	iN2Cb1bo4ckeFMVC7HVVfcK6TgXI1eLR26GCtopARLgK1zt/zjmezTrduXVOXliRq0GwNIv+Ov1W/
	m5sWdEfXKpcG5TOH2AbdC5Polb8UDm5wEpevddbohPt1gXfpu+ecLWg7ztG0nC63nd81LIy5TsTH7
	Q5l5hGkrMIBK9NzXqll0GeHbFW6ZuDBN8LjTcVcC1qvZ0JVLVaSp2G1j4dkqeKIj83bX5+EpVfL/w
	+C7PfwNMLctqiTjoA1D19TLBW4Yk+MBYUIAQiXdt5DI62jHyEh8CcnzqzyGAZKcYUbleXP1PISyYk
	BWivz9wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCH5c-0000000FiaC-2zri;
	Mon, 13 Apr 2026 13:12:32 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCH5V-0000000FiZc-3YhM
	for kexec@lists.infradead.org;
	Mon, 13 Apr 2026 13:12:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CA728409D7;
	Mon, 13 Apr 2026 13:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A980C2BCAF;
	Mon, 13 Apr 2026 13:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776085944;
	bh=UHZFVzdoCXmQFRk9A/R0zhGTxhJDLka4M03QOaOa4UM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aKnUFuClJm5nwOF+zkveF8qfYQ7Ffsj/x2C9dffwv6qelVzIk1T3nOBpfVSceyx5L
	 wg6hLxRqIP0o+j6c+E9iAlGLwuOkghGx5M8JTgc3p0dMl/p9xhM6PFZCIfQHzEIfDa
	 Tp+3rjWZB9cVV85FvM9CApAW43XsByMcfmYez91QaOMpeQEEmb3IOdZaUVSs+iE5KN
	 FIuNfYTfC7MkhbgVD5rjTwwBHYHSO1TksOhJa1QUqepCvRqz6d6jPc2BPfYo9j6SYP
	 0l8bwCikVLUh7yhf8Vb6QK8vf8LDr8O+g/gd9Y7S+dTxHPiCuCi0QsGqsSsBIVtMVj
	 fJWrzfLGuJa/A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  kernel-team@meta.com,
  stable@vger.kernel.org
Subject: Re: [PATCH v2] kho: fix error handling in kho_add_subtree()
In-Reply-To: <20260410-kho_fix_send-v2-1-1b4debf7ee08@debian.org> (Breno
	Leitao's message of "Fri, 10 Apr 2026 02:03:03 -0700")
References: <20260410-kho_fix_send-v2-1-1b4debf7ee08@debian.org>
Date: Mon, 13 Apr 2026 13:12:20 +0000
Message-ID: <2vxzy0ir80nf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260413_061225_929887_CB74D48E 
X-CRM114-Status: GOOD (  17.70  )
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

On Fri, Apr 10 2026, Breno Leitao wrote:

> Fix two error handling issues in kho_add_subtree(), where it doesn't
> handle the error path correctly.
>
> 1. If fdt_setprop() fails after the subnode has been created, the
>    subnode is not removed. This leaves an incomplete node in the FDT
>    (missing "preserved-data" or "blob-size" properties).
>
> 2. The fdt_setprop() return value (an FDT error code) is stored
>    directly in err and returned to the caller, which expects -errno.
>
> Fix both by storing fdt_setprop() results in fdt_err, jumping to a new
> out_del_node label that removes the subnode on failure, and only setting
> err =3D 0 on the success path, otherwise returning -ENOMEM (instead of
> FDT_ERR_ errors that would come from fdt_setprop).
>
> No user-visible changes. This patch fixes error handling in the KHO
> (Kexec HandOver) subsystem, which is used to preserve data across kexec
> reboots. The fix only affects a rare failure path during kexec
> preparation =E2=80=94 specifically when the kernel runs out of space in t=
he
> Flattened Device Tree buffer while registering preserved memory regions.
>
> In the unlikely event that this error path was triggered, the old code
> would leave a malformed node in the device tree and return an incorrect
> error code to the calling subsystem, which could lead to confusing log
> messages or incorrect recovery decisions. With this fix, the incomplete
> node is properly cleaned up and the appropriate errno value is
> propagated, this error code is not returned to the user.
>
> Cc: stable@vger.kernel.org
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

--=20
Regards,
Pratyush Yadav

