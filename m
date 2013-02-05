Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U2XY8-0005JG-J7
 for kexec@lists.infradead.org; Tue, 05 Feb 2013 01:42:18 +0000
Date: Tue, 5 Feb 2013 10:24:23 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] --dump-dmesg fix for post 3.5 kernels
Message-Id: <20130205102423.11b32c83823f8b02fead026d@mxc.nes.nec.co.jp>
In-Reply-To: <510F756F.9050604@canonical.com>
References: <1359632888-11345-1-git-send-email-louis.bouchard@canonical.com>
 <1359632888-11345-2-git-send-email-louis.bouchard@canonical.com>
 <20130204172705.85ee974cbefdad1b2b4a7aaa@mxc.nes.nec.co.jp>
 <510F756F.9050604@canonical.com>
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
To: louis.bouchard@canonical.com
Cc: kexec@lists.infradead.org

Hello Louis,

On Mon, 04 Feb 2013 09:46:39 +0100
Bouchard Louis <louis.bouchard@canonical.com> wrote:

[...]
> >>  
> >> +	SIZE_INIT(log, "log");
> >> +	OFFSET_INIT(log.ts_nsec, "log", "ts_nsec");
> >> +	OFFSET_INIT(log.len, "log", "len");
> >> +	OFFSET_INIT(log.text_len, "log", "text_len");
> >> +	OFFSET_INIT(log.dict_len, "log", "dict_len");
> >> +	OFFSET_INIT(log.dict_len, "log", "level");
> >> +
> > 
> > Why you overwrite log.dict_len with log.level ?
> > And is log.dict_len necessary for this feature ?
> > 
> 
> Sorry, this is a leftover from my log-level hack. The rest of the code
> has been removed, so this should be removed as well.

OK, I removed them.

> 
> >>  	return TRUE;
> >>  }
> >>  
> >> @@ -1354,6 +1364,8 @@ write_vmcoreinfo_data(void)
> >>  	WRITE_SYMBOL("log_buf", log_buf);
> >>  	WRITE_SYMBOL("log_buf_len", log_buf_len);
> >>  	WRITE_SYMBOL("log_end", log_end);
> >> +	WRITE_SYMBOL("log_first_idx", log_first_idx);
> >> +	WRITE_SYMBOL("log_next_idx", log_next_idx);
> >>  	WRITE_SYMBOL("max_pfn", max_pfn);
> >>  	WRITE_SYMBOL("high_memory", high_memory);
> >>  	WRITE_SYMBOL("node_remap_start_vaddr", node_remap_start_vaddr);
> >> @@ -1404,6 +1416,10 @@ write_vmcoreinfo_data(void)
> >>  	WRITE_MEMBER_OFFSET("node_memblk_s.size", node_memblk_s.size);
> >>  	WRITE_MEMBER_OFFSET("node_memblk_s.nid", node_memblk_s.nid);
> >>  	WRITE_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
> >> +	WRITE_MEMBER_OFFSET("log.ts_nsec",log.ts_nsec);
> >> +	WRITE_MEMBER_OFFSET("log.len",log.len);
> >> +	WRITE_MEMBER_OFFSET("log.text_len",log.text_len);
> >> +	WRITE_MEMBER_OFFSET("log.dict_len",log.dict_len);
> >>  
> >>  	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
> >>  		WRITE_ARRAY_LENGTH("node_data", node_data);
> >> @@ -1664,6 +1680,8 @@ read_vmcoreinfo(void)
> >>  	READ_SYMBOL("log_buf", log_buf);
> >>  	READ_SYMBOL("log_buf_len", log_buf_len);
> >>  	READ_SYMBOL("log_end", log_end);
> >> +	READ_SYMBOL("log_first_idx",log_first_idx);
> >> +	READ_SYMBOL("log_next_idx",log_next_idx);
> >>  	READ_SYMBOL("max_pfn", max_pfn);
> >>  	READ_SYMBOL("high_memory", high_memory);
> >>  	READ_SYMBOL("node_remap_start_vaddr", node_remap_start_vaddr);
> >> @@ -1679,6 +1697,7 @@ read_vmcoreinfo(void)
> >>  	READ_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
> >>  	READ_STRUCTURE_SIZE("nodemask_t", nodemask_t);
> >>  	READ_STRUCTURE_SIZE("pageflags", pageflags);
> >> +	READ_STRUCTURE_SIZE("log", log);
> > 
> > You forgot to add "WRITE_STRUCTURE_SIZE("log", log)", I'll add it.
> > 
> > Lastly, your patch causes the following warning:
> > 
> >   makedumpfile.c: In function 'dump_dmesg':
> >   makedumpfile.c:3562: warning: 'log_end' may be used uninitialized in this function
> > 
> > So, I'll fix this patch with the change below:
> > 
> > 
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index 2a2fcbd..ebedd07 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -1384,6 +1384,7 @@ write_vmcoreinfo_data(void)
> > 	WRITE_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
> > 	WRITE_STRUCTURE_SIZE("nodemask_t", nodemask_t);
> > 	WRITE_STRUCTURE_SIZE("pageflags", pageflags);
> > +	WRITE_STRUCTURE_SIZE("log", log);
> > 
> > 	/*
> > 	 * write the member offset of 1st kernel
> > @@ -3626,7 +3627,9 @@ dump_dmesg()
> > 			}
> > 			log_end = log_end_2_6_24;
> > 		}
> > -	}
> > +	} else
> > +		log_end = 0;
> > +
> 
> Oups, I missed this one, sorry.
> 
> > 	if (!readmem(VADDR, SYMBOL(log_buf_len), &log_buf_len,
> > 	    sizeof(log_buf_len))) {
> > 		ERRMSG("Can't get log_buf_len.\n");
> > 
> > 
> > Thanks
> > Atsushi Kumagai
> > 
> 
> This all looks fine. I am planning to add this patch over your 1.5.1
> version for Debian/Sid so we get this working (I need it myself for the
> upcoming Ubuntu/Raring) if you don't see any problem. The debian patch
> will be removed in the next version when it makes it into your upstream
> release.
> 
> I'll go pick up your patch in your repo as soon as it makes it in. Just
> let me know when you commit if you have a chance.

I fixed the patch, please pick up it from the devel branch:

http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=shortlog;h=refs/heads/devel

I haven't introduced it until now, this is a branch for development:

 - There are the patches reviewed by me, so I hope that this branch
   hasn't many bugs. 

 - This branch will be released as a next official version if
   there is no problem.

 - But, this branch could be broken without a announcement,
   don't trust too much.

At least, the dmesg patch will be merged into the next version without
more changes, I'm sure that this branch meet your purpose.


Thanks
Atsushi Kumagai

> Kind regards,
> 
> ...Louis
> -- 
> Louis Bouchard
> Backline Support Analyst
> Canonical Ltd
> Ubuntu support: http://landscape.canonical.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
