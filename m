Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iw0-f202.google.com ([209.85.223.202])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NEuPh-0005t6-Oi
	for kexec@lists.infradead.org; Mon, 30 Nov 2009 00:46:54 +0000
Received: by iwn40 with SMTP id 40so1869904iwn.28
	for <kexec@lists.infradead.org>; Sun, 29 Nov 2009 16:46:48 -0800 (PST)
MIME-Version: 1.0
From: Mayank Kaushik <mayank.utexas@gmail.com>
Date: Sun, 29 Nov 2009 18:40:45 -0600
Message-ID: <8e626b2a0911291640u378eb19dye74bae9022ae43e0@mail.gmail.com>
Subject: Kexec not working as expected from inside X
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0830838646=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============0830838646==
Content-Type: multipart/alternative; boundary=000e0cd56c32873b7504798be5e2

--000e0cd56c32873b7504798be5e2
Content-Type: text/plain; charset=ISO-8859-1

Hi everyone,

I'm running Fedora 8, kernel 2.6.24.3-50.fc8. I was experiencing
frequent kernel hangs, so to get to the bottom of it I setup kexec/
kdump with this kernel. I did it according to the documentation in
<kernel_src>/Documentation/
kdump/kdump.txt. I'm running Xorg with the
closed-source binary nvidia driver. I did the following:

1) Ensured that my running kernel supported kexec (as given in the
documentation above), obtained the vmlinux for it from the fedora
debug yum repos.
2) Built a new crash-dump kernel (linux-2.6.23.17-kdump).
3) Appended the following lines to my /etc/rc.sysinit:

921 echo "1" > /proc/sys/kernel/sysrq
922 savetextmode
923 # Tell kexec which kernel and ramdisk to use
924 kexec -p /usr/src/kernels/linux-2.6.23.17/vmlinux --initrd=/boot/
initrd-2.6.23.17-kdump.img --args-linux --append="root=LABEL=/ 1
irqpoll maxcpus=1"
925
926 DATE=`date +%Y-%m-%d-%T`
927 NAME=`uname -r`
928 if [ "$NAME" == "2.6.23.17-kdump" ]; then
929   echo -e "Creating crash dump..\n"
930   mkdir -p /var/crash/127.0.0.1-$DATE
931   cp /proc/vmcore /var/crash/127.0.0.1-$DATE/vmcore-incomplete
932   if [ $? == 0 ]
933   then
934       mv /var/crash/127.0.0.1-$DATE/vmcore-incomplete /var/crash/
127.0.0.1-$DATE/vmcore
935       echo -e "Done, rebooting..\n"
936       reboot -f
937   fi
938 fi

The above is supposed to dump the vmcore to my /var/crash/ directory
as soon as the kdump kernel boots after a hang. The motivation for
doing this was that I get kernel hangs while running X, and pressing
<Alt>+<Sysrq> causes the screen to get garbled when the kdump kernel
boots, so I don't have a chance of doing this manually.

I've tested the above while in runlevel 3 while I'm inside a VT,
everything works as expected (I see the kdump kernel boot up and copy
the kdump), and I can see the vmcore end up inside /var/crash/. But
when I try the same while X is running, the screen gets garbled while
the kdump kernel boots, but nothing happens! The kernel does not
reboot, and neither does it copy the vmcore to /var/crash. It is
responsive though, I can toggle the CapsLock key, but the screen is
blank.

Is it something in the nvidia driver that's causing this to not work?
Any clues on what's going wrong, or how I can debug this further?

(Please CC me in the reply, I'm not on this list)

Thanks!
-Mayank

--000e0cd56c32873b7504798be5e2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi everyone,<br>
<br>
I&#39;m running Fedora 8, kernel 2.6.24.3-50.fc8. I was experiencing<br>
frequent kernel hangs, so to get to the bottom of it I setup kexec/<br>
kdump with this kernel. I did it according to the documentation in<br>
&lt;kernel_src&gt;/Documentation/<div id=3D":ai" class=3D"ii gt">kdump/kdum=
p.txt. I&#39;m running Xorg with the<br>
closed-source binary nvidia driver. I did the following:<br>
<br>
1) Ensured that my running kernel supported kexec (as given in the<br>
documentation above), obtained the vmlinux for it from the fedora<br>
debug yum repos.<br>
2) Built a new crash-dump kernel (linux-2.6.23.17-kdump).<br>
3) Appended the following lines to my /etc/rc.sysinit:<br>
<br>
921 echo &quot;1&quot; &gt; /proc/sys/kernel/sysrq<br>
922 savetextmode<br>
923 # Tell kexec which kernel and ramdisk to use<br>
924 kexec -p /usr/src/kernels/linux-2.6.23.17/vmlinux --initrd=3D/boot/<br>
initrd-2.6.23.17-kdump.img --args-linux --append=3D&quot;root=3DLABEL=3D/ 1=
<br>
irqpoll maxcpus=3D1&quot;<br>
925<br>
926 DATE=3D`date +%Y-%m-%d-%T`<br>
927 NAME=3D`uname -r`<br>
928 if [ &quot;$NAME&quot; =3D=3D &quot;2.6.23.17-kdump&quot; ]; then<br>
929 =A0 echo -e &quot;Creating crash dump..\n&quot;<br>
930 =A0 mkdir -p /var/crash/127.0.0.1-$DATE<br>
931 =A0 cp /proc/vmcore /var/crash/127.0.0.1-$DATE/vmcore-incomplete<br>
932 =A0 if [ $? =3D=3D 0 ]<br>
933 =A0 then<br>
934 =A0 =A0 =A0 mv /var/crash/127.0.0.1-$DATE/vmcore-incomplete /var/crash/=
<br>
127.0.0.1-$DATE/vmcore<br>
935 =A0 =A0 =A0 echo -e &quot;Done, rebooting..\n&quot;<br>
936 =A0 =A0 =A0 reboot -f<br>
937 =A0 fi<br>
938 fi<br>
<br>
The above is supposed to dump the vmcore to my /var/crash/ directory<br>
as soon as the kdump kernel boots after a hang. The motivation for<br>
doing this was that I get kernel hangs while running X, and pressing<br>
&lt;Alt&gt;+&lt;Sysrq&gt; causes the screen to get garbled when the kdump k=
ernel<br>
boots, so I don&#39;t have a chance of doing this manually.<br>
<br>
I&#39;ve tested the above while in runlevel 3 while I&#39;m inside a VT,<br=
>
everything works as expected (I see the kdump kernel boot up and copy<br>
the kdump), and I can see the vmcore end up inside /var/crash/. But<br>
when I try the same while X is running, the screen gets garbled while<br>
the kdump kernel boots, but nothing happens! The kernel does not<br>
reboot, and neither does it copy the vmcore to /var/crash. It is<br>
responsive though, I can toggle the CapsLock key, but the screen is<br>
blank.<br>
<br>
Is it something in the nvidia driver that&#39;s causing this to not work?<b=
r>
Any clues on what&#39;s going wrong, or how I can debug this further?<br>
<br>(Please CC me in the reply, I&#39;m not on this list)<br><br>
Thanks!<br>
-Mayank</div><br>

--000e0cd56c32873b7504798be5e2--


--===============0830838646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0830838646==--

