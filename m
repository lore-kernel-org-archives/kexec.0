Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KSW7e-0002WR-0t
	for kexec@lists.infradead.org; Mon, 11 Aug 2008 12:03:38 +0000
Message-Id: <48A02A8C.3010904@mxs.nes.nec.co.jp>
Date: Mon, 11 Aug 2008 21:03:24 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: Kdump compressed format
References: <20080804135309.4ef6f33b@halley.suse.de>	<4897F177.2060106@mxs.nes.nec.co.jp>
	<20080805144329.559f4203@halley.suse.de>
In-Reply-To: <20080805144329.559f4203@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0533474923=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

--===============0533474923==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Sorry for my late response.

Bernhard Walle wrote:
> * Ken'ichi Ohmichi [2008-08-05 15:21]:
>> Bernhard Walle wrote:
>>> is there any documentation how the kdump compressed format (or the
>>> diskdump format, from what it is derived) looks like? Beside of the
>>> source code of the tools that support it. ;-)
>> The kdump compressed format is supported by only the crash utility
>> and makedumpfile command. gdb does not support it. I think that
>> there is not any documentation about the kdump compressed format,
>> then I wrote it. Is it enough ?
> 
> Thanks a lot! Yes, that gives me the overview I needed.
> 
> I grabbed your information and generated a manual page from it where I
> also want to describe the other dump formats (when I have some time
> left):
> 
>    http://www.suse.de/~bwalle/kdump/
> 
> That's basically part of the SUSE kdump configuration, maintained in
> http://freehg.org/u/bwalle/kdump/.
> 
> I just used asciidoc because I hate nroff. I hope it's ok for you to
> distribute that manual page.

I have one question.
On the site (http://www.suse.de/~bwalle/kdump/vmcore.5.txt), the copyright
of SUSE is written. If the part of kdump-compressed format is written to
the README file of makedumpfile, is it the problem ?


Thanks
Ken'ichi Ohmichi


--===============0533474923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0533474923==--
