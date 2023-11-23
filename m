Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7391C5AD4C
	for <kexec@archiver.kernel.org>; Thu, 23 Nov 2023 07:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=po1wfyWtMM7qCZQ0+4L5fzJQ2qrGZvZJpOO/oVrUFEg=; b=49OBCzf1vNXc6T
	DqhxKTYJUuqzK3xpLTEb/pSvCVfbt5/lBsd00DKNQFI3y79CwcUKXuRqzA5e/ZmeLfv1wEsjHKWCZ
	slvcsVZSJiJLPovRXi0NQryQ8h7U8c7FlSBSghQzQrCXvxOalTszGQmBUictk2TwwmLksP2bLydZG
	Lv4fnPkqzvp9aSV+SEJ44lm3z/gcKxr94tcI/BO/F5mgb/O8eXD1b87u3GUQJuuuo8WNP/aqG1a8A
	GDv/rP3jrVLT2Kqz1QTSnqv1MrSmdrc8D+qZzIKwxGiz67Ew9DfzBz7uw1SI2jU4vNzr+dIunar4j
	khyA0eGsWvQ487SeVlGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r64Gx-0043O9-0K;
	Thu, 23 Nov 2023 07:37:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r64Gu-0043MW-0W
	for kexec@lists.infradead.org;
	Thu, 23 Nov 2023 07:37:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700725031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNqYLkFiIJwwuHzYUt5fu8IOSkWjg/NNK5Ec2zATJ28=;
	b=GqbkU5ZZY73ALUt7GsWcJPQFXnG5iljLPP8O7KkmIBP06y94RmC3VC3hpNPf1M7c4f/TLV
	eJ8Rj5/LmCkWy9l2Ipm0xCgFsXEVnZ3HcIxvElE3H6oUWdo72tKAJYItv2Sowszu9xVh0K
	gJzVzreUK77Y8YAJAi0CfX9nwGDVG00=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-pvhi0avYMXu46SHWzNgkjw-1; Thu,
 23 Nov 2023 02:37:06 -0500
X-MC-Unique: pvhi0avYMXu46SHWzNgkjw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F8C61C05ABA;
	Thu, 23 Nov 2023 07:37:06 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 48D6C492BFA;
	Thu, 23 Nov 2023 07:37:02 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	akpm@linux-foundation.org,
	ignat@cloudflare.com,
	eric_devolder@yahoo.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/3] drivers/base/cpu: crash data showing should depends on KEXEC_CORE
Date: Thu, 23 Nov 2023 15:36:51 +0800
Message-ID: <20231123073652.507034-3-bhe@redhat.com>
In-Reply-To: <20231123073652.507034-1-bhe@redhat.com>
References: <20231123073652.507034-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_233712_271672_BC8FC451 
X-CRM114-Status: GOOD (  13.08  )
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

V2hlbiBiZWxvdyBrZXJuZWwgY29uZmlnIGl0ZW1zIGFyZSBzZXQsIGNvbXBpbGluZyBlcnJvciBh
cmUgdHJpZ2dlcmVkLgoKQ09ORklHX0NSQVNIX0NPUkU9eQpDT05GSUdfS0VYRUNfQ09SRT15CkNP
TkZJR19DUkFTSF9EVU1QPXkKQ09ORklHX0NSQVNIX0hPVFBMVUc9eQoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCmRyaXZlcnMvYmFzZS9jcHUu
YzogSW4gZnVuY3Rpb24g4oCYY3Jhc2hfaG90cGx1Z19zaG934oCZOgpkcml2ZXJzL2Jhc2UvY3B1
LmM6MzA5OjQwOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYY3Jh
c2hfaG90cGx1Z19jcHVfc3VwcG9ydOKAmTsgZGlkIHlvdSBtZWFuIOKAmGNyYXNoX2hvdHBsdWdf
c2hvd+KAmT8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgMzA5IHwg
ICAgICAgICByZXR1cm4gc3lzZnNfZW1pdChidWYsICIlZFxuIiwgY3Jhc2hfaG90cGx1Z19jcHVf
c3VwcG9ydCgpKTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY3Jhc2hfaG90cGx1Z19zaG93CmNjMTogc29tZSB3YXJuaW5ncyBi
ZWluZyB0cmVhdGVkIGFzIGVycm9ycwotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KCkNPTkZJR19LRVhFQyBpcyB1c2VkIHRvIGVuYWJsZSBrZXhl
Y19sb2FkIGludGVyZmFjZSwgdGhlCmNyYXNoX25vdGVzL2NyYXNoX25vdGVzX3NpemUvY3Jhc2hf
aG90cGx1ZyBzaG93aW5nIGRlcGVuZHMgb24KQ09ORklHX0tFWEVDIGlzIGluY29ycmVjdC4gSXQg
c2hvdWxkIGRlcGVuZCBvbiBLRVhFQ19DT1JFIGluc3RlYWQuCgpGaXggaXQgbm93LgoKU2lnbmVk
LW9mZi1ieTogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9iYXNlL2Nw
dS5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL2NwdS5jIGIvZHJpdmVycy9iYXNlL2Nw
dS5jCmluZGV4IDllYTIyZTE2NWFjZC4uNTQ4NDkxZGU4MThlIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2Jhc2UvY3B1LmMKKysrIGIvZHJpdmVycy9iYXNlL2NwdS5jCkBAIC0xNDQsNyArMTQ0LDcgQEAg
c3RhdGljIERFVklDRV9BVFRSKHJlbGVhc2UsIFNfSVdVU1IsIE5VTEwsIGNwdV9yZWxlYXNlX3N0
b3JlKTsKICNlbmRpZiAvKiBDT05GSUdfQVJDSF9DUFVfUFJPQkVfUkVMRUFTRSAqLwogI2VuZGlm
IC8qIENPTkZJR19IT1RQTFVHX0NQVSAqLwogCi0jaWZkZWYgQ09ORklHX0tFWEVDCisjaWZkZWYg
Q09ORklHX0tFWEVDX0NPUkUKICNpbmNsdWRlIDxsaW51eC9rZXhlYy5oPgogCiBzdGF0aWMgc3Np
emVfdCBjcmFzaF9ub3Rlc19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwKQEAgLTE4OSwxNCArMTg5
LDE0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIGNyYXNoX25vdGVfY3B1
X2F0dHJfZ3JvdXAgPSB7CiAjZW5kaWYKIAogc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVf
Z3JvdXAgKmNvbW1vbl9jcHVfYXR0cl9ncm91cHNbXSA9IHsKLSNpZmRlZiBDT05GSUdfS0VYRUMK
KyNpZmRlZiBDT05GSUdfS0VYRUNfQ09SRQogCSZjcmFzaF9ub3RlX2NwdV9hdHRyX2dyb3VwLAog
I2VuZGlmCiAJTlVMTAogfTsKIAogc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAg
KmhvdHBsdWdhYmxlX2NwdV9hdHRyX2dyb3Vwc1tdID0gewotI2lmZGVmIENPTkZJR19LRVhFQwor
I2lmZGVmIENPTkZJR19LRVhFQ19DT1JFCiAJJmNyYXNoX25vdGVfY3B1X2F0dHJfZ3JvdXAsCiAj
ZW5kaWYKIAlOVUxMCi0tIAoyLjQxLjAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
