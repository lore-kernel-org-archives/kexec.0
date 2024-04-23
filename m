Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50626C4345F
	for <kexec@archiver.kernel.org>; Tue, 23 Apr 2024 07:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SpbQpBOtHRjwl8DDT4U0eaS66jCA+9g66e+vgSakUls=; b=KoIBGeXvV++DxG
	WO44OkExoKW4d2zd9CeserGSi+ngmeu2FOFcuXhCxd7c4HYStuXxq0i5K5nKhg6WfXtVD6gldxAij
	ud8buqL2VMPdlZZqaYDjor2N5bnhg8Fc0wxGLjGwV1pLOFFJbCgJn+0MVVB3HKwaEysEOVZMxELDb
	zqH9UDcPUTgqJIXKNnmoROKWd8B9JnSMlsKfL/2BZRi1Xxb0OfKmPNM+u6MNnnkdyf5jGJnKYPTYc
	BrX2r8032K307K7YFWqtuwpL7huyki9/f9bi20fwEcNc1fkigqXo9+bjIFP9lapE+dokqKVBjn4eJ
	Jul2aJbzEByHJZlEc+Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzB1Q-0000000GKvo-3J2w;
	Tue, 23 Apr 2024 07:57:00 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzB0e-0000000GKK9-2T1g;
	Tue, 23 Apr 2024 07:56:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713858962;
	bh=C10U8w+9znaxkvj5EdGV6iNeFy+LKwoCMige5+WbmRk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dtp2KrFTs1ZPOV423X3Lj+ohYH+w1R0E/8kBpk9DMXXZtdIcFmbTu30wN5OkBGmMP
	 FLzPXuqgfXj6gzjMKHmGAW69Xpdffu14WLEeO5qDjUe0ZwtkRmnV3IoKoevaneipoy
	 3sjOVDTg0D0OU3K0YuEo6+K2obOUKB6HIC+G61H4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 09:54:40 +0200
Subject: [PATCH v3 05/11] neighbour: constify ctl_table arguments of
 utility function
MIME-Version: 1.0
Message-Id: <20240423-sysctl-const-handler-v3-5-e0beccb836e2@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713858961; l=808;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=C10U8w+9znaxkvj5EdGV6iNeFy+LKwoCMige5+WbmRk=;
 b=EAoTey3kmtnh/z6T2K9kHOuOiGQPDvnlrHzdVg4MNSMG74MpVnrzaAzOlr8qG7tTA+0aGApZ5
 EfQ5uq8SVYaAWFetEV8qu3UzVUp6J12UzjZsoq4ZupsTosh3ACnOL89
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_005612_894952_78825BF3 
X-CRM114-Status: UNSURE (   8.26  )
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
IGFkYXB0IHRoZSBpbnRlcm5hbApoZWxwZXIuCgpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgV2Vpw59z
Y2h1aCA8bGludXhAd2Vpc3NzY2h1aC5uZXQ+Ci0tLQogbmV0L2NvcmUvbmVpZ2hib3VyLmMgfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9uZXQvY29yZS9uZWlnaGJvdXIuYyBiL25ldC9jb3JlL25laWdoYm91ci5jCmluZGV4
IDA4MDVjMDBjNjNkNC4uOTJhMDE2NjRhNzIzIDEwMDY0NAotLS0gYS9uZXQvY29yZS9uZWlnaGJv
dXIuYworKysgYi9uZXQvY29yZS9uZWlnaGJvdXIuYwpAQCAtMzU3OCw3ICszNTc4LDcgQEAgc3Rh
dGljIHZvaWQgbmVpZ2hfY29weV9kZmx0X3Bhcm1zKHN0cnVjdCBuZXQgKm5ldCwgc3RydWN0IG5l
aWdoX3Bhcm1zICpwLAogCXJjdV9yZWFkX3VubG9jaygpOwogfQogCi1zdGF0aWMgdm9pZCBuZWln
aF9wcm9jX3VwZGF0ZShzdHJ1Y3QgY3RsX3RhYmxlICpjdGwsIGludCB3cml0ZSkKK3N0YXRpYyB2
b2lkIG5laWdoX3Byb2NfdXBkYXRlKGNvbnN0IHN0cnVjdCBjdGxfdGFibGUgKmN0bCwgaW50IHdy
aXRlKQogewogCXN0cnVjdCBuZXRfZGV2aWNlICpkZXYgPSBjdGwtPmV4dHJhMTsKIAlzdHJ1Y3Qg
bmVpZ2hfcGFybXMgKnAgPSBjdGwtPmV4dHJhMjsKCi0tIAoyLjQ0LjAKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
