Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877C2C021B0
	for <kexec@archiver.kernel.org>; Wed, 19 Feb 2025 07:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2/XOsfp0uEDM7ykATYgQhbRl7Qt7nib+LAHyAGWNp64=; b=eDR/qcMycf+Ns66Rgu4SMkMce/
	QB0osH2VvxrpEc43XmX7S7JzNsJWTwRqaF4ApLmZnmg/D7G+/AzLb5eGAxgFptMbyDKpexJU5j8Sf
	MO1Gax8lO7SD6AWBnmhbsHlhQ5GuW0zAyIeLn0FRqXReSKZe96LgMcr/2ZDtzuNViJ5hMRGuwN4Jq
	c1L69dhMd+QoVzblan5k+93zAGCnD556ha/pkXmx7JIPinO1aLmsG6U4pzfvYWJrMLVavfcqMypS+
	sQko13DWFtKil86cTRAp415BbsHjS2U+d8jXIEhzWH7XqtdpZ7uH/YCFO2q4HF9ryXbQ5m1NXP7xR
	JD7CiCPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkehN-0000000BIpc-0Wc5;
	Wed, 19 Feb 2025 07:40:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkeZg-0000000BGYU-3SlX;
	Wed, 19 Feb 2025 07:32:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7EF095C4649;
	Wed, 19 Feb 2025 07:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F07C4CED1;
	Wed, 19 Feb 2025 07:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739950371;
	bh=IU+pHUXldmRuJqluDgSiOT9EDGFnrS7y3gSj3xCGbVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bA71nhcLnBv4vVc6bzgMzt4pcW92PdxJcYfbTt8KMC68oKcFO7FfjZsO6EXrZWchl
	 Nmf7yFEHV+k3l6FR4r5n/w9/dOE/MgAfqavsjDv3Gxl6m2kgk0td6LefolW/tdq4vk
	 IQGJ71D7cCbtmVBKFWdpdylHgF1T4KHDqMxX/3ifie06MKaZHrdtFXOMHJVsfhd2gu
	 4P4M5HUSM3yduXdDxCu6tEG4DMvehgF39yoJqdbeJUI5cTCWgLsXZpSwZcWgYKkLNm
	 FTFZnXtSVFsFSCIsXBBp5pAB1gXIC0M5l2+gRyX7OFT9Mo9AFvCtwqfqTYSiu7XvFT
	 Ds0vM/Iq+dYLA==
Date: Wed, 19 Feb 2025 09:32:31 +0200
From: Mike Rapoport <rppt@kernel.org>
To: RuiRui Yang <ruyang@redhat.com>
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
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
Message-ID: <Z7WJD6eBLuIRnLwk@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <CALu+AoRMQyRDFS_4L0KQkmrFT_S+yk=uZ-Mqt86JQYKKnj-5Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoRMQyRDFS_4L0KQkmrFT_S+yk=uZ-Mqt86JQYKKnj-5Ug@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_233252_913594_C85F2FE6 
X-CRM114-Status: GOOD (  19.05  )
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

On Mon, Feb 17, 2025 at 11:19:45AM +0800, RuiRui Yang wrote:
> On Thu, 6 Feb 2025 at 21:34, Mike Rapoport <rppt@kernel.org> wrote:
> > == Limitations ==
> >
> > Currently KHO is only implemented for file based kexec. The kernel
> > interfaces in the patch set are already in place to support user space
> > kexec as well, but it is still not implemented it yet inside kexec tools.
> >
> 
> What architecture exactly does this KHO work fine?   Device Tree
> should be ok on arm*, x86 and power*, but how about s390?

KHO does not use device tree as the boot protocol, it uses FDT as a data
structure and adds architecture specific bits to the boot structures to
point to that data, very similar to how IMA_KEXEC works.

Currently KHO is implemented on arm64 and x86, but there is no fundamental
reason why it wouldn't work on any architecture that supports kexec.
 
> Thanks
> Dae
> 

-- 
Sincerely yours,
Mike.

