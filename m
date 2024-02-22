Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1466C5478C
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 22:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JrJNKbhj7IqhHGDauGuN54WcgvDOuZ3LpR8sPt3WS+U=; b=cxa9cHhOKqHOkL
	CaNMC9XYCxCTlGPHmvje9OMDpqOzY92Z1LtsDylzSkeBu9+UfPcM2o4V0DL9X8oy0Tg37RvU3d8W5
	34iZ5yIOADoXRssE1QlCetFDlWXgeTI6uYjvjQKTq2TotmkAf/6Gur4KIXkt59OXthy1v67kmeuZw
	9LR2L0MVyqI0W1WA256TlycCJCCk3mWPml3CvpUCpJGIpNQ+cmy/H+S7lKWk1lM1tRE0Adzuj2SBi
	mxvM/GdBlHdYHq+t8LuCfBLf+0nz21W7xKLD56w0VAFwsA38F0Ds1TBEXen910M9oAPy9ov7nYt1U
	K/RkRtfcMFggDt6nKWGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdHCD-00000006m3n-3kyU;
	Thu, 22 Feb 2024 22:05:37 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdHBb-00000006ltl-48yZ
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 22:05:33 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708639496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xXS+uiHmPKxW40P0P65T09ha/nNwEp1FEeNKV9lC8Jg=;
	b=m/2dyR85JIcCZGGQAeMJdxKDF024ImfMz99e5pyEMaUY+Fdv9HkWyfwbGViJcw/1GsTU9C
	8DlytIkC6CfziPrs7KYoFvgFP3/Sx/czcK21SfpTS2DjTbyfhPk8O1OszRPXJQflOgeomK
	UiqPbaS4/7VjEl7989ZoaPpKS4NAJJQRqCRnvMCPRgLc04BR1OZrWH+dCx99XRPneivpeY
	Ki6y92Dd/pC+o+66J2I6p5mayn0z/fVgF6ejdRp2EOqY8uL7ewCuvnNmknT4Y4Y3t6rzM3
	TZ3yF+FHuyOyV6NXNQVcgplxcJ0ZhSMrJv4VXiuFn9SD1CyP0kf0SKih2T7T6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708639496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xXS+uiHmPKxW40P0P65T09ha/nNwEp1FEeNKV9lC8Jg=;
	b=3P0A8iIYNJKmKCEkHPb/QvfbAasAull6AWDpa1ZTYuv6xCjlo8gStKpcoFEdANi6im3piH
	WcGG495WSr94wCAw==
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima
 <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, "Huang,
 Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv7 05/16] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
In-Reply-To: <20240212104448.2589568-6-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-6-kirill.shutemov@linux.intel.com>
Date: Thu, 22 Feb 2024 23:04:56 +0100
Message-ID: <87le7cduk7.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_140511_917355_95C806AA 
X-CRM114-Status: UNSURE (   6.55  )
X-CRM114-Notice: Please train this message.
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

On Mon, Feb 12 2024 at 12:44, Kirill A. Shutemov wrote:

> TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> to #VE.
>
> Use alternatives to keep the flag during kexec for TDX guests.
>
> The change doesn't affect non-TDX-guest environments.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
