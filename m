Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A3ECCA464
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 20:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RTVoFwqUnsU0sdHOYobwPK++xcK+Lshjclao26R+uqM=; b=IPZKFGWfUZvM3Hx95gDK+5hmNe
	Lex0pa5wQk1TvMf8bQ7NfOEbB3iVz6vYPFL5E0MMv1WgnJ0QRGHxVH77bC3FwkC8GGv9Oa9NZIwf8
	fFGn1ydoQ2X7Ihy2jhrMSMHAkZrPFeHpdZbNtSYbsfH2huVdd62HVipAV32SP9fK5LV9VxN3hcEJ2
	I9j410dwMclkMvpaTzVDM/XYbTPShktYLxPgvRMuByDPaRaR9SGORZ5VpBiMcuILYV7t+c0nMucs3
	IRXH5VTjTLkh+JtpW9CHA2aPLebuT6uxLov+HVXVB1lzxkaDPxKhskE6fzBTvuw5cqxpf5MAPWUTH
	g/PFddaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHSE8-00000001MBs-3oek;
	Thu, 15 Oct 2026 20:39:00 +0000
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHSE4-00000001MB9-44zk
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 20:38:59 +0000
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-98c7353395fso1674516241.3
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792096736; x=1792701536; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RTVoFwqUnsU0sdHOYobwPK++xcK+Lshjclao26R+uqM=;
        b=i7SouL2Qhs5ZxrXzhqtPEXU/kQPnpHNWjqV0Zq/95ehDr1SPpd5n51TSwZkgsuPiw1
         7cbg8P+/2wgvrbCsMj96lQM/JyBjoAh4plCaT3i7TSe1m5rxLpUXmd0aDblQEAkUSlHg
         M0rAFZu2N0+jNoFTBigYPUJAxS9Rncav/wt2/yKWN+fuMMruAkQfL0FGDekvv9G1vFO/
         ON9d3ZMyJnyTbUuBp3SkcwCaVIETsdzVg5NZYcvmwnjW8p2jOaa/jseP1hDJL6icN4+X
         SkRH/LaD8DOSEuVKMBeMDyx4K/bSY+VbxMbHkIhgSdWFBFQSld1MdVHqDr0cRkmjeV2V
         chBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792096736; x=1792701536;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RTVoFwqUnsU0sdHOYobwPK++xcK+Lshjclao26R+uqM=;
        b=qCkdDunuVA0AIn1fSULCmHAePNLzovrZbjDaDQuWvkLIh7Lz9ZOAsnbxD74zcSkVW/
         RR5GeinClwl7LVDCpVTNf9ZFwKd2fSneFr8d/uRl2etRCU19up9TgwWfhlM8i7eULzRR
         i3VW8rzv2JkQF9DoJ82mw5iCXa8PeuSVXPXbLnbVD52sI2IJwG3MScx5RFJyhMSGeGR1
         zcgsVDHkQ8u2+yvp7oLxyxa3u5Rmcs/uuwjJENe+6XV/7Wc7xM/WWYKKLQzPo1UN90fU
         s7ZJY3Q8zLfWF9xz/uRNa0Pt0sjQ9lzn6hp0vAkqkon2rYItO7Piwdflc9muwdsidlJv
         Jkng==
X-Forwarded-Encrypted: i=1; AKwUvBxY2XzpV7AId0B8pOppqRLGxtvY+joqczbq1zWemAtRdPPQnuWTJI+aRZpeG45o1YCeKVP5xQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYKaQDt6ZC3120NMUQ9zJmNi0qSluQUEJZXdV8GUlPR11EFwDtMQ
	dB2Gl4wUryQspxglp2XqkenGZOD8+QNxFQrhkEdjQtcvxlCB5miWWM9sPDxSqElfJgI=
X-Gm-Gg: AYBFou3AU3IUAveP5+OGy+nuM94Wyw7hFxDSvAfzcmm3csP0ECbnh7GQKrQWO1KrLWd
	u/IEiR0s81lgUnyK/A+zmItPW9Sv7YzZhleNvBtMzlr45vErrMxp3V4jq5cSpdy7winOz+j/+lm
	+JCJIjoBYzCZcT+juWOOuqbTIz1L7b3XkleVtQLj1BiIR0pKHSUrdh500ljMnN7zsQn4qIwAIA2
	UG+RG6cTQ6YpnAwSCBDe534xONL5D/wUyeTOkaJiwS3Mzk/F6BMci3Hx1Gy96jgTDvv1Th+Y9Ry
	TSljX91p/bl8JljL5JSi7RsydW/oQ1bUY9Uu50clk/+WvpoGVQ291kHEweJ2w+vZM08PzOK/ouc
	3fQcC+di0fr6HXY84LIFu0fCqivZ9XFcf9XZr+2p416Ri+3BYdPZHYCgfwd6AEWJkAMSC9oP8qF
	MRyLmw2U1pt7D8yGeMjwFf+RzIt87qjjHiAtfaSMEFAcu0EJsnszk36AYkFrcRg0/df63WaUkNj
	7m9GsRYubRO7cwsMQASuxraeiwgj3RRpre+SeNUvmZQS1qzG4shabzjHxhb9OC8QlgCnuWA2WI=
X-Received: by 2002:a05:6102:a49:b0:7c3:83a9:edca with SMTP id ada2fe7eead31-7cb36886005mr5673629137.3.1792096735597;
        Thu, 15 Oct 2026 13:38:55 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b4ae2e2sm114784e0c.7.2026.10.15.13.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:38:55 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:38:54 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org, vipinsh@google.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	pratyush@kernel.org, graf@amazon.com
Subject: Re: [PATCH v1 0/7] liveupdate: tmpfs preservation and early freeze
Message-ID: <atE53vmlDeA4cWD2@google.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
 <atESAwf17pJ11S9U@google.com>
 <atEaPuWNOm5VLc7A@google.com>
 <atEhc20Zawj4D62x@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atEhc20Zawj4D62x@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_133857_044562_8254A35C 
X-CRM114-Status: GOOD (  38.54  )
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

> > >  - memfd_pin_folios() doesn't require the inode lock, so iommufd can
> > >    pin folios of the target while they're being added or truncated
> > >    away. v1 starts with two patches that make iommufd take the lock
> > >    and make memfd_pin_folios() assert it.
> > 
> > Hm, isn't this mostly orthogonal to the change we're making here?
> 
> Kind of. Today .retrieve() fills a brand-new memfd that nobody else can
> reach until the ioctl returns. Retrieve-into fills a file that other
> processes can already open by path and pass to iommufd, so pinning can
> now race with the folios being added, or truncated away on failure.
> 
> In the failure case a folio can stay pinned (and mapped for DMA) after
> it's been removed from the file. Retrieve-into introduces the race, and
> the fix is two small prep patches.



> > We originally agreed that if retrieve() fails, we fail permanently and
> > leak resources until reboot to avoid memory corruption from ongoing DMA
> > activity. However, now that we have the retryable option, we can start
> > relaxing what is considered a permanent failure vs. a recoverable/early
> > failure that .finish() can clean up.
> 
> Ok I think we are ligned that we need to keep the preserved folios
> around until finish(). I think this point was saying there are bugs in
> the existing memfd_luo code and in this series that leak the folios even
> after finish(). Either way I'll fix them up.

I think we are solving this problem incorrectly, LUO should still always
re-create files, even the tmpfs files.

What if instead of retrieve-into an existing file FD, userspace passes
a dir_fd on the target tmpfs mount where the file should be restored?

During preserve we can record the file's basename if the file was linked
(or mark that it was unlinked). On retrieve, creates a brand-new file in
dir_fd (e.g. starts as an unlinked O_TMPFILE on that tmpfs superblock),
populates all the folios and metadata while the file is still unreachable
by anyone else, links it into dir_fd under the preserved name at the end
(or leaves it unlinked if the original file was unlinked), and returns
the FD of the new file to userspace.

That way:
1. Just like memfd today, .retrieve() always populates a brand-new
   file that no other process can open by path or pass to iommufd until
   retrieve succeeds, so the memfd_pin_folios() / truncate race goes
   away completely.
2. Userspace gets back a single new FD from RETRIEVE_FD instead of
   ending up with two FDs (the pre-created one and the retrieved one)
   referencing the same struct file.
3. Unlinked tmpfs files are also supported on the target tmpfs mount
   (preserving mount options and size/inode accounting) instead of
   silently falling back to the internal shm_mnt.

We can even postpone linking the file into dir_fd until finish(), so
that it only appears in the filesystem once it is fully populated.

Actually, I think, this is the right way to do tmpfs preservation,
instead of relying on user to provide the FD of an open file to us.

> > I do not want LUO to change the type of a preserved file across live
> > update. Take seals, for example: a memfd can be sealed with the
> > guarantee that it will never be modified, whereas a regular tmpfs file
> > does not support sealing. Allowing a preserved memfd to be retrieved
> > into a tmpfs file would create a loophole to strip seals (or bypass
> > mount/superblock boundaries). I strongly prefer keeping the file type
> > strictly the same across preserve and retrieve.
> 
> I agree that seals must not be strippable. I am not proposing to allow
> that. Regular tmpfs files are created with F_SEAL_SEAL, and v1 refuses
> to retrieve into a target that has F_SEAL_SEAL if the preserved file has
> any seals the target doesn't have. So a sealed memfd can only be
> retrieved into a memfd that allows sealing, and gets its seals back
> there the same way F_ADD_SEALS would add them. Only unsealed memfds can
> be retrieved into regular tmpfs files.
> 
> On mount boundaries, retrieving into a tmpfs file charges the blocks
> to that mount, so its size limit and quota apply. That's stricter than
> the unlimited internal shm mount that memfds live on, not looser.
> 
> This is what I mean about enforcing the fundamental requirements, rather
> than enforcing something artifical like MEMFD_LUO_FLAG_TMPFS.
> 
> BTW, MEMFD_LUO_FLAG_TMPFS is set based on i_nlink, so it doesn't really
> track the file type. An O_TMPFILE or unlinked tmpfs file gets preserved
> without the flag and comes back as an anonymous memfd on the internal
> shm mount. That changes its type and drops its mount's size limit and
> quota, which is the boundary crossing you're worried about.
> 
> If you still want the type to stay the same, we can define it by
> superblock instead of i_nlink:
> 
>  - memfds (on the internal shm mount): plain retrieve only, as today.
>  - files on a tmpfs mount, linked or not: retrieve-into only, into any
>    empty tmpfs file, including O_TMPFILE files.

I would like file type to stay exactly the same, I really don't want to 
play the game where LUO can magically change file from one type to 
another even if from Linux internal implementation they share a lot of 
code, they are still a different file types from the user perspective.

