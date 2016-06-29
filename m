Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bIMt5-0008Jv-9t
 for kexec@lists.infradead.org; Wed, 29 Jun 2016 21:19:11 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TLIZJW048232
 for <kexec@lists.infradead.org>; Wed, 29 Jun 2016 17:18:50 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23sm3wvhrv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 29 Jun 2016 17:18:50 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 18:18:48 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id AC4C6352006C
 for <kexec@lists.infradead.org>; Wed, 29 Jun 2016 17:18:28 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TLIiOs3932472
 for <kexec@lists.infradead.org>; Wed, 29 Jun 2016 18:18:44 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TLIi6B022276
 for <kexec@lists.infradead.org>; Wed, 29 Jun 2016 18:18:44 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/9] kexec_file: Generalize kexec_add_buffer.
Date: Wed, 29 Jun 2016 18:18:43 -0300
In-Reply-To: <20160629194751.GB5488@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <2060648.f0n9OPAato@hactar>
 <20160629194751.GB5488@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-Id: <1994502.0E8c14rYFh@hactar>
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

Am Mittwoch, 29 Juni 2016, 15:47:51 schrieb Dave Young:
> On 06/28/16 at 07:18pm, Thiago Jung Bauermann wrote:
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index e8acb2b43dd9..e16d845d587f 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -146,7 +146,30 @@ struct kexec_file_ops {
> > 
> >       kexec_verify_sig_t *verify_sig;
> >  
> >  #endif
> >  };
> > 
> > -#endif
> > +
> > +/**
> > + * struct kexec_buf - parameters for finding a place for a buffer in
> > memory + * @image:   kexec image in which memory to search.
> > + * @mem:     On return will have address of the buffer in memory.
> > + * @memsz:   Size for the buffer in memory.
> > + * @buf_align:       Minimum alignment needed.
> > + * @buf_min: The buffer can't be placed below this address.
> > + * @buf_max: The buffer can't be placed above this address.
> > + * @top_down:        Allocate from top of memory.
> > + */
> > +struct kexec_buf {
> > +     struct kimage *image;
> > +     unsigned long mem;
> > +     unsigned long memsz;
> > +     unsigned long buf_align;
> > +     unsigned long buf_min;
> > +     unsigned long buf_max;
> > +     bool top_down;
> > +};
> 
> Rethink about the first patch, you dropped the user buffer in kexec_buf
> But later your passing IMA digests buffer patchset may need use it.
> 
> So keep it in kexec_buf should be better.

I'm not following. The IMA buffer patchset doesn't use kexec_locate_mem_hole 
nor struct kexec_buf.

> For the IMA buffer patchset I'm still reading and learning the
> background, will reply them later.

Thank you!

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
