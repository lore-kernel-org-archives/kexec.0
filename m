Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0BBC88E72
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 16:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j35S9BqjED3DXK80YNuG2xcjHjQkfgWTqarprSit8bs=; b=hZbPIDd2o3BE0qwgHd5rXRy8p7
	DGw8M/ohsQoPqmTZyPtQPHO2OoBi8W+kWawXw52VOD+NaYftD7PWKmhTUxHB35tZq+u6nnX8H9jgG
	csD7Vg9AQqnJifDcAGQzvba/NwSLD9YDCCyeX/iDu3iIw4JDq+qQxqatnfaVhSohJGrpzl90DP4T2
	twBY262UJvVzvCBYwHgSeQ9bKqAkh3jR1d/XGhMc1RCOHkVY8L+3DPGhdzWoCcC2L/ev4ze4pjoPQ
	BOq6e4ENoxs02Ocv2hMd4iAHL62Qo22KcLhXCWWx68twFHTpBu3xvgwfSaXuEYkPBlo73HWVcc/+l
	jZFtj+7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FE8-0000000ByV1-0WcP;
	Thu, 17 Sep 2026 16:44:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FE6-0000000ByUe-0aPK
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 16:44:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E04CB41FA5;
	Thu, 17 Sep 2026 16:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74B31F000FF;
	Thu, 17 Sep 2026 16:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663485;
	bh=j35S9BqjED3DXK80YNuG2xcjHjQkfgWTqarprSit8bs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DEgVBFWjGVZOuLmeBpsF64cigsQnYZicpnGPLYOtmGhG5RViws6klzpRD6+GxaFlv
	 o7gvGsbSDyCHUNMNN4oB/RRWEW10DKtDX906ysd3WYqCUuWYmFCwUY0UwErGsZOs22
	 ztLnQgueG4omPERZB+NC2z3k/uur2NPCvwY5D8z9h01gm86r9YReC99Nox7g/4ksVu
	 Jv8spXAwPNiRnuZyStNONeOsDXVonnsHLl7Gbp0kZPI12pXtwheSSmEo6Im0wl18N6
	 rWW7OLjnWL2gI4JlzEmuHGKMmM74grpPQ7QpljD919D9pXYiU2qgipBYbkzvy6DgO3
	 sxku3oVoVVuAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] PCI: Link a virtual function to its physical
 function
To: driver-core@lists.linux.dev, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "David
 Jeffery" <djeffery@redhat.com>, "Danilo Krummrich" <dakr@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>
Cc: "Bjorn Helgaas" <helgaas@kernel.org>, Maurizio <mlombard@redhat.com>, kexec@lists.infradead.org, "Ewan
 Milne" <emilne@redhat.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, "John
 Meneghini" <jmeneghi@redhat.com>, linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, "Bjorn
 Helgaas" <bhelgaas@google.com>, "John Garry" <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org, "Bart
 Van Assche" <bvanassche@acm.org>, "Tarun Sahu" <tarunsahu@google.com>, "Jeremy
 Allison" <jallison@ciq.com>, "Stuart Hayes" <stuart.w.hayes@gmail.com>, "Laurence
 Oberman" <loberman@redhat.com>, "Pasha Tatashin" <tatashin@google.com>
In-Reply-To: <20260917163744.191748-8-djeffery@redhat.com>
References: <20260917163744.191748-1-djeffery@redhat.com>
 <20260917163744.191748-8-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:44:44 +0000
Message-Id: <20260917164444.B74B31F000FF@smtp.kernel.org>
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

> With a PCI virtual function having the same bus for its parent
> as the physical function it is associated with, there is no
> explicit dependency between the two in the device tree. With
> async shutdown, this can result in the PF being shutdown before the
> VF has an opportunity to shutdown.
>=20
> Link the VF as a consumer of the PF to note its dependency and
> ensure clean shutdown ordering.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917163744.1917=
48-1-djeffery@redhat.com?part=3D7


