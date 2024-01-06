Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD515C46CD2
	for <kexec@archiver.kernel.org>; Sat,  6 Jan 2024 23:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mAnYt+9Ve1Dq8JQHYkcXPu2zjX7mey9Hw857Nh4Wmkc=; b=Fi1+LMSrWATF8g
	0tJVKR2Rx9nk66qSNPRO7iKj4bg1xoy4KyXRMwzhqWDOeKlYUCRh6IcZj0svgpYgJHCBcvV1Heb1d
	9w6VyzaReH0AS9mRvdDSFiyG35wN6xIlvAOzVeaJQpJr2JEQ38xdy80ryVoh7ckEynKa3UNkPTQ+X
	ahcTaiNfYHthTndcs8pLU3IrfUlh+VFsywGHOEDSNAvK1Mje/ZBg3XDCr5S2fQv/Of0PYAL4jn14m
	N9GHctGx53uc9RKK0LfrPkOvHWLO7eUby3HQPb3uhs3ZF5NEp7MlAq3oyp/GBqXf4qMmdt5QtiQL+
	KVPC+3od4XM3eeVD4yKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMGLe-0023NK-1t;
	Sat, 06 Jan 2024 23:45:02 +0000
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMGLb-0023LS-02
	for kexec@lists.infradead.org;
	Sat, 06 Jan 2024 23:45:01 +0000
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-78313f4d149so76035685a.1
        for <kexec@lists.infradead.org>; Sat, 06 Jan 2024 15:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704584697; x=1705189497; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDbVoT7OoEiFM460KfCQ5FF8c6kjcJrMKDjqfMX1Qnc=;
        b=gLD+hFScvQ37FwchowWjdjcdYzJrGBW5KN6zY4GJabnjE9N3sbmiPJMJ5lcuc6VFm7
         GwemP9gsGCi2DQyM1hpDU+bDEna3+EHnSFcTMp1IBnyVUjqt+47RtxdlO7Loi4ot5JOS
         IkXLSY9KrLKdF6nuSeresMuay9EkkPXeg5bQ1UemHBjoeBiB8RTb4NNLYY+KC6ovaJ3Z
         splrrph51oBRKBSBluinRy9J49WyHJU9ekx+n4e2CrLRgyEQPCTnEMpaX6eKY22uWjen
         vT9R9y2Z7xW+ES6LbqjFEo5HXo6fDbU2OvEvZ8WxgaKMdAi1ytRiq49dGmWMe7RuPOGg
         aRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704584697; x=1705189497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDbVoT7OoEiFM460KfCQ5FF8c6kjcJrMKDjqfMX1Qnc=;
        b=rHZPTMmbx2pIUrsD6XVQRjFbDmzMbwBjCQw5ViSHqOwrG70vEu2UqFT/jdymLyYP6A
         42hsFwO6c+ijjCyCsEb1iMhmlpDzQmsljCGyS/nlQFb4IZTJzBppJcZ48U/LCGrF6YbK
         1GCoSa4lbGOT4gmJfftrRhrOoeu9h4IP0WVv3dF5/7Fc6SWYRQR73Aoto0hnUQL7rPtU
         B5t0qUgPQNEV1NfF1uIR9TlXObELQI0ZCUOMZZ3cp2tPxczqrSwL/ug/Q2Z77tvZSPRt
         8KrtmEH97KXwgcgGZRBUlH36L8FcIbNmNW0w71BDIpFNiRnorS91lDdph3d6SvkM+D26
         omig==
X-Gm-Message-State: AOJu0YybXWulC/NhGFfpzADu7YQV2MV9ramftp4U4Cp+qyGZ+8l9vYzO
	APMB9dXBzWRkU0pTZC5O4b5G8zU1r/YgBDUkvjeOfVPLMoUm
X-Google-Smtp-Source: AGHT+IEcPlkIt3uM5ECdHrGpN4ABuoY7X6eqs/p1NmkUnHpr3j0qgfOOV86sMtzHdJDQci/0ojkKljVBVspmg+nGsUo=
X-Received: by 2002:a05:620a:2a11:b0:783:148d:33ca with SMTP id
 o17-20020a05620a2a1100b00783148d33camr1931706qkp.128.1704584697399; Sat, 06
 Jan 2024 15:44:57 -0800 (PST)
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
 <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com> <1c370ecf-272a-4052-8f06-4fcfd9bf08b5@linux.ibm.com>
In-Reply-To: <1c370ecf-272a-4052-8f06-4fcfd9bf08b5@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 6 Jan 2024 18:44:45 -0500
Message-ID: <CAHC9VhR9kjn6=MxgcEFx1M0Hz=4pGXWLrUcPx++TLvngih4KPw@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Ken Goldman <kgold@linux.ibm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, 
	linux-integrity@vger.kernel.org, peterhuewe@gmx.de, 
	Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, bhe@redhat.com, vgoyal@redhat.com, 
	Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org, 
	serge@hallyn.com, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, 
	Tyler Hicks <tyhicks@linux.microsoft.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Sush Shringarputale <sushring@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240106_154459_440488_38DB506C 
X-CRM114-Status: GOOD (  20.70  )
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

T24gV2VkLCBEZWMgMjAsIDIwMjMgYXQgNToxNOKAr1BNIEtlbiBHb2xkbWFuIDxrZ29sZEBsaW51
eC5pYm0uY29tPiB3cm90ZToKPgo+IEknbSBzdGlsbCBzdHJ1Z2dsaW5nIHdpdGggdGhlICJuZXcg
cm9vdCBvZiB0cnVzdCIgY29uY2VwdC4KPgo+IFNvbWV0aGluZyAtIGEgdXNlciBzcGFjZSBhZ2Vu
dCwgYSB0aGlyZCBwYXJ0eSwgZXRjLiAtIGhhcyB0bwo+IHJldGFpbiB0aGUgZW50aXJlIGxvZyBm
cm9tIGV2ZW50IDAsIGJlY2F1c2UgYSBuZXcgdmVyaWZpZXIKPiBuZWVkcyBhbGwgbWVhc3VyZW1l
bnRzLgoKW05PVEU6IGEgZ2VudGxlIHJlbWluZGVyIHRvIHBsZWFzZSByZWZyYWluIGZyb20gdG9w
LXBvc3Rpbmcgb24gTGludXgKa2VybmVsIG1haWxpbmcgbGlzdHMsIGl0IGlzIGdlbmVyYWxseSBm
cm93bmVkIHVwb24gYW5kIG1ha2VzIGl0CmRpZmZpY3VsdCB0byBtYW5hZ2UgbG9uZyBydW5uaW5n
IHRocmVhZHNdCgpUaGlzIGlzIG9uZSBvZiB0aGUgcmVhc29ucyBJIGhhdmUgcHVzaGVkIHRvIG1h
bmFnZSB0aGUgc25hcHNob3QsIGJvdGgKdGhlIHRyaWdnZXIgYW5kIHRoZSBoYW5kbGluZyBvZiB0
aGUgdHJpbW1lZCBkYXRhLCBvdXRzaWRlIG9mIHRoZQprZXJuZWwuICBTZXR0aW5nIGFzaWRlIHRo
ZSBvYnZpb3VzIGxpbWl0YXRpb25zIG9mIGtlcm5lbCBJL08sIGhhbmRsaW5nCnRoZSBzbmFwc2hv
dCBpbiB1c2Vyc3BhY2UgcHJvdmlkZXMgZm9yIGEgbXVjaCByaWNoZXIgc2V0IG9mIG9wdGlvbnMK
d2hlbiBpdCBjb21lcyB0byBtYW5hZ2luZyB0aGUgc25hcHNob3QgYW5kIHRoZQp2ZXJpZmljYXRp
b24vYXR0ZXN0YXRpb24gb2YgdGhlIHN5c3RlbS4KCj4gVGhlcmVmb3JlLCB0aGUgc25hcHNob3Qg
YWdncmVnYXRlIHNlZW1zIHJlZHVuZGFudC4gIEl0IGhhcyB0bwo+IGJlIHZlcmlmaWVkIHRvIG1h
dGNoIHRoZSBzbmFwc2hvdHRlZCBldmVudHMuCgpJIGNhbiBzZWUgYSBwZXJzcGVjdGl2ZSB3aGVy
ZSB0aGUgc25hcHNob3RfYWdncmVnYXRlIGlzIHRoZW9yZXRpY2FsbHkKcmVkdW5kYW50LCBidXQg
SSBjYW4gYWxzbyBzZWUgYXQgbGVhc3Qgb25lIHByYWN0aWNhbCBwZXJzcGVjdGl2ZSB3aGVyZQph
IHNuYXBzaG90X2FnZ3JlZ2F0ZSBjb3VsZCBiZSB1c2VkIHRvIHNpbXBsaWZ5IGEgcmVtb3RlIGF0
dGVzdGF0aW9uCndpdGggYSBzdWZmaWNpZW50bHkgc3RhdGVmdWwgYXR0ZXN0YXRpb24gc2Vydmlj
ZS4KCj4gQSByZWR1bmRhbmN5IGlzIGFuIGF0dGFjayBzdXJmYWNlLgoKTm93IHRoYXQgaXMgYW4g
b3Zlcmx5IGJyb2FkIGdlbmVyYWxpemF0aW9uLCBpZiB3ZSBhcmUgZ29pbmcgdGhhdApyb3V0ZSwg
KmV2ZXJ5dGhpbmcqIGlzIGFuIGF0dGFjayBzdXJmYWNlIChhbmQgdGhpcyBhcmd1YWJseSB0cnVl
CnJlZ2FyZGxlc3MsIGFsdGhvdWdoIGEgYml0IG9mIGFuIGV4dHJlbWUgc3RhdGVtZW50KS4KCj4g
QSBiYWRseSB3cml0dGVuIHZlcmlmaWVyCj4gbWlnaHQgbm90IGRvIHRoYXQgdmVyaWZpY2F0aW9u
LCBhbmQgdGhpcyBwZXJtaXRzIHNuYXBzaG90dGVkCj4gZXZlbnRzIHRvIGJlIGZvcmdlZC4gTm8g
YWdncmVnYXRlIG1lYW5zIHRoZSB2ZXJpZmllciBjYW4ndAo+IG1ha2UgYSBtaXN0YWtlLgoKSSB3
b3VsZCBhc2sgdGhhdCB5b3UgcmVhZCB5b3VyIG93biBjb21tZW50IGFnYWluLiAgQSBwb29ybHkg
d3JpdHRlbgp2ZXJpZmllciBpcyBzdWJqZWN0IHRvIGFueSBudW1iZXIgb2YgcGl0ZmFsbHMgYW5k
IHZ1bG5lcmFiaWxpdGllcywKcmVnYXJkbGVzcyBvZiBhIHNuYXBzaG90IGFnZ3JlZ2F0ZS4gIEFz
IGEgcmVtaW5kZXIsIHRoZSBzbmFwc2hvdHRpbmcKbWVjaGFuaXNtIGhhcyBhbHdheXMgYmVlbiBw
cm9wb3NlZCBhcyBhbiBvcHQtaW4gbWVjaGFuaXNtLCBpZiBvbmUgaGFzCm5vdCBpbXBsZW1lbnRl
ZCBhIHByb3BlciBzbmFwc2hvdC1hd2FyZSBhdHRlc3RhdGlvbiBtZWNoYW5pc20gdGhlbgp0aGV5
IGNhbiBzaW1wbHkgcmVmcmFpbiBmcm9tIHRha2luZyBhIHNuYXBzaG90IGFuZCByZWplY3QgYWxs
CmF0dGVzdGF0aW9uIGF0dGVtcHRzIHVzaW5nIGEgc25hcHNob3QuCgo+IE9uIDExLzIyLzIwMjMg
OToyMiBBTSwgUGF1bCBNb29yZSB3cm90ZToKPiA+IEkgYmVsaWV2ZSB0aGUgaW50ZW50IGlzIHRv
IG9ubHkgcGF1c2UgdGhlIG1lYXN1cmVtZW50cyB3aGlsZSB0aGUKPiA+IHNuYXBzaG90X2FnZ3Jl
Z2F0ZSBpcyBnZW5lcmF0ZWQsIG5vdCBmb3IgdGhlIGR1cmF0aW9uIG9mIHRoZSBlbnRpcmUKPiA+
IHNuYXBzaG90IHByb2Nlc3MuICBUaGUgcHVycG9zZSBvZiB0aGUgc25hcHNob3RfYWdncmVnYXRl
IGlzIHRvCj4gPiBlc3RhYmxpc2ggYSBuZXcgcm9vdCBvZiB0cnVzdCwgc2ltaWxhciB0byB0aGUg
Ym9vdF9hZ2dyZWdhdGUsIHRvIGhlbHAKPiA+IGltcHJvdmUgYXR0ZXN0YXRpb24gcGVyZm9ybWFu
Y2UuCgotLSAKcGF1bC1tb29yZS5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
