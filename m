Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KkBWn-0002o0-E5
	for kexec@lists.infradead.org; Mon, 29 Sep 2008 05:42:38 +0000
Message-ID: <48E064EE.9050105@mxs.nes.nec.co.jp>
Date: Mon, 29 Sep 2008 14:17:34 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: Problems writing ELF dumps with makedumpfile 1.2.9
References: <28113A0489833849A1CF9EC16F42154340494D5BA0@GVW1097EXB.americas.hpqcorp.net>	<48D72B2B.3000406@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049544C88@GVW1097EXB.americas.hpqcorp.net>	<48D9EDDC.1070600@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F421543404958892C@GVW1097EXB.americas.hpqcorp.net>	<48DB29A6.3070608@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049588E80@GVW1097EXB.americas.hpqcorp.net>,
	<48DC6C23.1040704@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049EAF1D2@GVW1097EXB.americas.hpqcorp.net>	<28113A0489833849A1CF9EC16F4215434049D3EDB5@GVW1097EXB.americas.hpqcorp.net>
	<48E05748.6020706@mxs.nes.nec.co.jp>
In-Reply-To: <48E05748.6020706@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1640872438=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Worth, Kevin" <kevin.worth@hp.com>
Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>

--===============1640872438==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Kevin,

I uploaded makedumpfile-1.3.0-rc01.tar.gz to the following URL for avoiding
a tab/space issue:

https://sourceforge.net/project/downloading.php?group_id=178938&use_mirror=nchc&filename=makedumpfile-1.3.0-rc01.tar.gz&75638452

Could you use this ?


Ken'ichi Ohmichi wrote:
>> worthk:~/makedumpfile-1.2.9$ patch -l -p1 --dry-run <v1.3.0-rc01.patch
>> patching file Makefile
>> Hunk #1 succeeded at 1 with fuzz 1.
>> patching file ia64.c
>> patching file makedumpfile-R.pl
>> patching file makedumpfile.c
>> patching file makedumpfile.h
>> patching file x86.c
>> patching file x86_64.c
>>
>> The fuzz messages is because I'm patching against a makefile that was
>> modified by Ubuntu to use "-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE"
>> rather than "-D_FILE_OFFSET_BITS=64". Perhaps the difference between
>> the Ubuntu version and this upstream setting should be resolved...
>> Ubuntu changelog at https://launchpad.net/ubuntu/+source/makedumpfile
>>  with note "Use _LARGEFILE_SOURCE and _LARGEFILE64_SOURCE instead of
>> _FILE_OFFSET_BITS=64 for correct compilation." Could this have negative
>> effects or is it just a different way to tell the compiler to support
>> large files?
>>
>> CFLAGS = -g -O2 -Wall -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE \
>>           -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'
>> CFLAGS_ARCH     = -g -O2 -Wall -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
> 
> I will consider it.

I see that the problem occurs by the above change.
On my ubuntu kernel (built by your kernel config file), makedumpfile-1.3.0-rc01
can work fine like the following:

  # makedumpfile -cd31 -x vmlinux /proc/vmcore dump
  Copying data                       : [100 %]

  The dumpfile is saved to dump.

  makedumpfile Completed.
  #

But makedumpfile-1.3.0-rc01 with the above change of Makefile cannot work
with the following message:

  # makedumpfile -cd31 -x vmlinux /proc/vmcore dump
  open_dump_memory: Can't open the dump memory(vmcore). File too large

  makedumpfile Failed.
  #

Could you test makedumpfile-1.3.0-rc01 without any change ?


Thanks
Ken'ichi Ohmichi


--===============1640872438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1640872438==--
