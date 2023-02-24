Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC99C678D5
	for <kexec@archiver.kernel.org>; Fri, 24 Feb 2023 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eCdm6JzKPliHoG9PUPVOcK88HDbBEgkDX8kVhxsqtsk=; b=Ef6gWDVTu4x7vt
	G7FQFqGETHXlWeQW9bptttG5n9bmzns0qyrMCJi+ej9Q1fUUSWlFaI0OmCU9+YWo9RnKu0mtzaXFH
	aRuAhe3CxllodnxYe/pZaHKCbZ8EJ1rbd2M29Dyweh6mmuAoxKg7QYZB2ZROUwKj8EB59gsNth5hk
	c1J/d5O8bL41Pp2DX17GqVnFtbD/5NdB2UHLQcF6fE4I1bx+TUOyZ6vt2Bv5yJtxDXWhBch1OBebb
	kIZJSsyd2LZgNTGM1f7Szn5JMAvgLGJH4krXScXJOZODhIscgeFz+6ocZvoRAYeM+Zs0QNMGolgnT
	sk14gX4FvTkiZUvQahAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVZu3-002wW4-GE; Fri, 24 Feb 2023 15:22:31 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVZty-002wT6-Ts
	for kexec@lists.infradead.org; Fri, 24 Feb 2023 15:22:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677252146; x=1708788146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MhGM3MYVaJvxOcvRH4LRPO69GfRXxYIcxsnbb3HzPvE=;
  b=JGZSmQC+A8hWpc7y3LNHz9yszR37jDbTRBP+c43Hn6wryba1MBRaa1Vo
   FE93kqYGiPVrAGuI3mNUDQ/KK+nijTbWtLI+6Gg4X4YKIgPQF2GvhPzrr
   UZXeJ7YGk8SgPwAKvMy6oKT+Z7yEMjiQ0QHBdPvNMpO5pH/sZJMS84IAT
   HRDpjVlmBAlaQo3+86xtpehYW6ZrB6Q8bEpaTbQAxOjYuX62yfr+Mj5KI
   j433fPRtbefH+xynVTnETG6CulHOMtymE7bX8G+GDtSeKHYi9tisxGwti
   L9l0ELvy8n/zOorIqcJ6Nftzf8rWsUl/E7lCRqALpo7JtCzl7FHuT3bm3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="396009167"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="396009167"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 07:22:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="650391419"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="650391419"
Received: from mrevans-mobl.amr.corp.intel.com (HELO [10.212.167.241]) ([10.212.167.241])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 07:22:18 -0800
Message-ID: <f32f1f77-c707-ae19-ae1a-dc0a37fa9806@intel.com>
Date: Fri, 24 Feb 2023 07:22:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] Kexec enabling in TDX guest
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
 <6b09a3505bf3deaa11906a2ecb9d15c4ec427ea2.camel@infradead.org>
 <20230224143004.xqhpv6upn2fkqkjp@box.shutemov.name>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230224143004.xqhpv6upn2fkqkjp@box.shutemov.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230224_072227_056828_7996F43C 
X-CRM114-Status: UNSURE (   6.43  )
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

On 2/24/23 06:30, Kirill A. Shutemov wrote:
> Ideally, it has to be addressed on BIOS level: it has to provide a way to
> offline CPUs, putting it back to pre-wakeup state.

Is there anything stopping us from just parking the CPUs in a loop
looking at 'acpi_mp_wake_mailbox_paddr'?  Basically park them in a way
which is indistinguishable from what the BIOS did.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
