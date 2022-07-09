Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0C9C433EF
	for <kexec@archiver.kernel.org>; Sat,  9 Jul 2022 18:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sZvyPPphOl7GMDKg3PfbSo12Ak7sP6bUaItIvRbOxOY=; b=P9QGMeAVF2ogCa
	mLpngFnC9voEpF9PZ9kXFCcJ4K3AsdzIjmZM0w23EHL+kWxotdJx6IAxf4Pm/PGwrWFBSP90nJoB+
	GFJwHGOtJbFPKKSRUKt76aKS6HlJsc9QpJfeRVgf0vb5m1EQIErM6oKZcA0Qg4GeYQ7yhUUDh9QDA
	OSklVkPwGlS0cxiGncTKXrz8GA1kAgw8/3MSqduXWdZpZLjmD+dB+mWyNh06Zuh/7WM5Dkk4Xa+s5
	5iFIKWruhE5oZsEvT0aOlHTDrvJyKbr64C2iM+4Rwfb9VH19JJeA0JS62JupKbJ/ddz6Bq6KbMl4Z
	Bde93uE+vFQwhqn1pLdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAFOz-008vtf-9n; Sat, 09 Jul 2022 18:42:01 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAFOs-008vtG-T2
	for kexec@lists.infradead.org; Sat, 09 Jul 2022 18:41:56 +0000
Received: by mail-wr1-x42b.google.com with SMTP id b26so2238697wrc.2
        for <kexec@lists.infradead.org>; Sat, 09 Jul 2022 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afz0HFCyaKK/n0V2ad4ArLhaeQl00mG1v6qHamoozFM=;
        b=qVPI4o30sQoaP990Eq4HC7iN16X9vxdrJid76VUq/muhA+zQuWbfRAgeD9YsooQerS
         oZzyn7kdc1Ft59nbvy+HLy09c/Fh0mO1RtQrupE/XmJ13wvxFN5wQdyKLoeJviLZwTI7
         O+7aZ6PoUufXZkntdg0eQENSjBkyrdm7cJ2R6H91qaHjrMH2mNJWa9nWg8aBNLAGhLaq
         vchWj1Bx7QqcBJKysT+bpQa/Bq+HVGURjBMDh0XKNo+9rHrTvaagoeToWiS3ExTVc8dF
         JGA3w8jzDEEmQAdfH7yL9RBZkX8fcZWdJFk5AtW4hB32nc6BUxEhCx0Zu1BL+WZCMegh
         H9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afz0HFCyaKK/n0V2ad4ArLhaeQl00mG1v6qHamoozFM=;
        b=sOTrsEiRRAWDIBkMR8aNutPQybC8HP+2I1KZ0cl6/N0WWA5aCnAqI3rjNNnztNfQ7R
         +Taam8PlAKlMISRCNNu+QeZlk4nlaWHZPDiLQe4T8aOwQihCGmgKu0TXfn7YWcCZnzGD
         fcD19KPnE4rcdxjckbkbFeLdxBITC0pclU++FYfmpJt0k3TBphYHblGqP6rHWlgxupmI
         0MgPraaPmZEn7aCAffUGZnlggiSgCVuxZD+KvsodJgfKvG8dBlp/XMIQRwfQAHT+QPLW
         /D4FXn5c+TFxsk6Wt2i1rtnvofLxelTI2kgZONJtzBWFlSsr37rXlHi9kolPXYJHA+26
         M1HA==
X-Gm-Message-State: AJIora8P0wRfCyfw5Ff/j1zJ6SOO1WmvcTzfKqHnvzQPapCoxObEO5nd
	EI5Y0ohN1ICYlKtbxGbLJko=
X-Google-Smtp-Source: AGRyM1uWyUvU0+0n9AwqdWONf56SsxzB0N2QsG5ipwMtgssM95HDxMgnQY7m36n5baEki5JcGQN/Pw==
X-Received: by 2002:a5d:5952:0:b0:21d:7c9b:e444 with SMTP id e18-20020a5d5952000000b0021d7c9be444mr9543428wri.75.1657392111225;
        Sat, 09 Jul 2022 11:41:51 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id p129-20020a1c2987000000b003a17ab4e7c8sm5652149wmp.39.2022.07.09.11.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 11:41:49 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com, Eric DeVolder <eric.devolder@oracle.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com, sourabhjain@linux.ibm.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, ira.weiny@intel.com
Subject: Re: [PATCH v9 7/7] x86/crash: Add x86 crash hotplug support
Date: Sat, 09 Jul 2022 20:41:47 +0200
Message-ID: <4427532.LvFx2qVVIh@opensuse>
In-Reply-To: <3bd962c3-7dc6-6dd0-6d0d-2e4667a69a8a@oracle.com>
References: <20220613224240.79400-1-eric.devolder@oracle.com> <2843978.e9J7NaK4W3@opensuse> <3bd962c3-7dc6-6dd0-6d0d-2e4667a69a8a@oracle.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220709_114154_981632_6ACED603 
X-CRM114-Status: GOOD (  35.82  )
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

T24gdmVuZXJkw6wgOCBsdWdsaW8gMjAyMiAyMzowNzoyMCBDRVNUIEVyaWMgRGVWb2xkZXIgd3Jv
dGU6Cj4gCj4gT24gNy84LzIyIDE0OjM4LCBGYWJpbyBNLiBEZSBGcmFuY2VzY28gd3JvdGU6Cj4g
PiBPbiBtYXJ0ZWTDrCAxNCBnaXVnbm8gMjAyMiAwMDo0Mjo0MCBDRVNUIEVyaWMgRGVWb2xkZXIg
d3JvdGU6Cj4gPj4gRm9yIHg4Nl82NCwgd2hlbiBDUFUgb3IgbWVtb3J5IGlzIGhvdCB1bi9wbHVn
Z2VkLCB0aGUgY3Jhc2gKPiA+PiBlbGZjb3JlaGRyLCB3aGljaCBkZXNjcmliZXMgdGhlIENQVXMg
YW5kIG1lbW9yeSBpbiB0aGUgc3lzdGVtLAo+ID4+IG11c3QgYWxzbyBiZSB1cGRhdGVkLgo+ID4+
Cj4gPj4gV2hlbiBsb2FkaW5nIHRoZSBjcmFzaCBrZXJuZWwgdmlhIGtleGVjX2xvYWQgb3Iga2V4
ZWNfZmlsZV9sb2FkLAo+ID4+IHRoZSBlbGZjb3JlaGRyIGlzIGlkZW50aWZpZWQgYXQgcnVuIHRp
bWUgaW4KPiA+PiBjcmFzaF9jb3JlOmhhbmRsZV9ob3RwbHVnX2V2ZW50KCkuCj4gPj4KPiA+PiBU
byB1cGRhdGUgdGhlIGVsZmNvcmVoZHIgZm9yIHg4Nl82NCwgYSBuZXcgZWxmY29yZWhkciBtdXN0
IGJlCj4gPj4gZ2VuZXJhdGVkIGZyb20gdGhlIGF2YWlsYWJsZSBDUFVzIGFuZCBtZW1vcnkuIFRo
ZSBuZXcgZWxmY29yZWhkcgo+ID4+IGlzIHByZXBhcmVkIGludG8gYSBidWZmZXIsIGFuZCB0aGVu
IGluc3RhbGxlZCBvdmVyIHRoZSB0b3Agb2YKPiA+PiB0aGUgZXhpc3RpbmcgZWxmY29yZWhkci4K
PiA+Pgo+ID4+IEluIHRoZSBwYXRjaCAna2V4ZWM6IGV4Y2x1ZGUgZWxmY29yZWhkciBmcm9tIHRo
ZSBzZWdtZW50IGRpZ2VzdCcKPiA+PiB0aGUgbmVlZCB0byB1cGRhdGUgcHVyZ2F0b3J5IGR1ZSB0
byB0aGUgY2hhbmdlIGluIGVsZmNvcmVoZHIgd2FzCj4gPj4gZWxpbWluYXRlZC4gIEFzIGEgcmVz
dWx0LCBubyBjaGFuZ2VzIHRvIHB1cmdhdG9yeSBvciBib290X3BhcmFtcwo+ID4+IChhcyB0aGUg
ZWxmY29yZWhkcj0ga2VybmVsIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXIgcG9pbnRlcgo+ID4+IHJl
bWFpbnMgdW5jaGFuZ2VkIGFuZCBjb3JyZWN0KSBhcmUgbmVlZGVkLCBqdXN0IGVsZmNvcmVoZHIu
Cj4gPj4KPiA+PiBUbyBhY2NvbW1vZGF0ZSBhIGdyb3dpbmcgbnVtYmVyIG9mIHJlc291cmNlcyB2
aWEgaG90cGx1ZywgdGhlCj4gPj4gZWxmY29yZWhkciBzZWdtZW50IG11c3QgYmUgc3VmZmljaWVu
dGx5IGxhcmdlIGVub3VnaCB0byBhY2NvbW1vZGF0ZQo+ID4+IGNoYW5nZXMsIHNlZSB0aGUgQ1JB
U0hfTUFYX01FTU9SWV9SQU5HRVMgY29uZmlndXJlIGl0ZW0uCj4gPj4KPiA+PiBXaXRoIHRoaXMg
Y2hhbmdlLCBjcmFzaCBob3RwbHVnIGZvciBrZXhlY19maWxlX2xvYWQgc3lzY2FsbAo+ID4+IGlz
IHN1cHBvcnRlZC4gVGhlIGtleGVjX2xvYWQgaXMgYWxzbyBzdXBwb3J0ZWQsIGJ1dCBhbHNvCj4g
Pj4gcmVxdWlyZXMgYSBjb3JyZXNwb25kaW5nIGNoYW5nZSB0byB1c2Vyc3BhY2Uga2V4ZWMtdG9v
bHMuCj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIERlVm9sZGVyIDxlcmljLmRldm9sZGVy
QG9yYWNsZS5jb20+Cj4gPj4gLS0tCj4gPj4gICBhcmNoL3g4Ni9LY29uZmlnICAgICAgICB8ICAx
MSArKysrCj4gPj4gICBhcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYyB8IDExNiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKworKwo+ID4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMjcg
aW5zZXJ0aW9ucygrKQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L0tjb25maWcgYi9h
cmNoL3g4Ni9LY29uZmlnCj4gPj4gaW5kZXggNzYyYTBiNmFiOGI2Li5lOWVlY2ZmM2I5N2QgMTAw
NjQ0Cj4gPj4gLS0tIGEvYXJjaC94ODYvS2NvbmZpZwo+ID4+ICsrKyBiL2FyY2gveDg2L0tjb25m
aWcKPiA+PiBAQCAtMjA4Miw2ICsyMDgyLDE3IEBAIGNvbmZpZyBDUkFTSF9EVU1QCj4gPj4gICAJ
ICAoQ09ORklHX1JFTE9DQVRBQkxFPXkpLgo+ID4+ICAgCSAgRm9yIG1vcmUgZGV0YWlscyBzZWUg
RG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC9rZHVtcC5yc3QKPiA+PiAgIAo+ID4+ICtj
b25maWcgQ1JBU0hfTUFYX01FTU9SWV9SQU5HRVMKPiA+PiArCWRlcGVuZHMgb24gQ1JBU0hfRFVN
UCAmJiBLRVhFQ19GSUxFICYmIChIT1RQTFVHX0NQVSB8fAo+ID4gTUVNT1JZX0hPVFBMVUcpCj4g
Pj4gKwlpbnQKPiA+PiArCWRlZmF1bHQgMzI3NjgKPiA+PiArCWhlbHAKPiA+PiArCSAgRm9yIHRo
ZSBrZXhlY19maWxlX2xvYWQgcGF0aCwgc3BlY2lmeSB0aGUgbWF4aW11bSBudW1iZXIgb2YKPiA+
PiArCSAgbWVtb3J5IHJlZ2lvbnMsIGVnLiBhcyByZXByZXNlbnRlZCBieSB0aGUgJ1N5c3RlbSBS
QU0nIGVudHJpZXMKPiA+PiArCSAgaW4gL3Byb2MvaW9tZW0sIHRoYXQgdGhlIGVsZmNvcmVoZHIg
YnVmZmVyL3NlZ21lbnQgY2FuCj4gPiBhY2NvbW1vZGF0ZS4KPiA+PiArCSAgVGhpcyB2YWx1ZSBp
cyBjb21iaW5lZCB3aXRoIE5SX0NQVVMgYW5kIG11bHRpcGxpZWQgYnkKPiA+IEVsZjY0X1BoZHIK
PiA+PiArCSAgc2l6ZSB0byBkZXRlcm1pbmUgdGhlIGZpbmFsIGJ1ZmZlciBzaXplLgo+ID4+ICsK
PiA+PiAgIGNvbmZpZyBLRVhFQ19KVU1QCj4gPj4gICAJYm9vbCAia2V4ZWMganVtcCIKPiA+PiAg
IAlkZXBlbmRzIG9uIEtFWEVDICYmIEhJQkVSTkFUSU9OCj4gPj4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2tlcm5lbC9jcmFzaC5jIGIvYXJjaC94ODYva2VybmVsL2NyYXNoLmMKPiA+PiBpbmRleCA5
ZGI0MWNjZThkOTcuLmI5Y2RmN2EwZDg2OCAxMDA2NDQKPiA+PiAtLS0gYS9hcmNoL3g4Ni9rZXJu
ZWwvY3Jhc2guYwo+ID4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jCj4gPj4gQEAgLTI1
LDYgKzI1LDcgQEAKPiA+PiAgICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+Cj4gPj4gICAjaW5jbHVk
ZSA8bGludXgvdm1hbGxvYy5oPgo+ID4+ICAgI2luY2x1ZGUgPGxpbnV4L21lbWJsb2NrLmg+Cj4g
Pj4gKyNpbmNsdWRlIDxsaW51eC9oaWdobWVtLmg+Cj4gPj4gICAKPiA+PiAgICNpbmNsdWRlIDxh
c20vcHJvY2Vzc29yLmg+Cj4gPj4gICAjaW5jbHVkZSA8YXNtL2hhcmRpcnEuaD4KPiA+PiBAQCAt
Mzk4LDcgKzM5OSwxNyBAQCBpbnQgY3Jhc2hfbG9hZF9zZWdtZW50cyhzdHJ1Y3Qga2ltYWdlICpp
bWFnZSkKPiA+PiAgIAlpbWFnZS0+ZWxmX2hlYWRlcnMgPSBrYnVmLmJ1ZmZlcjsKPiA+PiAgIAlp
bWFnZS0+ZWxmX2hlYWRlcnNfc3ogPSBrYnVmLmJ1ZnN6Owo+ID4+ICAgCj4gPj4gKyNpZiBkZWZp
bmVkKENPTkZJR19IT1RQTFVHX0NQVSkgfHwgZGVmaW5lZChDT05GSUdfTUVNT1JZX0hPVFBMVUcp
Cj4gPj4gKwkvKiBFbnN1cmUgZWxmY29yZWhkciBzZWdtZW50IGxhcmdlIGVub3VnaCBmb3IgaG90
cGx1ZyBjaGFuZ2VzICovCj4gPj4gKwlrYnVmLm1lbXN6ID0gKENPTkZJR19OUl9DUFVTX0RFRkFV
TFQgKwo+ID4gQ09ORklHX0NSQVNIX01BWF9NRU1PUllfUkFOR0VTKSAqIHNpemVvZihFbGY2NF9Q
aGRyKTsKPiA+PiArCS8qIEZvciBtYXJraW5nIGFzIHVzYWJsZSB0byBjcmFzaCBrZXJuZWwgKi8K
PiA+PiArCWltYWdlLT5lbGZfaGVhZGVyc19zeiA9IGtidWYubWVtc3o7Cj4gPj4gKwkvKiBSZWNv
cmQgdGhlIGluZGV4IG9mIHRoZSBlbGZjb3JlaGRyIHNlZ21lbnQgKi8KPiA+PiArCWltYWdlLT5l
bGZjb3JlaGRyX2luZGV4ID0gaW1hZ2UtPm5yX3NlZ21lbnRzOwo+ID4+ICsJaW1hZ2UtPmVsZmNv
cmVoZHJfaW5kZXhfdmFsaWQgPSB0cnVlOwo+ID4+ICsjZWxzZQo+ID4+ICAgCWtidWYubWVtc3og
PSBrYnVmLmJ1ZnN6Owo+ID4+ICsjZW5kaWYKPiA+PiAgIAlrYnVmLmJ1Zl9hbGlnbiA9IEVMRl9D
T1JFX0hFQURFUl9BTElHTjsKPiA+PiAgIAlrYnVmLm1lbSA9IEtFWEVDX0JVRl9NRU1fVU5LTk9X
TjsKPiA+PiAgIAlyZXQgPSBrZXhlY19hZGRfYnVmZmVyKCZrYnVmKTsKPiA+PiBAQCAtNDEzLDMg
KzQyNCwxMDggQEAgaW50IGNyYXNoX2xvYWRfc2VnbWVudHMoc3RydWN0IGtpbWFnZSAqaW1hZ2Up
Cj4gPj4gICAJcmV0dXJuIHJldDsKPiA+PiAgIH0KPiA+PiAgICNlbmRpZiAvKiBDT05GSUdfS0VY
RUNfRklMRSAqLwo+ID4+ICsKPiA+PiArI2lmIGRlZmluZWQoQ09ORklHX0hPVFBMVUdfQ1BVKSB8
fCBkZWZpbmVkKENPTkZJR19NRU1PUllfSE9UUExVRykKPiA+PiAraW50IGNyYXNoX2hvdHBsdWdf
c3VwcG9ydCh2b2lkKSB7IHJldHVybiAxOyB9Cj4gPj4gK3ZvaWQgKmFyY2hfbWFwX2NyYXNoX3Bh
Z2VzKHVuc2lnbmVkIGxvbmcgcGFkZHIsIHVuc2lnbmVkIGxvbmcgc2l6ZSkKPiA+PiArewo+ID4+
ICsJLyoKPiA+PiArCSAqIE5PVEU6IFRoZSBhZGRyZXNzZXMgYW5kIHNpemVzIHBhc3NlZCB0byB0
aGlzIHJvdXRpbmUgaGF2ZQo+ID4+ICsJICogYWxyZWFkeSBiZWVuIGZ1bGx5IGFsaWduZWQgb24g
cGFnZSBib3VuZGFyaWVzLiBUaGVyZSBpcyBubwo+ID4+ICsJICogbmVlZCBmb3IgbWFzc2FnaW5n
IHRoZSBhZGRyZXNzIG9yIHNpemUuCj4gPj4gKwkgKi8KPiA+PiArCXZvaWQgKnB0ciA9IE5VTEw7
Cj4gPj4gKwo+ID4+ICsJLyogTk9URTogcmVxdWlyZXMgYXJjaF9rZXhlY19bdW5dcHJvdGVjdF9j
cmFzaGtyZXMoKSBmb3Igd3JpdGUKPiA+IGFjY2VzcyAqLwo+ID4+ICsJaWYgKHNpemUgPiAwKSB7
Cj4gPj4gKwkJc3RydWN0IHBhZ2UgKnBhZ2UgPSBwZm5fdG9fcGFnZShwYWRkciA+PiBQQUdFX1NI
SUZUKTsKPiA+PiArCj4gPj4gKwkJcHRyID0ga21hcChwYWdlKTsKPiA+PiArCX0KPiA+IAo+ID4g
a21hcF9sb2NhbF9wYWdlKCkgaXMgcHJlZmVycmVkIG92ZXIga21hcCgpIHdoaWNoIHNob3VsZCBi
ZSBhdm9pZGVkIGluIApuZXcKPiA+IGNvZGUgKHBsZWFzZSB0YWtlIGEgbG9vayBhdCBoaWdobWVt
LnJzdCB3aGljaCBJIHJlY2VudGx5IHVwZGF0ZWQpLgo+ID4gCj4gPiBDYW4geW91IHBsZWFzZSBj
aGVjayBpZiB5b3UgY2FuIGVhc2lseSBhdm9pZCB1c2luZyBrbWFwKCk/IE90aGVyd2lzZSwgCnRo
aXMKPiA+IGNvZGUgd2lsbCBiZSBhZGRlZCB0byBteSAobG9uZykgcXVldWUgYW5kIGNoYW5nZWQg
b25lIGRheSBvciB0aGUgb3RoZXIgCjotKQo+ID4gCj4gPiBUaGFua3MsCj4gPiAKPiA+IEZhYmlv
Cj4gRmFiaW8sCj4gSSBjb252ZXJ0ZWQgdGhpcyB0byBrbWFwX2xvY2FsX3BhZ2UoKSEKPiBUaGFu
a3MhCj4gZXJpYwo+IAo+ID4gCkVyaWMsCgpUaGFua3MgZm9yIHRoZSB2ZXJ5IHF1aWNrIHJlYWN0
aW9uIHRvIG15IHN1Z2dlc3Rpb24uCgpGYWJpbwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
