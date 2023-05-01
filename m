Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D3AC77B73
	for <kexec@archiver.kernel.org>; Mon,  1 May 2023 17:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WdCzgwptLd2Fcc27NssQgOtRbUKt0gacmfmJl2cTzhU=; b=094D/uqM0TaErW
	yasrfT2NLEbUguCaSNsZvYbl5Dd/S54lYhwf/xgrVRTDkqX/nBGju3IMcZFIuyTf8yoHPy2LefvT4
	5ua6GsYxCpkUOFnSX/y3k1cHCFlaShazc4B3TlxVbKFrH597EBcuowHMVfqsAbIcx/NW5oFK2meBA
	aen0t0SrCrf80E5U/I5gy+5gpdmJ9MwvHQdGu8yT8aoU6z3WndJamxrY1o9PeaOMHfhcMvQTV/dan
	5TXAmENl+yzsv0jMMXj9RVYK4xo+CzNWipDNAkekfYP/lFCbqBbWSdEg6QDtROpNYiN9H592sJAdH
	qH9YPrIgEMnLT7GsDreQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptXSV-00GPuh-2a;
	Mon, 01 May 2023 17:37:07 +0000
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptXSS-00GPtT-02
	for kexec@lists.infradead.org;
	Mon, 01 May 2023 17:37:05 +0000
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6a5ebf9f432so2038325a34.3
        for <kexec@lists.infradead.org>; Mon, 01 May 2023 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682962622; x=1685554622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+RNUTojqcUPndVpyqWpOuSnVDmC59OYTbJVhd//Jx0=;
        b=GYL5XLwkDZzXY+VQg5bm6uM19iSjeNRk2Da2qvHDtAme4uHcxzCq6z+H2D3uLIhsxM
         wE1DPbM1ZHuyYTSHFkc/4zCo97595k7l/RO4BllrJ6QH7XWpc+h9JLdrivS1Z6niwRP2
         yy5T0F5vmetnzIT7n5v69qeYMgSeczZl84Rhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682962622; x=1685554622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+RNUTojqcUPndVpyqWpOuSnVDmC59OYTbJVhd//Jx0=;
        b=XL4Jh48av5pVurbleORATkSDm+Wm7cksBeIdkqRsbUWKopmCrlXEK5SsSrjQ+Al7Hj
         ZgPqhfeC0+OE0BEznlnOC1Sgmq5gpCwPIj+l8oRDzA6O0+Vj4jOBgLHEXzIattiA9Epp
         4pj4GlrGRLJ9oyLTFV/Lii1ZwZ6E9qBqENkGkbiPlY4cO9ezVJk/W6FAaXUILQUbP0lX
         58u+7KI01aLbqecV6c6VFgWLvIapCrDNZJJnpVecI3WfWulreyCUuP1Zw0bbYa6hxOUk
         z8n9VjL2wT5CGBTTh0hwQeQ8gFBQw0zMBpLv8iAvhxMgzQRFpVRrR2PtfT9nXS3Vs7PJ
         50fA==
X-Gm-Message-State: AC+VfDxqyNicoXZeSJRDzFzo4ZVN4j785JCU3SfKRgLOaTcyaaYEmBlA
	Dv571MFF70n3XEciZsWrKNP/ANfiZjKSA5LkxjOiMw==
X-Google-Smtp-Source: ACHHUZ6W/rG1evtUvyOGDA/RsC1tcpLE1fdukKt/eWY70zrLeVcMI5XR9ci3bRdRTNbwvCifGXeISA==
X-Received: by 2002:a9d:7581:0:b0:6a5:f8b6:ccd2 with SMTP id s1-20020a9d7581000000b006a5f8b6ccd2mr7381367otk.16.1682962621889;
        Mon, 01 May 2023 10:37:01 -0700 (PDT)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id m7-20020a0568301e6700b006a5e0165d3esm12118657otr.19.2023.05.01.10.37.01
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 10:37:01 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-547705d6197so1611301eaf.3
        for <kexec@lists.infradead.org>; Mon, 01 May 2023 10:37:01 -0700 (PDT)
X-Received: by 2002:a17:90a:1543:b0:24b:2f97:9208 with SMTP id
 y3-20020a17090a154300b0024b2f979208mr14865070pja.0.1682962600487; Mon, 01 May
 2023 10:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org>
 <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org> <CAKwvOd=9RMivtkKX27nDDsagH5yCWjpAOvpE2uaW38KYC57vtg@mail.gmail.com>
 <CANiDSCtDfPffUQTuH3JiPWC+87FBtpog7kT954PSoiTbB_fmJQ@mail.gmail.com> <20230501-griminess-defiling-73b367bb2e47@spud>
In-Reply-To: <20230501-griminess-defiling-73b367bb2e47@spud>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 1 May 2023 19:36:29 +0200
X-Gmail-Original-Message-ID: <CANiDSCsKKh7pSbYRu6=EbF4PL5UXk5gYpDTk3KzjzW9ni5Hc2g@mail.gmail.com>
Message-ID: <CANiDSCsKKh7pSbYRu6=EbF4PL5UXk5gYpDTk3KzjzW9ni5Hc2g@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] risc/purgatory: Add linker script
To: Conor Dooley <conor@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Eric Biederman <ebiederm@xmission.com>, 
	Philipp Rudo <prudo@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>, 
	Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ross Zwisler <zwisler@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Simon Horman <horms@kernel.org>, llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, stable@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_103704_054401_5DC52C1C 
X-CRM114-Status: GOOD (  31.41  )
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

SGkgQ29ub3IKCkZpeGVkIG9uIG15IGJyYW5jaApodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9yaWJhbGRhL2xpbnV4LmdpdC9jb21taXQvP2g9YjQva2V4ZWNf
Y2xhbmcxNiZpZD0xZTljZGE5ZmE2MzhjYzcyNTgxOTg2ZjYwYjQ5MGNjMDY5YTM4Zjc1CgoKV2ls
bCBzdWJtaXQgYSBuZXcgdmVyc2lvbiBhZnRlciBhIHdoaWxlIDopCgpUaGFua3MhCgpPbiBNb24s
IDEgTWF5IDIwMjMgYXQgMTk6MjgsIENvbm9yIERvb2xleSA8Y29ub3JAa2VybmVsLm9yZz4gd3Jv
dGU6Cj4KPiBPbiBNb24sIE1heSAwMSwgMjAyMyBhdCAwNzoxODoxMlBNICswMjAwLCBSaWNhcmRv
IFJpYmFsZGEgd3JvdGU6Cj4gPiBPbiBNb24sIDEgTWF5IDIwMjMgYXQgMTg6MTksIE5pY2sgRGVz
YXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24g
TW9uLCBNYXkgMSwgMjAyMyBhdCA1OjM54oCvQU0gUmljYXJkbyBSaWJhbGRhIDxyaWJhbGRhQGNo
cm9taXVtLm9yZz4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBJZiBQR08gaXMgZW5hYmxlZCwgdGhl
IHB1cmdhdG9yeSBlbmRzIHVwIHdpdGggbXVsdGlwbGUgLnRleHQgc2VjdGlvbnMuCj4gPiA+ID4g
VGhpcyBpcyBub3Qgc3VwcG9ydGVkIGJ5IGtleGVjIGFuZCBjcmFzaGVzIHRoZSBzeXN0ZW0uCj4g
PiA+ID4KPiA+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+ID4gPiA+IEZpeGVzOiA5
MzA0NTcwNTdhYmUgKCJrZXJuZWwva2V4ZWNfZmlsZS5jOiBzcGxpdCB1cCBfX2tleGVjX2xvYWRf
cHVyYWdvcnkiKQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gUmliYWxkYSA8cmliYWxk
YUBjaHJvbWl1bS5vcmc+Cj4gPiA+Cj4gPiA+IEhpIFJpY2FyZG8sCj4gPiA+IFRoYW5rcyBmb3Ig
dGhlIHNlcmllcy4gIERvZXMgdGhpcyBwYXRjaCA0LzQgbmVlZCBhIG5ldyBvbmxpbmUgY29tbWl0
Cj4gPiA+IGRlc2NyaXB0aW9uPyBJdCdzIG5vdCBhZGRpbmcgYSBsaW5rZXIgc2NyaXB0IChtYXli
ZSBhbiBlYXJsaWVyIHZlcnNpb24KPiA+ID4gd2FzKS4KPgo+ID4gVGhhbmtzIGZvciBjYXRjaGlu
ZyB0aGlzLiBJdCBzaG91bGQgaGF2ZSBzYWlkCj4gPgo+ID4gcmlzYy9wdXJnYXRvcnk6IFJlbW92
ZSBwcm9maWxlIG9wdGltaXphdGlvbiBmbGFncwo+ICAgICAgXl4KPiBQZXJoYXBzIHdpdGggdGhl
IG9taXR0ZWQgdiBhZGRlZCB0b28/Cj4KPiBBbHNvIHdoaWxlIHBsYXlpbmcgdGhlICRzdWJqZWN0
IG5pdHBpY2tpbmcgZ2FtZSwgaXMgaXQgbm90IGNhbGxlZAo+ICJwcm9maWxlKiotZ3VpZGVkKiog
b3B0aW1pc2F0aW9uIiAoYW5kIGRpdHRvIGluIHRoZSBjb21tZW50cyk/Cj4KPiBDaGVlcnMsCj4g
Q29ub3IuCj4KPiA+IFdpbGwgZml4IGl0IG9uIG15IGxvY2FsIGJyYW5jaCBpbiBjYXNlIHRoZXJl
IGlzIGEgbmV4dCB2ZXJzaW9uIG9mIHRoZQo+ID4gc2VyaWVzLiBPdGhlcndpc2UsIHBsZWFzZSB0
aGUgbWFpbnRhaW5lciBmaXggdGhlIHN1YmplY3QuCj4KPiA+ID4gPiAtLS0KPiA+ID4gPiAgYXJj
aC9yaXNjdi9wdXJnYXRvcnkvTWFrZWZpbGUgfCA1ICsrKysrCj4gPiA+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKykKPiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jp
c2N2L3B1cmdhdG9yeS9NYWtlZmlsZSBiL2FyY2gvcmlzY3YvcHVyZ2F0b3J5L01ha2VmaWxlCj4g
PiA+ID4gaW5kZXggNTczMDc5N2E2YjQwLi5jZjNhNDQxMjFhOTAgMTAwNjQ0Cj4gPiA+ID4gLS0t
IGEvYXJjaC9yaXNjdi9wdXJnYXRvcnkvTWFrZWZpbGUKPiA+ID4gPiArKysgYi9hcmNoL3Jpc2N2
L3B1cmdhdG9yeS9NYWtlZmlsZQo+ID4gPiA+IEBAIC0zNSw2ICszNSwxMSBAQCBDRkxBR1Nfc2hh
MjU2Lm8gOj0gLURfX0RJU0FCTEVfRVhQT1JUUwo+ID4gPiA+ICBDRkxBR1Nfc3RyaW5nLm8gOj0g
LURfX0RJU0FCTEVfRVhQT1JUUwo+ID4gPiA+ICBDRkxBR1NfY3R5cGUubyA6PSAtRF9fRElTQUJM
RV9FWFBPUlRTCj4gPiA+ID4KPiA+ID4gPiArIyBXaGVuIHByb2ZpbGUgb3B0aW1pemF0aW9uIGlz
IGVuYWJsZWQsIGxsdm0gZW1pdHMgdHdvIGRpZmZlcmVudCBvdmVybGFwcGluZwo+ID4gPiA+ICsj
IHRleHQgc2VjdGlvbnMsIHdoaWNoIGlzIG5vdCBzdXBwb3J0ZWQgYnkga2V4ZWMuIFJlbW92ZSBw
cm9maWxlIG9wdGltaXphdGlvbgo+ID4gPiA+ICsjIGZsYWdzLgo+ID4gPiA+ICtLQlVJTERfQ0ZM
QUdTIDo9ICQoZmlsdGVyLW91dCAtZnByb2ZpbGUtc2FtcGxlLXVzZT0lIC1mcHJvZmlsZS11c2U9
JSwkKEtCVUlMRF9DRkxBR1MpKQo+ID4gPiA+ICsKPiA+ID4gPiAgIyBXaGVuIGxpbmtpbmcgcHVy
Z2F0b3J5LnJvIHdpdGggLXIgdW5yZXNvbHZlZCBzeW1ib2xzIGFyZSBub3QgY2hlY2tlZCwKPiA+
ID4gPiAgIyBhbHNvIGxpbmsgYSBwdXJnYXRvcnkuY2hrIGJpbmFyeSB3aXRob3V0IC1yIHRvIGNo
ZWNrIGZvciB1bnJlc29sdmVkIHN5bWJvbHMuCj4gPiA+ID4gIFBVUkdBVE9SWV9MREZMQUdTIDo9
IC1lIHB1cmdhdG9yeV9zdGFydCAteiBub2RlZmF1bHRsaWIKPiA+ID4gPgo+ID4gPiA+IC0tCj4g
PiA+ID4gMi40MC4xLjQ5NS5nYzgxNmUwOWI1M2QtZ29vZwo+ID4gPiA+Cj4gPiA+Cj4gPiA+Cj4g
PiA+IC0tCj4gPiA+IFRoYW5rcywKPiA+ID4gfk5pY2sgRGVzYXVsbmllcnMKPiA+Cj4gPgo+ID4K
PiA+IC0tCj4gPiBSaWNhcmRvIFJpYmFsZGEKPiA+Cj4gPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0Cj4g
PiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnCj4gPiBodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2CgoKCi0tIApSaWNhcmRvIFJpYmFs
ZGEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
