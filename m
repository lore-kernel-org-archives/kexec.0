Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F49EEB570
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 21:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OsJcmTu1D25Wi1dUACuceqEbcJgSt8mmqczOSNc6FEY=; b=xSLy9BcQItKaM0
	aY+XNCx/PL7aWhf5RXBiHWMAMoZ3k9OcQRW4ZRFMre00hBCzCAki5P0Zmr5rRnR0fAvJpdhzjGSYN
	2N9r/qTVcbq0pL9rMQKFSaaEdDneIkxUwdkxq6dAPBYru7iKZjrThOxoUE7c2vUjuIS+7+bW8xC4n
	PjJDV8gwH/XBZ1mFpwdk1j9w7zsQwHcKRfYlolTI+y+t+HuBSv44zw2VLOmVspaYIIoE7ldFo8aVA
	cAEUFUoD/mCD7WAYaDpT4X6rLoFTh6Z+ZeElObiZ4ZoSkNk6k9xYsdJeLg3ctMlOjqZjBZrIVKvb4
	SS/hBkyb7AfIgy+aABCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qejLP-00EYTl-1d;
	Fri, 08 Sep 2023 21:48:51 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qejLM-00EYSh-0B;
	Fri, 08 Sep 2023 21:48:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 15632CE1CAA;
	Fri,  8 Sep 2023 21:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA910C4339A;
	Fri,  8 Sep 2023 21:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694209723;
	bh=qBwdoqG1zVNvc3aShF3LCnCCMv6kyB9Wvl1DSPjBmKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LqG7JSNNHl+a3C2tdjmPUc9f+8/khnICP8q4+BvKP5FKdIDnR/LmnN52cpmtm4/En
	 c+mB3XAArArl1U0cANr+93qYmxPCfT+QgMTgj9crX+VOHaBTTmkMbj9ZDki6LYqlco
	 B1bgBOBB9sNIqUcU6fL3ksC8O/U6TH+70GIerdNCSOy7AS2A1d43bWdjXh3MUTdq+I
	 o62BFsJF4qePewmmtcAne07plHKcz//DOrSnDygR6Pexulzedzai//lVNheY+fRT5a
	 MFHocLxOf9a/PrIxIvvM/kVelIqEeSuteQLm+7+9VcHomVhSTofM4DFw95PniUISQm
	 GH8iwLG4xBdaQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-500a398cda5so4184024e87.0;
        Fri, 08 Sep 2023 14:48:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YwxnL1ck7gdcxf+3WhSkFmNPErAg2UEP0li20aNSgt33/Fl68MW
	FamI489ANMc49mSo+aM0mJ4FDrTjy1PJ1WDZEXM=
X-Google-Smtp-Source: AGHT+IHdt83V5zkWEI/zYp4eQdKOInBkQ/fcJo2LzCdTQtPBOg8u/Zxe/xPeFmYww3NGkOx3GITH5AX6OshJOu4NSCM=
X-Received: by 2002:a05:6512:3a87:b0:4fb:8bab:48b6 with SMTP id
 q7-20020a0565123a8700b004fb8bab48b6mr3731344lfu.52.1694209722018; Fri, 08 Sep
 2023 14:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v7-0-b05c520b7296@chromium.org>
 <CAPhsuW5_qAvV0N3o+hOiAnb1=buJ1pLzqYW9D+Bwft6hxJvAeQ@mail.gmail.com> <CANiDSCu2YLaXv2DkfzN0GbTF1b79HnqPG=GWqodDr4X9krGjUA@mail.gmail.com>
In-Reply-To: <CANiDSCu2YLaXv2DkfzN0GbTF1b79HnqPG=GWqodDr4X9krGjUA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 8 Sep 2023 14:48:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5JDPk7ZEthu7cowqp6emQOXsWgSvPM+kvnERPq4RR83w@mail.gmail.com>
Message-ID: <CAPhsuW5JDPk7ZEthu7cowqp6emQOXsWgSvPM+kvnERPq4RR83w@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] kexec: Fix kexec_file_load for llvm16 with PGO
To: Ricardo Ribalda <ribalda@chromium.org>
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
	Simon Horman <horms@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	stable@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_144848_467040_D42ECED4 
X-CRM114-Status: GOOD (  29.31  )
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

SGkgUmljYXJkbywKClRoYW5rcyBmb3IgeW91ciBraW5kIHJlcGx5LgoKT24gRnJpLCBTZXAgOCwg
MjAyMyBhdCAyOjE44oCvUE0gUmljYXJkbyBSaWJhbGRhIDxyaWJhbGRhQGNocm9taXVtLm9yZz4g
d3JvdGU6Cj4KPiBIaSBTb25nCj4KPiBPbiBGcmksIDggU2VwdCAyMDIzIGF0IDAxOjA4LCBTb25n
IExpdSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToKPiA+Cj4gPiBIaSBSaWNhcmRvIGFuZCBmb2xr
cywKPiA+Cj4gPiBPbiBGcmksIE1heSAxOSwgMjAyMyBhdCA3OjQ44oCvQU0gUmljYXJkbyBSaWJh
bGRhIDxyaWJhbGRhQGNocm9taXVtLm9yZz4gd3JvdGU6Cj4gPiA+Cj4gPiA+IFdoZW4gdXByZXZp
bmcgbGx2bSBJIHJlYWxpc2VkIHRoYXQga2V4ZWMgc3RvcHBlZCB3b3JraW5nIG9uIG15IHRlc3QK
PiA+ID4gcGxhdGZvcm0uCj4gPiA+Cj4gPiA+IFRoZSByZWFzb24gc2VlbXMgdG8gYmUgdGhhdCBk
dWUgdG8gUEdPIHRoZXJlIGFyZSBtdWx0aXBsZSAudGV4dCBzZWN0aW9ucwo+ID4gPiBvbiB0aGUg
cHVyZ2F0b3J5LCBhbmQga2V4ZWMgZG9lcyBub3Qgc3VwcG9ydHMgdGhhdC4KPiA+ID4KPiA+ID4g
U2lnbmVkLW9mZi1ieTogUmljYXJkbyBSaWJhbGRhIDxyaWJhbGRhQGNocm9taXVtLm9yZz4KPiA+
Cj4gPiBXZSBhcmUgc2VlaW5nIFdBUk5JTkdzIGxpa2UgdGhlIGZvbGxvd2luZyB3aGlsZSBrZXhl
YydpbmcgYSBQR08gYW5kCj4gPiBMVE8gZW5hYmxlZCBrZXJuZWw6Cj4gPgo+ID4gV0FSTklORzog
Q1BVOiAyNiBQSUQ6IDExMDg5NCBhdCBrZXJuZWwva2V4ZWNfZmlsZS5jOjkxOQo+ID4ga2V4ZWNf
bG9hZF9wdXJnYXRvcnkrMHgzN2YvMHgzOTAKPiA+Cj4gPiBBRkFJQ1QsIHRoZSB3YXJuaW5nIHdh
cyBhZGRlZCBieSB0aGlzIHNldCwgYW5kIGl0IHdhcyB0cmlnZ2VyZWQgd2hlbgo+ID4gd2UgaGF2
ZSBtYW55IC50ZXh0IHNlY3Rpb25zCj4gPiBpbiBwdXJnYXRvcnkucm8uIFRoZSBrZXhlYyB3YXMg
YWN0dWFsbHkgc3VjY2Vzc2Z1bC4gU28gSSB3b25kZXIKPiA+IHdoZXRoZXIgd2UgcmVhbGx5IG5l
ZWQgdGhlCj4gPiBXQVJOSU5HIGhlcmUuIElmIHdlIGRpc2FibGUgTFRPIChQR08gaXMgc3RpbGwg
ZW5hYmxlZCksIHdlIGRvbid0IHNlZQo+ID4gdGhlIFdBUk5JTkcgYW55IG1vcmUuCj4gPgo+ID4g
SSBhbHNvIHRlc3RlZCBhbiBvbGRlciBrZXJuZWwgKDUuMTkgYmFzZWQpLCB3aGVyZSB3ZSBhbHNv
IHNlZSBtYW55Cj4gPiAudGV4dCBzZWN0aW9ucyB3aXRoIExUTy4gSXQKPiA+IGtleGVjKCknZWQg
ZmluZS4gKEl0IGRvZXNuJ3QgaGF2ZSB0aGUgV0FSTl9PTigpIGluCj4gPiBrZXhlY19wdXJnYXRv
cnlfc2V0dXBfc2VjaGRycykuCj4KPiBZb3UgaGF2ZSBiZWVuICJsdWNreSIgdGhhdCB0aGUgY29k
ZSBoYXMgY2hvc2VuIHRoZSBjb3JyZWN0IHN0YXJ0Cj4gYWRkcmVzcywgeW91IG5lZWQgdG8gbW9k
aWZ5IHRoZSBsaW5rZXIgc2NyaXB0IG9mIHlvdXIga2VybmVsIHRvCj4gZGlzYWJsZSBQR08uCj4g
WW91IG5lZWQgdG8gYmFja3BvcnQgYSBwYXRjaCBsaWtlIHRoaXM6Cj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC9DQVBoc3VXNV9xQXZWME4zbytoT2lBbmIxPWJ1SjFwTHpxWVc5RCtCd2Z0
Nmh4SnZBZVFAbWFpbC5nbWFpbC5jb20vVC8jbWQ2OGI3ZjgzMjIxNmIwYzU2YmJlYzBjOWIwNzMz
MmUxODBiOWJhMmIKCldlIGFscmVhZHkgaGF2ZSB0aGlzIGNvbW1pdCBpbiBvdXIgYnJhbmNoLiBB
RkFJQ1QsIHRoZSBpc3N1ZSB3YXMKdHJpZ2dlcmVkIGJ5IExUTy4gU28gc29tZXRoaW5nIGxpa2Ug
dGhlIGZvbGxvd2luZyBzZWVtcyBmaXhlcyBpdAooSSBoYXZlbid0IGZpbmlzaGVkIHRoZSBlbmQt
dG8tZW5kIHRlc3QgeWV0KS4gRG9lcyB0aGlzIGNoYW5nZSBtYWtlCnNlbnNlIHRvIHlvdT8KClRo
YW5rcyBhZ2FpbiwKU29uZwoKZGlmZiAtLWdpdCBpL2FyY2gveDg2L3B1cmdhdG9yeS9NYWtlZmls
ZSB3L2FyY2gveDg2L3B1cmdhdG9yeS9NYWtlZmlsZQppbmRleCA4ZjcxYWFhMDRjYzIuLmRjMzA2
ZmE3MTk3ZCAxMDA2NDQKLS0tIGkvYXJjaC94ODYvcHVyZ2F0b3J5L01ha2VmaWxlCisrKyB3L2Fy
Y2gveDg2L3B1cmdhdG9yeS9NYWtlZmlsZQpAQCAtMTksNiArMTksMTAgQEAgQ0ZMQUdTX3NoYTI1
Ni5vIDo9IC1EX19ESVNBQkxFX0VYUE9SVFMKICMgb3B0aW1pemF0aW9uIGZsYWdzLgogS0JVSUxE
X0NGTEFHUyA6PSAkKGZpbHRlci1vdXQgLWZwcm9maWxlLXNhbXBsZS11c2U9JQotZnByb2ZpbGUt
dXNlPSUsJChLQlVJTERfQ0ZMQUdTKSkKCisjIFdoZW4gTFRPIGlzIGVuYWJsZWQsIGxsdm0gZW1p
dHMgbWFueSB0ZXh0IHNlY3Rpb25zLCB3aGljaCBpcyBub3Qgc3VwcG9ydGVkCisjIGJ5IGtleGVj
LiBSZW1vdmUgLWZsdG89KiBmbGFncy4KK0tCVUlMRF9DRkxBR1MgOj0gJChmaWx0ZXItb3V0IC1m
bHRvPSUsJChLQlVJTERfQ0ZMQUdTKSkKKwogIyBXaGVuIGxpbmtpbmcgcHVyZ2F0b3J5LnJvIHdp
dGggLXIgdW5yZXNvbHZlZCBzeW1ib2xzIGFyZSBub3QgY2hlY2tlZCwKICMgYWxzbyBsaW5rIGEg
cHVyZ2F0b3J5LmNoayBiaW5hcnkgd2l0aG91dCAtciB0byBjaGVjayBmb3IgdW5yZXNvbHZlZCBz
eW1ib2xzLgogUFVSR0FUT1JZX0xERkxBR1MgOj0gLWUgcHVyZ2F0b3J5X3N0YXJ0IC16IG5vZGVm
YXVsdGxpYgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
