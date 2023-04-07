Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C11DC77B6C
	for <kexec@archiver.kernel.org>; Fri,  7 Apr 2023 23:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bnGsbHVxwv7kZAi8JAlen9EpQHhdkWOdNcrozNLUyH8=; b=cFIltZA0UTOjVs
	TaVvqnW1y1i+6afIKqLCF5w11Sq9MPMxeer6c+EOkfi7kJyzKxQZIEVpyfw2jqHZPuD+Mnnw+5aE2
	e1n7ZFP1Sp7I20j2JzSDBhkzm5CoIO2WKiQt9QDhZAdtzqiD1qVqykiLdYe23WfJyWUU2Wzm/KCRo
	b5t21br+Gi0fGUrpjHo/D0UKr6PK3l3WJQKQMTaB2Lk6/NTt9NEzIA0OdVD45sCjwfQTAA9NY/og4
	NdZirXkh8ntCupgdfGb+4JmvEdubldODCW3W+jWP8vPjTu/N8A3vZmjn6RmYF+xrff8qiZ01CY3v/
	WRgHpQ6Oayd0+9XKuphw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkvPw-00BOTs-1G;
	Fri, 07 Apr 2023 23:22:52 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkvPt-00BOSu-1X
	for kexec@lists.infradead.org;
	Fri, 07 Apr 2023 23:22:51 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63260c5bb69so17169b3a.3
        for <kexec@lists.infradead.org>; Fri, 07 Apr 2023 16:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680909767; x=1683501767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njPybTaOp1vfFxl9sNrZg/wsVvOfoZpdPujnFpOpMQA=;
        b=Vt5cGuMIp/txoyJYLtEZ9dC+RpJrsinP5mQDIKekwD6nvyST7tXyhGxLGL3Z/M4BHL
         YFf8GiX9Fh4tjiQtNiW6yw9042t0+qbszTDR7yNaw1In2q93zzBUeag2fN++T7f+2SSO
         mYiSVqW3ikHB9B21Lqi8J8xL7fext5RlMpNhrFwdmnzrn/Bg3Vk8cSLVkFC/HZw24r+S
         +Kujk+EHG8CGkKC5eNtr/tRJybBPG+Q4wOvR2BLQmEOYTaTos8m/pQs78tPFU4aKWSaB
         e9oGkOODEFlAIv7rPaMXnrblaHO5Qm6fS70uBtRfFtfbmnE5Wyk0GaGO95IRt8LeppyG
         mLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680909767; x=1683501767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njPybTaOp1vfFxl9sNrZg/wsVvOfoZpdPujnFpOpMQA=;
        b=ivf51NWJbVK4wVH/YUMgxyr97Ke8rtmwn6ztjIJfiXJHcyJHvcCi0e03MlM0QITMIU
         +5vYcWAt4tu1ZSbzbeHyPcpArzuSx8HSZcYIS0ADGR17v3TSUc62aVJGejZ3W/PlKqtd
         S1QG3ee7UFE4tFXmha68lOy0kcRFdb3VYseYnie0y5vhcfQ6TjC3C0QNkWhplLQuuuCG
         slvzGq9tmGZRGM7VODO6hcenLte/H2/Oa0tACsBO3e9WPHaIpvFrfGnSNo4AUIzVcd53
         VzMFvks5NQqjqLJmiaWAiBsb+t6VgWts2lHgIQ8uEwymxfCkHucdma+rrTeW2r1JnvCQ
         PXow==
X-Gm-Message-State: AAQBX9e4PUf/J7vQ6ERB1J/37eC51z4E1n3Q2AS7rIka/hHV+cGGN4yo
	19WQEugKgjAa3ZphUucGVhyIkSrRM10e25Q7S4P6jg==
X-Google-Smtp-Source: AKy350bTVYi1UIgGoXP+cqF81jwaO+c2w357t2GB7id9Pg6AAkRKqAVvHygDDMoVBsekCEUGRFhlgAYliVFtq4CaHB0=
X-Received: by 2002:a05:6a00:2e28:b0:625:c55f:bc66 with SMTP id
 fc40-20020a056a002e2800b00625c55fbc66mr1911037pfb.4.1680909767332; Fri, 07
 Apr 2023 16:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
 <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org> <20230330111523.4b98c8ce@gandalf.local.home>
 <20230330151826.GDZCWoQkQBj4BYbwWw@fat_crate.local> <20230330113127.3011e021@gandalf.local.home>
 <20230330160017.GEZCWyEXQVQZRBbYif@fat_crate.local>
In-Reply-To: <20230330160017.GEZCWyEXQVQZRBbYif@fat_crate.local>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 7 Apr 2023 16:22:36 -0700
Message-ID: <CAKwvOdkULKxoifiVO4H4yomt1DHQxw0ntdO6QgMXk2BpM-urRg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] x86/purgatory: Add linker script
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Eric Biederman <ebiederm@xmission.com>, 
	Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>, 
	Simon Horman <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>, linux-toolchains@vger.kernel.org, 
	clang-built-linux <llvm@lists.linux.dev>, Borislav Petkov <bp@alien8.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_162249_515277_022E2907 
X-CRM114-Status: GOOD (  19.47  )
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

SGkgUmljYXJkbywKVGhhbmtzIGZvciB0aGUgcGF0Y2ghICBQbGVhc2UgbWFrZSBzdXJlIHRvIGNj
IG91ciBtYWlsaW5nIGxpc3QKPGxsdm1AbGlzdHMubGludXguZGV2PiBmb3IgbGx2bSBzcGVjaWZp
YyBpc3N1ZXMuCnNjcmlwdHMvZ2V0X21haW50YWluZXIucGwgc2hvdWxkIHJlY29tbWVuZCBpdCwg
b3IgeW91IGNhbiBmaW5kIGl0IGZyb20KY2xhbmdidWlsdGxpbnV4LmdpdGh1Yi5pby4gIFlvdSBj
YW4gYWxzbyBwaW5nIG1lIGludGVybmFsbHkgZm9yCnRvb2xjaGFpbiByZWxhdGVkIGlzc3Vlcy4K
ClN0YXJ0IG9mIHRocmVhZC4KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDMyMS1r
ZXhlY19jbGFuZzE2LXY1LTAtNTU2M2JmN2M0MTczQGNocm9taXVtLm9yZy8KCk9uIFRodSwgTWFy
IDMwLCAyMDIzIGF0IDk6MDDigK9BTSBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4gd3Jv
dGU6Cj4KPiBPbiBUaHUsIE1hciAzMCwgMjAyMyBhdCAxMTozMToyN0FNIC0wNDAwLCBTdGV2ZW4g
Um9zdGVkdCB3cm90ZToKPiA+IE9uIFRodSwgMzAgTWFyIDIwMjMgMTc6MTg6MjYgKzAyMDAKPiA+
IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPiB3cm90ZToKPiA+Cj4gPiA+IE9uIFRodSwg
TWFyIDMwLCAyMDIzIGF0IDExOjE1OjIzQU0gLTA0MDAsIFN0ZXZlbiBSb3N0ZWR0IHdyb3RlOgo+
ID4gPiA+ID4gTWFrZSBzdXJlIHRoYXQgdGhlIC50ZXh0IHNlY3Rpb24gaXMgbm90IGRpdmlkZWQg
aW4gbXVsdGlwbGUgb3ZlcmxhcHBpbmcKPiA+ID4gPiA+IHNlY3Rpb25zLiBUaGlzIGlzIG5vdCBz
dXBwb3J0ZWQgYnkga2V4ZWNfZmlsZS4KClBlcmhhcHMgdGhpcyBpcyByZWxhdGVkIHRvIENyT1Mn
IHVzZSBvZiBBdXRvRkRPIGNyZWF0aW5nIC50ZXh0LmhvdD8KSWYgc28sIGl0J3MgcHJvYmFibHkg
bW9yZSBzdHJhaWdodGZvcndhcmQgdG8gc3RyYWlnaHQgdXAgZGlzYWJsZSBQR08KZm9yIGtleGVj
LiBTZWUgYWxzbzoKCmNvbW1pdCBiZGU5NzFhODNiYmYgKCJLVk06IGFybTY0OiBudmhlOiBGaXgg
YnVpbGQgd2l0aCBwcm9maWxlIG9wdGltaXphdGlvbiIpCgo+ID4gPgo+ID4gPiBBbmQ/Cj4gPiA+
Cj4gPiA+IFdoYXQgaXMgdGhlIGZhaWx1cmUgc2NlbmFyaW8/IFdoeSBhcmUgeW91IGZpeGluZyBp
dD8gV2h5IGRvIHdlIGNhcmU/Cj4gPiA+Cj4gPiA+IFRoaXMgaXMgd2F5IHRvbyBsYWNvbmljLgo+
ID4gPgo+ID4KPiA+IFllYWgsIEkgdGhpbmsgdGhlIGNoYW5nZSBsb2cgaW4gcGF0Y2ggMSBuZWVk
cyB0byBiZSBpbiB0aGlzIHBhdGNoIHRvbywKPiA+IHdoaWNoIGdpdmVzIGJldHRlciBjb250ZXh0
Lgo+Cj4gSnVzdCByZWFkIGl0Lgo+Cj4gV2h5IGRpZCBpdCB3b3JrIHdpdGggY2xhbmcgdmVyc2lv
biA8IDE2PwoKSSdsbCBiZXQgaWYgd2UgYmlzZWN0IGxsdm0sIHdlIGNhbiBzcG90IHdoYXQgbWln
aHQgaGF2ZSBjaGFuZ2VkLCB3aGljaAptYXkgZ2l2ZSB1cyBhIGNsdWUgb24gaG93IHRvIGdldCB0
aGUgb2xkIGJlaGF2aW9yIGJhY2s7IG1heWJlIHdpdGhvdXQKdGhlIG5lZWQgZm9yIGEgbGlua2Vy
IHNjcmlwdC4KClJpY2FyZG8sIGhvdyBkaWQgeW91IHZlcmlmeSB0aGF0IHlvdXIgZml4IHdhcyBj
b3JyZWN0PyBTdXJlbHkgd2UgY2FuCmNoZWNrIHVzaW5nIGNvbW1hbmQgbGluZSB1dGlsaXRpZXMg
d2l0aG91dCBuZWVkaW5nIGEgZnVsbCBibG93biBrZXhlYwpzZXR1cD8gSWYgeW91IGNhbiBzaGFy
ZSBtb3JlIGluZm8sIEkgY2FuIGJpc2VjdCBsbHZtIHF1aWNrbHkuICBJZiBpdApyZXF1aXJlcyBw
cm9maWxlIGRhdGEsIHlvdSdsbCBuZWVkIHRvIHNoYXJlIGl0LCBzaW5jZSBDck9TIGVuZ2luZWVy
cwpzdGlsbCBoYXZlIG5vdCBwb3N0ZWQgcHVibGljIGRvY3VtZW50YXRpb24gb24gQXV0b0ZETyBh
cyBJIGhhdmUKcmVwZWF0ZWRseSBhc2tlZCBmb3IuCgo+Cj4gKyB0b29sY2hhaW5zIE1MLgo+Cj4g
LS0KPiBSZWdhcmRzL0dydXNzLAo+ICAgICBCb3Jpcy4KPgo+IGh0dHBzOi8vcGVvcGxlLmtlcm5l
bC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlCgoKCi0tIApUaGFua3MsCn5OaWNrIERl
c2F1bG5pZXJzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
