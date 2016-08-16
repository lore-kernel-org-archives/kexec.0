Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZhjb-00086H-V2
 for kexec@lists.infradead.org; Tue, 16 Aug 2016 17:01:05 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7GGxUvJ077716
 for <kexec@lists.infradead.org>; Tue, 16 Aug 2016 13:00:42 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24sxupe3se-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 16 Aug 2016 13:00:41 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 16 Aug 2016 14:00:38 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 618BA352005F
 for <kexec@lists.infradead.org>; Tue, 16 Aug 2016 13:00:15 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7GH0ZhW65863918
 for <kexec@lists.infradead.org>; Tue, 16 Aug 2016 14:00:35 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7GH0X7M027894
 for <kexec@lists.infradead.org>; Tue, 16 Aug 2016 14:00:34 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/6] kexec_file: Add mechanism to update kexec segments.
Date: Tue, 16 Aug 2016 14:00:31 -0300
In-Reply-To: <20160815152756.78ea7a61a3342547b9e694e5@linux-foundation.org>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1471058305-30198-5-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160815152756.78ea7a61a3342547b9e694e5@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <1734678.Uaq7DTajoE@hactar>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-ima-devel@lists.sourceforge.net, Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Petko Manolov <petkan@mip-labs.com>, Thomas Gleixner <tglx@linutronix.de>, Eric Richter <erichte@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, David Laight <David.Laight@aculab.com>, Eric Biederman <ebiederm@xmission.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@lists.ozlabs.org

Hello Andrew,

Thank you for your review!

Am Montag, 15 August 2016, 15:27:56 schrieb Andrew Morton:
> On Sat, 13 Aug 2016 00:18:23 -0300 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:
> > +/**
> > + * kexec_update_segment - update the contents of a kimage segment
> > + * @buffer:	New contents of the segment.
> > + * @bufsz:	@buffer size.
> > + * @load_addr:	Segment's physical address in the next kernel.
> > + * @memsz:	Segment size.
> > + *
> > + * This function assumes kexec_mutex is held.
> > + *
> > + * Return: 0 on success, negative errno on error.
> > + */
> > +int kexec_update_segment(const char *buffer, unsigned long bufsz,
> > +			 unsigned long load_addr, unsigned long memsz)
> > +{
> > +	int i;
> > +	unsigned long entry;
> > +	unsigned long *ptr = NULL;
> > +	void *dest = NULL;
> > +
> > +	if (kexec_image == NULL) {
> > +		pr_err("Can't update segment: no kexec image loaded.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * kexec_add_buffer rounds up segment sizes to PAGE_SIZE, so
> > +	 * we have to do it here as well.
> > +	 */
> > +	memsz = ALIGN(memsz, PAGE_SIZE);
> > +
> > +	for (i = 0; i < kexec_image->nr_segments; i++)
> > +		/* We only support updating whole segments. */
> > +		if (load_addr == kexec_image->segment[i].mem &&
> > +		    memsz == kexec_image->segment[i].memsz) {
> > +			if (kexec_image->segment[i].do_checksum) {
> > +				pr_err("Trying to update non-modifiable segment.\n");
> > +				return -EINVAL;
> > +			}
> > +
> > +			break;
> > +		}
> > +	if (i == kexec_image->nr_segments) {
> > +		pr_err("Couldn't find segment to update: 0x%lx, size 0x%lx\n",
> > +		       load_addr, memsz);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (entry = kexec_image->head; !(entry & IND_DONE) && memsz;
> > +	     entry = *ptr++) {
> > +		void *addr = (void *) (entry & PAGE_MASK);
> > +
> > +		switch (entry & IND_FLAGS) {
> > +		case IND_DESTINATION:
> > +			dest = addr;
> > +			break;
> > +		case IND_INDIRECTION:
> > +			ptr = __va(addr);
> > +			break;
> > +		case IND_SOURCE:
> > +			/* Shouldn't happen, but verify just to be safe. */
> > +			if (dest == NULL) {
> > +				pr_err("Invalid kexec entries list.");
> > +				return -EINVAL;
> > +			}
> > +
> > +			if (dest == (void *) load_addr) {
> > +				struct page *page;
> > +				char *ptr;
> > +				size_t uchunk, mchunk;
> > +
> > +				page = kmap_to_page(addr);
> > +
> > +				ptr = kmap(page);
> 
> kmap_atomic() could be used here, and it is appreciably faster.

Good idea. The patch below implements your suggestion.

This has a consequence for patch 5/6 in this series, because it makes
this code be used in the path of the kexec_file_load and
kexec_load syscalls.

In the latter case, there's a call to copy_from_user and thus kmap_atomic 
can't be used. I can change the patch to use kmap_atomic if
state->from_kernel is true and kmap otherwise, but perhaps this is one more 
hint that patch 5/6 is not a very good idea after all.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


Subject: [PATCH v2 4/6] kexec_file: Add mechanism to update kexec segments.

kexec_update_segment allows a given segment in kexec_image to have
its contents updated. This is useful if the current kernel wants to
send information to the next kernel that is up-to-date at the time of
reboot.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 include/linux/kexec.h |  2 ++
 kernel/kexec_core.c   | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 37eea32fdff1..14dda81e3e01 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -259,6 +259,8 @@ extern int kexec_purgatory_get_set_symbol(struct kimage *image,
 					  unsigned int size, bool get_value);
 extern void *kexec_purgatory_get_symbol_addr(struct kimage *image,
 					     const char *name);
+int kexec_update_segment(const char *buffer, unsigned long bufsz,
+			 unsigned long load_addr, unsigned long memsz);
 extern void __crash_kexec(struct pt_regs *);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 561675589511..9782b292714e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -721,6 +721,105 @@ static struct page *kimage_alloc_page(struct kimage *image,
 	return page;
 }
 
+/**
+ * kexec_update_segment - update the contents of a kimage segment
+ * @buffer:	New contents of the segment.
+ * @bufsz:	@buffer size.
+ * @load_addr:	Segment's physical address in the next kernel.
+ * @memsz:	Segment size.
+ *
+ * This function assumes kexec_mutex is held.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int kexec_update_segment(const char *buffer, unsigned long bufsz,
+			 unsigned long load_addr, unsigned long memsz)
+{
+	int i;
+	unsigned long entry;
+	unsigned long *ptr = NULL;
+	void *dest = NULL;
+
+	if (kexec_image == NULL) {
+		pr_err("Can't update segment: no kexec image loaded.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * kexec_add_buffer rounds up segment sizes to PAGE_SIZE, so
+	 * we have to do it here as well.
+	 */
+	memsz = ALIGN(memsz, PAGE_SIZE);
+
+	for (i = 0; i < kexec_image->nr_segments; i++)
+		/* We only support updating whole segments. */
+		if (load_addr == kexec_image->segment[i].mem &&
+		    memsz == kexec_image->segment[i].memsz) {
+			if (kexec_image->segment[i].do_checksum) {
+				pr_err("Trying to update non-modifiable segment.\n");
+				return -EINVAL;
+			}
+
+			break;
+		}
+	if (i == kexec_image->nr_segments) {
+		pr_err("Couldn't find segment to update: 0x%lx, size 0x%lx\n",
+		       load_addr, memsz);
+		return -EINVAL;
+	}
+
+	for (entry = kexec_image->head; !(entry & IND_DONE) && memsz;
+	     entry = *ptr++) {
+		void *addr = (void *) (entry & PAGE_MASK);
+
+		switch (entry & IND_FLAGS) {
+		case IND_DESTINATION:
+			dest = addr;
+			break;
+		case IND_INDIRECTION:
+			ptr = __va(addr);
+			break;
+		case IND_SOURCE:
+			/* Shouldn't happen, but verify just to be safe. */
+			if (dest == NULL) {
+				pr_err("Invalid kexec entries list.");
+				return -EINVAL;
+			}
+
+			if (dest == (void *) load_addr) {
+				struct page *page;
+				char *ptr;
+				size_t uchunk, mchunk;
+
+				page = kmap_to_page(addr);
+
+				ptr = kmap_atomic(page);
+				ptr += load_addr & ~PAGE_MASK;
+				mchunk = min_t(size_t, memsz,
+					       PAGE_SIZE - (load_addr & ~PAGE_MASK));
+				uchunk = min(bufsz, mchunk);
+				memcpy(ptr, buffer, uchunk);
+
+				kunmap_atomic(ptr);
+
+				bufsz -= uchunk;
+				load_addr += mchunk;
+				buffer += mchunk;
+				memsz -= mchunk;
+			}
+			dest += PAGE_SIZE;
+		}
+
+		/* Shouldn't happen, but verify just to be safe. */
+		if (ptr == NULL) {
+			pr_err("Invalid kexec entries list.");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int kimage_load_normal_segment(struct kimage *image,
 					 struct kexec_segment *segment)
 {
-- 
1.9.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
