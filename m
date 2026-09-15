Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C320BC982C3
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QRMZ7mmRdl98Hr0Jzx0dLUsIBC2R/cA4CuoG4//bR+w=; b=my5fTPyn2A1KK8SQQB2ga074GD
	H5vtXBox+os3ONcdmx1bJCPFj9Jra5gqhNKKRiRHuRJCErdERKmlzWVz8lAC8CWSM9sC9eWtn3Lyb
	7FINyanKgZcUX8DX2x3DokqPHDwTyalgcHveAprbDB4zppbYiDIgAHSsMm8HA8SWshbMhzY4TWBki
	oZT+C4yF6jCn14vStCVubouEaFRpQZ9iL5PzFXJ0qkHdAAfvbqX48lxINExhk25KnPr0L9Rf7LW9c
	s0O4BItWmIsHvHoUE4ukDEK2OXCjKZtproT6kzQqS+NNY0JpuBW5OFN3XfFlIc1tw4Vam/YnRoRxs
	e64i+U+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S3x-00000006RHE-2l4E;
	Tue, 15 Sep 2026 12:15:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S3w-00000006REl-1osD;
	Tue, 15 Sep 2026 12:15:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D5277602C4;
	Tue, 15 Sep 2026 12:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD1B1F00893;
	Tue, 15 Sep 2026 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474499;
	bh=QRMZ7mmRdl98Hr0Jzx0dLUsIBC2R/cA4CuoG4//bR+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XPGWfVIhJ/wSL6Jd1KV8QYkaPXQevpxTo5YKyPKDIrxlw9MIHMHo5cZnoqRuYBPzW
	 YAB/BBxKyr04OnAz1fXuFsMiapL3vJK/RuyN3woNJu65a7GotPewX23h9YHqDCxQPk
	 2CWF6CYq7PbvZJuYpGBlpn9YbalxW+tFPh2E8PMbxAki0JSstQ2YNM5+QlpENVA4OR
	 4S8OeAn9BG92ITePDtvvACim8Vy9KB2TGUTfda+kW7PhqaNdVyqOBZvhFMBFu6IU+R
	 cXVP4LUVIrc7LmnOQ3vKo+sFLx/fVgoMs3/93rCsxZ1sqN6D06XnUMiUCyDHo1Jf2m
	 gcjyzu+b66/Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 37/50] tpm: vtpm_proxy: install the server
 descriptor when the ioctl returns
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Peter
 Zijlstra" <peterz@infradead.org>, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux.dev, bpf@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, "Eugenio Perez" <eperezma@redhat.com>, kexec@lists.infradead.org, linux-openrisc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "David Airlie" <airlied@redhat.com>, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-alpha@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-mips@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-gpio@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-arm-msm@vger.kernel.org, linux-parisc@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-37-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-37-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:14:57 +0000
Message-Id: <20260915121457.BBD1B1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D37


