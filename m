Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5684DCE7AFC
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4E5RnGuKCe/WSr/9LPfLdt3Ud0q7Gn4kIpl5fuUu0h0=; b=kyeSfrvU/Aok/W
	7sPU9FD+Jk4w88d3XhGZZDi78qCxPfrfc88zcyBB2jYyiTBkQVbkAqBk6mLtajPBxOwn7AlZjbU8G
	oWQOWeORJF6N7fDEUi47tHqKJfTVOY5CO+Y5EBPiYj1diau+yDYpetJLPjuja3UDDEnGeq9aq7xS2
	95o4FdbuacwA6lNVX+W1hOKAyfYGQ/HDMKWn/uzKxr0fOtaew0phRT0dGN/dV+Fmv7b0NFew2eEd7
	hRgFEVHvd27PcUF+GYN5LyCsH8/Pkekm2X17Sj7P5/O2DA+VtKsTCVniz3itFaWWsTZRSqxQRbZhk
	k0muCm/Zsnh2rmuWsHlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlvJB-006TYZ-33;
	Thu, 28 Sep 2023 18:00:17 +0000
Received: from mgamail.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlvJ8-006TY8-3C
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 18:00:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695924015; x=1727460015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k08d4cJZrEP2o/SLqjoaj5SIzc6BygHuqPno8v6qPGw=;
  b=I48Og4Mk0Qq7PTxqkxfVgCIjA1jjkFdxDgHCpAKZQcN9TtKqorGIwOG4
   Eq/KhE718MBuzbIjz7MbWNTOmTa7vcEm0aJ+MbUwwiJda3PDlxwfD9pWB
   V58sw5GD+7RcpTEO+kWN6eXOLDsBeUG2rDTCRR3H0Hh9+Ut/89cdW9os9
   W3LH2R4cdrNJ3JjXM9s4r49As5UXJNEkba641dWZaQV3zGzlbdniUoIXO
   Bl9i8UkMLB80T4sDmms7mMcUp8g9EWUIMwNC4KWuVV2v8WZgofEBHUIyx
   jWJ6J7meLFwW/Rd5Iw5PNQfaRfMArc9upVVnBTvrmNHARJ0o4pU6mkLAf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="468414163"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="468414163"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 11:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="699374241"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="699374241"
Received: from jveerasa-mobl.amr.corp.intel.com (HELO [10.255.231.134]) ([10.255.231.134])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 11:00:12 -0700
Message-ID: <760bbb08-83b4-7bb1-822f-2ceba26278a6@intel.com>
Date: Thu, 28 Sep 2023 11:00:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Baoquan He <bhe@redhat.com>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com,
 "Shutemov, Kirill" <kirill.shutemov@intel.com>
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv> <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <20230927232548.GA20221@skinsburskii.>
 <b684d339-991d-be85-692c-75f21679ca69@intel.com>
 <20230928000230.GA20259@skinsburskii.>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230928000230.GA20259@skinsburskii.>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_110015_043091_C97632D8 
X-CRM114-Status: GOOD (  23.06  )
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

On 9/27/23 17:02, Stanislav Kinsburskii wrote:
> On Thu, Sep 28, 2023 at 10:29:32AM -0700, Dave Hansen wrote:
...
> Well, not exactly. That's something I'd like to have indeed, but from my
> POV this goal is out of scope of discussion at the moment.
> Let me try to express it the same way you did above:
> 
> 1. Boot some kernel
> 2. Grow the deposited memory a bunch
> 5. Kexec
> 4. Kernel panic due to GPF upon accessing the memory deposited to
> hypervisor.

I basically consider this a bug in the first kernel.  It *can't* kexec
when it's left RAM in shambles.  It doesn't know what features the new
kernel has and whether this is even safe.

Can the new kernel even read the new device tree data?

>> Can't the deposited memory just be shrunk before kexec?  Surely there
>> aren't a bunch of pathological things consuming that memory right before
>> kexec, which is basically a reboot.
> 
> In general it can. But for this to happen hypervisor needs to release
> this memory. And it can release the memory iff the guests are stopped.
> And stopping the guests during kexec isn't something we want to have in the
> long run.
> Also, even if we stop the guests before kexec, we need to restart them
> after boot meaning we have to deposit the pages once again.
> All this: stopping the guests, withdrawing the pages upon kexec,
> allocating after boot and depostiting them again significatnly affect
> guests downtime.

Ahh, and you're presumably kexec'ing in the first place because you've
got a bug in the first kernel and you want a second kernel with fewer bugs.

I still think the only way this will possibly work when kexec'ing both
old and new kernels is to do it with the memory maps that *all* kernels
can read.

Can the hypervisor be improved to make this release operation faster?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
