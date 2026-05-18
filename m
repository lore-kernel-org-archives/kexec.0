Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F92CD4F55
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 09:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=i1VtCXUBD1t3jnHSXjRhHz2N7tgp4UH2XPLZEo7iEPE=; b=Dw/YwPMyUyl906m4PpQ+4BV3Sx
	Zt85JFAKHR3GoxzelVY2za3zEzl7OZmTblTDRf8KfLS+IDrWMZVzVdTh4hFgHgpYtqAq/f9IdSWgO
	1zP5O88ApkEnJTC73dvH5hvaLH13+qyNDLy+9N6mqE9BeDSwuTMvu3SUhdrcHsPSwpZZRWnoN5dWC
	U/GXnCpgtnBmDGw62uZx2vFxLFLvVB2SQYaJyCpVEuXStR6B2t2CNLMjsrICkqusxl6apMKomAI3E
	uiYJudqHjVhk4BTTGdFU4h/mubyGWt519c4O30MQrSbJfbnSRtBpHOeCmRDQfoLkk+8M+0pImrlit
	znzN391w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuP2-0000000F2bf-2wBU;
	Mon, 18 May 2026 09:36:48 +0000
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuOz-0000000F2ZH-2myR
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 09:36:47 +0000
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-bcdbb46dce2so178748266b.1
        for <kexec@lists.infradead.org>; Mon, 18 May 2026 02:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779097003; x=1779701803; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i1VtCXUBD1t3jnHSXjRhHz2N7tgp4UH2XPLZEo7iEPE=;
        b=akgA0c5MhrptqRoRrfzQedX0dLNYshPmYJklY2BNfISzfmtJ3qC0H98DQf7bUXEJjK
         DH3aJinX39D1IQ42uaP0PD053SMwRu5iyEz1brNXkDDi20Wp907rWqsomIuLzl/Bczyx
         eJetZkay2QES9SE/3AnA4u+Za/TiSEXu6FP3iDvxtHBRHyQXBDjkunIPdwC59s/1hDyB
         mKxr6xxIf2Dto1RuhHgD65u09nYKhcuSkeSjVSZxC+Rbrv/NxJLk9OC173QtqVqLD8/W
         QZ8R7GgYmzD110d/IdQfrJvhgxieTi9xsJLrPYsh9ndbLrs7T9icLfKz6W6IorMlJ0SX
         9DHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097003; x=1779701803;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1VtCXUBD1t3jnHSXjRhHz2N7tgp4UH2XPLZEo7iEPE=;
        b=A2zsbjPHZb1Ya+LUtTLaZNUpRTYt7GgtPHLURHVcdgn4/dd+fliJflv+8oSaFvLLZN
         e7ILTUVeo1rbLbgqaU2dgNV98TQRCyeYwMeEPDdh1zl5PQoV4F/DsWIaeXnAKya3FgQx
         QKH7uMbuWlHBKdgi0HFJeCsQ04PH7Yw47NHnaK37YCbL/LWjs1afWezZLGBxtaokSaIr
         OeEAAapHWkbRMRsXxYI4o2r/BYV2xKCA4tczlDzadvRwKnNjKPXzJn5YxvIFJIqDmhX3
         D8Ye+05WFcV4UydLCi7uv0r32na5OrM/g8MTLsHMiSJYHiN3U+aOd3+jPix8a3wwZswb
         1k1g==
X-Forwarded-Encrypted: i=1; AFNElJ/sEyGaTMPe94srJ9u6qNx+JFmCqY+TmGSp0QyCU8WsFsr/QeROpcYczQGwQaLydV65xFmQMg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxURN4hXSXmefGfry2OIgLe5WF/k71MjMdTZpHkc/Jgj+YJnJap
	yNeMBXE7HV/g6AGFnfrmtQyh9gO85lwp8/cXbWYNSK/qIREatUZ7DQ/73FNouQo78/uU6F1bCUh
	ARgcqJXzw5Cgs7tnVow==
X-Received: from ejcjg37.prod.google.com ([2002:a17:907:9725:b0:bc1:3569:5260])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e27:b0:bd1:6909:d013 with SMTP id a640c23a62f3a-bd51780c64amr686154466b.8.1779097002163;
 Mon, 18 May 2026 02:36:42 -0700 (PDT)
Date: Mon, 18 May 2026 09:36:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <cover.1779080766.git.tarunsahu@google.com>
Subject: [RFC PATCH v1 0/8] liveupdate: kvm: Guest_memfd preservation
From: Tarun Sahu <tarunsahu@google.com>
To: axelrasmussen@google.com, mark.rutland@arm.com, skhawaja@google.com, 
	Mike Rapoport <rppt@kernel.org>, sagis@google.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shuah Khan <shuah@kernel.org>, ackerleytng@google.com, corbet@lwn.net, 
	dmatlack@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, vannapurve@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, aneesh.kumar@kernel.org, 
	vipinsh@google.com, Alexander Graf <graf@amazon.com>, David Hildenbrand <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kexec@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_023645_921221_C27F2EFB 
X-CRM114-Status: GOOD (  43.41  )
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

Hello,

I am proposing this series as RFC, to initiate the discussion for
supporting the guest_memfd preservation. This will setup basic arhitecture
for VM preservation during liveupdate. This Cover letter has three
sections (please feel free to skip the on you already know):

A. Guest_memfd introduction:
To make the audience familiar with guest_memfd
B. Liveupdate introduction:
To make the audience familiar with liveupdate
C. Actual Implementation Design and questions.

**GUEST MEMFD INTRODUCTION**

Initially, guest_memfd was created to support guest private memory in
confidential computing VMs (CoCo VMs). It was designed so that whenever
a guest wants to grant the host access to private memory, a series of
calls occurs: from the guest to KVM, KVM to the host userspace, host
userspace back to KVM, and finally a new page fault maps the memory into
a separate shared address space. Conversely, if the guest transitions the
memory back to private, the subsequent fault is handled by guest_memfd.
(Dual Mapping Architecture). In such a VM, all guest memory is initially
shared. On the fly, the guest may request to change pages to private; the
metadata indicating which parts of memory are private is stored in an
xarray inside struct kvm (mem_attr_array). This array serves as the source
of truth for the fault mechanism, determining whether a mapping should be
created from host-userspace-mapped pages or directly from the guest_memfd
file. For private memory, Fault also calls architecture-specific function
to set up private hardware access (e.g., on SEV-SNP or TDX). This type of
guest_memfd is fully-private where shared mapping comes from userspace
mapped address space.

Subsequently, support was added to allow the entire guest memory to be
backed by guest_memfd. This led to the implementation of the MMAP and
INIT_SHARED flags for the guest_memfd inode. When KVM_CREATE_GUEST_MEMFD
is called with these flags, the guest_memfd becomes mmap-able by host
userspace. The INIT_SHARED flag is used to make the guest_memfd completely
shared between the host and the guest. Consequently, page faults from both
host userspace and the guest resolve to the same guest_memfd page cache.
However, under this configuration, marking a portion of this memory as
private is not possible. This type of guest_memfd is fully-shared.

If guest_memfd is created with INIT_SHARED without MMAP, the host
can never access the guest_memfd. But the memory is still considered
shared.

Hence, At this point, Only use-case of guest_memfd is either fully-shared
or fully-private.

There is ongoing work to make shared and private mapping in-place backed
by guest_memfd. [1] There is also ongoing work to back guest_memfd by
hugetlb pages. [2]

**LIVEUPDATE INTRODUCTION (LIVEUPDATE ORCHESTRATOR - LUO)**

Livepdate support was added in kernel to update the host kernel by
minimizing the downtime to minimal. This is generally achieved by
preserving the current state of the system and retrieve after boot to
resume from where we left it.

Any subsystem that wants to preserve themselves, register their handler
with liveupdate system. This handler includes calls to the following

*can_preserve (file)*:
This tells the luo system about the eligibility of the file. When
preserve ioctl is called, it first loop through all the file handlers
and call can_preserve, the one which return true, luo uses this file
handler fh->preserve call to preserve the file.

*preserve(file)*:
This actually preserves the file.

*unpreserve(file)*:
This unpreserve the file incase userspace want to go back.

*retrieve(file)*:
On new kernel boot, this function retrieves the file.

*finish(file)*:
When userspace decides that all the files in the liveupdate session has
been retrieved, it can trigger this to do final work of cleaning up.

LUO preserve its memory using KHO (kexec-handover). All these APIs will
be implemented using KHO calls.

**GUEST MEMFD PRESERVATION**

This patch sets up the basic infrastructure to preserve the guest_memfd.
Currently this supports only fully-shared, pre-faulted guest_memfd
(INIT_SHARED) backed by PAGE_SIZE pages.

It registers a new LUO file handler for guest_memfd file to serialize
and deserialize guest memory. This allows preserving guest memory backed
by guest_memfd across updates, ensuring that guest instances can be
resumed seamlessly without losing their memory contents.

The preservation call is straight forward. It walks through the page
cache, serialize the folios and preserve them.

On the retrieval path:
Currently, creating a guest_memfd requires an associated struct kvm
(derived from vm_file / vm_fd). Since there is no direct way to pass a
VM file descriptor via the LUO API, we considered two main approaches:

Approach (1)
Split the KVM_CREATE_GUEST_MEMFD ioctl into two separate ioctl: one
to create the guest_memfd without a VM file (without struct kvm)
descriptor, and another to attach a newly created VM file descriptor to
a retrieved guest_memfd.

Introducing a new ioctl is in itself a problem (UAPI). Currently, a
guest_memfd file belongs to a single VM. Decoupling creation and
attachment could allow a guest_memfd to be attached to any VM, or shared
among multiple VMs when passed at different offsets. Fully supporting
this feature would require extensive work, and it is unclear if there
are any non-LUO use cases that justify this complexity.
There is related work going on here [4], but not exactly same. It still
does not allow guest_memfd to be created without vm_fd. But there be
other ways to use it, I would like to discuss the idea.

Approach (2)
Leverage a companion patch [3] (Also added as part of this series
PATCH[1]) that allows one file to retrieve another file from the same LUO
session. This enables the guest_memfd retrieval path to obtain the
preserved KVM file, use it during guest_memfd file creation, and
subsequently populate its preserved memory.

Preserving the KVM file allows us to preserve additional VM-specific
metadata, which will be crucial in the future for cleanly resuming the
VM. Currently, it preserves only the VM type and kvm->mem_attr_array.

Though the ongoing in-place sharing series [1] transfers attributes to
the guest_memfd file, But preserving the kvm file opens the opportunity
to preserve other VM state in future like registers state, vCPU etc.

Having the extensive usecases for preserving the kvm file, I went
ahead with Approach (2). In future, if approach (1) become possible, it
can easily be integrated with approach (2).

Following the first approach (preserving vm_fd along with guest_memfd),

** VM FILE LIVEUPDATE ** PATCH[3] && [4]

*PATCH[3]* has refactored few functions to support kvm preservation.
During retrieval, vm_file needs to be recreated which will require kvm
api. This patch exports those APIs. There is a new addition to struct
kvm, vm_file. Which will be used by guest_memfd. I will discuss about
this later.

*PATCH[4]*
The preservation of the vm file is straightforward.

On the retrieval path:
KVM normally requires a unique identifier (fdname) upon creation,
which KVM typically assigns based on the newly created file descriptor
number. However, in the LUO retrieval path, the retrieve call restores
the underlying file structure and delegates actual file descriptor
allocation to LUO (check luo_session_retrieve_fd). Currently, I used an
atomically incremented sequence number as the fdname. I would like to
discuss whether userspace services rely on specific naming conventions
here. Or if we can change underlying the retrieve call
(luo_retrieve_file) to pass fd?

**GUEST_MEMFD FILE LIVEUPDATE** PATCH[5], [6] & [7]

*PATCH[5]*
During retrieval of guest_memfd file, for its creation, this patch has
exported APIs from guest_memfd.c to be used for guest_memfd_luo.c

*PATCH[6]*
This patch implements the API for gmem inode freeze, which freeze the
fallocate operation on this inode. Freeze check can be extended in
future to prevent new page faults as well, when liveupdate support
for non-pre-faulted guest_memfd will be implemented.

*PATCH[7]*
Preservation Path:
We have discussed about this before,
I would like to add to that and discuss here a major design decision:
"Preservation order in between VM File and guest_memfd file"

Preservation Ordering is required because guest_memfd needs to store
vm file token as one of its data, which it can use during retrieval to
get the vm file and use (file->private_data: struct kvm ) for its
creation using [3]. So KVM file must be preserved before guest_memfd
file, so that guest_memfd preserve call can find vm file token from the
same luo session.

Currently My preservation implementation does not require any strict
ordering, they can be preserved in any sequence from userspace. I
achieved this by implementing the freeze call for guest_memfd which
gets run at the end just before kexec. This call freeze the luo session
and no further changes can be done to the session. Inside guest_memfd
luo_freeze handler, I update the token for vm_file. Which enable us to
preserve the vm file and guest_memfd file in any order.

The drawback is, incase vm_file is not preserved, freeze will fail. And
in enforcing the preserving order fails the guest_memfd preservation
from the start. As with VM preservation will evolve in future, it will
keep getting complicated so avoiding the preservation order should be
the better choice to make the userspace simpler. I would be happy to
disucss on this further.

To get the token, we need the vm_file and there is no way to get the
vm_file from the struct kvm, as guest_memfd file only store the
struct kvm. I have introduced a new member in struct kvm, vm_file.
But with weak circular dependency as it is just to get the pointer
for the file. we don't want to keep the reference of the file as vm_file
takes for the kvm to keep itself (vm_file) alive. So whenever there is a
need to use of kvm->vm_file, we take the reference and drop it suddenly.

Retrieval Path:
During retrieval path, we just retrieve the data from kho and populate
into the newly created guest_memfd.
To create guest_memfd itself, it needs struct kvm, as we discussed
above, which will come from vm_file, hence retrieval order is needed
here. VM file needs to be retrieved first before guest_memfd.

To handle this situation, I had three approaches in mind with their own
pros and cons:

Approach (1):
Use [3], retrieve internally using liveupdate_get_file_incoming which
inherently retrieves the file incase it was not retrieved by the
userspace already. But this creates an scenerio, that userspace might
call luo_finish which will drop all the references of vm_file (and
userspace not holding any as it has not retrieved it yet explicitly).
And vm_file will get released. But this is a valid situation as when vm
is going to be put down. Userspace can close the vm_fd and have
guest_memfd yet opened and so other user of struct kvm like vCPUs etc.
Only thing, this makes retrieved guest_memfd unusable unless, there is
a mechanism to link to another VM (Nope).
This leaves us with following situation:
	(A): As it is a valid situation, We can leave it as it, No
	retrieval order enforcement.
	(B): We can implement can_finish to check if userspace has
	retrieved the vm_file, otherwise can stop luo_finish from
	succeeding, but I did not find a way to implement such check.
Approach (2):
Enforce the strict order, by implementing a new call which will first
check whether the vm_file is retrieved or not, if not, it will not
retrieve it internally and retrurn err to the caller which is
guest_memfd retrieve function in this case. So guest_memfd can report
the userspace about this error.

I have implemented Approach (1)(A), as it is a valid case, and does not
enforce any retrieve order on userspace, which relieves the burden from
the userspace when vm_file preservation will evolve. But userspace is
now expected to retrieve the vm_file before calling luo_finish or
guest_memfd will become unusable. As per LUO philosphy, It is userspace
error.

**KERNEL SELFTEST FOR POC** PATCH[8] & [9]

*PATCH[8]* refactor kvm selftest framework to expose some raw apis to
setup the VM.
*PATCH[9]* implements the basic test, where it spawn a VM with guest_memfd
or 16MB and fault it completely and write data to its 5MB portion. After
LUO preserve call, and kexec, On retrieve, a new VM is spawn with the
restored vm_file and restored guest_memfd and the data is verified.

I will update this test in the next version to use the liveupdate
selftests library [5].

Future Work:
1. To support preservation for non-prefaulted guest_memfd to save memory
in KHO. (Already working on this, will post another series soon)
2. Support private guest_memfd preservation.
3. Extend the support for guest_memfd with in-place conversion of
shared/private.

[1] https://lore.kernel.org/all/20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com/
[2] https://lore.kernel.org/all/cover.1747264138.git.ackerleytng@google.com/
[3] https://lore.kernel.org/all/20260427175633.1978233-2-skhawaja@google.com/
[4] https://lore.kernel.org/all/cover.1691446946.git.ackerleytng@google.com/
[5] https://lore.kernel.org/all/20260511201155.1488670-1-vipinsh@google.com/

Pasha Tatashin (1):
  liveupdate: luo_file: Add internal APIs for file preservation

Tarun Sahu (8):
  liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
  kvm: Prepare core VM structs and helpers for LUO support
  kvm: kvm_luo: Allow kvm preservation with LUO
  kvm: guest_memfd: Move internal definitions and helper to new header
  kvm: guest_memfd: Add support for freezing and unfreezing mappings
  kvm: guest_memfd_luo: add support for guest_memfd preservation
  selftests: kvm: Split ____vm_create() to expose init helpers
  selftests: kvm: Add guest_memfd_preservation_test

 MAINTAINERS                                   |  13 +
 include/linux/kho/abi/kvm.h                   | 121 +++++
 include/linux/kvm_host.h                      |  14 +
 include/linux/liveupdate.h                    |  21 +
 kernel/liveupdate/Kconfig                     |  15 +
 kernel/liveupdate/luo_file.c                  |  69 +++
 kernel/liveupdate/luo_internal.h              |  17 +
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 .../kvm/guest_memfd_preservation_test.c       | 285 ++++++++++
 .../testing/selftests/kvm/include/kvm_util.h  |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  26 +-
 virt/kvm/Makefile.kvm                         |   1 +
 virt/kvm/guest_memfd.c                        | 180 +++++--
 virt/kvm/guest_memfd.h                        |  44 ++
 virt/kvm/guest_memfd_luo.c                    | 495 ++++++++++++++++++
 virt/kvm/kvm_luo.c                            | 346 ++++++++++++
 virt/kvm/kvm_main.c                           |  79 ++-
 virt/kvm/kvm_mm.h                             |   3 +
 18 files changed, 1653 insertions(+), 80 deletions(-)
 create mode 100644 include/linux/kho/abi/kvm.h
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_preservation_test.c
 create mode 100644 virt/kvm/guest_memfd.h
 create mode 100644 virt/kvm/guest_memfd_luo.c
 create mode 100644 virt/kvm/kvm_luo.c


base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.54.0.563.g4f69b47b94-goog


