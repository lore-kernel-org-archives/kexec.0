Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9622D35E5D
	for <kexec@archiver.kernel.org>; Wed,  6 Nov 2024 02:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7xKQAn4uskNCruc+oNYyuXB8AhWIR3Y9hOfdkCJyUyc=; b=BRwrltDn3R3z7B
	XjdfzASQlCSQfSBwflVIz+KIcG+jYFQ7BhFrY6iHHA0W0NN8MWkyI+sjCAYVRPL63ik1CI77Rpeei
	Q/1yudFrGoCtQ4zRODCtcTQZ4SWBeFrWz9hRa+Fw+q8Wy9YrHGg2kO+XXlJJufflvHbmCXVJES/jW
	7hu7khCzaRXiNF7LLA5sa9YuI2yzyvnUtVdPIhA2SqQzpjTEHMtnxnlJuwH7KIpOATIDXB4IjnAOk
	L24eCX/MZRN7ddjM5kyen6N72YsEcIOhI/GDd+kwVlNyNddBmXqMmzuKPg2FPtY2XGNmqrrA4MCDF
	E/QJGySyc8n+mNkxSfUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8W5F-00000001ZfI-1TZv;
	Wed, 06 Nov 2024 02:47:49 +0000
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8W5C-00000001ZeE-3EX0
	for kexec@lists.infradead.org;
	Wed, 06 Nov 2024 02:47:47 +0000
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A62lG2M501413
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 Nov 2024 18:47:16 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A62lG2M501413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730861237;
	bh=pD3c1qN+3qwiiELhWPCeBpM9P+/1hDsGwN0sbnawkAw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=f7HjKbfGwKWB76QznpZbHstUDYwAQ7sHXv1EsCbVKJDvpo1EtgkY4z03HzpuJoefy
	 r/7O3Fz6/IPdl94CLHyLJLjWiftppLkqToC5Bv4aU+1FCp/UkaSL6jiXVqaOdYvLhw
	 jnahoLwkZnCx3v8bUpKLehbKtSXulSnUtRVTLwwOQQ7grW/c8BuKet+6tmfiY4wkRa
	 /zVEMY/iFxBRJIQlWis4cwSx//5246n7jnfi84EbQ6xWOUyCRfhjfpvWendsQs3dY3
	 jtT/JrtiBjeqMPpWmJ4Rhrzkba57F21PCSaEbPK1LRvRk4OTd+qfyZZR4asqt/NBzL
	 XpEgMGbxNJW/w==
Date: Tue, 05 Nov 2024 18:47:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Woodhouse <dwmw2@infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>
CC: "horms@kernel.org" <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kai.huang@intel.com" <kai.huang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_6/7=5D_x86/kexec=3A_Debuggi?=
 =?US-ASCII?Q?ng_support=3A_Dump_registers_on_exception?=
User-Agent: K-9 Mail for Android
In-Reply-To: <10f2dec7afbbff6570007495185ce1c4144e446b.camel@infradead.org>
References: <20241103054019.3795299-1-dwmw2@infradead.org> <20241103054019.3795299-7-dwmw2@infradead.org> <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk> <b66cd5ca-aae4-48eb-a0ba-2d1d4e53f810@zytor.com> <10f2dec7afbbff6570007495185ce1c4144e446b.camel@infradead.org>
Message-ID: <B4EBAF27-5E42-4088-9857-DBCD0D19305C@zytor.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_184746_837301_85E27A06 
X-CRM114-Status: GOOD (  20.82  )
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

T24gTm92ZW1iZXIgNSwgMjAyNCA2OjQzOjQ0IFBNIFBTVCwgRGF2aWQgV29vZGhvdXNlIDxkd213
MkBpbmZyYWRlYWQub3JnPiB3cm90ZToKPk9uIFR1ZSwgMjAyNC0xMS0wNSBhdCAxMzozNyAtMDgw
MCwgSC4gUGV0ZXIgQW52aW4gd3JvdGU6Cj4+IAo+PiBMb29raW5nIGF0IHlvdXIgY29kZSwgeW91
IGhhdmUgYSBtdWNoIGJpZ2dlciBwcm9ibGVtIGhlcmU6Cj4+IAo+PiArLyoKPj4gKyAqIFRoaXMg
YWxsb3dzIG90aGVyIHR5cGVzIG9mIHNlcmlhbCBwb3J0cyB0byBiZSB1c2VkLgo+PiArICrCoCAt
ICVhbDogQ2hhcmFjdGVyIHRvIGJlIHByaW50ZWQgKG5vIGNsb2JiZXIgJXJheCkKPj4gKyAqwqAg
LSAlcmR4OiBNTUlPIGFkZHJlc3Mgb3IgcG9ydC4KPj4gKyAqLwo+PiArLm1hY3JvIHByX2NoYXIK
Pj4gK8KgwqDCoMKgwqDCoCBvdXRiwqDCoMKgICVhbCwgJWR4Cj4+ICsuZW5kbQo+PiArCj4+IAo+
PiBUaGlzIHdpbGwgb3ZlcmZsb3cgeW91ciBVQVJUIGJ1ZmZlciB2ZXJ5IHF1aWNrbHkgc2luY2Ug
eW91IGFyZSBub3cgCj4+IGR1bXBpbmcgYSB3aG9sZSBidW5jaCBvZiBkYXRhLiBUaGUgVVJUIGJ1
ZmZlciAtLSBpZiB5b3UgZXZlbiBoYXZlIG9uZQo+PiBhbmQgaXQgaXMgZW5hYmxlZCAtLSBpcyBv
bmx5IDE2IGJ5dGVzIGluIGEgc3RhbmRhcmQgMTY1NTBBIFVBUlQuIEluIAo+PiBvbGRlciBVQVJU
cyAob3IgZW11bGF0ZWQgb2xkZXIgVUFSVHMpIHlvdSBtaWdodCBub3QgaGF2ZSBhIGJ1ZmZlciBh
dCAKPj4gYWxsLiBUbyBwcmludCBtb3JlIHRoYW4gYSBoYW5kZnVsIG9mIGJ5dGVzLCB5b3UgbmVl
ZCB0byBwb2xsIGZvciB0aGUgCj4+IFRIUkUgYml0PTEgKGJpdCA1IG9mIHJlZ2lzdGVyIDUpLgo+
Cj5FbXVsYXRlZCBVQVJUcyBhcmUgZ2VuZXJhbGx5IGZpbmUgYmVjYXVzZSB0aGV5IGRvbid0IHJl
YWxseSBlbXVsYXRlIHRoZQo+YnVmZmVyIGF0IGFsbC4gQW5kIHdoZW4gSSBvcmlnaW5hbGx5IHdy
b3RlIHRoaXMgaXQgd2FzIHB1cmVseSBhIGhhY2sgdG8KPmRlYnVnIGFuIGlzc3VlIGZvciBteXNl
bGYsIGFuZCB1c2VkIGEgZGlmZmVyZW50IHR5cGUgb2YgbG9nZ2luZyBkZXZpY2UKPmFsdG9nZXRo
ZXIuCj4KPkJ1dCB5ZWFoLCBpZiB0aGlzIHdlcmUgdG8gYmUgdXNlZCBvbiBiYXJlIG1ldGFsIDE2
NTUwQSBpdCB3b3VsZCBpbmRlZWQKPm5lZWQgdG8gd2FpdCBmb3Igc3BhY2UgaW4gdGhlIEZJRk8v
VEhSLgo+Cj4+IFdoYXQgaXMgdGhlIHBvaW50IG9mIHdyaXRpbmcgdGhpcyBjb2RlIGluIGFzc2Vt
Ymx5IGluIHRoZSBmaXJzdCBwbGFjZT8gQSAKPj4gbXVjaCBtb3JlIGxvZ2ljYWwgdGhpbmcgdG8g
ZG8gaXMgdG8ganVzdCBwdXNoIHRoZSByZWdpc3RlcnMgeW91IGhhdmVuJ3QgCj4+IHB1c2hlZCBh
bHJlYWR5IG9udG8gdGhlIHN0YWNrIGFuZCBjYWxsIGEgQyBmdW5jdGlvbiB0byBkbyB0aGUgYWN0
dWFsIAo+PiBkdW1waW5nPyBJdCBpc24ndCBsaWtlIGl0IGlzIGluIGFueSBzaGFwZSwgd2F5IG9y
IGZvcm0gcGVyZm9ybWFuY2UgY3JpdGljYWwuCj4KPklmIHdlIGZpeCBpdCB1cCB0byB1c2UgYSBw
cm9wZXIgbGlua2VyIHNjcmlwdCwgdGhhdCdzIHNsaWdodGx5IG1vcmUKPmZlYXNpYmxlLsKgQXMg
dGhpbmdzIHN0YW5kLCBpdCdzIG9ubHkgcmVhbGx5IHBvc3NpYmxlIHRvIGRvIGl0IGluIHRoZQo+
ZXhpc3RpbmcgYXNtIGZpbGUuIAo+Cj5BbmQgaXQncyBvbmx5IHRoZSBjb3JlIG9mIHRoZSBleGNl
cHRpb24gaGFuZGxlciAiZnVuY3Rpb24iIHdoaWNoIGNvdWxkCj5iZSBtb3ZlZCBvdXQgdG8gQzsg
aXQgZGlkbid0IHNlZW0gcGFydGljdWxhcmx5IHdvcnRoIGJvdGhlcmluZy4gV291bGQKPmJlIG5p
Y2UgdG8gaGF2ZSB0aGUgSURUIGdlbmVyYXRlZCBmcm9tIEMgY29kZSAqYmVmb3JlKiBjYWxsaW5n
Cj5yZWxvY2F0ZV9rZXJuZWwoKSBpbnN0ZWFkIG9mIGluc2lkZSByZWxvY2F0ZV9rZXJuZWwgaXRz
ZWxmLCBwZXJoYXBzLAo+YnV0IEkgd2FzIGFsc28gdHJ5aW5nIHRvIGtlZXAgdGhlICNkZWZpbmUg
REVCVUcgdmVyc2lvbiBvZiB0aGUgY29kZQo+ZmFpcmx5IHNlbGYtY29udGFpbmVkLgo+Cj4KClll
cywgdGhlIGxpbmtlciBzY3JpcHQgbmVlZHMgdG8gaGFwcGVuLiAKClRoaXMgaXMgYSBjYXNlIG9m
IGRvaW5nIGl0IHJpZ2h0IHZzIGRvaW5nIGl0IHF1aWNrbHkuCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
