Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.21] helo=orsmga101.jf.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2C43-0008Sn-0x
	for kexec@lists.infradead.org; Thu, 07 May 2009 22:27:45 +0000
From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH 10/14] x86,
	doc: document the runtime_start and runtime_size bzImage fields
Date: Thu,  7 May 2009 15:26:58 -0700
Message-Id: <1241735222-6640-11-git-send-email-hpa@linux.intel.com>
In-Reply-To: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, sam@ravnborg.org, tglx@linutronix.de, vgoyal@redhat.com

From: H. Peter Anvin <hpa@zytor.com>

Add documentation for the runtime_start and runtime_size fields;
bzImage protocol version 2.10 (0x020a).

[ Impact: documentation only ]

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 Documentation/x86/boot.txt |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
index e020366..093f838 100644
--- a/Documentation/x86/boot.txt
+++ b/Documentation/x86/boot.txt
@@ -50,6 +50,10 @@ Protocol 2.08:	(Kernel 2.6.26) Added crc32 checksum and ELF format
 Protocol 2.09:	(Kernel 2.6.26) Added a field of 64-bit physical
 		pointer to single linked list of struct	setup_data.
 
+Protocol 2.10:	(Kernel 2.6.31) Added the runtime_start and
+		runtime_size fields for the post-decompression address
+		and memory requirements of the kernel.
+
 **** MEMORY LAYOUT
 
 The traditional memory map for the kernel loader, used for Image or
@@ -182,6 +186,8 @@ Offset	Proto	Name		Meaning
 024C/4	2.08+	payload_length	Length of kernel payload
 0250/8	2.09+	setup_data	64-bit physical pointer to linked list
 				of struct setup_data
+0258/4	2.10+	runtime_start	(Minimum) post-decompression address
+025C/4	2.10+	runtime_size	Minimum linear memory required
 
 (1) For backwards compatibility, if the setup_sects field contains 0, the
     real value is 4.
@@ -582,6 +588,41 @@ Protocol:	2.09+
   sure to consider the case where the linked list already contains
   entries.
 
+Field name:	runtime_start
+Type:		modify (optional, reloc)
+Offset/size:	0x258/4
+Protocol:	2.10+
+
+  For a non-relocatable kernel, this is a readonly field indicating
+  the post-decompression address of the kernel.  This will typically
+  be larger than the load address (0x100000).
+
+  For a relocatable kernel, this is a read-write field indicating the
+  *minimum* post-decompression address of the kernel.  This allows
+  unchanged behavior when a non-relocating bootloader is used.  If
+  this value is greater than the load address, this value is used; if
+  this value is smaller than the load address, the load address is
+  rounded up to the nearest multiple of the kernel_alignment field and
+  this field is ignored.
+
+  A relocating bootloader can override this field, e.g. by setting it
+  to zero, to force the load address to control the runtime address of
+  the kernel.
+
+Field name:	runtime_size
+Type:		read
+Offset/size:	0x25C/4
+Protocol:	2.10+
+
+  This field informs the boot loader of the amount of linearly
+  contiguous memory starting at the kernel decompression address (as
+  given by the appropriate combination of the load address,
+  runtime_start, and kernel_alignment) that the kernel will require
+  before it becomes aware of the memory map.  It does *not* guarantee
+  a successful boot with only this memory, but it may be a useful
+  guideline for a relocating bootloader when it comes to selecting an
+  address to load the kernel.
+
 
 **** THE IMAGE CHECKSUM
 
-- 
1.6.0.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
