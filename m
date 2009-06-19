Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wf-out-1314.google.com ([209.85.200.174])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MHXce-0008WN-E9
	for kexec@lists.infradead.org; Fri, 19 Jun 2009 06:31:08 +0000
Received: by wf-out-1314.google.com with SMTP id 23so567298wfg.24
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 23:30:44 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 19 Jun 2009 12:00:44 +0530
Message-ID: <48e37220906182330w6a6e83bctb3b3a27f7bfc6afb@mail.gmail.com>
Subject: Need for KEXEC_PRESERVE_CONTEXT flag ?
From: Indraneel Mukherjee <indro.ml@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0266693794=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============0266693794==
Content-Type: multipart/alternative; boundary=000e0cd2a0a80bfc4b046cadaab1

--000e0cd2a0a80bfc4b046cadaab1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

The file kernel/kexec.c (~ line 1001 in linux-2.6.30) has this code

------snip----

 if (flags & KEXEC_PRESERVE_CONTEXT)
            image->preserve_context = 1;

------snip----

Will this ever be true? The flag KEXEC_PRESERVE_CONTEXT is not even defined
in kexec-tools-2.0.0.

Consequently, all the code inside the condition  if(image->preserve_context)
  is also useless?

Am i missing something here?

Regards,
Indro

--000e0cd2a0a80bfc4b046cadaab1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>The file kernel/kexec.c (~ line 1001 in linux-2.6.30) has this c=
ode<br><br>------snip----<br><br>=A0if (flags &amp; KEXEC_PRESERVE_CONTEXT)=
<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 image-&gt;preserve_context =3D 1;<br>=
<br>------snip----<br><br>
Will this ever be true? The flag KEXEC_PRESERVE_CONTEXT is not even defined=
 in kexec-tools-2.0.0.<br><br>Consequently, all the code inside the conditi=
on=A0 if(image-&gt;preserve_context) =A0 is also useless?<br><br>Am i missi=
ng something here?<br>
<br>Regards,<br>Indro<br><br><br>

--000e0cd2a0a80bfc4b046cadaab1--


--===============0266693794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0266693794==--

