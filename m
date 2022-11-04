Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FBAC4332F
	for <kexec@archiver.kernel.org>; Fri,  4 Nov 2022 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mzA3Op99KpjdRbMIEAXXUqAtawrwLnrSA4+6Qlx/D+A=; b=YYI/U2+kFtjVkD
	ynhQUnZ3gW7o/qyV/soafGWJ+/213ozdK2rU1G0R0fFDaXUGcjR1Gpcoqdfssw/tYkCnFflyJhs8c
	5Ok3PX4i5AgXxvmFj8+HxjZncFzPnWVSHmxHnY8tZwNfkGLsF96OGiJ7ykAfJ34B/WFlaqliOs9BO
	NtgdbzLdqwCSLfG+51LcNwDjlD38LGk96WOKV/cy0xLkGxnEQN00K8J1+KwemNCqawVYWPTIxkOLd
	nGVWfL8e8JiIe64CvyzX8SACf0Xqs7EHMOY3vqEzuy749zvj25LkAgAv+7FD+UY5Kned/dfzDObi0
	MGilNf2WflHf59diapgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqxq1-0042gx-Nd; Fri, 04 Nov 2022 14:38:29 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqxpz-0042fG-FI
	for kexec@lists.infradead.org; Fri, 04 Nov 2022 14:38:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667572707; x=1699108707;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+BDW2rlh59H9OsdW2Tw7Cz4tXSOMyT1tD39twyGaGg0=;
  b=Rr8RW+y/5VLi6ZLVuTzXADJ9kUe4OP4Y1ByNcDjsd1U4UvsEXZAX+qiJ
   GQIPWaEyUUaO6JqteXpgWaIN+VIqpZgDD6z563gGUTGrpaLLuMpVVzkUi
   mlhyJ2APEUZg1BGJKzxd5SlAAXPjIx+Tha53To8hfrZdDm4Vy31guifzZ
   ZwD3qvsobXfyg2815QkyApFpXySmi3SxXNG8vp/76Et1wKN+Qj164wcGT
   YvNLqt98yDF39JWIZEnrMrHxufkl14OT4wCjT8HA+NAjRIBmJdEviJwhI
   O1Jb0j8yue/lS+ggh7SwTtzvr7FHSOfokWwCdZE7YQIbNEdNx91WsZvve
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="308692016"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="308692016"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 07:38:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668373765"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="668373765"
Received: from anantsin-mobl2.amr.corp.intel.com (HELO [10.209.97.57]) ([10.209.97.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 07:38:18 -0700
Message-ID: <1c9a1b86-efef-fa56-4451-ac3348b678bf@intel.com>
Date: Fri, 4 Nov 2022 07:38:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC v2 4/5] x86/crash: make the page that stores the LUKS volume
 key inaccessible
Content-Language: en-US
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>,
 Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
 Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>,
 Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20221104113000.487098-1-coxu@redhat.com>
 <20221104113000.487098-5-coxu@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221104113000.487098-5-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_073827_554590_A03978A2 
X-CRM114-Status: GOOD (  10.54  )
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

On 11/4/22 04:29, Coiby Xu wrote:
> +	if (kexec_crash_image->luks_volume_key_addr) {
> +		start = kexec_crash_image->luks_volume_key_addr;
> +		end = start + kexec_crash_image->luks_volume_key_sz - 1;
> +		page = pfn_to_page(start >> PAGE_SHIFT);
> +		nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
> +		set_memory_np((unsigned long)page_address(page), nr_pages);
> +	}

Why does this go pfn -> page -> vaddr?  What good does having the page
do?  Can you just do phys_to_virt() on the start address?  Maybe:

 	start_paddr = kexec_crash_image->luks_volume_key_addr;
 	end_paddr   = start_paddr + kexec_crash_image->luks_volume_key_sz - 1;
 	nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/
PAGE_SIZE;
 	set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);

Also, if you resend this, please just cc the x86 folks on the series.
The other patches and cover letter have desperately needed context
around this.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
