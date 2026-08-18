Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBF8C5DF7E
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 10:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Koz3r/AfThNLRrBgrtFERGCjlw/bQbRflD0M4YMQKNo=; b=mbB7xQSrYRRTdb/ShLMWgeBBZ3
	7+BAZbBno0mJd4rzQ7yhAczKK79MxK0s5v7w/xQrPS9/xwCY0XHai0N/PtXgjc+3tR59F4j3Bcwy0
	apbNuffRfWo4yGPeqSaOQiHyzZwgolWHD49YV4UZfluc+cS9yx5fCu5GwDCy37+jMRGIheN0P3zcx
	1vZpdW5MPmZGmS0g8n5KVjMCBR15+5uI6I0qYWdbpK2P/Dr+JwQxzpUGS5Ns0oHbGKwjSDAt0X5mt
	Jv/ZdCOfP6ZiI6oUP1s6958gY4GjVU5g/+JNOv2+5VTACyyS9j8H//lCyxnCjVq0pgUumEBO4qIZl
	8sUvcTMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwHX7-00000007nYb-3Q0V;
	Tue, 18 Aug 2026 10:59:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwHX6-00000007nY9-0XP8
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 10:59:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 34D09601E0;
	Tue, 18 Aug 2026 10:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3811F000E9;
	Tue, 18 Aug 2026 10:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787050742;
	bh=Koz3r/AfThNLRrBgrtFERGCjlw/bQbRflD0M4YMQKNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ihoilFApSOAE34vYAawnEXEPs2f7u8XzfhkPsgG2g14u5Q5sWxPAMOf71YALTPv8v
	 fZyOdM6N19EY1DCuJzEcAgnNo9BvWctVjcxlxlZit/W1UkRoq7AnILj/k5I3fXHckj
	 grBgpSIdu0Uxj74rIVP2vJjPjRmaX/GeuFFr/SaBlUOHJG0teMz5FRbtdoS1mfTTJB
	 rv0RjYc0NXjBPQIsE0OKcZEy6Z5T+gJWmnkPZfyepE74gvHw2bKL7FMJuDxlOVEaTm
	 mjg1MlR4odsf+vaZlanjE2Ww8L2FXJYF7SZMeEpBWtRQBMi5LcfJ29f2343Zn26qLX
	 CFZBDHwCrHJwA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Gregory Price <gourry@gourry.net>,  Pratyush Yadav
 <pratyush@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Mike Rapoport <rppt@kernel.org>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,
  Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@kernel.org>,  Lorenzo Stoakes <ljs@kernel.org>,  "Liam R. Howlett"
 <liam@infradead.org>,  Vlastimil Babka <vbabka@kernel.org>,  Suren
 Baghdasaryan <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,  Thomas
 Gleixner <tglx@kernel.org>,  Ingo Molnar <mingo@redhat.com>,  Borislav
 Petkov <bp@alien8.de>,  Dave Hansen <dave.hansen@linux.intel.com>,  "H.
 Peter Anvin" <hpa@zytor.com>,  Ard Biesheuvel <ardb@kernel.org>,  Ilias
 Apalodimas <ilias.apalodimas@linaro.org>,  Saravana Kannan
 <saravanak@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,  Baoquan He
 <baoquan.he@linux.dev>,  x86@kernel.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-efi@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/4] kho: rename "scratch" to "bootmem"
In-Reply-To: <20260817145231.GA579285-robh@kernel.org> (Rob Herring's message
	of "Mon, 17 Aug 2026 09:52:31 -0500")
References: <20260811162642.3504565-1-pratyush@kernel.org>
	<aoMdJ7hpr1GonLz8@gourry-fedora-PF4VCD3F>
	<20260817145231.GA579285-robh@kernel.org>
Date: Tue, 18 Aug 2026 12:58:55 +0200
Message-ID: <2vxz4igr1yq8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Aug 17 2026, Rob Herring wrote:

> On Mon, Aug 17, 2026 at 10:42:00AM -0400, Gregory Price wrote:
>> On Tue, Aug 11, 2026 at 06:26:36PM +0200, Pratyush Yadav wrote:
>> > From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> > 
>> > The term "KHO scratch" is vague and overloaded. It does not accurately
>> > describe what the memory is for. This was discussed previously at [0].
>> > The conclusion was to rename "KHO scratch" to "KHO bootmem", since this
>> > is memory passed by the previous kernel for early boot allocations.
>> > 
>> 
>> This seems like a lot of churn to just rename some stuff, especially for
>> a term "scratch" which is very much understood to mean "temporary
>> working memory region" in common computing parlance.

Gregory,

Maybe. The people who work with the code on a daily basis (me, Mike,
Pasha) think the rename is worthwhile because it helps us grok the code
better.

I think patch 1 and 2 should go in for sure. They make a noticeable
improvement to memblock's code. Without that, memblock might have some
memory marked as MEMBLOCK_KHO_SCRATCH that is part of "scratch" we got
from KHO, and then some other memory also marked as MEMBLOCK_KHO_SCRATCH
that we discovered at boot. Then later, the "scratch from KHO" needs to
be initialized in a different way from "scratch discovered at boot". The
rename to NOPRSRV makes it way more clear what the properties of the
memory are and how memblock should use it.

For patch 3, I am honestly surprised at how large it ended up being. But
I am in principle opposed to the idea that we should not do any
housekeeping because it might cause "churn". So I think if the end
result is better then churn shouldn't stop us.

Of course patch 3 has a lot of potential for bikeshedding so we can
argue all day on what is better.

>> 
>> The boot param name change would also cause breakage for existing
>> systems that update and depend on the scratch parameter.
>> 
>> Is there a non-verbiage reason to justify these changes?  Living with
>> "scratch" seems better than potentially breaking folks.

I renamed the commandline option because similar things have been done
in the past for other options too.

See commit c5bfece2d612 ("nohz: Switch from "extended nohz" to "full
nohz" based naming") for example. It renamed "nohz_extended" to
"nohz_full" because it is "a bit opaque and vague".

Or commit 9406415f46f6 ("sched/debug: Rename the sched_debug parameter
to sched_verbose"). Or a94e88cdd805 ("ACPICA: Tables: Avoid SSDT
installation with acpi_gbl_disable_ssdt_table_load."). Or 632ff6170647
("x86/microcode: Add microcode= cmdline parsing"). There are a handful
more.

So I think there is a bit of history of command line options being
renamed to names the developers think are better.

Also, I would imagine very few people are using kho_scratch= blindly.
Since kho=on already does a pretty good job of automatically selecting
the sizes, most people should not be using this option at all. Manual
sizing of scratch areas is tricky and should only be done very carefully
by observing each system's characteristics. And the numbers should be
re-calibrated on each kernel upgrade since a new kernel might use more
(or less) memory at boot. So really, I think the change is a lot less
disruptive than you think.

That said, I am not opposed to keeping backwards compatibility if
someone _does_ complain.

> I don't think these are the first breaking changes. And if the changes 

Rob,

What do you mean? None of the KHO's commandline options have changed
before. And KHO has no uAPI to break in the first place.

> are fine, then that means more breaking changes are fine, too. So why is 
> this upstream at all until the design is settled?
>
> Rob

-- 
Regards,
Pratyush Yadav

