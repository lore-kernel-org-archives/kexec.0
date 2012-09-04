Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T8jAR-0003Tj-5N
 for kexec@lists.infradead.org; Tue, 04 Sep 2012 02:47:09 +0000
Date: Tue, 4 Sep 2012 11:45:23 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 01/16] [PATCH v3 1/12] Introduce cyclic mode to keep
 memory usage constant.
Message-Id: <20120904114523.e4adee9dddf970aa9a81ac00@mxc.nes.nec.co.jp>
In-Reply-To: <20120903.121637.204037088.d.hatayama@jp.fujitsu.com>
References: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
 <20120830164521.0b07c16fe2993dd8afafc79b@mxc.nes.nec.co.jp>
 <20120903.115057.275187572.d.hatayama@jp.fujitsu.com>
 <20120903.121637.204037088.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hello HATAYAMA-san,

On Mon, 03 Sep 2012 12:16:37 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> Subject: Re: [PATCH 01/16] [PATCH v3 1/12] Introduce cyclic mode to keep memory usage constant.
> Date: Mon, 3 Sep 2012 11:50:57 +0900
> 
> > From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> > Subject: [PATCH 01/16] [PATCH v3 1/12] Introduce cyclic mode to keep memory usage constant.
> > Date: Thu, 30 Aug 2012 16:45:21 +0900
> > 
> > <cut>
> > 
> >> diff --git a/makedumpfile.c b/makedumpfile.c
> >> index d024e95..21bb55a 100644
> >> --- a/makedumpfile.c
> >> +++ b/makedumpfile.c
> >> @@ -2553,6 +2553,8 @@ initial(void)
> >>  							info->name_memory);
> >>  			return FALSE;
> >>  		}
> >> +		info->flag_cyclic = FALSE;
> >> +
> > 
> > Please disable cyclic mode on sadump dumpfiles, too.

I will take care of sadump (and Xen) in the same way as for refiltering.

> Also, there's no information to users about disabling cyclic mode.
> Now switching from cyclic to normal mode is implicitly done. This is
> confusing. I think some message indicating that, is necessary.

As you said, it is unkind that no message is displayed.
I will show message as below when running mode is switched.

  MSG("Switched running mode from cyclic to non-cyclic,\n");
  MSG("because cyclic mode doesn't support sadump format.\n");


BTW, cyclic mode doesn't support the three below now.

 - Xen
 - refiltering
 - sadump

I will support Xen after Xen4 patch-set is merged.

On the other hand, I think the bottom two will be used in the 1st kernel
and makedumpfile can allocate enough memory, so cyclic mode isn't necessary
for them.
Therefore, I won't support them now. What do you think ?


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
