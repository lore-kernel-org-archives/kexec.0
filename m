Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DF4CCA473
	for <kexec@archiver.kernel.org>; Fri,  3 Jun 2022 15:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UAVL7cvy2iNXRssxlWxfbXuNRdfEBbir7RGSZ3d42ms=; b=1qrEkIt9bet2l5
	N+F0JGrlu41bUngp06NNM/dxozzj2Lj97o3B689lLlWJvNz3W5k90XXd/+o/kwX6ok8Kk5AujOzaw
	9HdLatKvUltRHuBSsVtXUzUJtT6824uGmWtZbw6398FnM2W8dsy1Gej1jYUPv1VIx14UDrvlp30fN
	AvlGmpdynFuAQs5fZZGN2y8rcdukQKhG+e9bTqlin3io82Bn1KU1U2phXyAQ85v+4qpUKqOmg0zBe
	/EBxGWZRdy9IybwaNuTT3SPAiWqKk/ZL+WgmW72OFEs11obPNrU2SGr/ips4sgxtFI73IeDtgmFmt
	SYp4CBH1wTWWfUlvSUYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nx9eN-0085Pk-F2; Fri, 03 Jun 2022 15:55:47 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nx9eJ-0085Oa-Dk
	for kexec@lists.infradead.org; Fri, 03 Jun 2022 15:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654271743; x=1685807743;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=blHQrZ0g94mMvLynPtoK8ncChfAm2Hug5DTS5ZrddFY=;
  b=eCj363LvKZlSMmpRrkXxB5BRQo4mT0wsPxM5hTkTV7g4dDYVppy8s4SE
   bDNwYQBok//290jG9GwKpiooxvCg1hw4l1DU7XIZPMzsfyz0iQf3vgROr
   S35gxFHzpMzMB3ryx9AJEqJ7JL4bg3jfmqwoOvjWEqOdAtfcdN3ufQM0a
   b4U16HmsxabWfekxU1hY1acvIJYGC5zLSVMEZcm6vAvXLYU3fZTzFt2Y9
   3hF36Zw0s4VHePMhr3UK5qMTntvBQ3mu+qgPuISTXAkSGn4FY2SDnrZte
   HLnGrbwzjp1AGjAPpz6fY31OAWARk2FfnbkxHULf1ZgSe52XMM7MGRV85
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="336942728"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="336942728"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 08:55:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="613323243"
Received: from fbarati-mobl.amr.corp.intel.com (HELO [10.251.24.19]) ([10.251.24.19])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 08:55:41 -0700
Message-ID: <e7758ed1-5dcb-80dd-092a-a6bb21c3997d@intel.com>
Date: Fri, 3 Jun 2022 08:55:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] x86/kexec: Carry forward IMA measurement log on kexec
Content-Language: en-US
To: Jonathan McDowell <noodles@fb.com>, Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
 <8634d4dd0813b9522f039ed211023c2c65c6f888.camel@linux.ibm.com>
 <YpSC4AQInLM73wex@noodles-fedora.dhcp.thefacebook.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YpSC4AQInLM73wex@noodles-fedora.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220603_085543_628793_46E76D30 
X-CRM114-Status: GOOD (  11.40  )
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

On 5/30/22 01:40, Jonathan McDowell wrote:
> Borislav,
> 
> I don't think there are any outstanding review comments for me to deal
> with on this, so is it safe to assume it'll get picked up at some point
> once the merge window calms down?

Nothing here looks too crazy, but it's still been _very_ lightly
reviewed.  It doesn't seem like anyone from the kexec world has seen it,
for instance.

Mimi's review was a great start, but it would be really nice to make
sure that the kexec bits look good.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
