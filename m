Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC59CD5BD1
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	To:Cc:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CQQ3fHPI7z0+oYhhy2SS2++wUzwKs9NFKfTFjo35QFE=; b=1l1a0fXcD5ERFD+XqCah/A4UXZ
	ECq32HShFeJn5JFw0xPNjwFllVey0yUhJcAIAoQBnQf9wxFQa1XZYskLyhkmRhk46czKkQteX1JSX
	Gij76W8oLFFmHKj5J9NLddmSkL7jlajfKjftzCxgxggFBcnQnC6OvfOJBQbLDwtj7R4S7dD1sbu03
	YUnMIv9zA/oAQMLdNRXAvgTJ1ti823G64unxnQ3A/EiIRY2Qt89UPifQcd844NFrO7e965yil6r1+
	C/4xDjSSxwKMVehDKSCIr3J/7FXer2+zyxq0VSQvYCB9L/c484sgvPrnkZ1a9KK2ZYUlxS3db08By
	3J6jFAGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU4HG-0000000BLsh-37ub;
	Mon, 01 Jun 2026 15:10:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU4HF-0000000BLsR-3V8H
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 15:10:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 48FBF601E4;
	Mon,  1 Jun 2026 15:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74AC1F00898;
	Mon,  1 Jun 2026 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780326605;
	bh=CQQ3fHPI7z0+oYhhy2SS2++wUzwKs9NFKfTFjo35QFE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=H6GKp/dzqdK9ORxjj0B40gPyyI+Oji2zXc3Le5Sabsl/dFTi0wga5rdS2Kf9sYveJ
	 XADB9m10hTqyRD5XENfhigGHA6xbgGDk5NPtM7BRolacY8BQaIOlaU446uf7Dmi2zl
	 hmTmsBeVFgywVd9Y3U6r51xN20vw8Ze9xskMuxrAa47Xae4rrZ8vgH4MN2CEybz50K
	 t0WarlKSDJf6hW39j5PwA/N/G5xNTmutyB0YQ00tyPqnfT86uMY8B+GdTphTkwt7P2
	 LdEJxogDT4R4mCI3zNbccAbuKOvpgTUNEVxQ8s0MVQxcsYAv5scNpsLLfUgtDOeX68
	 YjwLO0KryJm/Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 17:09:59 +0200
Message-Id: <DIXT3WV9XAWK.3E0JOPV2K6NC1@kernel.org>
Subject: Re: [PATCH v16 0/5] shut down devices asynchronously
Cc: <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <linux-scsi@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <tatashin@google.com>, =?utf-8?q?Micha=C5=82_C=C5=82api=C5=84ski?=
 <mclapinski@google.com>, "Jordan Richards" <jordanrichards@google.com>,
 "Ewan Milne" <emilne@redhat.com>, "John Meneghini" <jmeneghi@redhat.com>,
 "Lombardi, Maurizio" <mlombard@redhat.com>, "Stuart Hayes"
 <stuart.w.hayes@gmail.com>, "Laurence Oberman" <loberman@redhat.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "Bjorn Helgaas" <helgaas@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, "John Garry"
 <john.g.garry@oracle.com>, <kexec@lists.infradead.org>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>
To: "David Jeffery" <djeffery@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260518193204.14273-1-djeffery@redhat.com>
In-Reply-To: <20260518193204.14273-1-djeffery@redhat.com>
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

On Mon May 18, 2026 at 9:31 PM CEST, David Jeffery wrote:
> These patches are now rebased against the driver-core tree's driver-core-=
next
> branch.

[...]

> Changes from V15:
>
> The async_shutdown bit field is converted to a device flags bit Convert a=
ll
> patches to use the flag bit accessor macros to set or check if async shut=
down
> should be used Added documentation on the kernel parameter to control use=
 of
> async shutdown

Did you have a look at the Sashiko report from v15 [1]? Some of the concern=
s
raised seem valid at a quick glance.

(It seems that this version has not been picked up by Sashiko (despite you
mentioning they are based on driver-core-next). I'd assume it doesn't like =
that
the series was not sent with '--base'.)

Can you have a look at [1] please?

Thanks,
Danilo

[1] https://sashiko.dev/#/patchset/20260429175016.7915-1-djeffery%40redhat.=
com

> Stuart Hayes (2):
>   driver core: separate function to shutdown one device
>   driver core: do not always lock parent in shutdown
>
> David Jeffery (3):
>   driver core: async device shutdown infrastructure
>   PCI: Enable async shutdown support
>   scsi: Enable async shutdown support

Not sure it will make it for 7.2, but I think it would be good to give this=
 some
more time in linux-next anyways.

Bjorn, James, Martin:

Should the PCI and scsi patch go through the driver-core tree too?

Do you prefer a signed tag with the driver-core changes to merge into the P=
CI
and scsi trees?

