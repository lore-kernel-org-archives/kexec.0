Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from n16a.bullet.mail.mud.yahoo.com ([68.142.207.126])
	by bombadil.infradead.org with smtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MsSlN-0004k8-JE
	for kexec@lists.infradead.org; Tue, 29 Sep 2009 02:48:29 +0000
Message-ID: <527147.77305.qm@web65705.mail.ac4.yahoo.com>
Date: Mon, 28 Sep 2009 19:48:22 -0700 (PDT)
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
Content-Type: multipart/mixed; boundary="===============1412775172=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@lists.linux-foundation.org, Kexec Mailing List <kexec@lists.infradead.org>

--===============1412775172==
Content-Type: multipart/alternative; boundary="0-564131461-1254192502=:77305"

--0-564131461-1254192502=:77305
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


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
>> and=A0
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
> while at=A0
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
>> Yes, we do have software watchdog and hardware watchdog. I disabled soft=
ware watchdog and I think the reason for resetting to the first kernel can =
be explained due to hardware watchdog kicking in.
To try out a different version of the kexec, I took kexec version 20080227 =
from=A0http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/and =
instrumented that code as well. With this, I was able to see the sha 256 ve=
rification done during kexec -e and also the post verification of purgatory=
 code. And it hangs there (does not reboot to the first kernel).
So, any conclusions based on these ? Please CC me in reply. Thanks !!

Eric=0A=0A=0A      
--0-564131461-1254192502=:77305
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><br>From: Eric W. Biederman &lt;ebiederm@xmis=
sion.com&gt;<br>Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again<b=
r>To: "Prabhakar K." &lt;krishkar99@yahoo.com&gt;<br>Cc: "Kexec Mailing Lis=
t" &lt;kexec@lists.infradead.org&gt;, fastboot@lists.linux-foundation.org<b=
r>Date: Tuesday, September 29, 2009, 6:11 AM<br><br><div class=3D"plainMail=
">"Prabhakar K." &lt;<a ymailto=3D"mailto:krishkar99@yahoo.com" href=3D"/mc=
/compose?to=3Dkrishkar99@yahoo.com">krishkar99@yahoo.com</a>&gt; writes:<br=
><br>&gt;&gt; Hi - After my previous posting I was able to make some progre=
ss.<br>&gt;&gt;<br>&gt;&gt; When I do<br>&gt;&gt;<br>&gt;&gt; kexec -l vmli=
nux --append=3D"init 1 root=3D/dev/hda2" --console-serial<br>&gt;&gt;<br>&g=
t;&gt; and&nbsp;<br>&gt;&gt; kexec -e,<br>&gt;&gt;<br>&gt;&gt; I get messag=
e:<br>&gt;&gt;<br>&gt;&gt; Starting new kernel<br>&gt;&gt; I'm in
 purgatory<br>&gt;&gt;<br>&gt;&gt; And after that it still boots from BIOS =
(to the same first kernel).<br>&gt;&gt;<br>&gt;&gt; Whats the problem here?=
<br>&gt;<br>&gt; I would recommend instrumenting up purgatory and then your=
 target kernel.<br>&gt;<br>&gt; It is quite possible the problem is in your=
 backport.<br>&gt;<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&nbsp; I have instrumente=
d the purgatory code. when I run kexec -e, It hangs for a<br>&gt; while at&=
nbsp;<br>&gt; sha256_starts(&amp;ctx); in the function verify_sha256_digest=
(), and then reboots<br>&gt; to the first kernel (from BIOS). I have put de=
bug prints in sha256_starts, but<br>&gt; none of those are executed.<br>&gt=
;<br>&gt; Interestingly, the same function sha256_starts is executed during=
 kexec -l,<br>&gt; which is called as part of update_purgatory( )( when my_=
load( ) is called from<br>&gt; kexec.c).<br>&gt; so its surprise why the sa=
me function is giving problems when kexec -e is run.<br><br>Do you
 by any chance have a watchdog you are not petting?</div><div class=3D"plai=
nMail"><br></div><div class=3D"plainMail">&gt;&gt; Yes, we do have software=
 watchdog and hardware watchdog. I disabled software watchdog and I think t=
he reason for resetting to the first kernel can be explained due to hardwar=
e watchdog kicking in.</div><div class=3D"plainMail"><br></div><div class=
=3D"plainMail">To try out a different version of the kexec, I took kexec ve=
rsion 20080227 from&nbsp;<a href=3D"http://www.kernel.org/pub/linux/kernel/=
people/horms/kexec-tools/">http://www.kernel.org/pub/linux/kernel/people/ho=
rms/kexec-tools/</a></div><div class=3D"plainMail"><a href=3D"http://www.ke=
rnel.org/pub/linux/kernel/people/horms/kexec-tools/"></a>and instrumented t=
hat code as well. With this, I was able to see the sha 256 verification don=
e during kexec -e and also the post verification of purgatory code. And it =
hangs there (does not reboot to the first kernel).</div><div
 class=3D"plainMail"><br></div><div class=3D"plainMail">So, any conclusions=
 based on these ? Please CC me in reply. Thanks !!<br><br>Eric</div></td></=
tr></table><br>=0A=0A=0A=0A      
--0-564131461-1254192502=:77305--



--===============1412775172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1412775172==--


