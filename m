Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6CA606A325
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aYYbkMgu;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTvG7bDa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2NZpyB9t623uL5dQnZ6f8f6YXap/qWRuUhL4dHrhvis=; b=aYYbkMguFWvVUQi51IsM9+GtG8
	+TV7p7tt1wZxc/Bu/iyQCsMas3ME5te2AuVM8RmpwW1weAsSHYTe24jkwmqP5UbHLSVP9Te52JK8C
	sPitplmbY7aZ05A2nEMvKLLULWG9Y04+v58+ROqpeeUV4Jqj74dc0o/FTkitOde6nnLM8SJM4PU+5
	gcJ5h7c2ke/18LMk6FViGjDhImac6G48vxPXgOR4oBfs/Nx1i4KCQBiG1G6D7KQ0ouI7aEie09Pm+
	JsvHfTY2jIC/2zOs6s0Xb9b2jeHK237WqgtMY6+qXMJFS719pD0UBOb+2yOVIF0Lh4LQ1DiqisfpP
	ZJEz1X0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnKE-0000000AKuY-2rag;
	Wed, 18 Nov 2026 21:36:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnKD-0000000AKu9-1XXd
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:36:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7472D63E9F;
	Wed, 18 Nov 2026 21:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A814A1F000C4;
	Wed, 18 Nov 2026 21:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795037776;
	bh=2NZpyB9t623uL5dQnZ6f8f6YXap/qWRuUhL4dHrhvis=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oTvG7bDarH80o08w0pjmEq8w7w/7bqdlpOmB9OretpMHfktc3RxX6YGYOBV2xkvNA
	 QP6mqlwCEiU2CVWjMxEwO4jW6F8uNS9muGJqyRfSFxk75aSVFx27bAszOVGs+YSjxN
	 J6tlfaHdfMNX6OT6W6l69wgLTPiCRBUyKVl1vEJIE/8tyr3cqAHOAil+0/404FdGnp
	 /GGFWM1wGhejw5gFAaBJJDmlQiQsha5Y6jCCGlJ62E9h/9+OUUFx5FL3Kp0Pj/LZba
	 g1ujTOqyqES5IBZXLKzCAJxkj9Sy2I0g5f/uIjEwfWeNP4+F6xsmOQZgq93gC3VyNx
	 X00P7znVRAWTA==
Message-ID: <sashiko-outbox-222013@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/7] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
 to freeze sessions early
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, vipinsh@google.com, corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, graf@amazon.com
In-Reply-To: <20261118212845.2855249-6-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
 <20261118212845.2855249-6-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:36:15 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Add the LIVEUPDATE_SESSION_FREEZE ioctl on outgoing session FDs. Once
> frozen, no additional files can be preserved in the session and
> repeated freeze calls return -EBUSY.
>=20
> Currently, LUO freezes sessions only during reboot(LINUX_REBOOT_CMD_KEXEC=
),
> serially under global write locks. On hosts running multiple workloads
> such as VMs, freezing sessions early under their per-session mutexes
> lets workloads freeze in parallel as they pause ahead of kexec,
> reducing blackout time.
>=20
> By default, session lifetime remains tied to the session FD: closing
> the FD before reboot unfreezes and unpreserves the session, while
> keeping it open skips late auto-freeze at kexec.
>=20
> Add optional flag LIVEUPDATE_SESSION_FREEZE_COMMIT to serialize the
> frozen session and its FLBs immediately and transfer ownership to LUO
> until reboot. Committed sessions survive closing the session FD,
> allowing processes to hand off preserved state and exit prior to kexec.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118212845.2855=
249-1-pasha.tatashin@soleen.com?part=3D5


