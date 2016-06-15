Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bDDZd-00056s-Cx
 for kexec@lists.infradead.org; Wed, 15 Jun 2016 16:21:50 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5FGJqPc014669
 for <kexec@lists.infradead.org>; Wed, 15 Jun 2016 12:21:27 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23jch5u1m8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 15 Jun 2016 12:21:27 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 15 Jun 2016 13:21:24 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 4AEE3352005C
 for <kexec@lists.infradead.org>; Wed, 15 Jun 2016 12:21:05 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5FGLLk24292638
 for <kexec@lists.infradead.org>; Wed, 15 Jun 2016 13:21:21 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5FGLLHu012658
 for <kexec@lists.infradead.org>; Wed, 15 Jun 2016 13:21:21 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/9] kexec_file: Generalize kexec_add_buffer.
Date: Wed, 15 Jun 2016 13:21:16 -0300
In-Reply-To: <20160615073302.GA5684@dhcp-128-65.nay.redhat.com>
References: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1465916349-3398-3-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160615073302.GA5684@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-Id: <3237367.XLxdnj8q4x@hactar>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

Hello Dave,

Am Mittwoch, 15 Juni 2016, 15:33:02 schrieb Dave Young:
> > @@ -472,14 +498,16 @@ int kexec_add_buffer(struct kimage *image, char
> > *buffer, unsigned long bufsz,> 
> >  	kbuf->top_down = top_down;
> >  	
> >  	/* Walk the RAM ranges and allocate a suitable range for the buffer */
> > 
> > -	if (image->type == KEXEC_TYPE_CRASH)
> > -		ret = walk_iomem_res_desc(crashk_res.desc,
> > -				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> > -				crashk_res.start, crashk_res.end, kbuf,
> > -				locate_mem_hole_callback);
> > -	else
> > -		ret = walk_system_ram_res(0, -1, kbuf,
> > -					  locate_mem_hole_callback);
> > +	if (image->type == KEXEC_TYPE_CRASH) {
> > +		start = crashk_res.start;
> > +		end = crashk_res.end;
> > +	} else {
> > +		start = 0;
> > +		end = ULONG_MAX;
> > +	}
> 
> For crashk_res, start and end is global, the non-crash values are
> hard coded, thus it is not necessary to pass these two in arguments.
> 
> Moving above to arch_kexec_walk_mem will make it cleaner.

That's true. What about this version?

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


    kexec_file: Generalize kexec_add_buffer.
    
    Allow architectures to specify different memory walking functions for
    kexec_add_buffer. Intel uses iomem to track reserved memory ranges,
    but PowerPC uses the memblock subsystem.
    
    Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
    Cc: Eric Biederman <ebiederm@xmission.com>
    Cc: Dave Young <dyoung@redhat.com>
    Cc: kexec@lists.infradead.org
    Cc: linux-kernel@vger.kernel.org

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e8acb2b43dd9..9b02f907b40a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -315,6 +315,8 @@ int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
 					Elf_Shdr *sechdrs, unsigned int relsec);
 int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 					unsigned int relsec);
+int __weak arch_kexec_walk_mem(unsigned int image_type, bool top_down,
+			       void *data, int (*func)(u64, u64, void *));
 void arch_kexec_protect_crashkres(void);
 void arch_kexec_unprotect_crashkres(void);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b6eec7527e9f..2d066c458222 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -428,6 +428,29 @@ static int locate_mem_hole_callback(u64 start, u64 end, void *arg)
 	return locate_mem_hole_bottom_up(start, end, kbuf);
 }
 
+/**
+ * arch_kexec_walk_mem - call func(data) on free memory regions
+ * @image_type:	kimage.type
+ * @top_down:	Start from the highest address?
+ * @data:	Argument to pass to @func.
+ * @func:	Function to call for each memory region.
+ *
+ * Return: The memory walk will stop when func returns a non-zero value
+ * and that value will be returned. If all free regions are visited without
+ * func returning non-zero, then zero will be returned.
+ */
+int __weak arch_kexec_walk_mem(unsigned int image_type, bool top_down,
+			       void *data, int (*func)(u64, u64, void *))
+{
+	if (image_type == KEXEC_TYPE_CRASH)
+		return walk_iomem_res_desc(crashk_res.desc,
+					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+					   crashk_res.start, crashk_res.end,
+					   data, func);
+	else
+		return walk_system_ram_res(0, ULONG_MAX, data, func);
+}
+
 /*
  * Helper function for placing a buffer in a kexec segment. This assumes
  * that kexec_mutex is held.
@@ -472,14 +495,8 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 	kbuf->top_down = top_down;
 
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
-	if (image->type == KEXEC_TYPE_CRASH)
-		ret = walk_iomem_res_desc(crashk_res.desc,
-				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
-				crashk_res.start, crashk_res.end, kbuf,
-				locate_mem_hole_callback);
-	else
-		ret = walk_system_ram_res(0, -1, kbuf,
-					  locate_mem_hole_callback);
+	ret = arch_kexec_walk_mem(image->type, top_down, kbuf,
+				   locate_mem_hole_callback);
 	if (ret != 1) {
 		/* A suitable memory range could not be found for buffer */
 		return -EADDRNOTAVAIL;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
