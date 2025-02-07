Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7B5C0219B
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 08:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p3nkfxSaNeN7hJYI9UBbIfRFZwlZD8sEoPkfxHM5WLE=; b=UxGU3m26jqhbAVOzdN4BOY/+0t
	ZOlN2StQG4pO/EVbwxnfw2vDTMP/h8+Y/WladnN/9s7s9DFOXJ0VMK5zu7h4IayI+6G8Xuo48S7qb
	lK/lSNd7Z6vIBTQMpBx71BQ2obJWV1lMd2itzcPwsXS7Fv2w7VpuzvUIu0jAWywUvKatbIqUvYENe
	ZVVtbu2RrjA/Ft7yj26lCUveW93Jxph8RGa5TFKbVAi78alKOAjl5/eB6mSSPwakjez+DMnjG0M3a
	1+5p+eSsywav3aljYiqtihbTsetLCI7y1qm+LZ15LJTIRJPLm/cu7F5ue8p990aSPnGbnK8AmOGyB
	Wm8GCDFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJOD-00000008kMr-2mvr;
	Fri, 07 Feb 2025 08:07:05 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJOB-00000008kLM-0CAT;
	Fri, 07 Feb 2025 08:07:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F3EECA4289D;
	Fri,  7 Feb 2025 08:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3BEC4CED1;
	Fri,  7 Feb 2025 08:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738915621;
	bh=gmvjh4dkLXQWB/aNPOCFxhvy4MCVdZfnnTa23d2Vqx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9hGFt1MT9MudOB8G3xhPsgVkPL13CsGiEUsLxyCU38gOEui2kZK2TRDIJuOwNn9d
	 3LIB+f8dOdcZerYT7pIiLFGBBv3bhQdSSBnOKrJ3b1XwzaZvoXfU1qYQIWj0ngmh69
	 p//fwX1B1vzkSXX3A5dH7nIbzFPmXcKnMSPSs5YWDWVpC1BuLcz0KBpWZZXW+CkvwE
	 UObo9g70YkW+RiyeycGMCSps8itwC4ifzY34sO99kkNeTyp5bijklQEj0VbqEndkq5
	 ZKExFJOSeC4i1Y+VcMCFjWcQ06zZUJ33AFWJ1Q88KJo74WN355g5NTlF4Nz5ZJaFaH
	 CKchBYGyDprFw==
Date: Fri, 7 Feb 2025 10:06:41 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
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
	Krzysztof Kozlowski <krzk@kernel.org>,
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
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
Message-ID: <Z6W_EcyPO5lBbCKZ@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206162939.a1f86fb835f1eeb7ed73ff1c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206162939.a1f86fb835f1eeb7ed73ff1c@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_000703_203893_9627BED6 
X-CRM114-Status: GOOD (  25.36  )
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

On Thu, Feb 06, 2025 at 04:29:39PM -0800, Andrew Morton wrote:
> On Thu,  6 Feb 2025 15:27:40 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > This a next version of Alex's "kexec: Allow preservation of ftrace buffers"
> > series (https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com),
> > just to make things simpler instead of ftrace we decided to preserve
> > "reserve_mem" regions.
> > 
> > The patches are also available in git:
> > https://git.kernel.org/rppt/h/kho/v4
> > 
> > 
> > Kexec today considers itself purely a boot loader: When we enter the new
> > kernel, any state the previous kernel left behind is irrelevant and the
> > new kernel reinitializes the system.
> 
> I tossed this into mm.git for some testing and exposure.
> 
> What merge path are you anticipating?

I think your tree is the most appropriate, but let's wait for Acks from x86
and arm64 people ;-)

> Review activity seems pretty thin thus far?

Yeah :(
Maybe with Pasha's version on top of that we'll have more people reviewing.

And here is another fixup for a sparse error kbuild reported:


From e1e34b96b96b89a01ee31be223c8dfc2ce1c4cbe Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Fri, 7 Feb 2025 09:55:03 +0200
Subject: [PATCH] kho: make bin_attr_dt_kern static

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index c26753d613cb..c21ea2a09d47 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -258,7 +258,7 @@ static ssize_t dt_read(struct file *file, struct kobject *kobj,
 	return count;
 }
 
-struct bin_attribute bin_attr_dt_kern = __BIN_ATTR(dt, 0400, dt_read, NULL, 0);
+static struct bin_attribute bin_attr_dt_kern = __BIN_ATTR(dt, 0400, dt_read, NULL, 0);
 
 static int kho_expose_dt(void *fdt)
 {
-- 
2.47.2


-- 
Sincerely yours,
Mike.

