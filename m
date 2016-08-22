Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bbxbA-0006OF-Fg
 for kexec@lists.infradead.org; Mon, 22 Aug 2016 22:21:41 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7MMJK03120348
 for <kexec@lists.infradead.org>; Mon, 22 Aug 2016 18:21:17 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24y0w62na9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 22 Aug 2016 18:21:17 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 22 Aug 2016 19:21:14 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 8F0631DC0054
 for <kexec@lists.infradead.org>; Mon, 22 Aug 2016 18:21:02 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7MMLBiS26083748
 for <kexec@lists.infradead.org>; Mon, 22 Aug 2016 19:21:11 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7MMLA8G028227
 for <kexec@lists.infradead.org>; Mon, 22 Aug 2016 19:21:11 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/6] powerpc: kexec_file: Add buffer hand-over support
 for the next kernel
Date: Mon, 22 Aug 2016 19:21:09 -0300
In-Reply-To: <20160822072200.GA32673@dhcp-128-65.nay.redhat.com>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <5233171.lLzbU6ABRT@hactar>
 <20160822072200.GA32673@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-Id: <1796099.kfo9Nk8t61@hactar>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-ima-devel@lists.sourceforge.net, Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Petko Manolov <petkan@mip-labs.com>, Thomas Gleixner <tglx@linutronix.de>, Eric Richter <erichte@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, David Laight <David.Laight@aculab.com>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@lists.ozlabs.org

Am Montag, 22 August 2016, 15:22:00 schrieb Dave Young:
> On 08/22/16 at 12:38am, Thiago Jung Bauermann wrote:
> > Am Montag, 22 August 2016, 11:21:35 schrieb Dave Young:
> > > On 08/13/16 at 12:18am, Thiago Jung Bauermann wrote:
> > > > diff --git a/arch/powerpc/kernel/machine_kexec_64.c
> > > > b/arch/powerpc/kernel/machine_kexec_64.c index
> > > > a484a6346146..190c652e49b7 100644
> > > > --- a/arch/powerpc/kernel/machine_kexec_64.c
> > > > +++ b/arch/powerpc/kernel/machine_kexec_64.c
> > > > @@ -490,6 +490,60 @@ int arch_kimage_file_post_load_cleanup(struct
> > > > kimage *image)>
> > > > 
> > > >  	return image->fops->cleanup(image->image_loader_data);
> > > >  
> > > >  }
> > > > 
> > > > +bool kexec_can_hand_over_buffer(void)
> > > > +{
> > > > +	return true;
> > > > +}
> > > > +
> > > > +int arch_kexec_add_handover_buffer(struct kimage *image,
> > > > +				   unsigned long load_addr, unsigned 
long
> > 
> > size)
> > 
> > > > +{
> > > > +	image->arch.handover_buffer_addr = load_addr;
> > > > +	image->arch.handover_buffer_size = size;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +int kexec_get_handover_buffer(void **addr, unsigned long *size)
> > > > +{
> > > > +	int ret;
> > > > +	u64 start_addr, end_addr;
> > > > +
> > > > +	ret = of_property_read_u64(of_chosen,
> > > > +				   "linux,kexec-handover-buffer-
start",
> > > > +				   &start_addr);
> > > > +	if (ret == -EINVAL)
> > > > +		return -ENOENT;
> > > > +	else if (ret)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ret = of_property_read_u64(of_chosen,
> > > > "linux,kexec-handover-buffer-end", +
> > 
> > &end_addr);
> > 
> > > > +	if (ret == -EINVAL)
> > > > +		return -ENOENT;
> > > > +	else if (ret)
> > > > +		return -EINVAL;
> > > > +
> > > > +	*addr =  __va(start_addr);
> > > > +	/* -end is the first address after the buffer. */
> > > > +	*size = end_addr - start_addr;
> > > > +
> > > > +	return 0;
> > > > +}
> > > 
> > > This depends on dtb, so if IMA want to extend it to arches like x86 in
> > > the future you will have to think about other way to pass it.
> > > 
> > > How about think about a general way now?
> > 
> > The only general way I can think of is by adding a kernel command line
> > parameter which the first kernel would pass to the second kernel, but
> > IMHO that is ugly, because such parameter wouldn't be useful to a user,
> > and it would also be something that, from the perspective of the user,
> > would magically appear in the kernel command line of the second
> > kernel...
> Sorry I just brought up the question, actually I have no idea either.
> Maybe we have to do this with arch specific ways..

Actually, I don't think it's possible to avoid arch-specific code because 
the first kernel has to put the buffer memory region in a reserved memory 
map, and that is arch-specific.

On powerpc, this is done by adding it to the device tree memory reservation 
map. On x86, I believe this would be done added to the e820 map.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
