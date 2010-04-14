Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qy0-f191.google.com ([209.85.221.191])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O254g-0007Oi-5F
	for kexec@lists.infradead.org; Wed, 14 Apr 2010 16:04:22 +0000
Received: by qyk29 with SMTP id 29so353983qyk.2
	for <kexec@lists.infradead.org>; Wed, 14 Apr 2010 09:04:19 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Apr 2010 12:04:18 -0400
Message-ID: <i2u64cd42531004140904ve9859bc0l54fd768420810dc@mail.gmail.com>
Subject: kexec hang : x86 loading 2.6.16.60-0.21-smp from a bootcd that is 
	running 2.6.27.29-0.1-default
From: Sumedh Degaonkar <dsumedh@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0974490207=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============0974490207==
Content-Type: multipart/alternative; boundary=0016364edb1cd6cc65048434870e

--0016364edb1cd6cc65048434870e
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I have a bootcd that loads '2.6.27.29-0.1-default' and drops to a shell.
From here I do an nfs mount and pick up a kernel and initrd that I know are
good.

I then try :
kexec -l <new_kernel> --append=console=tty0 console==ttyS0,9600n8
--initrd=<initrd_location>
kexec -e

All I get is : 'Starting new kernel' and machine hangs. No output on serial
minicom from another linux machine where the serial cable is connected.

I read that there is a way to test kexec by doing :
"kexec -l kexec_test" ---> but this does not work for me?

Any tips/ideas on how to debug?

Thanks,
sumedh

--0016364edb1cd6cc65048434870e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>I have a bootcd that loads &#39;2.6.27.29-0.1-default&#39; a=
nd drops to a shell. From here I do an nfs mount and pick up a kernel and i=
nitrd that I know are good.<br><br>I then try :<br>kexec -l &lt;new_kernel&=
gt; --append=3Dconsole=3Dtty0 console=3D=3DttyS0,9600n8 --initrd=3D&lt;init=
rd_location&gt;<br>
kexec -e<br><br>All I get is : &#39;Starting new kernel&#39; and machine ha=
ngs. No output on serial minicom from another linux machine where the seria=
l cable is connected.<br><br>I read that there is a way to test kexec by do=
ing : <br>
&quot;kexec -l kexec_test&quot; ---&gt; but this does not work for me?<br><=
br>Any tips/ideas on how to debug?<br><br>Thanks,<br>sumedh<br><br><br>

--0016364edb1cd6cc65048434870e--


--===============0974490207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0974490207==--

