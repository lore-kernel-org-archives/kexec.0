Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fFb7n-0004ew-IJ
 for kexec@lists.infradead.org; Mon, 07 May 2018 08:04:07 +0000
Date: Mon, 7 May 2018 16:03:43 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 3/4] Makedumpfile: Add a new function check_5level_paging()
Message-ID: <20180507080343.GI19030@localhost.localdomain>
References: <20180302054841.22195-1-bhe@redhat.com>
 <20180302054841.22195-4-bhe@redhat.com>
 <61D4E5D821F1674CB87C99F080A210BE011A75E5@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61D4E5D821F1674CB87C99F080A210BE011A75E5@BPXM01GP.gisp.nec.co.jp>
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
To: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Cc: "douly.fnst@cn.fujitsu.com" <douly.fnst@cn.fujitsu.com>, "indou.takao@jp.fujitsu.com" <indou.takao@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Keiichi Nakamura <kei-nakamura@vt.jp.nec.com>

On 05/07/18 at 07:21am, Masaki Tachibana wrote:
> Hi Baoquan,
> 
> Sorry for the late reply.
> 
> > +check_5level_paging(void)
> > +{
> > +	if (NUMBER(pgtable_l5_enabled) != 0)
> Is this if (NUMBER(pgtable_l5_enabled) != NOT_FOUND_NUMBER && NUMBER(pgtable_l5_enabled) != 0)  ?
> If so, I will correct this.

Yes, you are right. For kernel which includes 5-level code, it export
pgtable_l5_enabled as 0 or 1, however for kernel w/o 5-level code,
should be NOT_FOUND_NUMBER. Please help correct it.

Thanks
Baoquan

 
> 
> > -----Original Message-----
> > From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Baoquan He
> > Sent: Friday, March 02, 2018 2:49 PM
> > To: kexec@lists.infradead.org
> > Cc: douly.fnst@cn.fujitsu.com; indou.takao@jp.fujitsu.com; Hayashi Masahiko() <mas-hayashi@tg.jp.nec.com>;
> > Baoquan He <bhe@redhat.com>; Tachibana Masaki() <mas-tachibana@vf.jp.nec.com>
> > Subject: [PATCH 3/4] Makedumpfile: Add a new function check_5level_paging()
> > 
> > Use it to check if the corrupted kernel is in 5-level paging.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/x86_64.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/x86_64.c b/arch/x86_64.c
> > index cbe45c2..e88ee0b 100644
> > --- a/arch/x86_64.c
> > +++ b/arch/x86_64.c
> > @@ -33,6 +33,15 @@ get_xen_p2m_mfn(void)
> >  	return NOT_FOUND_LONG_VALUE;
> >  }
> > 
> > +static int
> > +check_5level_paging(void)
> > +{
> > +	if (NUMBER(pgtable_l5_enabled) != 0)
> > +		return TRUE;
> > +	else
> > +		return FALSE;
> > +}
> > +
> >  unsigned long
> >  get_kaslr_offset_x86_64(unsigned long vaddr)
> >  {
> > --
> > 2.13.6
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
