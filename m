Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZHjYT-0003Ds-5R
 for kexec@lists.infradead.org; Wed, 22 Jul 2015 02:14:45 +0000
Date: Wed, 22 Jul 2015 10:14:08 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH V2 2/2] kexec: split kexec_load syscall from kexec core
 code
Message-ID: <20150722021408.GA16615@dhcp-128-11.nay.redhat.com>
References: <20150720083713.528114272@redhat.com>
 <20150720084558.645442047@redhat.com>
 <20150721130308.GB5053@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150721130308.GB5053@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: jwboyer@fedoraproject.org, tytso@mit.edu, kexec@lists.infradead.org, ptesarik@suse.cz, linux-kernel@vger.kernel.org, dhowells@redhat.com, geert@linux-m68k.org, ebiederm@xmission.com, akpm@linux-foundation.org

On 07/21/15 at 09:03am, Vivek Goyal wrote:
> On Mon, Jul 20, 2015 at 04:37:15PM +0800, dyoung@redhat.com wrote:
> > Now there's two kexec load syscall, one is kexec_load another is
> > kexec_file_load, kexec_file_load has been splited as kernel/kexec_file.c.
> > In this patch I split kexec_load syscall code to kernel/kexec.c.
> 
> Hi Dave,
> 
> Nice work. Thanks for doing this. I have couple of minor comments.
> 
> - We might have to audit kernel/kexec_core.c. I think there are some
>   functions in there which are used by only old syscall and not the new
>   one. All that code should be in kernel/kexec.c. Only the code which is
>   shared between two syscalls should be in kernel/kexec_core.c.
>   
>   For example, I think kimage_alloc_init() is used by old syscall only.
>   New syscall uses kimage_file_alloc_init().

You are right, actually two functions
copy_user_segment_list and kimage_alloc_init are used by kexec.c only

Will move them to kexec.c from kexec_core.c, it works well during my testing

> 
> [..]
> > --- linux.orig/include/linux/kexec.h
> > +++ linux/include/linux/kexec.h
> > @@ -16,7 +16,7 @@
> >  
> >  #include <uapi/linux/kexec.h>
> >  
> > -#ifdef CONFIG_KEXEC
> > +#ifdef CONFIG_KEXEC_CORE
> >  #include <linux/list.h>
> >  #include <linux/linkage.h>
> >  #include <linux/compat.h>
> > @@ -318,12 +318,18 @@ int crash_shrink_memory(unsigned long ne
> >  size_t crash_get_memory_size(void);
> >  void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
> >  
> > -#else /* !CONFIG_KEXEC */
> > +#ifdef CONFIG_KEXEC
> > +int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> > +			     unsigned long nr_segments,
> > +			     struct kexec_segment __user *segments,
> > +			     unsigned long flags);
> > +#endif
> 
> I am wondering why this needs to be in kexec.h. Who needs this? Even if
> somebody needs this, this should probably be outside of KEXEC_CORE.

It was added here in 1st version before adding kexec_internal.h, later
I moved most of them to kexec_internal.h, but yes it is not used by
any file other than kexec.c, will drop this chunk.

Thanks a lot
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
