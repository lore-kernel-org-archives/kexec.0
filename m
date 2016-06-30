Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bIdYy-0006AO-4P
 for kexec@lists.infradead.org; Thu, 30 Jun 2016 15:07:32 +0000
Date: Thu, 30 Jun 2016 11:07:00 -0400
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 2/9] kexec_file: Generalize kexec_add_buffer.
Message-ID: <20160630150700.GA3058@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <2060648.f0n9OPAato@hactar>
 <20160629194751.GB5488@dhcp-128-65.nay.redhat.com>
 <1994502.0E8c14rYFh@hactar>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1994502.0E8c14rYFh@hactar>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

On 06/29/16 at 06:18pm, Thiago Jung Bauermann wrote:
> Am Mittwoch, 29 Juni 2016, 15:47:51 schrieb Dave Young:
> > On 06/28/16 at 07:18pm, Thiago Jung Bauermann wrote:
> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index e8acb2b43dd9..e16d845d587f 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -146,7 +146,30 @@ struct kexec_file_ops {
> > > 
> > >       kexec_verify_sig_t *verify_sig;
> > >  
> > >  #endif
> > >  };
> > > 
> > > -#endif
> > > +
> > > +/**
> > > + * struct kexec_buf - parameters for finding a place for a buffer in
> > > memory + * @image:   kexec image in which memory to search.
> > > + * @mem:     On return will have address of the buffer in memory.
> > > + * @memsz:   Size for the buffer in memory.
> > > + * @buf_align:       Minimum alignment needed.
> > > + * @buf_min: The buffer can't be placed below this address.
> > > + * @buf_max: The buffer can't be placed above this address.
> > > + * @top_down:        Allocate from top of memory.
> > > + */
> > > +struct kexec_buf {
> > > +     struct kimage *image;
> > > +     unsigned long mem;
> > > +     unsigned long memsz;
> > > +     unsigned long buf_align;
> > > +     unsigned long buf_min;
> > > +     unsigned long buf_max;
> > > +     bool top_down;
> > > +};
> > 
> > Rethink about the first patch, you dropped the user buffer in kexec_buf
> > But later your passing IMA digests buffer patchset may need use it.
> > 
> > So keep it in kexec_buf should be better.
> 
> I'm not following. The IMA buffer patchset doesn't use kexec_locate_mem_hole 
> nor struct kexec_buf.

It does not use kexec_locate_mem_hole, but the buffer being passed is
very similar to a kexec_buf struct, no? 

So you may refactor kexec_add_buffer and your new function to pass only kimage
and a kbuf, it will be better than passing all those arguments separately.

> 
> > For the IMA buffer patchset I'm still reading and learning the
> > background, will reply them later.
> 
> Thank you!
> 
> []'s
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
