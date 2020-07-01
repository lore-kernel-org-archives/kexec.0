Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jql1i-00022V-Km
 for kexec@lists.infradead.org; Wed, 01 Jul 2020 22:16:24 +0000
Received: by mail-pg1-f199.google.com with SMTP id z187so18938351pgd.11
 for <kexec@lists.infradead.org>; Wed, 01 Jul 2020 15:14:42 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 0/2] arm64/kdump: Fix OOPS and OOM issues in kdump kernel
Date: Thu,  2 Jul 2020 03:44:18 +0530
Message-Id: <1593641660-13254-1-git-send-email-bhsharma@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: cgroups@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, James Morse <james.morse@arm.com>, Vladimir Davydov <vdavydov.dev@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, bhupesh.linux@gmail.com, Will Deacon <will@kernel.org>

Prabhakar recently reported a kdump kernel boot failure on ThunderX2
arm64 plaforms (which I was able to reproduce on ampere arm64 machines
as well), (see [1]), which is seen when a corner case is hit on some
arm64 boards when kdump kernel runs with "cgroup_disable=memory" passed
to the kdump kernel (via bootargs) and the crashkernel was originally
allocated from either a ZONE_DMA32 memory or mixture of memory chunks
belonging to both ZONE_DMA and ZONE_DMA32 regions.

While [PATCH 1/2] fixes the OOPS inside mem_cgroup_get_nr_swap_pages()
function, [PATCH 2/2] fixes the OOM seen inside the kdump kernel by
allocating the crashkernel inside ZONE_DMA region only.

[1]. https://marc.info/?l=kexec&m=158954035710703&w=4

Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Reported-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

Bhupesh Sharma (2):
  mm/memcontrol: Fix OOPS inside mem_cgroup_get_nr_swap_pages()
  arm64: Allocate crashkernel always in ZONE_DMA

 arch/arm64/mm/init.c | 16 ++++++++++++++--
 mm/memcontrol.c      |  9 ++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
