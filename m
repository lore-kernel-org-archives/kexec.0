Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A22DC982D2
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uRDxUsoUx/5GBEtufJ3qz2htzusfPT9XjctbtT7XS+E=; b=qLXgtdEeRaJ4ZrwVjrGU6WXrMu
	/jQrwX4ikK4WI3xqCYqjI0EehuJYn4xUfXsxm9bnJsMA21cVeXUpIVxGiXJGPtkhfSkMUf2FgpMa8
	YXxqARpAks3xoUwJO82lfWKX5l1qmr2hAVJ5OgZeLs7RG0cTxgmMh/j3qqVn/yrVNylSkf9jexo8w
	KXYiA7YkjqWoGxVeG9Y3p5P08mhVfP5OkQ5llm0Ily0jLGuBXHB9HbPwfg+X+Wxmo9ciHUWqMRLxC
	nqLzRUaPhfaP2z0qE4qs9pnBoJuubtIW89ljJeK8e2yokyytwe7U2qnGk+yIevzSQOat3q+E35gUX
	tV83q5nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FHX-0000000BzPU-3TGT;
	Thu, 17 Sep 2026 16:48:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FHW-0000000BzPH-0mh3
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 16:48:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EB806437DD;
	Thu, 17 Sep 2026 16:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FB21F000FF;
	Thu, 17 Sep 2026 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663697;
	bh=uRDxUsoUx/5GBEtufJ3qz2htzusfPT9XjctbtT7XS+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AdhXRDWEI8z8/VqFT8f1/Zb8gNtPvn8fEU5Hht+JlautNgX0zryQ2lqimxN8UfxEM
	 exVhz313nt4ajGoS6Cr+SJ2q/6iCDF/MrmyVSWv3uygMYy8i7qXTPSiSBHYzsGlz5U
	 n9s4VQPl1TcUFUqJsRy4sSDFoBwByv+koT3x+heWDR7Jnzfc1UwKQhpc3wA3zb7kr7
	 V2T1jAlIx2NrtZp/yFgz+utPHYEQWb0/JTyXxriYCDkE8Dtq1PpZjBMpB+X3JrPMQl
	 a5V65AGxRdwYrzsy9pkUT7/bDs5yc8HtamcrvgBV4TC7jOmaPyic0LB35EskMo6WDv
	 wbjZIs9XjZrog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] PCI: Enable async shutdown support
To: "David Jeffery" <djeffery@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, driver-core@lists.linux.dev, "Danilo
 Krummrich" <dakr@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, "Laurence Oberman" <loberman@redhat.com>, linux-kernel@vger.kernel.org, Maurizio <mlombard@redhat.com>, "John
 Meneghini" <jmeneghi@redhat.com>, kexec@lists.infradead.org, "Tarun Sahu" <tarunsahu@google.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, "John Garry" <john.g.garry@oracle.com>, "Jeremy
 Allison" <jallison@ciq.com>, linux-scsi@vger.kernel.org, "Stuart Hayes" <stuart.w.hayes@gmail.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Bart Van Assche" <bvanassche@acm.org>, "Martin
 K . Petersen" <martin.petersen@oracle.com>, "Ewan Milne" <emilne@redhat.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pasha Tatashin" <tatashin@google.com>
In-Reply-To: <20260917163744.191748-9-djeffery@redhat.com>
References: <20260917163744.191748-1-djeffery@redhat.com>
 <20260917163744.191748-9-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:48:16 +0000
Message-Id: <20260917164816.B3FB21F000FF@smtp.kernel.org>
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

> Like its async suspend support, allow PCI device shutdown to be performed
> asynchronously to reduce shutdown time.
>=20
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917163744.1917=
48-1-djeffery@redhat.com?part=3D8


