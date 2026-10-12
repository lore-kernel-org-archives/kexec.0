Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A674FCA9ED1
	for <kexec@archiver.kernel.org>; Mon, 12 Oct 2026 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=limYlGucbLfnD6/B196ITj8VoydVRIr6Jy1/waZAj8E=; b=I5UPJq9HUoe5X2MARb9dR6ebMP
	bjNVsaGwyvTt+D231v8JhCvXBMFKxHoZvxHFrcT32rvCQiWkhgydlB95+summc3mAd3HbrPbyukya
	H19sTD5KnueopboTEJ3KGVPHIcEcAX2k7yd3zrZRsHhc6vJu0YIPyk7DBeTXPJoXYVux6XPCTVWzZ
	aC/1ZjsJgvFkncSbucIJyXVg0Jq+lN/yg1zzOONVG7abpryJkUZbFB9ACL0WkYH6UPxNqydVpz/78
	RxyOb4K6zCS6XUS4eXTOt4onVfWk09Kbixaqn5W5fVTKuDAoBFTrIr0R7MPJf5Fi7NrDRTdh5tKB4
	8uFY7ziw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGIIB-0000000At5f-0Fdi;
	Mon, 12 Oct 2026 15:50:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGII9-0000000At5N-2fcS
	for kexec@lists.infradead.org;
	Mon, 12 Oct 2026 15:50:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F30D0418D8;
	Mon, 12 Oct 2026 15:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3871F0089C;
	Mon, 12 Oct 2026 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791820220;
	bh=limYlGucbLfnD6/B196ITj8VoydVRIr6Jy1/waZAj8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=R3dX9MUsVzFhlYf/JqRbrpziAFTT8EEiwanDofQ6t1q9WwenOmpt1fVFkJUPT+47G
	 3lErBIH1u84D0EZMGlqFMTQeNlZZqb2G0b1RRiAPF4OW9tzDoNivyUlI4HpZUnkFJG
	 1Ti1bf0m0jNEcdfwrcs5V4FBNRKh32yB48B1ce7q4tdqsLmXHxsldH/zFbs/Pc7rih
	 F36v9vtzv2tfJKPVow3s/k1FfBcfY1cFIJLjttqNj/TJsktXXxEyIdabIU75U2PWVh
	 7XP+Vt8BMKKZ1Z1YzXzMS3bYkyAf6iamntYUztBn6CE9+P0CPSDin5qNPLh3mq369j
	 VQ8RJ4+xIJvng==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>, Tarun Sahu <tarunsahu@google.com>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/5] liveupdate: LIVEUPDATE_SESSION_RETRIEVE_INTO_FD
In-Reply-To: <20260901180713.4185641-1-dmatlack@google.com> (David Matlack's
	message of "Tue, 1 Sep 2026 18:07:08 +0000")
References: <20260901180713.4185641-1-dmatlack@google.com>
Date: Mon, 12 Oct 2026 17:50:17 +0200
Message-ID: <2vxz7bjmkjeu.fsf@kernel.org>
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

Hi,

On Tue, Sep 01 2026, David Matlack wrote:

> This series adds support for LIVEUPDATE_SESSION_RETRIEVE_INTO_FD, a new
> UAPI to enable preserved files to be restored into a userspace-provided
> file instead of a kernel-allocated file, and uses this to support
> preserving tmpfs files in-place without any changes to the LUO ABI.
>
> The Live Update Orchestrator (LUO) API currently explicitly returns a
> new struct file for every preserved file during retrieve() (e.g. via
> memfd_alloc_file()). This then forces userspace to use anonymous memfds
> for all in-memory files it wants to preserve. This works reasonably well
> for VM guest memory but does not work well for other types of files that
> userspace may want to preserve (e.g. in-memory logs, binaries,
> configuration files, etc.).
>
> Preserving entire tmpfs mounts in-place would require a large amount of
> kernel support and would effectively make tmpfs an ABI, which is a
> non-starter (or so I hear). Instead, we can delegate the reconstruction
> of the tmpfs mounts (directory structure, permissions, etc.) post-kexec
> to userspace. The kernel just needs to preserve the contents of tmpfs
> files and provide userspace a mechanism to restore those contents back
> into a specific file on the filesystem after the kexec. Hence,
> LIVEUPDATE_SESSION_RETRIEVE_INTO_FD.

Based on the discussion at LPC, we came to the conclusion that this is
the path forward.

Before reviewing the code, here's an idea that Pasha briefly brought up
briefly at LPC, and I more or less agree. I'd like other opinions on
this.

Should we make the interface more generic by allowing userspace to pass
extra arguments to PRESERVE_FD and RETRIEVE_FD? This effectively gives
each file handler an additional uAPI of its own. The upside is that it
would be more extensible and we should be able to accommodate more use
cases with this. The memfd/shmem extra uAPI will take an optional target
file to retrieve into.

For example, the guest_memfd patches might use this to tell the KVM FD
to retrieve the guest_memfd into. Of course, KVM needs to see if this
makes sense (alternative being preserving the KVM FD too), but this is
just an example of how it might be used. I think VFIO also does some
workarounds by using an anon inode on retrieve. It perhaps might be
useful there too, though I don't understand that problem well enough to
talk in more detail.

>
> An alternative approach to restoring data to a named file would be
> supporting a zero-copy sendfile() that can be used to convert named
> tmpfs files to/from memfds across the kexec. But this poses significant
> challenges on the *preserve* side since the preserved file might still
> be actively in use. The benefit of the retrieve-into approach introduced
> in this series is that it does not require dealing with two different
> files. There is only ever one file that owns the preserved memory.
>
> By leaving file and metadata allocation purely in the purview of
> userspace, programs can create the target files where they want, with
> the names and security permissions they desire, before directing the
> kernel to restore the preserved folios into them.
>
> Currently, only tmpfs shmem files are allowed as valid target receptors.
> Attempting to target populated files, or anything other than an empty
> shmem file, will trigger -EINVAL. HugeTLBfs files could be supported in
> the future.

I suppose we should rename all the memfd_luo_* stuff to shmem_luo_*?

>
> The coding work for this series was done with assistance from Gemini. I
> am not sure what is the latest recommendation is with respect to adding
> Assisted-by tags, but I can add them when I send out the real patches if
> this RFC looks acceptable.

The latest guidelines per Documentation/process/coding-assistants.rst
seem to be "Assisted-by: LLM".

Although in _my_ opinion, I'd reckon most patches these days are
assisted by an LLM. The code might not necessarily be generated by an
LLM, but I think a large majority of developers use LLMs in some
capacity during patch development. So "Assisted-by: LLM" doesn't add any
value to me. Other people seem to find it useful, so please do feel free
to add it to your patches.

[...]

-- 
Regards,
Pratyush Yadav

