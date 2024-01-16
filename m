Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1147DC47077
	for <kexec@archiver.kernel.org>; Tue, 16 Jan 2024 10:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kziaRx7qQSc+VwfY+tNpfnw1IDXOLZk5d/BlskIJZEM=; b=OE0f9n4XDmO0ix
	VjyhtLYTCW5Coehdfk9yAbuOEA4lK0I5+n75DU7omkLqQEfyOf7BDVT9Jq5jdTXaDyzFwu72Q6cko
	XLpUOfBvw049EcOVzAChETaJNeB70QA/Vdd6a4X3SVTrzW7eIaQHcVp2O1hiIWR+tPOpFFaPTvvGd
	xJTosni0Umiw3piIpO9CRGHEncLiavgb7vklVlmCQr617oD8ZUL3l7KPiqyh94If4e1Ir+y/GExru
	W7D7eXL4xLlpfqVZmdkrw0k0UmogmWw18UKrPG19n8zPBxGbdNw0rcPED3j+d1vWlHWhNSbuCtqSb
	VAvviTc6x6yg68uTjhCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPgxH-00BhlY-0X;
	Tue, 16 Jan 2024 10:46:03 +0000
Received: from mgamail.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPgxE-00Bhjm-2B
	for kexec@lists.infradead.org;
	Tue, 16 Jan 2024 10:46:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705401960; x=1736937960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=U149l/P2gQncQeTKVFG2mholC+8inxIjrWVzckSmZk0=;
  b=ZYDyTRyea3ytm/2zfOa25QidsRMNegpEIGy/vMaFN1HscaywJkzg1DIp
   JiRYIm5FE34ofUQkML80FKwq21ZGr16qIh/hucy4K6PC+J7nx6vsARUWd
   OjmpfHbymN3aUyMjEWBPDMEOIqPYiQ1cOSVGXqmkkmucmgSqAU9BBO4FI
   NWOF8bUXiBl8OcKN2I4/7B6wZlyFJzlXltLrjEgFEV9Bn43YrGpC/N7XD
   IHWqhkNulY8CJwP/Qb+T9nYt6bM5vLH6xHnl9oGHJYBv5MsU9mYzioW/i
   aK6D+3A3vDq1WCntQ/CfrskRY05IjA/G4Q0F9609lt6YJg2PuwjdJJT1t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="399493510"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="399493510"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 02:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="787403940"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="787403940"
Received: from uschumac-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.254])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 02:45:51 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 7226210A17B; Tue, 16 Jan 2024 13:45:48 +0300 (+03)
Date: Tue, 16 Jan 2024 13:45:48 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20240116104548.4jmku5pq34p4lqn6@box.shutemov.name>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-11-kirill.shutemov@linux.intel.com>
 <89e8722b-661b-4319-8018-06705b366c62@suse.com>
 <20240116072822.pvzseyqry56eqa4j@box.shutemov.name>
 <bad09d97-d99b-4231-a481-c14ed0f8d59d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bad09d97-d99b-4231-a481-c14ed0f8d59d@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_024600_723176_E4CC876C 
X-CRM114-Status: GOOD (  17.44  )
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

T24gVHVlLCBKYW4gMTYsIDIwMjQgYXQgMTA6MDE6NDdBTSArMDIwMCwgTmlrb2xheSBCb3Jpc292
IHdyb3RlOgo+IAo+IAo+IE9uIDE2LjAxLjI0INCzLiA5OjI4INGHLiwgS2lyaWxsIEEuIFNodXRl
bW92IHdyb3RlOgo+IAo+IDxzbmlwPgo+IAo+ID4gPiA+IEBAIC00MSw2ICs0NCw5IEBACj4gPiA+
ID4gICAgc3RhdGljIGF0b21pY19sb25nX3QgbnJfc2hhcmVkOwo+ID4gPiA+ICtzdGF0aWMgYXRv
bWljX3QgY29udmVyc2lvbnNfaW5fcHJvZ3Jlc3M7Cj4gPiA+ID4gK3N0YXRpYyBib29sIGNvbnZl
cnNpb25fYWxsb3dlZCA9IHRydWU7Cj4gPiA+IAo+ID4gPiBHaXZlbiB0aGUgdXNhZ2UgbW9kZWwg
b2YgdGhpcyB2YXJpYWJsZSwgc2hvdWxkbid0IGl0IGJlIHNpbXBseSBhY2Nlc3NlZCB2aWEKPiA+
ID4gUkVBRC9XUklURV9PTkNFIG1hY3Jvcz8KPiA+IAo+ID4gV2hhdCBkbyB5b3Ugc2VlIGl0IGNo
YW5naW5nPwo+IAo+IAo+IFNlcnZpbmcgYXMgZG9jdW1lbnRhdGlvbiB0aGF0IHlvdSBhcmUgYWNj
ZXNzaW5nIGEgc2hhcmVkIHZhcmlhYmxlIHdpdGhvdXQgYW4KPiBleHBsaWNpdCBsb2NrICh1bmxl
c3MgSSdtIG1pc3Npbmcgc29tZXRoaW5nKS4gY29udmVyc2lvbl9hbGxvd2VkIGNhbiBiZSByZWFk
Cj4gYnkgbXVsdGlwbGUgdGhyZWFkcywgbm8gPyBBbmQgaXQncyB3cml0dGVuIGJ5IGEgc2luZ2xl
IHRocmVhZD8KCkkgZG9uJ3QgdGhpbmsgUkVBRF9PTkNFKCkvV1JJVEVfT05DRSgpIGhhdmUgZG9j
dW1lbnRhdGlvbiBzZW5zZSB5b3UgaW1wbHkuCgpJIHdvdWxkIGFyZ3VlIGFkZGluZyB0aGVtIHdp
bGwgYWRkIG1vcmUgY29uZnVzaW9uIGFzIHRoZXkgc2VydmUgbm8gcHVycG9zZQppbiB0aGlzIGNv
bnRleHQ6IGlzc3VpbmcgbXVsdGlwbGUgbG9hZHMvc3RvcmVzIGZvciB0aGUgdmFyaWFibGUgaGF2
ZSBubwppbXBhY3Qgb24gb3V0Y29tZS4KCj4gPiBrZXhlYyBvbiBBTUQgd2lsbCBub3Qgd29yayB3
aXRob3V0IHRoZW0sIEkgdGhpbmsuIEJ1dCBub29wcyBtYWtlcyBzZW5zZQo+ID4gYW55d2F5LiBX
aWxsIGZpeC4KPiAKPiBJJ20gbm90IGRpc3B1dGluZyB3aGV0aGVyIHRob3NlIGFyZSBuZWVkZWQg
Zm9yIEFNRCBvciBub3QsIHRoYXQgd2F5IEkgc2VlIGl0Cj4geW91IG1ha2UgdGhvc2UgY2FsbGJh
Y2tzIG1hbmRhdG9yeSBpbiB0aGUgY2FzZSBvZiBDQ19BVFRSX0dVRVNUX01FTV9FTkNSWVBUCj4g
YmVpbmcgcHJlc2VudCwgeWV0IG9ubHkgaW1wbGVtZW50IHRoZW0gZm9yIFREWC4gU28gaW4gdGhl
IGNhc2Ugb2YgQU1EIHRoZXkKPiB3aWxsIGJlIE5VTEwgYW5kIHNvIEFNRCB3aXRoIGtleGVjIGVu
YWJsZWQgKGFsYmVpdCBlcnJvbmVvdXNseSkgd2lsbCBjcmFzaCwKPiBubyA/CgpBcyBJIHNhaWQs
IEkgd2lsbCBmaXggaXQuCgotLSAKICBLaXJ5bCBTaHV0c2VtYXUgLyBLaXJpbGwgQS4gU2h1dGVt
b3YKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
