Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailwasher.lanl.gov ([204.121.3.2])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JDOLG-0001em-27
	for kexec@lists.infradead.org; Fri, 11 Jan 2008 18:11:02 +0000
In-Reply-To: <20080111031918.GB13135@verge.net.au>
References: <26DE1597-CE35-45A9-A765-BC0D2B6ED77D@lanl.gov>
	<20080111031918.GB13135@verge.net.au>
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <669503D8-1C64-4C82-AAE1-A3FE5986B62F@lanl.gov>
From: kevint <kevint@lanl.gov>
Subject: [PATCH] x86_64: printf format change
Date: Fri, 11 Jan 2008 11:10:47 -0700
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0643289071=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org


--===============0643289071==
Content-Type: multipart/alternative; boundary=Apple-Mail-20-577031861


--Apple-Mail-20-577031861
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Minor patch to print the reloc_name as a string.

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


Developer's Certificate of Origin 1.1

         By making a contribution to this project, I certify that:

         (a) The contribution was created in whole or in part by me  
and I
             have the right to submit it under the open source license
             indicated in the file; or

         (b) The contribution is based upon previous work that, to  
the best
             of my knowledge, is covered under an appropriate open  
source
             license and I have the right under that license to  
submit that
             work with modifications, whether created in whole or in  
part
             by me, under the same open source license (unless I am
             permitted to submit under a different license), as  
indicated
             in the file; or

         (c) The contribution was provided directly to me by some other
             person who certified (a), (b) or (c) and I have not  
modified
             it.

         (d) I understand and agree that this project and the  
contribution
             are public and that a record of the contribution  
(including all
             personal information I submit with it, including my sign- 
off) is
             maintained indefinitely and may be redistributed  
consistent with
             this project or the open source license(s) involved.

         Signed-off-by: Kevin Tegtmeier <kevint@lanl.gov>

On Jan 10, 2008, at 8:19 PM, Simon Horman wrote:

> On Thu, Jan 10, 2008 at 11:07:53AM -0700, kevint wrote:
>> I included a one-line patch to kexec-tools-testing, at Bernhard  
>> Walle's
>> request.  This prints the relocation type as a string.  I noticed  
>> that
>> other architectures do not use reloc_name, but instead just print the
>> r_type.  I find the reloc_name useful.
>
> Hi Kevin,
>
> that looks fine to me. I notice that other archs don't seem to have
> reloc_name(), so unfortunately it looks like a bit of a chore to  
> switch
> them over to use it in the log message.
>
> I'm wondering if you could provide a sign-off line as per
> section 5 of http://linux.yyz.us/patch-format.html
>
> -- 
> Horms
>

********************************************
Kevin Tegtmeier
HPC-3 Scientific Computing Resources
Los Alamos National Laboratory
email:  kevint@lanl.gov
phone: 505.667.3488
********************************************




--Apple-Mail-20-577031861
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Minor patch =
to print the reloc_name as a string.</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><BR =
class=3D"khtml-block-placeholder"></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">--- =
kexec-tools-testing-20071030/kexec/arch/x86_64/kexec-elf-rel-x86_64.c=A0 =
=A0 =A0=A0 2007-10-16 21:16:16.000000000 -0600</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">+++ =
kexec-tools-testing-20071030-modified/kexec/arch/x86_64/kexec-elf-rel-x86_=
64.c=A0 =A0 =A0 2008-01-10 10:52:22.000000000 -0700</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">@@ -83,7 +83,7 @@</DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 *(uint32_t *)location =3D value - =
address;</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
break;</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">=A0 =A0 =A0 =A0 =
default:</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">-=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 =
die("Unhandled rela relocation: %lu\n", reloc_name(r_type));</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">+=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 die("Unhandled rela =
relocation: %s\n", reloc_name(r_type));</DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 break;</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">=A0 =A0 =A0 =A0=
 }</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: =
0px; margin-left: 0px; ">=A0 =A0 =A0 =A0 return;</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" color=3D"#303030" =
face=3D"Courier" size=3D"2"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 9.9px;"><BR =
class=3D"khtml-block-placeholder"></SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" color=3D"#303030" =
face=3D"Courier" size=3D"2"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 9.9px;"><BR =
class=3D"khtml-block-placeholder"></SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" color=3D"#303030" =
face=3D"Courier" size=3D"2"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 9.9px;">Developer's Certificate of Origin =
1.1</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
9.9px/normal Courier; min-height: 11px; "><FONT class=3D"Apple-style-span"=
 color=3D"#303030"><SPAN class=3D"Apple-style-span" style=3D"line-height: =
19px;"><BR></SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">By making a contribution to this project, I =
certify that:</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font: normal =
normal normal 9.9px/normal Courier; min-height: 11px; "><FONT =
class=3D"Apple-style-span" color=3D"#303030"><SPAN =
class=3D"Apple-style-span" style=3D"line-height: =
19px;"><BR></SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">(a) The contribution was created in whole or in =
part by me and I</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">have the right to submit it under the open source =
license</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">indicated in the file; =
or</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font: normal =
normal normal 9.9px/normal Courier; min-height: 11px; "><FONT =
class=3D"Apple-style-span" color=3D"#303030"><SPAN =
class=3D"Apple-style-span" style=3D"line-height: =
19px;"><BR></SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">(b) The contribution is based upon previous work =
that, to the best</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">of my knowledge, is covered under an appropriate =
open source</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">license and I have the right under that license to =
submit that</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">work with modifications, whether created in whole =
or in part</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">by me, under the same open source license (unless =
I am</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">permitted to submit under a different license), as =
indicated</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">in the file; or</SPAN></FONT></SPAN></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 9.9px/normal Courier; =
min-height: 11px; "><FONT class=3D"Apple-style-span" =
color=3D"#303030"><SPAN class=3D"Apple-style-span" style=3D"line-height: =
19px;"><BR></SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">(c) The contribution was provided directly to me =
by some other</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">person who certified (a), (b) or (c) and I have =
not modified</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">it.</SPAN></FONT></SPAN></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 9.9px/normal Courier; =
min-height: 11px; "><FONT class=3D"Apple-style-span" =
color=3D"#303030"><SPAN class=3D"Apple-style-span" style=3D"line-height: =
19px;"><BR></SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">(d) I understand and agree that this project and =
the contribution</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">are public and that a record of the contribution =
(including all</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">personal information I submit with it, including =
my sign-off) is</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">maintained indefinitely and may be redistributed =
consistent with</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"line-height: 19px;"><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">=A0 =A0 =A0 =A0 =A0 =A0 </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#303030" face=3D"Courier" =
size=3D"2"><SPAN class=3D"Apple-style-span" style=3D"font-size: 9.9px; =
line-height: normal;">this project or the open source license(s) =
involved.</SPAN></FONT></SPAN></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; line-height: =
19px; "><FONT class=3D"Apple-style-span" color=3D"#303030" =
face=3D"Courier" size=3D"2"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 9.9px;"><BR =
class=3D"khtml-block-placeholder"></SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><SPAN class=3D"Apple-style-span" style=3D"line-height:=
 19px;"><FONT class=3D"Apple-style-span" color=3D"#303030" =
face=3D"Courier" size=3D"2"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 9.9px; line-height: normal;">=A0 =A0 =A0 =A0 =
</SPAN></FONT><FONT class=3D"Apple-style-span" color=3D"#303030" =
face=3D"Courier" size=3D"2"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 9.9px; line-height: normal;">Signed-off-by: Kevin =
Tegtmeier &lt;<A =
href=3D"mailto:kevint@lanl.gov">kevint@lanl.gov</A>&gt;</SPAN></FONT></SPA=
N></DIV><SPAN class=3D"Apple-style-span" style=3D"line-height: =
19px;"><BR></SPAN><DIV><DIV>On Jan 10, 2008, at 8:19 PM, Simon Horman =
wrote:</DIV><BR class=3D"Apple-interchange-newline"><BLOCKQUOTE =
type=3D"cite"><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">On Thu, Jan 10, 2008 at =
11:07:53AM -0700, kevint wrote:</DIV> <BLOCKQUOTE type=3D"cite"><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">I included a one-line patch to kexec-tools-testing, =
at Bernhard Walle's<SPAN =
class=3D"Apple-converted-space">=A0</SPAN></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">request.<SPAN class=3D"Apple-converted-space">=A0 </SPAN>This prints =
the relocation type as a string.<SPAN class=3D"Apple-converted-space">=A0 =
</SPAN>I noticed that<SPAN =
class=3D"Apple-converted-space">=A0</SPAN></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">other =
architectures do not use reloc_name, but instead just print the<SPAN =
class=3D"Apple-converted-space">=A0</SPAN></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">r_type.<SPAN class=3D"Apple-converted-space">=A0 </SPAN>I find the =
reloc_name useful.</DIV> </BLOCKQUOTE><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Hi Kevin,</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">that =
looks fine to me. I notice that other archs don't seem to have</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">reloc_name(), so unfortunately it looks like a bit =
of a chore to switch</DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">them over to use it in the =
log message.</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">I'm wondering if you could provide a sign-off line =
as per</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">section 5 of <A =
href=3D"http://linux.yyz.us/patch-format.html">http://linux.yyz.us/patch-f=
ormat.html</A></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">--<SPAN =
class=3D"Apple-converted-space">=A0</SPAN></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">Horms</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV> =
</BLOCKQUOTE></DIV><BR><DIV> <SPAN class=3D"Apple-style-span" =
style=3D"border-collapse: separate; border-spacing: 0px 0px; color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; =
"><DIV>********************************************</DIV><DIV>Kevin =
Tegtmeier</DIV><DIV>HPC-3 Scientific Computing Resources</DIV><DIV>Los =
Alamos National Laboratory</DIV><DIV>email:=A0 <A =
href=3D"mailto:kevint@lanl.gov">kevint@lanl.gov</A></DIV><DIV>phone: =
505.667.3488</DIV><DIV>********************************************</DIV><=
DIV><BR class=3D"khtml-block-placeholder"></DIV><BR =
class=3D"Apple-interchange-newline"></SPAN> </DIV><BR></BODY></HTML>=

--Apple-Mail-20-577031861--


--===============0643289071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0643289071==--

