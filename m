Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailwasher.lanl.gov ([204.121.3.2])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JEwaJ-0003gN-AT
	for kexec@lists.infradead.org; Wed, 16 Jan 2008 00:56:51 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailwasher.lanl.gov (Postfix) with ESMTP id 3AC4BEC8519
	for <kexec@lists.infradead.org>; Tue, 15 Jan 2008 17:53:26 -0700 (MST)
Received: from mailwasher.lanl.gov (localhost.localdomain [127.0.0.1])
	by mailwasher.lanl.gov (Postfix) with ESMTP id 11EC8EC851A
	for <kexec@lists.infradead.org>; Tue, 15 Jan 2008 17:53:26 -0700 (MST)
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
	by mailwasher.lanl.gov (Postfix) with ESMTP id 05892EC8519
	for <kexec@lists.infradead.org>; Tue, 15 Jan 2008 17:53:26 -0700 (MST)
Received: from nmt-mail.lanl.gov (nmt-mail.lanl.gov [128.165.4.122])
	by mailrelay2.lanl.gov (8.13.8/8.13.8/(ccn-5)) with ESMTP id
	m0G0rPRP001820
	for <kexec@lists.infradead.org>; Tue, 15 Jan 2008 17:53:25 -0700
Received: from [128.165.248.199] (glacier.lanl.gov [128.165.248.199])
	by nmt-mail.lanl.gov (Postfix) with ESMTP id 0EC4821C002
	for <kexec@lists.infradead.org>; Tue, 15 Jan 2008 17:53:21 -0700 (MST)
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <3E21B264-7964-4A77-ADD9-64934D3D6AAF@lanl.gov>
From: kevint <kevint@lanl.gov>
Subject: reloc_name
Date: Tue, 15 Jan 2008 17:53:19 -0700
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0752038887=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


--===============0752038887==
Content-Type: multipart/alternative; boundary=Apple-Mail-23-946783892


--Apple-Mail-23-946783892
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

This isn't a high priority issue- just something I am looking at in  
my spare time.  I would appreciate any advice you can provide.

I am looking through some of the kexec elf relocation code, and  
noticed that reloc_name is only defined for x86_64.  I started  
writing this function for the other architectures, but noticed that  
some of the other architectures do not have contiguous r_type numbers  
(from include/elf.h).  In the x86_64 reloc_name code, r_name is an  
array of strings with all of the relocation names.  I can't (AFAIK)  
use a similar approach to architectures with non-contiguous r_type  
numbers.

My questions:

Is it valuable to print out the relocation type as a string?  (I  
personally find it helpful)

If so, should the reloc_name function still reside in the kexec-elf- 
rel-$ARCH.c file?  There are 81 IA64 relocations, which make the file  
considerably longer.

If not, should there be consistency between the different  
architectures with regards to these types of error messages?  Should  
the X86_64 file print out the r_type instead of the string?

Thanks,

********************************************
Kevin Tegtmeier
HPC-3 Scientific Computing Resources
Los Alamos National Laboratory
email:  kevint at lanl dot gov
********************************************




--Apple-Mail-23-946783892
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><DIV>This isn't a high priority =
issue- just something I am looking at in my spare time.=A0 I would =
appreciate any advice you can provide.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>I am looking through some =
of the kexec elf relocation code, and noticed that reloc_name is only =
defined for x86_64.=A0 I started writing this function for the other =
architectures, but noticed that some of the other architectures do not =
have contiguous r_type numbers (from include/elf.h).=A0 In the x86_64 =
reloc_name code, r_name is an array of strings with all of the =
relocation names.=A0 I can't (AFAIK) use a similar approach to =
architectures with non-contiguous r_type numbers.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>My questions:</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Is it valuable to print out =
the relocation type as a string?=A0 (I personally find it =
helpful)</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV>If =
so, should the reloc_name function still reside in the =
kexec-elf-rel-$ARCH.c file?=A0 There are 81 IA64 relocations, which make =
the file considerably longer.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>If not, should there be =
consistency between the different architectures with regards to these =
types of error messages?=A0 Should the X86_64 file print out the r_type =
instead of the string?</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Thanks,</DIV><DIV><BR><DIV> =
<SPAN class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; =
"><DIV>********************************************</DIV><DIV>Kevin =
Tegtmeier</DIV><DIV>HPC-3 Scientific Computing Resources</DIV><DIV>Los =
Alamos National Laboratory</DIV><DIV>email:=A0 kevint at lanl dot =
gov</DIV><DIV>********************************************</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><BR =
class=3D"Apple-interchange-newline"></SPAN> =
</DIV><BR></DIV></BODY></HTML>=

--Apple-Mail-23-946783892--


--===============0752038887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0752038887==--

