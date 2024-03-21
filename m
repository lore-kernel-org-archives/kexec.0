Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64761C54E58
	for <kexec@archiver.kernel.org>; Thu, 21 Mar 2024 07:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ypraLNZ0sLIpR7Y7K7R9g+jmqE3fpxqbdKwaKQD9gCA=; b=tFBtKiA8NOjVfL
	bIDblRfw420r2rKOzFJiPowTefaSbbV7KYplJKwdUfVEs4hBQPkW4ikb5xUeeKu3evGxGRI/5zUA/
	A3g6EGPZk/rWv5gq61pQ6ddfPsoG0lmcjj/uTykTvwPfe/z/NV9urnTulHsa2citBrjbHtbBHXVdw
	kTBQTn5dQH1l/xbrMpKI5N+ubjWyHuudG6UEyRCwjMX4sUAIC3jDEh2R1qhZzzIfKsKREgmDNCGiT
	kL46gXtIiv9XzMllAAf9Gc8xUYd1PFJorjCeagvS/Aa0L6Mfmt7tUmXip9gE9ianFBLU4Fhf3MzyE
	tkDv5gj0WGTO+hDLBRDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnCt3-00000002AvZ-0YOJ;
	Thu, 21 Mar 2024 07:30:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnCt0-00000002Aux-0a2w
	for kexec@lists.infradead.org;
	Thu, 21 Mar 2024 07:30:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711006247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P7TesMlyTWG91Noskm9JFjOimxY1eogitEqOnaIXlk8=;
	b=BY4NzB6aRj0ZsKyy2Z4zRSz3GVe4qJ9gfi42NAJD6eYrLbIjniZzlsbyChP/jTA68PtKpK
	BYHt1ghWbZfvPCA2ptv5QbQrJyL1GNQ1hIy3HA323pHclP8WzyAoiolFyQdr3enjBvBqaj
	lFbug5y0KUsaoVnAucdMICXSjDK75Tw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-ndzFJlFvOcidEY1VuAe5Og-1; Thu, 21 Mar 2024 03:30:46 -0400
X-MC-Unique: ndzFJlFvOcidEY1VuAe5Og-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA0FD800264;
	Thu, 21 Mar 2024 07:30:45 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3615A2166B33;
	Thu, 21 Mar 2024 07:30:43 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH] util_lib/elf_info.c: fix a warning
Date: Thu, 21 Mar 2024 15:30:37 +0800
Message-ID: <20240321073037.823696-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_003050_267201_9F24F238 
X-CRM114-Status: GOOD (  11.54  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

VGhlcmUncyBhIGluY29ycmVjdCBhcnJheSBvcGVyYXRpb24gaW4gZnVuY3Rpb24gc2Nhbl92bWNv
cmVpbmZvKCksIGl0CndpbGwgY2F1c2UgYmVsb3cgd2FybmluZyBtZXNzYWdlLgoKLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KdXRpbF9saWIvZWxmX2luZm8uYzogSW4gZnVuY3Rpb24g4oCYc2Nhbl92
bWNvcmVpbmZv4oCZOgp1dGlsX2xpYi9lbGZfaW5mby5jOjM2MDo0Mzogd2FybmluZzogd3JpdGlu
ZyAxIGJ5dGUgaW50byBhIHJlZ2lvbiBvZiBzaXplIDAgWy1Xc3RyaW5nb3Atb3ZlcmZsb3c9XQog
IDM2MCB8ICAgICAgICAgICAgICAgICAgICAgICAgIHRlbXBfYnVmW2xlbiArIDFdID0gJ1wwJzsK
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5efn5+fn4K
dXRpbF9saWIvZWxmX2luZm8uYzozMTk6MTQ6IG5vdGU6IGF0IG9mZnNldCAxMDI0IGludG8gZGVz
dGluYXRpb24gb2JqZWN0IOKAmHRlbXBfYnVm4oCZIG9mIHNpemUgMTAyNAogIDMxOSB8ICAgICAg
ICAgY2hhciB0ZW1wX2J1ZlsxMDI0XTsKICAgICAgfCAgICAgICAgICAgICAgXn5+fn5+fn4KLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCgpGaXggaXQgdG8gYXZvaWQgb29iIGFjY2VzcyBvZiBhcnJheS4K
ClNpZ25lZC1vZmYtYnk6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPgotLS0KIHV0aWxfbGli
L2VsZl9pbmZvLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS91dGlsX2xpYi9lbGZfaW5mby5jIGIvdXRpbF9saWIvZWxm
X2luZm8uYwppbmRleCBjZTcxYzYwNTVjM2EuLjdjYTk4NzBiZmNhMCAxMDA2NDQKLS0tIGEvdXRp
bF9saWIvZWxmX2luZm8uYworKysgYi91dGlsX2xpYi9lbGZfaW5mby5jCkBAIC0zNTcsNyArMzU3
LDcgQEAgdm9pZCBzY2FuX3ZtY29yZWluZm8oY2hhciAqc3RhcnQsIHNpemVfdCBzaXplKQogCQkJ
aWYgKGxlbiA+PSBzaXplb2YodGVtcF9idWYpKQogCQkJCWxlbiA9IHNpemVvZih0ZW1wX2J1Zikg
LSAxOwogCQkJc3RybmNweSh0ZW1wX2J1ZiwgcG9zLCBsZW4pOwotCQkJdGVtcF9idWZbbGVuICsg
MV0gPSAnXDAnOworCQkJdGVtcF9idWZbbGVuXSA9ICdcMCc7CiAKIAkJCXBvcyA9IHRlbXBfYnVm
OwogCQkJbGVuID0gbGVuICsgMTsKLS0gCjIuNDEuMAoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK
