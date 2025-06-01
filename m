Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52B8C5AE59
	for <kexec@archiver.kernel.org>; Sun,  1 Jun 2025 03:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uJ3qtgIDfEsN49rId0uuuPNM2vOn1Oqk2Kq6F9+907Y=; b=3i2Qqq1RoPf7dKPkDku1AEfcDl
	ZwNvNPbKfxcp6XnQbtFoqL4njce8wmpnjJJ9lZRe+E7aq30HrPkKwk/R1NeELqBDX9LHv1tAcReXO
	hRANkuJyPTPfQfb342SUZEBaL9saTKp7XiVhiLjKoQnsjhmIIaNkX6reTgpEFtS3HFCfwnzh2/wgQ
	yLj0eK4Mo1qgI4z5S6z+1piYJz6fAsTslp1LWQOeJSPt+3sK/kfVNOzG7TQsLBD/txNGB7nkXVeVQ
	Vz0cUFfhiHozd5aC0FpHaEkgUtnQP4GbRCMvQ4U10G+0RSSQY3hfgvBisabzUs9uJcrHRIuN0ykQ3
	YECKGDfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLZBR-00000004vRl-0MZz;
	Sun, 01 Jun 2025 03:16:25 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLZBK-00000004vR9-46wL
	for kexec@lists.infradead.org;
	Sun, 01 Jun 2025 03:16:20 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2357c61cda7so52735ad.1
        for <kexec@lists.infradead.org>; Sat, 31 May 2025 20:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748747777; x=1749352577; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uJ3qtgIDfEsN49rId0uuuPNM2vOn1Oqk2Kq6F9+907Y=;
        b=S/Cwa11023PrCH5FZH3DpcbJ91ZDMQPruKA9cWjnCRufm+jlyJUGjQNLSJgkcUPNyb
         3MXSPT74jIQepIavS+umdk0orE8lwpF+8Zvla4s+D/x1k1i7siL/U2M8whrJ2zB6FK54
         WAEGxB5cmp4tM/YIp9CHBcwJ7kC+BxZYBjGXVrYvm4ECG9sxkLJLWACKIXig0Mk44R25
         pwQ0IpuibWgVTbkjACVSvIyaS74bJKi+43JNzVhIGfG9p98HZSpiPO+xeoa3pF1QsEGi
         RgLlUYhakmTVBJ4C3Qba8f2SS4HzEIujVGysAHeupj9e9LdodXVL413VbdAefoS8v9pk
         yb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748747777; x=1749352577;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJ3qtgIDfEsN49rId0uuuPNM2vOn1Oqk2Kq6F9+907Y=;
        b=rb/CW/qR7B8yHQxYy+TTgNwOtI2mtO9wXbN1gZIt7FzEVbNvIF5FOIeYMOVrZJdWi+
         Ug7sLHSrO+Fpr9wf434WLxKtpU7HBawbXeseOJt+MCXaGGm/v5JFLRkGL8YvSykIzErs
         3dEn+7mRkZJgYkDwlUhn60JT704T1USIV60vz/sR/Va+9blw4VLVSGXQ0+pAPXEyCgzq
         V76p+6lSJTkCzHv6RJtNobZPDGY/n24Pq4/eQQS8PhUGG7xTYzwq9Xd0Ln8JAeCnVCHO
         xu3VC03npBSO8fibBn7YswnpCWL214LF16j3ejFAiFHxPKKcCYnZShDAS7MP8jLgicrI
         S2TA==
X-Forwarded-Encrypted: i=1; AJvYcCW9jF1zRkhijDl43PQS7NLg98PvOuF86xamdiDrmPwDsQlLEgyr4AzzXivSr1eP9t3kBQlDOQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzGkFMlrJjB4jWF3U9HzN9CQW7SU+HrLrHyYdTkLb9lRRhEo/eo
	fZs884S9g9m5ADju3E0R2gr/HVk9fJhOoYen3U5DZ4L0GsSjkXcdztLLH6SGDOpQLw==
X-Gm-Gg: ASbGncstOGViCqPymRIlFKRz07rNoFBla9QZltynY5y+R0mf8e7oMSXKDJMZVqNr7W/
	RFcYOT9hMdvjXc7xMCpinzMvw0bZR2hIH+L15cUcDULgU+3ZK63MaRSeWjkeMtFKTt4yJJAtCeD
	g9zZgmE+CF9k8B3ZyPYhlD/UJmWhukZbzmCBCEjmmg0Nt8nACwCCM0CvZ/XTqbGPO5XNCu5K40N
	oUmzen0EOk1m7jE7GfTr57092gvnrVF24hoFM+ovsQhnZKJEoEK9dmgfwHcpAeQvoFoSAmOwtr+
	1on9WTM25sDc6MomhbpkQC1bzT5UarwXd2cQq5T/VHk98Ia3GTnjUWwUeTtiUj8xH0aHLS42l+q
	mqj3ZokF0QWFFjfjig7s0zi2fhHtjxTVEUtibKAfUtc5c4L6PcL2x2A==
X-Google-Smtp-Source: AGHT+IFINazidOPXFvZzJSusmwSLp67gD06pkPD86JcvYRE6vud46JnjJj1MJxd67mXame/J2tMMVA==
X-Received: by 2002:a17:902:fc43:b0:234:c37:85a with SMTP id d9443c01a7336-235568f2be5mr2272235ad.24.1748747776551;
        Sat, 31 May 2025 20:16:16 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:1d6:160a:64d1:5d06] ([2a00:79e0:2eb0:8:1d6:160a:64d1:5d06])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc85fcsm49274755ad.38.2025.05.31.20.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 20:16:15 -0700 (PDT)
Date: Sat, 31 May 2025 20:16:14 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
    David Matlack <dmatlack@google.com>, 
    Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Junaid Shahid <junaids@google.com>, 
    Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from May 19, 2025
Message-ID: <958b2ec3-f5f1-b714-1256-1b06dcf7470f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250531_201619_044004_4504DA59 
X-CRM114-Status: GOOD (  30.71  )
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

Hi everybody,

Here are the notes from the last Hypervisor Live Update call that happened 
on Monday, May 19.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
Pasha started off by presenting material on the LUO v2 design[1].  He
noted that while we want to eventually preserve devices, the current
proposal only preserves file descriptors.  He also made a comment that
future use cases may allow for extensions for preserving containers
across kexec.

Pasha went through the state machine for LUO: normal, prepared (VMs still
running but devices are serialized), frozen (VM is suspended), and
updated (have updated into the next kernel but are not yet in the normal
cycle on the other side of the kexec).

There are four LUO event stages: prepare (before blackout), freeze (done
normally through reboot syscall), finish (transition from updated state to
normal state), and cancel (for prepare or freeze).

The UAPI includes /dev/liveupdate character device to add participants,
sned events, and query state, as well as /sys/kernel/liveupdate/state that
describes the current state of the system per the above.  The latter can
be used by systemd to optimize for boot or live update; live updates
always want very fast boot.

LUO will register subsystem and can allow for querying of subsystem data.
Each struct liveupdate_subsystem has the callbacks for the event stages
and pass in a u64 pointer.  David Matlack asked if the u64 is normally
used to store the address in memory of saved state; Pasha confirmed this
would normally be the case but LUO doesn't put any restrictions on its 
usage.  Mike Rapoport noted the lower 12 bits could be used for other
purposes if used for an address.

Filesystems can also register with LUO to preserve their fds.  The
struct liveupdate_filesystem includes callbacks for the event stages as
well as a ->retrieve() and ->can_preserve() boolean.  The latter will
allow us to determine if a file can be preserved or not.  These callbacks
all operate on pointers to struct file.

Pratyush asked about the relationship between KHO and LUO.  Pasha noted
that KHO provides a state machine and in RFC v2 of LUO, LUO can drive KHO
which makes the KHO debugfs interface optional.  KHO activate will cause
LUO to switch to the prepared phase, for example.  /dev/liveupdate
continues to be the preferred mechanism.  Think of KHO as preserving state
across kexec whereas LUO provides the state machine.

----->o-----
I asked about the next steps for LUO.  Pasha noted v2 was very recent and
there would be discussion over the next few weeks.  Memfd preservation is
currently under development and Chris Li is working on device
preservation.

Pratyush is working on tests for memfd as well as libluo which is a
userspace library to making interacting with LUO simpler.

Mike had a thought about more tightly coupling KHO and LUO in the kernel
tree.  Pasha suggested waiting for later to do a clean up of the code, at
least waiting for KHO to land (not necessarily LUO landing).  In the
future, it may be better to store under kernel/ instead of drivers/misc/.

No additional work is being planned on KHO until it initially lands.

----->o-----
David Matlack brought up the idea of a live update microconference for LPC
this year.  Once submitted and accepted, then the microconference will
proposed its own CFP per Mike Rapoport and then people can submit for
that.  Pasha noted that this could even include people working on boot
time optimizations that may not be aware that their work is useful for
live update.

----->o-----
I asked about current status of work to split pmem regions into smaller
shards.

We briefly chatted about defaulting dax regions per a specification on
the kernel command line.  Mike had a similar approach in the past for
pmem on top of e820 with namespaces but it was not sent upstream.  Pasha
said the current approach being worked on is that the kernel command line
would specify what should be fsdax and what should be devdax.  The big
change, however, is to eliminate the first 2MB of data for the superblock.
Mike's approach was to move labels to the very end of the device in the
last 128KB.

Pasha said it was likely best to not have the pmem label at all.  Mike
said it was needed to resize namespaces on the pmem devices itself.  Mike
asked to be cc'd on the patches when they go upstream.

----->o-----
David Matlack noted that he was almost finished with VFIO selftests for
6.15 and that it would be sent out.  This was planned to be used for
testing device preservation in an automated way.

Pasha noted there was no good way to create qemu instances in selftests
today, so we need infrastructure for KHO and LUO in selftests.  This will
likely require a significant amount of work.

Mike noted that it may be possible to borrow the infrastructure that BPF 
uses for this.

----->o-----
Next meeting will be on Monday, June 2 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - discuss current feedback on LUO v2 and its next steps
 - check on status of memfd preservation using LUO
 - check on status of libluo development from Pratyush
 - check on status of sharding dax devices and eliminating the labels in
   the first 2MB
 - determine timeline for new kernel parameters to specify devdax and
   fsdax directly on the command line itself without ndctl
 - check on status of VFIO selftests that will be useful for automated
   testing of device preservation
 - determine timelines for selftest framework for live updates, which
   could be a significant amount of work
 - update on physical pool allocator that can be used to provide pages
   for hugetlb, guest_memfd, and memfds
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1]
https://docs.google.com/presentation/d/1F-lcl4vSGDX72vhcdmlgKTSe8-GAlwqP46G37SDJP0Q/edit?usp=drive_link&resourcekey=0-jrQSQ7Catn-A7EimsR475A
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=ramdax
[3] https://github.com/groeck/linux-build-test.git
[4] http://kerneltests.org

