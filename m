Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F5FC10F15
	for <kexec@archiver.kernel.org>; Tue, 23 Apr 2024 07:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OLqivIseZ4RjACAn6paWO6Sd7mj9MmUth/oniCauIDE=; b=JgSfyGMrlwGqcf
	j7niP9144zAS2p4Pjc2X+Qz9xOiaDK9fAeGdx17LqWZp2ikA2cuuW5OBlHVtE3yEAB8w/+65nTnal
	NtDG0JFU9tTQs18P9Yb3d+gkSnBjr1izrjhlpJbDMTwph9l9SvEUFejhxF8wpvxdOoSkB6P6TFJlQ
	UF30W1TsTQsyMBolldus/iElv7FuJyOW4EFHSvSrUkf6Ie1NDd5DflVUOxlCfDseWx6QmaGspDatk
	j+t2jlsr5caIYqstBYlTDB7RDnq2jIXcPFdiH9bI/968XNhSE5hPcR+KWSBAZUDaq/h8C6lX3tPCn
	eexWUnG/AUi8Kip9in/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzB1R-0000000GKwu-3pni;
	Tue, 23 Apr 2024 07:57:01 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzB0e-0000000GKK8-2LBu;
	Tue, 23 Apr 2024 07:56:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713858962;
	bh=Zi29e0eOxt3096ac9S5+YPXUBVokEDqe9aNQ4UAlgts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cZv9tYu8jocP/CYyJINYfc6gNMFDkTBOvuAOKlCzFGjSQkkOQjo0JESha2IW51Tx2
	 8ga7jXOZatRJA1l9JDz69bqpRG/VPockakDWzf5aZ3apozniKI/TMoukS3JUAF1jwf
	 74sydQ3cQRwTNYzc5LQlBGGK7riDu1h8/tleJFis=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 09:54:42 +0200
Subject: [PATCH v3 07/11] ipv6/addrconf: constify ctl_table arguments of
 utility functions
MIME-Version: 1.0
Message-Id: <20240423-sysctl-const-handler-v3-7-e0beccb836e2@weissschuh.net>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
In-Reply-To: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Joel Granados <j.granados@samsung.com>, Kees Cook <keescook@chromium.org>
Cc: Eric Dumazet <edumazet@google.com>, Dave Chinner <david@fromorbit.com>, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, kexec@lists.infradead.org, 
 linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
 lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
 linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713858961; l=1733;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Zi29e0eOxt3096ac9S5+YPXUBVokEDqe9aNQ4UAlgts=;
 b=Uw0D0YcV60peceqZ8qkDg47x1/65ErxkGJOFBWaWNhF23zLkktHPe16IBGyrNywDi8Y64Gmfl
 c6GjQOH3NApB35AQteIr4jMklYZuzfOAKo/zEOjtr7qwLtB/qod7qRv
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_005612_935212_64F22CA1 
X-CRM114-Status: UNSURE (   7.17  )
X-CRM114-Notice: Please train this message.
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

SW4gYSBmdXR1cmUgY29tbWl0IHRoZSBwcm9jX2hhbmRsZXJzIHRoZW1zZWx2ZXMgd2lsbCBjaGFu
Z2UgdG8KImNvbnN0IHN0cnVjdCBjdGxfdGFibGUiLiBBcyBhIHByZXBhcmF0aW9uIGZvciB0aGF0
IGFkYXB0IHRoZSBpbnRlcm5hbApoZWxwZXJzLgoKU2lnbmVkLW9mZi1ieTogVGhvbWFzIFdlacOf
c2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0PgotLS0KIG5ldC9pcHY2L2FkZHJjb25mLmMgfCA4
ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL25ldC9pcHY2L2FkZHJjb25mLmMgYi9uZXQvaXB2Ni9hZGRyY29uZi5j
CmluZGV4IDlhYTA5MDBhYmZhMS4uOTZhYjM0OWU4YmE0IDEwMDY0NAotLS0gYS9uZXQvaXB2Ni9h
ZGRyY29uZi5jCisrKyBiL25ldC9pcHY2L2FkZHJjb25mLmMKQEAgLTg2Myw3ICs4NjMsNyBAQCBz
dGF0aWMgdm9pZCBhZGRyY29uZl9mb3J3YXJkX2NoYW5nZShzdHJ1Y3QgbmV0ICpuZXQsIF9fczMy
IG5ld2YpCiAJfQogfQogCi1zdGF0aWMgaW50IGFkZHJjb25mX2ZpeHVwX2ZvcndhcmRpbmcoc3Ry
dWN0IGN0bF90YWJsZSAqdGFibGUsIGludCAqcCwgaW50IG5ld2YpCitzdGF0aWMgaW50IGFkZHJj
b25mX2ZpeHVwX2ZvcndhcmRpbmcoY29uc3Qgc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCAq
cCwgaW50IG5ld2YpCiB7CiAJc3RydWN0IG5ldCAqbmV0OwogCWludCBvbGQ7CkBAIC05MzEsNyAr
OTMxLDcgQEAgc3RhdGljIHZvaWQgYWRkcmNvbmZfbGlua2Rvd25fY2hhbmdlKHN0cnVjdCBuZXQg
Km5ldCwgX19zMzIgbmV3ZikKIAl9CiB9CiAKLXN0YXRpYyBpbnQgYWRkcmNvbmZfZml4dXBfbGlu
a2Rvd24oc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCAqcCwgaW50IG5ld2YpCitzdGF0aWMg
aW50IGFkZHJjb25mX2ZpeHVwX2xpbmtkb3duKGNvbnN0IHN0cnVjdCBjdGxfdGFibGUgKnRhYmxl
LCBpbnQgKnAsIGludCBuZXdmKQogewogCXN0cnVjdCBuZXQgKm5ldDsKIAlpbnQgb2xkOwpAQCAt
NjM3OCw3ICs2Mzc4LDcgQEAgc3RhdGljIHZvaWQgYWRkcmNvbmZfZGlzYWJsZV9jaGFuZ2Uoc3Ry
dWN0IG5ldCAqbmV0LCBfX3MzMiBuZXdmKQogCX0KIH0KIAotc3RhdGljIGludCBhZGRyY29uZl9k
aXNhYmxlX2lwdjYoc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCAqcCwgaW50IG5ld2YpCitz
dGF0aWMgaW50IGFkZHJjb25mX2Rpc2FibGVfaXB2Nihjb25zdCBzdHJ1Y3QgY3RsX3RhYmxlICp0
YWJsZSwgaW50ICpwLCBpbnQgbmV3ZikKIHsKIAlzdHJ1Y3QgbmV0ICpuZXQgPSAoc3RydWN0IG5l
dCAqKXRhYmxlLT5leHRyYTI7CiAJaW50IG9sZDsKQEAgLTY2NjksNyArNjY2OSw3IEBAIHZvaWQg
YWRkcmNvbmZfZGlzYWJsZV9wb2xpY3lfaWRldihzdHJ1Y3QgaW5ldDZfZGV2ICppZGV2LCBpbnQg
dmFsKQogfQogCiBzdGF0aWMKLWludCBhZGRyY29uZl9kaXNhYmxlX3BvbGljeShzdHJ1Y3QgY3Rs
X3RhYmxlICpjdGwsIGludCAqdmFscCwgaW50IHZhbCkKK2ludCBhZGRyY29uZl9kaXNhYmxlX3Bv
bGljeShjb25zdCBzdHJ1Y3QgY3RsX3RhYmxlICpjdGwsIGludCAqdmFscCwgaW50IHZhbCkKIHsK
IAlzdHJ1Y3QgbmV0ICpuZXQgPSAoc3RydWN0IG5ldCAqKWN0bC0+ZXh0cmEyOwogCXN0cnVjdCBp
bmV0Nl9kZXYgKmlkZXY7CgotLSAKMi40NC4wCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
