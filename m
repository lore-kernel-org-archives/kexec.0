Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KkWGR-0002jX-2b
	for kexec@lists.infradead.org; Tue, 30 Sep 2008 03:51:08 +0000
Message-ID: <48E191B1.7090809@mxs.nes.nec.co.jp>
Date: Tue, 30 Sep 2008 11:40:49 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: Problems writing ELF dumps with makedumpfile 1.2.9
References: <28113A0489833849A1CF9EC16F42154340494D5BA0@GVW1097EXB.americas.hpqcorp.net>	<48D72B2B.3000406@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049544C88@GVW1097EXB.americas.hpqcorp.net>	<48D9EDDC.1070600@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F421543404958892C@GVW1097EXB.americas.hpqcorp.net>	<48DB29A6.3070608@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049588E80@GVW1097EXB.americas.hpqcorp.net>,
	<48DC6C23.1040704@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049EAF1D2@GVW1097EXB.americas.hpqcorp.net>	<28113A0489833849A1CF9EC16F4215434049D3EDB5@GVW1097EXB.americas.hpqcorp.net>	<48E05748.6020706@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F4215434049D3F31F@GVW1097EXB.americas.hpqcorp.net>
In-Reply-To: <28113A0489833849A1CF9EC16F4215434049D3F31F@GVW1097EXB.americas.hpqcorp.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1249229193=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Worth, Kevin" <kevin.worth@hp.com>
Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>

--===============1249229193==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Kevin,

Thank you for the report.

Worth, Kevin wrote:
> I now get the following result (still a failure but hopefully provides
> some additional info). As I mentioned before, I have another system with
> identical hardware but only 2GB of memory instead of 4GB and I don't
> encounter this, not sure what kind of system you're testing on, but it
> may not reproduce with <4GB of memory, despite having a matching config.

My system has 5GB memory, and I'm testing on ubuntu kernel which is built
by your config file. But I haven't been able to reproduce this problem yet.


> Excluding zero pages               : [ 38 %] readmem: Can't seek the dump memory(/proc/vmcore). (offset:800002d8) Invalid argument
> readmem: addr:84060000, size:4096
> exclude_zero_pages: Can't get the page data(pfn:84060, max_mapnr:140000).
> create_2nd_bitmap: Can't exclude pages filled with zero for creating an ELF dumpfile.
>
> [snip]
>
> LOAD (3)
>   phys_start : 38000000
>   phys_end   : bf790000
>   virt_start : ffffffffffffffff
>   virt_end   : 8778ffff

When lseek() fails at readmem(), the physical address is 0x84060000 and
this address is valid because it exists in LOAD (3).

The cause of lseek() failure is due to an invalid 'offset' value or a
kernel problem related to /proc/vmcore. I'd like to know real 'offset'
value when lseek() fails, so could you run makedumpfile-1.3.0-rc01 by
strace ?

Ex) strace makedumpfile -D -E -d 31 -i $rootmnt/boot/vmcoreinfo /proc/vmcore $rootmnt/var/crash/vmcore

BTW if you specify '-d 30' as makedumpfile arguments, does it succeed ?


Thanks
Ken'ichi Ohmichi


--===============1249229193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1249229193==--
