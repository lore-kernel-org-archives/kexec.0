Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailwasher.lanl.gov ([204.121.3.2])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JD1ot-00008r-Mn
	for kexec@lists.infradead.org; Thu, 10 Jan 2008 18:08:07 +0000
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <26DE1597-CE35-45A9-A765-BC0D2B6ED77D@lanl.gov>
Subject: minor patch to kexec-elf-rel-x86_64.c
From: kevint <kevint@lanl.gov>
Date: Thu, 10 Jan 2008 11:07:53 -0700
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1718703514=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au


--===============1718703514==
Content-Type: multipart/alternative; boundary=Apple-Mail-18-490457413


--Apple-Mail-18-490457413
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

I included a one-line patch to kexec-tools-testing, at Bernhard  
Walle's request.  This prints the relocation type as a string.  I  
noticed that other architectures do not use reloc_name, but instead  
just print the r_type.  I find the reloc_name useful.

--- kexec-tools-testing-20071030/kexec/arch/x86_64/kexec-elf-rel- 
x86_64.c       2007-10-16 21:16:16.000000000 -0600
+++ kexec-tools-testing-20071030-modified/kexec/arch/x86_64/kexec-elf- 
rel-x86_64.c      2008-01-10 10:52:22.000000000 -0700
@@ -83,7 +83,7 @@
                 *(uint32_t *)location = value - address;
                 break;
         default:
-               die("Unhandled rela relocation: %lu\n", reloc_name 
(r_type));
+               die("Unhandled rela relocation: %s\n", reloc_name 
(r_type));
                 break;
         }
         return;


********************************************
Kevin Tegtmeier
HPC-3 Scientific Computing Resources
Los Alamos National Laboratory
email:  kevint at lanl dot gov
********************************************




--Apple-Mail-18-490457413
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><DIV>I included a one-line patch =
to kexec-tools-testing, at Bernhard Walle's request.=A0 This prints the =
relocation type as a string.=A0 I noticed that other architectures do =
not use reloc_name, but instead just print the r_type.=A0 I find the =
reloc_name useful.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>--- =
kexec-tools-testing-20071030/kexec/arch/x86_64/kexec-elf-rel-x86_64.c=A0 =
=A0 =A0=A0 2007-10-16 21:16:16.000000000 -0600</DIV><DIV>+++ =
kexec-tools-testing-20071030-modified/kexec/arch/x86_64/kexec-elf-rel-x86_=
64.c=A0 =A0 =A0 2008-01-10 10:52:22.000000000 -0700</DIV><DIV>@@ -83,7 =
+83,7 @@</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(uint32_t *)location =
=3D value - address;</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
break;</DIV><DIV>=A0 =A0 =A0 =A0 default:</DIV><DIV>-=A0 =A0 =A0 =A0 =A0 =
=A0 =A0=A0 die("Unhandled rela relocation: %lu\n", =
reloc_name(r_type));</DIV><DIV>+=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 =
die("Unhandled rela relocation: %s\n", reloc_name(r_type));</DIV><DIV>=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 break;</DIV><DIV>=A0 =A0 =A0 =A0 =
}</DIV><DIV>=A0 =A0 =A0 =A0 return;</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><BR><DIV> <SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
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
class=3D"Apple-interchange-newline"></SPAN> </DIV><BR></BODY></HTML>=

--Apple-Mail-18-490457413--


--===============1718703514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1718703514==--

