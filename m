Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBE7ECAAD4
	for <kexec@archiver.kernel.org>; Mon, 29 Aug 2022 09:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fXW4MQyPDEagUS/1FlPjhp2E+hwH+1CQwLz8+HNNaIs=; b=WUqboXCyAWrOSs
	KMaJuVANzmmO4DpPC2DuY4yW9GwEkchOyX+SnOrUE8ERhN72M6mZkOaSk50TlapNw3E72ehTQsmqR
	g8S0QSDINlhy6AgRvKUjZCJESTEPOfFp4JjMS/DIf+PgGv/aciYrtghqRf7MvP5/h25zXqS8ubOZD
	/rNNimiWwEaNJO1kk7bNCjpSp/IHVH//GgBXl8vgCfu6LzO2JsorHMD7FhNfsARsYoF0C9iolnMIA
	B+gMADWt9GMA0YWP3gJhU1t+XkfMzMS2mbHnxkUIsiBm4EYYqbUS/oZZavUwCn5n+N4Zc81Cpy7Yi
	tCkChTgFbuT6k2HsYc6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSb1P-006hqy-Oz; Mon, 29 Aug 2022 09:25:31 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSb1M-006hlb-6w
	for kexec@lists.infradead.org; Mon, 29 Aug 2022 09:25:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661765128; x=1693301128;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=6bjFxwLEsKLZFX2cLm7NlJwmIJ4DJEjhNXC6KOzn034=;
  b=VFPgyTs9MYGa29F8gbTYHb8Xmp/sykE1MPrLqzsAybkwLOW20gqJDTZC
   xOncLmdld+2GbauNv2j08hPN3tqYLo3iGc0oEQvrsAOAy/Ddi+c4ep5kw
   dB9e6ex3ojWmvGcfC2P9mWtykjiL8uFQt2OOtiK/nJbvkw6u8jFPxySgZ
   fc+kI8VWCqBaV85QX2fAU7MST8E55wh/pY7M4HhKaGDT0JFRzh9yW3ONy
   9732UC/1Ge4htHAbNBPv+NhXK+HeJXzpZMTXip3+apSQBecmWs/+PXyd/
   qq+xhMD8+5kqTJ6VZbI41J1cZIrZPbKv/WvUen2/XTICSKJbk76GdMsIU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="281823690"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="281823690"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 02:25:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="640869351"
Received: from idecesar-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.53.198])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 02:25:09 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Dave Young
 <dyoung@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, John Hubbard
 <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, kexec@lists.infradead.org, Andrew Morton
 <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, David Laight
 <David.Laight@aculab.com>, Jonathan Corbet <corbet@lwn.net>, Andy
 Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Dwaipayan
 Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Stephen
 Johnston <sjohnsto@redhat.com>, Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN()
 rules ("do not crash the kernel")
In-Reply-To: <CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220824163100.224449-1-david@redhat.com>
 <20220824163100.224449-2-david@redhat.com>
 <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com>
 <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
 <CALu+AoThhou7z+JCyv44AxGWDLDt2b7h0W6wcKRsJyLvSR1iQA@mail.gmail.com>
 <fe7aee66-d9f7-e472-a13f-e4c5aa176cca@redhat.com>
 <CALu+AoRwVfr=9KabOLUQigWwCtP5RLQ1YaKbG75ZVM9E-bW2ZQ@mail.gmail.com>
 <CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com>
Date: Mon, 29 Aug 2022 12:25:02 +0300
Message-ID: <87tu5vflld.fsf@intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_022528_452013_E0E52EF5 
X-CRM114-Status: GOOD (  10.10  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sun, 28 Aug 2022, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> So WARN_ON_ONCE() is the thing to aim for. BUG_ON() is the thing for
> "oops, I really don't know what to do, and I physically *cannot*
> continue" (and that is *not* "I'm too lazy to do error handling").

Any insight for the tradeoff between WARN_ON_ONCE() and WARN_ON(),
i.e. wasting the static once variable per use site vs. littering the
dmesg on every hit? I see there have been some improvements with the
__WARN_FLAGS() stuff, but is the data use really neglible?

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
