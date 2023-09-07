Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF1DEC873D
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 15:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MMU8mt/Eg8Yrqjv3i3ORIz/Zo6pSOeBlCGlfPDVUHvY=; b=mznN86n+WxR/KH
	z/x3btvRc2+BQAq3UnXMyBM1inOgzukLx6MBajQlbK3kLnvtQxzjLdODYgMqOO7Y+1UlE33wBVydF
	T6aATDfTsrE8T8RTpcAOkL5LMZv09Gfg6oXZEEIYi4D4FAjnQgc69V7zGKsU2tfESd8kQm06CO5kQ
	iwaAxG5ammeGnobD7c9sqe0Jbq/yybX6POnFpJ4D0HUNzd8xzG+Dl0fGAL4dKafIF3J7UaySf6fLJ
	BcHNQ65wkWUI0y+q73aR9TBvYq/18GLHp7ihmamDuJ+rO60175feWhZlmgt/LcK6tA1vazJ5dClt4
	cyXVZOZZHgCTS+WD8NPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeHI0-00CKj8-2y;
	Thu, 07 Sep 2023 15:51:28 +0000
Received: from mgamail.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeHHy-00CKiE-0K
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 15:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694101886; x=1725637886;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6EsGUJGhX1zT+Uyl+vPXWvJ0hitAvo76hypLco20y4Y=;
  b=eQzq+RuxCvmYs5gwVa0CmmuEn6yIa/PyxstvRIhlNdG+Xq/KRDlb25h+
   FbrxDiwfEDgIOmMcP+yH51LU/A90/Wk/w6mXj/pv2FIjM//mhHgIOBIgf
   bkoK+cCHlIPibWfJYP+cmVUNfNEr4P7MqE4BRFaaLyILHWIUlcWrQ09Dn
   TXliaHy7A9Q74ZZY12brulsYj3LZIEl7V3/dthqK86SUrgfB2X9IsVHXV
   /RJ4agUQ+V5SL8mnp0XcEqPo1qLm6ab6rAxsWrc8Y7xzsY/eTQ++iw5pM
   5Wd5hSdixKn56OgiKZrAAAhBiCh4iDlJ8I/grRsGz41osIwqDgYy5YzjE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="408388050"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="408388050"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="915793424"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="915793424"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:51:06 -0700
Message-ID: <5a188bb6-add4-0522-069f-18fbd34aff16@intel.com>
Date: Thu, 7 Sep 2023 08:51:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] proc/vmcore: Do not map unaccepted memory
Content-Language: en-US
To: Adrian Hunter <adrian.hunter@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@linux.ibm.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-2-adrian.hunter@intel.com>
 <21bf2e44-3316-2372-44cb-1488f88650f5@intel.com>
 <30d0cebb-13f9-572e-9baa-b7450fec9108@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <30d0cebb-13f9-572e-9baa-b7450fec9108@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_085126_164730_5C499F43 
X-CRM114-Status: GOOD (  10.58  )
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

T24gOS83LzIzIDA4OjQ0LCBBZHJpYW4gSHVudGVyIHdyb3RlOgo+IE9uIDcvMDkvMjMgMTg6Mzks
IERhdmUgSGFuc2VuIHdyb3RlOgo+PiBPbiA5LzYvMjMgMDA6MzksIEFkcmlhbiBIdW50ZXIgd3Jv
dGU6Cj4+PiBAQCAtNTU5LDcgKzU2Nyw4IEBAIHN0YXRpYyBpbnQgdm1jb3JlX3JlbWFwX29sZG1l
bV9wZm4oc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCj4+PiAgCSAqIHBhZ2VzIHdpdGhvdXQg
YSByZWFzb24uCj4+PiAgCSAqLwo+Pj4gIAlpZHggPSBzcmN1X3JlYWRfbG9jaygmdm1jb3JlX2Ni
X3NyY3UpOwo+Pj4gLQlpZiAoIWxpc3RfZW1wdHkoJnZtY29yZV9jYl9saXN0KSkKPj4+ICsJaWYg
KCFsaXN0X2VtcHR5KCZ2bWNvcmVfY2JfbGlzdCkgfHwKPj4+ICsJICAgIHJhbmdlX2NvbnRhaW5z
X3VuYWNjZXB0ZWRfbWVtb3J5KHBhZGRyLCBwYWRkciArIHNpemUpKQo+Pj4gIAkJcmV0ID0gcmVt
YXBfb2xkbWVtX3Bmbl9jaGVja2VkKHZtYSwgZnJvbSwgcGZuLCBzaXplLCBwcm90KTsKPj4+ICAJ
ZWxzZQo+Pj4gIAkJcmV0ID0gcmVtYXBfb2xkbWVtX3Bmbl9yYW5nZSh2bWEsIGZyb20sIHBmbiwg
c2l6ZSwgcHJvdCk7Cj4+IFRoZSB3aG9sZSBjYWxsYmFjayBtZWNoYW5pc20gd2hpY2ggZnMvcHJv
Yy92bWNvcmUuYzo6cGZuX2lzX3JhbSgpCj4+IGltcGxlbWVudHMgc2VlbXMgdG8gYmUgaW4gcGxh
Y2UgdG8gZW5zdXJlIHRoYXQgdGhlcmUgYXJlbid0IGEgYmlsbGlvbgo+PiBkaWZmZXJlbnQgInJh
bSIgY2hlY2tzIGluIGhlcmUuCj4+Cj4+IElzIHRoZXJlIGEgcmVhc29uIHlvdSBjYW4ndCByZWdp
c3Rlcl92bWNvcmVfY2IoKSBhIGNhbGxiYWNrIHRvIGNoZWNrIGZvcgo+PiB1bmFjY2VwdGVkIG1l
bW9yeT8KPiBTb21lb25lIGFza2VkIGZvciB0aGUgY2hhbmdlIHRvIGJlIGluIGFyY2gtaW5kZXBl
bmRlbnQgY29kZS4uLiDwn5iJCgpUaGF0IGRvZXNuJ3QgcmVhbGx5IGFuc3dlciBteSBxdWVzdGlv
bi4gIHZpcnRpb19tZW1faW5pdF9rZHVtcCgpLCBmb3IKaW5zdGFuY2UsIGlzIGluIGFyY2gtaW5k
ZXBlbmRlbnQgY29kZS4KCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
