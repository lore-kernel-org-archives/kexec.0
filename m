Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D2AC44515
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 09:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+vMw6oQSjwCJ5PIW/dE/nzx2Fukiu125+N1BT8qG1GI=; b=k/J2svw0p9MqDro+ncO8FwwHSP
	MQYsFEnwpQAtiYJYqgKlsrO8eTAvGJrzzvCGStRPGRTQXc0yuqkwalcR/Dj/JBtleaScXrxo+cgCY
	lGqah+b9uOcOYjDdE04IvuNN28qLma0WbbU7fW71L06JdfUYR+41++1QhtlcuZKe/mWVSZe//c65i
	+eerK0pMPcFR1f4to7lEXzJCvh/dVHXzZfUAZt/HDXRtNOqSnY9TmY4QckKGXGvl66z5Zc4Q28dP7
	Dk6oQhqSFOegmn+OODzk0vyzdmk2EMBOlw086f/RYALdwRDdZUFfF7WhqNMxj90XqLE6Ut77hNbDf
	yJbgTDAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlkF3-00000006IWd-0T4N;
	Mon, 20 Jul 2026 09:24:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlkF2-00000006IWF-0LDO
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 09:24:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3E93D60103;
	Mon, 20 Jul 2026 09:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9FF1F000E9;
	Mon, 20 Jul 2026 09:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784539491;
	bh=+vMw6oQSjwCJ5PIW/dE/nzx2Fukiu125+N1BT8qG1GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=au+ndke4RcxmDotkFio4JCXl9Z+jkRc0QcJmANfcBFzxNPh1RhJXb2nNVSEpRgtbo
	 zdU2K6Ysq10IIti0fNYZx4FHhhWZCKaaCUlazaHSdkG4F265iZJT+cJMg8lSVbP/ga
	 cRAqZ53ad30d23Vh7qZa8ezDfa9vBCwUxRvke7aan47J+HOFRFSSRBVG//4HK8qItn
	 c0fkwCmQyvCy3VG+LZAGXUG5StCVg2ZgPZH1KToj8Yc5wYhj1VJVG0nC1F/51lOyWQ
	 sCuPmCZsj2cKjqkAkomfi+gg0ylJaD4HJtqgxTz5yhe4E9YvkcCHGWVF0pRm1T4rr+
	 Mw/G8YAFOA9BA==
Date: Mon, 20 Jul 2026 10:24:48 +0100
From: Simon Horman <horms@kernel.org>
To: Pnina Feder <pnina.feder@mobileye.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH 02/10] util_lib: Add vmcoreinfo parser and memory reader
Message-ID: <20260720092448.GC1736709@horms.kernel.org>
References: <20260622205550.1087163-1-pnina.feder@mobileye.com>
 <20260622205550.1087163-3-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622205550.1087163-3-pnina.feder@mobileye.com>
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

On Mon, Jun 22, 2026 at 11:54:40PM +0300, Pnina Feder wrote:
> Add the foundational utility libraries for parsing vmcore files:
> 
> - vmcore_info: Parser for vmcoreinfo note section. Supports SYMBOL(),
>   OFFSET(), SIZE(), NUMBER(), LENGTH() lookups via hash table.
>   Provides cached get_page_size()/get_page_shift() accessors.
>   Handles plain KEY=VALUE entries like PAGESIZE and OSRELEASE.
> 
> - memory: Virtual-to-physical address translation dispatcher and
>   readmem() for reading from vmcore via kernel or user virtual
>   addresses, or physical addresses.Uses paddr_to_offset() from
>   elf_info for physical-to-file-offset mapping.
> 
> - vmcore_tasks_util: Shared macros, typedefs, and debug helpers
>   used by vmcore_info and memory (debug verbosity levels, type
>   accessors, __weak definition).
> 
> These files are placed in util_lib/ but are currently only built by
> the vmcore_tasks Makefile. Integration into the main util_lib build
> can be done later if other tools need them.
> 
> Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>

There are whitepsace errors when applying using git am.
Likewise in patch 5/10, 8/10 and 9/10.

I'd appreciate it if you could address that along with
the minor concerns I raised with patch 1/10.

...

