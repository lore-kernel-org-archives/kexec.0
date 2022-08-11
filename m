Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAE2C00140
	for <kexec@archiver.kernel.org>; Thu, 11 Aug 2022 03:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yUla4zazo/cQ7ODLsGtEpw+VVHYXJH9B2rvT0n9KYag=; b=2DYv/qzzYrzZRvOAFgKej5yEXi
	dh2pXha+7/5Cq1/zT6LpfqU8T8RVhBvBm2AmJojHTS10/MiZgKLTTVX97ovg5fS4jiZIfuZ8qZ1N2
	dNT4KdQeNElhINx1u5fML65QAnDE7xOjWDbewUILISl5OPPzNmDAJpqb35dwS+XKnfuSixx+94DOD
	AbPLgWolZ7mljCn7BksDx8FjVULiunXbUtZKz0/mpsuLEhh1CizxWxbq0cTg0p8m3BQZKriWh8shE
	2i6ICvXStT6X+J+Y02VId2vJEsXBWy2JXoNCCBTO9mOTOjoSi5Kg96FxWh/9DZ/ctHCJwAxRh4++I
	vGnn2dHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLz0y-004sWu-5D; Thu, 11 Aug 2022 03:37:44 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLz0u-004sVs-8T; Thu, 11 Aug 2022 03:37:42 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VLxQ5Q3_1660189052;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VLxQ5Q3_1660189052)
          by smtp.aliyun-inc.com;
          Thu, 11 Aug 2022 11:37:34 +0800
Subject: Re: [PATCH V5 5/6] riscv: crash_core: Export kernel vm layout,
 phys_ram_base
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 anup@brainfault.org, heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
 alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
 heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
 hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-6-xianting.tian@linux.alibaba.com>
 <YvRyT5f5uH7LBs4H@debian.me>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <81bf1acd-307c-b093-44c2-280c70f44e08@linux.alibaba.com>
Date: Thu, 11 Aug 2022 11:37:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YvRyT5f5uH7LBs4H@debian.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_203740_490688_629BC2C8 
X-CRM114-Status: GOOD (  15.02  )
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

CuWcqCAyMDIyLzgvMTEg5LiK5Y2IMTE6MDYsIEJhZ2FzIFNhbmpheWEg5YaZ6YGTOgo+IE9uIFR1
ZSwgQXVnIDAyLCAyMDIyIGF0IDA4OjE4OjE3UE0gKzA4MDAsIFhpYW50aW5nIFRpYW4gd3JvdGU6
Cj4+IFRoZXNlIGluZm9zIGFyZSBuZWVkZWQgYnkgdGhlIGtkdW1wIGNyYXNoIHRvb2wuIFNpbmNl
IHRoZXNlIHZhbHVlcyBjaGFuZ2UKPj4gZnJvbSB0aW1lIHRvIHRpbWUsIGl0IGlzIHByZWZlcmFi
bGUgdG8gZXhwb3J0IHRoZW0gdmlhIHZtY29yZWluZm8gdGhhbiB0bwo+PiBjaGFuZ2UgdGhlIGNy
YXNoJ3MgY29kZSBmcmVxdWVudGx5Lgo+Pgo+IEkgaGF2ZSB0byBhZ3JlZSB3aXRoIENvbm9yLkRv
b2xleSwgdGhhdCB0aGlzIHBhdGNoIGlzIG1pc2xlYWRpbmcgKEkgc2VlCj4gZG9jdW1lbnRhdGlv
biBpbnN0ZWFkIG9mIHJlYWwgZXhwb3J0KS4gU28gSU1PLCB0aGUgcGF0Y2ggc3ViamVjdCBzaG91
bGQKPiBiZSAiRG9jdW1lbnRhdGlvbjoga2R1bXA6IGRlc2NyaWJlIFZNQ09SRUlORk8gZXhwb3J0
IGZvciBSSVNDVjY0Ii4KPgo+IEZvciBNT0RVTEVTX1ZBRERSIGFuZCBmcmllbmRzLCB0aGUgZG9j
IGNhbiBiZSBpbXByb3ZlZCwgbGlrZToKPgo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Fk
bWluLWd1aWRlL2tkdW1wL3ZtY29yZWluZm8ucnN0IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlk
ZS9rZHVtcC92bWNvcmVpbmZvLnJzdAo+IGluZGV4IDZiNzYyODRhNTAzY2E1Li42Njk0YWNjMzJj
MzU4OCAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tkdW1wL3ZtY29y
ZWluZm8ucnN0Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC92bWNvcmVp
bmZvLnJzdAo+IEBAIC02MTUsMTQgKzYxNSwxMyBAQCBwaHlzX3JhbV9iYXNlCj4gICAKPiAgIElu
ZGljYXRlcyB0aGUgc3RhcnQgcGh5c2ljYWwgUkFNIGFkZHJlc3MuCj4gICAKPiAtTU9EVUxFU19W
QUREUnxNT0RVTEVTX0VORHxWTUFMTE9DX1NUQVJUfFZNQUxMT0NfRU5EfFZNRU1NQVBfU1RBUlR8
Vk1FTU1BUF9FTkQKPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAtS0FTQU5fU0hBRE9XX1NUQVJU
fEtBU0FOX1NIQURPV19FTkR8S0VSTkVMX0xJTktfQUREUnxBRERSRVNTX1NQQUNFX0VORAo+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCj4gK01PRFVMRVNfVkFERFJ8TU9EVUxFU19FTkR8Vk1BTExPQ19TVEFSVHxW
TUFMTE9DX0VORHxWTUVNTUFQX1NUQVJUfFZNRU1NQVBfRU5EfEtBU0FOX1NIQURPV19TVEFSVHxL
QVNBTl9TSEFET1dfRU5EfEtFUk5FTF9MSU5LX0FERFJ8QUREUkVTU19TUEFDRV9FTkQKPiArLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgCj4gICBVc2VkIHRvIGdldCB0aGUg
Y29ycmVjdCByYW5nZXM6Cj4gLQlNT0RVTEVTX1ZBRERSIH4gTU9EVUxFU19FTkQgOiBLZXJuZWwg
bW9kdWxlIHNwYWNlLgo+IC0JVk1BTExPQ19TVEFSVCB+IFZNQUxMT0NfRU5EIDogdm1hbGxvYygp
IC8gaW9yZW1hcCgpIHNwYWNlLgo+IC0JVk1FTU1BUF9TVEFSVCB+IFZNRU1NQVBfRU5EIDogdm1l
bW1hcCByZWdpb24sIHVzZWQgZm9yIHN0cnVjdCBwYWdlIGFycmF5Lgo+IC0JS0FTQU5fU0hBRE9X
X1NUQVJUIH4gS0FTQU5fU0hBRE9XX0VORCA6IGthc2FuIHNoYWRvdyBzcGFjZS4KPiAtCUtFUk5F
TF9MSU5LX0FERFIgfiBBRERSRVNTX1NQQUNFX0VORCA6IEtlcm5lbCBsaW5rIGFuZCBCUEYgc3Bh
Y2UuCj4gKwo+ICsgICogTU9EVUxFU19WQUREUiB+IE1PRFVMRVNfRU5EIDogS2VybmVsIG1vZHVs
ZSBzcGFjZS4KPiArICAqIFZNQUxMT0NfU1RBUlQgfiBWTUFMTE9DX0VORCA6IHZtYWxsb2MoKSAv
IGlvcmVtYXAoKSBzcGFjZS4KPiArICAqIFZNRU1NQVBfU1RBUlQgfiBWTUVNTUFQX0VORCA6IHZt
ZW1tYXAgcmVnaW9uLCB1c2VkIGZvciBzdHJ1Y3QgcGFnZSBhcnJheS4KPiArICAqIEtBU0FOX1NI
QURPV19TVEFSVCB+IEtBU0FOX1NIQURPV19FTkQgOiBrYXNhbiBzaGFkb3cgc3BhY2UuCj4gKyAg
KiBLRVJORUxfTElOS19BRERSIH4gQUREUkVTU19TUEFDRV9FTkQgOiBLZXJuZWwgbGluayBhbmQg
QlBGIHNwYWNlLgpUaGFua3MgZm9yIHRoZSBjb21tZW50LCBJIHdpbGwgZml4IGl0IGluIFY2Cj4K
PiBUaGFua3MuCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
