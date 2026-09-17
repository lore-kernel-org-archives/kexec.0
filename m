Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9733C982D2
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 16:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n/b+TkHJhF+tCoFn9I9g+htfnz1uHmfohwh9wRCjPDU=; b=jlPQ+zAYJtW3M13Lrygy/WhSFX
	tKHLY6MzbHivw5Jpga7EOEmvRGe7WLerUB9IaFxZMelqC7qH1ahWt1U0+KbRhF0GvdmHsV6HS+DUJ
	iLeHgfYJgykYtraRAqthTU0KeQbXI8YHX5W07SJ0To5cWVPGkjCFGhx27ECoN9NUPXIg6QCuh35H6
	U32VCI8DM1rAKfHvEK53+WGlIXqxLMRXbSgUsQff887QYc2ZhigvJBQpwPWc6v1vjaI5TXK7nh+i2
	DCZQPnHh1v0dCnsg6x4OsWe/dm3H1BUsrmOoNRngbO1R8ptAuDU/NVbzCs3nBFa3nl+LO1EcR8izb
	gYxRqQaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FR1-0000000C1AI-3I1E;
	Thu, 17 Sep 2026 16:58:07 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FR0-0000000C19u-0n36
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 16:58:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D4552419DC;
	Thu, 17 Sep 2026 16:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6C01F000FF;
	Thu, 17 Sep 2026 16:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789664285;
	bh=n/b+TkHJhF+tCoFn9I9g+htfnz1uHmfohwh9wRCjPDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LL3uY2524Sa23BQKAZLTNnfnFot4uLjZ4uvBbirjVjjGk6jvoEslDoe90Zfl2Z4oz
	 r3HoF8YbbXcYyZcXZKR+YK4LzaCjxIe7dVMGSFw37/fHX4JBnKm7P8DPHoSpiOpsvo
	 isPW2pwpOmiJbXT/QCPUmNgKs8fjWnlGFeru8TF3k2J49KiGaOn3Lzdcr2xEundrs8
	 PgxomivVexSRDZKME60JtVvbTZklN4Q8RQ9KcBQ1N94zA/V8KMc9C1BIiK7fjSX/tO
	 qoHVwMcO2KdJJGjU0OQOOnOZ8TMSSi9ELp0vqg0FOFnghhPH4BME9lFeOjE5KNYHIx
	 PPVKDB/J8eo5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] scsi: Enable async shutdown support
To: "David Jeffery" <djeffery@redhat.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, driver-core@lists.linux.dev
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, "John Garry" <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org, "John
 Meneghini" <jmeneghi@redhat.com>, Maurizio <mlombard@redhat.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, "Jeremy Allison" <jallison@ciq.com>, linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, "Laurence
 Oberman" <loberman@redhat.com>, "Stuart Hayes" <stuart.w.hayes@gmail.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "Pasha Tatashin" <tatashin@google.com>, kexec@lists.infradead.org, "Ewan
 Milne" <emilne@redhat.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Tarun
 Sahu" <tarunsahu@google.com>
In-Reply-To: <20260917163744.191748-10-djeffery@redhat.com>
References: <20260917163744.191748-1-djeffery@redhat.com>
 <20260917163744.191748-10-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:58:04 +0000
Message-Id: <20260917165804.AF6C01F000FF@smtp.kernel.org>
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

> Like scsi's async suspend support, allow scsi devices to be shut down
> asynchronously to reduce system shutdown time.
>=20
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917163744.1917=
48-1-djeffery@redhat.com?part=3D9


