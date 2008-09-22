Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Khds7-000278-Fj
	for kexec@lists.infradead.org; Mon, 22 Sep 2008 05:22:08 +0000
Message-ID: <48D72B2B.3000406@mxs.nes.nec.co.jp>
Date: Mon, 22 Sep 2008 14:20:43 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: Problems writing ELF dumps with makedumpfile 1.2.9
References: <28113A0489833849A1CF9EC16F42154340494D5BA0@GVW1097EXB.americas.hpqcorp.net>
In-Reply-To: <28113A0489833849A1CF9EC16F42154340494D5BA0@GVW1097EXB.americas.hpqcorp.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2104296657=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Worth, Kevin" <kevin.worth@hp.com>
Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>

--===============2104296657==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Kevin,

Thank you for reporting.

I guess that the problem depends on kernel configuration, and I want
to reproduce it on my machine for investigating. Could you send me
your kernel .config file ? And please let me know the kernel version.


Thanks
Ken'ichi Ohmichi

Worth, Kevin wrote:
> Hello,
> 
> I have a couple errors that also happened on 1.2.6 and I wondered if anyone might have a suggestion why.
> 
> The one thing I know might be strange about my system is that my first kernel (the one that panics) is compiled with CONFIG_VMSPLIT_1G, meaning that it is set to have 3GB of kernel space and 1GB of user space. I believe this does things to CONFIG_PAGE_OFFSET, but the depth of my kernel knowledge is not so great.
> 
> 
> # makedumpfile -E -d 31 -i /boot/vmcoreinfo vmcore dumpoutput2
> check_release: /boot/vmcoreinfo and vmcore don't match.
> 
> makedumpfile Failed.
> 
> The release numbers of the vmcore and vmcoreinfo files should be identical. This happens if I specify anything greater than "-d 1".
> 
> I tried a quick addition to the printf to include the values that generate the above error. It looks like "system_utsname.release" is NULL coming into the strcmp on line 340 of makedumpfile.c . Unfortunately I don't know enough about the kernel to go further than this.
> 
> 
> Additionally (potentially a separate issue), on an identical piece of hardware, but with 4GB of memory instead of 2GB, using "-d 1", I get the following error:
> 
> Excluding zero pages               : [ 38 %] readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> create_2nd_bitmap: Can't exclude pages filled with zerocreate_2nd_bitmap: for creating an ELF dumpfile.
> 
> makedumpfile Failed.
> 
> I can cp the file just fine and it loads up in crash, but I can't seem to use makedumpfile to trim the vmcore down at all on this system with more memory.
> 
> Any suggestions? Thanks!
> 
> 
> Kevin Worth
> Network Security
> Software Engineer
> kevin.worth@hp.com<mailto:kevin.worth@hp.com>
> ph 916.785.4528
> fx 916.785.1196
> 
> [cid:image003.jpg@01C91999.C5AF4AE0]



--===============2104296657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2104296657==--
