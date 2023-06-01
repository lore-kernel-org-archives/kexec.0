Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F73C77B73
	for <kexec@archiver.kernel.org>; Thu,  1 Jun 2023 01:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ijZ37DJ09W4Ee8As4fMFwQaMAcYZF24enxBuGhe/KGI=; b=a9uEg81pUFZwYE
	cxvb12rl7LbOGEzRuLQVFI92Y2xzs5CrSr3rdq6fOH5eJgPl0RETrVQ9PJQ5Rmsno6XKcQB1zrig9
	ihPxPjwN5uzYUqkbarD2NVHSc+C+rxDybWPh+4CmVLqZ2ax54GxNnYoB2hnHbH9lXtidZE3c7w6p9
	aruOcTi7nl+oxL+CeSax2KCgzkyLAu3boNABGvHVTX6+p4CEB09UcRZlDS5EE/PAtSmAfiTdfyAWT
	JZL33qfLl5FUTVljPekH8fUHow5d3Ys3gR0kLRCEbht6DPgHwdJdRuQFYN/B4y8C6m2R9g2l6dLQX
	4D23XzXF+XpAhQTnEo8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4XNe-001euo-1l;
	Thu, 01 Jun 2023 01:45:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4XNa-001ett-1b
	for kexec@lists.infradead.org;
	Thu, 01 Jun 2023 01:45:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685583925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wikRRQsxNQ97PYn14rHkO66E3G1u30DSKcHh3jXSxuA=;
	b=J9QY5AsYNoE1ghB1/cOY3E2AFTuiLlgQUrBiqdBW1UHbOA7R/gIimC2loxdvkjcWs5cKia
	qNWhMHYGxjFNVZoAfM6PosHx0s+8P0yHbG6PYxxRQqKRBeRMB8vOpB0oxJWAYe1iqBv5DL
	4pqJZL5lm2cRmq6fvc/ags4ck0gMkTU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-SDE3mssXO9i6OhE2EMwoJQ-1; Wed, 31 May 2023 21:45:24 -0400
X-MC-Unique: SDE3mssXO9i6OhE2EMwoJQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-624b4176bf7so6044886d6.1
        for <kexec@lists.infradead.org>; Wed, 31 May 2023 18:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685583923; x=1688175923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wikRRQsxNQ97PYn14rHkO66E3G1u30DSKcHh3jXSxuA=;
        b=Xc973rL71BGliWgTmB1PExa2Yf1WlenhNdzdIK9y4V3+MaOFyCoRug0FEJ428IOcn/
         sA32DlmisNt+QCLh07sxk93pJAeAURPXH8HgOQ4EIwvjd4QEqJiBZY07BuUJp479hoID
         NWoCX7tM3g6tFvrT++LP0wrgA1KKNbsf5sTljjiacBcmdXy+HCFkxUXsZdivQ5qOs2ME
         KaiZJI0hY9lfP/qR0oQzqueUVztKOp350o9qBR1bQHGf4It96w3yMQZqELpJeDM+uqDu
         Ov8qH0BvZ7JR+Js1hS8GSL1MA2F0NLtVw+h/ilcoJfJyeHnFsP7Wqk+pi8MaWKoL4R6n
         a2ww==
X-Gm-Message-State: AC+VfDwoD62PlXVYSoa99vtJlNc94s9u+wS5BfvSIrUf2uuuKivlVUJw
	o+7lvgaK6IiASo2dKxb+DkSe2kGW6sTnrJ8bn6W/b+bnV2GDRBIr/0PXLe9uNR5sYiLxBtPPiQv
	HDlEh2R1+zwHhiJpbfnGV/enc7UpH91ZOl71U
X-Received: by 2002:a05:6214:1c88:b0:627:5560:1ecf with SMTP id ib8-20020a0562141c8800b0062755601ecfmr3403369qvb.7.1685583923137;
        Wed, 31 May 2023 18:45:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Sqsnxm/iwFVOXNtaKUjawOw3AAj052lZCpPBrEOxbcFhVNsTZh/CfzF28V5J5hZuS0QK5RRU7gM49NC1ZDUs=
X-Received: by 2002:a05:6214:1c88:b0:627:5560:1ecf with SMTP id
 ib8-20020a0562141c8800b0062755601ecfmr3403360qvb.7.1685583922833; Wed, 31 May
 2023 18:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230516073124.23531-1-piliu@redhat.com> <20230516073124.23531-2-piliu@redhat.com>
 <ZG36mQerUGDHAgcQ@kernel.org> <CAF+s44RTqPzURPYDJm+XKv2U4-=LUB9dPk7GaDPBWihJKSf_UA@mail.gmail.com>
In-Reply-To: <CAF+s44RTqPzURPYDJm+XKv2U4-=LUB9dPk7GaDPBWihJKSf_UA@mail.gmail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 1 Jun 2023 09:45:12 +0800
Message-ID: <CAF+s44QCWAxuZDtzdwx0fDFGMmzYpiuXas7K9KRb7BWz5VZV0Q@mail.gmail.com>
Subject: Re: [PATCHv2 1/6] kexec: Change the image probe's prototype
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ardb@kernel.org, 
	jeremy.linton@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_184530_629087_81E5BB62 
X-CRM114-Status: GOOD (  39.22  )
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

T24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgMTE6MzLigK9BTSBQaW5nZmFuIExpdSA8cGlsaXVAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIE1heSAyNCwgMjAyMyBhdCA3OjUz4oCvUE0gU2lt
b24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPiB3cm90ZToKPiA+Cj4gPiBPbiBUdWUsIE1heSAx
NiwgMjAyMyBhdCAwMzozMToxOVBNICswODAwLCBQaW5nZmFuIExpdSB3cm90ZToKPiA+ID4gQXMg
bW9yZSBjb21wbGljYXRlZCBrZXJuZWwgZm9ybWF0IG9jY3VycyBzdWNoIGFzIHpib290LCB3aGVy
ZSB0aGUKPiA+ID4gY29tcHJlc3NlZCBrZXJuZWwgaXMgc3RvcmVkIGFzIGEgcGF5bG9hZC4gVGhl
IHN0cmFpZ2h0IGZvcndhcmQKPiA+ID4gZGVjb21wcmVzc2lvbiBjYW4gbm90IG1lZXQgdGhlIGRl
bWFuZC4KPiA+ID4KPiA+ID4gQSBuZXcgaW1hZ2UgcHJvYmUgbWV0aG9kIGlzIGV4cGVjdGVkIHRv
IHJlYWQgaW4gdGhlIGtlcm5lbCBmaWxlIGFuZCBkZWNpZGUKPiA+ID4gaG93IHRvIHVuZm9sZCB0
aGUgY29udGVudCBieSBpdHNlbGYuCj4gPiA+Cj4gPiA+IFRoaXMgcGF0Y2ggYWltcyB0byBjaGFu
Z2UgdGhlIGltYWdlIHByb2JlJ3MgcHJvdG90eXBlIGZyb20KPiA+ID4gICAgICAgICAgICAgdHlw
ZWRlZiBpbnQgKHByb2JlX3QpKGNvbnN0IGNoYXIgKmtlcm5lbF9idWYsIG9mZl90IGtlcm5lbF9z
aXplKTsKPiA+ID4gdG8KPiA+ID4gICAgICAgICAgICAgdHlwZWRlZiBpbnQgKHByb2JlX3QpKGNv
bnN0IGNoYXIgKmtlcm5lbF9idWYsIG9mZl90IGtlcm5lbF9zaXplLCBzdHJ1Y3Qga2V4ZWNfaW5m
byAqaW5mbyk7Cj4gPiA+Cj4gPiA+IExhdGVyLCBpbmZvIGNhbiBiZSB1c2VkIHRvIHJldHVybiBi
b3RoIHRoZSBmaWxlIGRlc2NyaXB0b3IgYW5kIHRoZQo+ID4gPiBwYXJzZWQga2VybmVsIGJ1ZmZl
ci4KPiA+ID4KPiA+ID4gSW4gY2FzZSB5b3VyIGFyZSBjdXJpb3VzLCB0aGUgcmVtYWluZyBwYXJ0
IG9mIHRoZSBsb2cgZGVzY3JpYmVzIHRoZQo+ID4gPiBwcm9jZXNzIG9mIHRoZSBzdWJzdGl0dXRp
b24gb2YgdGhlIG5ldyBwcm90b3R5cGUsIHdoaWNoIGNhbiBiZSBkaXZpZGVkCj4gPiA+IGludG8g
dGhyZWUgZ3JvdXBzLgo+ID4gPgo+ID4gPiAxLiBjaGFuZ2UgZnVuY3Rpb24gcG9pbnRlciBhbmQg
aXRzIGNhbGxzaXRlczoKPiA+ID4gICBzZWQgLWkgJ3MvKHByb2JlX3QpKGNvbnN0IGNoYXIgXCpr
ZXJuZWxfYnVmLCBvZmZfdCBrZXJuZWxfc2l6ZSk7Lyhwcm9iZV90KShjb25zdCBjaGFyIFwqa2Vy
bmVsLCBvZmZfdCBrZXJuZWxfc2l6ZSwgc3RydWN0IGtleGVjX2luZm8gXCppbmZvKTsvZycga2V4
ZWMva2V4ZWMuaAo+ID4gPiAgIHNlZCAtaSAncy9cLnByb2JlKFwoW14sXSpcKSwgXChbXildKlwp
KS9cLnByb2JlKFwxLCBcMiwgTlVMTCkvZycga2V4ZWMva2V4ZWMuYwo+ID4gPgo+ID4gPiAyLiBj
aGFuZ2UgdGhlIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIGFuZCBkZWZpbml0aW9uIG9mIGVhY2ggJ3By
b2JlJwo+ID4gPiAgICBpbnN0YW5jZSBieSBjb2NjaW5lbGxlIGJlY2F1c2UgdGhleSBtYXkgY3Jv
c3MgbGluZXMKPiA+ID4KPiA+ID4gVGhlIGNvY2NpIGZpbGUgbG9va3MgbGlrZToKPiA+ID4KPiA+
ID4gQCBydWxlMSBACj4gPiA+IGlkZW50aWZpZXIgZm4gPX4gIl9wcm9iZSI7Cj4gPiA+IGlkZW50
aWZpZXIgYnVmLCBzaXplOwo+ID4gPiB0eXBlZGVmIG9mZl90Owo+ID4gPiBAQAo+ID4gPgo+ID4g
PiAtaW50IGZuKGNvbnN0IGNoYXIgKmJ1Ziwgb2ZmX3Qgc2l6ZSkKPiA+ID4gK2ludCBmbihjb25z
dCBjaGFyICpidWYsIG9mZl90IHNpemUsIHN0cnVjdCBrZXhlY19pbmZvICppbmZvKQo+ID4gPiB7
Cj4gPiA+ICAgICAgICAgLi4uCj4gPiA+IH0KPiA+ID4KPiA+ID4gQCBydWxlMiBACj4gPiA+IGlk
ZW50aWZpZXIgZm4gPX4gIl9wcm9iZSI7Cj4gPiA+IGlkZW50aWZpZXIgYnVmLCBzaXplOwo+ID4g
PiB0eXBlZGVmIG9mZl90Owo+ID4gPiBAQAo+ID4gPgo+ID4gPiAraW50IGZuKGNvbnN0IGNoYXIg
KmJ1Ziwgb2ZmX3Qgc2l6ZSwgc3RydWN0IGtleGVjX2luZm8gKmluZm8pOwo+ID4gPiAtaW50IGZu
KGNvbnN0IGNoYXIgKmJ1Ziwgb2ZmX3Qgc2l6ZSk7Cj4gPiA+Cj4gPiA+IFRoZW4gcnVubmluZyB0
aGUgY29tbWFuZAo+ID4gPiBzcGF0Y2ggLS1zcC1maWxlIGNvY2NpL2RlZmluZS5jb2NjaSAtLWRp
ciBrZXhlYyAtLWluY2x1ZGUtaGVhZGVycyA+IC4uL2RlZmluZS5wYXRjaAo+ID4gPiBnaXQgYXBw
bHkgLS1kaXJlY3Rvcnk9a2V4ZWMgLi4vZGVmaW5lLnBhdGNoCj4gPiA+Cj4gPiA+IDMuIGNoYW5n
ZSB0aGUgZGlyZWN0IGNhbGxzIHRvIHRoZSBwcm9iZSBpbnN0YW5jZXMKPiA+ID4KPiA+ID4gT3Jp
Z2luYWxseSBJIHBsYW5uZWQgdG8gYWNoaWV2ZSB0aGlzIGJ5IGNvY2NpbmVsbGUsIGJ1dCBmYWls
ZWQgc2ltaWxhcgo+ID4gPiB0byBbMV0uIEkgaGF2ZSB0cmllZCB1c2luZyAiLUkgYW5kIC0taW5j
bHVkZSIgb3B0aW9uIGZvciBjb2NjaW5lbGxlLCBidXQgaXQKPiA+ID4gc3RpbGwgZGlkIG5vdCB3
b3JrLgo+ID4gPgo+ID4gPiBDaGVja2luZyB0aGUgZGlyZWN0IGNhbGxzaXRlIGJ5ICJnaXQgZ3Jl
cCAiX3Byb2JlKCIgfCBncmVwIC12IGNvbnN0Igo+ID4gPiBGb3J0dW5hdGVsbHksIGl0IHR1cm5z
IG91dCB0aGF0IG9ubHkgYSBmZXcgZGlyZWN0IGNhbGxzaXRlcyBleGlzdCwgd2hpY2gKPiA+ID4g
bGllcyBpbiBpMzg2LCBhbmQgZWFzeSB0byBiZSBhbWVuZGVkIG1hbnVhbGx5Lgo+ID4gPgo+ID4g
PiBBbnl3YXksIGp1c3QgRllJLCB0aGUgY29jY2kgZmlsZSBsb29rcyBsaWtlOgo+ID4gPiBAIHJ1
bGUxIEAKPiA+ID4gaWRlbnRpZmllciBmbiA9fiAiX3Byb2JlIjsKPiA+ID4gaWRlbnRpZmllciBi
dWYsIHNpemU7Cj4gPiA+IGlkZW50aWZpZXIgaW5mbzsKPiA+ID4gdHlwZWRlZiBvZmZfdDsKPiA+
ID4gQEAKPiA+ID4KPiA+ID4gaW50IGZuKGNvbnN0IGNoYXIgKmJ1Ziwgb2ZmX3Qgc2l6ZSwgc3Ry
dWN0IGtleGVjX2luZm8gKmluZm8pOwo+ID4gPgo+ID4gPiAvKiBjaGFuZ2UgdGhlIGRpcmVjdCBj
YWxsc2l0ZSBvZiBhbnkgcHJvYmUgKi8KPiA+ID4gQCBydWxlMiBACj4gPiA+IGlkZW50aWZpZXIg
cnVsZTEuZm47Cj4gPiA+IGV4cHJlc3Npb24gRTEsIEUyOwo+ID4gPiBAQAo+ID4gPgo+ID4gPiAg
Zm4oRTEsIEUyCj4gPiA+ICsgICxOVUxMCj4gPiA+ICAgICkKPiA+ID4KPiA+ID4gVGhlbiBydW5u
aW5nIHRoZSBjb21tYW5kOgo+ID4gPiBzcGF0Y2ggLS1zcC1maWxlIGNvY2NpL2RpcmVjdC5jb2Nj
aSAtLWRpciBrZXhlYyAtLWluY2x1ZGUtaGVhZGVycwo+ID4gPgo+ID4gPiBbMV06IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC9hbHBpbmUuREVCLjIuMjIuMzk0LjIyMDIyODA3MDUwODAuMzEx
MkBoYWRyaWVuL1QvCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBpbmdmYW4gTGl1IDxwaWxp
dUByZWRoYXQuY29tPgo+ID4gPiBUbzoga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwo+ID4gPiBD
YzogaG9ybXNAdmVyZ2UubmV0LmF1Cj4gPiA+IENjOiBhcmRiQGtlcm5lbC5vcmcKPiA+ID4gQ2M6
IGplcmVteS5saW50b25AYXJtLmNvbQo+ID4KPiA+IFVuZm9ydHVuYXRlbHkgSSBhbSBzZWVpbmcg
YSBidWlsZCBmYWlsdXJlIG9uIChhdCBsZWFzdCkgc2g0IHdpdGggdGhpcyBjaGFuZ2U6Cj4gPgo+
ID4gIC4uLy4uL2tleGVjL2FyY2gvc2gva2V4ZWMtekltYWdlLXNoLmM6NTQ6NTogZXJyb3I6IGNv
bmZsaWN0aW5nIHR5cGVzIGZvciDigJh6SW1hZ2Vfc2hfcHJvYmXigJkKPiA+ICAgICA1NCB8IGlu
dCB6SW1hZ2Vfc2hfcHJvYmUoY29uc3QgY2hhciAqYnVmLCBvZmZfdCBVTlVTRUQobGVuKSkKPiA+
ICAgICAgICB8ICAgICBefn5+fn5+fn5+fn5+fn4KPgo+IEl0IG1heSBiZSBiZWNhdXNlIHRoZSBt
YWNybyBVTlVTRUQoKSBpcyBub3QgdGFja2xlZCBjb3JyZWN0bHkgYnkgY29jY2luZWxsZS4KPgo+
IEFuZCB0aGVyZSBhcmUgc2V2ZXJhbCBvdGhlciBwbGFjZXMsIHdoaWNoIHVzZSBVTlVTRUQoKQo+
IGdpdCBncmVwIFVOVVNFRCB8IGdyZXAgcHJvYmUKPiBrZXhlYy9hcmNoL2FybS9rZXhlYy16SW1h
Z2UtYXJtLmM6MTM4OmludCB6SW1hZ2VfYXJtX3Byb2JlKGNvbnN0IGNoYXIKPiAqVU5VU0VEKGJ1
ZiksIG9mZl90IFVOVVNFRChsZW4pKQo+IGtleGVjL2FyY2gvczM5MC9rZXhlYy1pbWFnZS5jOjIx
OTppbWFnZV9zMzkwX3Byb2JlKGNvbnN0IGNoYXIKPiAqVU5VU0VEKGtlcm5lbF9idWYpLCBvZmZf
dCBVTlVTRUQoa2VybmVsX3NpemUpKQo+IGtleGVjL2FyY2gvc2gva2V4ZWMtbmV0YnNkLXNoLmM6
Mzg6aW50IG5ldGJzZF9zaF9wcm9iZShjb25zdCBjaGFyCj4gKmJ1Ziwgb2ZmX3QgVU5VU0VEKGxl
bikpCj4ga2V4ZWMvYXJjaC9zaC9rZXhlYy16SW1hZ2Utc2guYzo1NDppbnQgekltYWdlX3NoX3By
b2JlKGNvbnN0IGNoYXIKPiAqYnVmLCBvZmZfdCBVTlVTRUQobGVuKSkKPgo+IEkgd2lsbCBzZWUg
aG93IHRvIGhhbmRsZSB0aGVtLgo+CgpJJ20gaGF2aW5nIHRyb3VibGUgZmlndXJpbmcgb3V0IGhv
dyB0byBtYWtlIENvY2NpbmVsbGUgcmVjb2duaXplCiJVTlVTRUQoKSIgZXZlbiB0aG91Z2ggaXQg
Y2FuIHJlY29nbml6ZSAiYXR0cmlidXRlKHVudXNlZCkiLiAgU28gSQpmaXhlZCB0aGVzZSBpc3N1
ZXMgbWFudWFsbHkuCgpJIGhhdmUgZG8gY3Jvc3MtY29tcGlsaW5nIGZvciAiYXJtL2FybTY0L202
OGsvbWlwcy9tNjhrL3BwYzY0L3MzOTAvc2giCnVzaW5nIHRoZSB0b29sY2hhaW5zIG9uIGh0dHBz
Oi8vdG9vbGNoYWlucy5ib290bGluLmNvbS8KCkFuZCBJIG9wZW4gYSBwdWxsIHJlcXVlc3QgWzFd
IGZvciBbUEFUQ0h2MyAwLzZdIGFybTY0OiB6Ym9vdCBzdXBwb3J0LgpUaGUgb25seSBjaGFuZ2Ug
ZnJvbSB2Mi0+djMgaXMgdG8gZml4IHRoZSBjb21waWxpbmcgaXNzdWUgaW4gWzEvNl0KCgpbMV06
IGh0dHBzOi8vZ2l0aHViLmNvbS9ob3Jtcy9rZXhlYy10b29scy9wdWxsLzQKCgpUaGFua3MsCgpQ
aW5nZmFuCgo+Cj4gVGhhbmtzLAo+Cj4gUGluZ2Zhbgo+ID4gIEluIGZpbGUgaW5jbHVkZWQgZnJv
bSAuLi8uLi9rZXhlYy9hcmNoL3NoL2tleGVjLXpJbWFnZS1zaC5jOjI3Ogo+ID4gIC4uLy4uL2tl
eGVjL2FyY2gvc2gva2V4ZWMtc2guaDoxMTo1OiBub3RlOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBv
ZiDigJh6SW1hZ2Vfc2hfcHJvYmXigJkgd2FzIGhlcmUKPiA+ICAgICAxMSB8IGludCB6SW1hZ2Vf
c2hfcHJvYmUoY29uc3QgY2hhciAqYnVmLCBvZmZfdCBsZW4sIHN0cnVjdCBrZXhlY19pbmZvICpp
bmZvKTsKPiA+ICAgICAgICB8ICAgICBefn5+fn5+fn5+fn5+fn4KPiA+ICAuLi8uLi9rZXhlYy9h
cmNoL3NoL2tleGVjLXpJbWFnZS1zaC5jOjI5OjE4OiB3YXJuaW5nOiDigJhwcm9iZV9kZWJ1Z+KA
mSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQo+ID4gICAg
IDI5IHwgc3RhdGljIGNvbnN0IGludCBwcm9iZV9kZWJ1ZyA9IDA7Cj4gPiAgICAgICAgfCAgICAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn5+Cj4gPiAgbWFrZVsxXTogKioqIFtNYWtlZmlsZToxMjQ6
IGtleGVjL2FyY2gvc2gva2V4ZWMtekltYWdlLXNoLm9dIEVycm9yIDEKPiA+ICBtYWtlWzFdOiAq
KiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgo+ID4gIC4uLy4uL2tleGVjL2FyY2gv
c2gva2V4ZWMtbmV0YnNkLXNoLmM6Mjg6MTg6IHdhcm5pbmc6IOKAmHByb2JlX2RlYnVn4oCZIGRl
ZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCj4gPiAgICAgMjgg
fCBzdGF0aWMgY29uc3QgaW50IHByb2JlX2RlYnVnID0gMDsKPiA+ICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgXn5+fn5+fn5+fn4KPiA+Cj4gPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vaG9y
bXMva2V4ZWMtdG9vbHMvYWN0aW9ucy9ydW5zLzUwNjgyNTA0OTMvam9icy85MTAwMzE5MDkzI3N0
ZXA6NToyMTUKPiA+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
