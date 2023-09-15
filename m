Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC9AEE021A
	for <kexec@archiver.kernel.org>; Fri, 15 Sep 2023 03:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MPXOZ54ZSdhQUBU79yJmGclZ05KTP6Dp6pB6g4nevMU=; b=EXyD6bktF/BP4C
	B1ZkDg0uA5wI8YhMMFjVeRj4G128QDBqvtymrXc433ewF+I9jFD1Qge8M54ULkayyfCmcsV6pEjpq
	GqTg9HKk7B2Z3iiaAosXDkOYtHY6QzcHMAb48G3YkUwG4Pca+h2x2lZBLqM6F3qS8goYeKRzZNsjv
	OHGEd/o8RDrV4gfE7sNLo/68AuimjfgbmzSbwIM7KOGg0xS3gDfbwPky9Gwkm0z2hg9T3seZ0YJqP
	lXNupx3K5uVdqrkIFxkU+mOE4Sbsfgx8T0ixJWelB0zpiTcNVMp2WLBvCP6ZHtNk6LXq700PuB+M/
	99QMZWFjtmVnvXZS14MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgzs2-009hMw-2Z;
	Fri, 15 Sep 2023 03:51:54 +0000
Received: from bg2.exmail.qq.com ([106.55.200.77])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgzrw-009hLY-2m
	for kexec@lists.infradead.org;
	Fri, 15 Sep 2023 03:51:53 +0000
X-QQ-mid: bizesmtp85t1694749867tk9gx8ey
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Sep 2023 11:51:05 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: cZJzGXgx8vYeSqI9bKUq6ya3TigehiPlY+ImccjDXbIBMHxecolCESEVDbinD
	vCXIpoHasp6m6TGxvezQ0qPhcaXDHjv+5X7bCoyokW2YIPasIgvOzfYuTvZVCO/kVhOl0/G
	azJ2529kb5zGSe/DCtZk66zb9C0TM44o4VTDAGMcaj9/k9/DEA3YqHzQstdi0yes+sR1Kvo
	THbLn0bolQS1OrAIUktgO9xbEjSnOa/0IQF/ERzkF5P7JSEjyABtmQEhV71zlm5cOYvLMGW
	P/hDhd75WtDEU8UWwr6Znf8jEYfB3P5HUTx+YrZA6dN7FNzoZlg2qkVqIiPdjOiugxTvSEy
	C8jofmFHYYQ7w/eeS4LI+lNPCxkGV9LotFj2pnR
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6215815145595776650
From: Song Shuai <songshuaishuai@tinylab.org>
To: lizhengyu3@huawei.com,
	liaochang1@huawei.com,
	xianting.tian@linux.alibaba.com,
	guoren@kernel.org,
	horms@kernel.org,
	horms@verge.net.au,
	huanyi.xj@alibaba-inc.com,
	mick@ics.forth.gr,
	yixun.lan@gmail.com
Cc: kexec@lists.infradead.org,
	Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH 0/7] Kexec-tools: Improve RISC-V port
Date: Fri, 15 Sep 2023 11:50:06 +0800
Message-Id: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_205149_233424_EFC00FBA 
X-CRM114-Status: UNSURE (   9.91  )
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

SGksCgpUaGlzIHNlcmllcyBpcyBjcmVhdGVkIHRvIGltcHJvdmUgUklTQy1WIHBvcnQgb2Yga2V4
ZWMtdG9vbHMsCmFuZCBpcyBiYXNlZCBvbiB0aGUgaG9ybXMva2V4ZWMtdG9vbHM6YnVpbGQtdGVz
dC1yaXNjdi12MiBicmFuY2guCgpGb3IgeW91ciBjb252ZW5pZW5jZSwgaGVyZSBpcyBteSBHaXRo
dWIgYnJhbmNoIGZvciBrZXhlYy10b29sczoKaHR0cHM6Ly9naXRodWIuY29tL3N1Z2FyZmlsbGV0
L2tleGVjLXRvb2xzL2NvbW1pdHMvcnYtSW1hZ2UKClRoZSBmaXJzdCBmb3VyIHBhdGNoZXMgZml4
ZXMgc29tZSBidWlsZCBvciBydW50aW1lIGlzc3VlczogIAoKICBSSVNDLVY6IFVzZSBsaW51eCx1
c2FibGUtbWVtb3J5LXJhbmdlIGZvciBjcmFzaCBrZXJuZWwKICBSSVNDLVY6IEZpeCB0aGUgdW5k
ZWNsYXJlZCDigJhFTV9SSVNDVuKAmSBidWlsZCBmYWlsdXJlCiAgUklTQy1WOiBHZXQgbWVtb3J5
IHJhbmdlcyBmcm9tIGlvbWVtCiAgUklTQy1WOiBDb3JyZWN0IHRoZSB1c2FnZSBvZiBjb21tYW5k
IGxpbmUgb3B0aW9uCgpUaGUgbGFzdCB0aHJlZSBwYXRjaGVzIGVuYWJsZSB0aGUga2V4ZWNfZmls
ZV9sb2FkIHN5c2NhbGwgdG8gbG9hZAp2bWxpbnV4IGFuZCBzdXBwb3J0IGxvYWRpbmcgSW1hZ2Ug
YmluYXJ5IGZpbGUgZm9yIHR3byBzeXNjYWxscy4KCiAgUklTQy1WOiBFbmFibGUga2V4ZV9maWxl
X2xvYWQKICBSSVNDLVY6IFNlcGFyYXRlIGVsZl9yaXNjdl9maW5kX3BiYXNlIG91dAogIFJJU0Mt
VjogU3VwcG9ydCBsb2FkaW5nIEltYWdlIGJpbmFyeSBmaWxlCgpOb3RlIHRoYXQ6IAoKUklTQy1W
IExpbnV4IGtleGVjX2xvYWRfZmlsZSdzIHN1cHBvcnQgZm9yIEltYWdlIGZpbGUgaGFzIGJlZW4g
c2VudCBvdXQgYnV0IG5vdCBtZXJnZWQgWzFdLgoKWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1yaXNjdi8yMDIzMDkxNDAyMDA0NC4xMzk3MzU2LTEtc29uZ3NodWFpc2h1YWlAdGlu
eWxhYi5vcmcvVC8jdCAKCkxpIFpoZW5neXUgKDEpOgogIFJJU0MtVjogRW5hYmxlIGtleGVfZmls
ZV9sb2FkCgpTb25nIFNodWFpICg2KToKICBSSVNDLVY6IFVzZSBsaW51eCx1c2FibGUtbWVtb3J5
LXJhbmdlIGZvciBjcmFzaCBrZXJuZWwKICBSSVNDLVY6IEZpeCB0aGUgdW5kZWNsYXJlZCDigJhF
TV9SSVNDVuKAmSBidWlsZCBmYWlsdXJlCiAgUklTQy1WOiBHZXQgbWVtb3J5IHJhbmdlcyBmcm9t
IGlvbWVtCiAgUklTQy1WOiBDb3JyZWN0IHRoZSB1c2FnZSBvZiBjb21tYW5kIGxpbmUgb3B0aW9u
CiAgUklTQy1WOiBTZXBhcmF0ZSBlbGZfcmlzY3ZfZmluZF9wYmFzZSBvdXQKICBSSVNDLVY6IFN1
cHBvcnQgbG9hZGluZyBJbWFnZSBiaW5hcnkgZmlsZQoKIGtleGVjL2FyY2gvcmlzY3YvTWFrZWZp
bGUgICAgICAgICAgICB8ICAgMiArCiBrZXhlYy9hcmNoL3Jpc2N2L2NyYXNoZHVtcC1yaXNjdi5j
ICAgfCAgIDIgKy0KIGtleGVjL2FyY2gvcmlzY3YvaW1hZ2UtaGVhZGVyLmggICAgICB8ICA4OCAr
KysrKysrKysrKysrKwoga2V4ZWMvYXJjaC9yaXNjdi9pb21lbS5oICAgICAgICAgICAgIHwgIDEw
ICsrCiBrZXhlYy9hcmNoL3Jpc2N2L2tleGVjLWVsZi1yaXNjdi5jICAgfCAgNzcgKy0tLS0tLS0t
LS0tCiBrZXhlYy9hcmNoL3Jpc2N2L2tleGVjLWltYWdlLXJpc2N2LmMgfCAgOTUgKysrKysrKysr
KysrKysrCiBrZXhlYy9hcmNoL3Jpc2N2L2tleGVjLXJpc2N2LmMgICAgICAgfCAxNzYgKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tCiBrZXhlYy9hcmNoL3Jpc2N2L2tleGVjLXJpc2N2LmggICAg
ICAgfCAgMjEgKysrKwoga2V4ZWMva2V4ZWMtc3lzY2FsbC5oICAgICAgICAgICAgICAgIHwgICAz
ICsKIDkgZmlsZXMgY2hhbmdlZCwgMzY4IGluc2VydGlvbnMoKyksIDEwNiBkZWxldGlvbnMoLSkK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBrZXhlYy9hcmNoL3Jpc2N2L2ltYWdlLWhlYWRlci5oCiBjcmVh
dGUgbW9kZSAxMDA2NDQga2V4ZWMvYXJjaC9yaXNjdi9pb21lbS5oCiBjcmVhdGUgbW9kZSAxMDA2
NDQga2V4ZWMvYXJjaC9yaXNjdi9rZXhlYy1pbWFnZS1yaXNjdi5jCgotLSAKMi4yMC4xCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
