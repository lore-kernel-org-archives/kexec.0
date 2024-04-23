Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E8CC4345F
	for <kexec@archiver.kernel.org>; Tue, 23 Apr 2024 07:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V7CDkOgwYCF1IOwbcbWqhr5gacFfCfwc5HEYiERaQ5E=; b=R9Zl5iTHmIldUJ
	1Dz3LvX/7VtTuuc7vWOS9YpcQM2OqHUygOv0Tl4O6qoIKZMEuOmAiV99vLpRAdDcBU33WO5hdtKJW
	SBbkEKdxl2X4Aj1iO9lxkq3UVtK1dBzfbgR5bjoVADBP4nQVGWU+Fm82qXp2+WPzHyF9Fra+y+Kug
	4ALcZbVyKpsxr3Go8sy16SPUT22axnFumxXRJA+NCGCP3Ef+UtDDqFL4oH0lB9qqVlh+1NyDWhB29
	y/fMbm6JwDR0/Z8ADlb6PzusWv32MZ+ypylQtim+IfCZwV2v6nnlCEEAcEvScsYOSmMIlvSZdp8xv
	Bh86qSYFZhtfHnWZ0v1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzB2F-0000000GLg6-288C;
	Tue, 23 Apr 2024 07:57:51 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzB0f-0000000GKL9-3JDG;
	Tue, 23 Apr 2024 07:56:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713858962;
	bh=odMbVtXputh1B0wvO7gtV7cKLTLD5qqVWgyPwr4fby8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iLEuUiqmghQTs4TpLEBZo8gm3hwwbmMwVh4LjetW99mef7fnKS1+JFbAcu6CXN+nU
	 Qkeg3C6Dg8GVXnY7Yt7xJGc6b7m/FkLbHyvle0PIjuq8AhNHSJZCZpA5JwOewu8BaK
	 /noyOblAFfy+/YF6CCqIRarm1v2eXbwf+FU797II=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 09:54:44 +0200
Subject: [PATCH v3 09/11] ipvs: constify ctl_table arguments of utility
 functions
MIME-Version: 1.0
Message-Id: <20240423-sysctl-const-handler-v3-9-e0beccb836e2@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713858961; l=1292;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=odMbVtXputh1B0wvO7gtV7cKLTLD5qqVWgyPwr4fby8=;
 b=HGS1kdZAsaJZKpg4r6Gy7F4xJbcNv2yq+KS0wT9dr5GDwl8/cNzV2zronax9Lbe4GmE5G3NOC
 F+TpiwFZuPaBZHHRsyNSIMTh2HPxXZ0cjduuz09UV7awWr9POrydgh8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_005614_130365_33A601B0 
X-CRM114-Status: UNSURE (   7.00  )
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
c2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0PgotLS0KIG5ldC9uZXRmaWx0ZXIvaXB2cy9pcF92
c19jdGwuYyB8IDcgKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvbmV0ZmlsdGVyL2lwdnMvaXBfdnNfY3RsLmMg
Yi9uZXQvbmV0ZmlsdGVyL2lwdnMvaXBfdnNfY3RsLmMKaW5kZXggMTQzYTM0MWJiYzBhLi42ODlh
YzUyMWVhMmQgMTAwNjQ0Ci0tLSBhL25ldC9uZXRmaWx0ZXIvaXB2cy9pcF92c19jdGwuYworKysg
Yi9uZXQvbmV0ZmlsdGVyL2lwdnMvaXBfdnNfY3RsLmMKQEAgLTE5MjQsNyArMTkyNCw4IEBAIHBy
b2NfZG9fc3luY19wb3J0cyhzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwgaW50IHdyaXRlLAogCXJl
dHVybiByYzsKIH0KIAotc3RhdGljIGludCBpcHZzX3Byb2NfZXN0X2NwdW1hc2tfc2V0KHN0cnVj
dCBjdGxfdGFibGUgKnRhYmxlLCB2b2lkICpidWZmZXIpCitzdGF0aWMgaW50IGlwdnNfcHJvY19l
c3RfY3B1bWFza19zZXQoY29uc3Qgc3RydWN0IGN0bF90YWJsZSAqdGFibGUsCisJCQkJICAgICB2
b2lkICpidWZmZXIpCiB7CiAJc3RydWN0IG5ldG5zX2lwdnMgKmlwdnMgPSB0YWJsZS0+ZXh0cmEy
OwogCWNwdW1hc2tfdmFyX3QgKnZhbHAgPSB0YWJsZS0+ZGF0YTsKQEAgLTE5NjIsOCArMTk2Myw4
IEBAIHN0YXRpYyBpbnQgaXB2c19wcm9jX2VzdF9jcHVtYXNrX3NldChzdHJ1Y3QgY3RsX3RhYmxl
ICp0YWJsZSwgdm9pZCAqYnVmZmVyKQogCXJldHVybiByZXQ7CiB9CiAKLXN0YXRpYyBpbnQgaXB2
c19wcm9jX2VzdF9jcHVtYXNrX2dldChzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwgdm9pZCAqYnVm
ZmVyLAotCQkJCSAgICAgc2l6ZV90IHNpemUpCitzdGF0aWMgaW50IGlwdnNfcHJvY19lc3RfY3B1
bWFza19nZXQoY29uc3Qgc3RydWN0IGN0bF90YWJsZSAqdGFibGUsCisJCQkJICAgICB2b2lkICpi
dWZmZXIsIHNpemVfdCBzaXplKQogewogCXN0cnVjdCBuZXRuc19pcHZzICppcHZzID0gdGFibGUt
PmV4dHJhMjsKIAljcHVtYXNrX3Zhcl90ICp2YWxwID0gdGFibGUtPmRhdGE7CgotLSAKMi40NC4w
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
