Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from web65704.mail.ac4.yahoo.com ([76.13.9.96])
	by bombadil.infradead.org with smtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Mt9JX-0005wW-Qo
	for kexec@lists.infradead.org; Thu, 01 Oct 2009 00:14:36 +0000
Message-ID: <564351.23709.qm@web65704.mail.ac4.yahoo.com>
Date: Wed, 30 Sep 2009 17:07:51 -0700 (PDT)
From: "Prabhakar K." <krishkar99@yahoo.com>
Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again
In-Reply-To: <m1tyympope.fsf@fess.ebiederm.org>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2085382395=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@lists.linux-foundation.org, Kexec Mailing List <kexec@lists.infradead.org>

--===============2085382395==
Content-Type: multipart/alternative; boundary="0-1169479822-1254355671=:23709"

--0-1169479822-1254355671=:23709
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Sending again as it is not posted yet !!
I have back ported to multiple versions of different kexec-tools. Also I di=
sabled watchdogs so that the first kernel reboot is not kicked in.Now, with=
 all those kexec-tools I see that it hangs after=A0post_verification_setup_=
arch( ).And I had to hard reboot the router box.
Is there a specific kexec tools that is known to work with 2.6.14 ? Or any =
additional changes needed ?
Any inputs welcome , thanks in advance !!
Please CC me in reply.
Regards,Prabhakar
--- On Tue, 9/29/09, Eric W. Biederman <ebiederm@xmission.com> wrote:

From: Eric W. Biederman <ebiederm@xmission.com>
Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again
To: "Prabhakar K." <krishkar99@yahoo.com>
Cc: "Kexec Mailing List" <kexec@lists.infradead.org>, fastboot@lists.linux-=
foundation.org
Date: Tuesday, September 29, 2009, 6:11 AM

"Prabhakar K." <krishkar99@yahoo.com> writes:

>> Hi - After my previous posting I was able to make some progress.
>>
>> When I do
>>
>> kexec -l vmlinux --append=3D"init 1 root=3D/dev/hda2" --console-serial
>>
>> and=20
>> kexec -e,
>>
>> I get message:
>>
>> Starting new kernel
>> I'm in purgatory
>>
>> And after that it still boots from BIOS (to the same first kernel).
>>
>> Whats the problem here?
>
> I would recommend instrumenting up purgatory and then your target kernel.
>
> It is quite possible the problem is in your backport.
>
>>>>>
>=A0 I have instrumented the purgatory code. when I run kexec -e, It hangs =
for a
> while at=20
> sha256_starts(&ctx); in the function verify_sha256_digest(), and then reb=
oots
> to the first kernel (from BIOS). I have put debug prints in sha256_starts=
, but
> none of those are executed.
>
> Interestingly, the same function sha256_starts is executed during kexec -=
l,
> which is called as part of update_purgatory( )( when my_load( ) is called=
 from
> kexec.c).
> so its surprise why the same function is giving problems when kexec -e is=
 run.

Do you by any chance have a watchdog you are not petting?

Eric

=0A=0A__________________________________________________=0ADo You Yahoo!?=
=0ATired of spam?  Yahoo! Mail has the best spam protection around =0Ahttp:=
//mail.yahoo.com 
--0-1169479822-1254355671=:23709
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><span class=3D"Apple-style-span" style=3D"fon=
t-family: arial, helvetica, clean, sans-serif; border-collapse: collapse; l=
ine-height: 15px; -webkit-border-horizontal-spacing: 2px; -webkit-border-ve=
rtical-spacing: 2px; "><div>Sending again as it is not posted yet !!</div><=
div><br></div>I have back ported to multiple versions of different kexec-to=
ols. Also I disabled watchdogs so that the first kernel reboot is not kicke=
d in.<div style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px=
; padding-left: 0px; line-height: 1.2em; outline-style: none; outline-width=
: initial; outline-color: initial; ">Now, with all those kexec-tools I see =
that it hangs after&nbsp;post_verification_setup_arch( ).</div><div style=
=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0p=
x;
 padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0=
px; line-height: 1.2em; outline-style: none; outline-width: initial; outlin=
e-color: initial; ">And I had to hard reboot the router box.</div><div styl=
e=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0=
px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left=
: 0px; line-height: 1.2em; outline-style: none; outline-width: initial; out=
line-color: initial; "><br style=3D"line-height: 1.2em; outline-style: none=
; outline-width: initial; outline-color: initial; "></div><div style=3D"mar=
gin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padd=
ing-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; l=
ine-height: 1.2em; outline-style: none; outline-width: initial; outline-col=
or: initial; ">Is there a specific kexec tools that is known to work with 2=
.6.14 ? Or any additional changes needed ?</div><div style=3D"margin-top:
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding-top:=
 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; line-heig=
ht: 1.2em; outline-style: none; outline-width: initial; outline-color: init=
ial; "><br style=3D"line-height: 1.2em; outline-style: none; outline-width:=
 initial; outline-color: initial; "></div><div style=3D"margin-top: 0px; ma=
rgin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding-top: 0px; pa=
dding-right: 0px; padding-bottom: 0px; padding-left: 0px; line-height: 1.2e=
m; outline-style: none; outline-width: initial; outline-color: initial; ">A=
ny inputs welcome , thanks in advance !!</div><div style=3D"margin-top: 0px=
; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding-top: 0px=
; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; line-height: =
1.2em; outline-style: none; outline-width: initial; outline-color: initial;=
 "><br style=3D"line-height: 1.2em; outline-style: none; outline-width:
 initial; outline-color: initial; "></div><div style=3D"margin-top: 0px; ma=
rgin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding-top: 0px; pa=
dding-right: 0px; padding-bottom: 0px; padding-left: 0px; line-height: 1.2e=
m; outline-style: none; outline-width: initial; outline-color: initial; ">P=
lease CC me in reply.</div><div style=3D"margin-top: 0px; margin-right: 0px=
; margin-bottom: 0px; margin-left: 0px; padding-top: 0px; padding-right: 0p=
x; padding-bottom: 0px; padding-left: 0px; line-height: 1.2em; outline-styl=
e: none; outline-width: initial; outline-color: initial; "><br style=3D"lin=
e-height: 1.2em; outline-style: none; outline-width: initial; outline-color=
: initial; "></div><div style=3D"margin-top: 0px; margin-right: 0px; margin=
-bottom: 0px; margin-left: 0px; padding-top: 0px; padding-right: 0px; paddi=
ng-bottom: 0px; padding-left: 0px; line-height: 1.2em; outline-style: none;=
 outline-width: initial; outline-color: initial; ">Regards,</div><div
 style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-le=
ft: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding=
-left: 0px; line-height: 1.2em; outline-style: none; outline-width: initial=
; outline-color: initial; ">Prabhakar</div></span><br>--- On <b>Tue, 9/29/0=
9, Eric W. Biederman <i>&lt;ebiederm@xmission.com&gt;</i></b> wrote:<br><bl=
ockquote style=3D"border-left: 2px solid rgb(16, 16, 255); margin-left: 5px=
; padding-left: 5px;"><br>From: Eric W. Biederman &lt;ebiederm@xmission.com=
&gt;<br>Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again<br>To: "P=
rabhakar K." &lt;krishkar99@yahoo.com&gt;<br>Cc: "Kexec Mailing List" &lt;k=
exec@lists.infradead.org&gt;, fastboot@lists.linux-foundation.org<br>Date: =
Tuesday, September 29, 2009, 6:11 AM<br><br><div class=3D"plainMail">"Prabh=
akar K." &lt;<a ymailto=3D"mailto:krishkar99@yahoo.com" href=3D"/mc/compose=
?to=3Dkrishkar99@yahoo.com">krishkar99@yahoo.com</a>&gt; writes:<br><br>&gt=
;&gt;
 Hi - After my previous posting I was able to make some progress.<br>&gt;&g=
t;<br>&gt;&gt; When I do<br>&gt;&gt;<br>&gt;&gt; kexec -l vmlinux --append=
=3D"init 1 root=3D/dev/hda2" --console-serial<br>&gt;&gt;<br>&gt;&gt; and <=
br>&gt;&gt; kexec -e,<br>&gt;&gt;<br>&gt;&gt; I get message:<br>&gt;&gt;<br=
>&gt;&gt; Starting new kernel<br>&gt;&gt; I'm in purgatory<br>&gt;&gt;<br>&=
gt;&gt; And after that it still boots from BIOS (to the same first kernel).=
<br>&gt;&gt;<br>&gt;&gt; Whats the problem here?<br>&gt;<br>&gt; I would re=
commend instrumenting up purgatory and then your target kernel.<br>&gt;<br>=
&gt; It is quite possible the problem is in your backport.<br>&gt;<br>&gt;&=
gt;&gt;&gt;&gt;<br>&gt;&nbsp; I have instrumented the purgatory code. when =
I run kexec -e, It hangs for a<br>&gt; while at <br>&gt; sha256_starts(&amp=
;ctx); in the function verify_sha256_digest(), and then reboots<br>&gt; to =
the first kernel (from BIOS). I have put debug prints in sha256_starts,
 but<br>&gt; none of those are executed.<br>&gt;<br>&gt; Interestingly, the=
 same function sha256_starts is executed during kexec -l,<br>&gt; which is =
called as part of update_purgatory( )( when my_load( ) is called from<br>&g=
t; kexec.c).<br>&gt; so its surprise why the same function is giving proble=
ms when kexec -e is run.<br><br>Do you by any chance have a watchdog you ar=
e not petting?<br><br>Eric<br><br></div></blockquote></td></tr></table><br>=
__________________________________________________<br>Do You Yahoo!?<br>Tir=
ed of spam?  Yahoo! Mail has the best spam protection around <br>http://mai=
l.yahoo.com 
--0-1169479822-1254355671=:23709--


--===============2085382395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2085382395==--

