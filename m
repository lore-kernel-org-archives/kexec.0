Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E4DCC6B1D
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 13:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4n9LUBp/94FrA7OEAIK6wGrf06ppdChh63JRq9nGxWk=; b=WZKHskfsw5Pg7YYSvn6MnXvF3X
	b+xj4Ea6xgNG3ou33+Hti5bcLMiShoQvFnlA6qBvrQ3DlbRQtgPjz6oVUtJlKWp6CbP6b/BQoNJu2
	bOYGPmiC2G55tU7QuYoPOFvweqmSPdGcrHxfpxeFyPd8Fp/MApOQgrV6n0vddFn0pmBoNnofUp4MQ
	Q0AFJjOGQDDvn6+FfTFTW/ruBGMNNDUSUlQCkSMhPnUDhN+o3meQGF7b8J+hFUCZlVzM1wPyGvLe3
	C9lyLtExfSjH2Ynct2aDSB2HfN7luNvNWOclr9jHohZhixP+crtJ3vC4EL55QeFsv1sitSCwkmdT9
	vACNAq2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyuM-0000000FZSc-1ghj;
	Wed, 14 Oct 2026 13:20:38 +0000
Received: from mail-ej1-x648.google.com ([2a00:1450:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyuJ-0000000FZPh-1DVD
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 13:20:37 +0000
Received: by mail-ej1-x648.google.com with SMTP id a640c23a62f3a-c319731f460so110507566b.1
        for <kexec@lists.infradead.org>; Wed, 14 Oct 2026 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791984027; x=1792588827; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4n9LUBp/94FrA7OEAIK6wGrf06ppdChh63JRq9nGxWk=;
        b=AsqrTdecRyKwdnsHKt3IgfYw67m+rcr0QWjC/WksmbgOzZo+OdyWaiKHFcwiWvIV9S
         QMY9C+X4OdxycPnk84f+emRCu4qWwIgdIXr/6Ikm6rtZ8mQP/QViXfjB2ksdS3FnT87M
         6+tjpWjTP8y9INtC1qPdDn8Ag1VI0FUdfkCNgCCj9+d7e1HKCUk68DC7hLeDV4Y8+aDg
         b3oA+GCcBjdEhE5rz/fxSxbHpA47Gw9cZn8GhjX2LnAZSjPwHfGHuyiAf7lwgY/+MXNS
         Nh3iXC+Z2ffvUv+wL2Mk7Iatu0JEkenyKt98+SaLj6utP6c+0bEoVemfJJiMavRiGtxr
         vS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984027; x=1792588827;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4n9LUBp/94FrA7OEAIK6wGrf06ppdChh63JRq9nGxWk=;
        b=ngei+5RYtatCQGCcUOet5QPd6aKRlBqqG1JNso+G2zjxgOpOeWR/dkMJmSM7+jllOg
         SlT8CrjxofsfZK60JBFverLW0kIUkSHOCaylgzriRd00tKC9Fig9Udbc8xUdjSHvi80N
         su417ZW3tPGFdF8NoBWz0shV83pM+WCEP3OOiS7Cw2MWurJxBri5VHaV4P5AJIf6MIwH
         WREN/gptbaKpZoRm0Bd2Ic/PvlKnPljUOwIQC9hZ/Fxx1DK97+nigWrMbKIMu+r/bCwv
         y2xRPWryg+Yo+g+oGvpj7qOumPI1WfKV/ImBNgPWff0F4uGNm4dG4Y3QDTD7OJ2VUWRa
         g2IA==
X-Gm-Message-State: AFq9FYLwrurnv3QwVIAm74RnKrWinzfMg7VsH3HYeg1csD/uqA4P1bKa
	ONCoCGq3QTh8OoxyqzOtzHtkb8qBJM5AJ4jgyuXG8LMersoaEPLqttrDrWR4NkCKxfYjLa3Ej0x
	yoi8sp0iM8EtbevE5Jg==
X-Received: from edcpr25.prod.google.com ([2002:a05:6402:c1d9:b0:6ae:21f4:c371])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:320c:b0:6b1:df89:7e11 with SMTP id 4fb4d7f45d1cf-6b1df899325mr5347239a12.36.1791984026642;
 Wed, 14 Oct 2026 06:20:26 -0700 (PDT)
Date: Wed, 14 Oct 2026 13:20:25 +0000
In-Reply-To: <2vxz7bjmkjeu.fsf@kernel.org>
Mime-Version: 1.0
References: <20260901180713.4185641-1-dmatlack@google.com> <2vxz7bjmkjeu.fsf@kernel.org>
Message-ID: <9huz7bjkmnae.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH 0/5] liveupdate: LIVEUPDATE_SESSION_RETRIEVE_INTO_FD
From: tarunsahu@google.com
To: Pratyush Yadav <pratyush@kernel.org>, David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_062036_854626_63CAC081 
X-CRM114-Status: GOOD (  41.81  )
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

Pratyush Yadav <pratyush@kernel.org> writes:

> Hi,
>
> On Tue, Sep 01 2026, David Matlack wrote:
>
>> This series adds support for LIVEUPDATE_SESSION_RETRIEVE_INTO_FD, a new
>> UAPI to enable preserved files to be restored into a userspace-provided
>> file instead of a kernel-allocated file, and uses this to support
>> preserving tmpfs files in-place without any changes to the LUO ABI.
>>
>> The Live Update Orchestrator (LUO) API currently explicitly returns a
>> new struct file for every preserved file during retrieve() (e.g. via
>> memfd_alloc_file()). This then forces userspace to use anonymous memfds
>> for all in-memory files it wants to preserve. This works reasonably well
>> for VM guest memory but does not work well for other types of files that
>> userspace may want to preserve (e.g. in-memory logs, binaries,
>> configuration files, etc.).
>>
>> Preserving entire tmpfs mounts in-place would require a large amount of
>> kernel support and would effectively make tmpfs an ABI, which is a
>> non-starter (or so I hear). Instead, we can delegate the reconstruction
>> of the tmpfs mounts (directory structure, permissions, etc.) post-kexec
>> to userspace. The kernel just needs to preserve the contents of tmpfs
>> files and provide userspace a mechanism to restore those contents back
>> into a specific file on the filesystem after the kexec. Hence,
>> LIVEUPDATE_SESSION_RETRIEVE_INTO_FD.
>
> Based on the discussion at LPC, we came to the conclusion that this is
> the path forward.
>
> Before reviewing the code, here's an idea that Pasha briefly brought up
> briefly at LPC, and I more or less agree. I'd like other opinions on
> this.
>
> Should we make the interface more generic by allowing userspace to pass
> extra arguments to PRESERVE_FD and RETRIEVE_FD? This effectively gives
> each file handler an additional uAPI of its own. The upside is that it
> would be more extensible and we should be able to accommodate more use
> cases with this. The memfd/shmem extra uAPI will take an optional target
> file to retrieve into.
>
> For example, the guest_memfd patches might use this to tell the KVM FD
> to retrieve the guest_memfd into. Of course, KVM needs to see if this
> makes sense (alternative being preserving the KVM FD too), but this is
> just an example of how it might be used. I think VFIO also does some
> workarounds by using an anon inode on retrieve. It perhaps might be
> useful there too, though I don't understand that problem well enough to
> talk in more detail.

I agree, While developing the guest_memfd preservation support, I also
felt the need of upgrading the preservation and retrieval ioctl to have
arguments which will make it flexible. And help decouple the VM
preservation and guest_memfd preservation. I would love to see where
this argument idea goes.

~Tarun
>
>>
>> An alternative approach to restoring data to a named file would be
>> supporting a zero-copy sendfile() that can be used to convert named
>> tmpfs files to/from memfds across the kexec. But this poses significant
>> challenges on the *preserve* side since the preserved file might still
>> be actively in use. The benefit of the retrieve-into approach introduced
>> in this series is that it does not require dealing with two different
>> files. There is only ever one file that owns the preserved memory.
>>
>> By leaving file and metadata allocation purely in the purview of
>> userspace, programs can create the target files where they want, with
>> the names and security permissions they desire, before directing the
>> kernel to restore the preserved folios into them.
>>
>> Currently, only tmpfs shmem files are allowed as valid target receptors.
>> Attempting to target populated files, or anything other than an empty
>> shmem file, will trigger -EINVAL. HugeTLBfs files could be supported in
>> the future.
>
> I suppose we should rename all the memfd_luo_* stuff to shmem_luo_*?
>
>>
>> The coding work for this series was done with assistance from Gemini. I
>> am not sure what is the latest recommendation is with respect to adding
>> Assisted-by tags, but I can add them when I send out the real patches if
>> this RFC looks acceptable.
>
> The latest guidelines per Documentation/process/coding-assistants.rst
> seem to be "Assisted-by: LLM".
>
> Although in _my_ opinion, I'd reckon most patches these days are
> assisted by an LLM. The code might not necessarily be generated by an
> LLM, but I think a large majority of developers use LLMs in some
> capacity during patch development. So "Assisted-by: LLM" doesn't add any
> value to me. Other people seem to find it useful, so please do feel free
> to add it to your patches.
>
> [...]
>
> -- 
> Regards,
> Pratyush Yadav

