Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KkvTz-0004yX-9S
	for kexec@lists.infradead.org; Wed, 01 Oct 2008 06:46:48 +0000
Message-ID: <48E30585.2090107@mxs.nes.nec.co.jp>
Date: Wed, 01 Oct 2008 14:07:17 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: Problems writing ELF dumps with makedumpfile 1.2.9
References: <28113A0489833849A1CF9EC16F42154340494D5BA0@GVW1097EXB.americas.hpqcorp.net>	<48D72B2B.3000406@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049544C88@GVW1097EXB.americas.hpqcorp.net>	<48D9EDDC.1070600@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F421543404958892C@GVW1097EXB.americas.hpqcorp.net>	<48DB29A6.3070608@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049588E80@GVW1097EXB.americas.hpqcorp.net>,
	<48DC6C23.1040704@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049EAF1D2@GVW1097EXB.americas.hpqcorp.net>	<28113A0489833849A1CF9EC16F4215434049D3EDB5@GVW1097EXB.americas.hpqcorp.net>	<48E05748.6020706@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049D3F31F@GVW1097EXB.americas.hpqcorp.net>	<48E191B1.7090809@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049FC6BD3@GVW1097EXB.americas.hpqcorp.net>
	<48E2DDEE.5050603@mxs.nes.nec.co.jp>
In-Reply-To: <48E2DDEE.5050603@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0564816078=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Worth, Kevin" <kevin.worth@hp.com>
Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>

--===============0564816078==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Kevin,

Ken'ichi Ohmichi wrote:
>> I've attached the log files from running strace.
>> Hopefully they contain some clue as to where this failure is occurring.
>> I tried specifying -d30 and it still failed. Both traces attached.
> 
> Thank you for some log files.
> 
> vmcore-d30.log: 
>   open("/proc/vmcore", O_RDONLY)          = 4
>   [snip]
>   lseek(4, 2885288664, SEEK_SET)          = -1 EINVAL (Invalid argument)
> 
> Your system has 4GB memory, and /proc/vmcore size is almost 4GB, right ?
> If yes, the above lseek() should *not* fail because the offset (almost 2.7GB)
> is in /proc/vmcore. So I guess that this problem is due to a kernel.

I should see the log more carefully.

According to your log, lseek(2) is called even if makedumpfile is
compiled by -D_FILE_OFFSET_BITS=64. On my system (RHEL5), _llseek()
is called instead of it. This difference is due to each environment.

To fix it, I added both -D_LARGEFILE_SOURCE and -D_LARGEFILE64_SOURCE
with -D_FILE_OFFSET_BITS=64 and I uploaded makedumpfile-1.3.0-rc02.tar.gz
to the following:

https://sourceforge.net/project/showfiles.php?group_id=178938&package_id=293160&release_id=629891

I guess/hope that this makedumpfile fixes your problem.
Please try it on your system.


Thanks
Ken'ichi Ohmichi


--===============0564816078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0564816078==--
