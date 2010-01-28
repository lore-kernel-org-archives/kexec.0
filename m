Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yx0-f197.google.com ([209.85.210.197])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NaU4X-000381-4v
	for kexec@lists.infradead.org; Thu, 28 Jan 2010 13:06:13 +0000
Received: by yxe35 with SMTP id 35so673673yxe.2
	for <kexec@lists.infradead.org>; Thu, 28 Jan 2010 05:06:08 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 28 Jan 2010 18:36:07 +0530
Message-ID: <4d358c531001280506p2169fad8gdde3c23d989870e1@mail.gmail.com>
Subject: mip64: kexec: Probem in allocating resevr mem
From: Vishnu Yadav <vishnuyadav@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1310362226=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============1310362226==
Content-Type: multipart/alternative; boundary=001636c9270ca989a5047e392e47

--001636c9270ca989a5047e392e47
Content-Type: text/plain; charset=ISO-8859-1

Hi
I am  not able to reserve the memory in mips 64 plateform for "crash kernel"

in below function of arch/mips/kernel/setup.c file of kernel code
reserve_bootmem(start, size , flags)
if i put flags= BOOTMEM_DEFAULT then this function succeeds but doesnt
reserve  mem of crash kernel .. i verified it by seeing /proc/iomem

but if i put flags= BOOTMEM_EXCLUSIVE .. this function itself fails and
again no memry is reseved.


Pls suggest me how to resevre mem regio for "crash kernel" in mips 64. NOTE-
I have applied kernel as well as user spaces patches for running kexec on
mips64.



-- 
Best Regards,

Vishnu Yadav

--001636c9270ca989a5047e392e47
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi=A0<div>I am =A0not able to reserve the memory in mips 64 plateform for &=
quot;crash kernel&quot;</div><div><br></div><div>in below function of arch/=
mips/kernel/setup.c file of kernel code</div><div>reserve_bootmem(start, si=
ze , flags)=A0</div>
<div>if i put flags=3D BOOTMEM_DEFAULT then this function succeeds but does=
nt reserve =A0mem of crash kernel .. i verified it by seeing /proc/iomem</d=
iv><div><br clear=3D"all">but if i put flags=3D BOOTMEM_EXCLUSIVE .. this f=
unction itself fails and again no memry is reseved.</div>
<div><br></div><div><br></div><div>Pls suggest me how to resevre mem regio =
for &quot;crash kernel&quot; in mips 64. NOTE- I have applied kernel as wel=
l as user spaces patches for running kexec on mips64.<br><br></div><div>
<br></div><div><br></div><div>-- <br>Best Regards,<br><br>Vishnu Yadav<br>
</div>

--001636c9270ca989a5047e392e47--


--===============1310362226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1310362226==--

