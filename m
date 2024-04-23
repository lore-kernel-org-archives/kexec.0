Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD09C4345F
	for <kexec@archiver.kernel.org>; Tue, 23 Apr 2024 07:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A86+UjmoCklIp4fs4fvG0PQs5XgT2Ng66oRWzoxHTeo=; b=v20fgb9Y3JgEGA
	tKAaH7ndziYHF+sqC/lmmLZ2S71zuvepjVqjAeS5KL/OhyY5Drxm3c5VBgN43Ihd3U10s2Kzncygm
	1kk7Jmyg3vOWpq1MwQZfxlX6pMAPMet2p45s2228IpUU3aNplyZAO8iZJGat2Q6CU0tJ5frvxKCQn
	eDUmeGte4w/U3p2Sz+PbwAngq3+DNiRbQxAWWkyUbrYI70NE9wYnd5a15eopI3TIlffFFxC62VODP
	XA+j82o7JgduenjVjIDdNTEkgePqulGzGSddbngejtg3JuyZzZN05VlGm1PlIrbbh3DJ1xGWCpt71
	1s5MnbxEeZRTM0OpoUAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzB1T-0000000GKyB-2o3n;
	Tue, 23 Apr 2024 07:57:03 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzB0e-0000000GKK7-2Nzf;
	Tue, 23 Apr 2024 07:56:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713858962;
	bh=rhTtJbRFTTDD/EEuqh+xmQGgJG7l1CgJQWXHlODBL5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jh4kHqKR8uFfgbO8D9WK1hxUfjPm8iO4Tj/1g9oqbdvZsvOO7NNctmOr5j9hI/VKE
	 pHafcxJ8BdeddjSts/bMxWLccdEWmQmje38r1ok3DoPkrNGs3KG6i7U8YJpR6imRw2
	 VR1iTBJjamva0pTfL/MxJ99YyYItdDSAEsnB8hOA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 09:54:41 +0200
Subject: [PATCH v3 06/11] ipv4/sysctl: constify ctl_table arguments of
 utility functions
MIME-Version: 1.0
Message-Id: <20240423-sysctl-const-handler-v3-6-e0beccb836e2@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713858961; l=1269;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rhTtJbRFTTDD/EEuqh+xmQGgJG7l1CgJQWXHlODBL5I=;
 b=xkBxm95PFV9biLBQXL/jnQoslPWOqeiKfLilfo9X0/w/rpk96uwZ6XcT8dAItQlTvocuJZiXJ
 AWgjsh5bK7RD2GBrU5dFR8YS1o9Y0qoHpG5ydJoQPSEwJ0OoCUdGv/k
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_005612_898181_82659F36 
X-CRM114-Status: UNSURE (   7.70  )
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
c2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0PgotLS0KIG5ldC9pcHY0L3N5c2N0bF9uZXRfaXB2
NC5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvc3lzY3RsX25ldF9pcHY0LmMgYi9uZXQvaXB2
NC9zeXNjdGxfbmV0X2lwdjQuYwppbmRleCBjZTVkMTk5NzhhMjYuLmZjNGMwMDFiZjcyYSAxMDA2
NDQKLS0tIGEvbmV0L2lwdjQvc3lzY3RsX25ldF9pcHY0LmMKKysrIGIvbmV0L2lwdjQvc3lzY3Rs
X25ldF9pcHY0LmMKQEAgLTEzMCw3ICsxMzAsOCBAQCBzdGF0aWMgaW50IGlwdjRfcHJpdmlsZWdl
ZF9wb3J0cyhzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwgaW50IHdyaXRlLAogCXJldHVybiByZXQ7
CiB9CiAKLXN0YXRpYyB2b2lkIGluZXRfZ2V0X3BpbmdfZ3JvdXBfcmFuZ2VfdGFibGUoc3RydWN0
IGN0bF90YWJsZSAqdGFibGUsIGtnaWRfdCAqbG93LCBrZ2lkX3QgKmhpZ2gpCitzdGF0aWMgdm9p
ZCBpbmV0X2dldF9waW5nX2dyb3VwX3JhbmdlX3RhYmxlKGNvbnN0IHN0cnVjdCBjdGxfdGFibGUg
KnRhYmxlLAorCQkJCQkgICAga2dpZF90ICpsb3csIGtnaWRfdCAqaGlnaCkKIHsKIAlrZ2lkX3Qg
KmRhdGEgPSB0YWJsZS0+ZGF0YTsKIAlzdHJ1Y3QgbmV0ICpuZXQgPQpAQCAtMTQ1LDcgKzE0Niw4
IEBAIHN0YXRpYyB2b2lkIGluZXRfZ2V0X3BpbmdfZ3JvdXBfcmFuZ2VfdGFibGUoc3RydWN0IGN0
bF90YWJsZSAqdGFibGUsIGtnaWRfdCAqbG93CiB9CiAKIC8qIFVwZGF0ZSBzeXN0ZW0gdmlzaWJs
ZSBJUCBwb3J0IHJhbmdlICovCi1zdGF0aWMgdm9pZCBzZXRfcGluZ19ncm91cF9yYW5nZShzdHJ1
Y3QgY3RsX3RhYmxlICp0YWJsZSwga2dpZF90IGxvdywga2dpZF90IGhpZ2gpCitzdGF0aWMgdm9p
ZCBzZXRfcGluZ19ncm91cF9yYW5nZShjb25zdCBzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwKKwkJ
CQkga2dpZF90IGxvdywga2dpZF90IGhpZ2gpCiB7CiAJa2dpZF90ICpkYXRhID0gdGFibGUtPmRh
dGE7CiAJc3RydWN0IG5ldCAqbmV0ID0KCi0tIAoyLjQ0LjAKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
