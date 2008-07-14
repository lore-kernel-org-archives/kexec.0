Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KIKHF-0006Zm-B8
	for kexec@lists.infradead.org; Mon, 14 Jul 2008 09:23:25 +0000
Date: Mon, 14 Jul 2008 11:24:04 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] x86: Find offset for crashkernel reservation automatically
Message-ID: <20080714112404.36783df5@halley.suse.de>
In-Reply-To: <86802c440807140011v728cc35fy2540b537ddca9844@mail.gmail.com>
References: <1214510048-21215-1-git-send-email-bwalle@suse.de>
	<20080627133256.GB5801@redhat.com>
	<86802c440807140011v728cc35fy2540b537ddca9844@mail.gmail.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

* Yinghai Lu [2008-07-14 00:11]:
>
> should use min_t(u64, 1ULL<<32, max_low_pfn<<PAGE_SHIFT) replace ULONG_MAX

Shouldn't we use  min_t(u64, ULLONG_MAX, max_low_pfn<<PAGE_SHIFT), i.e.
should we really limit the crashkernel to a 32 bit address on a 64 bit
system?



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
