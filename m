Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QMO7A-0001F0-FL
	for kexec@lists.infradead.org; Tue, 17 May 2011 17:31:25 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4HHIkwX030677
	for <kexec@lists.infradead.org>; Tue, 17 May 2011 11:18:46 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p4HHV2JV057056
	for <kexec@lists.infradead.org>; Tue, 17 May 2011 11:31:11 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4HHUwan014036
	for <kexec@lists.infradead.org>; Tue, 17 May 2011 11:30:58 -0600
Received: from d27ml101.rchland.ibm.com (d27ml101.rchland.ibm.com
	[9.10.229.40])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p4HHUwZ6013886
	for <kexec@lists.infradead.org>; Tue, 17 May 2011 11:30:58 -0600
Subject: kdump with /proc/oldproc 
Message-ID: <OFC164F955.6ED93986-ON86257893.00589FE8-86257893.006037E5@us.ibm.com>
From: Nathan D Miller <nathanm2@us.ibm.com>
Date: Tue, 17 May 2011 12:30:58 -0500
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0416833441=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============0416833441==
Content-type: multipart/alternative; 
	Boundary="0__=09BBF200DFCB19788f9e8a93df938690918c09BBF200DFCB1978"
Content-Disposition: inline

--0__=09BBF200DFCB19788f9e8a93df938690918c09BBF200DFCB1978
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



Hello-

Has anyone tried reconstituting a portion of the old kernel's /proc whi=
le
in the capture kernel?

I had the idea while digging through the kexec/kdump code and it seemed=

intriguing.

It might be a means by which user-space dump applications running under=
 the
capture kernel could interrogate the old system, and identify bad proce=
sses
that instigated the panic.  In particular, I'm thinking of Out Of Memor=
y
scenarios.   We've modified our kernel to panic instead of invoking the=

kernel's OOM killer, but we still have the problem of identifying the "=
bad"
process while running in the capture kernel.

Perhaps everything could be accomplished using some sort of FUSE
file-system around /proc/oldmem and /proc/vmcore.  Not all the proc/<pi=
d>/
files would need to be implemented, of course.  In addition, each old
process could have its own 'vmcore' file for getting a core dump of the=

original process.

What do you think?  Am I tilting at windmills here?

Nate=

--0__=09BBF200DFCB19788f9e8a93df938690918c09BBF200DFCB1978
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font size=3D"2" face=3D"sans-serif">Hello-</font><br>
<br>
<font size=3D"2" face=3D"sans-serif">Has anyone tried reconstituting a =
portion of the old kernel's /proc while in the capture kernel?</font><b=
r>
<br>
<font size=3D"2" face=3D"sans-serif">I had the idea while digging throu=
gh the kexec/kdump code and it seemed intriguing. </font><br>
<br>
<font size=3D"2" face=3D"sans-serif">It might be a means by which user-=
space dump applications running under the capture kernel could interrog=
ate the old system, and identify bad processes that instigated the pani=
c.  In particular, I'm thinking of Out Of Memory scenarios.   We've mod=
ified our kernel to panic instead of invoking the kernel's OOM killer, =
but we still have the problem of identifying the &quot;bad&quot; proces=
s while running in the capture kernel.  </font><br>
<br>
<font size=3D"2" face=3D"sans-serif">Perhaps everything could be accomp=
lished using some sort of FUSE file-system around /proc/oldmem and /pro=
c/vmcore.  Not all the proc/&lt;pid&gt;/ files would need to be impleme=
nted, of course.  In addition, each old process could have its own 'vmc=
ore' file for getting a core dump of the original process. </font><br>
<br>
<font size=3D"2" face=3D"sans-serif">What do you think?  Am I tilting a=
t windmills here? </font><br>
<br>
<font size=3D"2" face=3D"sans-serif">Nate</font><br>
</body></html>=

--0__=09BBF200DFCB19788f9e8a93df938690918c09BBF200DFCB1978--



--===============0416833441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0416833441==--


