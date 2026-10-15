Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304CFCCA464
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 21:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mI5j2QSx7YHmNnf5OMmNmLr/+3VlhYuDRCjBR0r1XZM=; b=vvFzlJMP/sZhkAtw+uEVzzkRLq
	CBFCvwMQXEpemy/yxNq6fg0NFZ5vNeYfSBiuigNZd0NBp8BZP5P5vvIhBjbj1uObFd60BFAteHcRI
	Prxo8nr1jbt5oH3+xqh7Ybp6VkrvwlglPYlVrIklIAS/JlNcLrn1lT0P1csWUmJwCo9dFyI+vCIL4
	qUBe7zBTnkkOh3YN9CVJBlpjl78Y1G7zFjkmwTqtLhAIyvqmO5Dd3EYDOFUakW7o6FsmP2tEGGxZK
	XEZhjjks/3B6aUVH8HhKrz7BG1/48wDDC/jAv1CFUSMSyfOMj1wSlXrNqwhRzNNSMt0BoGia8FySq
	GXozPWEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHTOK-00000001Sya-05hU;
	Thu, 15 Oct 2026 21:53:36 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHTOH-00000001SyG-3vGI
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 21:53:35 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-3ab3260b2cdso2647082a91.1
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792101213; x=1792706013; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mI5j2QSx7YHmNnf5OMmNmLr/+3VlhYuDRCjBR0r1XZM=;
        b=bvxvbu2qvEJ3ZxdwlyKl9LPDzodf9sl2awRM0Nhwi6QXu8BsSXp7CRgE71HJ6c4YOQ
         83sWSOfhQeVM4ZKTqQxhdbFWOqc4Z7BHZ+W8YCPYxHEKHE+0pzMx47lB6Gcx87r0g1JQ
         IDvBB1JtYNASfeKW2MEkH+/abOhIBY9jBRCPw9zuSmaOInoTjPaI3jPcHej5hJRISQDa
         7lYy/jH1LDSPIBBF9OK+OWqPGye/kvUx+6g8+ELauzLz7HDIMSrCzRZ+Ha6GA9YrLrJo
         OqxK2MjBQk7Gy71FOhaz5U5SQAfX0Y7lebDNWRXrmAdU0ae7Gupabx2U4MMZbHR2mEAj
         Tl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792101213; x=1792706013;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mI5j2QSx7YHmNnf5OMmNmLr/+3VlhYuDRCjBR0r1XZM=;
        b=wvExk2oivM2SQk9VKgE6gKtHgSC8fjb37gfNIPVPU2C+FGBnQjOgBMGWdja8oxd+XP
         eWcBOGy2w5zKRkB328/BhKeai7UCrD0pAgVbGNK19vJWhUwxD9a2x2HZl3e0wQPtkUIs
         8qlhar+Eqpfx8pYEKlak5Z1eUT2QdAlLV4waI0UWlQ19BDH3YbypoBTx27667JMp7nP1
         aqUC83WOyFokoiVcQnoZ5fMBuMNp+MnpIZhEBa4jTJVAMzYWM9/djuhyys2kJk3MULV1
         SfKlCA+yWREMmsbC1KXfLQSpGpNEfq8Bl9cE4lx1o9W96RDQguvH9tuZggc2/7JOOazC
         P0FQ==
X-Forwarded-Encrypted: i=1; AKwUvBzU/HcO1SEqxCgG2khWVU04FBVlQ+NqHQh8ETMLGIT8G6b8DgTdPx0JxqdmEvbCughC4t6Q0w==@lists.infradead.org
X-Gm-Message-State: AFq9FYIUVeOilYW1W5lUswKV0oS8ElHJef/s3pG+QOdI1hSJxlV1DDJU
	iGATgwKMs+/PF9Lc0M0u6Asb1V60oDxc8bu4ESaFvXruMJl3i3iAyLkjGqmzP5Cbug==
X-Gm-Gg: AYBFou1+DE/z++IJZL6M3MHgXYcMWkVazF1hl1OGCqh7Pf8oIr7lBsRCpkpo87spK8e
	wmHFu4SHoGwcdo9L7vtY9nyrMTp88aV3kN8REV4H9NLacRBa6rIQmzSS1/0Up5S/Ss7zS+LRoWD
	qlWsraljifjA1Tlqqo9smZocgDIA/O079L5nEJ+oqAJBXoRDl+rxuFEqWt/x/RVU8tu49HO7Tr5
	j7JFddmbNoyNOJvTVTx8K3yv89BbvqOP45BS7kJH4USdTU0X3Mw9mpvYYyjncq+hxt4mGFXp/d3
	5yqANLn4Cx3CsHq3YRhtWMuuufl8oLDxdOJS9vqFJWlAaGRChao4rm9Cm5mvy9dL2SRp19uxS5y
	rVmyv9cvjPcwev81sdHvHQtpC8to1zolQuSj4VCncMfgqbi6Hk5NPE2mLlyHJoUF9yMSqDhwtUm
	ahsdfmWSAJS9W5T2YZV7/3X026TF07FLOkLw7KbuhG9cyj3uzvgTgEHYeWjMyaDZPv8LH0LaNoD
	jI4fv5OSu4kPlZhINSsdxLLIPTZIMXYL6GdvgDgEbma5g==
X-Received: by 2002:a17:90b:5343:b0:3ab:188b:c5bc with SMTP id 98e67ed59e1d1-3ab3a94f0dcmr16931016a91.14.1792101212423;
        Thu, 15 Oct 2026 14:53:32 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48e8646sm865063a91.10.2026.10.15.14.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:53:31 -0700 (PDT)
Date: Thu, 15 Oct 2026 21:53:27 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org, vipinsh@google.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	pratyush@kernel.org, graf@amazon.com
Subject: Re: [PATCH v1 0/7] liveupdate: tmpfs preservation and early freeze
Message-ID: <atFLV3tT0s3y6zMp@google.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
 <atESAwf17pJ11S9U@google.com>
 <atEaPuWNOm5VLc7A@google.com>
 <atEhc20Zawj4D62x@google.com>
 <atE53vmlDeA4cWD2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atE53vmlDeA4cWD2@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_145333_977623_4BE2BF0D 
X-CRM114-Status: GOOD (  24.25  )
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

On 2026-10-15 04:38 PM, Pasha Tatashin wrote:

> What if instead of retrieve-into an existing file FD, userspace passes
> a dir_fd on the target tmpfs mount where the file should be restored?

This is good. This eliminates the pinning race and also eliminates the
checks v1 had to do on the userspace-provided file.

> During preserve we can record the file's basename if the file was linked
> (or mark that it was unlinked). On retrieve, creates a brand-new file in
> dir_fd (e.g. starts as an unlinked O_TMPFILE on that tmpfs superblock),
> populates all the folios and metadata while the file is still unreachable
> by anyone else, links it into dir_fd under the preserved name at the end
> (or leaves it unlinked if the original file was unlinked), and returns
> the FD of the new file to userspace.

I don't think the name should be in the ABI though:

 - Userspace already has to know what each token is, so it knows the
   name. And a basename isn't enough anyway, since userspace still has
   to supply the directory.

 - "The name" isn't well defined. A file can have several hard links,
   and it can be renamed or unlinked between preserve and freeze.

 - Linking in the kernel needs a policy for collisions, and linking at
   finish() can fail (or find the name taken) at a point where there's
   no good way to report it.

 - The name isn't the only thing needed to create the file properly.
   There's also the mode, the owner (fsuid/fsgid, setgid directories,
   idmapped mounts), default ACLs and LSM labels, the access mode of the
   fd, and whether the file may be linked at all. If we record those in
   the ABI it grows a lot.

What if we model the retrieve args on open() directly? RETRIEVE_FD
behaves like openat(dirfd, ".", O_TMPFILE | flags, mode), then fills the
file, then returns the fd:

  struct liveupdate_memfd_retrieve_arg {
  	__u32		size;
  	__s32		dirfd;
  	__aligned_u64	flags;	/* subset of O_*, ORed with O_TMPFILE */
  	__aligned_u64	mode;
  };

In the kernel this is file_open_root(&dir_path, ".", O_TMPFILE | flags,
mode), which goes through the same path as open().

Userspace links the file into place with linkat() whenever it wants, the
usual O_TMPFILE way, or passes O_EXCL to make it unlinkable. Then
there's no name in the ABI or the uAPI, no linking in the kernel,
unlinked files are just files userspace never links, and "don't link it
until it's fully populated" comes for free.

One quirk: open() rejects O_TMPFILE without write access.  With LUO
holding the file until finish, that brings back the -ETXTBSY problem for
restored binaries. vfs_tmpfile() itself doesn't need write access, and
neither does filling the file, so I think we can allow an O_RDONLY |
O_TMPFILE here.

> I would like file type to stay exactly the same, I really don't want to 
> play the game where LUO can magically change file from one type to 
> another even if from Linux internal implementation they share a lot of 
> code, they are still a different file types from the user perspective.

Ok, I don't feel that strongly. We should just do it based on the
superblock rather than i_nlink, so that O_TMPFILE and unlinked tmpfs
files stay on a user mount.

