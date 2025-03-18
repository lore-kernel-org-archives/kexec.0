Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF46C282EC
	for <kexec@archiver.kernel.org>; Tue, 18 Mar 2025 17:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hriVVxoHqH5u/2+ZtiARjc6XCVLAyv129W4GnVKCN0M=; b=yEv5CSbGmFjujsdawPwc3x3wkY
	gIs+cySytxUqJkfG/5xptT1FHY5e8UMRly0iOYD46nyNOvpJIJo7UTS/bnfUFENKcKQhbPRgS4cIe
	WLnwJf6zD9/mMN/JDhqYTXw2hf/AByGJPi2MmgYQ7vPH+8SOVbCrAvMIjvItxdW/odoWxrxiH1+27
	hSLhz3yslRtl5YjjBfq5Wnys/R2jo6ZNUQ0/+x77hjrJSmAiTh10ZWFq7oNUxkRt3iDUZ//OyzH7P
	eNbVgP5W7WjAfIV0mwOPt0r4TZareUAd3q7UPvuIC4mPk/qrRRN5lLue/w8njaLyNFindo2QGGYkJ
	vbd/U2sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuaWR-00000006e0Z-3uJf;
	Tue, 18 Mar 2025 17:14:35 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuaWP-00000006dzd-10PK
	for kexec@lists.infradead.org;
	Tue, 18 Mar 2025 17:14:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E58AEA48B39;
	Tue, 18 Mar 2025 17:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8E9C4CEE3;
	Tue, 18 Mar 2025 17:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318072;
	bh=FdmeE5UpNTG7ZD9/uFOLcJYqB/eNRc5dbBERnws9X0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZy1bBNEehY+76p+JpVHAWgQfv6e31/k/jm8FqzUbSiA5prxPX0aTI02U1HVmU5iW
	 rXuRDwcXhLhmj3JvhJzuIze4DAixbJOzn0AMYE3G0JivOmqST+bYtjeRpKpd5CEUjT
	 4thVUCZz2Jxdd+Pyhil2NuExioXt1zAC7MYgxMLj8Q9oMHoI4BjvpauUhWPL51EotK
	 +uwzBR1M7Ntn/FbaRAMreXrkscnUsFc5rMlFYrQPEqmLyp38ZCi/8mtZx0HbJ1ngma
	 FWZHvCX3UYLZcJk33r+qLYm64LsLGDdtB66OASQJ0wAkv8lhPLe9ck0G8XYhBvh+2g
	 VezSPuCoxwsiw==
Date: Tue, 18 Mar 2025 10:14:29 -0700
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
Message-ID: <awucsfjn475mvwg7xhihexln2hfbtvrie2uv333u7awtkz4mrf@t57pi7jibytc>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-9-dwmw2@infradead.org>
 <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn>
 <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>
 <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7>
 <970a4932cb95bc8934dc2ad15e8e84a2a51d2232.camel@infradead.org>
 <wzc2owczflbhfho6xcgnl3mnrutdvmqz46xgo54g2ahorhpo5l@rykdsdkjw4fd>
 <6swzz4732x5kfeg3qsif2r5s5ado3nbweznm6alsxvniy4xq6a@z6foorhlhelj>
 <9c41ab61efc573e3ab5a75b6e4031f81db84a846.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c41ab61efc573e3ab5a75b6e4031f81db84a846.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_101433_343847_FA206415 
X-CRM114-Status: GOOD (  17.59  )
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

On Tue, Mar 18, 2025 at 03:56:36PM +0000, David Woodhouse wrote:
> But on the whole, I'm not sure the CFI check is worth it.
> 
> CFI checks that the caller and callee agree about the prototype of the
> function being called. There are two main benefits of this:
> 
>  • to protect against attacks where function pointers are substituted
>    for gadgets.
> 
>  • to protect against genuine bugs, where the caller and the callee
>    disagree about the function arguments.

AFAIK the first one is the main point of CFI.

> For the relocate_kernel() case I don't think we care much about the
> first. Without a CFI prologue, no *other* code can be tricked into
> calling relocate_kernel()

But for FineIBT the hash is checked on the callee side.  So it loses
FineIBT protection.

> — and besides, it's in the kernel's data
> section and isn't executable anyway until the kexec code copies it to a
> page that *is*.

Does the code get copied immediately before getting called, or can it be
initialized earlier during boot when kdump does its initial setup?

-- 
Josh

