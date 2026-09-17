Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11747C982D2
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 16:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nwZX7LWzQDsEEXIexefLINRItEhTA6HQK2X5rc/lUKI=; b=LOc1D1JKbaTEU6ija4KrUsACE9
	XMnFDYjtUJtAgzJZOqxh1xerBGcdn6FqauwvnVeTxnv2+JUXk9FlFklQvSKMJqPh/mllpAvpef/UW
	8izxAULtAKnKQEsPUeWm9ZLTJ7JFfruWKUJBjAu+WQi+vfpBdHpNEBDTDPwfiGLQAEwC8UXNKS6jR
	A7TH3nx9osazdqL8EMRt5+GN/TCZm8PrkFoUaY/wPuGNmrQ63FetstbXS2bgOgVb4UhL6ZjqNMNKN
	Dzmk1uHh4OuwXLc/7g80cW8yBBffgPxmw/bBguUAHBzfjNIacak3fbsMAId0I/W+sc8LXG6aRI4Z7
	khVqID+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FGJ-0000000Bz1V-0x1b;
	Thu, 17 Sep 2026 16:47:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FGH-0000000Bz17-3Gi1
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 16:47:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 858614183E;
	Thu, 17 Sep 2026 16:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6852F1F00893;
	Thu, 17 Sep 2026 16:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663621;
	bh=nwZX7LWzQDsEEXIexefLINRItEhTA6HQK2X5rc/lUKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jO4cnVCXs6364LMIAKfAUTkkpQ/ZJl4eupKU4kZxpG5EKTCoUC0n96E5Ode5UKXAL
	 qSCPRJQPgpDOHFpl6f53lvAjtGv/wzvYrggEbT5zfed2dDbegqNMwEjjkgyhyrJOhP
	 GJGIjxddTA/sk1yMtpOsl9nVXjFL6+0oMbEYZiLUThqzOU5dOpoejybO3ODUPWscJf
	 dIQXhGFLTxAPpmSsa4njcyf1F/cusnb0PdLrNWlO6SuTWklUqIBJMHuL9icZsn2Kvn
	 MRDOOr/CCGLOMWlEUMWUcVIrf4txmj/rOIv1PzYiXfLp+/1mK1635wy/6ekuxTGpCG
	 deSL9crvUHy0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] driver core: do not always lock parent in shutdown
To: "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "David
 Jeffery" <djeffery@redhat.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, driver-core@lists.linux.dev
Cc: "Laurence Oberman" <loberman@redhat.com>, "John Garry" <john.g.garry@oracle.com>, linux-pci@vger.kernel.org, "Stuart
 Hayes" <stuart.w.hayes@gmail.com>, "Jeremy Allison" <jallison@ciq.com>, "Martin
 K . Petersen" <martin.petersen@oracle.com>, "Bjorn Helgaas" <helgaas@kernel.org>, linux-scsi@vger.kernel.org, kexec@lists.infradead.org, "Ewan
 Milne" <emilne@redhat.com>, "John Meneghini" <jmeneghi@redhat.com>, Maurizio <mlombard@redhat.com>, "Pasha
 Tatashin" <tatashin@google.com>, "Bart Van Assche" <bvanassche@acm.org>, linux-kernel@vger.kernel.org, "Tarun
 Sahu" <tarunsahu@google.com>
In-Reply-To: <20260917163744.191748-6-djeffery@redhat.com>
References: <20260917163744.191748-1-djeffery@redhat.com>
 <20260917163744.191748-6-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:46:59 +0000
Message-Id: <20260917164700.6852F1F00893@smtp.kernel.org>
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

> Don't lock a parent device unless it is needed in device_shutdown. This
> is in preparation for making device shutdown asynchronous, when it will
> be needed to allow children of a common parent to shut down
> simultaneously.
>=20
> And only acquire a reference to the parent device if the parent is to be
> locked.
>=20
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917163744.1917=
48-1-djeffery@redhat.com?part=3D5


