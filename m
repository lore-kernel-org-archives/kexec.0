Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FAFC27C43
	for <kexec@archiver.kernel.org>; Wed, 29 May 2024 11:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ci/OsV7b4r7Cm4fCrb/GHe7pSoVTXZ115Tb4iotRSzE=; b=J/2WAVFoLTtcBa
	wvxSAwv6JWUW36Nlhz3Fnl2jRcbpV6qsDAt8RXlgOhKPuz1RR07CCiZmJOfLTOygiVIK9yxu3+fKo
	el+sjphIBdj7oejxjyHkV2wDYvaqtIb0QzgC63Wf1Ubf2LwBr5WKA+syQySf2tANRnMJD1fjKkalk
	vxl3GsE6aV1uDM7JYus1ijcY55esPPwHx4fGQ+HiRXxysVGjuGFUlXoFnwni2uoklF31OKIHIY/C2
	ikObd4vGTsFP0LqlzyQ0Ds3ho2ni6z9fJIMmcCy/7Dqhw/6UpISqNAPW1y+6V6X9whd+dPfmcPaDs
	vch0qa/uYzLZFBrVqhtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCHJN-00000003vBH-41ey;
	Wed, 29 May 2024 11:17:41 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCHJK-00000003v9n-3SEQ
	for kexec@lists.infradead.org;
	Wed, 29 May 2024 11:17:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716981458; x=1748517458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3SX+KJOmxPem9SO7R72o7juGuVC2oqAj0VD9rc9VaoM=;
  b=L0tjEdwL85J8CunwnnYYybj41fFjE6jO0ZXwhBiOU0VCk8fTN29JTl33
   BedTBY+tvMIn5jXhLfgMcl5qaHPr0uE8rxBHyzzdRZOjOsZTY6+xi8lRW
   nHCPGQGmVpFTD3hribqCwKYD29k7HlxAAKdBWKNNvTNdpdntS0veG3UYH
   ngoFJLdNyltrdjRpJgJFNxfby9lRNycEujrddlr33Tr0L67/yqCzHRqlK
   JX9Qx5A2LaCA7EoyuspKKIP/sE1ZAKDJoNLJisgqLdgnMbe5CBDWNSLHI
   DBdmnahfgiBzDZL+AzktUfjkT7F174Or464OurAkVzgeBY31eZWETghb+
   w==;
X-CSE-ConnectionGUID: ijWnCv9uQH6q7hJjcnU1Rw==
X-CSE-MsgGUID: XLd+ZrsIQt+0qKGfO35uBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13498243"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13498243"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 04:17:37 -0700
X-CSE-ConnectionGUID: O37lca9aTrCOFhvDkx9QKg==
X-CSE-MsgGUID: ezCnHFvXRqiqHhF2kf5l6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35874174"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 May 2024 04:17:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id CA79320F; Wed, 29 May 2024 14:17:29 +0300 (EEST)
Date: Wed, 29 May 2024 14:17:29 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
Message-ID: <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_041738_954862_BA30E1C5 
X-CRM114-Status: GOOD (  16.54  )
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

T24gV2VkLCBNYXkgMjksIDIwMjQgYXQgMDE6NDc6NTBQTSArMDMwMCwgTmlrb2xheSBCb3Jpc292
IHdyb3RlOgo+IAo+IAo+IE9uIDI4LjA1LjI0INCzLiAxMjo1NSDRhy4sIEtpcmlsbCBBLiBTaHV0
ZW1vdiB3cm90ZToKPiA+IEZyb206IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPgo+ID4g
Cj4gPiBUaGF0IGlkZW50aXR5X21hcHBlZCgpIGZ1bmN0aW9ucyB3YXMgbG92aW5nIHRoYXQgIjEi
IGxhYmVsIHRvIHRoZSBwb2ludAo+ID4gb2YgY29tcGxldGVseSBjb25mdXNpbmcgaXRzIHJlYWRl
cnMuCj4gPiAKPiA+IFVzZSBuYW1lZCBsYWJlbHMgaW4gZWFjaCBwbGFjZSBmb3IgY2xhcml0eS4K
PiA+IAo+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2VzLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBC
b3Jpc2xhdiBQZXRrb3YgKEFNRCkgPGJwQGFsaWVuOC5kZT4KPiA+IFNpZ25lZC1vZmYtYnk6IEtp
cmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4KPiA+IC0t
LQo+ID4gICBhcmNoL3g4Ni9rZXJuZWwvcmVsb2NhdGVfa2VybmVsXzY0LlMgfCAxMyArKysrKysr
LS0tLS0tCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvcmVsb2NhdGVfa2VybmVs
XzY0LlMgYi9hcmNoL3g4Ni9rZXJuZWwvcmVsb2NhdGVfa2VybmVsXzY0LlMKPiA+IGluZGV4IDU2
Y2FiMWJiMjVmNS4uMDg1ZWVmNWMzOTA0IDEwMDY0NAo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVs
L3JlbG9jYXRlX2tlcm5lbF82NC5TCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvcmVsb2NhdGVf
a2VybmVsXzY0LlMKPiA+IEBAIC0xNDgsOSArMTQ4LDEwIEBAIFNZTV9DT0RFX1NUQVJUX0xPQ0FM
X05PQUxJR04oaWRlbnRpdHlfbWFwcGVkKQo+ID4gICAJICovCj4gPiAgIAltb3ZsCSRYODZfQ1I0
X1BBRSwgJWVheAo+ID4gICAJdGVzdHEJJFg4Nl9DUjRfTEE1NywgJXIxMwo+ID4gLQlqegkxZgo+
ID4gKwlqegkuTG5vX2xhNTcKPiA+ICAgCW9ybAkkWDg2X0NSNF9MQTU3LCAlZWF4Cj4gPiAtMToK
PiA+ICsuTG5vX2xhNTc6Cj4gPiArCj4gPiAgIAltb3ZxCSVyYXgsICVjcjQKPiA+ICAgCWptcCAx
Zgo+IAo+IFRoYXQgam1wIDFmIGJlY29tZXMgcmVkdW5kYW50IG5vdyBhcyBpdCBzaW1wbHkganVt
cHMgMSBsaW5lIGJlbG93Lgo+IAoKTm90aGluZyBjaGFuZ2VkIHdydCB0aGlzIGp1bXAuIEl0IGRh
dGVzIGJhY2sgdG8gaW5pdGlhbCBrZXhlYwppbXBsZW1lbnRhdGlvbi4KClNlZSA1MjM0ZjVlYjA0
YWIgKCJbUEFUQ0hdIGtleGVjOiB4ODZfNjQga2V4ZWMgaW1wbGVtZW50YXRpb24iKS4KCkJ1dCBJ
IGRvbid0IHNlZSBmdW5jdGlvbmFsIG5lZWQgaW4gaXQuCgpBbnl3YXksIGl0IGlzIG91dHNpZGUg
b2YgdGhlIHNjb3BlIG9mIHRoZSBwYXRjaC4KCi0tIAogIEtpcnlsIFNodXRzZW1hdSAvIEtpcmls
bCBBLiBTaHV0ZW1vdgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
