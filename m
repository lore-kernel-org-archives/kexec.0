Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kijz5-0003aa-CD
	for kexec@lists.infradead.org; Thu, 25 Sep 2008 06:05:52 +0000
Message-ID: <48DB29A6.3070608@mxs.nes.nec.co.jp>
Date: Thu, 25 Sep 2008 15:03:18 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: Problems writing ELF dumps with makedumpfile 1.2.9
References: <28113A0489833849A1CF9EC16F42154340494D5BA0@GVW1097EXB.americas.hpqcorp.net>
	<48D72B2B.3000406@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F4215434049544C88@GVW1097EXB.americas.hpqcorp.net>
	<48D9EDDC.1070600@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F421543404958892C@GVW1097EXB.americas.hpqcorp.net>
In-Reply-To: <28113A0489833849A1CF9EC16F421543404958892C@GVW1097EXB.americas.hpqcorp.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0393786142=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Worth, Kevin" <kevin.worth@hp.com>
Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>

--===============0393786142==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Kevin,

Thank you for the test and the report.

Worth, Kevin wrote:
> Wow! That was quick turn-around time- just over 12 hours!
> 
> The line breaks in the email caused problems with patching, and I'd rather not sync completely to the CVS tree,
> but I was able to just pull the patches from sourceforge using the following links
> http://makedumpfile.cvs.sourceforge.net/makedumpfile/makedumpfile/makedumpfile.c?r1=1.7.2.48&r2=1.7.2.49&view=patch
> http://makedumpfile.cvs.sourceforge.net/makedumpfile/makedumpfile/makedumpfile.h?r1=1.4.2.31&r2=1.4.2.32&view=patch
> http://makedumpfile.cvs.sourceforge.net/makedumpfile/makedumpfile/x86.c?r1=1.2.2.20&r2=1.2.2.21&view=patch
> 
> The diff looked identical to what you sent, so I patched the source and built.
> 
> It appears to now work fine when I specify "-d 31", and it continues to work on my system with 2GB of memory.

That is good.

> However, on my identically-configured (identical hardware too) system with 4GB of memory my log file contains.
> This was just triggered with an alt-sysrq-c.
> 
> ^MChecking for memory holes          : [  0 %] ^MChecking for memory holes
>     : [100 %] ^MExcluding unnecessary pages        : [100 %] ^MExcluding free pa
> ges               : [100 %] ^MExcluding zero pages               : [ 18 %] readm
> em: Can't seek the dump memory(/proc/vmcore). Invalid argument
> create_2nd_bitmap: Can't exclude pages filled with zerocreate_2nd_bitmap: for cr
> eating an ELF dumpfile.
> 
> makedumpfile Failed.

According to your test, lseek(2) failed by EINVAL in readmem().
I want to know the 'offset' value and the 'addr' value to solve it.
Could you test again with both the attached patch and yesterday patch ?

One more, please run makedumpfile with '-D' option for debugging,
and send me both the result and `readelf -a /proc/vmcore` output.
`readelf -a /proc/vmcore` output is useful, because the 'offset'
is taken by referring PT_LOAD header of ELF header,


Thanks
Ken'ichi Ohmichi


diff -puN makedumpfile.org/makedumpfile.c makedumpfile/makedumpfile.c
--- makedumpfile.org/makedumpfile.c	2008-09-25 14:59:52.000000000 +0900
+++ makedumpfile/makedumpfile.c	2008-09-25 14:59:00.000000000 +0900
@@ -257,8 +257,8 @@ readmem(int type_addr, unsigned long lon
 	}
 
 	if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
-		ERRMSG("Can't seek the dump memory(%s). %s\n",
-		    info->name_memory, strerror(errno));
+		ERRMSG("Can't seek the dump memory(%s). (%s) offset:%llx, addr:%llx\n",
+		    info->name_memory, strerror(errno), offset, addr);
 		return FALSE;
 	}
 


--===============0393786142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0393786142==--
