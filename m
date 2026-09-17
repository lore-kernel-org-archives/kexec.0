Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE420C982D2
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 16:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LAxtjYEua4plusINVTHcMgxVKXWmoP1/pA9iq8tgzLI=; b=0bHv6NnAwzJhvH2g3FKorf+2Zi
	TYbmuOLdOlQALB5AYrur/KBvRELHrN2vwQ4O5f/iqESX/GaJrCLetyJorFjPhlm+zvFyBK+JScnwb
	K9AeW5P6LSqcDwEuYNF1ccRtY+OnlNBNl507aASHyyFm7t+SBJnbAVvxWjYD2zULBKGI6I5sE9gyr
	T3iFWW/QbeMGuODSZnE808NnX0Jn3ZkhqwY51AmHGXv9YVd0Jq9/v7N8D3Yk0CscvzjvX1vKnzDFk
	wO00laCR9XYwjUGp+8J0O5H1OTKpZhqYANQJOpI4JSNcc5qC4hBKpynTBzZ+AR/locsBx0Ctjicld
	tOFLvkxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FHB-0000000BzIp-2ZPH;
	Thu, 17 Sep 2026 16:47:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FHB-0000000BzIU-06N1
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 16:47:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 782E7601F1;
	Thu, 17 Sep 2026 16:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3566C1F00893;
	Thu, 17 Sep 2026 16:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663676;
	bh=LAxtjYEua4plusINVTHcMgxVKXWmoP1/pA9iq8tgzLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nTitcEIWbzlk+odPQnUeF0nJT6d5yWSXoqf8KNtrfF7Wtkxu5OSj8RUQdw61PuRgp
	 IGYQ3h+rYgG17SJbxNWCOVMhLGJUdCuxI8FuU0Vt5UQO22rxZJxgBBZCVxJmFhlT5r
	 cxi7DBGLJv681mS5YesTDO5zvdKjf2SB9C4Ez8p7h5uJ2KAeyAnFWEXhypXXy4rQeh
	 GaMUcctlOEyWUpd/EfPmiQX5fVrEKaNY8ChfrNau4xL1n1BKYiLbw7YCGSslZK1556
	 z0np5252lOVT/84rVd2yStnO8p0SomjB87tVT1h2TIoc+0sjjMseKtgdyB4MxwLWBe
	 8HQcdSOR/zT/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] driver core: warn should device_move try to move a
 need_parent_lock device
To: "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "David Jeffery" <djeffery@redhat.com>, driver-core@lists.linux.dev
Cc: linux-pci@vger.kernel.org, "Stuart Hayes" <stuart.w.hayes@gmail.com>, "Laurence
 Oberman" <loberman@redhat.com>, "John Meneghini" <jmeneghi@redhat.com>, "Martin
 K . Petersen" <martin.petersen@oracle.com>, "Pasha Tatashin" <tatashin@google.com>, "Ewan
 Milne" <emilne@redhat.com>, "John Garry" <john.g.garry@oracle.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "Tarun Sahu" <tarunsahu@google.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Maurizio <mlombard@redhat.com>, "Jeremy
 Allison" <jallison@ciq.com>, linux-scsi@vger.kernel.org, "Bjorn Helgaas" <helgaas@kernel.org>
In-Reply-To: <20260917163744.191748-4-djeffery@redhat.com>
References: <20260917163744.191748-1-djeffery@redhat.com>
 <20260917163744.191748-4-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:47:54 +0000
Message-Id: <20260917164755.3566C1F00893@smtp.kernel.org>
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

> Currently, no device has need_parent_lock set and is moved by
> device_move. need_parent_lock is only set by the usb bus and very
> few device types ever use device_move.
>=20
> Add a warning to device_move to catch should it ever be used on a
> device with need_parent_lock set. The combination would break
> the immutable relationship needed between parent and child for
> need_parent_lock when locking and unlocking both.
>=20
> Suggested-by: Tarun Sahu <tarunsahu@google.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917163744.1917=
48-1-djeffery@redhat.com?part=3D3


