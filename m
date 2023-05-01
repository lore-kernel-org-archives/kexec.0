Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ECBC77B61
	for <kexec@archiver.kernel.org>; Mon,  1 May 2023 17:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DH18jyKlsXEMRhEEpcu7X1N+htmdmv5/aBGBJNf3rW0=; b=hwa0zux7sW8/tH
	Cz13CjPRIRrNlPZWUnwu2JPwPZY/L1X6VMUx6Lu9xcnuiSmwYKYRP5seP7MvfnbxAU4S6SiB7a04U
	esw71HwQBEn5zlDR5CCqDB+B9tI1ymtSlr2GLYO/+w+hi866puc8/VeQxyl4d8VnjjCW9TvFoM+Pd
	5jU/cG0CZVjUQnxbaKqaQGlagiADOc95iRCBd4pWxl0Orhf0MBI2kMLS0U7i8BCg/i9RhwzEh+Vnx
	9RXxDNiFw3rM4nINRzp6VWTrbzSzlp1hqI45LeiFRFk5APzFWdwrIeCpVp0gHfO04JETyX4zs+CUh
	QTR/Pwj9UORiwD9NfTiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptXAo-00GOoQ-1z;
	Mon, 01 May 2023 17:18:50 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptXAl-00GOnQ-1N
	for kexec@lists.infradead.org;
	Mon, 01 May 2023 17:18:48 +0000
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9246a5f3feso4778507276.1
        for <kexec@lists.infradead.org>; Mon, 01 May 2023 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682961525; x=1685553525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDAy0yw2Hl6Xad3kepfPR0FriSjDMaQH5Y0jnLgi2V4=;
        b=oDAyKLSdxWeDf2Rr539YuGPN8WIpEGf8MZUyaYq5jr+2u5r+cTYAw2jASoneiiCznU
         2SvyyFMMDnvtDUHjWd0FR1VXwxNkJF1Db2fr3bNgMpEqVPMJ7oTUtw4hQgx3+k8EZndj
         FscTv8obyqztv1iAv4Pz/neD2LiCUt46YSdAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682961525; x=1685553525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDAy0yw2Hl6Xad3kepfPR0FriSjDMaQH5Y0jnLgi2V4=;
        b=Lt/Y8v72lh932p1+x7PaNPHdvpWQt+iXSrtUFeuxgzm1ojg3iFDiyLxNpR9M5SmHFU
         UrCr2ZkHuRSf2eQXUTtXLfDgKSBgLlwT7cGUTrJDIqRjsnzt/Hb9qxl2qMhaa6oreti5
         ZQ1ernmFzvMzecZbYUjUpWf7Io5gIbHGO6bxFT8LPXZnF2l6W4ToGffO0j3pFBp10oJM
         nEe6n/7Z6hJQFQFske9pYYhx2v38RQcrc4HqChjcPujs5JwUm2P0lTWI52RzZkKlPv02
         YHAJWoQlmSnWNdXNuLC+hHJk6dINkup5klAVwOQDRX08c/cMmGwSDX2QifiS9LxWnhTX
         OawQ==
X-Gm-Message-State: AC+VfDzBqzF1+aucdfeR3Sw+Cyo3fmqr8PpOPlDQBZTug1f8LrY8lxjP
	ASNmvgNAPxXOdlHdEbP4JdG8qLRFvf36vI9c0WXuLg==
X-Google-Smtp-Source: ACHHUZ72yhfHgaQO6Zz4gPYq57K8sbfhJFFBDD7DjIBvIe/KBYOgyIM7+9ZkwIae61B8K4wJ6yW4Yw==
X-Received: by 2002:a25:1445:0:b0:b9e:1b0:f134 with SMTP id 66-20020a251445000000b00b9e01b0f134mr4226482ybu.41.1682961525105;
        Mon, 01 May 2023 10:18:45 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id y189-20020a257dc6000000b00b9a7695e930sm2547530ybc.9.2023.05.01.10.18.44
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 10:18:44 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-b9dcd91a389so3096339276.2
        for <kexec@lists.infradead.org>; Mon, 01 May 2023 10:18:44 -0700 (PDT)
X-Received: by 2002:a17:902:f70f:b0:1a8:1c9a:f68 with SMTP id
 h15-20020a170902f70f00b001a81c9a0f68mr17818554plo.36.1682961504069; Mon, 01
 May 2023 10:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org>
 <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org> <CAKwvOd=9RMivtkKX27nDDsagH5yCWjpAOvpE2uaW38KYC57vtg@mail.gmail.com>
In-Reply-To: <CAKwvOd=9RMivtkKX27nDDsagH5yCWjpAOvpE2uaW38KYC57vtg@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 1 May 2023 19:18:12 +0200
X-Gmail-Original-Message-ID: <CANiDSCtDfPffUQTuH3JiPWC+87FBtpog7kT954PSoiTbB_fmJQ@mail.gmail.com>
Message-ID: <CANiDSCtDfPffUQTuH3JiPWC+87FBtpog7kT954PSoiTbB_fmJQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] risc/purgatory: Add linker script
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Philipp Rudo <prudo@linux.vnet.ibm.com>, 
	Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
X-CRM114-CacheID: sfid-20230501_101847_482358_B1832F02 
X-CRM114-Status: GOOD (  24.90  )
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

SGkgTmljawoKVGhhbmtzIGZvciBjYXRjaGluZyB0aGlzLiBJdCBzaG91bGQgaGF2ZSBzYWlkCgpy
aXNjL3B1cmdhdG9yeTogUmVtb3ZlIHByb2ZpbGUgb3B0aW1pemF0aW9uIGZsYWdzCgpXaWxsIGZp
eCBpdCBvbiBteSBsb2NhbCBicmFuY2ggaW4gY2FzZSB0aGVyZSBpcyBhIG5leHQgdmVyc2lvbiBv
ZiB0aGUKc2VyaWVzLiBPdGhlcndpc2UsIHBsZWFzZSB0aGUgbWFpbnRhaW5lciBmaXggdGhlIHN1
YmplY3QuCgpUaGFua3MhCgpPbiBNb24sIDEgTWF5IDIwMjMgYXQgMTg6MTksIE5pY2sgRGVzYXVs
bmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgTWF5IDEs
IDIwMjMgYXQgNTozOeKAr0FNIFJpY2FyZG8gUmliYWxkYSA8cmliYWxkYUBjaHJvbWl1bS5vcmc+
IHdyb3RlOgo+ID4KPiA+IElmIFBHTyBpcyBlbmFibGVkLCB0aGUgcHVyZ2F0b3J5IGVuZHMgdXAg
d2l0aCBtdWx0aXBsZSAudGV4dCBzZWN0aW9ucy4KPiA+IFRoaXMgaXMgbm90IHN1cHBvcnRlZCBi
eSBrZXhlYyBhbmQgY3Jhc2hlcyB0aGUgc3lzdGVtLgo+ID4KPiA+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnCj4gPiBGaXhlczogOTMwNDU3MDU3YWJlICgia2VybmVsL2tleGVjX2ZpbGUuYzog
c3BsaXQgdXAgX19rZXhlY19sb2FkX3B1cmFnb3J5IikKPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2Fy
ZG8gUmliYWxkYSA8cmliYWxkYUBjaHJvbWl1bS5vcmc+Cj4KPiBIaSBSaWNhcmRvLAo+IFRoYW5r
cyBmb3IgdGhlIHNlcmllcy4gIERvZXMgdGhpcyBwYXRjaCA0LzQgbmVlZCBhIG5ldyBvbmxpbmUg
Y29tbWl0Cj4gZGVzY3JpcHRpb24/IEl0J3Mgbm90IGFkZGluZyBhIGxpbmtlciBzY3JpcHQgKG1h
eWJlIGFuIGVhcmxpZXIgdmVyc2lvbgo+IHdhcykuCj4KPiA+IC0tLQo+ID4gIGFyY2gvcmlzY3Yv
cHVyZ2F0b3J5L01ha2VmaWxlIHwgNSArKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9wdXJnYXRvcnkvTWFrZWZp
bGUgYi9hcmNoL3Jpc2N2L3B1cmdhdG9yeS9NYWtlZmlsZQo+ID4gaW5kZXggNTczMDc5N2E2YjQw
Li5jZjNhNDQxMjFhOTAgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL3Jpc2N2L3B1cmdhdG9yeS9NYWtl
ZmlsZQo+ID4gKysrIGIvYXJjaC9yaXNjdi9wdXJnYXRvcnkvTWFrZWZpbGUKPiA+IEBAIC0zNSw2
ICszNSwxMSBAQCBDRkxBR1Nfc2hhMjU2Lm8gOj0gLURfX0RJU0FCTEVfRVhQT1JUUwo+ID4gIENG
TEFHU19zdHJpbmcubyA6PSAtRF9fRElTQUJMRV9FWFBPUlRTCj4gPiAgQ0ZMQUdTX2N0eXBlLm8g
Oj0gLURfX0RJU0FCTEVfRVhQT1JUUwo+ID4KPiA+ICsjIFdoZW4gcHJvZmlsZSBvcHRpbWl6YXRp
b24gaXMgZW5hYmxlZCwgbGx2bSBlbWl0cyB0d28gZGlmZmVyZW50IG92ZXJsYXBwaW5nCj4gPiAr
IyB0ZXh0IHNlY3Rpb25zLCB3aGljaCBpcyBub3Qgc3VwcG9ydGVkIGJ5IGtleGVjLiBSZW1vdmUg
cHJvZmlsZSBvcHRpbWl6YXRpb24KPiA+ICsjIGZsYWdzLgo+ID4gK0tCVUlMRF9DRkxBR1MgOj0g
JChmaWx0ZXItb3V0IC1mcHJvZmlsZS1zYW1wbGUtdXNlPSUgLWZwcm9maWxlLXVzZT0lLCQoS0JV
SUxEX0NGTEFHUykpCj4gPiArCj4gPiAgIyBXaGVuIGxpbmtpbmcgcHVyZ2F0b3J5LnJvIHdpdGgg
LXIgdW5yZXNvbHZlZCBzeW1ib2xzIGFyZSBub3QgY2hlY2tlZCwKPiA+ICAjIGFsc28gbGluayBh
IHB1cmdhdG9yeS5jaGsgYmluYXJ5IHdpdGhvdXQgLXIgdG8gY2hlY2sgZm9yIHVucmVzb2x2ZWQg
c3ltYm9scy4KPiA+ICBQVVJHQVRPUllfTERGTEFHUyA6PSAtZSBwdXJnYXRvcnlfc3RhcnQgLXog
bm9kZWZhdWx0bGliCj4gPgo+ID4gLS0KPiA+IDIuNDAuMS40OTUuZ2M4MTZlMDliNTNkLWdvb2cK
PiA+Cj4KPgo+IC0tCj4gVGhhbmtzLAo+IH5OaWNrIERlc2F1bG5pZXJzCgoKCi0tIApSaWNhcmRv
IFJpYmFsZGEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
