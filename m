Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T8ji1-0004sX-FI
 for kexec@lists.infradead.org; Tue, 04 Sep 2012 03:21:51 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id B8C833EE0B5
 for <kexec@lists.infradead.org>; Tue,  4 Sep 2012 12:21:43 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id A26DC45DEB5
 for <kexec@lists.infradead.org>; Tue,  4 Sep 2012 12:21:43 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8BBDC45DEB2
 for <kexec@lists.infradead.org>; Tue,  4 Sep 2012 12:21:43 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7E91B1DB803E
 for <kexec@lists.infradead.org>; Tue,  4 Sep 2012 12:21:43 +0900 (JST)
Received: from m024.s.css.fujitsu.com (m024.s.css.fujitsu.com [10.0.81.64])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3C7D91DB8038
 for <kexec@lists.infradead.org>; Tue,  4 Sep 2012 12:21:43 +0900 (JST)
Date: Tue, 04 Sep 2012 12:21:11 +0900 (JST)
Message-Id: <20120904.122111.407226681.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 01/16] [PATCH v3 1/12] Introduce cyclic mode to keep
 memory usage constant.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120904114523.e4adee9dddf970aa9a81ac00@mxc.nes.nec.co.jp>
References: <20120903.115057.275187572.d.hatayama@jp.fujitsu.com>
 <20120903.121637.204037088.d.hatayama@jp.fujitsu.com>
 <20120904114523.e4adee9dddf970aa9a81ac00@mxc.nes.nec.co.jp>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 01/16] [PATCH v3 1/12] Introduce cyclic mode to keep memory usage constant.
Date: Tue, 4 Sep 2012 11:45:23 +0900

> Hello HATAYAMA-san,
> 
> On Mon, 03 Sep 2012 12:16:37 +0900 (JST)
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
>> From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>> Subject: Re: [PATCH 01/16] [PATCH v3 1/12] Introduce cyclic mode to keep memory usage constant.
>> Date: Mon, 3 Sep 2012 11:50:57 +0900
>> 
>> > From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>> > Subject: [PATCH 01/16] [PATCH v3 1/12] Introduce cyclic mode to keep memory usage constant.
>> > Date: Thu, 30 Aug 2012 16:45:21 +0900
>> > 
>> > <cut>
>> > 
>> >> diff --git a/makedumpfile.c b/makedumpfile.c
>> >> index d024e95..21bb55a 100644
>> >> --- a/makedumpfile.c
>> >> +++ b/makedumpfile.c
>> >> @@ -2553,6 +2553,8 @@ initial(void)
>> >>  							info->name_memory);
>> >>  			return FALSE;
>> >>  		}
>> >> +		info->flag_cyclic = FALSE;
>> >> +
>> > 
>> > Please disable cyclic mode on sadump dumpfiles, too.
> 
> I will take care of sadump (and Xen) in the same way as for refiltering.
> 

Thanks.

>> Also, there's no information to users about disabling cyclic mode.
>> Now switching from cyclic to normal mode is implicitly done. This is
>> confusing. I think some message indicating that, is necessary.
> 
> As you said, it is unkind that no message is displayed.
> I will show message as below when running mode is switched.
> 
>   MSG("Switched running mode from cyclic to non-cyclic,\n");
>   MSG("because cyclic mode doesn't support sadump format.\n");
> 

For refiltering case, too, just in case.

> 
> BTW, cyclic mode doesn't support the three below now.
> 
>  - Xen
>  - refiltering
>  - sadump
> 
> I will support Xen after Xen4 patch-set is merged.
> 
> On the other hand, I think the bottom two will be used in the 1st kernel
> and makedumpfile can allocate enough memory, so cyclic mode isn't necessary
> for them.
> Therefore, I won't support them now. What do you think ?
> 

Yes, I think so, too.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
