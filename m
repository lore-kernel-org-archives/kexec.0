Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E83105F786
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7LsNLm8V1LNKM3RNu83Aj+OCZ8LbzE5exZLbnQQevA=; b=tO3UpkkylWCK4NWz2HwVTTGkks
	8CeQR07WzvVULkWa5b4nJOSFmt9jKMEMB209B4RQbSdRhyLd4zUmgw45cDmdfCJOcb5hQl2DGc1BG
	rJnwRtHVQpskmkx5EZ4hKnMLQVoV8PUS4VEIdWPZ8s6TlWNkJWq7RLd3UGk6VVlWtNyWl41dHWCyC
	5x2dC2UbKCgL8XxlDjz0UmjVhFAUSEpG5T7YnWHoXLc1APLnBPHwqeuQr+slD75Vn4lJQk2jjd/OK
	RIT68yakfoKXKpJT+TS+cZkS38CrY2X3FNaX2AGdfH2lrAghJO9tuaV+WmFvtqyjaI0qffoENAPYH
	aiaH7LeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0zL0-0000000HTCg-2yYR;
	Fri, 13 Mar 2026 10:01:46 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0zKz-0000000HTCL-3FPA
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 10:01:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D0E636013C;
	Fri, 13 Mar 2026 10:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FFAC19421;
	Fri, 13 Mar 2026 10:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773396104;
	bh=OIFeikD82nmwD3OmN2AOXV+pImCHdvGmD6kzGbZztMM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y/gC6JPhy66S1xqzXJ3KdEefi0wYq8mOdiHoWgx2/FDpA+nmJuZ/cPubHSwIx8sZw
	 Wfgyaa7t1krwXHYK73m1pVtjmfzmB5smo+c/GWzcfI/thdsEa/RuYE5rzJGI+ZZ1IF
	 6/HDCZreZCUQEJ5jIC5wkDanWpLDHJteJ7TjsWbo5/yfyyORHttM2EP6YCP55BRcW2
	 gtZNGo6jmxAhnJFDrUkKymFYGdwI+b5IhF/MdDaldEWbuWsRJr2kcQLVwHV98aUKVV
	 aj4ICSIaxLUTS0gYgWhQ5fPtrjN2/wiU1tn8X/ZXWEMsWiMp2dkOkgJ3KsycSJO8hX
	 fq7dpuVDt0sQg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  SeongJae Park <sj@kernel.org>,  kernel-team@meta.com
Subject: Re: [PATCH v8 0/6] kho: history: track previous kernel version and
 kexec boot count
In-Reply-To: <20260309-kho-v8-0-c3abcf4ac750@debian.org> (Breno Leitao's
	message of "Mon, 09 Mar 2026 06:41:43 -0700")
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
Date: Fri, 13 Mar 2026 10:01:40 +0000
Message-ID: <2vxzqzpof3p7.fsf@kernel.org>
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

Hi Breno,

On Mon, Mar 09 2026, Breno Leitao wrote:

> Use Kexec Handover (KHO) to pass the previous kernel's version string
> and the number of kexec reboots since the last cold boot to the next
> kernel, and print it at boot time.
>
[...]

Thanks for cleaning up the KHO infrastructure. It is much appreciated!

I only have a couple comments. Once they are fixed this series should be
good to go.

-- 
Regards,
Pratyush Yadav

