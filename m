Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vl9LN-0007Li-D5
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 03:29:46 +0000
Date: Tue, 26 Nov 2013 11:29:17 +0800
From: "chaowang@redhat.com" <chaowang@redhat.com>
Subject: Re: /proc/vmcore mmap() failure issue
Message-ID: <20131126032917.GA9643@dhcp16-109.nay.redhat.com>
References: <20131113204130.GD7613@redhat.com> <5284A689.70903@jp.fujitsu.com>
 <20131114151359.GA3913@redhat.com>
 <5285EC60.1060906@jp.fujitsu.com>
 <20131115142617.GC6637@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971BF592@BPXM01GP.gisp.nec.co.jp>
 <528B3585.5080606@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971C3845@BPXM01GP.gisp.nec.co.jp>
 <20131121071441.GA2207@dhcp16-109.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971C5AAC@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971C5AAC@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 11/25/13 at 08:09am, Atsushi Kumagai wrote:
> Hello WANG,
> 
> On 2013/11/21 16:15:22, kexec <kexec-bounces@lists.infradead.org> wrote:
> > > How about this fail back structure instead of such an extra option ?
> > > 
> > > Thanks
> > > Atsushi Kumagai
> > > 
> > > From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> > > Date: Wed, 20 Nov 2013 14:10:19 +0900
> > > Subject: [PATCH] Fall back to read() when mmap() fails.
> > > 
> > > Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> > > ---
> > >  makedumpfile.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/makedumpfile.c b/makedumpfile.c
> > > index ca03440..f583602 100644
> > > --- a/makedumpfile.c
> > > +++ b/makedumpfile.c
> > > @@ -324,7 +324,15 @@ read_from_vmcore(off_t offset, void *bufptr, unsigned long size)
> > >  		if (!read_with_mmap(offset, bufptr, size)) {
> > >  			ERRMSG("Can't read the dump memory(%s) with mmap().\n",
> > >  			       info->name_memory);
> > > -			return FALSE;
> > > +
> > > +			ERRMSG("This kernel might have some problems about mmap().\n");
> > > +			ERRMSG("read() will be used instead of mmap() from now.\n");
> > > +
> > > +			/*
> > > +			 * Fall back to read().
> > > +			 */
> > > +			info->flag_usemmap = FALSE;
> > > +			read_from_vmcore(offset, bufptr, size);
> > 
> > Hi, Atsushi
> > 
> > I've got such a workstation too. And I confirm this patch works for me.
> 
> Thanks for your testing !
> 
> > However, I have a question:
> > Why not switch to mmap() back after read()?
> 
> I made this patch as a general safety net, not only for the partial page
> issue.
> When facing unknown issues related mmap(), the kernel may have some bugs
> and mmap() can fail for every pages. In the worst case, most all mmap()
> will fail and try read() with error messages after every fail, but this
> patch will prevent the chattering of the switch and so many error messages.

Thanks for you explanation. I agree with you. Since mmap() is error
prone after first mmap failure, use read() instead as a fail safe makes
much sense to me.

WANG Chao
> 
> 
> Thanks
> Atsushi Kumagai
> 
> > Thanks
> > WANG Chao
> > 
> > >  		}
> > >  	} else {
> > >  		if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
> > > -- 
> > > 1.8.0.2
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
