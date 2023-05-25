Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AB5C77B7A
	for <kexec@archiver.kernel.org>; Thu, 25 May 2023 03:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H2D0rJYM7rafgExtFPYQBTuAArvmGdyvRqDnU0HRzVY=; b=h9e4oSy6Io3Spu
	C1WNd/yQ+cTW33kjZp4W0r+cUFSuIG3k1kmCg0VgXawHdnPU6Yo7apj1oJYKMKUUp1FSvndISBtmK
	9XeZm79fYiv/y50Bao6rGezKlzxv7g3SB64yvMjgYZNC3KzohJlctx+Ne8JgdAUMpE488oZQ5cwMF
	SLk/0U53EYkSrGFpwrK4KGV+rSgIl5vJKs5PDkplrFIOKy29B+wL/EHf0DUSTsfNCWoZJsxkxYSel
	Kyyw//9aWWRO4SqyWxB2cfMM3v+XPIfLZ4DPzuX4diHlWpuelcFrffxo5ZprT7yudQX+w8V2uRqeB
	rMkurUpCn288pkJ3Ap1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q21if-00FN02-12;
	Thu, 25 May 2023 03:32:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q21iZ-00FMz7-0k
	for kexec@lists.infradead.org;
	Thu, 25 May 2023 03:32:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684985563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nCL253oR0xrHiX919LuT19rMbaszPR0ez+RX1NsBHKo=;
	b=CeTtf9LTCjUIOgTlJOo9FaWIDLuQ+u7xT3epOaUODaX+Hg/UBVgotDf7ZRZaqUo7JBYcjH
	BmyhW+6tnJ1Z5bptrw/JQ6fDIjzVNMO/InXUQkSu6Y8ptcwRReMHYqsgOyLCclCIwrGXhF
	bkJ5vvNfZcpZPsh5tVhUbglArFXuw1E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-WgTRuoRuMM-92T_NEmNL4w-1; Wed, 24 May 2023 23:32:42 -0400
X-MC-Unique: WgTRuoRuMM-92T_NEmNL4w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-623998c0d33so5439976d6.0
        for <kexec@lists.infradead.org>; Wed, 24 May 2023 20:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684985561; x=1687577561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCL253oR0xrHiX919LuT19rMbaszPR0ez+RX1NsBHKo=;
        b=Wz8elBJqLAYsmeLS9anErvLo+SC0hQE9baFToKfshlKp5v/NhIwJhOsXs8vgCrEEMs
         lUFv4EoosS4JtFihIWbwMe6bvQsyL1QSzEouv3N1PI+uEZTcMAocEGxIS8A5J+WJ8ux+
         aokblt8ZjE+pub1VYjNgk5xFXcnQmjCBJqmiDwDIF73xTRON4XX5PYcG5TN3jWxLgtBM
         /pAzn6brjkl5DeYvY15MkcGyLTmWT6CS9Gktjny1P92dMLb0rko9ebVmOaSFmHV5X7+A
         URkXkV0TnykoXsffK1ktlR5R5uLFbGsoOyAbaE6E+Cyn/iHMHWVOOU/wjSIolk4W/JqJ
         ifBA==
X-Gm-Message-State: AC+VfDxYpBbmKK3uUJbVGSvFLxJnvmVqr8kqY2NF1bJxI14Z5HQKwwc4
	w4hTVkJNJuqwQGPhx/UD5VbbtCB6wRErSCNeaBRnsheT27Bh/d9bhCJqE9tFC1abWiXt/ikqxms
	WcaVrXDDrdCT8l9Bj+BW3yzx0yS4Z2+UDb2kemh0qc4j+wE4=
X-Received: by 2002:a05:6214:2b0d:b0:61b:5faf:9a72 with SMTP id jx13-20020a0562142b0d00b0061b5faf9a72mr206498qvb.3.1684985561467;
        Wed, 24 May 2023 20:32:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7aPyat/3nRnjUgeUsX36t6JNo9L7v259RwkLrNk5RYpmcpsEkuNXYiIQVMxFpuTwiFYg+1zoFc5eJrwcvSQJc=
X-Received: by 2002:a05:6214:2b0d:b0:61b:5faf:9a72 with SMTP id
 jx13-20020a0562142b0d00b0061b5faf9a72mr206491qvb.3.1684985561226; Wed, 24 May
 2023 20:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230516073124.23531-1-piliu@redhat.com> <20230516073124.23531-2-piliu@redhat.com>
 <ZG36mQerUGDHAgcQ@kernel.org>
In-Reply-To: <ZG36mQerUGDHAgcQ@kernel.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 25 May 2023 11:32:30 +0800
Message-ID: <CAF+s44RTqPzURPYDJm+XKv2U4-=LUB9dPk7GaDPBWihJKSf_UA@mail.gmail.com>
Subject: Re: [PATCHv2 1/6] kexec: Change the image probe's prototype
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ardb@kernel.org, 
	jeremy.linton@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_203247_364466_5223A8D7 
X-CRM114-Status: GOOD (  32.29  )
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

T24gV2VkLCBNYXkgMjQsIDIwMjMgYXQgNzo1M+KAr1BNIFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBUdWUsIE1heSAxNiwgMjAyMyBhdCAwMzozMToxOVBNICsw
ODAwLCBQaW5nZmFuIExpdSB3cm90ZToKPiA+IEFzIG1vcmUgY29tcGxpY2F0ZWQga2VybmVsIGZv
cm1hdCBvY2N1cnMgc3VjaCBhcyB6Ym9vdCwgd2hlcmUgdGhlCj4gPiBjb21wcmVzc2VkIGtlcm5l
bCBpcyBzdG9yZWQgYXMgYSBwYXlsb2FkLiBUaGUgc3RyYWlnaHQgZm9yd2FyZAo+ID4gZGVjb21w
cmVzc2lvbiBjYW4gbm90IG1lZXQgdGhlIGRlbWFuZC4KPiA+Cj4gPiBBIG5ldyBpbWFnZSBwcm9i
ZSBtZXRob2QgaXMgZXhwZWN0ZWQgdG8gcmVhZCBpbiB0aGUga2VybmVsIGZpbGUgYW5kIGRlY2lk
ZQo+ID4gaG93IHRvIHVuZm9sZCB0aGUgY29udGVudCBieSBpdHNlbGYuCj4gPgo+ID4gVGhpcyBw
YXRjaCBhaW1zIHRvIGNoYW5nZSB0aGUgaW1hZ2UgcHJvYmUncyBwcm90b3R5cGUgZnJvbQo+ID4g
ICAgICAgICAgICAgdHlwZWRlZiBpbnQgKHByb2JlX3QpKGNvbnN0IGNoYXIgKmtlcm5lbF9idWYs
IG9mZl90IGtlcm5lbF9zaXplKTsKPiA+IHRvCj4gPiAgICAgICAgICAgICB0eXBlZGVmIGludCAo
cHJvYmVfdCkoY29uc3QgY2hhciAqa2VybmVsX2J1Ziwgb2ZmX3Qga2VybmVsX3NpemUsIHN0cnVj
dCBrZXhlY19pbmZvICppbmZvKTsKPiA+Cj4gPiBMYXRlciwgaW5mbyBjYW4gYmUgdXNlZCB0byBy
ZXR1cm4gYm90aCB0aGUgZmlsZSBkZXNjcmlwdG9yIGFuZCB0aGUKPiA+IHBhcnNlZCBrZXJuZWwg
YnVmZmVyLgo+ID4KPiA+IEluIGNhc2UgeW91ciBhcmUgY3VyaW91cywgdGhlIHJlbWFpbmcgcGFy
dCBvZiB0aGUgbG9nIGRlc2NyaWJlcyB0aGUKPiA+IHByb2Nlc3Mgb2YgdGhlIHN1YnN0aXR1dGlv
biBvZiB0aGUgbmV3IHByb3RvdHlwZSwgd2hpY2ggY2FuIGJlIGRpdmlkZWQKPiA+IGludG8gdGhy
ZWUgZ3JvdXBzLgo+ID4KPiA+IDEuIGNoYW5nZSBmdW5jdGlvbiBwb2ludGVyIGFuZCBpdHMgY2Fs
bHNpdGVzOgo+ID4gICBzZWQgLWkgJ3MvKHByb2JlX3QpKGNvbnN0IGNoYXIgXCprZXJuZWxfYnVm
LCBvZmZfdCBrZXJuZWxfc2l6ZSk7Lyhwcm9iZV90KShjb25zdCBjaGFyIFwqa2VybmVsLCBvZmZf
dCBrZXJuZWxfc2l6ZSwgc3RydWN0IGtleGVjX2luZm8gXCppbmZvKTsvZycga2V4ZWMva2V4ZWMu
aAo+ID4gICBzZWQgLWkgJ3MvXC5wcm9iZShcKFteLF0qXCksIFwoW14pXSpcKSkvXC5wcm9iZShc
MSwgXDIsIE5VTEwpL2cnIGtleGVjL2tleGVjLmMKPiA+Cj4gPiAyLiBjaGFuZ2UgdGhlIGZ1bmN0
aW9uIGRlY2xhcmF0aW9uIGFuZCBkZWZpbml0aW9uIG9mIGVhY2ggJ3Byb2JlJwo+ID4gICAgaW5z
dGFuY2UgYnkgY29jY2luZWxsZSBiZWNhdXNlIHRoZXkgbWF5IGNyb3NzIGxpbmVzCj4gPgo+ID4g
VGhlIGNvY2NpIGZpbGUgbG9va3MgbGlrZToKPiA+Cj4gPiBAIHJ1bGUxIEAKPiA+IGlkZW50aWZp
ZXIgZm4gPX4gIl9wcm9iZSI7Cj4gPiBpZGVudGlmaWVyIGJ1Ziwgc2l6ZTsKPiA+IHR5cGVkZWYg
b2ZmX3Q7Cj4gPiBAQAo+ID4KPiA+IC1pbnQgZm4oY29uc3QgY2hhciAqYnVmLCBvZmZfdCBzaXpl
KQo+ID4gK2ludCBmbihjb25zdCBjaGFyICpidWYsIG9mZl90IHNpemUsIHN0cnVjdCBrZXhlY19p
bmZvICppbmZvKQo+ID4gewo+ID4gICAgICAgICAuLi4KPiA+IH0KPiA+Cj4gPiBAIHJ1bGUyIEAK
PiA+IGlkZW50aWZpZXIgZm4gPX4gIl9wcm9iZSI7Cj4gPiBpZGVudGlmaWVyIGJ1Ziwgc2l6ZTsK
PiA+IHR5cGVkZWYgb2ZmX3Q7Cj4gPiBAQAo+ID4KPiA+ICtpbnQgZm4oY29uc3QgY2hhciAqYnVm
LCBvZmZfdCBzaXplLCBzdHJ1Y3Qga2V4ZWNfaW5mbyAqaW5mbyk7Cj4gPiAtaW50IGZuKGNvbnN0
IGNoYXIgKmJ1Ziwgb2ZmX3Qgc2l6ZSk7Cj4gPgo+ID4gVGhlbiBydW5uaW5nIHRoZSBjb21tYW5k
Cj4gPiBzcGF0Y2ggLS1zcC1maWxlIGNvY2NpL2RlZmluZS5jb2NjaSAtLWRpciBrZXhlYyAtLWlu
Y2x1ZGUtaGVhZGVycyA+IC4uL2RlZmluZS5wYXRjaAo+ID4gZ2l0IGFwcGx5IC0tZGlyZWN0b3J5
PWtleGVjIC4uL2RlZmluZS5wYXRjaAo+ID4KPiA+IDMuIGNoYW5nZSB0aGUgZGlyZWN0IGNhbGxz
IHRvIHRoZSBwcm9iZSBpbnN0YW5jZXMKPiA+Cj4gPiBPcmlnaW5hbGx5IEkgcGxhbm5lZCB0byBh
Y2hpZXZlIHRoaXMgYnkgY29jY2luZWxsZSwgYnV0IGZhaWxlZCBzaW1pbGFyCj4gPiB0byBbMV0u
IEkgaGF2ZSB0cmllZCB1c2luZyAiLUkgYW5kIC0taW5jbHVkZSIgb3B0aW9uIGZvciBjb2NjaW5l
bGxlLCBidXQgaXQKPiA+IHN0aWxsIGRpZCBub3Qgd29yay4KPiA+Cj4gPiBDaGVja2luZyB0aGUg
ZGlyZWN0IGNhbGxzaXRlIGJ5ICJnaXQgZ3JlcCAiX3Byb2JlKCIgfCBncmVwIC12IGNvbnN0Igo+
ID4gRm9ydHVuYXRlbGx5LCBpdCB0dXJucyBvdXQgdGhhdCBvbmx5IGEgZmV3IGRpcmVjdCBjYWxs
c2l0ZXMgZXhpc3QsIHdoaWNoCj4gPiBsaWVzIGluIGkzODYsIGFuZCBlYXN5IHRvIGJlIGFtZW5k
ZWQgbWFudWFsbHkuCj4gPgo+ID4gQW55d2F5LCBqdXN0IEZZSSwgdGhlIGNvY2NpIGZpbGUgbG9v
a3MgbGlrZToKPiA+IEAgcnVsZTEgQAo+ID4gaWRlbnRpZmllciBmbiA9fiAiX3Byb2JlIjsKPiA+
IGlkZW50aWZpZXIgYnVmLCBzaXplOwo+ID4gaWRlbnRpZmllciBpbmZvOwo+ID4gdHlwZWRlZiBv
ZmZfdDsKPiA+IEBACj4gPgo+ID4gaW50IGZuKGNvbnN0IGNoYXIgKmJ1Ziwgb2ZmX3Qgc2l6ZSwg
c3RydWN0IGtleGVjX2luZm8gKmluZm8pOwo+ID4KPiA+IC8qIGNoYW5nZSB0aGUgZGlyZWN0IGNh
bGxzaXRlIG9mIGFueSBwcm9iZSAqLwo+ID4gQCBydWxlMiBACj4gPiBpZGVudGlmaWVyIHJ1bGUx
LmZuOwo+ID4gZXhwcmVzc2lvbiBFMSwgRTI7Cj4gPiBAQAo+ID4KPiA+ICBmbihFMSwgRTIKPiA+
ICsgICxOVUxMCj4gPiAgICApCj4gPgo+ID4gVGhlbiBydW5uaW5nIHRoZSBjb21tYW5kOgo+ID4g
c3BhdGNoIC0tc3AtZmlsZSBjb2NjaS9kaXJlY3QuY29jY2kgLS1kaXIga2V4ZWMgLS1pbmNsdWRl
LWhlYWRlcnMKPiA+Cj4gPiBbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9hbHBpbmUu
REVCLjIuMjIuMzk0LjIyMDIyODA3MDUwODAuMzExMkBoYWRyaWVuL1QvCj4gPgo+ID4gU2lnbmVk
LW9mZi1ieTogUGluZ2ZhbiBMaXUgPHBpbGl1QHJlZGhhdC5jb20+Cj4gPiBUbzoga2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwo+ID4gQ2M6IGhvcm1zQHZlcmdlLm5ldC5hdQo+ID4gQ2M6IGFyZGJA
a2VybmVsLm9yZwo+ID4gQ2M6IGplcmVteS5saW50b25AYXJtLmNvbQo+Cj4gVW5mb3J0dW5hdGVs
eSBJIGFtIHNlZWluZyBhIGJ1aWxkIGZhaWx1cmUgb24gKGF0IGxlYXN0KSBzaDQgd2l0aCB0aGlz
IGNoYW5nZToKPgo+ICAuLi8uLi9rZXhlYy9hcmNoL3NoL2tleGVjLXpJbWFnZS1zaC5jOjU0OjU6
IGVycm9yOiBjb25mbGljdGluZyB0eXBlcyBmb3Ig4oCYekltYWdlX3NoX3Byb2Jl4oCZCj4gICAg
IDU0IHwgaW50IHpJbWFnZV9zaF9wcm9iZShjb25zdCBjaGFyICpidWYsIG9mZl90IFVOVVNFRChs
ZW4pKQo+ICAgICAgICB8ICAgICBefn5+fn5+fn5+fn5+fn4KCkl0IG1heSBiZSBiZWNhdXNlIHRo
ZSBtYWNybyBVTlVTRUQoKSBpcyBub3QgdGFja2xlZCBjb3JyZWN0bHkgYnkgY29jY2luZWxsZS4K
CkFuZCB0aGVyZSBhcmUgc2V2ZXJhbCBvdGhlciBwbGFjZXMsIHdoaWNoIHVzZSBVTlVTRUQoKQpn
aXQgZ3JlcCBVTlVTRUQgfCBncmVwIHByb2JlCmtleGVjL2FyY2gvYXJtL2tleGVjLXpJbWFnZS1h
cm0uYzoxMzg6aW50IHpJbWFnZV9hcm1fcHJvYmUoY29uc3QgY2hhcgoqVU5VU0VEKGJ1ZiksIG9m
Zl90IFVOVVNFRChsZW4pKQprZXhlYy9hcmNoL3MzOTAva2V4ZWMtaW1hZ2UuYzoyMTk6aW1hZ2Vf
czM5MF9wcm9iZShjb25zdCBjaGFyCipVTlVTRUQoa2VybmVsX2J1ZiksIG9mZl90IFVOVVNFRChr
ZXJuZWxfc2l6ZSkpCmtleGVjL2FyY2gvc2gva2V4ZWMtbmV0YnNkLXNoLmM6Mzg6aW50IG5ldGJz
ZF9zaF9wcm9iZShjb25zdCBjaGFyCipidWYsIG9mZl90IFVOVVNFRChsZW4pKQprZXhlYy9hcmNo
L3NoL2tleGVjLXpJbWFnZS1zaC5jOjU0OmludCB6SW1hZ2Vfc2hfcHJvYmUoY29uc3QgY2hhcgoq
YnVmLCBvZmZfdCBVTlVTRUQobGVuKSkKCkkgd2lsbCBzZWUgaG93IHRvIGhhbmRsZSB0aGVtLgoK
ClRoYW5rcywKClBpbmdmYW4KPiAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4uLy4uL2tleGVjL2Fy
Y2gvc2gva2V4ZWMtekltYWdlLXNoLmM6Mjc6Cj4gIC4uLy4uL2tleGVjL2FyY2gvc2gva2V4ZWMt
c2guaDoxMTo1OiBub3RlOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBvZiDigJh6SW1hZ2Vfc2hfcHJv
YmXigJkgd2FzIGhlcmUKPiAgICAgMTEgfCBpbnQgekltYWdlX3NoX3Byb2JlKGNvbnN0IGNoYXIg
KmJ1Ziwgb2ZmX3QgbGVuLCBzdHJ1Y3Qga2V4ZWNfaW5mbyAqaW5mbyk7Cj4gICAgICAgIHwgICAg
IF5+fn5+fn5+fn5+fn5+fgo+ICAuLi8uLi9rZXhlYy9hcmNoL3NoL2tleGVjLXpJbWFnZS1zaC5j
OjI5OjE4OiB3YXJuaW5nOiDigJhwcm9iZV9kZWJ1Z+KAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBb
LVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQo+ICAgICAyOSB8IHN0YXRpYyBjb25zdCBpbnQgcHJv
YmVfZGVidWcgPSAwOwo+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn4KPiAg
bWFrZVsxXTogKioqIFtNYWtlZmlsZToxMjQ6IGtleGVjL2FyY2gvc2gva2V4ZWMtekltYWdlLXNo
Lm9dIEVycm9yIDEKPiAgbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4u
Li4KPiAgLi4vLi4va2V4ZWMvYXJjaC9zaC9rZXhlYy1uZXRic2Qtc2guYzoyODoxODogd2Fybmlu
Zzog4oCYcHJvYmVfZGVidWfigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0
LXZhcmlhYmxlPV0KPiAgICAgMjggfCBzdGF0aWMgY29uc3QgaW50IHByb2JlX2RlYnVnID0gMDsK
PiAgICAgICAgfCAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+Cj4KPiBMaW5rOiBodHRwczov
L2dpdGh1Yi5jb20vaG9ybXMva2V4ZWMtdG9vbHMvYWN0aW9ucy9ydW5zLzUwNjgyNTA0OTMvam9i
cy85MTAwMzE5MDkzI3N0ZXA6NToyMTUKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
