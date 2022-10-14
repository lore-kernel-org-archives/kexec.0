Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DA5C4332F
	for <kexec@archiver.kernel.org>; Fri, 14 Oct 2022 13:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FV8Fk3tnjRY1UA4m6hT0JEXJq8iHrhWbUIWfYJqpN7E=; b=UeAFtc73MEZNFM
	zoIPLCCt4d7RNPYC97LRspPHPYe4+hvl7gamVNr4uB6nbqOWedduncixpR5xgmktp6aw+KnC8jRiU
	Aw+iwrxnPykWV+s5Zi28a3NpKmzTP8WVAdczRpBy5I8AEI0knM+vjjrYjTxnstF9uDXnNbvKc0PFL
	1eqltfdTBwt6agI7MSZ8Hsyo7IO15SuNNcJv+eEozMWNRfCb6+joaUPiCkunarzX3A27goJkpBsgc
	AJAGD5xguwRdypZwf61VhU2wg9dCRBPsJJ6m/H5VejWyyqykUfgO3sNSPavl731Qx77Rud32nvj0s
	U+/DY3/+bYN9v46DMtnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojKz8-00Eou6-7J; Fri, 14 Oct 2022 13:44:22 +0000
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojKz4-00EosY-KO; Fri, 14 Oct 2022 13:44:20 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VS88kYV_1665755050;
Received: from 30.39.198.88(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VS88kYV_1665755050)
          by smtp.aliyun-inc.com;
          Fri, 14 Oct 2022 21:44:12 +0800
Message-ID: <cda77a7f-470d-21eb-f5ec-dac004b32bc5@linux.alibaba.com>
Date: Fri, 14 Oct 2022 21:44:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] Documentation: kdump: describe VMCOREINFO export for
 RISCV64
To: Bagas Sanjaya <bagasdotme@gmail.com>, Conor Dooley <conor@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 anup@brainfault.org, heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
 alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
 k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221014074810.4471-1-xianting.tian@linux.alibaba.com>
 <20221014074810.4471-3-xianting.tian@linux.alibaba.com>
 <Y0ldrJ91ac0um3++@debian.me> <Y0lfuixXue4k4poY@spud>
 <7353e949-17cc-ed8e-7e98-b3f3e0840623@gmail.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <7353e949-17cc-ed8e-7e98-b3f3e0840623@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221014_064418_854042_25310157 
X-CRM114-Status: UNSURE (   7.76  )
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

CuWcqCAyMDIyLzEwLzE0IOS4i+WNiDk6MjMsIEJhZ2FzIFNhbmpheWEg5YaZ6YGTOgo+IE9uIDEw
LzE0LzIyIDIwOjEwLCBDb25vciBEb29sZXkgd3JvdGU6Cj4+IFdpdGhvdXQgd2hpdGVzcGFjZSBo
aWdobGlnaHRpbmcsIHlvdXIgY2hhbmdlIHRocmV3IG1lIGZvciBhIHNlYy4uIEJ1dAo+PiB5ZWFo
LCBoYXZpbmcgdGhlIG92ZXJsaW5lIGlzIGluY29uc2lzdGVudCB3aXRoIG90aGVyIGhlYWRpbmdz
IGluIHRoZQo+PiBkb2MuCj4+Cj4+IFdoYXQgSSB3YW50ZWQgdG8gYXNrIGFib3V0IHdhcyB0aGUg
bGluZWxlbmd0aCBhcyBJIGRvbid0IGtub3cgYW55dGhpbmcKPj4gYWJvdXQgcnN0LiBJcyBpdCBw
b3NzaWJsZSB0byBhdm9pZCBoYXZpbmcgdGhlIH4xNTAgY2hhcmFjdGVyIGxpbmUgb3IgaXMKPj4g
dGhhdCBhIG5lY2Vzc2FyeSBldmlsPwo+Pgo+IEkgdGhpbmsgdGhlIHNlY3Rpb24gZGVzY3JpYmVz
IGNvcnJlY3QgcmFuZ2UgZXhwb3J0czsgaG93ZXZlciBzaW5jZSB0aGVyZQo+IGFyZSBtYW55IHN1
Y2ggcmFuZ2VzIHdpdGggZGlzdGluY3QgcHVycG9zZXMsIGl0IGlzIGJldHRlciB0byBzcGxpdCB0
aGUKPiBzZWN0aW9uIGludG8gbXVsdGlwbGUgc2VjdGlvbnMgZGVzY3JpYmluZyBlYWNoIHJhbmdl
Lgo+Cj4gSWYgd2UgZ28gd2l0aG91dCBzcGxpdHRpbmcsIHRoZSAxNTAtY2hhcmFjdGVyIGhlYWRl
ciBpcyBuZWNlc3NhcnkgKEkgZG9uJ3QKPiBrbm93IGhvdyB0byBzcGxpdCB0aGUgaGVhZGVyIHRl
eHQgbGluZSB3aXRob3V0IHRyaWdnZXIgYW55IHdhcm5pbmdzKS4KCnRoYW5rcywgSSBzZW5kIFYy
IHBhdGNoLCBwbGVhc2UgaGVscCByZXZpZXcuCgpodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMi8x
MC8xNC80NDcKCj4KPiBUaGFua3MuCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
