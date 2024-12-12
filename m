Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B260E7717F
	for <kexec@archiver.kernel.org>; Thu, 12 Dec 2024 21:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:
	Cc:To:Subject:MIME-Version:Date:Message-ID:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VMZNo7NPmWsGKF5GF5JCY/SKxwxdIEXrloUvJJEJyuU=; b=QdgkYwYt6yBGMu1KqWvw/zHlL/
	9ozzRrkHjyvvh8M7hk/73Yr11wgKyz64Y0RC8jj3Tp7tQ6aelFMuXIRvl12BC1ooSlSBwzndpfNo1
	w78xeFyVVmrLLkNZD0OZVkj93lLgASuxQwroO/MFDcYauMkMlV9mb6KttZ4ASIxljikGE1sDO4YDy
	GbnB27B4pqfV0PeKJ8QI1suMdM2UcDwfQcypQoHSrotKfAA2QMpowkR0FU6pME38YUTFxwKIN7uQ0
	qWBdWNnQLSv1A7UFCBoqnkEHvkr2FM/xdXMCdtd8c9MXm8wzjpbtPERxPvJ7xOAR6X3O3QL8IjBJS
	YR5c8m4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLqZj-00000001vxA-3G9k;
	Thu, 12 Dec 2024 21:18:23 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLqZg-00000001vwX-3Rno
	for kexec@lists.infradead.org;
	Thu, 12 Dec 2024 21:18:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734038301; x=1765574301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=f5ACnRexztK7l9ld99nnyP9ovl7Hc7HhsC6nVgy4KoY=;
  b=gJVp+wdAhiCRODrMmI3Rm5Psi8OKUg3JF68LPoGTx96tuYLYMYgKwjQb
   1wUmtMLvrZoiSa4zOyJPEMLiqSvjMAV1+ZD0b6A5qEMLki3tJNYkYSQhm
   Xh4XZ7PBTUbM5tAHV6yOenI8zkt+7wSJbNcWUYkimNMKWw0sWw/RVMyV2
   qwq6Bz1xjqnIHDXnX7PoJQsq5YKDje3K+UDYnX0x7dvDxzP8WHDbbNwBf
   a+jQB9bpdEr8JmNDXjGwlW3n2X7/gd7+qYH9xltAfQXJUWSnQlTVvhaMF
   4bhJPr0rGqUkDaYQwIhJSyIs2lv+cOO+xY84lnK7LMETfsKNBi/vUpa40
   A==;
X-CSE-ConnectionGUID: 4PcLmhMFRIa71XF4WKEM3w==
X-CSE-MsgGUID: R5h4iuqXTUiVgbEjDDkMAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="33784146"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="33784146"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 13:18:20 -0800
X-CSE-ConnectionGUID: uS/bY5rLQAi0T4BJtOq2gA==
X-CSE-MsgGUID: H85enkTyQ6aRaXBgOeRBOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="101375786"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO [10.124.223.26]) ([10.124.223.26])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 13:18:19 -0800
Content-Type: multipart/mixed; boundary="------------OxHzUR6N6tQ0toSbMptMxSQY"
Message-ID: <4517cb69-3c5c-4e75-8a14-dab136b29c19@intel.com>
Date: Thu, 12 Dec 2024 13:18:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kexec: Only write through identity mapping of control
 page
To: David Woodhouse <dwmw2@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>
Cc: "Ning, Hongyu" <hongyu.ning@linux.intel.com>, kexec@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-14-dwmw2@infradead.org>
 <20241212014418.GA532802@ax162>
 <10a4058d9a667ca7aef7e1862375c2da84ef53a3.camel@infradead.org>
 <20241212150408.GA542727@ax162>
 <38aaf87162d10c79b3d3ecae38df99e89ad16fce.camel@infradead.org>
 <20241212174243.GA2149156@ax162>
 <9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_131820_876656_72F576BB 
X-CRM114-Status: GOOD (  12.39  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

This is a multi-part message in MIME format.
--------------OxHzUR6N6tQ0toSbMptMxSQY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 12:11, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The virtual mapping of the control page may have been _PAGE_GLOBAL and
> thus its PTE might not have been flushed on the %cr3 switch and it might
> effectively still be read-only. Move the writes to it down into the
> identity_mapped() function where the same %rip-relative addressing will
> get the new mapping.
> 
> The stack is fine, as that's using the identity mapped address anyway.

Shouldn't we also ensure that Global entries don't bite anyone else?
Something like the completely untested attached patch?
--------------OxHzUR6N6tQ0toSbMptMxSQY
Content-Type: text/x-patch; charset=UTF-8; name="pge.patch"
Content-Disposition: attachment; filename="pge.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxfNjQuUyBiL2Fy
Y2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxfNjQuUwppbmRleCBlOWU4OGMzNDJmNzUy
Li5lY2JkNzdhYWIxMjIxIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvcmVsb2NhdGVf
a2VybmVsXzY0LlMKKysrIGIvYXJjaC94ODYva2VybmVsL3JlbG9jYXRlX2tlcm5lbF82NC5T
CkBAIC0xNTUsNiArMTU1LDggQEAgU1lNX0NPREVfU1RBUlRfTE9DQUxfTk9BTElHTihpZGVu
dGl0eV9tYXBwZWQpCiAJICovCiAJYW5kbAkkKFg4Nl9DUjRfUEFFIHwgWDg2X0NSNF9MQTU3
KSwgJXIxM2QKIAlBTFRFUk5BVElWRSAiIiwgX19zdHJpbmdpZnkob3JsICRYODZfQ1I0X01D
RSwgJXIxM2QpLCBYODZfRkVBVFVSRV9URFhfR1VFU1QKKwkvKiBJbnZhbGlkYXRlIEdsb2Jh
bCBlbnRyaWVzIGZyb20gdGhlIFRMQjogKi8KKwlhbmRxCSR+KFg4Nl9DUjBfUEdFKSwgJXIx
M2QKIAltb3ZxCSVyMTMsICVjcjQKIAogCS8qIEZsdXNoIHRoZSBUTEIgKG5lZWRlZD8pICov
Cg==

--------------OxHzUR6N6tQ0toSbMptMxSQY--

