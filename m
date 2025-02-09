Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1333FC021A1
	for <kexec@archiver.kernel.org>; Sun,  9 Feb 2025 20:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PegLxjr7RGLlGHR54YwuPBdBXg3Ixf5ePUyHS8FCXNs=; b=qWc3uMC1BuQkLpTrbwChw8OMF+
	CETJ2IJjpRSeUzvNtbny8o5RRcon6UclQup3b5yPMowX5Q2ElvczPtRSa7rXeF4B1vXBcjCvq4/ck
	rcvlamXU9rlGvwBlQbdMmmHV/BthuE9R8mnhu5bilbTX9ERW07/MMC1UbIvba37nAuZ7kp3lDDByM
	hUI2wcqD3scGBU3F1QAco2khh7/7KTcm+ei9RYawjguEjjuEl5bJCKB6pcBumCCyqL89385Wg1Aj7
	pwtr58Wr6s8u7RkI3HiGyhzzd1zikypMH2dLGmdtcDfz5gukkh8ZnxdanjHyRHCqQmCVRK6iwmCFF
	2IFBogXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thE7z-0000000FWc7-2ob6;
	Sun, 09 Feb 2025 20:42:07 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thE7x-0000000FWb8-2KmE;
	Sun, 09 Feb 2025 20:42:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0323C5C4A66;
	Sun,  9 Feb 2025 20:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0C8C4CEDD;
	Sun,  9 Feb 2025 20:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739133724;
	bh=I5K6zxbY/URQKv0ExjhoGFG70Vc1gvwB7vWXZFIu2Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mvb6ZNQqXlj09hq+unmSZoCfmod0TI+N53mH8hNPSmhVyaECG7qL/VeLfhSozBwyK
	 bKp+3joGTS/8s3clIpcXU+Kf3coxgVOphSyzF4hIIfi6JPcitd2fnaTr4OYmTK+2eo
	 HlHqV/qAg7XSOsMq2x0B+/PJIDWofzpZ5yMR8hNDTGhHx/Y9oX1jWuLDZoWAREW4+R
	 DJBNXzGWKtGcx9XY6KOHAp5SdQBSySW6jRv0MlYbzTruhoFWCjOEJhK0IaUSIjok8i
	 Gx7waD6FniX2f5APSdEPIG+AUN5MSH7PclqCC2YAZNH9a44UXgOHUXHV2I40nrNzbv
	 P8DS5GHanX+6A==
Date: Sun, 9 Feb 2025 22:41:46 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 14/14] Documentation: KHO: Add memblock bindings
Message-ID: <Z6kTCvex3DGhB-3C@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-15-rppt@kernel.org>
 <45df0d7a-622a-4268-9683-c5c6067483c3@kernel.org>
 <Z6jFZII5b-j7hzkj@kernel.org>
 <a3cca0ed-64ca-4921-bb4c-27c0e06b78c6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3cca0ed-64ca-4921-bb4c-27c0e06b78c6@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250209_124205_678733_229C835A 
X-CRM114-Status: GOOD (  27.53  )
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

On Sun, Feb 09, 2025 at 04:23:09PM +0100, Krzysztof Kozlowski wrote:
> On 09/02/2025 16:10, Mike Rapoport wrote:
> > On Sun, Feb 09, 2025 at 11:29:41AM +0100, Krzysztof Kozlowski wrote:
> >> On 06/02/2025 14:27, Mike Rapoport wrote:
> >>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >>>
> >>> We introduced KHO into Linux: A framework that allows Linux to pass
> >>> metadata and memory across kexec from Linux to Linux. KHO reuses fdt
> >>> as file format and shares a lot of the same properties of firmware-to-
> >>> Linux boot formats: It needs a stable, documented ABI that allows for
> >>> forward and backward compatibility as well as versioning.
> >>
> >> Please use subject prefixes matching the subsystem. You can get them for
> >> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> >> your patch is touching. For bindings, the preferred subjects are
> >> explained here:
> >> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> >  
> > These are not devicetree binding for communicating data from firmware to
> > the kernel. These bindings are specific to KHO which is perfectly
> > reflected by the subject.
> 
> No, it is not. None of the bindings use above subject prefix.
> 
> > 
> > Just a brief reminder from v2 discussion:
> > (https://lore.kernel.org/linux-mm/20231222193607.15474-1-graf@amazon.com/)
> > 
> > "For quick reference: KHO is a new mechanism this patch set introduces 
> > which allows Linux to pass arbitrary memory and metadata between kernels 
> > on kexec. I'm reusing FDTs to implement the hand over protocol, as 
> > Linux-to-Linux boot communication holds very similar properties to 
> > firmware-to-Linux boot communication. So this binding is not about 
> > hardware; it's about preserving Linux subsystem state across kexec.
> 
> does not matter. You added file to ABI documentation so you must follow
> that ABI documentation rules. One rule is proper subject prefix.
 
No, it does not. It's a different ABI.

FDT is a _data structure_ that provides cross platform unified, versioned,
introspectable data format.

Documentation/devicetree/bindings standardizes it's use for describing
hardware, but KHO uses FDT _data structure_ to describe state of the kernel
components that will be reused by the kexec'ed kernel.

KHO is a different namespace from Open Firmware Device Tree, with different
requirements and different stakeholders. Putting descriptions of KHO data
formats in Documentation/kho rather than in
Documentation/devicetree/bindings was not done to evade review of Open
Firmware Device Tree maintainers, but rather to emphasize that KHO FDT _is
not_ Open Firmware Device Tree.

> Best regards,
> Krzysztof

-- 
Sincerely yours,
Mike.

