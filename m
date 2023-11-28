Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0590C4167B
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 13:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Z4SbrnlLJDLhDuNl8mlI7P/OOkeEt5brW1COQPNr1U=; b=OWSMgCTpgle8fE
	AxGBk+MGJB82RHR5ECL3f31Y1qOPu+AvYrPcDmCpFC6uLrWYXI7gJMboG6VkKFtVi49ntujLKIEX0
	wRNh5r2BtZ4FEnrQ3ChtDdLTPmjM3O4mJ1Keg/notJGdDy3Rcx3iEPRJxLshh5PvC1qgkL3xjo1sE
	+PzgC1FQ/5Fom2NE0yGUTVIT66OIwD4/MAD1B/imA7ErPu4e4xm7+/ZFGQY8Cas4mlYtxEzCEyyd5
	awl7psUVeXb7gXyw/YE9Zjj6+3OspJz1gLZ3nUvUc6VhNmfjqZAjhfSf6tCnrMa2OoQbPDgirCvJl
	yt4vJg2u6beRS71Rim8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7yX8-005Q8m-2t;
	Tue, 28 Nov 2023 13:53:50 +0000
Received: from sonic304-21.consmr.mail.ne1.yahoo.com ([66.163.191.147])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7yX6-005Q7x-0g
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 13:53:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701179623; bh=FauI8fpf/CNgANuTPdYwuAuARRSWWVSTl36t3Qy63Lo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=TGCbb29ZlOrVyftAdAuJHqTzqPyfHMK8+9dCOuemn9f57pF5p7U2nV2pCZVoVpxlOpZOb0hawfkSNeaoco1Y8/Wy56gu8DaCR8uhn5PRAuPZ/YqGUW5YKbqYdIglcM5WWI/8aJY6j4pUMNRCR7AUiZ032mMOTeuBLRGuaRQtLSTGAaOhMaxrimZaKgDSuU4mXos9UH2CRd6JZhvgMt+w6jkqGFfLzRnwYXz0NMjeeaCZuaM7UmQw3czGbX/gyjDKhFtWld9wYizUy+LOYVjhma+rSR2J8D3cp3v8DTN7MTpWXZY0Hrc+k6+KkbzQVGmTQy/E9SAbE30hi32NvzInMQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701179623; bh=nRVT93Bi4WGbV5peCs1F9yqnl2egspOOkl1MkD7OCgf=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jZSc+HVL9xVi+w2g/vFU7fT0BR8vckAke/R1r6oN7n8IDLNPTcEOs8bzf5H8WobWnj46Ah/pSyvZTmRXSefNzXoWV65H4Ed0gUz6T/aWO0e5uJSBMgwHP59qVsP0UPpnjWX9NmxdjHAjd2VhlHdNhHsyY0OKai0UaSFbsx141IgKcPRnG/5Xnvo6rteM/PK6jpDx+AaUlNv0U0GRtgzO8oW0o+AxiNCXKAFwgLZX5mj3PEmeLSaUQ5NMhubioXdXDMPwfuYK+/EH+wXa7d3XMfQn+5ikynElxPp+U+JXhvaBl7OfcSLkSXlo9eeCnu0dzSOLQWdjGjdHUQzmUxjUFw==
X-YMail-OSG: yoFfnx8VM1l.SXckWZ4SPf0yffhAkCcnBHInopGIgHyAVgIUnqBXbuStB1EB03X
 p8B5E_YmUlZsMbmoCt2KcAaG.cM39_YaG36Ky2LrbKo2vmqqDsY82IqUFgjCS8HhohcWFV9Owl._
 K8rE2rpbFx3wYyAuggtWqWdm_x8_9ezk.fiugSCEoSAsA5CuFgnrc9zfR62xrrvbKxegMeL5XVVK
 bQwlI8NUmZWQ0NzMunZBTyeTx1AZBDDghfz4NcqvuOu_WuNJ6hWTk8N3lxLVh1CWC5Qu2P9IERmW
 yg1Uj9eK0JmRCTau9fwmILcF_3nJg.DE5eqdm.tg3aPaCOCjryIxEfLenNf.P4f3tnY7apgRsl7a
 KUTjHsFGFP6EFiIP8BNtlVsT8cbprKAjfwt2zTKVEcYrrcCsGhLqbiJ0OOkAv7zHU5JC1Ae8R2Yj
 nOII.o4Y.M_Ng9TuP5qh.fHuSxBS0acK0DgVyY7hWaV25P_Dq.ExnPNe3x_Txh9kBGyaVs7HCOQB
 O7hioAa11tM_6ubE6weuOyGjtLXlKsyRHi57D1B06HYHAPPoM9YfWWzFTtGCo3mo.dmopGYmDKqU
 woSnw.KpxfTST7qF1UqjQrDpeWl8YxiYLC8FU9mNUWhFKtsPqKeVowzyCJ5aF2nN17L5SoU9H1_x
 EWw_uObmp4FY1ABmE7bQKqt4D_yTrscbeqjMN4_9aTdKi.vnNoXtqd5rtFF4WmTxB0z6CoN0oR9y
 sv9Zpaz03puUOS.h8DVRuYCYrmxs2RLUIcEpgsfZ0nhwYpDMKHKzZ2AVIisz.tw7Crik2jrXOmSd
 _E_zsdyJRaaR29Jw9NEGDUURtOqGeDsBZWtqAHPGks2ZOF69QxT7kBC_MlKYweLAGJI8IgLtJZtY
 uNMStpE8oKlkx9BLRs7D0CQ1h3Ha.a67EvWp1R2ZheEwGu.gYB1PupnxZKP2LZhWILpY_UsfldhJ
 0YONAsJpWMCObxsRm59h0.UC6e7jvmaDxra1XAlKWKmJx86AN87ohzS7qLkmoBbTdjYF4H4F64HK
 pjaLx3AbGDjJv3.AXqtroxTIoomur97vc.wgVewZMX7pZ8RbiGjI8LBgxdD2w9ppB2xEXyAqsP_d
 _c5nTlN3uqujRdsZR5fjI6U3YY6hbGDZemNvrtbGPsgzl1mGH19oAvLMW5oyaraNVcAoPMuuP5Lu
 R.Tq2IiiKOV21QH2HdXqPVC1ymf7eQmNjmABRAREa.fY7VTYVAVKeeEM6yhHfVmvIhJ9NWuMFeHJ
 wSodfCjv5Eygho7dKsCN9rEY86emd4Ej6ZmiGfKvgQ6MGEtNGwuQ2PMdzbk5ti2K..K97hFQl4rK
 PXBH7NI0zHA215Si8IjSgvwUDRjgK7ojQN_tAjbdEoOLARsjcZOr60SMFRB0hjssay_9z7AyMFpq
 UOP.bvo03Y6VjHZ08rr9vdoDiKFg5ZwGa0PZ6B4FMRvEZGHTFLdh_s8zu4Q1BX.x_Sn487r9e4O8
 jAvIf0g1jXmkV0M6tey46jXUkNdx.U365pGjP2WsohB8pNQx3jvOV9QRCxoubh4FugfFPpGCZaEO
 rnaboelADhqmwEXuyevvzvlONy0XyFyHB7FT1Rt7aIqXKx5ginqARPAtpDw8q7.WpuHoVOlgu8IZ
 wvv2znlaDm2K75odYd3EKuhpuhMdrr54cY.uV0ErOVDDa6qwoGRWbRqTdJpSAF0PgpRMagIgC8uf
 xk737tee.8LU1ksiKuM_RbcOzaxQP4FJc3ro9O6UhkLfcb3CdtcYNgu2kiIQhmdJksTvGlUNt223
 OnqeOm2hJH1AXWpYxgfo5xnO81L4eUdRCNOjn9Csjg919NksjKDHKjket19naJdZ13IabUX9ZQYG
 XASWE3N96bPtbWM41d5AsTHvrbZYipLGBu2GXq9z2cps235yt.OGHsr55qEXLoHGin7waOXnbYD5
 x1oX1926uA8KlIedjAtMwYZgaYJ3Rk5QF7qlPPMrVMCiw.xGKlgWD16dQPXNgRzaaouL5wzrWTbM
 aJqgxUI.bpSRvlxgfqa1x7vZgY6t8ujBVGkkPq6S8XEjJepk5HfM4Fr5bIe3R3lPXCxa3gqTzBqf
 PSSttIKq.o0pZpHBi2aehiM1OoVeLRtlNBg4USAkXEgL6JBPB64ZJjJt2PjV47X_PdLugYi0DO4m
 egVjtlVgL1N.KqoYIFbg_vs0h2si0h88NOTP61g0OiawpN2il2U4izHEO.dSsVCWiMBn7xjrITxP
 Swi3Pm1rEltkGfKPENdkGuRYesL2IDsJz99GV2S0dXz23sSxz38Y0z5dWpwShYodG52N5H6j8.mL
 GiWz0
X-Sonic-MF: <eric_devolder@yahoo.com>
X-Sonic-ID: 2c111f83-4a3d-4d13-b9f6-c9d7c58ce06a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Nov 2023 13:53:43 +0000
Received: by hermes--production-bf1-5d8dc66654-q8vhw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 384bd59aae204a6b4d730f6db7611597;
          Tue, 28 Nov 2023 13:53:42 +0000 (UTC)
Message-ID: <68f993cb-26a6-4e38-8361-4529766e0f83@yahoo.com>
Date: Tue, 28 Nov 2023 07:53:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers/base/cpu: crash data showing should depends on
 KEXEC_CORE
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, x86@kernel.org, akpm@linux-foundation.org,
 ignat@cloudflare.com, agordeev@linux.ibm.com
References: <20231128055248.659808-1-bhe@redhat.com>
From: Eric DeVolder <eric_devolder@yahoo.com>
In-Reply-To: <20231128055248.659808-1-bhe@redhat.com>
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_055348_304507_A2537352 
X-CRM114-Status: GOOD (  15.10  )
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

Ck9uIDExLzI3LzIzIDIzOjUyLCBCYW9xdWFuIEhlIHdyb3RlOgo+IEFmdGVyIGNvbW1pdCA4OGE2
Zjg5OTQ0MjEgKCJjcmFzaDogbWVtb3J5IGFuZCBDUFUgaG90cGx1ZyBzeXNmcwo+IGF0dHJpYnV0
ZXMiKSwgb24geDg2XzY0LCBpZiBvbmx5IGJlbG93IGtlcm5lbCBjb25maWdzIHJlbGF0ZWQgdG8g
a2R1bXAKPiBhcmUgc2V0LCBjb21waWxpbmcgZXJyb3IgYXJlIHRyaWdnZXJlZC4KPgo+IC0tLS0K
PiBDT05GSUdfQ1JBU0hfQ09SRT15Cj4gQ09ORklHX0tFWEVDX0NPUkU9eQo+IENPTkZJR19DUkFT
SF9EVU1QPXkKPiBDT05GSUdfQ1JBU0hfSE9UUExVRz15Cj4gLS0tLS0tCj4KPiAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiBkcml2ZXJzL2Jh
c2UvY3B1LmM6IEluIGZ1bmN0aW9uIOKAmGNyYXNoX2hvdHBsdWdfc2hvd+KAmToKPiBkcml2ZXJz
L2Jhc2UvY3B1LmM6MzA5OjQwOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rp
b24g4oCYY3Jhc2hfaG90cGx1Z19jcHVfc3VwcG9ydOKAmTsgZGlkIHlvdSBtZWFuIOKAmGNyYXNo
X2hvdHBsdWdfc2hvd+KAmT8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25d
Cj4gICAgMzA5IHwgICAgICAgICByZXR1cm4gc3lzZnNfZW1pdChidWYsICIlZFxuIiwgY3Jhc2hf
aG90cGx1Z19jcHVfc3VwcG9ydCgpKTsKPiAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3Jhc2hfaG90cGx1Z19zaG93Cj4g
Y2MxOiBzb21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCj4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4KPiBDT05GSUdfS0VY
RUMgaXMgdXNlZCB0byBlbmFibGUga2V4ZWNfbG9hZCBpbnRlcmZhY2UsIHRoZQo+IGNyYXNoX25v
dGVzL2NyYXNoX25vdGVzX3NpemUvY3Jhc2hfaG90cGx1ZyBzaG93aW5nIGRlcGVuZHMgb24KPiBD
T05GSUdfS0VYRUMgaXMgaW5jb3JyZWN0LiBJdCBzaG91bGQgZGVwZW5kIG9uIEtFWEVDX0NPUkUg
aW5zdGVhZC4KPgo+IEZpeCBpdCBub3cuCj4KPiBGaXhlczogY29tbWl0IDg4YTZmODk5NDQyMSAo
ImNyYXNoOiBtZW1vcnkgYW5kIENQVSBob3RwbHVnIHN5c2ZzIGF0dHJpYnV0ZXMiKQo+IFNpZ25l
ZC1vZmYtYnk6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPgoKUmV2aWV3ZWQtYnk6IEVyaWMg
RGVWb2xkZXIgPGVyaWNfZGV2b2xkZXJAeWFob28uY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL2Jh
c2UvY3B1LmMgfCA2ICsrKy0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvY3B1LmMgYi9kcml2
ZXJzL2Jhc2UvY3B1LmMKPiBpbmRleCA5ZWEyMmUxNjVhY2QuLjU0ODQ5MWRlODE4ZSAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2Jhc2UvY3B1LmMKPiArKysgYi9kcml2ZXJzL2Jhc2UvY3B1LmMKPiBA
QCAtMTQ0LDcgKzE0NCw3IEBAIHN0YXRpYyBERVZJQ0VfQVRUUihyZWxlYXNlLCBTX0lXVVNSLCBO
VUxMLCBjcHVfcmVsZWFzZV9zdG9yZSk7Cj4gICAjZW5kaWYgLyogQ09ORklHX0FSQ0hfQ1BVX1BS
T0JFX1JFTEVBU0UgKi8KPiAgICNlbmRpZiAvKiBDT05GSUdfSE9UUExVR19DUFUgKi8KPiAgIAo+
IC0jaWZkZWYgQ09ORklHX0tFWEVDCj4gKyNpZmRlZiBDT05GSUdfS0VYRUNfQ09SRQo+ICAgI2lu
Y2x1ZGUgPGxpbnV4L2tleGVjLmg+Cj4gICAKPiAgIHN0YXRpYyBzc2l6ZV90IGNyYXNoX25vdGVz
X3Nob3coc3RydWN0IGRldmljZSAqZGV2LAo+IEBAIC0xODksMTQgKzE4OSwxNCBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBjcmFzaF9ub3RlX2NwdV9hdHRyX2dyb3VwID0g
ewo+ICAgI2VuZGlmCj4gICAKPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3Vw
ICpjb21tb25fY3B1X2F0dHJfZ3JvdXBzW10gPSB7Cj4gLSNpZmRlZiBDT05GSUdfS0VYRUMKPiAr
I2lmZGVmIENPTkZJR19LRVhFQ19DT1JFCj4gICAJJmNyYXNoX25vdGVfY3B1X2F0dHJfZ3JvdXAs
Cj4gICAjZW5kaWYKPiAgIAlOVUxMCj4gICB9Owo+ICAgCj4gICBzdGF0aWMgY29uc3Qgc3RydWN0
IGF0dHJpYnV0ZV9ncm91cCAqaG90cGx1Z2FibGVfY3B1X2F0dHJfZ3JvdXBzW10gPSB7Cj4gLSNp
ZmRlZiBDT05GSUdfS0VYRUMKPiArI2lmZGVmIENPTkZJR19LRVhFQ19DT1JFCj4gICAJJmNyYXNo
X25vdGVfY3B1X2F0dHJfZ3JvdXAsCj4gICAjZW5kaWYKPiAgIAlOVUxMCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
