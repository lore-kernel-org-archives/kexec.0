Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-fx0-f49.google.com ([209.85.161.49])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QvNwH-0008Re-C6
	for kexec@lists.infradead.org; Mon, 22 Aug 2011 06:24:50 +0000
Received: by fxd20 with SMTP id 20so4044605fxd.36
	for <kexec@lists.infradead.org>; Sun, 21 Aug 2011 23:24:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110821135139.GB17323@router-fw-old.local.net-space.pl>
References: <20110821135139.GB17323@router-fw-old.local.net-space.pl>
Date: Mon, 22 Aug 2011 12:09:45 +0545
Message-ID: <CAJRmKy8=f+x6bU0XQOuqgVcX-u1oMvk-hdsWGsrgOj3H+sepxQ@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH 1/4] xen: Take into account Xen control
	interface changes since Xen Ver. 4.1
From: Rajendra Bele <belerajendra753@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1598587417=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Daniel Kiper <dkiper@net-space.pl>
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, ian.campbell@citrix.com, konrad.wilk@oracle.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, vgoyal@redhat.com

--===============1598587417==
Content-Type: multipart/alternative; boundary=0015174790baa295a804ab1222b2

--0015174790baa295a804ab1222b2
Content-Type: text/plain; charset=UTF-8

Dear Friends,
I am pursuing Ph.D. in virtualization,
I want to study detail architecture and implementation of Xen
As I wanted to start from scratch ,can you suggest some guidance or resource
for it.
Thanking you
Rajendra Bele
Pune,India

On Sun, Aug 21, 2011 at 7:36 PM, Daniel Kiper <dkiper@net-space.pl> wrote:

> xc_interface_open() receive three arguments instead of void and returns
> pointer to xc_interface type instead of int since Xen Ver. 4.1. Take into
> account that and allow kexec-tools compilation with all versions of Xen.
>
> Signed-off-by: Daniel Kiper <dkiper@net-space.pl>
> ---
>  kexec/crashdump-xen.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)
>
> diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
> index b347764..9dfabf8 100644
> --- a/kexec/crashdump-xen.c
> +++ b/kexec/crashdump-xen.c
> @@ -126,19 +126,32 @@ unsigned long xen_architecture(struct crash_elf_info
> *elf_info)
>  {
>        unsigned long machine = elf_info->machine;
>  #ifdef HAVE_LIBXENCTRL
> -       int xc, rc;
> +       int rc;
>        xen_capabilities_info_t capabilities;
> +#ifdef XENCTRL_HAS_XC_INTERFACE
> +       xc_interface *xc;
> +#else
> +       int xc;
> +#endif
>
>        if (!xen_present())
>                goto out;
>
>        memset(capabilities, '0', XEN_CAPABILITIES_INFO_LEN);
>
> +#ifdef XENCTRL_HAS_XC_INTERFACE
> +       xc = xc_interface_open(NULL, NULL, 0);
> +       if ( !xc ) {
> +               fprintf(stderr, "failed to open xen control interface.\n");
> +               goto out;
> +       }
> +#else
>        xc = xc_interface_open();
>        if ( xc == -1 ) {
>                fprintf(stderr, "failed to open xen control interface.\n");
>                goto out;
>        }
> +#endif
>
>        rc = xc_version(xc, XENVER_capabilities, &capabilities[0]);
>        if ( rc == -1 ) {
> --
> 1.5.6.5
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel
>

--0015174790baa295a804ab1222b2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>Dear Friends,<br>I am pursuing Ph.D. in virtualization,<br>I want to s=
tudy detail architecture and implementation of Xen <br>As I wanted to start=
 from scratch ,can you suggest some guidance or resource for it.<br>Thankin=
g you</div>

<div>Rajendra Bele</div>
<div>Pune,India<br><br></div>
<div class=3D"gmail_quote">On Sun, Aug 21, 2011 at 7:36 PM, Daniel Kiper <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:dkiper@net-space.pl">dkiper@net-space=
.pl</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">xc_interface_open() receive thre=
e arguments instead of void and returns<br>pointer to xc_interface type ins=
tead of int since Xen Ver. 4.1. Take into<br>
account that and allow kexec-tools compilation with all versions of Xen.<br=
><br>Signed-off-by: Daniel Kiper &lt;<a href=3D"mailto:dkiper@net-space.pl"=
>dkiper@net-space.pl</a>&gt;<br>---<br>=C2=A0kexec/crashdump-xen.c | =C2=A0=
 15 ++++++++++++++-<br>
=C2=A01 files changed, 14 insertions(+), 1 deletions(-)<br><br>diff --git a=
/kexec/crashdump-xen.c b/kexec/crashdump-xen.c<br>index b347764..9dfabf8 10=
0644<br>--- a/kexec/crashdump-xen.c<br>+++ b/kexec/crashdump-xen.c<br>@@ -1=
26,19 +126,32 @@ unsigned long xen_architecture(struct crash_elf_info *elf_=
info)<br>
=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long machine =3D elf_info-&g=
t;machine;<br>=C2=A0#ifdef HAVE_LIBXENCTRL<br>- =C2=A0 =C2=A0 =C2=A0 int xc=
, rc;<br>+ =C2=A0 =C2=A0 =C2=A0 int rc;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0xen_c=
apabilities_info_t capabilities;<br>+#ifdef XENCTRL_HAS_XC_INTERFACE<br>+ =
=C2=A0 =C2=A0 =C2=A0 xc_interface *xc;<br>
+#else<br>+ =C2=A0 =C2=A0 =C2=A0 int xc;<br>+#endif<br><br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (!xen_present())<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0goto out;<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(capabil=
ities, &#39;0&#39;, XEN_CAPABILITIES_INFO_LEN);<br><br>+#ifdef XENCTRL_HAS_=
XC_INTERFACE<br>+ =C2=A0 =C2=A0 =C2=A0 xc =3D xc_interface_open(NULL, NULL,=
 0);<br>
+ =C2=A0 =C2=A0 =C2=A0 if ( !xc ) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 fprintf(stderr, &quot;failed to open xen control interface.\=
n&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<b=
r>+ =C2=A0 =C2=A0 =C2=A0 }<br>+#else<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0xc =3D x=
c_interface_open();<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0if ( xc =3D=3D -1 ) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quo=
t;failed to open xen control interface.\n&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0}=
<br>+#endif<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D xc_version(xc, XENVER_=
capabilities, &amp;capabilities[0]);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0if ( rc =
=3D=3D -1 ) {<br>
<font color=3D"#888888">--<br>1.5.6.5<br><br>______________________________=
_________________<br>Xen-devel mailing list<br><a href=3D"mailto:Xen-devel@=
lists.xensource.com">Xen-devel@lists.xensource.com</a><br><a href=3D"http:/=
/lists.xensource.com/xen-devel" target=3D"_blank">http://lists.xensource.co=
m/xen-devel</a><br>
</font></blockquote></div><br>

--0015174790baa295a804ab1222b2--


--===============1598587417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1598587417==--

