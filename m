Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13144CFA44F
	for <kexec@archiver.kernel.org>; Wed, 23 Oct 2024 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=raAmRnLBhq6chU6Xed0nCfcmSHb6OWXnSnpuVf1lrZE=; b=3fZSxjhwBUo7qeBCBAyoSgA6FP
	aS4e1siHbv8I3zClooHX1aj4Sbf54bhBm7t6Y+0ORZCl5hCueKEEBu15e702T2G5Vo1hVu1R52dYj
	unqeWxV3j3W0IorylN2NpzXN/Rma+UK+VzA+XRBhYIyS+xKV4wPXQaxSR9/DyXI/bm+dwvVssgJdN
	UaGCkKp31oNy+Ew9aNmwt4mvnyflOCp3tjmNmVLtYseBXYDwmuB0/ydWJ2XkO4cmkehfTBQ2h6qHb
	Q7aqSDGF7ETCJviwDLEAw5/GSi7fLGyZbiQLYoO3Ch8FE8GN8mw/AznR3NQM3HZ7BbU0SAwOmXtLT
	MfnHR2OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3e7N-0000000F7eZ-3uqi;
	Wed, 23 Oct 2024 16:21:53 +0000
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3dXZ-0000000F0sj-0HFP
	for kexec@lists.infradead.org;
	Wed, 23 Oct 2024 15:44:54 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:37192)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t3dXF-00Gq8R-Vr; Wed, 23 Oct 2024 09:44:34 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:48910 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t3dXE-00Ce3Q-Ub; Wed, 23 Oct 2024 09:44:33 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Yan Zhao <yan.y.zhao@intel.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-coco@lists.linux.dev,
  x86@kernel.org,  rick.p.edgecombe@intel.com,
  kirill.shutemov@linux.intel.com
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
	<87frop8r0y.fsf@email.froward.int.ebiederm.org>
	<tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
Date: Wed, 23 Oct 2024 10:44:11 -0500
In-Reply-To: <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
	(Kirill A. Shutemov's message of "Tue, 22 Oct 2024 15:06:15 +0300")
Message-ID: <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1t3dXE-00Ce3Q-Ub;;;mid=<87cyjq7rjo.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1899tWOjUmFXe4DAmPwzY/yTaOmZMJ+rQQ=
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: kirill.shutemov@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, yan.y.zhao@intel.com, kirill@shutemov.name
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_084453_128175_D0D4AAAF 
X-CRM114-Status: GOOD (  12.29  )
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

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> Waiting minutes to get VM booted to shell is not feasible for most
> deployments. Lazy is sane default to me.

Huh?

Unless my guesses about what is happening are wrong lazy is hiding
a serious implementation deficiency.  From all hardware I have seen
taking minutes is absolutely ridiculous.

Does writing to all of memory at full speed take minutes?  How can such
a system be functional?

If you don't actually have to write to the pages and it is just some
accounting function it is even more ridiculous.


I had previously thought that accept_memory was the firmware call.
Now that I see that it is just a wrapper for some hardware specific
calls I am even more perplexed.


Quite honestly what this looks like to me is that someone failed to
enable write-combining or write-back caching when writing to memory
when initializing the protected memory.  With the result that everything
is moving dog slow, and people are introducing complexity left and write
to avoid that bad implementation.


Can someone please explain to me why this accept_memory stuff has to be
slow, why it has to take minutes to do it's job.

I would much rather spend my time figuring out how to make accept_memory
run at a reasonable speed than to litter the kernel with more of this
nonsense.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
