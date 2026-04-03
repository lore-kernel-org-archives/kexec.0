Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CB9E7E37A
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 11:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V/arDm3ImxeL0GvbAOnjBuF0Adz5BzOJKD+OUyROEO8=; b=TRiraOdKP9yYyEVeZLOjIaP5mz
	w6ku0o8ZvxxJ/+m+CgDNNr5Kq0b1bMEQTTuGzffwDdUoG60I0SAZZrKGT6oemsGMEHW7ZgDQFzDfC
	JMQF4aPpCw1IYFGJ1gWe9WkBeoS55MK9z2CGuq9XNPODTKMkzoNRWfSwUal6a0rR8SOA+oDpmyr81
	6XyeA23Etc7mG1Q0xbTonXJzf+rmQ1jgi8lWWFSi/Xj4SIh4JDJLHL2TZY+UwQz8XJZgoS5dmo4o6
	FW4qkzWCQabSFjedHpp622kAZJMAeP9M0Ufp54fzDRVk8Qol0xQZTZ6VLA0ZSZay9fhmyx9ETVdty
	KR5eMHMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8cmJ-00000001xfV-2dM1;
	Fri, 03 Apr 2026 11:33:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8cmI-00000001xfN-1fnu
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 11:33:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AB4D060008;
	Fri,  3 Apr 2026 11:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072BCC4CEF7;
	Fri,  3 Apr 2026 11:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775216009;
	bh=MOa8QwYDPq/SXAl8Xjaj96vm9q5sOGqWl/i71Rc47Ws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pmfS6FenCMhHu+Si513jQqk03iN3KcvNvCYMo67y5M0mrFTLalxKgbME/ljU6ovlb
	 4cNutnZddi1UerKpbU+o45vr24FFbHHvBZ1A//YyJmsmNqBA6rK3Ek9enZotqQf0RR
	 mXUl18KPqbVW8SVLA2xHexUsP0P0hai+Ba7TgxuzSdBfyAPNVLcJTNEGaxwa7pM8av
	 14DnyjU42GpelIzK4Rzm/7jmlRHR+p1MLWixJaKdrzPeRPfaTmYB1ECRJl06Pm+t04
	 WXmRtYUTJx2XWtqW8nlPS2Tw9B3FXPLaekVl3E1nkrxuASZBdyYCebpTKIycNV/Ebz
	 1S4CVPs2TTXDw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usama.arif@linux.dev,
  SeongJae Park <sj@kernel.org>,  kernel-team@meta.com, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 0/6] kho: history: track previous kernel version and
 kexec boot count
In-Reply-To: <20260316-kho-v9-0-ed6dcd951988@debian.org> (Breno Leitao's
	message of "Mon, 16 Mar 2026 04:54:30 -0700")
References: <20260316-kho-v9-0-ed6dcd951988@debian.org>
Date: Fri, 03 Apr 2026 11:33:25 +0000
Message-ID: <2vxzeckwcm7u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Andrew,

On Mon, Mar 16 2026, Breno Leitao wrote:

> Use Kexec Handover (KHO) to pass the previous kernel's version string
> and the number of kexec reboots since the last cold boot to the next
> kernel, and print it at boot time.

This series is good to go I think. Please include it in the content for
the next merge window.

[...]

-- 
Regards,
Pratyush Yadav

