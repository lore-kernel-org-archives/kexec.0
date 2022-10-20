Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1558BC43219
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 02:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0XjKkxwUnibfHU7wym8Q5czmyPDiW6IPDqbaV9gGjgI=; b=TD9Ti3UzE/EDa9
	ZKYRIUetiJDWgV9x7KKSaldicqBqjqvUNtI6korWbCuibR7rlCz0S9l+C02p+JNVsKF4PTALyaCNa
	jEgLHi8evXwhYEOrtRmtmfNSb6EDX+GNJsm18vn4S4FioUhl06L8rn1Z6tYtZ7Z+XA1Os6yWkXUnL
	Lj4NNm3XXoqEv4BqK2qS/MsqjcH04Gse87kLf3SA0Z9JvupQOHVz3Ahkx+2n7kle7kIBugjY+InkD
	NOapAhIguHoTn0HWAhA/sVSK4ejwPGtctzZ1BmSi4NVSynM/n+s1mS4ZvtB/fTtII/t7N64I8RE2M
	/HhnhMd+zwmWxRYgvdOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olLGb-009RIQ-Jl; Thu, 20 Oct 2022 02:26:41 +0000
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olLGW-009RHj-B4; Thu, 20 Oct 2022 02:26:40 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VScpkGP_1666232788;
Received: from 30.221.97.125(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VScpkGP_1666232788)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 10:26:29 +0800
Message-ID: <cc713fb3-371f-ffb9-d0d3-6bb4da776398@linux.alibaba.com>
Date: Thu, 20 Oct 2022 10:26:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V4 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
To: Bagas Sanjaya <bagasdotme@gmail.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
 heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
 alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
 k-hagio-ab@nec.com, lijiang@redhat.com
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
 hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221019103623.7008-1-xianting.tian@linux.alibaba.com>
 <20221019103623.7008-3-xianting.tian@linux.alibaba.com>
 <26810115-1325-faf2-0f6e-0d7ff164982d@gmail.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <26810115-1325-faf2-0f6e-0d7ff164982d@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_192638_705033_64E3924A 
X-CRM114-Status: UNSURE (   5.58  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CuWcqCAyMDIyLzEwLzIwIOS4iuWNiDk6NTYsIEJhZ2FzIFNhbmpheWEg5YaZ6YGTOgo+IE9uIDEw
LzE5LzIyIDE3OjM2LCBYaWFudGluZyBUaWFuIHdyb3RlOgo+PiBUaGUgZm9sbG93aW5nIGludGVy
cmVsYXRlZCBkZWZpbml0aW9ucyBhbmQgcmFuZ2VzIGFyZSBuZWVkZWQgYnkgdGhlIGtkdW1wCj4+
IGNyYXNoIHRvb2wsIHdoaWNoIGFyZSBleHBvcnRlZCBieSAiYXJjaC9yaXNjdi9rZXJuZWwvY3Jh
c2hfY29yZS5jIjoKPj4gICAgICBWQV9CSVRTLAo+PiAgICAgIFBBR0VfT0ZGU0VULAo+PiAgICAg
IHBoeXNfcmFtX2Jhc2UsCj4+ICAgICAgS0VSTkVMX0xJTktfQUREUiwKPj4gICAgICBNT0RVTEVT
X1ZBRERSIH4gTU9EVUxFU19FTkQsCj4+ICAgICAgVk1BTExPQ19TVEFSVCB+IFZNQUxMT0NfRU5E
LAo+PiAgICAgIFZNRU1NQVBfU1RBUlQgfiBWTUVNTUFQX0VORCwKPj4KPj4gRG9jdW1lbnQgdGhl
c2UgUklTQ1Y2NCBleHBvcnRzIGFib3ZlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBYaWFudGluZyBU
aWFuIDx4aWFudGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tPgo+IEhpIFhpYW50aW5nLAo+Cj4g
U2VlbXMgbGlrZSB5b3UgZm9yZ290IHRvIGtlZXAgY2FycnlpbmcgbXkgUmV2aWV3ZWQtYnkgZnJv
bSB2MyBbMV0uCj4gQW55d2F5LCBoZXJlIGl0IGdvZXMuLi4KPgo+IFJldmlld2VkLWJ5OiBCYWdh
cyBTYW5qYXlhIDxiYWdhc2RvdG1lQGdtYWlsLmNvbT4KU29ycnksIEkgZm9yZ290Li4uIDooCj4K
PiBUaGFua3MuCj4KPiBbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWRvYy8yMDIy
MTAxODA4MTc1NS42MjE0LTMteGlhbnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNvbS8KPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
