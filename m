Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from n12.bullet.mail.mud.yahoo.com ([209.191.125.209])
	by bombadil.infradead.org with smtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MsLI6-0002XX-Dt
	for kexec@lists.infradead.org; Mon, 28 Sep 2009 18:49:46 +0000
Message-ID: <808738.1314.qm@web65701.mail.ac4.yahoo.com>
Date: Mon, 28 Sep 2009 11:43:27 -0700 (PDT)
From: "Prabhakar K." <krishkar99@yahoo.com>
Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again
In-Reply-To: <m1iqf6oeuy.fsf@fess.ebiederm.org>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0005022486=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>
Cc: fastboot@lists.linux-foundation.org

--===============0005022486==
Content-Type: multipart/alternative; boundary="0-993931113-1254163407=:1314"

--0-993931113-1254163407=:1314
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


> Hi - After my previous posting I was able to make some progress.
>
> When I do
>
> kexec -l vmlinux --append=3D"init 1 root=3D/dev/hda2" --console-serial
>
> and=A0
> kexec -e,
>
> I get message:
>
> Starting new kernel
> I'm in purgatory
>
> And after that it still boots from BIOS (to the same first kernel).
>
> Whats the problem here?

I would recommend instrumenting up purgatory and then your target kernel.

It is quite possible the problem is in your backport.
>>>>=A0I have instrumented the purgatory code. when I run kexec -e, It hang=
s for a while at=A0
sha256_starts(&ctx); in the function=A0verify_sha256_digest(), and then reb=
oots to the first kernel (from BIOS). I have put debug prints in sha256_sta=
rts, but none of those are executed.
Interestingly, the same function sha256_starts is executed during kexec -l,=
 which is called as part of=A0update_purgatory( )( when=A0my_load( ) is cal=
led from kexec.c).so its surprise why the same function is giving problems =
when kexec -e is run.

> What am I missing here?

The appropriate list.=A0 Discussion of all things kexec has moved to the ke=
xec
list at infradead which I have cc'd.

>>> Thanks Eric. For directing me to the right mailing list.

I am not subscribed to the list, so please CC me. Thanks !!
Regards,Prabhakar=0A=0A=0A      
--0-993931113-1254163407=:1314
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><div class=3D"plainMail"><br>&gt; Hi - After =
my previous posting I was able to make some progress.<br>&gt;<br>&gt; When =
I do<br>&gt;<br>&gt; kexec -l vmlinux --append=3D"init 1 root=3D/dev/hda2" =
--console-serial<br>&gt;<br>&gt; and&nbsp;<br>&gt; kexec -e,<br>&gt;<br>&gt=
; I get message:<br>&gt;<br>&gt; Starting new kernel<br>&gt; I'm in purgato=
ry<br>&gt;<br>&gt; And after that it still boots from BIOS (to the same fir=
st kernel).<br>&gt;<br>&gt; Whats the problem here?<br><br>I would recommen=
d instrumenting up purgatory and then your target kernel.<br><br>It is quit=
e possible the problem is in your backport.</div><div class=3D"plainMail"><=
br></div><div class=3D"plainMail">&gt;&gt;&gt;&gt;</div><div class=3D"plain=
Mail">&nbsp;I have instrumented the purgatory code. when I run kexec -e, It=
 hangs for a while at&nbsp;<br>sha256_starts(&amp;ctx); in the
 function&nbsp;verify_sha256_digest(), and then reboots to the first kernel=
 (from BIOS). I have put debug prints in sha256_starts, but none of those a=
re executed.</div><div class=3D"plainMail"><br></div><div class=3D"plainMai=
l">Interestingly, the same function sha256_starts is executed during kexec =
-l, which is called as part of&nbsp;update_purgatory( )( when&nbsp;my_load(=
 ) is called from kexec.c).</div><div class=3D"plainMail">so its surprise w=
hy the same function is giving problems when kexec -e is run.</div><div cla=
ss=3D"plainMail"><br></div><div class=3D"plainMail"><br></div><div class=3D=
"plainMail">&gt; What am I missing here?<br><br>The appropriate list.&nbsp;=
 Discussion of all things kexec has moved to the kexec<br>list at infradead=
 which I have cc'd.<br><br></div><div class=3D"plainMail">&gt;&gt;&gt; Than=
ks Eric. For directing me to the right mailing list.<br><br></div><div clas=
s=3D"plainMail">I am not subscribed to the list, so please CC me. Thanks
 !!</div><div class=3D"plainMail"><br></div><div class=3D"plainMail">Regard=
s,</div><div class=3D"plainMail">Prabhakar</div></td></tr></table><br>=0A=
=0A      
--0-993931113-1254163407=:1314--



--===============0005022486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0005022486==--


