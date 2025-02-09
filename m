Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5084C0219E
	for <kexec@archiver.kernel.org>; Sun,  9 Feb 2025 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uvkWI3cX2anxu18b6N3GYV6CIu0hENpPT5AGqx9H+vc=; b=At+AbW4bQonar9PpE9E+fLThdM
	XP6eNqE/ogih1thrJTHphzk7L10o3Uqoy6jUX2Yr8bGt1gJMFy0O6TxrNGFL7C8odju3UCxXftz3S
	qos7oDZDCheFdsO7d+85OnYU137s3UCx1G0dAAoMZu2FSnu+uNYxefKD5UcLNjNX1gRf2zc/fbx7a
	1tSPa/sa6CIxNEqNuBeTratE5ZCM1uhuYWgJYN5KyocsLflo7TnufOTv6rCARDePc2r7gghTgUnK6
	LRqY2NsFju/+CHlS86Jro5EUnGo8uYT+tTnlCgMFzwfYDyT4YM7ctSoFZb0poUepA/o4tFjHvgIzX
	V5c4fHeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1th8xS-0000000F4Ye-3cjB;
	Sun, 09 Feb 2025 15:10:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1th8xP-0000000F4XI-3V1A;
	Sun, 09 Feb 2025 15:10:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CCB195C3FDA;
	Sun,  9 Feb 2025 15:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A64C4CEE2;
	Sun,  9 Feb 2025 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739113849;
	bh=J7RPEEvR3YN2Zw3FJPrsXlkP5CHQ4ry6huE55PuC5gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vRjbl4gPV6wrAL1Op6b4UG/ZsW9dGApg6AGSIrvaNSkhp6cSEu2/MeZlFcqZZwjMp
	 VGmvNeICYY50N390bDunkJ9Pxo8RsJ0xTNfcJ1laLEVHM/S3P4HVCK7Ylo35ky9VjV
	 O3IQhIQFVExy2+rPS31ctiOp4I+goc35/Loe/O/4jtbq+ywEvbpBhgIMSbwVd3fu8Q
	 0f37CHSCjlpBrAGCyeVigrg+mNP3UavBOj7iXkp6DeeSFvXuwwlhF4XECVIDSp98q8
	 /uFv9cqyP3oCkixs4eyYjxu9KhtbCiIeLV+7GxHChQk+OC0ltm6uGrYLdetui3ZO6D
	 h8fHOZbzeBvEw==
Date: Sun, 9 Feb 2025 17:10:28 +0200
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
Message-ID: <Z6jFZII5b-j7hzkj@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-15-rppt@kernel.org>
 <45df0d7a-622a-4268-9683-c5c6067483c3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45df0d7a-622a-4268-9683-c5c6067483c3@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250209_071051_960918_547ED989 
X-CRM114-Status: GOOD (  38.69  )
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

On Sun, Feb 09, 2025 at 11:29:41AM +0100, Krzysztof Kozlowski wrote:
> On 06/02/2025 14:27, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > We introduced KHO into Linux: A framework that allows Linux to pass
> > metadata and memory across kexec from Linux to Linux. KHO reuses fdt
> > as file format and shares a lot of the same properties of firmware-to-
> > Linux boot formats: It needs a stable, documented ABI that allows for
> > forward and backward compatibility as well as versioning.
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
 
These are not devicetree binding for communicating data from firmware to
the kernel. These bindings are specific to KHO which is perfectly
reflected by the subject.

Just a brief reminder from v2 discussion:
(https://lore.kernel.org/linux-mm/20231222193607.15474-1-graf@amazon.com/)

"For quick reference: KHO is a new mechanism this patch set introduces 
which allows Linux to pass arbitrary memory and metadata between kernels 
on kexec. I'm reusing FDTs to implement the hand over protocol, as 
Linux-to-Linux boot communication holds very similar properties to 
firmware-to-Linux boot communication. So this binding is not about 
hardware; it's about preserving Linux subsystem state across kexec.

For more details, please refer to the KHO documentation which is part of 
patch 7 of this patch set: 
https://lore.kernel.org/lkml/20231222195144.24532-2-graf@amazon.com/"

and

"This is our own data structure for KHO that just happens to again 
contain a DT structure. The reason is simple: I want a unified, 
versioned, introspectable data format that is cross platform so you 
don't need to touch every architecture specific boot passing logic every 
time you want to add a tiny piece of data."
 
> > As first user of KHO, we introduced memblock which can now preserve
> > memory ranges reserved with reserve_mem command line options contents
> > across kexec, so you can use the post-kexec kernel to read traces from
> > the pre-kexec kernel.
> > 
> > This patch adds memblock schemas similar to "device" device tree ones to
> > a new kho bindings directory. This allows us to force contributors to
> > document the data that moves across KHO kexecs and catch breaking change
> > during review.
> > 
> > Co-developed-by: Alexander Graf <graf@amazon.com>
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  .../kho/bindings/memblock/reserve_mem.yaml    | 41 ++++++++++++++++++
> >  .../bindings/memblock/reserve_mem_map.yaml    | 42 +++++++++++++++++++
> >  2 files changed, 83 insertions(+)
> >  create mode 100644 Documentation/kho/bindings/memblock/reserve_mem.yaml
> >  create mode 100644 Documentation/kho/bindings/memblock/reserve_mem_map.yaml
> > 
> > diff --git a/Documentation/kho/bindings/memblock/reserve_mem.yaml b/Documentation/kho/bindings/memblock/reserve_mem.yaml
> > new file mode 100644
> > index 000000000000..7b01791b10b3
> > --- /dev/null
> > +++ b/Documentation/kho/bindings/memblock/reserve_mem.yaml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/memblock/reserve_mem.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Memblock reserved memory
> > +
> > +maintainers:
> > +  - Mike Rapoport <rppt@kernel.org>
> > +
> > +description: |
> > +  Memblock can serialize its current memory reservations created with
> > +  reserve_mem command line option across kexec through KHO.
> > +  The post-KHO kernel can then consume these reservations and they are
> > +  guaranteed to have the same physical address.
> > +
> > +examples:
> > +  - |
> > +    reserve_mem {
> 
> Again, do not introduce own coding style.
> 
> I don't understand why do you need this in the first place. There is
> already reserved-memory block.

Because these regions are not "... designed for the special usage by
various device drivers" and should not be exclude by the operating system
from normal usage. 
 
> Best regards,
> Krzysztof

-- 
Sincerely yours,
Mike.

