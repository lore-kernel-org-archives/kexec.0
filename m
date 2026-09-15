Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2958EC88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uc7cO5xoe1cQZMzNgyouoEulYOfR9Lrcdm/hjSDUACk=; b=tixUPQ/+QYtk2usidQE3PAXuIv
	BryAL4p+Nci08OAMuw4srrCD7wUzBoXAnmM4cW3fwn6GVywIcndutEhVn+jDhhhcny/HHfhODUtZr
	4++WVSRSXgjAY1eR/oWtusChq6YYNVOCgjhmZE8fLRtBx2iCZ9IzmE/UJLH67xG+1yLUAok/PUpj6
	BjFZ/sKr7rtkqo84ylmO6A6DOU5tdsSNwLBHPJmexONFPMxh4+rN+x+fL/5AZpa2UJUpnFLn5TwS7
	Lfb45BT3Er0HBpgJM2dQiqE3KZM8kIBPTuDmGVkqVSQQ4ZDSwTLfAxcEu5TGzQGCQ4J9LgRwDY9pz
	NyE7RUAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6SA9-00000006TRY-3cfV;
	Tue, 15 Sep 2026 12:21:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6SA6-00000006TQO-0JHC;
	Tue, 15 Sep 2026 12:21:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8201B600D1;
	Tue, 15 Sep 2026 12:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789A61F00893;
	Tue, 15 Sep 2026 12:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474881;
	bh=Uc7cO5xoe1cQZMzNgyouoEulYOfR9Lrcdm/hjSDUACk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RifjIpqwJ9OqsSvNVf8dpgAPRIXNtpH+2TvjVYCOe9JUquNlggyFFXGJ0dnsaYmCg
	 GQ9XosyxDDx8GSMITHICVAvNL+LxNcmxvQMQP7A3d1sqIXZ9RcF7rJNLS5wAMhcPOo
	 SPow9eKiSuj2zKpRt8Cuw1b4X6SN6EeInZhqMldrk5L5hldvpE4fVZKWhOZYYZiNwJ
	 uht3jZCMYXSw+Eavv2okVbNxYC6NRCTmed+SaIPKeRXggq0abWEv5pETdDXtyZFTxL
	 +PtN1edDe9OuMct6IEevtSb0WL7MUHUyK38VC8DLpI0Q9G8uZMCxYp4zSbGdcMEgO3
	 kB54THZRs52CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 46/50] xen/gntdev-dmabuf: stop putting the
 descriptor back on failure
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-gpio@vger.kernel.org, bpf@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, "Jann
 Horn" <jannh@google.com>, linux-mm@kvack.org, linux-openrisc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, sparclinux@vger.kernel.org, kvm@vger.kernel.org, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, dri-devel@lists.freedesktop.org, "Peter
 Zijlstra" <peterz@infradead.org>, io-uring@vger.kernel.org, "David Airlie" <airlied@redhat.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-m68k@lists.linux-m68k.org, linux-arm-kernel@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-um@lists.infradead.org, linux-sh@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org, linux-snps-arc@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, kexec@lists.infradead.org, linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-csky@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-46-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-46-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:21:19 +0000
Message-Id: <20260915122119.789A61F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D46


