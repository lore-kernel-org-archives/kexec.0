Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W2a6I-0004jW-Gu
 for kexec@lists.infradead.org; Mon, 13 Jan 2014 05:30:15 +0000
Date: Mon, 13 Jan 2014 13:29:44 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH] vmcore-dmesg: struct_val_u64() not casting u64 to u32
Message-ID: <20140113052944.GG9622@dhcp-17-89.nay.redhat.com>
References: <1389029854-2052-1-git-send-email-chaowang@redhat.com>
 <20140106191447.GA19883@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140106191447.GA19883@redhat.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On 01/06/14 at 02:14pm, Vivek Goyal wrote:
> On Tue, Jan 07, 2014 at 01:37:34AM +0800, WANG Chao wrote:
> > It seems gcc doesn't check return type from inline function.
> > struct_val_u64() should return u64 otherwise upper 32bit is lost.
> > 
> > Signed-off-by: WANG Chao <chaowang@redhat.com>
> 
> Acked-by: Vivek Goyal <vgoyal@redhat.com>
> 
> Vivek

Hi, Simon

Could you please pick up this one?

Thanks
WANG Chao

> 
> > ---
> >  vmcore-dmesg/vmcore-dmesg.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
> > index 0f477c0..df14c89 100644
> > --- a/vmcore-dmesg/vmcore-dmesg.c
> > +++ b/vmcore-dmesg/vmcore-dmesg.c
> > @@ -529,7 +529,7 @@ static inline uint32_t struct_val_u32(char *ptr, unsigned int offset)
> >  	return(file32_to_cpu(*(uint32_t *)(ptr + offset)));
> >  }
> >  
> > -static inline uint32_t struct_val_u64(char *ptr, unsigned int offset)
> > +static inline uint64_t struct_val_u64(char *ptr, unsigned int offset)
> >  {
> >  	return(file64_to_cpu(*(uint64_t *)(ptr + offset)));
> >  }
> > -- 
> > 1.8.4.2
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
