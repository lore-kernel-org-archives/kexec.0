Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91881E95A91
	for <kexec@archiver.kernel.org>; Mon,  9 Oct 2023 09:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=J3qpkbbjvWgHlGeQvQSPv1wKmiDDLr6OZsWUaetJ//k=; b=aiON/1SF+paIY9
	8urCu767S1Bhl68VqEOCYR6qwGG4Lu6YOwu/Ka0lck6Zw84Bh8mDxoeC5N0hzYdFpcyh0ILPDuQ+U
	gO8I2HrIa2AaRFCC2ZJMsBAgTVx50s1qM2PXwqP8pEBIDsslQsd5JBkUIAT8gQAiFWn3vq5Mt2PM3
	6rcEY78+lOaaVl8bLK6X33qT03I1QvJnAgeQtZNqkdhShoixLahNLTcGp420P5VAdHMViUZ6f7grs
	n4el0ecUZfapg0LBcFzaLAhrhJAja+S7E7+zulWgtIz8w30nn7X9VimKKiXemPwgc7Nfdg4kskpr/
	n+qDobUEP1/wf8lhPGdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpn38-00A9ON-1A;
	Mon, 09 Oct 2023 09:59:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpn35-00A9OD-2b
	for kexec@bombadil.infradead.org;
	Mon, 09 Oct 2023 09:59:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Subject:Cc:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=NF0NRYwOjrfOVeRra+W3z4/bDnmndPyW1zjkxhuai5c=; b=bpIGAvkYms1B47y9WBUNOyzVx5
	npLJ9BX0vXLsjJRR20l7X9lrioGoeSiYozl2lgs+bJ64Kn+dWm9UJWaBJUrwEpy5ub4DZUHVdWVgm
	ksuc6fTobXPEkCwp+Cpr5pREV81MmtSoKIDMj6TcIxOp9tQ0+61IpqxEKEl+GJgzKp0Mi4taxob7S
	W07dGc1mefcq8x9nFq9leZ0PVrlPwxEYxfwUHGPi4egP64/YFE6PP2tl76rrrZXmTllZWjMTla3r+
	gyOkwK5I/MO2mJxHug0Udu4j01exlmpoHphNaivUuidkK/KgNqcn5Y0tT7dWirHhkioEJKBSCSDYS
	gJ0YhupQ==;
Received: from mail.loongson.cn ([114.242.206.163])
	by desiato.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpn2y-00Flu7-0j
	for kexec@lists.infradead.org;
	Mon, 09 Oct 2023 09:59:37 +0000
Received: from loongson.cn (unknown [111.207.111.194])
	by gateway (Coremail) with SMTP id _____8DxPOvzziNlp0EwAA--.21756S3;
	Mon, 09 Oct 2023 17:59:16 +0800 (CST)
Received: from [10.180.13.92] (unknown [111.207.111.194])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLC_yziNl6YUcAA--.2723S2;
	Mon, 09 Oct 2023 17:59:14 +0800 (CST)
Message-ID: <41eb6420-915a-4746-8fe9-8778a46d9479@loongson.cn>
Date: Mon, 9 Oct 2023 17:59:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Ming Wang <wangming01@loongson.cn>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Subject: [kexec-tools] Archive file is missed iomem.h file under loongarch
 architecture.
X-CM-TRANSID: AQAAf8CxLC_yziNl6YUcAA--.2723S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAQATEmUjYyUFAgADsE
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jr4DXr43Ww43Aw18XFyDXFc_yoW3JFg_Xa
	4Iv3WDKwnavFWDWa10g34SgasIqaykXrn8KFWSqrZxCw1rJwn8Wrs0v3Z5AFsagFyvqFs5
	JFW0q3s8K3yDKosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07
	x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jbYFAUUUUU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_105934_732098_42A0D494 
X-CRM114-Status: UNSURE (   4.22  )
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

SGkswqAgbWFpbnRhaW5lcnMsCgoKSSBnZXQgdGhlIGtleGVjLXRvb2xzIDIuMC4yNyBmcm9tIGh0
dHA6Ly9rZXJuZWwub3JnL3B1Yi9saW51eC91dGlscy9rZXJuZWwva2V4ZWMva2V4ZWMtdG9vbHMt
Mi4wLjI3LnRhci5neizCoAoKQnV0IEkgbm90aWNlZCB0aGF0IHRoZSBrZXhlYy10b29scy0yLjAu
Mjcva2V4ZWMvYXJjaC9sb29uZ2FyY2gvaW9tZW0uaCBmaWxlIHdhcyBtaXNzaW5nIGZyb20KCnRo
aXMgYXJjaGl2ZS4KCgpUaGlzIGNhdXNlcyBidWlsZCBlcnJvcnMgaW4gbWFueSBkaXN0cmlidXRp
b25zLCBsaWtlIGRlYmlhbi7CoCBUaGUgZXJyb3IgbWVzc2FnZSBpcyBhcyBmb2xsb3dzLAoKbWFr
ZVsxXTogKioqIFtNYWtlZmlsZToxMjM6IGtleGVjL2FyY2gvbG9vbmdhcmNoL2NyYXNoZHVtcC1s
b29uZ2FyY2gub10gRXJyb3IgMQprZXhlYy9hcmNoL2xvb25nYXJjaC9rZXhlYy1sb29uZ2FyY2gu
YzoyNzoxMDogZmF0YWwgZXJyb3I6IGlvbWVtLmg6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkK
ICAgMjcgfCAjaW5jbHVkZSAiaW9tZW0uaCIKClNlZSBhbHNvOiBodHRwczovL2J1aWxkZC5kZWJp
YW4ub3JnL3N0YXR1cy9wYWNrYWdlLnBocD9wPWtleGVjLXRvb2xzJnN1aXRlPXNpZAoKCkNhbiB0
aGlzIGFyY2hpdmUgYmUgcmVwYWlyZWQgYW5kIHVwZGF0ZWQ/CgoKVGhhbmtzLApNaW5nCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
