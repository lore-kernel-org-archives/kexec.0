Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5BEC46CD2
	for <kexec@archiver.kernel.org>; Tue, 30 Jan 2024 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hUsIIAtdLEV5GDrbtydjP1oSLjtvaweI8Dzci3ff3TE=; b=r7PetfW3Jamdx+
	fWBg5/epYl1PBUT7J+ZFbMIfd4JMciR/4LTYXctBlvaPBM5AR5rwih1B7pxv7qfTNfETOoDa2fD2l
	pxyjLgJ8baIDF7QZUyo2egg/8EnW8QTwDCoGHsRVKgq8wT1lvKN5JYcl6DAt7HDNtvke6potxYxva
	6oMNTHSmfA9k+ksa48GD7tvXXUgPpdksFyu6l7IwU+RBgWPlFJjbd4atk3KqGVWTMfmjVsqaswB3n
	CQEQesQ4EijhxwrQOUCeY69V4uSrrsgD74pJden2sMRHzy1hg5+EoLvYSBmmVUcNk8T7KsrRp5F1K
	fnbDyf56lpODYQ7A/bmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUppj-0000000H7m5-1lqP;
	Tue, 30 Jan 2024 15:15:31 +0000
Received: from mgamail.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUpph-0000000H7lB-0c90
	for kexec@lists.infradead.org;
	Tue, 30 Jan 2024 15:15:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706627729; x=1738163729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cg4Vqit6KxU2rQTAj377CjGsVM4isPa7zNpJYoTP4as=;
  b=A/LvQMKKosaoNYic0i05z2Ua9dRzxELSBlZrPPtYhlBI6ObUbKJwtbWe
   7g968SEiVYVy6x4yEhQDXp/FTF7YiGvOanusgEFMJLnz1Ey3yImJs9Tox
   2nDM6NlYUgBVzYLcLsmZDi50Gw+3NuLdnUCgDKjI28xfm5Fo6+y7AftmG
   n6lHXF7gToG6uCkctAGGg19NXk1M1k3j67YhQ+6y0VDd49Bku9Onlu8GE
   J+x08bbUaRtW2kUjAqr1Ic2YrgdcaeKIMC0CsOEi5+JqM/xZcxHY6TDEA
   TyNfqdJio/O6fv0BpITKbkUIHPKsqJQMvNsJy2dZhjKWwPcOckUKGFHFG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="434482024"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="434482024"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:15:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="737804714"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="737804714"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Jan 2024 07:15:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5FA15DE; Tue, 30 Jan 2024 17:15:21 +0200 (EET)
Date: Tue, 30 Jan 2024 17:15:21 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 00/16] x86/tdx: Add kexec support
Message-ID: <qj3arfigftoolcdptm2yzqwufs6ywp2snqme5wknkt3odkon45@h76u2hnrswlq>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
 <g7jh422ild6c23hjxvf7q2xtygkumbpynz4hcops7nvg5izvpp@r3oyhvssph2o>
 <CABgObfZiyx8hRsD37xZq5TNs9sRq48vLUxbOKa=HZ1vcr67sWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABgObfZiyx8hRsD37xZq5TNs9sRq48vLUxbOKa=HZ1vcr67sWQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_071529_271910_33705F28 
X-CRM114-Status: GOOD (  24.18  )
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

T24gVHVlLCBKYW4gMzAsIDIwMjQgYXQgMDM6NTk6MzRQTSArMDEwMCwgUGFvbG8gQm9uemluaSB3
cm90ZToKPiBPbiBUdWUsIEphbiAzMCwgMjAyNCBhdCAzOjM04oCvUE0gS2lyaWxsIEEuIFNodXRl
bW92Cj4gPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+IHdyb3RlOgo+ID4KPiA+IE9u
IFR1ZSwgSmFuIDMwLCAyMDI0IGF0IDAyOjQzOjE1UE0gKzAxMDAsIFBhb2xvIEJvbnppbmkgd3Jv
dGU6Cj4gPiA+IE9uIDEvMjQvMjQgMTM6NTUsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToKPiA+
ID4gPiBUaGUgcGF0Y2hzZXQgYWRkcyBiaXRzIGFuZCBwaWVjZXMgdG8gZ2V0IGtleGVjIChhbmQg
Y3Jhc2hrZXJuZWwpIHdvcmsgb24KPiA+ID4gPiBURFggZ3Vlc3QuCj4gPiA+ID4KPiA+ID4gPiBU
aGUgbGFzdCBwYXRjaCBpbXBsZW1lbnRzIENQVSBvZmZsaW5pbmcgYWNjb3JkaW5nIHRvIHRoZSBh
cHByb3ZlZCBBQ1BJCj4gPiA+ID4gc3BlYyBjaGFuZ2UgcG9wb3NhbFsxXS4gSXQgdW5sb2NrcyBr
ZXhlYyB3aXRoIGFsbCBDUFVzIHZpc2libGUgaW4gdGhlIHRhcmdldAo+ID4gPiA+IGtlcm5lbC4g
SXQgcmVxdWlyZXMgQklPUy1zaWRlIGVuYWJsaW5nLiBJZiBpdCBtaXNzaW5nIHdlIGZhbGxiYWNr
IHRvIGJvb3RpbmcKPiA+ID4gPiAybmQga2VybmVsIHdpdGggc2luZ2xlIENQVS4KPiA+ID4gPgo+
ID4gPiA+IFBsZWFzZSByZXZpZXcuIEkgd291bGQgYmUgZ2xhZCBmb3IgYW55IGZlZWRiYWNrLgo+
ID4gPgo+ID4gPiBIaSBLaXJpbGwsCj4gPiA+Cj4gPiA+IEkgaGF2ZSBhIHZlcnkgYmFzaWMgcXVl
c3Rpb246IGlzIHRoZXJlIGEgcmVhc29uIHdoeSB0aGlzIHNlcmllcyBkb2VzIG5vdAo+ID4gPiBy
ZXZlcnQgY29tbWl0IGNiOGViMDZkNTBmYywgIng4Ni92aXJ0L3RkeDogRGlzYWJsZSBURFggaG9z
dCBzdXBwb3J0IHdoZW4KPiA+ID4ga2V4ZWMgaXMgZW5hYmxlZCI/Cj4gPgo+ID4gTXkgcGF0Y2hz
ZXQgZW5hYmxlcyBrZXhlYyBmb3IgVERYIGd1ZXN0LiBUaGUgY29tbWl0IHlvdSByZWZlciBibG9j
a3Mga2V4ZWMKPiA+IGZvciBob3N0LiBURFggaG9zdCBhbmQgZ3Vlc3QgaGF2ZSB0b3RhbGx5IGRp
ZmZlcmVudCBwcm9ibGVtcyB3aXRoIGhhbmRsaW5nCj4gPiBrZXhlYy4gS2FpIGxvb2tzIG9uIGhv
dyB0byBnZXQgaG9zdCBrZXhlYyBmdW5jdGlvbmFsLgo+IAo+IFllYWgsIHRoYXQgd2FzIHJpZ2h0
IHRoZXJlIGluIHRoZSBjb3ZlciBsZXR0ZXIgKGFuZCBJIHNob3VsZCBoYXZlCj4gZ290dGVuIGEg
Y2x1ZSBmcm9tIHRoZSBtYW55IHJlZmVyZW5jZXMgdG8gQ0NfKiBjb25zdGFudHMuLi4pLiBTb21l
Ym9keQo+IHBvaW50ZWQgbWUgdG8gdGhpcyBzZXJpZXMgYXMgInRoZSBURFgga2V4ZWMgc2VyaWVz
IGZyb20gSW50ZWwiIGFuZCBJCj4gaGFkIHNvbWUgdHVubmVsIHZpc2lvbiBpc3N1ZXMuIFNvcnJ5
IGZvciB0aGUgbm9pc2UhCj4gCj4gQnV0IHNpbmNlIEkgaGF2ZSB5b3VyIGF0dGVudGlvbiwgZG8g
eW91IGhhdmUgYSBwb2ludGVyIHRvIHRoZQo+IGNvcnJlc3BvbmRpbmcgZWRrMiBzZXJpZXM/CgpS
ZWxldmFudCBjb2RlIGNhbiBiZSBmb3VuZCBoZXJlOgoKaHR0cHM6Ly9naXRodWIuY29tL3RpYW5v
Y29yZS9lZGsyLXN0YWdpbmcvY29tbWl0cy90ZHZmLWtleGVjLwoKLS0gCiAgS2lyeWwgU2h1dHNl
bWF1IC8gS2lyaWxsIEEuIFNodXRlbW92CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
