Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90EBC98310
	for <kexec@archiver.kernel.org>; Thu, 24 Sep 2026 08:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7EM2scO1Xc78BwoAUHajjylw+akcDb4zR59+Q7scyY=; b=RiaNsElk+ZphKxlKf4CSPhfY1Q
	sn5FZFs5o8XPGSuYxTfLaYvHDS5KcNbvZtkq25HyEQXqNrh4AOkf4T9UMcs2Z1QMCtniYmSzWr1JS
	DJWRWGgSgQX1aisO1C6um+cv5ZmB5disKuzGvgCnn5Nh1mkOaNhtBXyHdBcN/Gw0bSEVfotGrQidw
	tYp/dEoGuT3OtSavY/SkjMN9eBCV8QUyYZzfltR+kM5/Y0tn7M5M+Q6V9/dO9rLWTl0jBPXDKrQJt
	57L75COBR/RmDdgBpkBwHtNHki8a0q9CpfOf4pm29gICwgN9o53p28Efl9PeuVBbwoe0w8QO1pFLT
	cHno3RJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9evx-0000000ARpl-2BYn;
	Thu, 24 Sep 2026 08:36:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9evu-0000000ARpT-49ko
	for kexec@lists.infradead.org;
	Thu, 24 Sep 2026 08:35:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6582040C32;
	Thu, 24 Sep 2026 08:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7F21F00893;
	Thu, 24 Sep 2026 08:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790238958;
	bh=e7EM2scO1Xc78BwoAUHajjylw+akcDb4zR59+Q7scyY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=X31XwyZEWdHBJJBkwh+YGKGtWaKuIhss1ceDmg2QfxyV2X31Pppi40vmjCTILvnnb
	 HrfOnU7BMetUV7eps82Hyhcz7Z0liQ4ND+29yycijKUs4CZQB4q7y069slEnJOnd8/
	 CNZxGl7NAAmR5lcDhHKyx+vtzOdaYixVosaL6aolLXTam1ZOC7Wi9CPWo3p13yFB36
	 QDY3Og6jLZBEgLDp3bl8akP6miMDKR6EeR6ukVYgP8FK6UN+EQDsJUalySXr1qxVB+
	 FO0idQCoegSt9g7eEZu4yfAViCkCg77UcAr0T9ZdcsDk5GkU62SNwQ42iqhj/PxDvR
	 aGQcdycbSPiQw==
From: Mike Rapoport <rppt@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Baoquan He <baoquan.he@linux.dev>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <20260922041321.233986-1-pratyush@kernel.org>
References: <20260922041321.233986-1-pratyush@kernel.org>
Subject: Re: [PATCH v3 0/4] kho: rename "scratch" to "bootmem"
Message-Id: <179023894799.508379.10846192044961348704.b4-ty@b4>
Date: Thu, 24 Sep 2026 11:35:47 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.1-dev
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

On Tue, 22 Sep 2026 06:13:12 +0200, Pratyush Yadav wrote:
> kho: rename "scratch" to "bootmem"
> 
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> The term "KHO scratch" is vague and overloaded. It does not accurately
> describe what the memory is for. This was discussed previously at [0].
> The conclusion was to rename "KHO scratch" to "KHO bootmem", since this
> is memory passed by the previous kernel for early boot allocations.
> 
> [...]

Applied to kho-bootmem branch of liveupdate/linux.git tree, thanks!

[1/4] memblock: get rid of CONFIG_MEMBLOCK_KHO_SCRATCH
      commit: 5e309f53050f33faf74f55332f359099d7346464
[2/4] memblock: rename KHO_SCRATCH to KHO_NOPRSRV
      commit: 05a84ceadf7024be320e2ba82fe709db4a4180bd
[3/4] kho: rename KHO scratch to KHO bootmem
      commit: 85d3615cea17968788aa6581fd242e34d8953e58
[4/4] kho: rename kho_scratch= commandline parameter to kho_bootmem=
      commit: 8fe64603a47506c3b357002460c3a9c0d8d4d321

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: kho-bootmem

--
Sincerely yours,
Mike.



