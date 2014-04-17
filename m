Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WaeKl-0000Tj-LY
 for kexec@lists.infradead.org; Thu, 17 Apr 2014 04:54:00 +0000
Date: Thu, 17 Apr 2014 12:52:08 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Message-ID: <20140417045208.GE8084@dhcp-16-105.nay.redhat.com>
References: <20140410214433.GF18808@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97201A0F@BPXM01GP.gisp.nec.co.jp>
 <585335973.3025244.1397211578378.JavaMail.zimbra@redhat.com>
 <20140414080239.GA8084@dhcp-16-105.nay.redhat.com>
 <20140416064445.GC8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE972048E6@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE972048E6@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "zzou@redhat.com" <zzou@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 04/17/14 at 04:01am, Atsushi Kumagai wrote:
> Hello Baoquan,
> 
> >Hi Atsushi,
> >
> >I have got the test machine where bug reported and did a test. The
> >changed code can make elf dump successful.
> 
> Great, thanks for your help!
> However, I still have questions.
> 
> First, what is the difference between yours and mine?
> 
> http://lists.infradead.org/pipermail/kexec/2014-April/011535.html

Yeah, you are right, it's the same on changing the code bug. I mush
haven't read your patch carefully.

> 
> My patch includes renaming some values, but the purpose looks
> the same as yours.
> Further, you described as below, 
> 
> >On 04/14/14 at 04:02pm, Baoquan He wrote:
> >> In case elf dump, the code to calculate the cyclic buffer size is
> >> not correct. Since elf need bitmap1/2, so the needed memory for
> >> bufsize_cyclic need be double. Hence free size should be 40% of
> >> free memory, however the needed_size which free_size is compared
> >> with should be info->max_mapnr / BITPERBYTE, but not 2 times of it.
> >>
> >> Because of this, in case of free memory in 2nd kernel is not too much,
> >> OOM will happen very often.
> 
> but I still don't think this bug causes OOM.
> Even if needed_size is calculated as so much size wrongly, bufsize_cyclic
> will not exceed 40% of free memory by the check below:
> 
>     info->bufsize_cyclic = (free_size <= needed_size) ? free_size : needed_size;
> 
> So it looks that bitmap1(40%) and bitmap2(40%) will fit in 80% of free
> memory in any case.
> 
> I may misunderstand something since your patch has an effect on this
> issue in practice, could you correct me?

It definitely will cause OOM. On my test machine, it has 100G memory. So
per old code, its needed_size is 3200K*2 == 6.4M, if currently free
memory is only 15M left, the free_size will be 15M*0.4 which is 6M. So
info->bufsize_cyclic is assigned to be 6M. and only 3M is left for other
use, e.g page cache, dynamic allocation. OOM will happen.

> 
> 
> Thanks
> Atsushi Kumagai
> 
> >> Signed-off-by: Baoquan He <bhe@redhat.com>
> >> ---
> >>  makedumpfile.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/makedumpfile.c b/makedumpfile.c
> >> index 75092a8..01ec516 100644
> >> --- a/makedumpfile.c
> >> +++ b/makedumpfile.c
> >> @@ -9010,7 +9010,7 @@ calculate_cyclic_buffer_size(void) {
> >>  	 */
> >>  	if (info->flag_elf_dumpfile) {
> >>  		free_size = get_free_memory_size() * 0.4;
> >> -		needed_size = (info->max_mapnr * 2) / BITPERBYTE;
> >> +		needed_size = info->max_mapnr / BITPERBYTE;
> >>  	} else {
> >>  		free_size = get_free_memory_size() * 0.8;
> >>  		needed_size = info->max_mapnr / BITPERBYTE;
> >> --
> >> 1.8.5.3
> >>
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
