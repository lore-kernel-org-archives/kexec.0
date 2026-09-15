Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80646C88E7F
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zv1rNZvSCHkzISCnzIgvhR1XdclekSPPoj8rLv8Qezg=; b=1XX+ye39ssv011f2p7GUeDe7am
	6y4Ths7QQovsBiTm+lDLoVtRg3fV+CuK9xLj019qJvWTCHiAvJR6fp6ybG1kz9ipe6fDDbSgdNdG2
	llKZSZsAFgrFyGcVLs3YfNl0Wg1C8N6ffd1NCNQFyEj4RKlid4qnqBElCdLW4u3UIO+cKOKV2e6xP
	g0w5rkI7aCRLHvJUtxXG+kO0N+O9XDV40wMU4LiemwEL9Juckx4Tkaq81BKvlTiVBKvAoRyWfRTV9
	oair4y4ebTy6SuJmkZJRgPNW0baH63lsdMtfI3oRbvb+Px5wBvbtUXmmyqJh/GBmodb09d0mzr6yf
	rXZ3tl7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Ryy-00000006PDi-0CN2;
	Tue, 15 Sep 2026 12:09:52 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Ryx-00000006PD4-1h4z;
	Tue, 15 Sep 2026 12:09:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CF82C600D1;
	Tue, 15 Sep 2026 12:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464481F000FF;
	Tue, 15 Sep 2026 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474190;
	bh=zv1rNZvSCHkzISCnzIgvhR1XdclekSPPoj8rLv8Qezg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4ZZV63EloWFTnOUlHK58XwOK2rkeCsu03ufhBV72Tiipl5qWiGg8pKw75jRnalat
	 Px+Ej4QbTLpchvWen5UHVg+abfR3qMIoHWKRq5zOfC+6fvUdhpGBml50Plsl14BxoA
	 MD9L1UkPG2s8tttZuNhCrGp0Ac838MyFzPadcw7MIZBEqZ9CQQXdlYMZFCITTIwQVR
	 e8ZVbA+QeVGcVPqWoOLbEKnwhY2HpmkZP6Db2SJHGUaetI9dgl3FBXgJQQpNHkGFqv
	 7oyl/HjPvr3DAOtUTzbk2i14RAaCiMZAvTqJbij4737kik3jJY1RQy1e4vJFFsF6gN
	 uDBgNLmQTLN+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 32/50] liveupdate: install the session
 descriptors when the ioctl returns
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Jan Kara" <jack@suse.cz>, linux-gpio@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, io-uring@vger.kernel.org, bpf@vger.kernel.org, linux-openrisc@vger.kernel.org, kexec@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Jann
 Horn" <jannh@google.com>, linux-hexagon@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-um@lists.infradead.org, kvm@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, virtualization@lists.linux.dev, linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRh?=
 =?utf-8?b?YmxlKQ==?= <brauner@kernel.org>, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org, linux-csky@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-32-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-32-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:09:48 +0000
Message-Id: <20260915120949.464481F000FF@smtp.kernel.org>
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

> Rely on the fd exit path machinery.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D32


