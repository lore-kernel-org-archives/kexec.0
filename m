Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOdqm-00EZ6i-1m
 for kexec@lists.infradead.org; Tue, 23 Mar 2021 10:01:25 +0000
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 0/3] crashdump/x86: dump dax/kmem and virito-mem added
 System RAM
Date: Tue, 23 Mar 2021 11:01:07 +0100
Message-Id: <20210323100111.8365-1-david@redhat.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Simon Horman <horms@verge.net.au>

Let's properly support dumping any kind of "System RAM" that is not on the
top level of the kernel resource tree in /proc/iomem, processing any
/proc/iomem entry that contains "System RAM". In addition, increase
the maximum number of crash memory ranges to fully support virtio-mem
even in corner cases where we end up with a lot of individual memory
ranges.

David Hildenbrand (3):
  crashdump/x86: dump any kind of "System RAM"
  crashdump/x86: iterate only over actual crash memory ranges
  crashdump/x86: increase CRASH_MAX_MEMORY_RANGES to 32k

 kexec/arch/i386/crashdump-x86.c | 18 +++++++++++++-----
 kexec/arch/i386/crashdump-x86.h |  3 ++-
 2 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
