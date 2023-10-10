Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0F7CD98C1
	for <kexec@archiver.kernel.org>; Tue, 10 Oct 2023 20:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uRqgxshr6bQBgMP5pTePa5Ahs/+FQWw3IljzzxVtvio=; b=yYlKzL0dd8XGKh
	aihWTOsf0Xr82fH/8geUepTONgnToUnG/3U99hVuJ7EwO31EKJfuysKvWSwSsvF/7paWiVlMHcgOP
	tkTFMKFQgm/cxqFuz4us3U0W6gbjFHexywux+TfBz9ceRPhBJ7Dgb707iRR4t/ALvmlV5pCJufbgT
	gQVDsIIUv10LEaoQ1DvZXrqQKMKn9xeta5jo4eIf1HJprFwcM0Qzfr6D8TccihHMht0uEgwDONVy9
	Dv6CWC8Zx+kbcSPOnFAtaXOboQCAdAwO8dbqRGTTde22EICmvsmCeG4tD82YzyJ34Ns6zaYG/N1sp
	6djYlj8vre8usrgVUhrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqJa8-00E8iY-1t;
	Tue, 10 Oct 2023 20:43:56 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqJa5-00E8ha-0S
	for kexec@lists.infradead.org;
	Tue, 10 Oct 2023 20:43:55 +0000
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c2907ff9fcso75908641fa.1
        for <kexec@lists.infradead.org>; Tue, 10 Oct 2023 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696970628; x=1697575428; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81cjp26ZLCRfVdmuI0tOydwXQofr1yefS0BzwFdHnbc=;
        b=x5TXYxbmOImSM7sYmOEr2UQ99TQxT/QpsDktEAN6wlvfOQMWWFr+6dIUxuA/arYRkP
         MMlKTUZdE58QmvqMVfDlTF7txdfyLQA2TlPDmNTxqQ5eUMWxsNuCHKk9YMswsigrkbxB
         3AE8ZuFTU+U/JLnxY5eyJBQ0p6H8SXkBRLPPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970628; x=1697575428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81cjp26ZLCRfVdmuI0tOydwXQofr1yefS0BzwFdHnbc=;
        b=DmrAy5lq8wYZojTlihiiJ6+sbwhrsFh1KAmZAMPnGIuCE7CKo13GA9/MXy1UaQ/2xs
         L+mVTPwmRDarv2iKECBPpwOSfTulDG/L1qfcz05O/zkOyyj1Py2XYyfnsqAyNRGxScoX
         z+zzb/vy8sl1BcST+skUKsTORkEkmSaKYxHl0WkzJhuqU/Dv4HM0AKTj7B97qAPd+hBJ
         0/4VzbPjzggOviXoHLyMzXLRvZ2DJ599CBj08AmE9Rc+5jTu8N38qfTVdRfUsEvqOFBw
         5a9vvRqBzazOei4WblYtRcH41abyZ5+9XTgSaWgQDJ612oucnPDo1ck/XrUD0/4dovqr
         l47A==
X-Gm-Message-State: AOJu0Yyu+rQMTaN9mHWuCDfDK+F+uHNFc2arJLyNHTRLwEYBuaVHX/sT
	2GpEcPaFD2yU2FS4bp3cz9kdc7F0QI1Kg6KTkRzOMQ==
X-Google-Smtp-Source: AGHT+IFbF9MZZKolGHZgDB2/ps8Ewh63dhGzwhUtUzbFrQtTYTg7F/nmufWO2JTcxu1WgI2EKXLI67E6W2ZwWnGL2LE=
X-Received: by 2002:a2e:9d0e:0:b0:2c2:966f:8cc with SMTP id
 t14-20020a2e9d0e000000b002c2966f08ccmr13106920lji.0.1696970627979; Tue, 10
 Oct 2023 13:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230929021213.2364883-1-joel@joelfernandes.org>
 <87bkdl55qm.fsf@email.froward.int.ebiederm.org> <CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
 <CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com> <20231009100155.6d71490f@gandalf.local.home>
In-Reply-To: <20231009100155.6d71490f@gandalf.local.home>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 10 Oct 2023 16:43:37 -0400
Message-ID: <CAEXW_YQzf9=90Y4Q6RrVZHPkdAB+0ht94LdPMCozN4JBkjXacw@mail.gmail.com>
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	Ricardo Ribalda <ribalda@google.com>, Ross Zwisler <zwisler@google.com>, Rob Clark <robdclark@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_134353_182255_21D7B093 
X-CRM114-Status: GOOD (  13.31  )
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

T24gTW9uLCBPY3QgOSwgMjAyMyBhdCAxMDowMOKAr0FNIFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0
QGdvb2RtaXMub3JnPiB3cm90ZToKPgo+IE9uIFNhdCwgNyBPY3QgMjAyMyAyMTozMDo0MiAtMDQw
MAo+IEpvZWwgRmVybmFuZGVzIDxqb2VsQGpvZWxmZXJuYW5kZXMub3JnPiB3cm90ZToKPgo+ID4g
SnVzdCBjaGVja2luZyBob3cgd2Ugd2FudCB0byBwcm9jZWVkLCBpcyB0aGUgY29uc2Vuc3VzIHRo
YXQgd2Ugc2hvdWxkCj4gPiBwcmV2ZW50IGtlcm5lbCBjcmFzaGVzIHdpdGhvdXQgcmVseWluZyBv
biB1c2Vyc3BhY2Ugc3RvcHBpbmcgYWxsCj4gPiBwcm9jZXNzZXM/IFNob3VsZCB3ZSBmaXggcmVn
dWxhciByZWJvb3Qgc3lzY2FsbCBhcyB3ZWxsIGFuZCBub3QganVzdAo+ID4ga2V4ZWMgcmVib290
Pwo+Cj4gSWYgeW91IGNhbiBzaG93IHRoYXQgd2UgY2FuIHRyaWdnZXIgdGhlIGNyYXNoIG9uIG5v
cm1hbCByZWJvb3QsIHRoZW4gSQo+IGRvbid0IHNlZSB3aHkgbm90LiBUaGF0IGlzLCBpZiB5b3Ug
aGF2ZSBhIHByb2dyYW0gdGhhdCBkb2VzIHRoZSByZWJvb3QKPiAod2l0aG91dCB0aGUgU0lHU1RP
UC9TSUdLSUxMIGNhbGxzKSBhbmQgdHJpZ2dlcnMgdGhpcyBjcmFzaCwgSSB0aGluayB0aGF0J3MK
PiBhIGxlZ2l0aW1hdGUgcmVhc29uIHRvIGZpeCBpdCBvbiBub3JtYWwgcmVib290IHRvby4KCk9r
LCBTb3VuZHMgZ29vZCwgdGhhbmtzIGZvciBzaGFyaW5nIHlvdXIgdGhvdWdodHMuCgogLSBKb2Vs
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBt
YWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
