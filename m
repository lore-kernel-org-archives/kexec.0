Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E55CAC598
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 12:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6tr2LlqeFB6hD9iMXwFSFB1+YLZ+2W4/0LTJuQB0NjE=; b=IgMocHH1XOHlPFDPfsz0ZcUEUO
	JG2OctB4LDwdM3tB8VBmDcFRi/bbMe7RfAchMKBov3GmTCQFDJYewgQ+M3F6ewYunzxjlu/FrULcz
	L9N9nARKFSX3zvVBYCK3s5LotPixdaDksjWUbjo7V+7Yqi7b2/1jCrPSvyKWI1TKHxUhznd5n3T6s
	E/wZDGw6jBjV9RcB1SImtNKrJD9JL7ND8LGkHjA0ZMkWzWCOd9nTAyE8YcbKqVKNd0aUQSN1uivjE
	72gGrG6sNNOHrlQl1xKkpdpEqMtAsuAm47IUim4laZrTJa1nixwaUk8wp4pA1eief4x+oWxMaqG2M
	ExFfO1Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyV94-00000007pY3-2pD9;
	Tue, 16 Sep 2025 12:50:54 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyV92-00000007pXk-0olZ
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 12:50:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758027052; x=1789563052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VxM/cdUE+MegHutCDt81ETLB7ynUxqJX6Yz1kpPrbhQ=;
  b=QKFi9y/IZCnZk8q0oWq+8NfeA0S4PyEAQ6M+q5OZNY9rZGWhhU4AeIEb
   aQroAXyhAxl14agqolBioqoYwVOcOw4G3rhr6fQUKitULio9+JzvjNShF
   WxnXFbMFeL9hMq9n5L6KlaF+kd4TsJJ2x86Ta24AqUoQl54VnooZjKOsa
   sP4kJflZ8Qe72VQRRuSnBhp4Enr5mXj3RLKKMmVimMKH1M2W/QJ4t66rQ
   /FJO+NqMrA63xLZkz+mudp0n5KtZbWYAtF+opBouYm+7oJunoUOJZZqBZ
   9Ihx3qcfzM1ZYE5oW1x0U7s1j50kGbk4HvD24H6RW8y5L0axABO263U3O
   A==;
X-CSE-ConnectionGUID: SD9uejgDS0STcIWO1QNi4A==
X-CSE-MsgGUID: ZKnFFBG4TJi9+4BIbqOenw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="85742568"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="85742568"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:50:52 -0700
X-CSE-ConnectionGUID: Sfghzwj2RRG2AEz6CPxh+w==
X-CSE-MsgGUID: dr1e4I5gRCGdNtLcOWHJew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174044636"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:50:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uyV8u-00000003WoJ-2sRO;
	Tue, 16 Sep 2025 15:50:44 +0300
Date: Tue, 16 Sep 2025 15:50:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, grom@black.igk.intel.com,
	07110bfd5785d3bff71cebd710db42d6f5c4a643@black.igk.intel.com,
	Mon@black.igk.intel.com, Sep@black.igk.intel.com,
	17@black.igk.intel.com, 2001@black.igk.intel.com
Subject: Re: From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <aMldJJktQVvkcMub@smile.fi.intel.com>
References: <20250916123048.3058824-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916123048.3058824-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_055052_242419_6900A63E 
X-CRM114-Status: UNSURE (   5.65  )
X-CRM114-Notice: Please train this message.
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

On Tue, Sep 16, 2025 at 02:29:49PM +0200, Andy Shevchenko wrote:

My gosh, the Subject is mangled, sorry, I resend it ASAP after double checking
it's fine looking.

-- 
With Best Regards,
Andy Shevchenko



