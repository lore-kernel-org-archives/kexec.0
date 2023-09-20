Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38239CE79CF
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 11:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8M6Gygd4d7AciofUmte9W8rlZGDx1vTfuMURfUyewGk=; b=lH2jVLPGgp+yHh
	aOVQ5dsWRwNSOV6wU8KFQVRNamdYN0rkSfSe2foS+HTx9wmrjiQ1kBcg6dTvfO4dCKws7wfLkgVQH
	ZZhWx5OpGKJEpOxp76LQZtJd3LwNK8W4rWmauivwXs/j+Lfuh/iCS6oFmQl/DL+8iArCXGNjF4THc
	x0VJe98AM0DjoZ/HGZ14mnpy2uV49WY4SGUFH01qbuwoxUwPcCAu9Xc1Gfs/3hld0KHG4CrDND76D
	ZEUPhzML8HaqmmwbcnqMza7tq1MYFnUth8aTt4hl2MnmxH0EyvZ6Lg1IN3VpQgqPqWhCLIFhP2QNE
	2lGL8GuGLr7mjWisA8ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qivp2-002wL1-1D;
	Wed, 20 Sep 2023 11:56:48 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qivoz-002wKI-0h
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 11:56:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 175F5CE18C0;
	Wed, 20 Sep 2023 11:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9CEC433C7;
	Wed, 20 Sep 2023 11:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695211001;
	bh=6cwwuWEQdryJbDUNuAluRciXzQeIwQXCGbgj8LfOPfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/S5SkXEW5n441wyNVafwKJo31pzMMgTPY0+32LR7RLcpArOOPyLwnrjU6U3aSzyE
	 ojsyFpmI5hJSBS+V/PuMLCunFu7Zs5lLgDy7hVUDKS7r0WAu+jVwM1UF+H6VokG8tv
	 JSasHvPaQVVnuo+YR2dn3kq0vo4zzQkrLs6lF7m5vtqnMtiBRQUdb8bpjG9YeCW7DW
	 E51/3FUVdvDPQ3Rezp30hL8Q2P8Wf50FpaeUWoskKCUYUvfmtS2q4M+6YUVj795Grz
	 A63zsS42Rgd2UZmRRPsBxWB1NrvpBuQmMWzW82z7jT0nIs2uwmtzk+EnA0d+jGKSHO
	 1b7RhQnPR+9bA==
Date: Wed, 20 Sep 2023 12:56:34 +0100
From: Simon Horman <horms@kernel.org>
To: Song Shuai <songshuaishuai@tinylab.org>
Cc: lizhengyu3@huawei.com, liaochang1@huawei.com,
	xianting.tian@linux.alibaba.com, guoren@kernel.org,
	huanyi.xj@alibaba-inc.com, mick@ics.forth.gr, yixun.lan@gmail.com,
	kexec@lists.infradead.org
Subject: Re: [PATCH 0/7] Kexec-tools: Improve RISC-V port
Message-ID: <20230920115634.GG224399@kernel.org>
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_045645_609271_5CC31760 
X-CRM114-Status: GOOD (  19.18  )
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

T24gRnJpLCBTZXAgMTUsIDIwMjMgYXQgMTE6NTA6MDZBTSArMDgwMCwgU29uZyBTaHVhaSB3cm90
ZToKPiBIaSwKPiAKPiBUaGlzIHNlcmllcyBpcyBjcmVhdGVkIHRvIGltcHJvdmUgUklTQy1WIHBv
cnQgb2Yga2V4ZWMtdG9vbHMsCj4gYW5kIGlzIGJhc2VkIG9uIHRoZSBob3Jtcy9rZXhlYy10b29s
czpidWlsZC10ZXN0LXJpc2N2LXYyIGJyYW5jaC4KCkluIG15IG1pbmQgdGhlIGJpZyBxdWVzdGlv
biBpcyBob3cgdG8gbW92ZSBSSVNDLVYgc3VwcG9ydApmcm9tIHRoYXQgYnJhbmNoLCB0byBiZWlu
ZyBtZXJnZWQgaW50byBtYWluLgoKSUlSQyB0aGVyZSB3ZXJlIHNvbWUgaXNzdWVzIHRoYXQgbmVl
ZGVkIHRvIGJlIGFkZHJlc3NlZC4KUGVyaGFwcyB0aGV5IGFyZSBhbGwgYWRkcmVzc2VkIGJ5IHRo
aXMgc2VyaWVzLCBhbmQgd2l0aApzb21lIGFwcHJvcHJpYXRlIHNxdWFzaGluZyB3ZSBjYW4gbW92
ZSBmb3J3YXJkcyB3aXRoIGEgc2VyaWVzCmJhc2VkIG9uIG1haW4/Cgo+IAo+IEZvciB5b3VyIGNv
bnZlbmllbmNlLCBoZXJlIGlzIG15IEdpdGh1YiBicmFuY2ggZm9yIGtleGVjLXRvb2xzOgo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9zdWdhcmZpbGxldC9rZXhlYy10b29scy9jb21taXRzL3J2LUltYWdl
Cj4gCj4gVGhlIGZpcnN0IGZvdXIgcGF0Y2hlcyBmaXhlcyBzb21lIGJ1aWxkIG9yIHJ1bnRpbWUg
aXNzdWVzOiAgCj4gCj4gICBSSVNDLVY6IFVzZSBsaW51eCx1c2FibGUtbWVtb3J5LXJhbmdlIGZv
ciBjcmFzaCBrZXJuZWwKPiAgIFJJU0MtVjogRml4IHRoZSB1bmRlY2xhcmVkIOKAmEVNX1JJU0NW
4oCZIGJ1aWxkIGZhaWx1cmUKPiAgIFJJU0MtVjogR2V0IG1lbW9yeSByYW5nZXMgZnJvbSBpb21l
bQo+ICAgUklTQy1WOiBDb3JyZWN0IHRoZSB1c2FnZSBvZiBjb21tYW5kIGxpbmUgb3B0aW9uCj4g
Cj4gVGhlIGxhc3QgdGhyZWUgcGF0Y2hlcyBlbmFibGUgdGhlIGtleGVjX2ZpbGVfbG9hZCBzeXNj
YWxsIHRvIGxvYWQKPiB2bWxpbnV4IGFuZCBzdXBwb3J0IGxvYWRpbmcgSW1hZ2UgYmluYXJ5IGZp
bGUgZm9yIHR3byBzeXNjYWxscy4KPiAKPiAgIFJJU0MtVjogRW5hYmxlIGtleGVfZmlsZV9sb2Fk
Cj4gICBSSVNDLVY6IFNlcGFyYXRlIGVsZl9yaXNjdl9maW5kX3BiYXNlIG91dAo+ICAgUklTQy1W
OiBTdXBwb3J0IGxvYWRpbmcgSW1hZ2UgYmluYXJ5IGZpbGUKPiAKPiBOb3RlIHRoYXQ6IAo+IAo+
IFJJU0MtViBMaW51eCBrZXhlY19sb2FkX2ZpbGUncyBzdXBwb3J0IGZvciBJbWFnZSBmaWxlIGhh
cyBiZWVuIHNlbnQgb3V0IGJ1dCBub3QgbWVyZ2VkIFsxXS4KPiAKPiBbMV06IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LXJpc2N2LzIwMjMwOTE0MDIwMDQ0LjEzOTczNTYtMS1zb25nc2h1
YWlzaHVhaUB0aW55bGFiLm9yZy9ULyN0IAo+IAo+IExpIFpoZW5neXUgKDEpOgo+ICAgUklTQy1W
OiBFbmFibGUga2V4ZV9maWxlX2xvYWQKPiAKPiBTb25nIFNodWFpICg2KToKPiAgIFJJU0MtVjog
VXNlIGxpbnV4LHVzYWJsZS1tZW1vcnktcmFuZ2UgZm9yIGNyYXNoIGtlcm5lbAo+ICAgUklTQy1W
OiBGaXggdGhlIHVuZGVjbGFyZWQg4oCYRU1fUklTQ1bigJkgYnVpbGQgZmFpbHVyZQo+ICAgUklT
Qy1WOiBHZXQgbWVtb3J5IHJhbmdlcyBmcm9tIGlvbWVtCj4gICBSSVNDLVY6IENvcnJlY3QgdGhl
IHVzYWdlIG9mIGNvbW1hbmQgbGluZSBvcHRpb24KPiAgIFJJU0MtVjogU2VwYXJhdGUgZWxmX3Jp
c2N2X2ZpbmRfcGJhc2Ugb3V0Cj4gICBSSVNDLVY6IFN1cHBvcnQgbG9hZGluZyBJbWFnZSBiaW5h
cnkgZmlsZQo+IAo+ICBrZXhlYy9hcmNoL3Jpc2N2L01ha2VmaWxlICAgICAgICAgICAgfCAgIDIg
Kwo+ICBrZXhlYy9hcmNoL3Jpc2N2L2NyYXNoZHVtcC1yaXNjdi5jICAgfCAgIDIgKy0KPiAga2V4
ZWMvYXJjaC9yaXNjdi9pbWFnZS1oZWFkZXIuaCAgICAgIHwgIDg4ICsrKysrKysrKysrKysrCj4g
IGtleGVjL2FyY2gvcmlzY3YvaW9tZW0uaCAgICAgICAgICAgICB8ICAxMCArKwo+ICBrZXhlYy9h
cmNoL3Jpc2N2L2tleGVjLWVsZi1yaXNjdi5jICAgfCAgNzcgKy0tLS0tLS0tLS0tCj4gIGtleGVj
L2FyY2gvcmlzY3Yva2V4ZWMtaW1hZ2UtcmlzY3YuYyB8ICA5NSArKysrKysrKysrKysrKysKPiAg
a2V4ZWMvYXJjaC9yaXNjdi9rZXhlYy1yaXNjdi5jICAgICAgIHwgMTc2ICsrKysrKysrKysrKysr
KysrKysrKystLS0tLQo+ICBrZXhlYy9hcmNoL3Jpc2N2L2tleGVjLXJpc2N2LmggICAgICAgfCAg
MjEgKysrKwo+ICBrZXhlYy9rZXhlYy1zeXNjYWxsLmggICAgICAgICAgICAgICAgfCAgIDMgKwo+
ICA5IGZpbGVzIGNoYW5nZWQsIDM2OCBpbnNlcnRpb25zKCspLCAxMDYgZGVsZXRpb25zKC0pCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBrZXhlYy9hcmNoL3Jpc2N2L2ltYWdlLWhlYWRlci5oCj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBrZXhlYy9hcmNoL3Jpc2N2L2lvbWVtLmgKPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGtleGVjL2FyY2gvcmlzY3Yva2V4ZWMtaW1hZ2UtcmlzY3YuYwo+IAo+IC0tIAo+IDIu
MjAuMQo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
