Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64F7E732D1
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8S54QHHMaq1yr7IbeDvTOC1MUCB7Qj+nBztDL9KVs6c=; b=rdGURY4YgpHbOZ
	592Ap/KEaEhq2+XG7DP9kRDs3rVBrwq8zFAgfZKiK4btxE0Fa8KzCXOl43aE1OrEjM1oCrQ+EhRDb
	WsbirEQr4VdqWfHspzMbdDYRyyc9NOUXyZRgI6W6U0EhFqsRCNmEJkkZB1mej/c6q2jKJt/W51Gvt
	K21jzK+BSl1cmtCOLU5DjJ+RglT1sUCMlLAHIcz8EgCxvCChWymYPD1UiIRI2HXugknIVgc9NRUu4
	YqNEL5IvMR6fYm3XCIZvlSQ0ywkq0q8tEMeU46iEMQCjd/eJ1wR2T6OHl5dC5YrKux1MrTdMn6QOu
	blhzxEH9S0I2GxqIrIqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlr98-004Nfl-30;
	Thu, 28 Sep 2023 13:33:38 +0000
Received: from mgamail.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlr95-004NY6-0G
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 13:33:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695908015; x=1727444015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TV50ur6EsvFD+NIQva87XnbSKRPe7K1V/2028Lb4zYE=;
  b=nB0fxQWodNeFGx3neNaqv+4Jv0Rin06eJ8FEwiIWFV85SjgPCFaqxzvr
   fqrxvknU/Sw5/vrF6NjwyzQ5nMNnkAwX7tiGzNKewNtjov4Mpv+734Dfz
   FWsV5RTRXavJHzQok1ad09FoNDnBy+g+nG60kDylbp4z+zWQhaUGUN4Nz
   z4eCS13tl00a8T6tbmn7mFqqptkbLdkSaZ62kFqi2ctc3gqih0i6LUGSB
   vlQsETmbELnEgUlToOMpoXk1DtBr4nYTySq80vg7LRPmr8ZhJITIiw/I4
   8Ngn1wcj9PmYn6WkGizHwbw+AhQ0el6AL1I4L6tmFTOoy22Od4GAtq6i4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="367123736"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="367123736"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 06:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784686572"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="784686572"
Received: from jveerasa-mobl.amr.corp.intel.com (HELO [10.255.231.134]) ([10.255.231.134])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 06:22:54 -0700
Message-ID: <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
Date: Thu, 28 Sep 2023 06:22:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
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
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230927161319.GA19976@skinsburskii.>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_063335_234849_E7EB824F 
X-CRM114-Status: UNSURE (   9.30  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 9/27/23 09:13, Stanislav Kinsburskii wrote:
> Once deposited, these pages can't be accessed by Linux anymore and thus
> must be preserved in "used" state across kexec, as hypervisor state is
> unware of kexec.

If Linux can't access them, they're not RAM any more.  I'd much rather
remove them from the memory map and move on with life rather than
implement a bunch of new ABI that's got to be handed across kernels.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
