Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4A2C36002
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 05:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i4DroqneBG6x0AD5NkBo68XH9/ZkMAi74MRpFzbuPbA=; b=WT42FPVsKjbc3PhYkTjns19S5g
	rliDahcRHLc8GoSJNciUl6TD/XTWrgrMszma9BcbKpPnHE5BqHAWVA2JqgF4Oqzqipykyu3EZH0a8
	yweGQ5UPmB8ctbls9OT2uWrlDaXCngb4CPHNNQR/ydcbdPD5BGD3qea/RrJpdvnDbYR1hHBPpXZ27
	6DzEX5LZwe9v9Vst5bLyi92Ep2lBeXDaXHWE4Ppk0MxTVMfO0+S7yo8BwZ5aDQQQAovdiTC55TOeR
	FizaQbjOpHf0muwIn7IuxleC3a1JOJm73lctqmvxkUyFZpYvtm3G27R1WNYNKduK57AnlewJhzanb
	1zdzl1ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tv8bn-0000000BEXV-0Z7i;
	Thu, 20 Mar 2025 05:38:23 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv8bk-0000000BEWn-0gcp
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 05:38:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2E570A48F7B;
	Thu, 20 Mar 2025 05:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51B8C4AF09;
	Thu, 20 Mar 2025 05:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742449098;
	bh=NQpmUMJVyMyFJpKpG5jMIUbPPQhrRkv3l6n2VcE0EUg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fuMNo4sNK9rhmK+emalGQ6LXJk0BvGUhlA+tpCOWs9uNaHCOVaqQgbYFz0NLLgdlp
	 aAV9LjSUwTiji7kc13eE91Xk1LgTrGMChLjL3VKl5uXggr9wkmTIAASEsexsTeXQTo
	 hgyaGgEFm3B/LdGBy4FdSRAM8UxBjBOYC0t9ObIBbMaGLje7prvIQSdPGMoNLyaVyz
	 njn4Km2JW7uFIMW5csKuRKRQ4XTnxUegzEj7m8jRpFX13pT6Q4gahNXo21WmTN/ss5
	 XmjNPrw3/ldi8geuBfhZv573ycrN5nPvkAzFfBjxLcybFsfqRhBiQ9WVhmJzG503Et
	 TV1QD7SwzHqvQ==
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id C4767120006F;
	Thu, 20 Mar 2025 01:38:16 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Thu, 20 Mar 2025 01:38:16 -0400
X-ME-Sender: <xms:yKnbZ0PcaGRKeZZuFl7w0-BrS2uZdik9z1k5XaAUyC38Tqu1nw71kA>
    <xme:yKnbZ68WRGZZrSaNsR7C6px1Orztvveivv_mwb4EYxcwWSTgcUwKV7arQWUMZ2s8F
    0D3TylCOC9F_urGbP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfrfhrrghthihushhhucgjrggurghvfdcuoehprhgrthihuhhshh
    eskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpedtleelvdejtdeiudfhtdev
    feeujefhgfetleeifeffleevtedtgeevkeehhfeludenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqudegjeefudejtddtkedqfedtvdelkeefiedtqdhprhgrthihuhhshh
    eppehkvghrnhgvlhdrohhrgheshigruggrvhhprhgrthihuhhshhdrtghomhdpnhgspghr
    tghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegufihmfiesrg
    hmrgiiohhnrdgtohdruhhkpdhrtghpthhtohepghhrrghfsegrmhgriihonhdrtghomhdp
    rhgtphhtthhopehjghhofigrnhhssegrmhgriihonhdrtghomhdprhgtphhtthhopehprg
    hnkhgrjhdrghhuphhtrgdrlhhinhhugiesghhmrghilhdrtghomhdprhgtphhtthhopehf
    vhgulhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhunhgrihgushesghhoohhglh
    gvrdgtohhmpdhrtghpthhtoheprhhivghnthhjvghssehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehtrghtrghshhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvhgrnh
    hnrghpuhhrvhgvsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:yKnbZ7Q6E1rgEp6Xk-smVSHYdF4IVNsSUSQkuOV5QV4DztyGPextvQ>
    <xmx:yKnbZ8siwRsO6fIQbGpDpwJyfBxgk8Rf_CiBF0XdzqAIXwU70LHv8A>
    <xmx:yKnbZ8f25a-AEd3xThLVU_BTtBDvWTEfHPEC8x870ZbB3MnRtJ_71A>
    <xmx:yKnbZw15-xIIhKafN5vXynVwBRLZ9y4rlnNIw4zE9CCdb5jcTy-Xmw>
    <xmx:yKnbZw_KbVQ6OGp1oKpvEH1ecD13Vok88VWRXm4EukMqAjZh_kVAlUvS>
Feedback-ID: id4c94969:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 951301C20066; Thu, 20 Mar 2025 01:38:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Tb8cb476dfbc5618c
Date: Thu, 20 Mar 2025 09:37:56 +0400
From: "Pratyush Yadav" <pratyush@kernel.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>, "David Rientjes" <rientjes@google.com>
Cc: "Alexander Graf" <graf@amazon.com>,
 "Anthony Yznaga" <anthony.yznaga@oracle.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "David Hildenbrand" <david@redhat.com>,
 "Frank van der Linden" <fvdl@google.com>,
 "James Gowans" <jgowans@amazon.com>, "Junaid Shahid" <junaids@google.com>,
 "Matthew Wilcox" <willy@infradead.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Pankaj Gupta" <pankaj.gupta.linux@gmail.com>,
 "Pasha Tatashin" <tatashin@google.com>, "Vipin Sharma" <vipinsh@google.com>,
 "Vishal Annapurve" <vannapurve@google.com>,
 "Woodhouse, David" <dwmw@amazon.co.uk>, linux-mm@kvack.org,
 kexec@lists.infradead.org
Message-Id: <755e80a2-60a7-4a04-9eb2-714e89ea34c5@app.fastmail.com>
In-Reply-To: <20250317172255.GO9311@nvidia.com>
References: <a350f3e5-e764-4ba6-f871-da7252f314da@google.com>
 <20250317172255.GO9311@nvidia.com>
Subject: Re: [Hypervisor Live Update] Notes from March 10, 2025
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_223820_348189_BBAECDA5 
X-CRM114-Status: GOOD (  20.52  )
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


Writing this from my phone so apologies in advance if it messes up formatting somewhere.

On Mon, Mar 17, 2025, at 9:22 PM, Jason Gunthorpe wrote:
> On Sun, Mar 16, 2025 at 08:52:43PM -0700, David Rientjes wrote:
[...]
>> Pratyush noted there was no way to preserve folio orders in KHO and he
>> also noted there was a need for page flags.
>
> I think the xarray idea will preserve folio orders, that was a big
> point of it.
>
> Not clear why we'd need to preserve page flags. The same page flags
> may not even exist in the new kernel? New kernel should set the page
> flags correctly based on what it is doing. Shouldn't, say, memfd know
> exactly what it's page flags should be in the new kernel when adopting
> the memory?

I didn't mean the exact flags value, but the ability to have per-folio flags. The exact bits and their meaning would of course need to be part of the ABI. Shmem uses the dirty and uptodate flags to track some state on the folios, and the flags can affect it's behavior (lazily zeroing out falloc-ed pages for example). I am assuming other FD types or drivers might also want to store per-folio information. Having KHO core provide this facility can avoid duplicating the logic in each subsystem.

That said, I don't think this is a blocking feature that should be present from the get go. I would be happy if it is, since that would make the shmem flag tracking easy, but for now I can have a separate property to track this.

>
>> Pasha asked how cgroups would be handled, but there was no current
>> support for that.  Pratyush said the current RFC focused on anon memfd
>> and has not yet looked at hugetlb.  Pasha emphasized the importance of
>> focusing on one type of memory to start.
>
> I'd say userspace should deal with this. It should de-serialize the FD
> within the context of the cgroup it wants to charge that FD too, and
> the de-serializing process should charge that cgroups accounting with
> whatever is restored inside the FD.
>
> Is that possible?

For FDBox, it is certainly possible. In the current patch version, deserialization happens on boot so it can't be done, but in later versions I want to give userspace control on when to deserialize. So whichever context triggers that gets charged.
[...]

-- 
Regards,
Pratyush Yadav

