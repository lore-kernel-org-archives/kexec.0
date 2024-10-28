Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9290BD339A9
	for <kexec@archiver.kernel.org>; Mon, 28 Oct 2024 17:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qPptdCGHgzShvglBnm/jDAmi6Xi29x3V4mAdsr8khZ0=; b=U7/KTmQO7D9Mna
	Ij/ELbPNrKni1owvojismDx+/8kGm17xs1FXiBg4SFODiKLOBxuUbTj8M/YypZqFqgo4kToBCTYuk
	ABS3hmrquNQ2qJz6VAY8nCIVElLP4TdA8sCM1B17zcmTriCZtm1ZDh0Q92doWBklspkbfXHeyfgic
	ptZliHgVSqcHpHLNf5x/eVixelE93IydJZaUBlWS49mdWoDy6XvrBp4w8nW5c+O2ZMqzSMgOJAXdP
	3666ynKrdRCPacJQCtB91vHejN6NFMWsmeVd5DS5khi18Fo+MTFQB5Ol5Xyw7xsWmdHzLhcjF6vnT
	IABhFUD1MwxT/RVsuqQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Td5-0000000BfMA-4APG;
	Mon, 28 Oct 2024 17:34:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Td2-0000000BfLX-3Dtd;
	Mon, 28 Oct 2024 17:34:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D62785C5C12;
	Mon, 28 Oct 2024 17:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E76C4CEE7;
	Mon, 28 Oct 2024 17:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730136847;
	bh=pcLLhLxlquE4QPOlWW4Lr1bb5MuHYN7k6DZdbDCx9DQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N2N8PbhzCFAC8L9B/R+n6LS/2Vz3FY30Fm8hWgEopytD1knoRkeGPQKL3kqI2YZh4
	 N66V/nX5SYYKx1XlmynUto9sGLWOvhBEmg5rJSntmjzIwGDKa6y6pQ5CqfVhu6ox3z
	 XXy4qMSqLoaPINE/LE66ohBgCVuwypgcmHq7aI6zsMGsZnZ0NSH6AbSvbsTjET7iO5
	 tM6H9w8I9wRriKG8/z+JwgusAW1OG4vSksb8DGG2Dt3CZPSWdvjdM4zjviLYwYBMsG
	 60iDnfcMYPZgh5mphm7YYFd/flxuIVSEHd35xe9nF7CCH1OilerJX6R47wN1hlmM2E
	 GJMGejqlT3Efw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53a007743e7so5250608e87.1;
        Mon, 28 Oct 2024 10:34:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBAo6pbX/nMZ4DWSeW4pJ++IbfxTMicmcYyI21EiKf2/MlayznbJ+RJgDCdl8leEtHKWkv7+CkgJ2sLP+Ljsz/MQ==@lists.infradead.org, AJvYcCVXodPayS/2IcpDWoXjpJ4W/0B2YUn2oXUX+0Rrl8/Bvbvu2VPjUYXnKRAyLYB3sF14KYpSnw==@lists.infradead.org, AJvYcCXsvHC8GDd6pwllSXXhuUy2BDMHFlb6f2QmxZ8YQcDNBk7dra8syTjAPluYiZtixUoXot2mBF2fh8LbwnU=@lists.infradead.org
X-Gm-Message-State: AOJu0YxTmaPXYkJnprt3rt+T8dchElQC89DCqaOJTa4jqNbzjVBAH6Qx
	q8cu/rNgb8VHAaENFnJFhDdn5+FOijmC87u6MjcdBlR9PEiSS8SRAT5oH11r4dljSYnoQClB7G8
	vXW7uX8kTNX3iq8V9TJaE1xOXLw==
X-Google-Smtp-Source: AGHT+IF5IETAXGDmlx+LAKug+dwz64NqnsL1okXnnGJyl9RYKmQIgXl4x3+ziMcKV48JBCGh1PNtcevuXjcqmWy53WY=
X-Received: by 2002:a05:6512:224e:b0:539:e85c:c888 with SMTP id
 2adb3069b0e04-53b34a1900emr4148343e87.40.1730136845913; Mon, 28 Oct 2024
 10:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241023171426.452688-1-usamaarif642@gmail.com> <20241028154054.GE2484@willie-the-truck>
In-Reply-To: <20241028154054.GE2484@willie-the-truck>
From: Rob Herring <robh@kernel.org>
Date: Mon, 28 Oct 2024 12:33:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK=cbknmjKa-rtr9vPhaOoYf26KNzvQ0uGabOwy19jcCA@mail.gmail.com>
Message-ID: <CAL_JsqK=cbknmjKa-rtr9vPhaOoYf26KNzvQ0uGabOwy19jcCA@mail.gmail.com>
Subject: Re: [PATCH v2] of/fdt: add dt_phys arg to early_init_dt_scan and early_init_dt_verify
To: Will Deacon <will@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, mark.rutland@arm.com, leitao@debian.org, 
	catalin.marinas@arm.com, tglx@linutronix.de, chris@zankel.net, 
	saravanak@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-openrisc@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-csky@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_103408_921998_4229AD27 
X-CRM114-Status: GOOD (  23.15  )
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

T24gTW9uLCBPY3QgMjgsIDIwMjQgYXQgMTA6NDHigK9BTSBXaWxsIERlYWNvbiA8d2lsbEBrZXJu
ZWwub3JnPiB3cm90ZToKPgo+IE9uIFdlZCwgT2N0IDIzLCAyMDI0IGF0IDA2OjE0OjI2UE0gKzAx
MDAsIFVzYW1hIEFyaWYgd3JvdGU6Cj4gPiAgX19wYSgpIGlzIG9ubHkgaW50ZW5kZWQgdG8gYmUg
dXNlZCBmb3IgbGluZWFyIG1hcCBhZGRyZXNzZXMgYW5kIHVzaW5nCj4gPiBpdCBmb3IgaW5pdGlh
bF9ib290X3BhcmFtcyB3aGljaCBpcyBpbiBmaXhtYXAgZm9yIGFybTY0IHdpbGwgZ2l2ZSBhbgo+
ID4gaW5jb3JyZWN0IHZhbHVlLiBIZW5jZSBzYXZlIHRoZSBwaHlzaWNhbCBhZGRyZXNzIHdoZW4g
aXQgaXMga25vd24gYXQKPiA+IGJvb3QgdGltZSB3aGVuIGNhbGxpbmcgZWFybHlfaW5pdF9kdF9z
Y2FuIGZvciBhcm02NCBhbmQgdXNlIGl0IGF0IGtleGVjCj4gPiB0aW1lIGluc3RlYWQgb2YgY29u
dmVydGluZyB0aGUgdmlydHVhbCBhZGRyZXNzIHVzaW5nIF9fcGEoKS4KPiA+Cj4gPiBSZXBvcnRl
ZC1ieTogQnJlbm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4KPiA+IFN1Z2dlc3RlZC1ieTog
TWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IFVz
YW1hIEFyaWYgPHVzYW1hYXJpZjY0MkBnbWFpbC5jb20+Cj4gPiBGaXhlczogYWMxMGJlNWNkYmZh
ICgiYXJtNjQ6IFVzZSBjb21tb24gb2Zfa2V4ZWNfYWxsb2NfYW5kX3NldHVwX2ZkdCgpIikKPiA+
IC0tLQo+ID4gdjEgLT4gMjoKPiA+IC0gcGFzcyBkdF9waHlzIGluIGVhcmx5X2luaXRfZHRfc2Nh
biBpbnN0ZWFkIG9mIGNyZWF0aW5nCj4gPiAgIGFub3J0aGVyIGFyY2gtPmR0IGZ1bmN0aW9uIChS
b2IgSGVycmluZykKPiA+IC0tLQo+ID4gIGFyY2gvYXJjL2tlcm5lbC9kZXZ0cmVlLmMgICAgICAg
ICAgICAgIHwgIDIgKy0KPiA+ICBhcmNoL2FybS9rZXJuZWwvZGV2dHJlZS5jICAgICAgICAgICAg
ICB8ICAyICstCj4gPiAgYXJjaC9hcm02NC9rZXJuZWwvc2V0dXAuYyAgICAgICAgICAgICAgfCAg
NiArKysrKy0KPiA+ICBhcmNoL2Nza3kva2VybmVsL3NldHVwLmMgICAgICAgICAgICAgICB8ICA0
ICsrLS0KPiA+ICBhcmNoL2xvb25nYXJjaC9rZXJuZWwvc2V0dXAuYyAgICAgICAgICB8ICAyICst
Cj4gPiAgYXJjaC9taWNyb2JsYXplL2tlcm5lbC9wcm9tLmMgICAgICAgICAgfCAgMiArLQo+ID4g
IGFyY2gvbWlwcy9rZXJuZWwvcHJvbS5jICAgICAgICAgICAgICAgIHwgIDIgKy0KPiA+ICBhcmNo
L21pcHMva2VybmVsL3JlbG9jYXRlLmMgICAgICAgICAgICB8ICAyICstCj4gPiAgYXJjaC9uaW9z
Mi9rZXJuZWwvcHJvbS5jICAgICAgICAgICAgICAgfCAgNCArKy0tCj4gPiAgYXJjaC9vcGVucmlz
Yy9rZXJuZWwvcHJvbS5jICAgICAgICAgICAgfCAgMiArLQo+ID4gIGFyY2gvcG93ZXJwYy9rZXJu
ZWwvZHRfY3B1X2Z0cnMuYyAgICAgIHwgIDIgKy0KPiA+ICBhcmNoL3Bvd2VycGMva2VybmVsL3By
b20uYyAgICAgICAgICAgICB8ICAyICstCj4gPiAgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2Vy
aWVzL3BscGtzLmMgfCAgMiArLQo+ID4gIGFyY2gvcmlzY3Yva2VybmVsL3NldHVwLmMgICAgICAg
ICAgICAgIHwgIDIgKy0KPiA+ICBhcmNoL3NoL2tlcm5lbC9zZXR1cC5jICAgICAgICAgICAgICAg
ICB8ICAyICstCj4gPiAgYXJjaC91bS9rZXJuZWwvZHRiLmMgICAgICAgICAgICAgICAgICAgfCAg
MiArLQo+ID4gIGFyY2gveDg2L2tlcm5lbC9kZXZpY2V0cmVlLmMgICAgICAgICAgIHwgIDIgKy0K
PiA+ICBhcmNoL3h0ZW5zYS9rZXJuZWwvc2V0dXAuYyAgICAgICAgICAgICB8ICAyICstCj4gPiAg
ZHJpdmVycy9vZi9mZHQuYyAgICAgICAgICAgICAgICAgICAgICAgfCAxNCArKysrKysrKy0tLS0t
LQo+ID4gIGRyaXZlcnMvb2Yva2V4ZWMuYyAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KPiA+
ICBpbmNsdWRlL2xpbnV4L29mX2ZkdC5oICAgICAgICAgICAgICAgICB8ICA1ICsrKy0tCj4gPiAg
MjEgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pCj4gPgo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL2tlcm5lbC9kZXZ0cmVlLmMgYi9hcmNoL2FyYy9rZXJu
ZWwvZGV2dHJlZS5jCj4gPiBpbmRleCA0YzllNjE0NTdiMmYuLmNjNmFjN2QxMjhhYSAxMDA2NDQK
PiA+IC0tLSBhL2FyY2gvYXJjL2tlcm5lbC9kZXZ0cmVlLmMKPiA+ICsrKyBiL2FyY2gvYXJjL2tl
cm5lbC9kZXZ0cmVlLmMKPiA+IEBAIC02Miw3ICs2Miw3IEBAIGNvbnN0IHN0cnVjdCBtYWNoaW5l
X2Rlc2MgKiBfX2luaXQgc2V0dXBfbWFjaGluZV9mZHQodm9pZCAqZHQpCj4gPiAgICAgICBjb25z
dCBzdHJ1Y3QgbWFjaGluZV9kZXNjICptZGVzYzsKPiA+ICAgICAgIHVuc2lnbmVkIGxvbmcgZHRf
cm9vdDsKPiA+Cj4gPiAtICAgICBpZiAoIWVhcmx5X2luaXRfZHRfc2NhbihkdCkpCj4gPiArICAg
ICBpZiAoIWVhcmx5X2luaXRfZHRfc2NhbihkdCwgX19wYShkdCkpKQo+ID4gICAgICAgICAgICAg
ICByZXR1cm4gTlVMTDsKPiA+Cj4gPiAgICAgICBtZGVzYyA9IG9mX2ZsYXRfZHRfbWF0Y2hfbWFj
aGluZShOVUxMLCBhcmNoX2dldF9uZXh0X21hY2gpOwo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2tlcm5lbC9kZXZ0cmVlLmMgYi9hcmNoL2FybS9rZXJuZWwvZGV2dHJlZS5jCj4gPiBpbmRleCBm
ZGI3NGU2NDIwNmEuLjNiNzg5NjZlNzUwYSAxMDA2NDQKPiA+IC0tLSBhL2FyY2gvYXJtL2tlcm5l
bC9kZXZ0cmVlLmMKPiA+ICsrKyBiL2FyY2gvYXJtL2tlcm5lbC9kZXZ0cmVlLmMKPiA+IEBAIC0y
MDAsNyArMjAwLDcgQEAgY29uc3Qgc3RydWN0IG1hY2hpbmVfZGVzYyAqIF9faW5pdCBzZXR1cF9t
YWNoaW5lX2ZkdCh2b2lkICpkdF92aXJ0KQo+ID4KPiA+ICAgICAgIG1kZXNjX2Jlc3QgPSAmX19t
YWNoX2Rlc2NfR0VORVJJQ19EVDsKPiA+Cj4gPiAtICAgICBpZiAoIWR0X3ZpcnQgfHwgIWVhcmx5
X2luaXRfZHRfdmVyaWZ5KGR0X3ZpcnQpKQo+ID4gKyAgICAgaWYgKCFkdF92aXJ0IHx8ICFlYXJs
eV9pbml0X2R0X3ZlcmlmeShkdF92aXJ0LCBfX3BhKGR0X3ZpcnQpKSkKPiA+ICAgICAgICAgICAg
ICAgcmV0dXJuIE5VTEw7Cj4gPgo+ID4gICAgICAgbWRlc2MgPSBvZl9mbGF0X2R0X21hdGNoX21h
Y2hpbmUobWRlc2NfYmVzdCwgYXJjaF9nZXRfbmV4dF9tYWNoKTsKPiA+IGRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jIGIvYXJjaC9hcm02NC9rZXJuZWwvc2V0dXAuYwo+ID4g
aW5kZXggYjIyZDI4ZWM4MDI4Li4xNzcyNjI3MzljNDkgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL2Fy
bTY0L2tlcm5lbC9zZXR1cC5jCj4gPiArKysgYi9hcmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jCj4g
PiBAQCAtMTc1LDcgKzE3NSwxMSBAQCBzdGF0aWMgdm9pZCBfX2luaXQgc2V0dXBfbWFjaGluZV9m
ZHQocGh5c19hZGRyX3QgZHRfcGh5cykKPiA+ICAgICAgIGlmIChkdF92aXJ0KQo+ID4gICAgICAg
ICAgICAgICBtZW1ibG9ja19yZXNlcnZlKGR0X3BoeXMsIHNpemUpOwo+ID4KPiA+IC0gICAgIGlm
ICghZHRfdmlydCB8fCAhZWFybHlfaW5pdF9kdF9zY2FuKGR0X3ZpcnQpKSB7Cj4gPiArICAgICAv
Kgo+ID4gKyAgICAgICogZHRfdmlydCBpcyBhIGZpeG1hcCBhZGRyZXNzLCBoZW5jZSBfX3BhKGR0
X3ZpcnQpIGNhbid0IGJlIHVzZWQuCj4gPiArICAgICAgKiBQYXNzIGR0X3BoeXMgZGlyZWN0bHku
Cj4gPiArICAgICAgKi8KPiA+ICsgICAgIGlmICghZHRfdmlydCB8fCAhZWFybHlfaW5pdF9kdF9z
Y2FuKGR0X3ZpcnQsIGR0X3BoeXMpKSB7Cj4KPiBuaXQ6IEl0IGxvb2tzIGxpa2UgZWFybHlfaW5p
dF9kdF92ZXJpZnkoKSB3aWxsIG5vdyByZXR1cm4gZmFsc2UgaWYKPiAhZHRfdmlydCwgc28gd2Ug
Y2FuIGRyb3AgdGhlIGFkZGl0aW9uYWwgY2hlY2sgaGVyZS4KClRoYXQgd2FzIHRydWUgYmVmb3Jl
LCBidXQgSSdsbCBmaXggdGhpcyB1cCB3aGVuIGFwcGx5aW5nLgoKUm9iCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
