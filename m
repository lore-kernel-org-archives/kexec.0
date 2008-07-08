Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KG2H3-0000s7-1J
	for kexec@lists.infradead.org; Tue, 08 Jul 2008 01:45:45 +0000
Message-Id: <4872C6C4.5040909@mxs.nes.nec.co.jp>
Date: Tue, 08 Jul 2008 10:45:40 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] Use progress bar also for bitmap creation
References: <20080626143721.GA12486@suse.de>	<4864B595.8040205@mxs.nes.nec.co.jp>	<48718477.3020406@mxs.nes.nec.co.jp>
	<20080707165317.7cd320aa@halley.suse.de>
In-Reply-To: <20080707165317.7cd320aa@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2056179093=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: jlan@sgi.com, kexec@lists.infradead.org

--===============2056179093==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
> * Ken'ichi Ohmichi [2008-07-07 11:50]:
>> Ken'ichi Ohmichi wrote:
>>> Hi Bernhard,
>>>
>>> Thank you for your patch.
>>> I like this idea :-)
>>>
>>> I am busy now, and I will consider the patch well the next week.
>> Thank you for the patch, and sorry for my late response.
>>
>> I added the progress bar for excluding free pages to your patch.
>> Could you please check the attached patch ?
>> If there is no problem in the attached patch, I will release the
>> next release with this patch.
> 
> That patch does not apply any more to the latest release. Maybe you can
> send me your whole tarball?

Sorry for wasting your time.
OK, I'll send you tarball later.
In the other way, you can get it by the following command:
cvs -z3 -d:pserver:anonymous@makedumpfile.cvs.sourceforge.net:/cvsroot/makedumpfile co -r DEVEL -P makedumpfile


Thanks
Ken'ichi Ohmichi


--===============2056179093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2056179093==--
