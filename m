Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vj0Pp-0003ip-QT
 for kexec@lists.infradead.org; Wed, 20 Nov 2013 05:33:30 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: /proc/vmcore mmap() failure issue
Date: Wed, 20 Nov 2013 05:29:16 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971C3862@BPXM01GP.gisp.nec.co.jp>
References: <20131113204130.GD7613@redhat.com>
 <5284A689.70903@jp.fujitsu.com> <20131114151359.GA3913@redhat.com>
 <5285EC60.1060906@jp.fujitsu.com> <20131115142617.GC6637@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971BF592@BPXM01GP.gisp.nec.co.jp>
 <20131118135511.GA30637@redhat.com>
In-Reply-To: <20131118135511.GA30637@redhat.com>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "chaowang@redhat.com" <chaowang@redhat.com>

On 2013/11/18 22:56:10, kexec <kexec-bounces@lists.infradead.org> wrote:
> On Mon, Nov 18, 2013 at 12:51:39AM +0000, Atsushi Kumagai wrote:
> 
> [..]
> > > Is there any chance that you could look into fixing this. I have no 
> > > experience writing code for makedumpfile.
> > 
> > I'll send a patch to fix this soon.
> 
> Thanks Atsushi.
> 
> Vivek

Vivek, could you test this patch ?

Thanks
Atsushi Kumagai


From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Wed, 20 Nov 2013 10:05:03 +0900
Subject: [PATCH] Disable mmap() for reading fractional pages.

Since mmap() was introduced on /proc/vmcore, it fails
for fractional pages which don't start or end at page boundary
due to kernel issue.
This patch disables mmap() temporarily for fractional pages
to avoid this issue, so mmap() will be used only for aligned pages.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 3746cf6..ca03440 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -368,6 +368,7 @@ readpage_elf(unsigned long long paddr, void *bufptr)
 	off_t offset1, offset2;
 	size_t size1, size2;
 	unsigned long long phys_start, phys_end, frac_head = 0;
+	int original_usemmap = info->flag_usemmap;
 
 	offset1 = paddr_to_offset(paddr);
 	offset2 = paddr_to_offset(paddr + info->page_size);
@@ -392,6 +393,7 @@ readpage_elf(unsigned long long paddr, void *bufptr)
 		offset1 = paddr_to_offset(phys_start);
 		frac_head = phys_start - paddr;
 		memset(bufptr, 0, frac_head);
+		info->flag_usemmap = FALSE;
 	}
 
 	/*
@@ -402,6 +404,7 @@ readpage_elf(unsigned long long paddr, void *bufptr)
 		phys_end = page_head_to_phys_end(paddr);
 		offset2 = paddr_to_offset(phys_end);
 		memset(bufptr + (phys_end - paddr), 0, info->page_size - (phys_end - paddr));
+		info->flag_usemmap = FALSE;
 	}
 
 	/*
@@ -420,7 +423,7 @@ readpage_elf(unsigned long long paddr, void *bufptr)
 	if(!read_from_vmcore(offset1, bufptr + frac_head, size1)) {
 		ERRMSG("Can't read the dump memory(%s).\n",
 		       info->name_memory);
-		return FALSE;
+		goto error;
 	}
 
 	if (size1 + frac_head != info->page_size) {
@@ -429,11 +432,16 @@ readpage_elf(unsigned long long paddr, void *bufptr)
 		if(!read_from_vmcore(offset2, bufptr + frac_head + size1, size2)) {
 			ERRMSG("Can't read the dump memory(%s).\n",
 			       info->name_memory);
-			return FALSE;
+			goto error;
 		}
 	}
 
+	info->flag_usemmap = original_usemmap;
 	return TRUE;
+
+error:
+	info->flag_usemmap = original_usemmap;
+	return FALSE;
 }
 
 static int
-- 
1.8.0.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
