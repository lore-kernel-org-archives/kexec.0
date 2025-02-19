Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB88C021AA
	for <kexec@archiver.kernel.org>; Wed, 19 Feb 2025 07:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8VZ4jL8diAc1EN7dg417QGXOWLpNluAlP2CUguqhcio=; b=HjvmhJeUbjavMMG6AFWCC05fJI
	5Apb7JDxvKasCnMAzNEKeN2mlhoRrGffLQliS96XX7ZsUTu0FxKz27oN7fK6U/OvUrv29uQBTPyrR
	LosuPjItXuoV16O1U7PZuEW7QCVkE7re8uEdRNJOWIwy3AtOrrkXpyAjNcDG/q57UPy/CDC9MBVC9
	ztAm5Z0/r446K1WMUjMbmxMF8JsEtA5VIZGy2e2UVoZn7FtPXSQNoykXx7P5l8jwXhFqokdGNH90q
	DRtDOweXAQPxd0bYJYnPAur8/KAWgaR6F6ZCFpUT5UCqnXN6TczrkMkRY0I8GmCqqSmyX8xhhsERy
	r+JIITgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkeTj-0000000BEcq-0rc6;
	Wed, 19 Feb 2025 07:26:43 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkeSm-0000000BEJp-3mmE;
	Wed, 19 Feb 2025 07:25:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 49C5BA41F32;
	Wed, 19 Feb 2025 07:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25288C4CED1;
	Wed, 19 Feb 2025 07:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739949943;
	bh=mn7g0i0MWinLv2YGo+kZxHpbfVUa4TgH6wIWEUwX83A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jo0MN+L40nZsA1Z3XLmqtTAFU4+nInYDLglMHXNfS2AWgOzeetC9vn00TVjVV+H9+
	 rQaOBtcGPzPXGVyyTiFcCpL/nBV8pOM8Q4gmV4co22EBNknyhAhIQ5IzurwH1xZs5D
	 9ZupQiXqdfdhBvy4JD5VrKUeuKr1eVOMSSkdgtpySL+EufzrfLjrRGqbFNvu3nHa6B
	 /b5W+Y0ntMGSBuAk5O+mNwS70ivu6sfNCZi3UJ8fCaFpIZ1/CRE0Cn1aAnZq16m/Q5
	 Um3231KPD8ZPih0fAIySoNxdGrfA0cv8JPQSfDj/hyxBae0+mQMSkcmUV9eOwlWzAf
	 EzSsDgPrKpVQQ==
Date: Wed, 19 Feb 2025 09:25:23 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
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
Subject: Re: [PATCH v4 13/14] memblock: Add KHO support for reserve_mem
Message-ID: <Z7WHY5RBJc9YxPPY@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-14-rppt@kernel.org>
 <20250217040448.56xejbvsr2a73h4c@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217040448.56xejbvsr2a73h4c@master>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_232545_067094_EA4FC239 
X-CRM114-Status: GOOD (  24.85  )
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

On Mon, Feb 17, 2025 at 04:04:48AM +0000, Wei Yang wrote:
> On Thu, Feb 06, 2025 at 03:27:53PM +0200, Mike Rapoport wrote:
> >From: Alexander Graf <graf@amazon.com>
> >
> >Linux has recently gained support for "reserve_mem": A mechanism to
> >allocate a region of memory early enough in boot that we can cross our
> >fingers and hope it stays at the same location during most boots, so we
> >can store for example ftrace buffers into it.
> >
> >Thanks to KASLR, we can never be really sure that "reserve_mem"
> >allocations are static across kexec. Let's teach it KHO awareness so
> >that it serializes its reservations on kexec exit and deserializes them
> >again on boot, preserving the exact same mapping across kexec.
> >
> >This is an example user for KHO in the KHO patch set to ensure we have
> >at least one (not very controversial) user in the tree before extending
> >KHO's use to more subsystems.
> >
> >Signed-off-by: Alexander Graf <graf@amazon.com>
> >Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >---
> > mm/memblock.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 131 insertions(+)
> >
> >diff --git a/mm/memblock.c b/mm/memblock.c
> >index 84df96efca62..fdb08b60efc1 100644
> >--- a/mm/memblock.c
> >+++ b/mm/memblock.c
> >@@ -16,6 +16,9 @@
> > #include <linux/kmemleak.h>
> > #include <linux/seq_file.h>
> > #include <linux/memblock.h>
> >+#include <linux/kexec_handover.h>
> 
> Looks this one breaks the memblock test in tools/testing/memblock.
> 
> memblock.c:19:10: fatal error: linux/kexec_handover.h: No such file or directory
>    19 | #include <linux/kexec_handover.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~

Thanks, will fix.
 
> >+#include <linux/kexec.h>
> >+#include <linux/libfdt.h>
> > 
> 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

