Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailwasher.lanl.gov ([204.121.3.2])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JD39y-0005cd-IX
	for kexec@lists.infradead.org; Thu, 10 Jan 2008 19:33:58 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailwasher.lanl.gov (Postfix) with ESMTP id 5224BEC861F
	for <kexec@lists.infradead.org>; Thu, 10 Jan 2008 12:33:49 -0700 (MST)
Received: from mailwasher.lanl.gov (localhost.localdomain [127.0.0.1])
	by mailwasher.lanl.gov (Postfix) with ESMTP id 25D17EC861D
	for <kexec@lists.infradead.org>; Thu, 10 Jan 2008 12:33:49 -0700 (MST)
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
	by mailwasher.lanl.gov (Postfix) with ESMTP id 205EBEC861B
	for <kexec@lists.infradead.org>; Thu, 10 Jan 2008 12:33:49 -0700 (MST)
Received: from nmt-mail.lanl.gov (nmt-mail.lanl.gov [128.165.4.122])
	by mailrelay2.lanl.gov (8.13.8/8.13.8/(ccn-5)) with ESMTP id
	m0AJXnGO024014
	for <kexec@lists.infradead.org>; Thu, 10 Jan 2008 12:33:49 -0700
Received: from [128.165.248.199] (glacier.lanl.gov [128.165.248.199])
	by nmt-mail.lanl.gov (Postfix) with ESMTP id D8E0B21C007
	for <kexec@lists.infradead.org>; Thu, 10 Jan 2008 12:33:43 -0700 (MST)
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <mailman.1.1199984402.16403.kexec@lists.infradead.org>
References: <mailman.1.1199984402.16403.kexec@lists.infradead.org>
Message-Id: <2D2AC01D-D2BE-48CA-9333-8632AE8096C3@lanl.gov>
From: kevint <kevint@lanl.gov>
Subject: Re: Re: x86_64 kernel relocation question
Date: Thu, 10 Jan 2008 12:33:41 -0700
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0659473717=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


--===============0659473717==
Content-Type: multipart/alternative; boundary=Apple-Mail-19-495606209


--Apple-Mail-19-495606209
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

>
> * kevint <kevint@lanl.gov> [2008-01-10 01:45]:
>>
>> I am relatively new to kexec, and am running into some problems with
>> relocations when I try to use kexec to load several different X86_64
>> kernels.  I think this is the correct list to post to, but please  
>> point me
>> in the right direction if it isn't.
>>
>> Here is some of the information on my test environment:
>>
>> $ kexec --version
>> kexec-tools-testing 20071030 released 30th October 2007
>>
>> $ uname -r
>> 2.6.21.5
>
> Just to make sure, is CONFIG_RELOCATABLE set?
>

I was a bit confused about this.  I have two kernels:  the kernel I  
want to kexec from and the one I want to kexec to.  From what I've  
read, the kernel I kexec from needs to have kexec support  
(CONFIG_KEXEC=y) and the kernel I want to kexec to needs to be  
relocatable.

It appears from:

http://lists.infradead.org/pipermail/kexec/2007-April/000012.html

that this configuration option (CONFIG_RELOCATABLE) is no longer  
required.  I am going to dig around a bit more to see if I can find  
out more on how to build a relocatable x86_64 kernel.

Please correct me if I am missing something here.

>> $ kexec -l /tmp/vmlinuz
>> Unhandled rela relocation: 4258616
>>
>> I noticed this line in the source file,
>> kexec/arch/x86_64/kexec-elf-rel-x86_64.c:
>>
>> die("Unhandled rela relocation: %lu\n", reloc_name(r_type));
>>
>> I figured %lu should be %s, so I changed it, and got the following  
>> output:
>
> Can you make a patch and send it to this list so that it get fixed in
> kexec-tools-testing? Cc Simon Horman <horms@verge.net.au>, the
> maintainer.
>
>

Sent patch in previous message.

>
>         Bernhard
>
>
>
> ------------------------------

Thanks again!

********************************************
Kevin Tegtmeier
HPC-3 Scientific Computing Resources
Los Alamos National Laboratory
email:  kevint@lanl.gov
phone: 505.667.3488
********************************************




--Apple-Mail-19-495606209
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><DIV><BLOCKQUOTE =
type=3D"cite"><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">* kevint &lt;<A =
href=3D"mailto:kevint@lanl.gov">kevint@lanl.gov</A>&gt; [2008-01-10 =
01:45]:</DIV> <BLOCKQUOTE type=3D"cite"><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">I am relatively new to kexec, =
and am running into some problems with<SPAN =
class=3D"Apple-converted-space">=A0</SPAN></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">relocations when I try to use kexec to load several different =
X86_64<SPAN class=3D"Apple-converted-space">=A0</SPAN></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">kernels.<SPAN class=3D"Apple-converted-space">=A0 =
</SPAN>I think this is the correct list to post to, but please point =
me<SPAN class=3D"Apple-converted-space">=A0</SPAN></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">in the right direction if it isn't.</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Here is =
some of the information on my test environment:</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">$ kexec =
--version</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">kexec-tools-testing 20071030 =
released 30th October 2007</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">$ uname -r</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">2.6.21.5</DIV> </BLOCKQUOTE><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Just to make =
sure, is CONFIG_RELOCATABLE set?</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV></BLOCKQUOTE><DIV><BR =
class=3D"khtml-block-placeholder"></DIV>I was a bit confused about =
this.=A0 I have two kernels:=A0 the kernel I want to kexec from and the =
one I want to kexec to.=A0 =46rom what I've read, the kernel I kexec =
from needs to have kexec support (CONFIG_KEXEC=3Dy) and the kernel I =
want to kexec to needs to be relocatable.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>It appears =
from:</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV><A =
href=3D"http://lists.infradead.org/pipermail/kexec/2007-April/000012.html"=
>http://lists.infradead.org/pipermail/kexec/2007-April/000012.html</A></DI=
V><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV>that this =
configuration option (CONFIG_RELOCATABLE) is no longer required.=A0 I am =
going to dig around a bit more to see if I can find out more on how to =
build a relocatable x86_64 kernel.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Please correct me if I am =
missing something here.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV><BLOCKQUOTE =
type=3D"cite"><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "></DIV> =
<BLOCKQUOTE type=3D"cite"><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">$ kexec -l =
/tmp/vmlinuz</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Unhandled rela relocation: =
4258616</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">I noticed this line in the source file,<SPAN =
class=3D"Apple-converted-space">=A0</SPAN></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">kexec/arch/x86_64/kexec-elf-rel-x86_64.c:</DIV><DIV style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">die("Unhandled rela relocation: %lu\n", reloc_name(r_type));</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">I =
figured %lu should be %s, so I changed it, and got the following =
output:</DIV> </BLOCKQUOTE><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; min-height: 14px; =
"><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Can you make a patch and send it =
to this list so that it get fixed in</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">kexec-tools-testing? Cc Simon Horman &lt;<A =
href=3D"mailto:horms@verge.net.au">horms@verge.net.au</A>&gt;, =
the</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">maintainer.</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><BR></DIV></BLOCKQUOTE><DIV><BR =
class=3D"khtml-block-placeholder"></DIV>Sent patch in previous =
message.</DIV><DIV><BR><BLOCKQUOTE type=3D"cite"><DIV style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "></DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; min-height: 14px; =
"><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-converted-space">=A0 =A0 =A0 =A0 =
</SPAN>Bernhard</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">------------------------------</DIV></BLOCKQUOTE></DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV>Thanks again!<DIV><BR><DIV> =
<SPAN class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; =
"><DIV>********************************************</DIV><DIV>Kevin =
Tegtmeier</DIV><DIV>HPC-3 Scientific Computing Resources</DIV><DIV>Los =
Alamos National Laboratory</DIV><DIV>email:=A0 <A =
href=3D"mailto:kevint@lanl.gov">kevint@lanl.gov</A></DIV><DIV>phone: =
505.667.3488</DIV><DIV>********************************************</DIV><=
DIV><BR class=3D"khtml-block-placeholder"></DIV><BR =
class=3D"Apple-interchange-newline"></SPAN> =
</DIV><BR></DIV></BODY></HTML>=

--Apple-Mail-19-495606209--


--===============0659473717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0659473717==--

