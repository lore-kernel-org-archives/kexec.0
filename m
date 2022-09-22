Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24633C6FA82
	for <kexec@archiver.kernel.org>; Thu, 22 Sep 2022 10:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M9uFm8QQrogoK/ZjK8CNlWyiRSdkwL25aWQTSK5+1dU=; b=BeSN4eOfFQ3QJ/
	hda5JBcTzPRfD52n6dFqiFY8ERn+NKdUTKOm7tKYaqpl8AQBW5yBTDirr0qfhIvMYmIOuZ2xkAYH7
	N00NJFki0Z33EENuHwxRsA8ic3yimAD8N5mVB47I0s8eRZuEMVWsBAYTD3Gohy2JgILcgm7Zs73/W
	OcCkR/BrPiJpQBtJPTdEUO8H/Zmmwxo3eVmGYMP3RCt2YPzHtkDkO58/pBYX9POj51h8166KgrrVh
	preP7J+efFu0q3WXj/d1Hvysfzvvzvzvvxjb9Vydli3/hV6qH6u5OWYxRV18sEQRoZ0brYbJEEb1Q
	ciO5pOX9IRZepkDHm24g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obJAR-00EpJb-Cu; Thu, 22 Sep 2022 10:10:51 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obJ10-00EfjF-Ia
	for kexec@lists.infradead.org; Thu, 22 Sep 2022 10:01:09 +0000
Received: by mail-ed1-x530.google.com with SMTP id z97so12767496ede.8
        for <kexec@lists.infradead.org>; Thu, 22 Sep 2022 03:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=J0qXhAwEzoWbz8NYi11IkHID2B4LQANK3dOrOzpzswM=;
        b=EokOGSnIK46rPF0cq5JkkwoxMv8EWDs4JGCatOPqqwqHOk7VVx5cN8Z4pR+ia19ty1
         VqbQSXqeshUYwMZ3zrCOl7xa1Ko5uzNEIMPgxPrjtsxjj41DS8jAO/bEcdDQ/as0CWRM
         nREFoJ1c8pSocKsEIwnMPLVEKtIQBV6T9xxvX/IQK/epJuPQz9hPJgQlyp1q+cHNC5QN
         SakGEbkKVrr2uXSo8Br/Q7V99tS7MtCVSQz/gAZPhJ52pPxBDEYWn3wo1+oSLvR6TtqG
         YA0T0qlFkn9yuqpyfIA+LIgVX/Kdh0EUzhpm1c21Qq3a3jZDWMXd6Zt4P7uJEInaI5cg
         TCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=J0qXhAwEzoWbz8NYi11IkHID2B4LQANK3dOrOzpzswM=;
        b=kT7cnu2usO9rH9Q1EW56wqwj4WSDLmu9oZ7jjv0TL/3xFwjP4UsJBk54iMeHseEFt+
         r7+WZg1O/tfNhv/uDMvP4qBUDF5+i+1gx1FY2gF+a2Xigs1UqQXeP79aAvupaWAopPmj
         5Mcf8FyiJGdJehCjQ077CH4cX/rfMxen/dF2X9IFoOkaGNcagvNAyXgzV2c/sZIZmyXA
         5WN1ZHHRFMoI6pvBlelYfvskhRJqFOYSg5ocnteElXYeG7o9gFtyJdYJkVTuI55vwCj2
         yT9+KuE6e1GJnkYyFNwOqFDmuRuKMx7s70Ub8G2IxxI45Pk2tWZiD1+7x7QZr/zhmVz2
         bHbQ==
X-Gm-Message-State: ACrzQf3+IZPawbpDKElrh/xEMaGVXNvX5+lK1iPt6DOvq9tW6IH5kTOc
	/f2JBzmz/DN1c/DRDJMIUQqFX3/NEX8aNvLRWn6f7w==
X-Google-Smtp-Source: AMsMyM61YoKKgXD2TA5sZVWJ9BLcFHrwIAfLChpAAtUcovDLpwWQQCNKsZ+/eUBPUBz41TArDzkEfh374RGFsFLM0oI=
X-Received: by 2002:aa7:cb87:0:b0:43b:e650:6036 with SMTP id
 r7-20020aa7cb87000000b0043be6506036mr2455207edt.350.1663840862990; Thu, 22
 Sep 2022 03:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220921153646.931277075@linuxfoundation.org>
In-Reply-To: <20220921153646.931277075@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 Sep 2022 15:30:51 +0530
Message-ID: <CA+G9fYs5BDHc2638p7br6-RzQzdJjxOOUvujyssy0bOWKOtLCg@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/45] 5.15.70-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, slade@sladewatkins.com, 
	Coiby Xu <coxu@redhat.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Michal Suchanek <msuchanek@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_030106_681975_2740B98B 
X-CRM114-Status: GOOD (  17.27  )
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

T24gV2VkLCAyMSBTZXB0IDIwMjIgYXQgMjE6MTksIEdyZWcgS3JvYWgtSGFydG1hbgo8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+Cj4gVGhpcyBpcyB0aGUgc3RhcnQgb2YgdGhl
IHN0YWJsZSByZXZpZXcgY3ljbGUgZm9yIHRoZSA1LjE1LjcwIHJlbGVhc2UuCj4gVGhlcmUgYXJl
IDQ1IHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMsIGFsbCB3aWxsIGJlIHBvc3RlZCBhcyBhIHJlc3Bv
bnNlCj4gdG8gdGhpcyBvbmUuICBJZiBhbnlvbmUgaGFzIGFueSBpc3N1ZXMgd2l0aCB0aGVzZSBi
ZWluZyBhcHBsaWVkLCBwbGVhc2UKPiBsZXQgbWUga25vdy4KPgo+IFJlc3BvbnNlcyBzaG91bGQg
YmUgbWFkZSBieSBGcmksIDIzIFNlcCAyMDIyIDE1OjM2OjMzICswMDAwLgo+IEFueXRoaW5nIHJl
Y2VpdmVkIGFmdGVyIHRoYXQgdGltZSBtaWdodCBiZSB0b28gbGF0ZS4KPgo+IFRoZSB3aG9sZSBw
YXRjaCBzZXJpZXMgY2FuIGJlIGZvdW5kIGluIG9uZSBwYXRjaCBhdDoKPiAgICAgICAgIGh0dHBz
Oi8vd3d3Lmtlcm5lbC5vcmcvcHViL2xpbnV4L2tlcm5lbC92NS54L3N0YWJsZS1yZXZpZXcvcGF0
Y2gtNS4xNS43MC1yYzEuZ3oKPiBvciBpbiB0aGUgZ2l0IHRyZWUgYW5kIGJyYW5jaCBhdDoKPiAg
ICAgICAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFi
bGUvbGludXgtc3RhYmxlLXJjLmdpdCBsaW51eC01LjE1LnkKPiBhbmQgdGhlIGRpZmZzdGF0IGNh
biBiZSBmb3VuZCBiZWxvdy4KPgo+IHRoYW5rcywKPgo+IGdyZWcgay1oCgpSZXN1bHRzIGZyb20g
TGluYXJv4oCZcyB0ZXN0IGZhcm0uClJlZ3Jlc3Npb25zIG9uIGFybTY0IGFsbG1vZGNvbmZpZyBi
dWlsZHMgZmFpbGVkLgoKUmVwb3J0ZWQtYnk6IExpbnV4IEtlcm5lbCBGdW5jdGlvbmFsIFRlc3Rp
bmcgPGxrZnRAbGluYXJvLm9yZz4KCiogYXJtNjQsIGJ1aWxkIGZhaWxlZC4KICAtIGNsYW5nLTEy
LWFsbG1vZGNvbmZpZwogIC0gY2xhbmctMTMtYWxsbW9kY29uZmlnCiAgLSBjbGFuZy0xNC1hbGxt
b2Rjb25maWcKICAtIGNsYW5nLW5pZ2h0bHktYWxsbW9kY29uZmlnCiAgLSBnY2MtMTAtYWxsbW9k
Y29uZmlnCiAgLSBnY2MtMTEtYWxsbW9kY29uZmlnCiAgLSBnY2MtMTItYWxsbW9kY29uZmlnCgo+
IENvaWJ5IFh1IDxjb3h1QHJlZGhhdC5jb20+Cj4gICAgIGFybTY0OiBrZXhlY19maWxlOiB1c2Ug
bW9yZSBzeXN0ZW0ga2V5cmluZ3MgdG8gdmVyaWZ5IGtlcm5lbCBpbWFnZSBzaWduYXR1cmUKCkJ1
aWxkIGVycm9yczoKLS0tLS0tLS0tLS0tLS0tCmFyY2gvYXJtNjQva2VybmVsL2tleGVjX2ltYWdl
LmM6MTM2OjIzOiBlcnJvcjoKJ2tleGVjX2tlcm5lbF92ZXJpZnlfcGVfc2lnJyB1bmRlY2xhcmVk
IGhlcmUgKG5vdCBpbiBhIGZ1bmN0aW9uKTsgZGlkCnlvdSBtZWFuICdhcmNoX2tleGVjX2tlcm5l
bF92ZXJpZnlfc2lnJz8KICAxMzYgfCAgICAgICAgIC52ZXJpZnlfc2lnID0ga2V4ZWNfa2VybmVs
X3ZlcmlmeV9wZV9zaWcsCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIGFyY2hfa2V4ZWNf
a2VybmVsX3ZlcmlmeV9zaWcKCgojIyBCdWlsZAoqIGtlcm5lbDogNS4xNS43MC1yYzEKKiBnaXQ6
IGh0dHBzOi8vZ2l0bGFiLmNvbS9MaW5hcm8vbGtmdC9taXJyb3JzL3N0YWJsZS9saW51eC1zdGFi
bGUtcmMKKiBnaXQgYnJhbmNoOiBsaW51eC01LjE1LnkKKiBnaXQgY29tbWl0OiAxNmQ0MWU2MDE4
NTg3NjY5MzVlNjllM2Y5ZDYyZGI4MTBlNWQyNzdkCiogZ2l0IGRlc2NyaWJlOiB2NS4xNS42OS00
Ni1nMTZkNDFlNjAxODU4CiogdGVzdCBkZXRhaWxzOgpodHRwczovL3FhLXJlcG9ydHMubGluYXJv
Lm9yZy9sa2Z0L2xpbnV4LXN0YWJsZS1yYy1saW51eC01LjE1LnkvYnVpbGQvdjUuMTUuNjktNDYt
ZzE2ZDQxZTYwMTg1OAoKIyMgVGVzdCBSZWdyZXNzaW9ucyAoY29tcGFyZWQgdG8gdjUuMTUuNjkp
CiogYXJtNjQsIGJ1aWxkCiAgLSBjbGFuZy0xMi1hbGxtb2Rjb25maWcKICAtIGNsYW5nLTEzLWFs
bG1vZGNvbmZpZwogIC0gY2xhbmctMTQtYWxsbW9kY29uZmlnCiAgLSBjbGFuZy1uaWdodGx5LWFs
bG1vZGNvbmZpZwogIC0gZ2NjLTEwLWFsbG1vZGNvbmZpZwogIC0gZ2NjLTExLWFsbG1vZGNvbmZp
ZwogIC0gZ2NjLTEyLWFsbG1vZGNvbmZpZwoKIyMgTm8gTWV0cmljIFJlZ3Jlc3Npb25zIChjb21w
YXJlZCB0byB2NS4xNS42OSkKCiMjIE5vIFRlc3QgRml4ZXMgKGNvbXBhcmVkIHRvIHY1LjE1LjY5
KQoKIyMgTm8gTWV0cmljIEZpeGVzIChjb21wYXJlZCB0byB2NS4xNS42OSkKCiMjIFRlc3QgcmVz
dWx0IHN1bW1hcnkKdG90YWw6IDEwNjcxMywgcGFzczogOTQwMzQsIGZhaWw6IDY4Nywgc2tpcDog
MTE2ODAsIHhmYWlsOiAzMTIKCiMjIEJ1aWxkIFN1bW1hcnkKKiBhcmM6IDEwIHRvdGFsLCAxMCBw
YXNzZWQsIDAgZmFpbGVkCiogYXJtOiAzMzkgdG90YWwsIDMzNiBwYXNzZWQsIDMgZmFpbGVkCiog
YXJtNjQ6IDcyIHRvdGFsLCA2MyBwYXNzZWQsIDkgZmFpbGVkCiogaTM4NjogNjEgdG90YWwsIDU1
IHBhc3NlZCwgNiBmYWlsZWQKKiBtaXBzOiA2MiB0b3RhbCwgNTkgcGFzc2VkLCAzIGZhaWxlZAoq
IHBhcmlzYzogMTQgdG90YWwsIDE0IHBhc3NlZCwgMCBmYWlsZWQKKiBwb3dlcnBjOiA2OSB0b3Rh
bCwgNjYgcGFzc2VkLCAzIGZhaWxlZAoqIHJpc2N2OiAyNyB0b3RhbCwgMjcgcGFzc2VkLCAwIGZh
aWxlZAoqIHMzOTA6IDMwIHRvdGFsLCAyNyBwYXNzZWQsIDMgZmFpbGVkCiogc2g6IDI2IHRvdGFs
LCAyNCBwYXNzZWQsIDIgZmFpbGVkCiogc3BhcmM6IDE0IHRvdGFsLCAxNCBwYXNzZWQsIDAgZmFp
bGVkCiogeDg2XzY0OiA2NSB0b3RhbCwgNjMgcGFzc2VkLCAyIGZhaWxlZAoKIyMgVGVzdCBzdWl0
ZXMgc3VtbWFyeQoqIGZ3dHMKKiBpZ3QtZ3B1LXRvb2xzCioga3VuaXQKKiBrdm0tdW5pdC10ZXN0
cwoqIGxpYmh1Z2V0bGJmcwoqIGxvZy1wYXJzZXItYm9vdAoqIGxvZy1wYXJzZXItdGVzdAoqIGx0
cC1jYXBfYm91bmRzCiogbHRwLWNvbW1hbmRzCiogbHRwLWNvbnRhaW5lcnMKKiBsdHAtY29udHJv
bGxlcnMKKiBsdHAtY3B1aG90cGx1ZwoqIGx0cC1jcnlwdG8KKiBsdHAtY3ZlCiogbHRwLWRpbwoq
IGx0cC1mY250bC1sb2NrdGVzdHMKKiBsdHAtZmlsZWNhcHMKKiBsdHAtZnMKKiBsdHAtZnNfYmlu
ZAoqIGx0cC1mc19wZXJtc19zaW1wbGUKKiBsdHAtZnN4CiogbHRwLWh1Z2V0bGIKKiBsdHAtaW8K
KiBsdHAtaXBjCiogbHRwLW1hdGgKKiBsdHAtbW0KKiBsdHAtbnB0bAoqIGx0cC1vcGVuLXBvc2l4
LXRlc3RzCiogbHRwLXB0eQoqIGx0cC1zY2hlZAoqIGx0cC1zZWN1cmViaXRzCiogbHRwLXN5c2Nh
bGxzCiogbHRwLXRyYWNpbmcKKiBuZXR3b3JrLWJhc2ljLXRlc3RzCiogcGFja2V0ZHJpbGwKKiBy
Y3V0b3J0dXJlCiogdjRsMi1jb21wbGlhbmNlCiogdmRzbwoKLS0KTGluYXJvIExLRlQKaHR0cHM6
Ly9sa2Z0LmxpbmFyby5vcmcKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
