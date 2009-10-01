Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from n9a.bullet.mail.mud.yahoo.com ([209.191.87.108])
	by bombadil.infradead.org with smtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MtT0g-0006aR-Kc
	for kexec@lists.infradead.org; Thu, 01 Oct 2009 21:16:26 +0000
Message-ID: <187068.43679.qm@web65716.mail.ac4.yahoo.com>
Date: Thu, 1 Oct 2009 14:09:33 -0700 (PDT)
From: "Prabhakar K." <krishkar99@yahoo.com>
Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again
In-Reply-To: <m1pr98ylmi.fsf@fess.ebiederm.org>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0419131994=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@lists.linux-foundation.org, Kexec Mailing List <kexec@lists.infradead.org>

--===============0419131994==
Content-Type: multipart/alternative; boundary="0-363814439-1254431373=:43679"

--0-363814439-1254431373=:43679
Content-Type: text/plain; charset=us-ascii




From: Eric W. Biederman <ebiederm@xmission.com>
Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again
To: "Prabhakar K." <krishkar99@yahoo.com>
Cc: "Kexec Mailing List" <kexec@lists.infradead.org>, fastboot@lists.linux-foundation.org
Date: Thursday, October 1, 2009, 6:29 AM

"Prabhakar K." <krishkar99@yahoo.com> writes:

> Sending again as it is not posted yet !!
>
> I have back ported to multiple versions of different kexec-tools. Also I
> disabled watchdogs so that the first kernel reboot is not kicked in.
> Now, with all those kexec-tools I see that it hangs
> after post_verification_setup_arch( ).
> And I had to hard reboot the router box.
>
> Is there a specific kexec tools that is known to work with 2.6.14 ? Or any
> additional changes needed ?

Almost certainly if you are getting as far as kexec-tools you are dying
someplace early in your target kernel.

>>> OK. What piece of code can cause in the target kernel to die ?Can I take any working bzImage or vmlinux of a linux kernel(for that matter any linux kernel) and load that as my target kernel ? or does this has any restriction ?thanks for your input !!

> Any inputs welcome , thanks in advance !!
>

Please CC me in reply.

Eric
--- On Thu, 10/1/09, Eric W. Biederman <ebiederm@xmission.com> wrote:

From: Eric W. Biederman <ebiederm@xmission.com>
Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again
To: "Prabhakar K." <krishkar99@yahoo.com>
Cc: "Kexec Mailing List" <kexec@lists.infradead.org>, fastboot@lists.linux-foundation.org
Date: Thursday, October 1, 2009, 6:29 AM

"Prabhakar K." <krishkar99@yahoo.com> writes:

> Sending again as it is not posted yet !!
>
> I have back ported to multiple versions of different kexec-tools. Also I
> disabled watchdogs so that the first kernel reboot is not kicked in.
> Now, with all those kexec-tools I see that it hangs
> after post_verification_setup_arch( ).
> And I had to hard reboot the router box.
>
> Is there a specific kexec tools that is known to work with 2.6.14 ? Or any
> additional changes needed ?

Almost certainly if you are getting as far as kexec-tools you are dying
someplace early in your target kernel.


> Any inputs welcome , thanks in advance !!
>
> Please CC me in reply.

Eric



      
--0-363814439-1254431373=:43679
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;"><br><br><div><br>From: Eric W. Biederman &lt;ebiederm@xmission.com&gt;<br>Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again<br>To: "Prabhakar K." &lt;krishkar99@yahoo.com&gt;<br>Cc: "Kexec Mailing List" &lt;kexec@lists.infradead.org&gt;, fastboot@lists.linux-foundation.org<br>Date: Thursday, October 1, 2009, 6:29 AM<br><br><div class="plainMail">"Prabhakar K." &lt;<a ymailto="mailto:krishkar99@yahoo.com" href="/mc/compose?to=krishkar99@yahoo.com">krishkar99@yahoo.com</a>&gt; writes:<br><br>&gt; Sending again as it is not posted yet !!<br>&gt;<br>&gt; I have back ported to multiple versions of different kexec-tools. Also I<br>&gt; disabled watchdogs so that the first kernel reboot is not kicked in.<br>&gt; Now, with all those kexec-tools I see that it hangs<br>&gt; after post_verification_setup_arch( ).<br>&gt; And I had to hard reboot the router
 box.<br>&gt;<br>&gt; Is there a specific kexec tools that is known to work with 2.6.14 ? Or any<br>&gt; additional changes needed ?<br><br>Almost certainly if you are getting as far as kexec-tools you are dying<br>someplace early in your target kernel.<br><br></div><div class="plainMail">&gt;&gt;&gt; OK. What piece of code can cause in the target kernel to die ?</div><div class="plainMail">Can I take any working bzImage or vmlinux of a linux kernel(for that matter any linux kernel) and load that as my target kernel ? or does this has any restriction ?</div><div class="plainMail">thanks for your input !!<br><br>&gt; Any inputs welcome , thanks in advance !!<br>&gt;<br><br></div><div class="plainMail">Please CC me in reply.<br><br>Eric</div><div class="plainMail"><br></div>--- On <b>Thu, 10/1/09, Eric W. Biederman <i>&lt;ebiederm@xmission.com&gt;</i></b> wrote:<br><blockquote style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left:
 5px;"><br>From: Eric W. Biederman &lt;ebiederm@xmission.com&gt;<br>Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again<br>To: "Prabhakar K." &lt;krishkar99@yahoo.com&gt;<br>Cc: "Kexec Mailing List" &lt;kexec@lists.infradead.org&gt;, fastboot@lists.linux-foundation.org<br>Date: Thursday, October 1, 2009, 6:29 AM<br><br><div class="plainMail">"Prabhakar K." &lt;<a ymailto="mailto:krishkar99@yahoo.com" href="/mc/compose?to=krishkar99@yahoo.com">krishkar99@yahoo.com</a>&gt; writes:<br><br>&gt; Sending again as it is not posted yet !!<br>&gt;<br>&gt; I have back ported to multiple versions of different kexec-tools. Also I<br>&gt; disabled watchdogs so that the first kernel reboot is not kicked in.<br>&gt; Now, with all those kexec-tools I see that it hangs<br>&gt; after post_verification_setup_arch( ).<br>&gt; And I had to hard reboot the router box.<br>&gt;<br>&gt; Is there a specific kexec tools that is known to work with 2.6.14 ? Or any<br>&gt;
 additional changes needed ?<br><br>Almost certainly if you are getting as far as kexec-tools you are dying<br>someplace early in your target kernel.<br><br><br>&gt; Any inputs welcome , thanks in advance !!<br>&gt;<br>&gt; Please CC me in reply.<br><br>Eric<br></div></blockquote></div></td></tr></table><br>



      
--0-363814439-1254431373=:43679--



--===============0419131994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0419131994==--


