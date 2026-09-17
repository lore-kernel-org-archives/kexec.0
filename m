Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C55C88E72
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+/6dP/tc8y91FwlyDopq/x0v1dZoVJ2RxSzY2tr973M=; b=o0m7M4al0rngGQ5EKoC5JJOgl5
	havMZP+svhbSddaX2sdDcYghNIhn0iFbd8imoo+yMNF8lMR6kY3tzDLw3z/9K0RFotoKSS64BL915
	PK6G+fVfdlAjCEON3AajRwvwE2f8UyvycqqhTQUvjQR6z/F2OGZ9yFbSN6Z4QEGrdsZwAOjrFwr6J
	4ScVTmqgpT56rS52M3uvNdcF4amFiJlpZB+0bQTPEUJt0A3JAlo/InGdLiH3petJzYKzzLOZaZ6qc
	AKDTIQSW7yOPhnk4OVu6h4MxIihP/0G89iwpTalRri3fiMSpA96YbTJSOVOVl2M1TiIJSaxEQr3un
	j3QAGkzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FFX-0000000Byn4-3GmV;
	Thu, 17 Sep 2026 16:46:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FFW-0000000Bymq-3wdY
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 16:46:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4112A601EF;
	Thu, 17 Sep 2026 16:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15051F000FF;
	Thu, 17 Sep 2026 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663574;
	bh=+/6dP/tc8y91FwlyDopq/x0v1dZoVJ2RxSzY2tr973M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hfVPjIK7tdl76eXtbjTQGTByiYpiKtjOZ6BvEqbmvXBTGbJO2wpOdjEdk69c8Avt9
	 Mi60UA6VEUd7EbQiCHt5nRLC+zEg8F1xoTkBVZu6cxKM+IZx6xbWZs2Pz4aQSthlLX
	 W8Gqbidtg4ALKChnqHSlg9da3YTAH/nB/b07zJTRpstCBoqRv5xpqKQ4Vsa4QUWq7q
	 HxZcvy9q7GwEmpZLmeLJCPryqOPmSINbThzAV37FRTinsmnEK8Phod2aLwS5+dl0ql
	 Zs55RiqrqjYRIf2ZVE3BFFWmxCJIFsAmRhkO4pt15XargE2NVzzzQ6mpfzZUV1pmjV
	 b+MSXv1sctw8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] driver core: prevent device_add() during system
 shutdown
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Danilo Krummrich" <dakr@kernel.org>, driver-core@lists.linux.dev, "Rafael
 J. Wysocki" <rafael@kernel.org>, "David Jeffery" <djeffery@redhat.com>
Cc: linux-pci@vger.kernel.org, "Pasha Tatashin" <tatashin@google.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, "John Meneghini" <jmeneghi@redhat.com>, linux-scsi@vger.kernel.org, "John
 Garry" <john.g.garry@oracle.com>, Maurizio <mlombard@redhat.com>, "Jeremy
 Allison" <jallison@ciq.com>, linux-kernel@vger.kernel.org, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "Stuart Hayes" <stuart.w.hayes@gmail.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "Ewan Milne" <emilne@redhat.com>, "Tarun
 Sahu" <tarunsahu@google.com>, kexec@lists.infradead.org, "Laurence Oberman" <loberman@redhat.com>
In-Reply-To: <20260917163744.191748-3-djeffery@redhat.com>
References: <20260917163744.191748-1-djeffery@redhat.com>
 <20260917163744.191748-3-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:46:12 +0000
Message-Id: <20260917164612.F15051F000FF@smtp.kernel.org>
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

> From: Tarun Sahu <tarunsahu@google.com>
>=20
> In Async device shutdown, device_kset->list lock is released to handle
> asynchronisation and hold again to get entry from device_kset->list.
> Which will leave window when device_add can try to add the device to
> device_kset list and temper with ongoing shutdown process. New added
> device can be async type or sync type and might also introduce new
> dependency which can cause device_shutdown path to deadlock. S is
> waiting C to finish but C is never scheduled as it was added recently
> from device_add path. And C can only be scheduled when main loops
> continue to reach to C which is waiting on S.
>=20
> So, When a system enters shutdown (SYSTEM_HALT, SYSTEM_POWER_OFF, or
> SYSTEM_RESTART), new devices should not be allowed to be added.
> Adding system_state check (system_is_shutting_down()) to avoid
> device_add incase of these states of the system. And use srcu so the
> device shutdown operation can synchronize device_add and ensure any
> device_add in progress is finished.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917163744.1917=
48-1-djeffery@redhat.com?part=3D2


