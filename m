Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD76E732D0
	for <kexec@archiver.kernel.org>; Fri, 29 Sep 2023 10:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JrXs/w7To4gtOmnfYYiA290SFX6cGWtowIEWtKufwsE=; b=W07K9wTXRszVSg
	eFasDyF/RRd/C6eirnvBJ+UKIuUbJ5p9kHpYJCezk/cHGy8gdSI0KoXZTHqZTH23lqwo/yLGzvZwb
	4ibsU82suz2H/VAfnnixCWqZVjuPVRPBEjpCpETmho34xRJjbuQ5oUnmFEbU04t35SECbHj5cWc9c
	McrcKrhr2MeD1phT49eqYNix6LkrTfs9vVxLTqvEXoGwjZZzQIx22yVJ0DPgXm+zhoAyDy9lMIOa/
	DgQiHtuWc3TUgiA5sEG9yC7cWZ93sDPuCvoLSuk4p8ioZhkjRnrThrXwwBkOeIdV1Zrhz5mz8sQQ8
	kNMrecHHsDieTnOCciXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmAVD-007WZg-1k;
	Fri, 29 Sep 2023 10:13:43 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qmAV9-007WYN-0w
	for kexec@lists.infradead.org;
	Fri, 29 Sep 2023 10:13:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695982420; x=1727518420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yMUdUXBMxkbONlcFbJ0cpOiSHGH/6S4pUNSsyx3HTtc=;
  b=kX0BhpuQP0827HwtMfZ1mLqAlZOV3YVAum6HuzwiRrbUEZ34gO57mel5
   j79tPtDbtOtd0LNG/1B3+cLWlxW7+8vdxeObyUd0VSyS8nr/MPgp4uvnp
   DLFKNmGpuRPNBj/rklg8Pk9iaRqMVQ5QuC8WJlQgYhpRyrERMsX1JPGH+
   P95oqXCvGKfXczlzJJRkQ9opuFzmLQv/z8dghFj7e24fhb+QZ/zzSLWgE
   /hSUYBtekWmPUCDuCEnhMkjqxxHkKiJw5Pu2KIjB9KdqWf0Iv+n6w/Bfq
   T4PLX5QaeqmlRzGZ6i3f5WFqqF+0dBgWG/JlLW5NxwCd6zftEhfyT26tb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="872805"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="872805"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 03:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="749914451"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="749914451"
Received: from mziotti-mobl4.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.34.13])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 03:13:27 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id B9E791095FB; Fri, 29 Sep 2023 13:13:24 +0300 (+03)
Date: Fri, 29 Sep 2023 13:13:24 +0300
From: "Shutemov, Kirill" <kirill.shutemov@intel.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Baoquan He <bhe@redhat.com>,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	ebiederm@xmission.com, akpm@linux-foundation.org,
	stanislav.kinsburskii@gmail.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
	wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	graf@amazon.de, pbonzini@redhat.com
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Message-ID: <20230929101324.jgixt4jmqialchno@box.shutemov.name>
References: <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
 <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <20230927232548.GA20221@skinsburskii.>
 <b684d339-991d-be85-692c-75f21679ca69@intel.com>
 <20230928000230.GA20259@skinsburskii.>
 <760bbb08-83b4-7bb1-822f-2ceba26278a6@intel.com>
 <20230928003831.GA20366@skinsburskii.>
 <340596c9-d55d-5f8a-fa27-d95b0e10b20a@intel.com>
 <20230928024636.GA20423@skinsburskii.>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230928024636.GA20423@skinsburskii.>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230929_031339_390191_3B00B833 
X-CRM114-Status: GOOD (  11.33  )
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

On Wed, Sep 27, 2023 at 07:46:36PM -0700, Stanislav Kinsburskii wrote:
> I'd answer yes, "System MAP" must be persisted across kexec.
> Could you elaborate on why there should be a mechanism to tell the
> kernel anything special about the existent "System map" in this context?
> Say, one can reserve a CMA region (or a crash kernel region, etc), store
> there some data, and then pass it across kexec. Reserved CMA region will
> still be a part of the "System MAP", won't it?

Em. When crash kernel starts all System RAM of the the first kernel
becomes E820_TYPE_RESERVED and only memory pre-allocated for crash
scenario becomes E820_TYPE_RAM. See crash_setup_memmap_entries().

Can't you go the same path? Report all deposited memory as
E820_TYPE_RESERVED.

Or do you have too many deposited memory ranges, so we would run out of
e820 entries?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
