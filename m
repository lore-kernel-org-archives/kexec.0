Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE01C87FCC
	for <kexec@archiver.kernel.org>; Sun, 27 Jul 2025 05:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y4fzyMbg9b9tChn/1fYJ7NRuUNWKz/X0SkndoLYJL0g=; b=ibJs6J9K1Xcu96sANotAwXWIvR
	xudaUksEw32DbuLUZRr6C/c9GUGz4V6CU/jxMxVf8WF3b7Zz8MYsblvOTwwNFGEIrl81iIfN5th+Y
	IynxdR91vSZDOYXCjCX61IT8LRNtVjhaf+nYuB3ekkWfxb+UFNmm28/10x+7D3h42Fv5m/vBgt5Wb
	pCh3rL12KAuIPPlwpAsCfXW5wCUnYyvEybOfLWAQlIpV8ULxREPh8FLLpJatcjwVptxnDLZWRU1DU
	r6xynzspZNqUhvDgE1OIbsUiFu0QJ44U3fPL/eJ3/8JS+zkNzJnWwAH0Py9paWf6N7DhHQtUVCmVk
	t6Fww4rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uftwE-0000000CLn1-1jcK;
	Sun, 27 Jul 2025 05:28:46 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uftw9-0000000CLma-23BK
	for kexec@lists.infradead.org;
	Sun, 27 Jul 2025 05:28:42 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-235e389599fso157985ad.0
        for <kexec@lists.infradead.org>; Sat, 26 Jul 2025 22:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753594120; x=1754198920; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y4fzyMbg9b9tChn/1fYJ7NRuUNWKz/X0SkndoLYJL0g=;
        b=FKQVW3fXW/aX72PodgY/3QNfyGfVt2jqh6LqayQJXlzRf0iCyZXhxoXd6gDeTcg0wp
         +1o36pP1UcpCHwrldvS8qZ/JP6x0JEOWg59YssRTQ7fUkLpe8lpQBBoi0wElPdLjCxU5
         3RqgltYjo7kkTmLJ6buG2MqeL9Z29iLNEWIyHZrD3+OD3juE/UCw2ZiHEaglE1uceN+2
         +Hgk/e0CSbz3w2xGcv4TOGCmOp0leiCSKY23PGaAQlIuqpO5H4QNvEDlpZmScX/Qvwtj
         nr2lzYqoMqn94CdMIjBV9Gf2tgmO94ubhhE5XeyNk5khX1qT1YOogDl/9bROh1uiQdP9
         3ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753594120; x=1754198920;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4fzyMbg9b9tChn/1fYJ7NRuUNWKz/X0SkndoLYJL0g=;
        b=LWIwkstMNoijmupcunBST9Ii36MlM0bc5WBf92aTckDysmsInIdJaCxy+YjZ7WiNfd
         X9p2PPeTjwsBDIJoDUIsh3A6gK4bzaQPDS2+EWUkBrG1nbxpA3jlZ65vZPWPUA6ard98
         69SVw3cL6ae4H8ls1DVWjWIZHQ6QL72SWRVVMHnM0syxgH8ijiTIZe/O69g7qikX9EgD
         zs3wfIf8AkYQG/T9WFfu1CHSCfqAkOLmPl2bY7cdEU1nKs3Sbq4RuF+kDJfJLHrflm5r
         ZlgKDfe+JfJMWXvIJyPX1IHsi/AmxSKg8MIiI8mq0ZIvKZwyf22lWTCLgD993xTxz7bK
         cnmA==
X-Forwarded-Encrypted: i=1; AJvYcCXNxqwMkmg/Wkrikw3MgVIapdQY7xtVtkwlERmh10WnvN3TgId6t57Vco+/PwKwzdps9QOFvw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxfIfNJ7ueJH4mm6lzQ7loIglL+dor4inCgJLPYWbIgn7p1YTr6
	vfE5WExPzRZsL/VBooyL5N45NpaoK7E1gRXrG7c/6UXZ4D4BZkhuhmdVg/PsiQCGig==
X-Gm-Gg: ASbGncvThoosaFBK0v2ZG3/ifdnlEyNAAkgEyp+aj6FNWoet/Xbd7hb7C8wbeQ/60Zx
	JGcYcYdnHzAMvNMo71dKbplkHm9S1EABuUaWCEtdmlV2+RdQ565DQWIIs7PKlMHHv7qWYG4zdgz
	WcuJH4jF8RIHU4iRfeb9lhRN5jyvVBVvYiS1NtA88p+l8kwCfzMGTVmDAWD0GY04jFSQ4uVGTIS
	ixadDT2TfRyN7tiqDM1k9qr2YToHukVBoX9/FA8v8O8pOwxfO3bnncLcfmrv4vi85EelOTvXCwX
	WgRffpZCj94aCDSnICemrJS8NfdqjLms0DnJj/iKAumRSG7epbaFQDRT2SgHYIExzUQhnsjSDPv
	Iq+eCIce+9cj2nJpy716XJSFkeNTv5MKu0V2utMEuYEQpV7fyI2Yg8hZv/D/AGmD2eF4gqKrVKl
	52fIw1PbU0D9YJ/pwDEatzem96y0yfhefqfXE3DQ==
X-Google-Smtp-Source: AGHT+IHnc6cUG06f6cNWo4opD7IJz7IhkPswhlCALVJIFBdHGdAJXNrJvZAaR9NFudPqT1pwJuP30g==
X-Received: by 2002:a17:903:2441:b0:23f:f6f4:246 with SMTP id d9443c01a7336-23ff6f40326mr596465ad.19.1753594119390;
        Sat, 26 Jul 2025 22:28:39 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:364f:4373:b756:1458] ([2a00:79e0:2eb0:8:364f:4373:b756:1458])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b1e0318sm2827904b3a.93.2025.07.26.22.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 22:28:38 -0700 (PDT)
Date: Sat, 26 Jul 2025 22:28:37 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
    David Matlack <dmatlack@google.com>, 
    Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Jork Loeser <jork.loeser@microsoft.com>, 
    Junaid Shahid <junaids@google.com>, Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from July 14, 2025
Message-ID: <ff87b623-2e8f-2fd8-3db0-d592804e1466@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250726_222841_549845_FDFBF531 
X-CRM114-Status: GOOD (  28.71  )
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
on Monday, July 14.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
Mike Rapoport discussed a proposal about sticky preservation with KHO.  A
colleague had been working on integration with Microsoft Hyper-V (MSHV).
They want to mark memory that is persistent forever so it is not necessary
to mark pages as persistent for every kexec; this would continue until
there was a request to stop persisting that memory.  An example is memfd
to back guest memory where the layout of memory doesn't change much;
another example might be PCI configuration.  This may be used for memory
that is obtained from the HV but then not tracked anymore anywhere.

Pasha Tatashin suggested that this would be another user for KHO and not
part of LUO.  Mike suggested there may be states involved with this memory
since you could eventually mark it as not sticky anymore.  Until this is
marked as no longer sticky, it would be a permanently included fd.

Jason Gunthorpe asked what we would get back on the other side of the
kexec.  Pratyush Yadav noted that we can't change the size of this memory
without more effort.  Jason suggested that MSHV would just use a KHO
provider and preserve with LUO as normal because you need to track the
memory.  We might schedule additional time to discuss this in a follow-up
when joined by MSHV developers.

----->o-----
We discussed current status of LUO.  Pasha at the time had sent out v1 of
of the patch series (non RFC) and received some comments.  Current version
should address any concerns from the RFC version and also includes memfd
preservation from Pratyush.  There is an on-going discussion about using
kexec fs instead of using tokens.  Jason suggested against using
filesystems if at all possible.  Pasha noted this could be a future
extension and does not need to be part of the core LUO.

Mike noted there were two opinions being expressed: ioctls shouldn't be
used and how much dev tmpfs differs from kernel filesystems.  Jason noted
this is just a regular character device like hudnreds of other devices in
the kernel.

Pratyush brought up the previous conversation about handing out sessions
so when serialization is done it is done per session.  The agent decides
who gets access to these sessions.  David Matlack asked if the agent could
hand out sessions to unprivileged processes and, if so, this would address
concerns about all saved fds being sent to the agent and context stored in
the agent's process before being sent out again.  There was general
agreement on session fds; an open question remained about whether the fd
passing would be done with sockets or bind mounts.

An example Jason provided would be to create a session through a file in
a filesystem and then give that to qemu; qemu would then open it and do an
ioctl on it and provide the kvmfd.  Pasha believed that it was very clean
to do the policy through a userspace agent rather than in the kernel.

----->o-----
We transitioned to discussing the agent, liveupdated, which the group
thought was going to be needed.  There was a desire to have both Christian
and systemd people join the call, so I took the AI to reach out and see
if they would be available.  I asked about where liveupdated would live,
if this is something that would be shipped along with the kernel itself or
whether this would be perhaps its own open source entity.

Pratyush experimented with fdstore and was looking into whether a process
could survive through the reboot call, or at least an fd survive through
that call in systemd.  Pasha suggested there should be a way for the agent
to survive until the reboot call if you modify the target to not kill the
agent process.  He also suggested that while it may be attractive to have
this as part of the systemd tree, it would be separated from that
entirely.

----->o-----
Chris Li gave a quick update on PCI preservation.  He said the current
support allows for the PCI device to preserve its state across the kexec
and allows for supporting DMA during reboot.  He suggested the inital
patch series to modify the PCI interfaces to allow registration will be
straightforward.  However, feedback and discussion will be needed for
changing PCI initialization for device that already have state; these
changes could be invasive.

----->o-----
David Matlack shared that the live update microconference was accepted for
LPC!  It now shows up for the CFP so people can submit talks for this[1].

----->o-----
Next meeting will be on Monday, July 28 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - follow-up on sticky preservations with KHO, any additional insight
   provided for MSHV use cases
 - discuss any on-going pushback against character devices and suggestions
   for using a filesystem instead of ioctls
 - status update on the liveupdated agent, design, and timelines, as well
   as open sourcing it and libluo in its own repository
 - Frank van der Linden: physical pool allocator, used to provide memory
   for hugetlb, guest_memfd, etc
 - Chris Li: update on PCI preservation, registration, and initialization,
   and the RFC patch series discussed in last meeting
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1] https://lpc.events/event/19/contributions/2004/

