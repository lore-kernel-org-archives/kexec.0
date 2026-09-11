Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A4BC88E53
	for <kexec@archiver.kernel.org>; Fri, 11 Sep 2026 18:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UoB/yhujSeic4Z83ePKaRXKf1DWcrbuqnOKvr88NN90=; b=HVcjDAOx0NgfPTes49Pq49VN0D
	TGtJelBTxzGKxR26/PKjH/0kOIVSfqE9ABVVJO+silJojbdOKpDxedhEfLUXDGpM2+l6qo+ekO/A3
	mzz29ud5k4ZH2VbzwFvnWQlhvUDdQhtDCRi9tl6l0iRzOaB7FZJg8BUzXj2+FI4t2zZPvx4obcQMX
	0HX07xqcPdxFfZCMnF+vyHk5TUDv4U3HkBmP100ZGv6FFrY6U5fC0Kkml2mrOcrw2/b9Hr2rUikhV
	3+p/UVOLLjgnuxilS9+gNlKqIttZUD03YuPWLdBbrCEpdUgqz9RlGfwf0RztvN8h72qDLUrIbyZJZ
	PObRKlIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x55ms-0000000HQO6-35SS;
	Fri, 11 Sep 2026 18:15:46 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x55mq-0000000HQNW-12Fo
	for kexec@lists.infradead.org;
	Fri, 11 Sep 2026 18:15:45 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-cc4d64bcea5so344465a12.1
        for <kexec@lists.infradead.org>; Fri, 11 Sep 2026 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789150543; x=1789755343; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UoB/yhujSeic4Z83ePKaRXKf1DWcrbuqnOKvr88NN90=;
        b=P8dTcbHE6hHQlFYHUnI/T4nfImuEYDW5eOKSIzUMXm5sUHM9UflDlvB+5ZL66dEg65
         FTLZZx+qygstCRbH0uzo49x7rAGJXC2VmhW7JrgWzA7ZLlFY+r3Fcfzso730Taxk7f3k
         xx+6x72GBGD4nAxa8Tl95pqECGaoI1CSJNFR/DRzLFDK8GfnG6CyIEdw7HiJcc0NCL5u
         Httm7AwOWNVVkhfcafj0KUsGgEQCjbcGDAJmB4C31TJF1x3z8G1Nln+bn/LX5tlbSMn+
         wNH2FuNF+Ei+FvckOLKzgCqWAJRcCP974icC65ESkw2edZbAaW84qaED2HKp5Fbr0Rha
         Qvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150543; x=1789755343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UoB/yhujSeic4Z83ePKaRXKf1DWcrbuqnOKvr88NN90=;
        b=L0itVnlsbYlWDO5WazKJ3Ueim4KowzBlPFiSU/Pa70uvGIh369rezubehyT99OIvxi
         gn6OSoa40iiAkAp2MkD1xER0Farh9guOzacMHnxXOUYRNCCdZBOU7csKD18mX35/9OYW
         8kz3Jvbq6Fwv4NJJSbOn1dCxhp04d7PZ/dla7/C7g8Tw+MxiBTh+ydph7097FzlotjoL
         Dn34MTU/BcW2QHEKTr+ltIFi16FiMWTJkJiiqQthxW/sczOYqeJwkXGb+vUGxszukF7W
         N14d44o/vzygmYiV+ITOMhKpwAKyaDT9hKhPCdsY1tghono7y0BWwSZ7wR63akkqkxMu
         z5Aw==
X-Gm-Message-State: AFuF++l/ATXpuyzyBNEovw5k34MlHK2iRlkjPztIO34OC9jQztBZ+VA8
	ouwjq9VWoRbsD9byy0kea2fj3cszqr4xRSDFRM06EhiT+1QgkGsvDFZNQcDJb2pL/g==
X-Gm-Gg: AYBFou0Fm9Gn7C7pzYmZa3uSPyfmgVNpmRZOlTrIkED3t0SVm7gHUtEMcOUuxEBX60A
	2ZSCplfiGQojJRa6+n7Fwmh2X8We61hQfwdKWJiEmRG6vcD/eD6x9DB68PkeNpn9jG82nU3efkp
	RCJHF2iunV5zOMuRoj/vPmAYXlnBZQIgtUdTlpHeJtSjFT1zNYD6iNEygG4ojBY3sFeqE2FMddv
	OlJdZydsPV410WoXA7ltuzd3htjBz6m0B+Smns4BBjkbA1NtxRpBTp4Jk7pzWgGA/m8+vBIgVjv
	c8RqNTXhhyEsojxZNtwjxpSc8Lyeq4GZD5ZvVtzr9CW6fyz3qvxnN4sWE1+1GvBBhv2qY6FASwl
	q/DAtP7Jh5nNFeSD6O2AmMtwic/fBZQcBIs5iz0M9qPBPYa+wKBaRkV+IkVtXmbMZMMOlj03A34
	lU7+yYz7iM6TLcDg/g7KF8aIjgTwbGWrjX2lzKcPuPnRxRf0DET87gEqMXmLPT79snA6Mm7pNkd
	dLXnEH+kyirY92iStYv2So7EGdhtifdZ04+ZYz3
X-Received: by 2002:a05:6a20:3ca8:b0:3da:bb98:b1f9 with SMTP id adf61e73a8af0-3daed4bba1dmr10454732637.9.1789150542427;
        Fri, 11 Sep 2026 11:15:42 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6550e06sm1594193a12.14.2026.09.11.11.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:15:41 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:15:38 +0000
From: David Matlack <dmatlack@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH 0/5] liveupdate: LIVEUPDATE_SESSION_RETRIEVE_INTO_FD
Message-ID: <aqRFSiicubfsw3N6@google.com>
References: <20260901180713.4185641-1-dmatlack@google.com>
 <CAEvNRgEs82CVTL_CUn=Ovrwvt86U1dxzr8psWGu=nk98ZH6Esw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvNRgEs82CVTL_CUn=Ovrwvt86U1dxzr8psWGu=nk98ZH6Esw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_111544_316750_14418AE2 
X-CRM114-Status: GOOD (  41.96  )
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

On 2026-09-11 11:04 AM, Ackerley Tng wrote:
> David Matlack <dmatlack@google.com> writes:
> 
> > This series adds support for LIVEUPDATE_SESSION_RETRIEVE_INTO_FD, a new
> > UAPI to enable preserved files to be restored into a userspace-provided
> > file instead of a kernel-allocated file, and uses this to support
> > preserving tmpfs files in-place without any changes to the LUO ABI.
> >
> 
> I'm interested in the idea of retrieving folios into an fd for a
> different reason, I'm exploring handling over ownership physical memory
> to a guest_memfd.
> 
> > The Live Update Orchestrator (LUO) API currently explicitly returns a
> > new struct file for every preserved file during retrieve() (e.g. via
> > memfd_alloc_file()). This then forces userspace to use anonymous memfds
> > for all in-memory files it wants to preserve. This works reasonably well
> > for VM guest memory but does not work well for other types of files that
> > userspace may want to preserve (e.g. in-memory logs, binaries,
> > configuration files, etc.).
> >
> 
> Does this assume that VM guest memory is usually provided using
> anonymous memfds?
> 
> More generally, is the problem that there isn't a simple way to
> implement retrieval into anything other than anonymous memfds?

Roughly, yes.

> > Preserving entire tmpfs mounts in-place would require a large amount of
> > kernel support and would effectively make tmpfs an ABI, which is a
> > non-starter (or so I hear). Instead, we can delegate the reconstruction
> > of the tmpfs mounts (directory structure, permissions, etc.) post-kexec
> > to userspace. The kernel just needs to preserve the contents of tmpfs
> > files and provide userspace a mechanism to restore those contents back
> > into a specific file on the filesystem after the kexec. Hence,
> > LIVEUPDATE_SESSION_RETRIEVE_INTO_FD.
> >
> 
> Suppose pre-kexec, the data was in a tmpfs file (and fd), how would the
> preservation work? Would the user have to
> 
> 1. Transfer the data from tmpfs fd -> anonymous fd
> 2. Preserve from anonymous fd
> 3. kexec
> 4. Set up the tmpfs fd
> 5. Retrieve into the tmpfs fd

No, the proposal in this series is to support:

1. ioctl(LIVEUPDATE_SESSION_PRESERVE_FD, {TOKEN, tmpfs_fd})
2. kexec
3. tmpfs_fd = open(..., O_CREAT)
4. ioctl(LIVEUPDATE_SESSION_RETRIEVE_INTO_FD, {TOKEN, tmpfs_fd})

No transfering to or from an anonymous fd is required.

> > An alternative approach to restoring data to a named file would be
> > supporting a zero-copy sendfile() that can be used to convert named
> > tmpfs files to/from memfds across the kexec. But this poses significant
> > challenges on the *preserve* side since the preserved file might still
> > be actively in use. The benefit of the retrieve-into approach introduced
> > in this series is that it does not require dealing with two different
> > files. There is only ever one file that owns the preserved memory.
> >
> 
> Would it be more symmetric if the process is
> 
> 1. Transfer the data from tmpfs fd -> anonymous fd
> 2. Preserve from anonymous fd
> 3. kexec
> 4. Retrieve into anonymous fd
> 5. Transfer the data from anonymous fd -> tmpfs fd
> 
> As to the exact details of "transfer", I think the best we could do
> would be some kind of move from one fd's page cache to the other fd's
> page cache?
> 
> Is the goal of the transfer to avoid any memcpy and fully transfer
> ownership (so, not just by increasing folio refcounts?)

Yes this is the alternative proposal that has been proposed and
discussed a little bit off list, with sendfile() and copy_file_range()
being the possible mechanisms to do the "transfer". I think there are a
few fundamental problems with that approach on the pre-kexec side.

 1. iommufd requires that fds mapped into it are preserved. If the file
    mapped into iommufd is tmpfs, but then we transfer that file to memfd
    for preservation, iommufd will fail to preserve because the tmpfs file
    is not preserved.

 2. Even if you only use this feature for files not mapped into an
    iommufd, transfering the contents in a zero-copy way seems
    challenging. What do you do if the tmpfs file is still in use when
    you want to transfer it?

> > By leaving file and metadata allocation purely in the purview of
> > userspace, programs can create the target files where they want, with
> > the names and security permissions they desire, before directing the
> > kernel to restore the preserved folios into them.
> >
> > Currently, only tmpfs shmem files are allowed as valid target receptors.
> > Attempting to target populated files, or anything other than an empty
> > shmem file, will trigger -EINVAL. HugeTLBfs files could be supported in
> > the future.
> >
> 
> Is this basically that at some point, all in-memory filesystems' fds can
> support transfers?

Yes, theoretically.

> 
> >
> > [...snip...]
> >

