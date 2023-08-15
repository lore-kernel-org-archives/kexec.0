Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F26C001E0
	for <kexec@archiver.kernel.org>; Tue, 15 Aug 2023 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Qs0ml9WqI483JBvH4RXONEm7L+hzMVdxV7coB/xpEn4=; b=l7gmj+sUVryNtT
	KVUQnya52j2zmVxjZYUtGVJfxvpirlsK+Yvb2yJgg8nAEbGUT5zMOrO8OUIp/LxwJPQcleuU/o9kK
	b1ItYZ/2vccD/s+953xg7F5tEoRwlBre5ZI8lbhZJWs8u14ArMeJrx9s5etxvXmB9wkGXItpOtAyp
	xBjssKK1fyAag6+RvvWqYwgQmtE+fdmGCb1Qxg7eE8kn9zYJwxaDxU9OWVH+4dLs3zAakXP+74MJP
	D4rIz3FBPiVbtxSvivMecymc2TTHV/z7odMHAjX8It0Kpl/TxPmiwvQRoVGcHoOAEoyIKOFg/2mYN
	i0ZE4m516iNaiUCb4YKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVrdE-001KND-2S;
	Tue, 15 Aug 2023 10:50:36 +0000
Received: from bg4.exmail.qq.com ([43.155.67.158])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVrdA-001KKd-2A;
	Tue, 15 Aug 2023 10:50:35 +0000
X-QQ-mid: bizesmtp78t1692096533tqw77zvr
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Aug 2023 18:48:51 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: rZJGTgY0+YMW5DdpUqE/uxFUSfrDxy1/9tAZByanbxvWWIqR870ykuNueNqb6
	LIDON3wk2mEk441WvWfQUBxKoWj2/m51tF/enBR4D8JLRHifnfJPhTBIUj7bbGFyFBMNbva
	0Fj6l0cg8SMyKEt0Q4kD7Wq8ujsi0s8Vpzz/UzXfij/mXgu699rYly19VF5D4s/+uii7kX4
	B1HLjcvregTDZIjaasVqei3sy+rrMJJvw62r/LRYwMLODvy3XvgBbhqhMEt/0tHBc6JdpeO
	kvVlF2PHCeOR276sw1JUM8u7lW3yWKddqN04/bQDZ/8fIi9SITaYBYV78WNW1VnC0YCC0o+
	lack9p9DAiXbeMS1dbHou0AXk9300jRX1IkXCBaEySIVyLAqgrr21Nwblk0/A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7910942497712437719
From: Song Shuai <songshuaishuai@tinylab.org>
To: xianting.tian@linux.alibaba.com,
	mick@ics.forth.gr,
	heinrich.schuchardt@canonical.com,
	guoren@kernel.org,
	k-hagio-ab@nec.com,
	yixun.lan@gmail.com,
	lijiang@redhat.com
Cc: linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org,
	crash-utility@redhat.com,
	Song Shuai <suagrfillet@gmail.com>
Subject: [Crash-utility PATCH] RISCV64: Add KASLR support
Date: Tue, 15 Aug 2023 18:48:00 +0800
Message-Id: <20230815104800.705753-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230815_035033_036450_E7811295 
X-CRM114-Status: GOOD (  14.72  )
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

RnJvbTogU29uZyBTaHVhaSA8c3VhZ3JmaWxsZXRAZ21haWwuY29tPgoKVGhpcyBwYXRjaCBhZGRz
IEtBU0xSIHN1cHBvcnQgZm9yIENyYXNoIHRvIGFuYWx5emUgS0FTTFItZWQgdm1jb3JlCnNpbmNl
IFJJU0MtViBMaW51eCBpcyBhbHJlYWR5IHN1ZmZpY2llbnRseSBwcmVwYXJlZCBmb3IgS0FTTFIg
WzFdLgoKV2l0aCB0aGlzIHBhdGNoLCBldmVuIGlmIHRoZSBDcmFzaCAnLS1rYXNscicgb3B0aW9u
IGlzIG5vdCBzZXQgb3IgTGludXgKQ09ORklHX1JBTkRPTUlaRV9CQVNFIGlzIG5vdCBjb25maWd1
cmVkLCB0aGUgJ2Rlcml2ZV9rYXNscl9vZmZzZXQoKScKZnVuY3Rpb24gd2lsbCBhbHdheXMgd29y
a8KgdG8gY2FsY3VsYXRlICdrdC0+cmVsb2NhdGUnIHdoaWNoIHNlcnZlcyB0bwp1cGRhdGUgdGhl
IGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3MuCgpbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LXJpc2N2LzIwMjMwNzIyMTIzODUwLjYzNDU0NC0xLWFsZXhnaGl0aUByaXZvc2luYy5jb20v
CgpTaWduZWQtb2ZmLWJ5OiBTb25nIFNodWFpIDxzdWFncmZpbGxldEBnbWFpbC5jb20+Ci0tLQog
bWFpbi5jICAgIHwgIDIgKy0KIHJpc2N2NjQuYyB8IDExICsrKysrKysrKysrCiBzeW1ib2xzLmMg
fCAgNCArKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvbWFpbi5jIGIvbWFpbi5jCmluZGV4IGIyNzhjMjIuLjBjNmU1OTUg
MTAwNjQ0Ci0tLSBhL21haW4uYworKysgYi9tYWluLmMKQEAgLTIyOCw3ICsyMjgsNyBAQCBtYWlu
KGludCBhcmdjLCBjaGFyICoqYXJndikKIAkJCX0gZWxzZSBpZiAoU1RSRVEobG9uZ19vcHRpb25z
W29wdGlvbl9pbmRleF0ubmFtZSwgImthc2xyIikpIHsKIAkJCQlpZiAoIW1hY2hpbmVfdHlwZSgi
WDg2XzY0IikgJiYKIAkJCQkgICAgIW1hY2hpbmVfdHlwZSgiQVJNNjQiKSAmJiAhbWFjaGluZV90
eXBlKCJYODYiKSAmJgotCQkJCSAgICAhbWFjaGluZV90eXBlKCJTMzkwWCIpKQorCQkJCSAgICAh
bWFjaGluZV90eXBlKCJTMzkwWCIpICYmICFtYWNoaW5lX3R5cGUoIlJJU0NWNjQiKSkKIAkJCQkJ
ZXJyb3IoSU5GTywgIi0ta2FzbHIgbm90IHZhbGlkICIKIAkJCQkJCSJ3aXRoIHRoaXMgbWFjaGlu
ZSB0eXBlLlxuIik7CiAJCQkJZWxzZSBpZiAoU1RSRVEob3B0YXJnLCAiYXV0byIpKQpkaWZmIC0t
Z2l0IGEvcmlzY3Y2NC5jIGIvcmlzY3Y2NC5jCmluZGV4IGEwMmY3NWEuLjI4OGM3YWUgMTAwNjQ0
Ci0tLSBhL3Jpc2N2NjQuYworKysgYi9yaXNjdjY0LmMKQEAgLTM3OCw2ICszNzgsOSBAQCBzdGF0
aWMgdm9pZCByaXNjdjY0X2dldF92YV9yYW5nZShzdHJ1Y3QgbWFjaGluZV9zcGVjaWZpYyAqbXMp
CiAJfSBlbHNlCiAJCWdvdG8gZXJyb3I7CiAKKwlpZiAoKGt0LT5mbGFnczIgJiBLQVNMUikgJiYg
KGt0LT5mbGFncyAmIFJFTE9DX1NFVCkpCisJCW1zLT5rZXJuZWxfbGlua19hZGRyICs9IChrdC0+
cmVsb2NhdGUgKiAtMSk7CisKIAkvKgogCSAqIEZyb20gTGludXggNS4xMywgdGhlIGtlcm5lbCBt
YXBwaW5nIGlzIG1vdmVkIHRvIHRoZSBsYXN0IDJHQgogCSAqIG9mIHRoZSBhZGRyZXNzIHNwYWNl
LCBtb2R1bGVzIHVzZSB0aGUgMkdCIG1lbW9yeSByYW5nZSByaWdodApAQCAtMTM2MCw2ICsxMzYz
LDE0IEBAIHJpc2N2NjRfaW5pdChpbnQgd2hlbikKIAogCQltYWNoZGVwLT52ZXJpZnlfcGFkZHIg
PSBnZW5lcmljX3ZlcmlmeV9wYWRkcjsKIAkJbWFjaGRlcC0+cHRyc19wZXJfcGdkID0gUFRSU19Q
RVJfUEdEOworCisJCS8qCisJCSAqIEV2ZW4gaWYgQ09ORklHX1JBTkRPTUlaRV9CQVNFIGlzIG5v
dCBjb25maWd1cmVkLAorCQkgKiBkZXJpdmVfa2FzbHJfb2Zmc2V0KCkgc2hvdWxkIHdvcmsgYW5k
IHNldAorCQkgKiBrdC0+cmVsb2NhdGUgdG8gMAorCQkgKi8KKwkJaWYgKCFrdC0+cmVsb2NhdGUg
JiYgIShrdC0+ZmxhZ3MyICYgKFJFTE9DX0FVVE98S0FTTFIpKSkKKwkJCWt0LT5mbGFnczIgfD0g
KFJFTE9DX0FVVE98S0FTTFIpOwogCQlicmVhazsKIAogCWNhc2UgUFJFX0dEQjoKZGlmZiAtLWdp
dCBhL3N5bWJvbHMuYyBiL3N5bWJvbHMuYwppbmRleCA4NzZiZTdhLi44ZThiNGMzIDEwMDY0NAot
LS0gYS9zeW1ib2xzLmMKKysrIGIvc3ltYm9scy5jCkBAIC02MjksNyArNjI5LDcgQEAga2FzbHJf
aW5pdCh2b2lkKQogCWNoYXIgKnN0cmluZzsKIAogCWlmICgoIW1hY2hpbmVfdHlwZSgiWDg2XzY0
IikgJiYgIW1hY2hpbmVfdHlwZSgiQVJNNjQiKSAmJiAhbWFjaGluZV90eXBlKCJYODYiKSAmJgot
CSAgICAhbWFjaGluZV90eXBlKCJTMzkwWCIpKSB8fCAoa3QtPmZsYWdzICYgUkVMT0NfU0VUKSkK
KwkgICAgIW1hY2hpbmVfdHlwZSgiUzM5MFgiKSAmJiAhbWFjaGluZV90eXBlKCJSSVNDVjY0Iikp
IHx8IChrdC0+ZmxhZ3MgJiBSRUxPQ19TRVQpKQogCQlyZXR1cm47CiAKIAlpZiAoIWt0LT52bWNv
cmVpbmZvLl9zdGV4dF9TWU1CT0wgJiYKQEAgLTc5NSw3ICs3OTUsNyBAQCBzdG9yZV9zeW1ib2xz
KGJmZCAqYWJmZCwgaW50IGR5bmFtaWMsIHZvaWQgKm1pbmlzeW1zLCBsb25nIHN5bWNvdW50LAog
CQl9IGVsc2UgaWYgKCEoa3QtPmZsYWdzICYgUkVMT0NfU0VUKSkKIAkJCWt0LT5mbGFncyB8PSBS
RUxPQ19GT1JDRTsKIAl9IGVsc2UgaWYgKG1hY2hpbmVfdHlwZSgiWDg2XzY0IikgfHwgbWFjaGlu
ZV90eXBlKCJBUk02NCIpIHx8Ci0JCSAgIG1hY2hpbmVfdHlwZSgiUzM5MFgiKSkgeworCQkgICBt
YWNoaW5lX3R5cGUoIlMzOTBYIikgfHwgbWFjaGluZV90eXBlKCJSSVNDVjY0IikpIHsKIAkJaWYg
KChrdC0+ZmxhZ3MyICYgUkVMT0NfQVVUTykgJiYgIShrdC0+ZmxhZ3MgJiBSRUxPQ19TRVQpKQog
CQkJZGVyaXZlX2thc2xyX29mZnNldChhYmZkLCBkeW5hbWljLCBmcm9tLAogCQkJCWZyb21lbmQs
IHNpemUsIHN0b3JlKTsKLS0gCjIuMjAuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
