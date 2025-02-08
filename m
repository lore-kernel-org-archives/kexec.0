Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835FDC02199
	for <kexec@archiver.kernel.org>; Sun,  9 Feb 2025 08:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DdV0CpD28PU9+NJG4gRe2c2s9k+Um9Re0nUCXPDAbKk=; b=eKwfa56ioWmYVcsjQpNH0L87/V
	Fg2g9Bm4qcA54V0KrikrNfm4O6imMtIwrn6VNf+7f3xkbD3YoLOXgPjFIF+LYS1NXbSHTE6ygPLSQ
	fLKkCRMgto6s921LQfJfmKsrs8+Psb8PJ8cr8pwx00e3IxAFBBMxGfdAYjzy+nALvcIwsqURH1CG+
	j0uIpFFL1EF2Pi3Xf0yEQpCj5SPcMuZseiaINSkztGq5AAII7znaL84ePg3usKZzYBgw7R+UdWWqy
	+EPmqUBK7MQ3cvlqWJvEvEow+dKPoImJWAm9v7de9hNQHeXExjxzTg/LuZmBotJiNGLkNFBQLH7Jr
	uohDyoDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1th2Hv-0000000EJWk-18t1;
	Sun, 09 Feb 2025 08:03:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tggPN-0000000CUrk-3k4z;
	Sat, 08 Feb 2025 08:41:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CE6635C06B6;
	Sat,  8 Feb 2025 08:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F32C4CED6;
	Sat,  8 Feb 2025 08:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739004108;
	bh=E5gL8dRYvMRUB4RhOkfU03fhf9gt76TJAgi4Xl3jmPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kREtqi2fggdaHb5LdxuUlbR8DBCUpVZQneZJk5djPdcuD+zlfrwy3Afe7zNEJkUwF
	 ye9iA/JXQY7uM39/BkEOyuNNl7kCmFofLB6/wn6/edGIcq1WdQ288cMsymsQxm7kb+
	 93CgoBcP7Hc2cGSaJm0AtBwEdpM0WeYSJrDhd/f7fz3J8WZJHeUn08YMbyOCVrTbSH
	 LcisQvIvzKkLvkq+PrRq1rJdfYPnyfJ20e74GmlHoSlat/YjuOlllltnOzHb/Dyjlk
	 fm3BQpq17SSse+gB8/aFVhCbARUcCRdCOequOBW1EwRZ8L2VCtatJigrLrZnp23Ks+
	 NNu8GFJ88NvUw==
Date: Sat, 8 Feb 2025 10:41:27 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
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
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	changyuanl@google.com
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
Message-ID: <Z6cYt8QryoUfI0wc@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206162939.a1f86fb835f1eeb7ed73ff1c@linux-foundation.org>
 <CA+CK2bD6204AKWGOgzLMiMsnVZ=tk+DGc+VWgi3RVt2byaLJJA@mail.gmail.com>
 <Z6a1kxR2GlQoepgI@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6a1kxR2GlQoepgI@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250208_004150_019863_9746E841 
X-CRM114-Status: GOOD (  29.31  )
X-Mailman-Approved-At: Sun, 09 Feb 2025 00:03:34 -0800
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

Hi Baoquan,

On Sat, Feb 08, 2025 at 09:38:27AM +0800, Baoquan He wrote:
> On 02/06/25 at 08:28pm, Pasha Tatashin wrote:
> > On Thu, Feb 6, 2025 at 7:29 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Thu,  6 Feb 2025 15:27:40 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > > This a next version of Alex's "kexec: Allow preservation of ftrace buffers"
> > > > series (https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com),
> > > > just to make things simpler instead of ftrace we decided to preserve
> > > > "reserve_mem" regions.
> > > >
> > > > The patches are also available in git:
> > > > https://git.kernel.org/rppt/h/kho/v4
> > > >
> > > >
> > > > Kexec today considers itself purely a boot loader: When we enter the new
> > > > kernel, any state the previous kernel left behind is irrelevant and the
> > > > new kernel reinitializes the system.
> > >
> > > I tossed this into mm.git for some testing and exposure.
> > >
> > > What merge path are you anticipating?
> > >
> > > Review activity seems pretty thin thus far?
> > 
> > KHO is going to be discussed at the upcoming lsfmm, we are also
> > planning to send v5 of this patch series (discussed with Mike
> > Rapoport) in a couple of weeks. It will include enhancements needed
> > for the hypervisor live update scenario:
> 
> So is this V4 still a RFC if v5 will be sent by plan? Should we hold the
> reviewing until v5? Or this series is a infrustructure building, v5 will
> add more details as you listed as below. I am a little confused.

v4 adds the very basic support for kexec handover in the simplest form we
could think of. There were discussions on Linux MM Alignment and Hypervisor
live update meetings and there people agreed about MVP for KHO that v4
essentially implements.

v5 will add more details on top of v4 and I'm not sure there's a consensus
about some of them among the people involved in KHO.
 
> > 1. Allow nodes to be added to the KHO tree at any time
> > 2. Remove "activate" (I will also send a live update framework that
> > provides the activate functionality).
> > 3. Allow serialization during shutdown.
> > 4. Decouple KHO from kexec_file_load(), as kexec_file_load() should
> > not be used during live update blackout time.
> > 5. Enable multithreaded serialization by using hash-table as an
> > intermediate step before conversion to FDT.
> 

-- 
Sincerely yours,
Mike.

