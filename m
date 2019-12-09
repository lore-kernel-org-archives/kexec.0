Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iePNk-0000ZZ-1B
 for kexec@lists.infradead.org; Mon, 09 Dec 2019 20:11:49 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: assign bitmap2 fd for sub process during
 refiltering
Date: Mon, 9 Dec 2019 20:10:24 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03597A16@BPXM09GP.gisp.nec.co.jp>
References: <1575358627-17152-1-git-send-email-piliu@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035977E6@BPXM09GP.gisp.nec.co.jp>
 <0d793e2d-6698-6543-13de-a3de8732df75@redhat.com>
In-Reply-To: <0d793e2d-6698-6543-13de-a3de8732df75@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: piliu <piliu@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>


> -----Original Message-----
> From: piliu <piliu@redhat.com>
> Sent: Monday, December 9, 2019 1:06 AM
> To: Hagio Kazuhito(萩尾 一仁) <k-hagio@ab.jp.nec.com>; kexec@lists.infradead.org
> Subject: Re: [PATCH] makedumpfile: assign bitmap2 fd for sub process during refiltering
> 
> 
> 
> On 12/07/2019 06:11 AM, Kazuhito Hagio wrote:
> > Hi Pingfan,
> >
> >> -----Original Message-----
> >> In refiltering mode, each sub process inherits bitmap2->fd from parent.
> >> Then they lseek()/read() on the same fd, which means that they interference
> >> with each other.
> >>
> >> This breaks the purpose of SPLITTING_FD_BITMAP(i) for each sub process.
> >> Fix it by assigning a sub process dedicated fd to bitmap2->fd.
> >>
> >> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> >
> > Thanks for the patch.
> > I'm still reading the code, but it might be better to apply this to bitmap1->fd
> > as well?  see you next week..
> Yes. Although during my test, bitmap1 is not touched, but it is a
> reasonable step to against any future bug.

Reading the code, I think
- the issue might occur not only in refiltering, but also the first filtering
  with --split and --work-dir option (forced non-cyclic mode).
- pefer to gather things for --split option into writeout_multiple_dumpfiles()
  if we can, for readability.

So does the following patch work for you and your test?
I could not have reproduced the issue yet.

diff --git a/makedumpfile.c b/makedumpfile.c
index b9e9dfbd45ba..674c6a00e2dd 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -10091,6 +10091,10 @@ writeout_multiple_dumpfiles(void)
 			info->split_start_pfn = SPLITTING_START_PFN(i);
 			info->split_end_pfn   = SPLITTING_END_PFN(i);
 
+			if (!info->flag_cyclic) {
+				info->bitmap1->fd = info->fd_bitmap;
+				info->bitmap2->fd = info->fd_bitmap;
+			}
 			if (!reopen_dump_memory())
 				exit(1);
 			if ((status = writeout_dumpfile()) == FALSE)


BTW, what do you see when the issue occurs? an error or broken dump?

Thanks,
Kazu

> 
> Thanks,
> Pingfan
> >
> > Thanks,
> > Kazu
> >
> >> ---
> >>  makedumpfile.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/makedumpfile.c b/makedumpfile.c
> >> index d76a435..1dc8640 100644
> >> --- a/makedumpfile.c
> >> +++ b/makedumpfile.c
> >> @@ -8857,7 +8857,8 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
> >>  	if (info->flag_cyclic) {
> >>  		if (!prepare_bitmap2_buffer())
> >>  			return FALSE;
> >> -	}
> >> +	} else if (info->flag_refiltering)
> >> +		info->bitmap2->fd = info->fd_bitmap;
> >>
> >>  	/*
> >>  	 * Write pages and bitmap cyclically.
> >> --
> >> 2.7.5
> >>
> >
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
