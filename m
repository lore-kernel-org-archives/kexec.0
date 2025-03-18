Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C89C282EC
	for <kexec@archiver.kernel.org>; Tue, 18 Mar 2025 00:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jzT0lHXMqCo0FVNh4EW0uLwal7ywPfd5DI6lemkBlgU=; b=O0SrpX8ebhHoDsKCOw8cfIZMU2
	94/O6KdSTnxfCHu7YKkpXwxu5Of7JqziMjV8fAB6rQ5FomqIDdkPgxe4ccjJ8laRHK0J+hiAe9iSQ
	ogJQEPufcEQemNtcRmN4hvbrsmJ1NFlWZyhMklm9ylAV2OD4TMbdudi6sn3vxNm3kFCoQn2V8X9NV
	deIu+48LCtACvLifxcMAug6RAygvp+52LpK+AlOzTrF+632n47ciEeRJ2IE5dkje6ED0Cjg1pZbJ8
	tVp6pRzY6w3BjhzxzQ6+GzGiASBUzhDPdedRp/AQsMrp9ySj4cWr16kTkC7LUyeukPy5ksg5INkvv
	QOJrHT4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuKkh-00000004G5V-0xZR;
	Tue, 18 Mar 2025 00:24:15 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuKkf-00000004G4c-0PQL
	for kexec@lists.infradead.org;
	Tue, 18 Mar 2025 00:24:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7E5D85C1D32;
	Tue, 18 Mar 2025 00:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEA3C4CEE3;
	Tue, 18 Mar 2025 00:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742257452;
	bh=ig9ih0A11KohCT91l/yVMWlq4EmXyFnYoyq69nfYDl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fux+aLOT/wJw4GJHH1d2iSwMLHDlXGeKF2TA8+UZeIRyLosEB+8mSymv5GMzid6Dw
	 QyXNCsl1tE5E8z+hPVlEYtpCCh7yhDkeGo86nHD0aHx+CBpLxtH5FRze2RLekk+RRQ
	 5x3AA5h8q2/8W6pGx7FW2a17WbfHZVFeNwec2+dSSBgbsgheLqy43ytIlT2RQB86rj
	 BBCCqLfpz9lPlxSf4GKmJypBb1Cykm/xXXYh/AcUBO3QtwVfT8rvB9VkGhViIakhuE
	 nOcIEITcmrROaB5tuVCPONdTfmMrr0zYEhBiJ+qnJP668pGKuSlhmeL+RgJZs99vK/
	 iIUAT8tpr93Xg==
Date: Mon, 17 Mar 2025 17:24:09 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de
Subject: Re: [PATCH v7 8/8] [DO NOT MERGE] x86/kexec: Add CFI type
 information to relocate_kernel()
Message-ID: <6swzz4732x5kfeg3qsif2r5s5ado3nbweznm6alsxvniy4xq6a@z6foorhlhelj>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-9-dwmw2@infradead.org>
 <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn>
 <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>
 <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7>
 <970a4932cb95bc8934dc2ad15e8e84a2a51d2232.camel@infradead.org>
 <wzc2owczflbhfho6xcgnl3mnrutdvmqz46xgo54g2ahorhpo5l@rykdsdkjw4fd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <wzc2owczflbhfho6xcgnl3mnrutdvmqz46xgo54g2ahorhpo5l@rykdsdkjw4fd>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_172413_184539_3C323FF2 
X-CRM114-Status: GOOD (  11.92  )
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

On Mon, Mar 17, 2025 at 05:17:24PM -0700, Josh Poimboeuf wrote:
> On Mon, Mar 17, 2025 at 12:40:14PM +0000, David Woodhouse wrote:
> > On Fri, 2025-03-14 at 10:52 -0700, Josh Poimboeuf wrote:
> > > 
> > > IIRC, the reasons were the patched alternative, and also you wanted to
> > > disassemble (but note that's still possible with gdb).
> > 
> > It's meaningful output from 'objdump -S' that I miss. But OK.
> 
> FYI, this works:
> 
>   objdump -Srw -j .data..relocate_kernel vmlinux.o

... but I see now that it doesn't intersperse the source.  Never mind...

-- 
Josh

