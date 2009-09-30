Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from n23b.bullet.mail.mud.yahoo.com ([68.142.206.142])
	by bombadil.infradead.org with smtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Mt4ZP-0006nb-BJ
	for kexec@lists.infradead.org; Wed, 30 Sep 2009 19:10:39 +0000
Message-ID: <367789.94839.qm@web65708.mail.ac4.yahoo.com>
Date: Wed, 30 Sep 2009 12:03:07 -0700 (PDT)
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
Content-Type: multipart/mixed; boundary="===============1172596881=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@lists.linux-foundation.org, Kexec Mailing List <kexec@lists.infradead.org>

--===============1172596881==
Content-Type: multipart/alternative; boundary="0-781500450-1254337387=:94839"

--0-781500450-1254337387=:94839
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

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

=0A=0A=0A      
--0-781500450-1254337387=:94839
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">I have back ported to multiple versions of di=
fferent kexec-tools. Also I disabled watchdogs so that the first kernel reb=
oot is not kicked in.<div>Now, with all those kexec-tools I see that it han=
gs after&nbsp;post_verification_setup_arch( ).</div><div>And I had to hard =
reboot the router box.</div><div><br></div><div>Is there a specific kexec t=
ools that is known to work with 2.6.14 ? Or any additional changes needed ?=
</div><div><br></div><div>Any inputs welcome , thanks in advance !!</div><d=
iv><br></div><div>Please CC me in reply.</div><div><br></div><div>Regards,<=
/div><div>Prabhakar<br><br>--- On <b>Tue, 9/29/09, Eric W. Biederman <i>&lt=
;ebiederm@xmission.com&gt;</i></b> wrote:<br><blockquote style=3D"border-le=
ft: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"><br>F=
rom: Eric W. Biederman &lt;ebiederm@xmission.com&gt;<br>Subject: Re: [Fastb=
oot]
 kexec - 2.6.14 - loads BIOS again<br>To: "Prabhakar K." &lt;krishkar99@yah=
oo.com&gt;<br>Cc: "Kexec Mailing List" &lt;kexec@lists.infradead.org&gt;, f=
astboot@lists.linux-foundation.org<br>Date: Tuesday, September 29, 2009, 6:=
11 AM<br><br><div class=3D"plainMail">"Prabhakar K." &lt;<a ymailto=3D"mail=
to:krishkar99@yahoo.com" href=3D"/mc/compose?to=3Dkrishkar99@yahoo.com">kri=
shkar99@yahoo.com</a>&gt; writes:<br><br>&gt;&gt; Hi - After my previous po=
sting I was able to make some progress.<br>&gt;&gt;<br>&gt;&gt; When I do<b=
r>&gt;&gt;<br>&gt;&gt; kexec -l vmlinux --append=3D"init 1 root=3D/dev/hda2=
" --console-serial<br>&gt;&gt;<br>&gt;&gt; and <br>&gt;&gt; kexec -e,<br>&g=
t;&gt;<br>&gt;&gt; I get message:<br>&gt;&gt;<br>&gt;&gt; Starting new kern=
el<br>&gt;&gt; I'm in purgatory<br>&gt;&gt;<br>&gt;&gt; And after that it s=
till boots from BIOS (to the same first kernel).<br>&gt;&gt;<br>&gt;&gt; Wh=
ats the problem here?<br>&gt;<br>&gt; I would recommend instrumenting up
 purgatory and then your target kernel.<br>&gt;<br>&gt; It is quite possibl=
e the problem is in your backport.<br>&gt;<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&=
nbsp; I have instrumented the purgatory code. when I run kexec -e, It hangs=
 for a<br>&gt; while at <br>&gt; sha256_starts(&amp;ctx); in the function v=
erify_sha256_digest(), and then reboots<br>&gt; to the first kernel (from B=
IOS). I have put debug prints in sha256_starts, but<br>&gt; none of those a=
re executed.<br>&gt;<br>&gt; Interestingly, the same function sha256_starts=
 is executed during kexec -l,<br>&gt; which is called as part of update_pur=
gatory( )( when my_load( ) is called from<br>&gt; kexec.c).<br>&gt; so its =
surprise why the same function is giving problems when kexec -e is run.<br>=
<br>Do you by any chance have a watchdog you are not petting?<br><br>Eric<b=
r><br></div></blockquote></div></td></tr></table><br>=0A=0A=0A=0A      
--0-781500450-1254337387=:94839--



--===============1172596881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1172596881==--


