Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410089.outbound.protection.outlook.com
 ([40.107.141.89] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kStcv-0003fF-Q6
 for kexec@lists.infradead.org; Thu, 15 Oct 2020 03:08:27 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH 3/3] Cleanup: Remove offset_pt_load_memory
Date: Thu, 15 Oct 2020 03:07:59 +0000
Message-ID: <OSBPR01MB19917ADD8446FD2DBA92410DDD020@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20201007065652.28160-1-ptesarik@suse.com>
 <20201007065652.28160-4-ptesarik@suse.com>
 <OSBPR01MB19916814541649F049C22090DD050@OSBPR01MB1991.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB19916814541649F049C22090DD050@OSBPR01MB1991.jpnprd01.prod.outlook.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Petr Tesarik <ptesarik@suse.com>, kexec-ml <kexec@lists.infradead.org>

-----Original Message-----
> > -----Original Message-----
> > After the previous commit, this variable has become write-only, so
> > it is clearly no longer needed.
> >
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > ---
> >  elf_info.c | 17 -----------------
> >  1 file changed, 17 deletions(-)
> >
> > diff --git a/elf_info.c b/elf_info.c
> > index 5ed65fc..a6624b5 100644
> > --- a/elf_info.c
> > +++ b/elf_info.c
> > @@ -63,7 +63,6 @@ static int			flags_memory;
> >   */
> >  static unsigned int		num_pt_loads;
> >  static struct pt_load_segment	*pt_loads;
> > -static off_t			offset_pt_load_memory;
> >
> >  /*
> >   * PT_NOTE information about /proc/vmcore:
> > @@ -843,15 +842,6 @@ int get_kcore_dump_loads(void)
> >  			return FALSE;
> >  		}
> >
> > -		if (j == 0) {
> > -			offset_pt_load_memory = p->file_offset;
> > -			if (offset_pt_load_memory == 0) {
> > -				ERRMSG("Can't get the offset of page data.\n");
> > -				free(pls);
> > -				return FALSE;
> > -			}
> > -		}
> > -
> >  		pls[j] = *p;
> >  		j++;
> >  	}
> > @@ -929,13 +919,6 @@ get_elf_info(int fd, char *filename)
> >  		if (phdr.p_type != PT_LOAD)
> >  			continue;
> >
> > -		if (j == 0) {
> > -			offset_pt_load_memory = phdr.p_offset;
> > -			if (offset_pt_load_memory == 0) {
> > -				ERRMSG("Can't get the offset of page data.\n");
> > -				return FALSE;
> 
> I think this part is a kind of sanity check on ELF Phdr data, but
> checking only p_offset when j==0 doesn't make sense and there would
> be extremely rare cases where are aborted by this check, so it would
> be fine to remove completely.
> 
> So the patchset looks good to me.
> Thank you for the cleanup!

Applied.
https://github.com/makedumpfile/makedumpfile/compare/64d2aee2c4654fa422633a683c1c3f2a8d3bf3a9...master

Thanks,
Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
