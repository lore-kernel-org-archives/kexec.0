Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581C9C001DF
	for <kexec@archiver.kernel.org>; Fri,  4 Aug 2023 09:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LnJqNabD9bTT+whVy68vTetZzZUZboZ6t+TYKUcDkXQ=; b=Fre8lcysSkD/KZ
	zCIudCZ3ZTvvZZQaksoPJCUyiFE9qyNczNUFILozFQNl9mcrlZTcnKPit2RpoadjLnEHH8c+p3ist
	eRMcUkCCr1XjPapwvVax8I7PUpTAXatvHUAbNS08x2KFT3QI2+CsxCEV3z9pNSwrVK6Nt0JaG3+OC
	8CVrR4va8loC9ZfZ4aIAVXpz+MgRIEWSYI0y33/B2Pu57uo6tCW48Z0BAzlFHRgUQ1l+rudOOqyOl
	rTJWkHtqMJGQ6XkUFgiYWIXp5Q7DUnppHl6dVKMANOCVSniH2EHBg1w2X5ln2sw3alNqs+jYYxH97
	6CyBQrOj/T5Gy4qKyEAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRqzd-00Bzhd-1h;
	Fri, 04 Aug 2023 09:21:09 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRqza-00BzgZ-1a;
	Fri, 04 Aug 2023 09:21:08 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bc411e9d17so10745535ad.0;
        Fri, 04 Aug 2023 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691140865; x=1691745665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZZmD3rCARtEOTJ/+vmo01MDEXL1vajhMhF1j7+O0X8=;
        b=DHmebdQ3O0si0DF667aeyB+odO7mOBRuJwEf6dkmbwhVUkJuNmdVT7fD/FkJfKWTmi
         46DJzE2iM4s7Z09ty/VZY62zAm6/fbv3vDkXzgxZlx24vXHHeChXPN65F3Eehub4W88m
         de+gZPGceDnFnLsWBcM46TLj8IUQK40dGzqOYQt7hOr1yWAs9fqnLR5QtBnZth2/WmFa
         vif5fgiiWCHFWZghGa/8gJSgXGc2YZ6bDw3W3YLuGz6kwLwHBC/tEn027Z+YTOg5rgA3
         huuvWB1rQuV8vS2otTFLH9B/akXy8NdNXPbFPg3WTns5yBby7E1p+3OjdTjltba8F11p
         WBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691140865; x=1691745665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VZZmD3rCARtEOTJ/+vmo01MDEXL1vajhMhF1j7+O0X8=;
        b=ag5M7tAp8wGe2vCevxKHtPjN2+R6jAR1Lr8ThAIJnHS+UYSw+oOzEeukGgTL7o4GPI
         Bjd4sM907/3JB0S+TBymJ7dyCJa+ORaZdA37uefGqUqY+c9MoIN9w5mtjJZINwMnfWiD
         Ebxlf8ziiQmRPGWu7A6r5ioc7OB5WuAVBGtXkiQ2skrRvMJOwR7gEMUXepTItHDd5eVC
         Pk2DY/JB16srSUzt9gYTsG8CfUYC3vmzyeXJyFCAsVEokCjWST1zSlusKE50ZQN9qyhP
         fUvioZsbz+WIBkREqsVtbQtFvQRU/ItkLMhxZ26ZOoO1VXZ7xx4tS6O9Bi+Tw/bOGeGA
         J1nw==
X-Gm-Message-State: AOJu0YzsX75DMt/tFoXPQmzQV0BmqchUjSwuNhsEQMKGxKcf08RsSMeX
	nWJ6Usf5K1PKX7alyrARcb0=
X-Google-Smtp-Source: AGHT+IE0AqjACNGYBdCaqTOG7QZpjOZHe45v71WeBnPXTp18L6dI+VRAxsF7ohueXJN+CcDpZS63mA==
X-Received: by 2002:a17:902:b70e:b0:1b2:48c:4db with SMTP id d14-20020a170902b70e00b001b2048c04dbmr810424pls.38.1691140865540;
        Fri, 04 Aug 2023 02:21:05 -0700 (PDT)
Received: from [0.0.0.0] ([5.180.77.117])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b001acae9734c0sm1263915plh.266.2023.08.04.02.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 02:21:05 -0700 (PDT)
Message-ID: <bd8be47f-4c46-6a47-970b-86a5d36e22c2@gmail.com>
Date: Fri, 4 Aug 2023 17:20:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [Crash-utility] RISCV64: Use va_kernel_pa_offset in VTOP()
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "crash-utility@redhat.com" <crash-utility@redhat.com>,
 "xianting.tian@linux.alibaba.com" <xianting.tian@linux.alibaba.com>,
 "mick@ics.forth.gr" <mick@ics.forth.gr>,
 "heinrich.schuchardt@canonical.com" <heinrich.schuchardt@canonical.com>,
 "guoren@kernel.org" <guoren@kernel.org>,
 "yixun.lan@gmail.com" <yixun.lan@gmail.com>,
 "lijiang@redhat.com" <lijiang@redhat.com>, Song Shuai <suagrfillet@gmail.com>
References: <20230724040649.220279-1-suagrfillet@gmail.com>
 <378ea919-5149-fb1a-02ec-3c0b41ebecc3@nec.com>
From: Song Shuai <suagrfillet@gmail.com>
In-Reply-To: <378ea919-5149-fb1a-02ec-3c0b41ebecc3@nec.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230804_022106_537184_37C67DCE 
X-CRM114-Status: GOOD (  22.99  )
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

CgrlnKggMjAyMy84LzQgMTI6NDIsIEhBR0lPIEtBWlVISVRPKOiQqeWwviDkuIDku4EpIOWGmemB
kzoKPiBPbiAyMDIzLzA3LzI0IDEzOjA2LCBTb25nIFNodWFpIHdyb3RlOgo+PiBTaW5jZSBSSVND
LVYgTGludXggdjYuNCwgdGhlIGNvbW1pdCAzMzM1MDY4Zjg3MjEgKCJyaXNjdjogVXNlCj4+IFBV
RC9QNEQvUEdEIHBhZ2VzIGZvciB0aGUgbGluZWFyIG1hcHBpbmciKSBjaGFuZ2VzIHRoZQo+PiBw
aHlzX3JhbV9iYXNlIGZyb20gdGhlIGtlcm5lbF9tYXAucGh5c19hZGRyIHRvIHRoZSBzdGFydCBv
ZiBEUkFNLgo+Pgo+PiBUaGUgQ3Jhc2gncyBWVE9QKCkgc3RpbGwgdXNlcyBwaHlzX3JhbV9iYXNl
IGFuZCBrZXJuZWxfbWFwLnZpcnRfYWRkcgo+PiB0byB0cmFuc2xhdGUga2VybmVsIHZpcnR1YWwg
YWRkcmVzcywgdGhhdCBtYWRlIENyYXNoIGJvb3QgZmFpbGVkIHdpdGgKPj4gTGludXggdjYuNCBh
bmQgbGF0ZXIgdmVyc2lvbi4KPj4KPj4gTGV0IExpbnV4IGV4cG9ydCBrZXJuZWxfbWFwLnZhX2tl
cm5lbF9wYV9vZmZzZXQgaW4gdjYuNSBhbmQgQ3Jhc2ggY2FuCj4+IHVzZSAidmFfa2VybmVsX3Bh
X29mZnNldCIgdG8gdHJhbnNsYXRlIHRoZSBrZXJuZWwgdmlydHVhbCBhZGRyZXNzIGluCj4+IFZU
T1AoKSBjb3JyZWN0bHkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNvbmcgU2h1YWkgPHN1YWdyZmls
bGV0QGdtYWlsLmNvbT4KPj4gLS0tCj4+IFlvdSBjYW4gY2hlY2svdGVzdCB0aGUgTGludXggY2hh
bmdlcyBmcm9tIHRoaXMgbGluazoKPj4gaHR0cHM6Ly9naXRodWIuY29tL3N1Z2FyZmlsbGV0L2xp
bnV4L2NvbW1pdHMvNi41LXJjMy1jcmFzaAo+Pgo+PiBBbmQgSSdsbCBzZW5kIHRoZSBMaW51eCBj
aGFuZ2VzIHRvIHJpc2N2L2Zvci1uZXh0IElmIHlvdSdyZSBvayB3aXRoIHRoaXMgcGF0Y2guCj4+
IC0tLQo+PiAgICBkZWZzLmggICAgfCAgNCArKy0tCj4+ICAgIHJpc2N2NjQuYyB8IDIyICsrKysr
KysrKysrKysrKysrKysrKysKPj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZGVmcy5oIGIvZGVmcy5oCj4+IGlu
ZGV4IDM1OGYzNjUuLjQ2Yjk4NTcgMTAwNjQ0Cj4+IC0tLSBhL2RlZnMuaAo+PiArKysgYi9kZWZz
LmgKPj4gQEAgLTM2NjIsOCArMzY2Miw3IEBAIHR5cGVkZWYgc2lnbmVkIGludCBzMzI7Cj4+ICAg
IAl1bG9uZyBfWCA9IFg7CQkJCQkJCQkJXAo+PiAgICAJKFRISVNfS0VSTkVMX1ZFUlNJT04gPj0g
TElOVVgoNSwxMywwKSAmJgkJCQkJXAo+PiAgICAJCShfWCkgPj0gbWFjaGRlcC0+bWFjaHNwZWMt
Pmtlcm5lbF9saW5rX2FkZHIpID8JCQkJXAo+PiAtCQkoKCh1bnNpZ25lZCBsb25nKShfWCktKG1h
Y2hkZXAtPm1hY2hzcGVjLT5rZXJuZWxfbGlua19hZGRyKSkgKwkJXAo+PiAtCQkgbWFjaGRlcC0+
bWFjaHNwZWMtPnBoeXNfYmFzZSk6CQkJCQkJXAo+PiArCQkoKHVuc2lnbmVkIGxvbmcpKF9YKS0o
bWFjaGRlcC0+bWFjaHNwZWMtPnZhX2tlcm5lbF9wYV9vZmZzZXQpKTogCVwKPj4gICAgCQkoKCh1
bnNpZ25lZCBsb25nKShfWCktKG1hY2hkZXAtPmt2YmFzZSkpICsJCQkJXAo+PiAgICAJCSBtYWNo
ZGVwLT5tYWNoc3BlYy0+cGh5c19iYXNlKTsJCQkJCQlcCj4+ICAgIAl9KQo+PiBAQCAtNzAyMSw2
ICs3MDIwLDcgQEAgc3RydWN0IG1hY2hpbmVfc3BlY2lmaWMgewo+PiAgICAJdWxvbmcgbW9kdWxl
c192YWRkcjsKPj4gICAgCXVsb25nIG1vZHVsZXNfZW5kOwo+PiAgICAJdWxvbmcga2VybmVsX2xp
bmtfYWRkcjsKPj4gKwl1bG9uZyB2YV9rZXJuZWxfcGFfb2Zmc2V0Owo+PiAgICAKPj4gICAgCXVs
b25nIF9wYWdlX3ByZXNlbnQ7Cj4+ICAgIAl1bG9uZyBfcGFnZV9yZWFkOwo+PiBkaWZmIC0tZ2l0
IGEvcmlzY3Y2NC5jIGIvcmlzY3Y2NC5jCj4+IGluZGV4IDZiOWE2ODguLmI5ZTUwYjQgMTAwNjQ0
Cj4+IC0tLSBhL3Jpc2N2NjQuYwo+PiArKysgYi9yaXNjdjY0LmMKPj4gQEAgLTQxOCw2ICs0MTgs
MjcgQEAgZXJyb3I6Cj4+ICAgIAllcnJvcihGQVRBTCwgImNhbm5vdCBnZXQgdm0gbGF5b3V0XG4i
KTsKPj4gICAgfQo+PiAgICAKPj4gK3N0YXRpYyB2b2lkCj4+ICtyaXNjdjY0X2dldF92YV9rZXJu
ZWxfcGFfb2Zmc2V0KHN0cnVjdCBtYWNoaW5lX3NwZWNpZmljICptcykKPj4gK3sKPj4gKwl1bnNp
Z25lZCBsb25nIGtlcm5lbF92ZXJzaW9uID0gcmlzY3Y2NF9nZXRfa2VybmVsX3ZlcnNpb24oKTsK
Pj4gKwo+PiArCS8qCj4+ICsJICogdmFfa2VybmVsX3BhX29mZnNldCBpcyBkZWZpbmVkIGluIExp
bnV4IGtlcm5lbCBzaW5jZSA2LjUuCj4+ICsJICovCj4+ICsJaWYgKGtlcm5lbF92ZXJzaW9uID49
IExJTlVYKDYsNSwwKSkgewo+IAo+IFRoZSBrZXJuZWwgcGF0Y2hlcyBsb29rIGFjY2VwdGVkLCBz
byBmb3IgdGhlIGNyYXNoIHBhdGNoIGRldGFpbCwKPiAKPiBJIHRoaW5rIHRoaXMgZmlyc3QgdmVy
c2lvbiBjaGVjayBpcyBub3QgbmVjZXNzYXJ5LCB3ZSBjYW4ganVzdCB1c2UgdGhlCj4gdm1jb3Jl
aW5mbyBlbnRyeSBpZiBhdmFpbGFibGUuICBXaXRoIGl0LCBiYWNrcG9ydGluZyB0aGUga2VybmVs
IHBhdGNoZXMKPiB0byBlLmcuIDYuNC4wIHdpbGwgYWxzbyBiZSBzdXBwb3J0ZWQuCj4gCm9rLCBW
MiBpcyBoZXJlOgoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvMjAyMzA4MDQw
OTE1NTkuMzAwNTgyMC0xLXN1YWdyZmlsbGV0QGdtYWlsLmNvbS9ULyN1Cgo+IFRoYW5rcywKPiBL
YXp1Cj4gCj4+ICsJCWNoYXIgKnN0cmluZzsKPj4gKwkJaWYgKChzdHJpbmcgPSBwYy0+cmVhZF92
bWNvcmVpbmZvKCJOVU1CRVIodmFfa2VybmVsX3BhX29mZnNldCkiKSkpIHsKPj4gKwkJCW1zLT52
YV9rZXJuZWxfcGFfb2Zmc2V0ID0gaHRvbChzdHJpbmcsIFFVSUVULCBOVUxMKTsKPj4gKwkJCWZy
ZWUoc3RyaW5nKTsKPj4gKwkJfSBlbHNlCj4+ICsJCQllcnJvcihGQVRBTCwgImNhbm5vdCByZWFk
IHZhX2tlcm5lbF9wYV9vZmZzZXRcbiIpOwo+PiArCX0gZWxzZSBpZiAoa2VybmVsX3ZlcnNpb24g
Pj0gTElOVVgoNiw0LDApKQo+PiArCQllcnJvcihGQVRBTCwgImNhbm5vdCBkZXRlcm1pbmUgdmFf
a2VybmVsX3BhX29mZnNldCBzaW5jZSBMaW51eCA2LjRcbiIpOwo+PiArCWVsc2UKPj4gKwkJbXMt
PnZhX2tlcm5lbF9wYV9vZmZzZXQgPSBtcy0+a2VybmVsX2xpbmtfYWRkciAtIG1zLT5waHlzX2Jh
c2U7Cj4+ICt9Cj4+ICsKPj4gICAgc3RhdGljIGludAo+PiAgICByaXNjdjY0X2lzX2t2YWRkcih1
bG9uZyB2YWRkcikKPj4gICAgewo+PiBAQCAtMTM1Miw2ICsxMzczLDcgQEAgcmlzY3Y2NF9pbml0
KGludCB3aGVuKQo+PiAgICAJCXJpc2N2NjRfZ2V0X3N0cnVjdF9wYWdlX3NpemUobWFjaGRlcC0+
bWFjaHNwZWMpOwo+PiAgICAJCXJpc2N2NjRfZ2V0X3ZhX2JpdHMobWFjaGRlcC0+bWFjaHNwZWMp
Owo+PiAgICAJCXJpc2N2NjRfZ2V0X3ZhX3JhbmdlKG1hY2hkZXAtPm1hY2hzcGVjKTsKPj4gKwkJ
cmlzY3Y2NF9nZXRfdmFfa2VybmVsX3BhX29mZnNldChtYWNoZGVwLT5tYWNoc3BlYyk7Cj4+ICAg
IAo+PiAgICAJCXB0X2xldmVsX2FsbG9jKCZtYWNoZGVwLT5wZ2QsICJjYW5ub3QgbWFsbG9jIHBn
ZCBzcGFjZS4iKTsKPj4gICAgCQlwdF9sZXZlbF9hbGxvYygmbWFjaGRlcC0+bWFjaHNwZWMtPnA0
ZCwgImNhbm5vdCBtYWxsb2MgcDRkIHNwYWNlLiIpOwoKLS0gClRoYW5rcwpTb25nIFNodWFpCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWls
aW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
