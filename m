Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bJ2bP-0007AA-9E
 for kexec@lists.infradead.org; Fri, 01 Jul 2016 17:51:43 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u61HiF4j086260
 for <kexec@lists.infradead.org>; Fri, 1 Jul 2016 13:51:21 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23wpmf5yfb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 01 Jul 2016 13:51:21 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 14:51:19 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 702513520068
 for <kexec@lists.infradead.org>; Fri,  1 Jul 2016 13:51:00 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u61HpHuh4391164
 for <kexec@lists.infradead.org>; Fri, 1 Jul 2016 14:51:17 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u61HpHbC028524
 for <kexec@lists.infradead.org>; Fri, 1 Jul 2016 14:51:17 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/9] kexec_file: Generalize kexec_add_buffer.
Date: Fri, 01 Jul 2016 14:51:16 -0300
In-Reply-To: <20160630214357.GB4187@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1902156.s2yTykCR7c@hactar>
 <20160630214357.GB4187@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-Id: <3713936.n8FBhAAd79@hactar>
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
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

Am Donnerstag, 30 Juni 2016, 17:43:57 schrieb Dave Young:
> On 06/30/16 at 01:42pm, Thiago Jung Bauermann wrote:
> > Am Donnerstag, 30 Juni 2016, 12:49:44 schrieb Thiago Jung Bauermann:
> > > To be honest I think struct kexec_buf is an implementation detail
> > > inside
> > > kexec_locate_mem_hole, made necessary because the callback functions
> > > it
> > > uses need to access its arguments. Callers of kexec_locate_mem_hole,
> > > kexec_add_handover_buffer and kexec_add_buffer shouldn't need to know
> > > it
> > > exists.
> > 
> > Elaborating a bit more: the argument list for these three functions are
> > equal or similar because kexec_add_handover_buffer uses
> > kexec_add_buffer,
> > which uses kexec_locate_mem_hole.
> > 
> > It could be beneficial to have a struct to collect the arguments to
> > these
> > functions if someone using one of them would be likely to use another
> > one
> > with the same arguments. In that case, you set up kexec_buf once and
> > then
> > just pass it whenever you need to call one of those functions.
> > 
> > But that is unlikely to happen. A user of the kexec API will need to use
> > only one of these functions with a given set of arguments, so they don't
> > gain anything by setting up a struct.
> > 
> > Syntactically, I also don't think it's clearer to set struct members
> > instead of simply passing arguments to a function, even if the argument
> > list is long.
> 
> Sorry, I'm not sure I get your points but the long argument list really
> looks ugly, since you are introducing more callbacks I still think a
> cleanup is necessary.
> 
> kexec_buffer struct is pretty fine to be a abstract of all these buffers.

What I understood from what you said is that making the following change
results in code that is easier to understand:

@@ -650,6 +639,7 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 	const Elf_Shdr *sechdrs_c;
 	Elf_Shdr *sechdrs = NULL;
 	void *purgatory_buf = NULL;
+	struct kexec_buf buf;
 
 	/*
 	 * sechdrs_c points to section headers in purgatory and are read
@@ -757,11 +747,19 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 		buf_align = bss_align;
 
 	/* Add buffer to segment list */
-	ret = kexec_add_buffer(image, purgatory_buf, buf_sz, memsz,
-				buf_align, min, max, top_down,
-				&pi->purgatory_load_addr);
+	memset(&buf, 0, sizeof(struct kexec_buf));
+	buf.image = image;
+	buf.buffer = purgatory_buf;
+	buf.bufsz = buf_sz,
+	buf.memsz = memsz;
+	buf.buf_align = buf_align;
+	buf.buf_min = min;
+	buf.buf_max = max;
+	buf.top_down = top_down;
+	ret = kexec_add_buffer(&buf);
 	if (ret)
 		goto out;
+	pi->purgatory_load_addr = buf.mem;
 
 	/* Load SHF_ALLOC sections */
 	buf_addr = purgatory_buf;

There are 9 calls to kexec_add_buffer in the kernel (including arch/x86,
arch/powerpc/ and kernel/), plus 1 to kexec_locate_mem_hole
and 1 to kexec_add_handover_buffer, so there would be 11 places in
the code settings up kexec_buf. My opinion is that this change doesn't
improve code readability.

Also, I think that kexec_buf abstracts something that, from the
perspective of the user of the kexec API, lives only for the duration
of a single call to either of kexec_add_buffer, kexec_locate_mem_hole,
or kexec_add_handover_buffer. Because of this, there's no need from the
perspective of the API user to initialize this "object", so this just
adds to their cognitive load without any benefit to them.

I understand that this is all somewhat subjective, so if you still disagree
with my points I can provide a patch set implementing the change above.

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
