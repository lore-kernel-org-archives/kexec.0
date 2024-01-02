Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EE9C47074
	for <kexec@archiver.kernel.org>; Tue,  2 Jan 2024 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J/Wv4Cj+ssozdxQ2GKDmn3OPnqxbdVDPdfay2wQeJlo=; b=eeghMrXbxbIhi8
	0ApfD+77oqjQnDodwyQnUb7oQWM4G9xtpi+sStrUYDBCfNYfz5L1LxtwOFjsJl7sO9jB7Vcmog+dJ
	v4V0zfgTi5FLKX2MsRRc2wIQ5CvODQkbpCXJ8fI6vAD2wtxWHvFZF8umduureM79AQnlneJ3FA4jP
	igBaeXW+vuM1i3JVUcCNSBLuJCigYO0Q56VBFYF9OMLvhVCxDTwe3jFl2u0g7XqFjrGeT/XZ+mOUT
	+8Er1PusA6P0eO/ooNm2d4NPNd2vmTxTp0CtQ83SZlWcPHwOl7O4xb8J+8vkxbX1j2/RcsKDlCWrY
	1hsJL9dfEPzN6P2g7wlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKg91-008IX5-2b;
	Tue, 02 Jan 2024 14:53:27 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKg8z-008IVS-0u;
	Tue, 02 Jan 2024 14:53:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id E3C08B80DDA;
	Tue,  2 Jan 2024 14:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A473EC433C8;
	Tue,  2 Jan 2024 14:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704207201;
	bh=33py32HipQADVMip2QWDvskvo4ArE+O9uBBmaumLfiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9Kot7xBJ+tffPDF2Uq3v1XI+nGy2eUAWOpn4y8nL9vnMOUEOx1xZ74j/PwQFV2xk
	 HdZwBzfSSAIKpG5mlPQTWHhmfa4u4U2m3eeXCDACaCDk21Q+axko7rhR5gjZO1kLrL
	 0WVp/stC/NEtPgZTE6om7EWBaDttRk8HLkCyqebdjKBXWvOae431bqSrBteisYnq7/
	 05cL3O/gmcD8jwlHnaT/z8SsUR0jUWX5izW1RoFOiBPJfVa4VUK4v8c7ehYwF8BAbx
	 p3tFIucCeWupZ8yhu6Xo0CIH8eiG5mivO3ccyPepCNRFfggRU3QqSsJ2Ex679D2BXT
	 JFMQGgB3FeYpw==
Received: (nullmailer pid 2821843 invoked by uid 1000);
	Tue, 02 Jan 2024 14:53:17 -0000
Date: Tue, 2 Jan 2024 07:53:17 -0700
From: Rob Herring <robh@kernel.org>
To: Alexander Graf <graf@amazon.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-doc@vger.kernel.org, x86@kernel.org, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com, Anthony Yznaga <anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 17/17] devicetree: Add bindings for ftrace KHO
Message-ID: <20240102145317.GA2815776-robh@kernel.org>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-12-graf@amazon.com>
 <39a33f9b-0290-428d-ab1f-f90856cdb31d@kernel.org>
 <34e78a84-a29d-4b01-a860-cac3959f6cb6@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34e78a84-a29d-4b01-a860-cac3959f6cb6@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_065325_488598_63BB9CEC 
X-CRM114-Status: GOOD (  25.43  )
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

On Sun, Dec 24, 2023 at 12:20:17AM +0100, Alexander Graf wrote:
> Hi Krzysztof!
> 
> Thanks a lot for the fast review!
> 
> On 23.12.23 15:30, Krzysztof Kozlowski wrote:
> > On 22/12/2023 20:51, Alexander Graf wrote:
> > > With ftrace in KHO, we are creating an ABI between old kernel and new
> > > kernel about the state that they transfer. To ensure that we document
> > > that state and catch any breaking change, let's add its schema to the
> > > common devicetree bindings. This way, we can quickly reason about the
> > > state that gets passed.
> > Please use scripts/get_maintainers.pl to get a list of necessary people
> > and lists to CC (and consider --no-git-fallback argument). It might
> > happen, that command when run on an older kernel, gives you outdated
> > entries. Therefore please be sure you base your patches on recent Linux
> > kernel.

[...]

> > 
> > > +            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
> > ? Do you see any of such syntax in DTS?
> 
> 
> I was trying to make it easy to reason to readers about 64bit numbers - and
> then potentially extend dtc to consume that new syntax. KHO DTs are
> native/little endian, so dtc already has some difficulties interpreting it
> which I'll need to fix up with patches to it eventually :). I'll change it
> to something that looks more 32bit'y for now.

"/bits/ 64 <0x0 ...>" is what you are looking for.

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
