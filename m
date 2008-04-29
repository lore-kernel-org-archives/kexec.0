Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from yw-out-1718.google.com ([74.125.46.155])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jqgsz-0003LQ-D3
	for kexec@lists.infradead.org; Tue, 29 Apr 2008 03:52:09 +0000
Received: by yw-out-1718.google.com with SMTP id 9so3411700ywk.72
	for <kexec@lists.infradead.org>; Mon, 28 Apr 2008 20:52:00 -0700 (PDT)
Message-ID: <c62583fb0804282045w757bba55v5515bdbb37d5f18c@mail.gmail.com>
Date: Mon, 28 Apr 2008 20:45:49 -0700
From: "Mrunal Gawade" <mrunal.gawade@gmail.com>
Subject: kexec/ kdump setup problem
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0601751202=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============0601751202==
Content-Type: multipart/alternative; 
	boundary="----=_Part_14268_22589900.1209440749623"

------=_Part_14268_22589900.1209440749623
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have setup the system with two kernels (2.6.25) for kexec/kdump utility. I
am using this command to load kernel. Please comment if its correct. vmlinux
is the dump kernel.

kexec -p /boot/vmlinux --initrd=2.6.25-default-kdump --args-linux
--append="root=/dev/sda1 init 1 irqpoll"

After I execute this command. Should I expect any prompt that kernel loaded
successfully? Because if I execute the sequence alt-SysReq-c after this to
force crash my system hangs. Nothing seems to proceed further. How do I
check if the kernel is loaded successfully? Because if I execute the "-u"
unload option I do not get any error either that kernel is not loaded or
something. Nothing seems to happen over there.

Your timely help would be much appreciated as I need to get this fixed as
soon as possible as my project progress is stopped as I am not able to
analyse the reason for crash.


Thank you,
Mrunal

------=_Part_14268_22589900.1209440749623
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I have setup the system with two kernels (2.6.25) for kexec/kdump utility. I am using this command to load kernel. Please comment if its correct. vmlinux is the dump kernel. <br><br>kexec -p /boot/vmlinux --initrd=2.6.25-default-kdump --args-linux --append=&quot;root=/dev/sda1 init 1 irqpoll&quot;<br>
<br>After I execute this command. Should I expect any prompt that kernel loaded successfully? Because if I execute the sequence alt-SysReq-c after this to force crash my system hangs. Nothing seems to proceed further. How do I check if the kernel is loaded successfully? Because if I execute the &quot;-u&quot; unload option I do not get any error either that kernel is not loaded or something. Nothing seems to happen over there. <br>
<br>Your timely help would be much appreciated as I need to get this fixed as soon as possible as my project progress is stopped as I am not able to analyse the reason for crash.<br><br><br>Thank you,<br>Mrunal<br>

------=_Part_14268_22589900.1209440749623--


--===============0601751202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0601751202==--

