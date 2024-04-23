Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDD1C16B13
	for <kexec@archiver.kernel.org>; Tue, 23 Apr 2024 07:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FmcNgaf/5Qr9cBoAS85ONPga0YdCNiQmundsJrwlIlU=; b=MS0IUPoKOk48b6
	djh6lriuK9m1u22Ye3dIVT29ckqonUUkzpltNbAk1HB/P7rFjBemskuVwlP/NF+7+63gGDXf3s0Ed
	yx582za5NMNCjdvadEwegnxBKZ7H9QRNqaN/QJ/2oVbUarnS2NQwTf8pzmff0TTnjXdWCcokzkKuo
	QlKhA0YG6NUDetQS/0C6eW+GXHaurgjefME+oV65QBSnhtaNY0AQvsC+if3sEe9uWfNyV/1TDfEqQ
	RJPH5ghLay66XruUV6R79azQGbVlxGJngT5kCH+nqA6WpacabTRVkCgG/ssrOWZrstgwwNAAjtSVe
	aFmFdO7TGCfgFWfgMsRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzB0q-0000000GKWK-3aih;
	Tue, 23 Apr 2024 07:56:24 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzB0a-0000000GKI1-1xRI;
	Tue, 23 Apr 2024 07:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713858962;
	bh=opGR4gpnAvbs+lyNBq6fdLjOrQBbmIYYx1eB7UGZHV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HfImcajLyH9fRAHB6Ui+Edknzu1unFNUQsyZkN6W9dmfU+gHpYzWRB8z1jdPEJfrY
	 Pr+tQUXouYF6Fr8ZB0dJgU5uJKyqI4ZpirRA8P4QYR64pl5zSDWYNSCG1oUxNDMuR7
	 AXYmALCXm31TMp71SE8rzh6qU7YGEq6bCde/2XZw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 09:54:39 +0200
Subject: [PATCH v3 04/11] utsname: constify ctl_table arguments of utility
 function
MIME-Version: 1.0
Message-Id: <20240423-sysctl-const-handler-v3-4-e0beccb836e2@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713858961; l=696;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=opGR4gpnAvbs+lyNBq6fdLjOrQBbmIYYx1eB7UGZHV4=;
 b=ed5W9yz6Y3PYc8dy+kq6hSu45FqtfkT99vg42nbOB1Ni65LnrRYJQZmla0Oue7XwR99Gbnjaj
 bId0PbgErm0AeGk6gclOc5pv5Xfx6JPwBqf+J7ohAIHsKXAVAE3Ars1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_005608_684557_3CF9ADC2 
X-CRM114-Status: UNSURE (   7.67  )
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
Y2h1aCA8bGludXhAd2Vpc3NzY2h1aC5uZXQ+Ci0tLQoga2VybmVsL3V0c25hbWVfc3lzY3RsLmMg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9rZXJuZWwvdXRzbmFtZV9zeXNjdGwuYyBiL2tlcm5lbC91dHNuYW1lX3N5c2N0
bC5jCmluZGV4IDc2YTc3MjA3MjU1Ny4uMDRlNDUxM2YyOTg1IDEwMDY0NAotLS0gYS9rZXJuZWwv
dXRzbmFtZV9zeXNjdGwuYworKysgYi9rZXJuZWwvdXRzbmFtZV9zeXNjdGwuYwpAQCAtMTUsNyAr
MTUsNyBAQAogCiAjaWZkZWYgQ09ORklHX1BST0NfU1lTQ1RMCiAKLXN0YXRpYyB2b2lkICpnZXRf
dXRzKHN0cnVjdCBjdGxfdGFibGUgKnRhYmxlKQorc3RhdGljIHZvaWQgKmdldF91dHMoY29uc3Qg
c3RydWN0IGN0bF90YWJsZSAqdGFibGUpCiB7CiAJY2hhciAqd2hpY2ggPSB0YWJsZS0+ZGF0YTsK
IAlzdHJ1Y3QgdXRzX25hbWVzcGFjZSAqdXRzX25zOwoKLS0gCjIuNDQuMAoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
