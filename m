Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF2AD3A661
	for <kexec@archiver.kernel.org>; Tue, 29 Oct 2024 15:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TzfX2lhr7nY47WMPyNTvRadljsoPx/VQ2c03qzYohRI=; b=bdH6ffQ3YYvRKm
	EnvwE/wbW5NQPqK9+FWdMBtlAkf+VWaMLT0HJ6rjuvqc2u6OaO6wbo0A4V1LXBMk1tJFUnCvyMVAG
	05SplCz7dHKl0pEWk8gMZDOT4h9uDWWmzj8SHR6p0VlrFj84H5S4DfgnTWOB97fPdXhqCErG1Zo9L
	sx7qWGbjXzI+1CiMCYLCnE/UQm7zGQiej81bDvyo9xN1yPR1iTXzUQKFVsaicoWEI6fVeohay+P4p
	kxp9BcMWdo+H1QDsGAQNkw8iHjW8V6a+7ixsEzx3h6OKOYgvtq7AcvTZveCNwcZ4KwCvhJ+/qe656
	wdrIGI5rVa3pTQOVt0TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5oQg-0000000EzI7-0K60;
	Tue, 29 Oct 2024 15:46:46 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5oDN-0000000EwHo-2d6u
	for kexec@lists.infradead.org;
	Tue, 29 Oct 2024 15:33:03 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4315ee633dcso239805e9.1
        for <kexec@lists.infradead.org>; Tue, 29 Oct 2024 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730215978; x=1730820778; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA25QmUqC0ZcOPOspAQgURZn/6Gu6Iy+i/zcroEU5qE=;
        b=0JU9lw9ke5dkpK6OZcFqh4kiZS4jQHYsH4QKVbMS8G0njRvrC41Ve6HpN5yFFI6RQc
         L+X+13b7ZG1dY+HWiYPkVgRxBX6TzLDNj6om041JByWTHV40beb7qmmqUzhqtd6Hli4S
         R0RCmdwKF8OODuTk6eCib0IH9/6QnKiUKn862LHYpq213wH2Qe0S7OWCA8v+UpHJX+8q
         9x9MZ1nd7qKyaK9qpl2MpxZWek8ZvTqLKJnZabxRr29LSDtj9+rCrQl0xZT+m5qEI+KD
         D/8WC5rsJw29e/KGaeFIUUcthQnZ0cvSOFJ2OhrBKGl/05Q4GesOpN11pWTscBFQgH7z
         09Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730215978; x=1730820778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lA25QmUqC0ZcOPOspAQgURZn/6Gu6Iy+i/zcroEU5qE=;
        b=XnuxsG5diPCoycWLGPUxiwtlrVo+5mytPnKXBuDFIfJ/3oegcTOMNuAR43Y+BFkM7x
         h4WwNlyQKrAA7BQVddWFjjLcLtP5I0WdrOrwjgreXtGFmfHqS0CIzTqG6dKoLdHq5XHk
         WVx23MSBwrARxHoacV9D+Pu45Jm+1vUDsgNly/u/x++U6odeRSSE0aP6/wdq5GV0MJD5
         L0oYVdd4EeRkfpTyqtsJ427H8Q8vbIhzdnvjfVm/+M/WDnsDvOSngASce+TvkMwusVRf
         S+N4gZNmOWpqNBd6E/lD/K7N5qYM9UmHEUAUpnVwWv6qomTIPBYV1QQ/50XtjOqUmn0v
         0ycA==
X-Forwarded-Encrypted: i=1; AJvYcCVN0V1HGjZT6qWiJkciV9Ul1f1/AicP14GYwpEJcynwMjN4CqtbOjBl1SfcEJCmIEuiUSYjkA==@lists.infradead.org
X-Gm-Message-State: AOJu0YySmHqxT/SLm+R3ch/mSEkr+uB8Pc8HVk0kVtyEKd5oUjxG9i1W
	gwy/Qy+NYgdO9Bp1KneVNzxE4h8HvXlco9FkBxZc/4/EN/7FO5MrhmqxEJeP8OeoKlVhbmL1eq/
	uss2KARGRXEusOvMrYjyYh3j0jIolIpIw8PNs
X-Gm-Gg: ASbGncvVN3Ya0qnM0HoaahZdC5RJ+3v/fCQ27QRo/CbnhjYlImDVDg9AG0dyDR7klUP
	LTXsrW9TL5vCgckszLZTtx8IGXle2cg==
X-Google-Smtp-Source: AGHT+IG4cSjy9rKsIArP/hCONxPQKYWRexhjTn64f/Kyhz47oUfHYKz591NpwDalxYSsaco3mIoeoduYf0V3i4rFvT4=
X-Received: by 2002:a05:600c:b85:b0:42c:b0b0:513a with SMTP id
 5b1f17b1804b1-431b3c9a40dmr5307525e9.2.1730215978010; Tue, 29 Oct 2024
 08:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <f44f317a-2dcb-cfe2-013c-7508907ce3df@google.com> <5b6613bc-beef-79e6-62ed-23de4dfafe51@google.com>
In-Reply-To: <5b6613bc-beef-79e6-62ed-23de4dfafe51@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 29 Oct 2024 21:02:45 +0530
Message-ID: <CAGtprH-xiW8XaJLqNht906C5kN_vsv3EtqNoEC5pSQVS_OJ0Og@mail.gmail.com>
Subject: Re: Pmemfs/guestmemfs discussion recap and open questions
To: David Rientjes <rientjes@google.com>
Cc: James Gowans <jgowans@amazon.com>, Dave Hansen <dave.hansen@intel.com>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Mike Rapoport <mike.rapoport@gmail.com>, Pasha Tatashin <tatashin@google.com>, 
	Peter Xu <peterx@redhat.com>, Alexander Graf <graf@amazon.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Frank van der Linden <fvdl@google.com>, 
	Vipin Sharma <vipinsh@google.com>, David Matlack <dmatlack@google.com>, 
	Steve Rutherford <srutherford@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Alper Gun <alpergun@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Sagi Shahar <sagis@google.com>, linux-mm@kvack.org, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_083301_701655_AA54FF44 
X-CRM114-Status: GOOD (  33.50  )
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

T24gU2F0LCBPY3QgMjYsIDIwMjQgYXQgMTE6MzfigK9BTSBEYXZpZCBSaWVudGplcyA8cmllbnRq
ZXNAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIDE2IE9jdCAyMDI0LCBEYXZpZCBSaWVu
dGplcyB3cm90ZToKPgo+ID4gLS0tLS0+by0tLS0tCj4gPiBNeSB0YWtlYXdheTogYmFzZWQgb24g
dGhlIGZlZWRiYWNrIHRoYXQgd2FzIHByb3ZpZGVkIGluIHRoZSBkaXNjdXNzaW9uOgo+ID4KPiA+
ICAtIHdlIG5lZWQgYW4gYWxsb2NhdG9yIGFic3RyYWN0aW9uIGZvciBwZXJzaXN0ZW50IG1lbW9y
eSB0aGF0IGNhbiByZXR1cm4KPiA+ICAgIG1lbW9yeSB3aXRoIHZhcmlvdXMgY2hhcmFjdGVyaXN0
aWNzOiAxR0Igb3Igbm90LCBrZXJuZWwgZGlyZWN0IG1hcCBvcgo+ID4gICAgbm90LCBIVk8gb3Ig
bm90LCBldGMuCj4gPgo+ID4gIC0gYnVpbHQgb24gdG9wIG9mIHRoYXQsIHdlIG5lZWQgdGhlIGFi
aWxpdHkgdG8gY2FydmUgb3V0IHZlcnkgbGFyZ2UKPiA+ICAgIHJhbmdlcyBvZiBtZW1vcnkgKGNs
b3VkIHByb3ZpZGVyIHVzZSBjYXNlKSB3aXRoIE5VTUEgYXdhcmVuZXNzIG9uIHRoZQo+ID4gICAg
a2VybmVsIGNvbW1hbmQgbGluZQo+ID4KPgo+IEZvbGxvd2luZyB1cCBvbiB0aGlzLCBJIHRoaW5r
IHRoaXMgcGh5c2ljYWwgbWVtb3J5IGFsbG9jYXRvciB3b3VsZCBhbHNvIGJlCj4gcG9zc2libGUg
dG8gdXNlIGFzIGEgYmFja2VuZCBmb3IgaHVnZXRsYi4gIEhvcGVmdWxseSB0aGlzIHdvdWxkIGJl
IGFuCj4gYWxsb2NhdG9yIHRoYXQgd291bGQgYmUgZ2VuZXJhbGx5IHVzZWZ1bCBmb3IgbXVsdGlw
bGUgcHVycG9zZXMsIHNvbWV0aGluZwo+IGxpa2UgYSBtbS9waHlzX2FsbG9jLmMuCj4KPiBGcmFu
ayB2YW4gZGVyIExpbmRlbiBtYXkgYWxzbyBoYXZlIHRob3VnaHRzIG9uIHRoZSBhYm92ZT8KPgo+
ID4gIC0gd2UgYWxzbyBuZWVkIHRoZSBhYmlsaXR5IHRvIGJlIGFibGUgdG8gZHluYW1pY2FsbHkg
cmVzaXplIHRoaXMgb3IKPiA+ICAgIHByb3ZpZGUgaGludHMgYXQgYWxsb2NhdGlvbiB0aW1lIHRo
YXQgbWVtb3J5IG11c3QgYmUgcGVyc2lzdGVkIGFjcm9zcwo+ID4gICAga2V4ZWMgdG8gc3VwcG9y
dCB0aGUgbm9uLWNsb3VkIHByb3ZpZGVyIHVzZSBjYXNlCj4gPgo+ID4gIC0gd2UgbmVlZCBhIGZp
bGVzeXN0ZW0gYWJzdHJhY3Rpb24gdGhhdCBtYXAgbWVtb3J5IG9mIHRoZSB0eXBlIHRoYXQgaXMK
PiA+ICAgIHJlcXVlc3RlZCwgaW5jbHVkaW5nIGd1ZXN0X21lbWZkIGFuZCB0aGVuIGRlYWwgd2l0
aCBhbGwgdGhlIGZ1biBvZgo+ID4gICAgbXVsdGl0ZW5hbmN5IHNpbmNlIGl0IHdvdWxkIGJlIGRy
YXdpbmcgZnJvbSBhIGZpbml0ZSBwZXItTlVNQSBub2RlCj4gPiAgICBwb29sIG9mIHBlcnNpc3Rl
bnQgbWVtb3J5Cj4gPgo+ID4gIC0gYWJzb2x1dGVseSBjcml0aWNhbCB0byB0aGlzIGRpc2N1c3Np
b24gaXMgZGVmaW5pbmcgd2hhdCBpcyB0aGUgY29yZQo+ID4gICAgaW5mcmFzdHJ1Y3R1cmUgdGhh
dCBpcyByZXF1aXJlZCBmb3IgYSBnZW5lcmFsbHkgYWNjZXB0YWJsZSBzb2x1dGlvbgo+ID4gICAg
YW5kIHRoZW4gd2hhdCBidWlsZHMgb2ZmIG9mIHRoYXQgdG8gYmUgbW9yZSBzcGVjaWFsIGNhc2Vk
IChsaWtlIHRoZQo+ID4gICAgY2xvdWQgcHJvdmlkZXIgdXNlIGNhc2Ugb3IgcGVyc2lzdGVudCB0
bXBmcyB1c2UgY2FzZSkKPiA+Cj4gPiBXZSdyZSBsb29raW5nIHRvIGNvbnRpbnVlIHRoYXQgZGlz
Y3Vzc2lvbiBoZXJlIGFuZCB0aGVuIGNvbWUgdG9nZXRoZXIKPiA+IGFnYWluIGluIGEgZmV3IHdl
ZWtzLgo+ID4KPgo+IFdlJ2xsIGJlIGxvb2tpbmcgdG8gc2NoZWR1bGUgc29tZSBtb3JlIHRpbWUg
dG8gdGFsayBhYm91dCB0aGlzIHRvcGljIGluCj4gdGhlIFdlZG5lc2RheSwgTm92ZW1iZXIgMTMg
aW5zdGFuY2Ugb2YgdGhlIExpbnV4IE1NIEFsaWdubWVudCBTZXNzaW9uLgo+Cj4gQWZ0ZXIgdGhh
dCwgSSB0aGluayBpdCB3b3VsZCBiZSBxdWl0ZSB1c2VmdWwgdG8gYnJlYWsgb3V0IHRoZSBzZXQg
b2YKPiBwZW9wbGUgdGhhdCBhcmUgaW50ZXJlc3RlZCBpbiBwZXJzaXN0aW5nIGd1ZXN0IG1lbW9y
eSBhY3Jvc3Mga2V4ZWMgYW5kIEtITwo+IGludG8gYSBzZXBhcmF0ZSBzZXJpZXMgdG8gYWNjZWxl
cmF0ZSBkaXNjdXNzaW9uIGFuZCBuZXh0IHN0cGVzLiAgR2V0dGluZwo+IHRoZSByZXF1aXJlbWVu
dHMgYW5kIGRlc2lnbiBsb2NrZWQgZG93biBhcmUgY3JpdGljYWwsIHNvIGhhcHB5IHRvCj4gZmFj
aWxpdGF0ZSB0aGF0IHRvIGFueSBleHRlbnQgcG9zc2libGUgYW5kIHdlbGNvbWUgZXZlcnlib2R5
IGludGVyZXN0ZWQgaW4KPiBkaXNjdXNzaW5nIGl0LgoKSSB0aGluayB0aGVyZSBpcyBhIG5pY2Ug
b3ZlcmxhcCBiZXR3ZWVuIHJlcXVpcmVtZW50cyBmb3IgdGhlIGd1ZXN0Cm1lbW9yeSBwZXJzaXN0
ZW5jZSBhbmQgZ3Vlc3RfbWVtZmQgMUcgcGFnZSBzdXBwb3J0IGZvcgpjb25maWRlbnRpYWwvbm9u
LWNvbmZpZGVudGlhbCBWTXMuIE1lbW9yeSBwZXJzaXN0ZW5jZSBvZiBndWVzdF9tZW1mZApiYWNr
ZWQgQ29DbyBWTXMgYW5kIEtITyB3aWxsIGJlIGEgY3JpdGljYWwgdXNlY2FzZSBmb3IgdXMgYXQg
R29vZ2xlIGFzCndlbGwsIHNvIEkgYW0gaW50ZXJlc3RlZCBpbiBmdXJ0aGVyIGRpc2N1c3Npb24g
aGVyZS4KClJlZ2FyZHMsClZpc2hhbAoKPgo+IEphbWVzLCBmb3IgdGhlIGd1ZXN0bWVtZnMgZGlz
Y3Vzc2lvbnMsIHdvdWxkIHRoaXMgd29yayBmb3IgeW91Pwo+Cj4gQWxleGFuZGVyLCBzYW1lIHF1
ZXN0aW9uIGZvciB5b3UgcmVnYXJkaW5nIHRoZSBLSE8gd29yaz8KPgo+IEl0J3MgYSBnbG9iYWwg
Y29tbXVuaXR5LCBzbyB0aGUgdGltaW5nIHdvbid0IHdvcmsgZm9yIGV2ZXlyYm9keS4gIFdlJ2QK
PiBwbGFuIG9uIHNlbmRpbmcgb3V0IHN1bW1hcmllcyBvZiB0aGVzZSBkaXNjdXNzaW9ucywgc3Vj
aCBhcyBpbiB0aGlzIGVtYWlsLAo+IHRvIHNvbGljaXQgZmVlZGJhY2sgYW5kIGlkZWFzIGZyb20g
ZXZlcnlib2R5Lgo+Cj4gSWYgeW91J3JlIG5vdCBvbiB0aGUgVG86IG9yIENjOiBsaXN0IGFscmVh
ZHksIHBsZWFzZSBlbWFpbCBtZSBzZXBhcmF0ZWwgaWYKPiB5b3UncmUgaW50ZXJlc3RlZCBpbiBw
YXJ0aWNpcGF0aW5nIGFuZCB0aGVuIHdlIGNhbiBmaW5kIGEgcmVndWxhciB0aW1lLgo+Cj4gVGhp
cyBpcyBleGNpdGluZyEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
