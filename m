Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cWIqT-0006TN-I6
 for kexec@lists.infradead.org; Wed, 25 Jan 2017 08:22:25 +0000
Date: Wed, 25 Jan 2017 09:21:47 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3] kexec: implemented XEN KEXEC STATUS to determine if
 an image is loaded
Message-ID: <20170125082147.GE16671@olila.local.net-space.pl>
References: <1485284135-3058-1-git-send-email-eric.devolder@oracle.com>
 <20170124191640.GC16671@olila.local.net-space.pl>
 <e82a352d-3d26-7361-4538-33749d687b02@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e82a352d-3d26-7361-4538-33749d687b02@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com, xen-devel@lists.xenproject.org

On Tue, Jan 24, 2017 at 04:37:27PM -0600, Eric DeVolder wrote:
> On 01/24/2017 01:16 PM, Daniel Kiper wrote:
> >On Tue, Jan 24, 2017 at 12:55:35PM -0600, Eric DeVolder wrote:

[...]

> >>diff --git a/configure.ac b/configure.ac
> >>index 3044185..c6e864b 100644
> >>--- a/configure.ac
> >>+++ b/configure.ac
> >>@@ -165,8 +165,14 @@ fi
> >> dnl find Xen control stack libraries
> >> if test "$with_xen" = yes ; then
> >> 	AC_CHECK_HEADER(xenctrl.h,
> >>-		[AC_CHECK_LIB(xenctrl, xc_kexec_load, ,
> >>+		[AC_CHECK_LIB(xenctrl, xc_kexec_load, [ have_xenctrl_h=yes ],
> >> 		AC_MSG_NOTICE([Xen support disabled]))])
> >>+if test "$have_xenctrl_h" = yes ; then
> >>+	AC_CHECK_LIB(xenctrl, xc_kexec_status,
> >>+		AC_DEFINE(HAVE_KEXEC_CMD_STATUS, 1,
> >>+			[The kexec_status call is available]),
> >>+		AC_MSG_NOTICE([The kexec_status call is not available]))
> >>+fi
> >
> >I have a feeling that you have missed my comment. Please add two TABs
> >starting from "+if test "$have_xenctrl_h" = yes ; then" up to "+fi".
> >So, it should look more or less like this:
> >
> >		AC_MSG_NOTICE([Xen support disabled]))])
> >+		if test "$have_xenctrl_h" = yes ; then
> >+			AC_CHECK_LIB(xenctrl, xc_kexec_status,
> >...
> >
> >If it is not needed or something like that please drop me a line.
>
> The tabs are not needed for the configure to work properly.

Yep.

> If tabs are needed for readability/style purposes, I will
> add them in. There is not any precedent of nesting in

Please do as above.

> the configure.ac file, so I am unsure what convention is
> for this package.

OK, no problem.

> >> fi
> >>
> >> dnl ---Sanity checks
> >>diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
> >>index 24a4191..2b448d3 100644
> >>--- a/kexec/kexec-xen.c
> >>+++ b/kexec/kexec-xen.c
> >>@@ -105,6 +105,27 @@ int xen_kexec_unload(uint64_t kexec_flags)
> >> 	return ret;
> >> }
> >>
> >>+int xen_kexec_status(uint64_t kexec_flags)
> >>+{
> >>+	xc_interface *xch;
> >>+	uint8_t type;
> >>+	int ret = -1;
> >>+
> >>+#ifdef HAVE_KEXEC_CMD_STATUS
> >>+	xch = xc_interface_open(NULL, NULL, 0);
> >>+	if (!xch)
> >>+		return -1;
> >>+
> >>+	type = (kexec_flags & KEXEC_ON_CRASH) ? KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
> >>+
> >>+	ret = xc_kexec_status(xch, type);
> >>+
> >>+	xc_interface_close(xch);
> >>+#endif
> >>+
> >>+	return ret;
> >>+}
> >>+
> >> void xen_kexec_exec(void)
> >> {
> >> 	xc_interface *xch;
> >>@@ -130,6 +151,11 @@ int xen_kexec_unload(uint64_t kexec_flags)
> >> 	return -1;
> >> }
> >>
> >>+int xen_kexec_status(uint64_t kexec_flags)
> >>+{
> >>+	return -1;
> >>+}
> >>+
> >> void xen_kexec_exec(void)
> >> {
> >> }
> >>diff --git a/kexec/kexec.8 b/kexec/kexec.8
> >>index 4d0c1d1..f4b39a6 100644
> >>--- a/kexec/kexec.8
> >>+++ b/kexec/kexec.8
> >>@@ -107,6 +107,12 @@ command:
> >> .B \-d\ (\-\-debug)
> >> Enable debugging messages.
> >> .TP
> >>+.B \-S\ (\-\-status)
> >>+Return 0 if the type (by default crash) is loaded. Can be used in conjuction
> >>+with -l or -p to toggle the type. Note this option supersedes other options
> >>+and it will
> >>+.BR not\ load\ or\ unload\ the\ kernel.
> >
> >Same as above. I think that you have missed my earlier comments.
> >I suppose that you can join "+and it will" and "+.BR not\ load\ or\
> >unload\ the\ kernel." into one line.
>
> In that file, all dot directives start with the dot in the
> first column. I did the same for the .BR in this statement.

OK, let's leave it then.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
