Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5454CCA48B
	for <kexec@archiver.kernel.org>; Mon, 25 Jul 2022 13:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yqcsEZVqGT4/Sw0XGW55Pc4K5iPQN28345j9NBfq6Xs=; b=k6hpcDNGsJLFZj
	iOgs+bNra36Th6MEYZTdICCcUkfuFcJ3EVIdCywyH4oEvF/9+UYz0U2ZEAnastpHqvlzjCDq8kB8B
	ER3WLamX34q6oRBxpHFv+8djDqvqIQf8tkbquoiCtLW4XSK34kBB4VF7Boy6I5JJ72RXJD8Q+mK9t
	eTdGb42RG6Cm8PaYNUsXjiROrYz2/6lj3SwMHRhghBhkdd5G2//DILjs0/RZQUt82sYWA1/JsQLXl
	ABjxM2AZzkrjEFTT0XujKM+XBT8KNNy32LrDwRlxl/pqAwTXJmbodgBc0jhw6HiXLenfnRiea5q57
	1hpN1zHu9dejFv0cZXng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFyCx-00A2Po-8n; Mon, 25 Jul 2022 13:33:15 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFyCv-00A2Nz-5h
	for kexec@lists.infradead.org; Mon, 25 Jul 2022 13:33:14 +0000
Received: by mail-io1-xd35.google.com with SMTP id p81so8770253iod.2
        for <kexec@lists.infradead.org>; Mon, 25 Jul 2022 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UI2/nxfk1QNcmFQVdYqpL42RDFh7hqRmtHgOiz0UFAE=;
        b=pKE5ac071R6Pb3RRecZCZJIoq81DrpZBqMcjudyYrNlHT+FblM7h1cLSJhjMU04hOC
         4/KSTkTwMdb6u4Vl0kYNayVP6351sf8pHJfF0BK6xYWcoFNHKe0VvjiuimjrGPQKyLbi
         eTh9XY6XGpZW+JPB88tsV3Mkl7EER7lAp/WC7fnq77elUyERjeeQsBPs/bOJRapjZd4P
         uud2yhv+lZu+4zSGaQbtbWTr0FrgWlG1FDRde0zVuGd9lNc45+3WM2Pz9uGGck8GxZQ1
         fMpK6ySfy4CuKwp3/DvvptSXLKpX/oEj8fBvJQnvXA1b5s6wN+88QFfPeX2um/xZthHL
         on9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UI2/nxfk1QNcmFQVdYqpL42RDFh7hqRmtHgOiz0UFAE=;
        b=agwGeYd6+5O68TMqlC5HqNULLVsSWUpTdru0P6WJjYcFZqlWdqlLR3ASGkXXMu6V83
         bhwFKPcEJ2KuErzGuJURBr0SMyoObKdoqsnc3KgHRe1zaS0UKLx+VoahLX2j9sDOAKUQ
         LDuIKyn7mm3j255tL1JGQqa2ZtLNdGwsuFhkEctczzS4QvdvnIbqnsLrxpRCR32345L7
         C3xoPS1QV9GtaMWwuZuXJ93h7CfWU6eMqv/yVpAnX6W8ydG+OSDa2g3P55dLc2euXCeY
         4qbEPS6Eh21TQ9QUmqiLdy8C674VZHvMGo8b4St2wHw1W6Ho3CXANABPB3rr/MBBaYMI
         oh6g==
X-Gm-Message-State: AJIora/Gs6MQof2Ken/I/053O+XB86T5hhFzMZm+gVt7uglBktcGSRV+
	PVZ4mI9G8QeJfz65pZHo0u359QGcLM4uU8IKQLevaQ==
X-Google-Smtp-Source: AGRyM1s94qNICw9Lb3JDMcSff9B114i33VAnDqLIK5x0bwim9blfoCpQDQF+4jdp/Xo+2lXAFvHnOUTKg6ry3bzveVk=
X-Received: by 2002:a02:c722:0:b0:33f:393d:d198 with SMTP id
 h2-20020a02c722000000b0033f393dd198mr5025831jao.22.1658755990616; Mon, 25 Jul
 2022 06:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
 <20220725083904.56552-3-huangjie.albert@bytedance.com> <Yt6JRBToqY5ts6OU@zx2c4.com>
In-Reply-To: <Yt6JRBToqY5ts6OU@zx2c4.com>
From: =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date: Mon, 25 Jul 2022 21:32:59 +0800
Message-ID: <CABKxMyOcePkvAvMyrG2r08yRuxx=gK2SnMBFbKzKW6hBAdmRFw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/4] kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, 
	Nick Desaulniers <ndesaulniers@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Nathan Chancellor <nathan@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Joerg Roedel <jroedel@suse.de>, Mark Rutland <mark.rutland@arm.com>, 
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kbuild@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_063313_262300_C6F3B763 
X-CRM114-Status: GOOD (  19.30  )
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

bWF5YmUgYSBib290IHBhcmFtZXRlciA/CgpKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0
LmNvbT4g5LqOMjAyMuW5tDfmnIgyNeaXpeWRqOS4gCAyMDoxNeWGmemBk++8mgo+Cj4gSGkgQWxi
ZXJ0LAo+Cj4gT24gTW9uLCBKdWwgMjUsIDIwMjIgYXQgMDQ6Mzg6NTRQTSArMDgwMCwgQWxiZXJ0
IEh1YW5nIHdyb3RlOgo+ID4gK2NvbmZpZyBLRVhFQ19QVVJHQVRPUllfU0tJUF9TSUcKPiA+ICsg
ICAgIGJvb2wgInNraXAga2V4ZWMgcHVyZ2F0b3J5IHNpZ25hdHVyZSB2ZXJpZmljYXRpb24iCj4g
PiArICAgICBkZXBlbmRzIG9uIEFSQ0hfSEFTX0tFWEVDX1BVUkdBVE9SWQo+ID4gKyAgICAgaGVs
cAo+ID4gKyAgICAgICB0aGlzIG9wdGlvbnMgbWFrZXMgdGhlIGtleGVjIHB1cmdhdG9yeSBkbyAg
bm90IHNpZ25hdHVyZSB2ZXJpZmljYXRpb24KPiA+ICsgICAgICAgd2hpY2ggd291bGQgZ2V0IGh1
bmRyZWRzIG9mIG1pbGxpc2Vjb25kcyBzYXZlZCBkdXJpbmcga2V4ZWMgYm9vdC4gSWYgd2UgY2Fu
Cj4gPiArICAgICAgIGNvbmZpcm0gdGhhdCB0aGUgZGF0YSBvZiBlYWNoIHNlZ21lbnQgbG9hZGVk
IGJ5IGtleGVjIHdpbGwgbm90IGNoYW5nZSB3ZSBtYXkKPiA+ICsgICAgICAgZW5hYmxlIHRoaXMg
b3B0aW9uCj4gPiArCj4KPiBTb21lIGdyYW1tYXIgbml0cyBoZXJlLCBidXQgYWN0dWFsbHksIHdv
dWxkbid0IGl0IGJlIGJldHRlciB0byBtYWtlIHRoaXMKPiBkZXBlbmQgb24gc29tZSBvdGhlciBz
aWduYXR1cmUgdGhpbmdzIGluc3RlYWQ/IExpa2UgaWYgdGhlIHBhcmVudCBrZXJuZWwKPiBhY3R1
YWxseSBkaWQgYSBiaWcgc2lnbmF0dXJlIGNvbXB1dGF0aW9uLCB0aGVuIG1heWJlIHRoZSBwdXJn
YXRvcnkgc3RlcAo+IGlzIG5lZWRlZCwgYnV0IGlmIGl0IGRpZG4ndCBib3RoZXIsIHRoZW4gbWF5
YmUgeW91IGNhbiBza2lwIGl0LiBUaGlzCj4gd2F5LCB5b3UgZG9uJ3QgbmVlZCBhIGNvbXBpbGUt
dGltZSBvcHRpb24gdGhhdCBtaWdodCBjaGFuZ2Ugc29tZSBhc3BlY3QKPiBvZiBzaWduYXR1cmUg
dmVyaWZpY2F0aW9uIHBlb3BsZSBtaWdodCBvdGhlcndpc2UgYmUgcmVseWluZyBvbi4KPgo+IEph
c29uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
