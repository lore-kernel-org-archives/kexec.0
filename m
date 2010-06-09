Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iw0-f177.google.com ([209.85.214.177])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OMEqj-00042C-Pi
	for kexec@lists.infradead.org; Wed, 09 Jun 2010 06:33:18 +0000
Received: by iwn34 with SMTP id 34so6269014iwn.36
	for <kexec@lists.infradead.org>; Tue, 08 Jun 2010 23:33:14 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 9 Jun 2010 14:33:14 +0800
Message-ID: <AANLkTilNsIvlsoALcESOoA0q2K8Ao5dMW3GjkHvKpSCX@mail.gmail.com>
Subject: kexec fail on ia64 platform
From: =?GB2312?B?1tzQ2w==?= <jencce2002@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0148917436=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============0148917436==
Content-Type: multipart/alternative; boundary=0016e68dd2649ea59f04889314d5

--0016e68dd2649ea59f04889314d5
Content-Type: text/plain; charset=ISO-8859-1

hello everyone,
           sorry to bother you. I have a problem with kexec tools. when i
use it on a ia64 machine, it does't work.
           situation 1 : after executing "kexec -l ***" and "kexec -e" ,
many "cpu # is now offline" printed out, then the system lose response.
           situation 2 (mostly): after many "cpu # is now offline" printed
out, some warn info printed out , and then a call trace..  system lose
response...    warn info is : Unexpected irq vector 0x44 on cpu 11! .. ..
call trace has info like : fixup_irqs , take_cpu_down, etc..
           Is there something wrong with my current kernel ? but it is an
usual 2.6.28.10. Does kexec support IA64 fully?
           Thanks alot. bow. :)


jencce chou.

--0016e68dd2649ea59f04889314d5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hello everyone, <br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sorry to bother you. I h=
ave a problem with kexec tools. when i use it on a ia64 machine, it does&#3=
9;t work. <br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 situation 1 : after executing =
&quot;kexec -l ***&quot; and &quot;kexec -e&quot; , many &quot;cpu # is now=
 offline&quot; printed out, then the system lose response.<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 situation 2 (mostly): after many &quot;cpu #=
 is now offline&quot; printed out, some warn info printed out , and then a =
call trace..=A0 system lose response...=A0=A0=A0 warn info is : Unexpected =
irq vector 0x44 on cpu 11! .. ..=A0 call trace has info like : fixup_irqs ,=
 take_cpu_down, etc..<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Is there something wrong with my current ker=
nel ? but it is an usual 2.6.28.10. Does kexec support IA64 fully?<br>=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Thanks alot. bow. :)<br><br><br>jencce chou.<br=
>

--0016e68dd2649ea59f04889314d5--


--===============0148917436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0148917436==--

