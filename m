Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD52EC2BD09
	for <kexec@archiver.kernel.org>; Tue,  9 Jul 2024 07:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cg5D8tYrHkhHgqqtIAE6Z6ak/dUdgafueCq3Hq868bY=; b=jxh2nfXpv8TsS6
	EA/F66Jlm8kNvOvP7MsZubLY2l2bBvVxSllMJ7Q/MpoXwYoUZIY/SBNcuTdFjf+snAyD5bW8CNhdG
	bhgES2K/HGy39arU0IlEHYKCgyP5TiwrY6Xp61q34dO5nOYTd/h0qWnhYVZo52eBcnkINKMj5PeWR
	rtb7aGvy50SPqtYWUWvzgW5gSEw0v6X9rQC+K3VczVFRKjU7bett3eI5c90uiVX4dDotADbnUxr9Y
	BRgDsfb69STjESJX6UKacJWME4B4J8y8zAEhVirVvdt3MBwb2jJjIlaqp506eKYh0RrwPji+tmrjQ
	HOpDfP1QdTrpxngvhQjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR5Ia-00000006ENO-10UE;
	Tue, 09 Jul 2024 07:30:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR5IW-00000006EM7-29O5
	for kexec@lists.infradead.org;
	Tue, 09 Jul 2024 07:30:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5745060F38;
	Tue,  9 Jul 2024 07:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E21C3277B;
	Tue,  9 Jul 2024 07:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720510199;
	bh=r0nJLph3vOq6vcsrqYIVHY/7gvpCGCD/nRIzDvt3Qww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAat4fR7g25/Av/rahPoVvWLuwODZjEkE0yGY89ONa+PupLsKeK8zoNle8dCGRxRB
	 aRBiNyElBsO4uf2t9MMuL3kplm42GKPR+tFTmSo7VXCWZczhyP+FbOBsQojg6q625l
	 PGsed+kW11R2tpsro30R3vVcRExG+s+qlpGGVrxFLFKHqLqu7uahGQnd+BUUp245wc
	 rLRREUPBlDwbiwJxTsz/WqqtUZDA50cubIVev8tK/durG5SnOwxmYGVKu3eeEpcihf
	 HvYZ+NCFtEo5nlbv8sote1CPEanwI5kRmPoJYIP3PtifOXT/6kGEcm1EIZKdQ7QKFd
	 AqwZaKLZ8Cwng==
Date: Tue, 9 Jul 2024 08:29:55 +0100
From: Simon Horman <horms@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Aditya Gupta <adityag@linux.ibm.com>,
	Baoquan He <bhe@redhat.com>, Coiby Xu <coxu@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] Enable crash hotplug support on powerpc
Message-ID: <20240709072955.GB346094@kernel.org>
References: <20240707152456.87899-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240707152456.87899-1-sourabhjain@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_003000_611541_A6279C26 
X-CRM114-Status: GOOD (  17.80  )
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

On Sun, Jul 07, 2024 at 08:54:53PM +0530, Sourabh Jain wrote:
> The primary goal of this patch series is to enable crash hotplug on
> powerpc architecture for the `kexec_load` system call.
> 
> The first patch in the series introduces a new kexec flag added in the
> kernel to generalize crash hotplug support. The second patch enables
> crash hotplug support on PowerPC for `kexec_load` system call. The third
> patch updates the documentation about crash hotplug support.
> 
> Changes log:
> 
> v4:
>   - Do not remove the KEXEC_UPDATE_ELFCOREHDR kexec flag. It is needed to
>     maintain backward compatibility on x86. 1/3
>   - Send the KEXEC_UPDATE_ELFCOREHDR kexec flag for x86, and for the rest
>     of the architectures, send KEXEC_CRASH_HOTPLUG_SUPPORT to enable
>     crash hotplug support kexec_load system call. 1/3
>   - Since there is a significant change in 1/3, hence Hari's Acked-by
>     is removed form only first patch. 1/3
>   - Rename and reorder the function arch_do_exclude_segment() parameters
>     as suggested. 1/3
>   - Keep the implementation of arch_do_exclude_segment() function same
>     for x86_64 and i386. 1/3
> 
> v3:
>   https://lists.infradead.org/pipermail/kexec/2024-July/030361.html
>   - Updated --hotplug option description 3/3
> 
> v2:
>   https://lists.infradead.org/pipermail/kexec/2024-June/030309.html
>   - Find CPUs in the system using the /sys/devices/system/cpu/present sysfs
>     instead of traversing all nodes under /proc/device-tree/cpus. 2/3
>   - Added a new function to find present CPUs in the system. 2/3
>   - Removed unnecessary NULL check on seg_ptr from arch_do_exclude_segment(). 2/3
>   - Updated --hotplug option description 3/3
> 
> v1:
>   https://lists.infradead.org/pipermail/kexec/2024-May/030051.html

Thanks Sourabh,

Series applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
