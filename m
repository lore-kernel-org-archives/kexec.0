Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ve0-f196.google.com ([209.85.128.196])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGWVb-0001wP-1W
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 15:25:29 +0000
Received: by mail-ve0-f196.google.com with SMTP id ox1so578764veb.3
 for <kexec@lists.infradead.org>; Fri, 15 Mar 2013 08:25:24 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 15 Mar 2013 16:25:23 +0100
Message-ID: <CABZax47tS-OYB3vki13NbQo6fhpo3JZk3qtCyB0gLKwK5G4XGg@mail.gmail.com>
Subject: kexec support for uImage multi-files?
From: Mattias Wallin <mattias.ml.wallin@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6646999496726991387=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============6646999496726991387==
Content-Type: multipart/alternative; boundary=20cf30780e627ae02b04d7f83f5c

--20cf30780e627ae02b04d7f83f5c
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I would like to reboot my embedded arm system using kexec.
The uImage I want to load is a multi-file of type IH_TYPE_MULTI and
contains two images. The first image contain a zImage and the second a
rootfs.
(Added my mkimage -l output at the bottom for more details).

When looking at the code and searching the maillinglist I don't find
support for multi-file uImage of type IH_TYPE_MULTI. Is this correct?
What is the background?
No requests or is it difficult to implement generic support for it?
Is support for it something you have considered?

(To learn more I have made changes in the kexec source code and got it
working but it is a hack and hardcoded for my multi image)

---8<---
$ mkimage -l uImage-3.0-cs-armv4l-multi
Image Name:   Linux-3.0.36-cs-armv4l-local
Created:      Tue Mar 12 07:57:13 2013
Image Type:   ARM Linux Multi-File Image (uncompressed)
Data Size:    4644154 Bytes = 4535.31 kB = 4.43 MB
Load Address: 20008000
Entry Point:  20008000
Contents:
   Image 0: 2107172 Bytes = 2057.79 kB = 2.01 MB
   Image 1: 2536970 Bytes = 2477.51 kB = 2.42 MB
--------------
On target I get:
$ kexec -d --atags -l /mnt/media/1/uImage-3.0-cs-armv4l-multi
uImage type 4 unsupported
---8<---

Best Regards,
Mattias Wallin

--20cf30780e627ae02b04d7f83f5c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>I would like to reboot my embedded arm system using kexec.<br>The uI=
mage I want to load is a multi-file of type IH_TYPE_MULTI and contains two =
images. The first image contain a zImage and the second a rootfs.<br>(Added=
 my mkimage -l output at the bottom for more details).<br>


<br>When looking at the code and searching the maillinglist I don&#39;t fin=
d support for multi-file uImage of type IH_TYPE_MULTI. Is this correct?<br>=
What is the background?<br>No requests or is it difficult to implement gene=
ric support for it?<br>


Is support for it something you have considered?<br><br>(To learn more I ha=
ve made changes in the kexec source code and got it working but it is a hac=
k and hardcoded for my multi image)<br><br>---8&lt;---<br>$ mkimage -l uIma=
ge-3.0-cs-armv4l-multi<br>


Image Name:=A0=A0 Linux-3.0.36-cs-armv4l-local<br>Created:=A0=A0=A0=A0=A0 T=
ue Mar 12 07:57:13 2013<br>Image Type:=A0=A0 ARM Linux Multi-File Image (un=
compressed)<br>Data Size:=A0=A0=A0 4644154 Bytes =3D 4535.31 kB =3D 4.43 MB=
<br>Load Address: 20008000<br>


Entry Point:=A0 20008000<br>Contents:<br>=A0=A0 Image 0: 2107172 Bytes =3D =
2057.79 kB =3D 2.01 MB<br>=A0=A0 Image 1: 2536970 Bytes =3D 2477.51 kB =3D =
2.42 MB<br>--------------<br>On target I get:<br>$ kexec -d --atags -l /mnt=
/media/1/uImage-3.0-cs-armv4l-multi<br>


uImage type 4 unsupported<br>---8&lt;---<br><br>Best Regards,<br>Mattias Wa=
llin<br><br>

--20cf30780e627ae02b04d7f83f5c--


--===============6646999496726991387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============6646999496726991387==--

