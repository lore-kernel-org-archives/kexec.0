Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11F5E732FE
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1I9ubz3P64SExOC4F1njor5xuB6Jdp4KhUahWsU0DCk=; b=P3ZJ+yvDx5zTC2
	45P44VYJHopmheERbVxurHfGjDIOl3VixKQB6IX8f6bOaRSUGrBDZwZUMSJZixDr814W9UP2L54Bf
	8nlHVUTf9FSVTnlqMA8NSwthBADe/9Wss2JzECnNP9ryDLivfKqr9awr+GGD4PqJL1eezAuOXdTHz
	2v62bPNoSURDuq+vm0y26XbfVPhS2x8JTDwViKiXvt50QHM1CDq4wwwlvaHvE6g3LpHWbrDntefWE
	WMNnXluP+zwUhUs/MtAyFqwEBdzzN9IOMDOwFwruOUz9VSgDLAp7bJhqgMGgGrkhs41/yGmND1yO/
	fY+DvU8D83rSxOkMY08g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qluxi-006RbM-0d;
	Thu, 28 Sep 2023 17:38:06 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qluxd-006RZZ-2w
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 17:38:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695922681; x=1727458681;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vUYvjPlgFPXD0fht4ZgNaZaIp5jz+/28FbQ6ukEjL3g=;
  b=NtQYw9eO7Eay8afcUWfvSWi5W/IVYJXy7TD2HncZpVuNUOFd0/OsuCPF
   LfcSb1PO2EjKVeWOVVqLBUsSMPK0+syyA5IO+WaPxSGEqiqjJ9iP+neH+
   qt0iyp/xx3KWhRvE3Nk6yKFOV1qCx1uq11VvL7FfvbhKhRBrVnLO4wcht
   KlQLvyaS1uzPD8xTIEjtp2BSeMen5ZULVfJz9pOe5HAWCRnjMVmEEDGXu
   vBZemmEHIaL2NAYFtWcWUjE0KGfYXFyZoaBZ5BlNNah/MDw7lfNWDp2ML
   SuyjM40mXffWMUdungjgmigNR35S3zrZC7bHi1j5/kiPsFR1LKvZhrIi8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="448618134"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="448618134"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:37:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="699365408"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="699365408"
Received: from jveerasa-mobl.amr.corp.intel.com (HELO [10.255.231.134]) ([10.255.231.134])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:37:56 -0700
Message-ID: <f0f68a16-9bf2-703a-345f-5061e821e80a@intel.com>
Date: Thu, 28 Sep 2023 10:37:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Baoquan He <bhe@redhat.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv> <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <fa924c8d-c954-5612-37eb-43e1976a1b7b@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <fa924c8d-c954-5612-37eb-43e1976a1b7b@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_103802_001330_48A94B69 
X-CRM114-Status: GOOD (  10.33  )
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

T24gOS8yOC8yMyAxMDozNSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6Cj4gT24gMjguMDkuMjMg
MTU6MjIsIERhdmUgSGFuc2VuIHdyb3RlOgo+PiBPbiA5LzI3LzIzIDA5OjEzLCBTdGFuaXNsYXYg
S2luc2J1cnNraWkgd3JvdGU6Cj4+PiBPbmNlIGRlcG9zaXRlZCwgdGhlc2UgcGFnZXMgY2FuJ3Qg
YmUgYWNjZXNzZWQgYnkgTGludXggYW55bW9yZSBhbmQgdGh1cwo+Pj4gbXVzdCBiZSBwcmVzZXJ2
ZWQgaW4gInVzZWQiIHN0YXRlIGFjcm9zcyBrZXhlYywgYXMgaHlwZXJ2aXNvciBzdGF0ZSBpcwo+
Pj4gdW53YXJlIG9mIGtleGVjLgo+Pgo+PiBJZiBMaW51eCBjYW4ndCBhY2Nlc3MgdGhlbSwgdGhl
eSdyZSBub3QgUkFNIGFueSBtb3JlLsKgIEknZCBtdWNoIHJhdGhlcgo+PiByZW1vdmUgdGhlbSBm
cm9tIHRoZSBtZW1vcnkgbWFwIGFuZCBtb3ZlIG9uIHdpdGggbGlmZSByYXRoZXIgdGhhbgo+PiBp
bXBsZW1lbnQgYSBidW5jaCBvZiBuZXcgQUJJIHRoYXQncyBnb3QgdG8gYmUgaGFuZGVkIGFjcm9z
cyBrZXJuZWxzLgo+IAo+IFRoZSBtb3RpdmF0aW9uIG9mIGhhbmRsaW5nIGtleGVjIChmYXN0ZXI/
KSBpbiBhIGh5cGVyLXYgZG9tYWluIGRvZXNuJ3QKPiBzb3VuZCBwYXJ0aWN1bGFybHkgY29tcGVs
bGluZyBnb3QgbWUgZm9yIHN1Y2ggZmVhdHVyZXMuIElmIHlvdSBpbmZsYXRlZAo+IG1lbW9yeSwg
anVzdCBkb24ndCBhbGxvdyB0byBrZXhlYy4gSXQncyBiZWVuIGJyb2tlbiBmb3IgeWVhcnMgSUlV
Qy4KClRoYXQncyBhIGdvb2QgcG9pbnQuICBXaGF0IHByZXZlbnRzIGRlZmxhdGluZyBiZWZvcmUg
a2V4ZWM/CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
ZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
