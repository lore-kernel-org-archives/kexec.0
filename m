Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFAkm-0005Ou-Px
 for kexec@lists.infradead.org; Tue, 21 Jun 2016 01:45:27 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L1idBV093882
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 21:45:04 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n0mekejm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 21:45:04 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:45:01 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 8DDD81DC0054
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 21:44:51 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L1iw9W4751386
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 22:44:58 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L1iw37030044
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 22:44:58 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 5/6] kexec: Share logic to copy segment page contents.
Date: Mon, 20 Jun 2016 22:44:35 -0300
In-Reply-To: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1466473476-10104-6-git-send-email-bauerman@linux.vnet.ibm.com>
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
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Eric Richter <erichte@linux.vnet.ibm.com>

Make kimage_load_normal_segment and kexec_update_segment share code
which they currently duplicate.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 kernel/kexec_core.c | 159 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 95 insertions(+), 64 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 8781d3e4479d..281d8b961fb4 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -700,6 +700,65 @@ static struct page *kimage_alloc_page(struct kimage *image,
 	return page;
 }
 
+struct kimage_update_buffer_state {
+	/* Destination memory address currently being copied to. */
+	unsigned long maddr;
+
+	/* Bytes in buffer still left to copy. */
+	size_t ubytes;
+
+	/* Bytes in memory still left to copy. */
+	size_t mbytes;
+
+	/* If true, copy from kbuf. */
+	bool from_kernel;
+
+	/* Clear pages before copying? */
+	bool clear_pages;
+
+	/* Buffer position to continue copying from. */
+	const unsigned char *kbuf;
+	const unsigned char __user *buf;
+};
+
+static int kimage_update_page(struct page *page,
+			      struct kimage_update_buffer_state *state)
+{
+	char *ptr;
+	int result = 0;
+	size_t uchunk, mchunk;
+
+	ptr = kmap(page);
+
+	/* Start with a clear page */
+	if (state->clear_pages)
+		clear_page(ptr);
+
+	ptr += state->maddr & ~PAGE_MASK;
+	mchunk = min_t(size_t, state->mbytes,
+		       PAGE_SIZE - (state->maddr & ~PAGE_MASK));
+	uchunk = min(state->ubytes, mchunk);
+
+	if (state->from_kernel)
+		memcpy(ptr, state->kbuf, uchunk);
+	else
+		result = copy_from_user(ptr, state->buf, uchunk);
+
+	kunmap(page);
+	if (result)
+		return -EFAULT;
+
+	state->ubytes -= uchunk;
+	state->maddr += mchunk;
+	if (state->from_kernel)
+		state->kbuf += mchunk;
+	else
+		state->buf += mchunk;
+	state->mbytes -= mchunk;
+
+	return 0;
+}
+
 /**
  * kexec_update_segment - update the contents of a kimage segment
  * @buffer:	New contents of the segment.
@@ -718,6 +777,7 @@ int kexec_update_segment(const char *buffer, unsigned long bufsz,
 	unsigned long entry;
 	unsigned long *ptr = NULL;
 	void *dest = NULL;
+	struct kimage_update_buffer_state state;
 
 	for (i = 0; i < kexec_image->nr_segments; i++)
 		/* We only support updating whole segments. */
@@ -736,8 +796,15 @@ int kexec_update_segment(const char *buffer, unsigned long bufsz,
 		return -EINVAL;
 	}
 
-	for (entry = kexec_image->head; !(entry & IND_DONE) && memsz;
-	     entry = *ptr++) {
+	state.maddr = load_addr;
+	state.ubytes = bufsz;
+	state.mbytes = memsz;
+	state.kbuf = buffer;
+	state.from_kernel = true;
+	state.clear_pages = false;
+
+	for (entry = kexec_image->head; !(entry & IND_DONE) &&
+					state.mbytes; entry = *ptr++) {
 		void *addr = (void *) (entry & PAGE_MASK);
 
 		switch (entry & IND_FLAGS) {
@@ -754,26 +821,13 @@ int kexec_update_segment(const char *buffer, unsigned long bufsz,
 				return -EINVAL;
 			}
 
-			if (dest == (void *) load_addr) {
-				struct page *page;
-				char *ptr;
-				size_t uchunk, mchunk;
-
-				page = kmap_to_page(addr);
-
-				ptr = kmap(page);
-				ptr += load_addr & ~PAGE_MASK;
-				mchunk = min_t(size_t, memsz,
-					       PAGE_SIZE - (load_addr & ~PAGE_MASK));
-				uchunk = min(bufsz, mchunk);
-				memcpy(ptr, buffer, uchunk);
-
-				kunmap(page);
+			if (dest == (void *) state.maddr) {
+				int ret;
 
-				bufsz -= uchunk;
-				load_addr += mchunk;
-				buffer += mchunk;
-				memsz -= mchunk;
+				ret = kimage_update_page(kmap_to_page(addr),
+							 &state);
+				if (ret)
+					return ret;
 			}
 			dest += PAGE_SIZE;
 		}
@@ -791,31 +845,30 @@ int kexec_update_segment(const char *buffer, unsigned long bufsz,
 static int kimage_load_normal_segment(struct kimage *image,
 					 struct kexec_segment *segment)
 {
-	unsigned long maddr;
-	size_t ubytes, mbytes;
-	int result;
-	unsigned char __user *buf = NULL;
-	unsigned char *kbuf = NULL;
-
-	result = 0;
-	if (image->file_mode)
-		kbuf = segment->kbuf;
-	else
-		buf = segment->buf;
-	ubytes = segment->bufsz;
-	mbytes = segment->memsz;
-	maddr = segment->mem;
+	int result = 0;
+	struct kimage_update_buffer_state state;
+
+	/* For file based kexec, source pages are in kernel memory */
+	if (image->file_mode) {
+		state.kbuf = segment->kbuf;
+		state.from_kernel = true;
+	} else {
+		state.buf = segment->buf;
+		state.from_kernel = false;
+	}
+	state.ubytes = segment->bufsz;
+	state.mbytes = segment->memsz;
+	state.maddr = segment->mem;
+	state.clear_pages = true;
 
-	result = kimage_set_destination(image, maddr);
+	result = kimage_set_destination(image, state.maddr);
 	if (result < 0)
 		goto out;
 
-	while (mbytes) {
+	while (state.mbytes) {
 		struct page *page;
-		char *ptr;
-		size_t uchunk, mchunk;
 
-		page = kimage_alloc_page(image, GFP_HIGHUSER, maddr);
+		page = kimage_alloc_page(image, GFP_HIGHUSER, state.maddr);
 		if (!page) {
 			result  = -ENOMEM;
 			goto out;
@@ -825,31 +878,9 @@ static int kimage_load_normal_segment(struct kimage *image,
 		if (result < 0)
 			goto out;
 
-		ptr = kmap(page);
-		/* Start with a clear page */
-		clear_page(ptr);
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
-		uchunk = min(ubytes, mchunk);
-
-		/* For file based kexec, source pages are in kernel memory */
-		if (image->file_mode)
-			memcpy(ptr, kbuf, uchunk);
-		else
-			result = copy_from_user(ptr, buf, uchunk);
-		kunmap(page);
-		if (result) {
-			result = -EFAULT;
+		result = kimage_update_page(page, &state);
+		if (result)
 			goto out;
-		}
-		ubytes -= uchunk;
-		maddr  += mchunk;
-		if (image->file_mode)
-			kbuf += mchunk;
-		else
-			buf += mchunk;
-		mbytes -= mchunk;
 	}
 out:
 	return result;
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
