Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TgdLw-0001bD-9N
 for kexec@lists.infradead.org; Thu, 06 Dec 2012 15:27:09 +0000
Date: Thu, 6 Dec 2012 10:26:58 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1350981766.43974385.1354807618743.JavaMail.root@redhat.com>
In-Reply-To: <50BC4073.7060402@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Vivek Goyal <vgoyal@redhat.com>, buendgen@de.ibm.com



----- Original Message -----

> 
> Another approach is to dynamically load libeppic library - similar way
> how crash does it. No major changes will be done to makedumpfile code,
> except the addition of --eppic flag. Upon specifying --eppic flag
> makedumpfile will dlopen libeppic.so, which will have functionality to
> scrub the specified data. This will prevent makedumpfile bloat and will
> not affect the size of initramfs as --eppic is only specified during
> post processing. The distribution should build and ship libeppic.so and
> the procedure for building .so will be similar to what we have in
> crash.

OK, so based upon the most recent discussion here:

 Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
 http://lists.infradead.org/pipermail/kexec/2012-December/007452.html

Aravinda states that he will be posting an update for makedumpfile 
that will dlopen() a new "libeppic.so" shared object that is built
with the libeppic.a library.

The upstream eppic git tree contains an "applications/crash" subdirectory
that contains the code that creates a crash-utility-specific "eppic.so" file.

Accordingly, this new proposal will also require new source file(s) and
a build process to create this new makedumpfile-specific "libeppic.so" 
shared object.
   
Arvinda -- will you be proposing an additional "applications/makedumpfile"
subdirectory for the upstream eppic git tree that can be used to create
the makedumpfile-specific libeppic.so file?

Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
