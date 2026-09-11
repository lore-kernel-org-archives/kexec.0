Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8320DC88E53
	for <kexec@archiver.kernel.org>; Fri, 11 Sep 2026 21:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c6HV8uHNfHnA3I2z6iazz6poKohSe+yKAEsfT8M/ffc=; b=UoP2xEf+efWwXExRZOWAcfjhhY
	/spe3Ouq+cDfRez0PTQarySCXKNcukr0wAD+P+3zNf7+rdhzktsnPZadEQf3dr2eY0aHdGnZhHb0n
	M+dRyNXFellhW2tAxj+0mFYlVxPtMPDw4OuScgAi/gCF9VQorBuAN8m49ybBfsdZOTWbbTrVEWijT
	WO4wReD5Mghrid5+DN3ZFs0oXZv0s6eVAoeYoeOF6e2712Wl/cBPAdJC2G4d/2Nhj/Eeya+dJhEN1
	LAZ5ahqH5ox9eIqquGB6C9+6+xK4GUuXBtaMrpfn1+078U64vJQRXFV48Iv+VTnW5609UoQjhKPJ+
	l5Th0IrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58Wm-000000009Ew-0bGw;
	Fri, 11 Sep 2026 21:11:20 +0000
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58Wk-000000009Ec-0NAz
	for kexec@lists.infradead.org;
	Fri, 11 Sep 2026 21:11:19 +0000
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-85469e25187so289775b3a.2
        for <kexec@lists.infradead.org>; Fri, 11 Sep 2026 14:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789161077; cv=none;
        d=google.com; s=arc-20260327;
        b=k9CofNrSMC6oubW7Nez7eL+rKa6vPBxL7kgRvBTDB3S9cP88b7616kUMYy/jV0CjEs
         Z5lOCIdmSjmTncmycb9t4PXaVDpv8dSXBub298aalyVvQygCHKRTlq+CKgv01oW89Emb
         KFgW0zLTEkF/pB+IsPyofYhS+K9Xfv3VvtKmbv/fHg+G4sKJjwjUegHGII5Ihw/2NBh5
         qLzZn7of41gsAPWLJ1XE5RAYeDs9VOue4mpvqIpsPjSzHyn1qaTk+uemAvuirUxXZ4Dw
         5yP0owDmZbSJsE2ZLfNQdj04Pb6t3bDcsrxHkpJRyCPmo/74ZHWyWa1vwWBajFQP5GlZ
         ArWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c6HV8uHNfHnA3I2z6iazz6poKohSe+yKAEsfT8M/ffc=;
        fh=jL+1W+b4SklXljBdpRK8a3qT9qLDon9+WM9pnqH6ltI=;
        b=c4FRv568CoWOmUrysNnLKLaROYiauOwDl3x5QSuh4BJ/dEuwlTOQaZeMmA3swUxL3W
         T5aEJyjNHnNg5noQF7EpnZgFoRDItSDtjL4mFj5IuYaUbv8Vpnl2mMkm6zM3+Q2knq/s
         ArRnGwPKNJqql5Na/VQ8wryB2jCA+g+RBwOWItpuC+jCWG7xt4vgC6dzr+Es9VL/oJTi
         W1cl7sn0XlH+CQhNL6BaU12T1GD4Na0WTJ8DcuwXusY0fgl8eID+xI0ydt/pxilCOmQE
         tXkwszUh/H7eqQGmnrd8Lq2uC039kjM5u0HcbU39RshmOHjbv50HPEnjMTSFF87WFepu
         DzIA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789161077; x=1789765877; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c6HV8uHNfHnA3I2z6iazz6poKohSe+yKAEsfT8M/ffc=;
        b=PwCTjZDYvvy/UQ6llGHzTaOTq/tpe0QXdVNT3IZslouVuganoCzYnEe3N+xtV2uxul
         T/3nLDmoX5cbRdk9jiok27Iq4HagkydYR0HlCcN7xVmSYFtpg2HNqnz5ntwL+ON7bZSq
         gandHqzTjOR0uu1mYSKnz8oVTbXrEaw78ixZzoV0GiaLnHennCM4qkWpnBV59XowF5Je
         3T4epuxNVSb3Mb2LeHRgXUIj7Oud84IVR6yrUaLaUdVP9YlEUcdFJX0E0SvYXzOlyJUb
         enWQ2a7u6D+/wkLxCnol5ToMksE8VKpL8b+k+e/0nQVv7sFrPieb5oh3TBbSRc6UrIKj
         GByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161077; x=1789765877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c6HV8uHNfHnA3I2z6iazz6poKohSe+yKAEsfT8M/ffc=;
        b=iHmIhSlzM9XW3tFJdMXaRxG81QlmxJ0ECqVS+kvEapb12YIP7DlKDaSlOU/r0V1NNG
         bmOxDMcXyi2bwMDOsz9YBIys8YVOCjJLMqAMGgeqZ1qwpxC14xyrFdD1yohvqqYWzuK1
         sYmulQVBh4/Jwta5vXJspljxORd4lLtm3FsA/VE7ggVv7hr2yIlWAVzsNYrhaxAyWzg2
         GeAdVSdH2R6LnXKQHnjyhCufmadOfpl1rMzGFpgfI16M4LBWqmvwYxyvPWZzOOrylVE9
         xI6im8nQw4cp0s+GtRPykMPss5Njjgo8ZXQ4YU1cOmeI7Elqm5SmOyCKn8fS7BvqeVsy
         s6RQ==
X-Gm-Message-State: AFuF++kcyS+aeuukyTCaY9tHgw+8zrIYuEqCN/Z0nx94G/GCph6isCWy
	KWzxaklYKV0V3fak5VsLjJkprFxjYRMPsfri7t4QkgsJ5F+Pi9PNuuTk4BXsomRnm/HZaJCSHUH
	f9yVnY3Jpdt7WFFeVmnxu3a7/0w+C7PcZsWmfcEgk
X-Gm-Gg: AYBFou3j6KEepDt1erNs3nDLxT6bEqDOL2M6FYiMcf6ahavqf4n1DwIDEx4v+1Ik1z1
	xsQSS04kwB4WKVc17ve4aprQ02xvNKvck59HLEjoGw4jo9usRVIxaah8b75QIJ4ALCcdSkEIKZY
	bO/2QftsrU9SPcU+YoTtZq7WArIbMoZSbgxtTM6w3xBGOTCKWlI9ZH1keP3AcLs64HNDo+p7kCd
	jbyxuQBYNPKSIutG3CekzXQHBNdr0RkWY5aNbNvpmgxIGUGmQAzV3T4A0DMdAtYmK5HQKVfZJrD
	BeOXidPzfsORa+rRmAUQfmt4V7WJLhRoX0e+X81jwhky/RLCBjMFivRL
X-Received: by 2002:a05:6a21:a95:b0:3da:6bdd:2c74 with SMTP id
 adf61e73a8af0-3daed306372mr12662047637.10.1789161076494; Fri, 11 Sep 2026
 14:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260901180713.4185641-1-dmatlack@google.com> <CAEvNRgEs82CVTL_CUn=Ovrwvt86U1dxzr8psWGu=nk98ZH6Esw@mail.gmail.com>
 <aqRFSiicubfsw3N6@google.com> <CAEvNRgFCrcyk6F0vJ11pgj2EDSUAXj6Zw-oEdZpfj2SrH1Cv9g@mail.gmail.com>
In-Reply-To: <CAEvNRgFCrcyk6F0vJ11pgj2EDSUAXj6Zw-oEdZpfj2SrH1Cv9g@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 11 Sep 2026 14:10:45 -0700
X-Gm-Features: AcwNN1VPqi3zVmYZAELfBj-CBxTUTXJC8KC_tY6rHii958hpSbyM_Grda2-osHc
Message-ID: <CALzav=cKG9hXskFgQfub3Jg5O-rKUWBe8TBcPdJz+tBKzenFrg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] liveupdate: LIVEUPDATE_SESSION_RETRIEVE_INTO_FD
To: Ackerley Tng <ackerleytng@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_141118_163320_AB33B1BB 
X-CRM114-Status: GOOD (  56.27  )
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

On Fri, Sep 11, 2026 at 1:59=E2=80=AFPM Ackerley Tng <ackerleytng@google.co=
m> wrote:
>
> David Matlack <dmatlack@google.com> writes:
>
> > On 2026-09-11 11:04 AM, Ackerley Tng wrote:
> >> David Matlack <dmatlack@google.com> writes:
> >>
> >> > This series adds support for LIVEUPDATE_SESSION_RETRIEVE_INTO_FD, a =
new
> >> > UAPI to enable preserved files to be restored into a userspace-provi=
ded
> >> > file instead of a kernel-allocated file, and uses this to support
> >> > preserving tmpfs files in-place without any changes to the LUO ABI.
> >> >
> >>
> >> I'm interested in the idea of retrieving folios into an fd for a
> >> different reason, I'm exploring handling over ownership physical memor=
y
> >> to a guest_memfd.
> >>
> >> > The Live Update Orchestrator (LUO) API currently explicitly returns =
a
> >> > new struct file for every preserved file during retrieve() (e.g. via
> >> > memfd_alloc_file()). This then forces userspace to use anonymous mem=
fds
> >> > for all in-memory files it wants to preserve. This works reasonably =
well
> >> > for VM guest memory but does not work well for other types of files =
that
> >> > userspace may want to preserve (e.g. in-memory logs, binaries,
> >> > configuration files, etc.).
> >> >
> >>
> >> Does this assume that VM guest memory is usually provided using
> >> anonymous memfds?
> >>
> >> More generally, is the problem that there isn't a simple way to
> >> implement retrieval into anything other than anonymous memfds?
> >
> > Roughly, yes.
> >
> >> > Preserving entire tmpfs mounts in-place would require a large amount=
 of
> >> > kernel support and would effectively make tmpfs an ABI, which is a
> >> > non-starter (or so I hear). Instead, we can delegate the reconstruct=
ion
> >> > of the tmpfs mounts (directory structure, permissions, etc.) post-ke=
xec
> >> > to userspace. The kernel just needs to preserve the contents of tmpf=
s
> >> > files and provide userspace a mechanism to restore those contents ba=
ck
> >> > into a specific file on the filesystem after the kexec. Hence,
> >> > LIVEUPDATE_SESSION_RETRIEVE_INTO_FD.
> >> >
> >>
> >> Suppose pre-kexec, the data was in a tmpfs file (and fd), how would th=
e
> >> preservation work? Would the user have to
> >>
> >> 1. Transfer the data from tmpfs fd -> anonymous fd
> >> 2. Preserve from anonymous fd
> >> 3. kexec
> >> 4. Set up the tmpfs fd
> >> 5. Retrieve into the tmpfs fd
> >
> > No, the proposal in this series is to support:
> >
> > 1. ioctl(LIVEUPDATE_SESSION_PRESERVE_FD, {TOKEN, tmpfs_fd})
> > 2. kexec
> > 3. tmpfs_fd =3D open(..., O_CREAT)
> > 4. ioctl(LIVEUPDATE_SESSION_RETRIEVE_INTO_FD, {TOKEN, tmpfs_fd})
> >
> > No transfering to or from an anonymous fd is required.
> >
>
> Cool that preserving a tmpfs_fd is supported. How is that done without
> preserving the rest of the tmpfs stuff?
>
> Why is it possible to preserve the fd without the rest of the tmpfs
> stuff but not retrieve without the rest of the tmpfs stuff?
>
> Is retrieving into an fd a bit too much of a shortcut? Would preserving
> the rest of the tmpfs eventually be required, and hence retrieval of the
> rest of tmpfs should also be eventually supported symmetrically?

The idea is that the kernel is responsible for preserving the
_contents_ of the tmpfs file in place. Userspace is responsible for
setting up a new tmpfs mount, configuring permissions, etc. after
kexec and telling the kernel which file should receive those preserved
contents. Userspace set up these mounts before kexec, so it is
responsible for setting them up after kexec as well. I see no issue
with that.

There is some nuance that this series doesn't handle though (it is RFC
after all). Pratyush brought up offline that the tmpfs mount might
have allocation policies attached to it. The
LIVEUPDATE_SESSION_RETRIEVE_INTO_FD handler needs to confirm the
preserved contents do not violate the allocation policies of the mount
it is retrieving into. But that seems easily solvable to me.

>
> >> > An alternative approach to restoring data to a named file would be
> >> > supporting a zero-copy sendfile() that can be used to convert named
> >> > tmpfs files to/from memfds across the kexec. But this poses signific=
ant
> >> > challenges on the *preserve* side since the preserved file might sti=
ll
> >> > be actively in use. The benefit of the retrieve-into approach introd=
uced
> >> > in this series is that it does not require dealing with two differen=
t
> >> > files. There is only ever one file that owns the preserved memory.
> >> >
> >>
> >> Would it be more symmetric if the process is
> >>
> >> 1. Transfer the data from tmpfs fd -> anonymous fd
> >> 2. Preserve from anonymous fd
> >> 3. kexec
> >> 4. Retrieve into anonymous fd
> >> 5. Transfer the data from anonymous fd -> tmpfs fd
> >>
> >> As to the exact details of "transfer", I think the best we could do
> >> would be some kind of move from one fd's page cache to the other fd's
> >> page cache?
> >>
> >> Is the goal of the transfer to avoid any memcpy and fully transfer
> >> ownership (so, not just by increasing folio refcounts?)
> >
> > Yes this is the alternative proposal that has been proposed and
> > discussed a little bit off list, with sendfile() and copy_file_range()
> > being the possible mechanisms to do the "transfer". I think there are a
> > few fundamental problems with that approach on the pre-kexec side.
> >
> >  1. iommufd requires that fds mapped into it are preserved. If the file
> >     mapped into iommufd is tmpfs, but then we transfer that file to mem=
fd
> >     for preservation, iommufd will fail to preserve because the tmpfs f=
ile
> >     is not preserved.
> >
> >  2. Even if you only use this feature for files not mapped into an
> >     iommufd, transfering the contents in a zero-copy way seems
> >     challenging. What do you do if the tmpfs file is still in use when
> >     you want to transfer it?
> >
>
> When you say in-use, I suppose you mean folio is in-use by some IO and
> is mapped in IO page tables, and that the IO must continue while the
> folio is transferred?
>
> Are you expecting guests (as in stage 2 mappings) to continue to be
> functional while the folio is transferred?
>
> I'll have to think a bit more, I was initially thinking of just
> transferring folios where I could unmap from everywhere (processes,
> stage 2, IO page tables) for the transfer.

I was imagining a userspace process may have the tmpfs file mmap()'d
and is accessing the memory. I guess you can argue that userspace
should stop doing that during LU. But I think the iommufd use-case
shows that that is not really possible. The whole point is to preserve
the memory mapped into the iommufd throughout the Live Update.

>
> >> > By leaving file and metadata allocation purely in the purview of
> >> > userspace, programs can create the target files where they want, wit=
h
> >> > the names and security permissions they desire, before directing the
> >> > kernel to restore the preserved folios into them.
> >> >
> >> > Currently, only tmpfs shmem files are allowed as valid target recept=
ors.
> >> > Attempting to target populated files, or anything other than an empt=
y
> >> > shmem file, will trigger -EINVAL. HugeTLBfs files could be supported=
 in
> >> > the future.
> >> >
> >>
> >> Is this basically that at some point, all in-memory filesystems' fds c=
an
> >> support transfers?
> >
> > Yes, theoretically.
> >
> >>
> >> >
> >> > [...snip...]
> >> >

