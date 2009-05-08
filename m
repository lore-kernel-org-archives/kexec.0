Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pfepb.post.tele.dk ([195.41.46.236])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2Wwv-00039O-VV
	for kexec@lists.infradead.org; Fri, 08 May 2009 20:45:48 +0000
Date: Fri, 8 May 2009 22:47:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 05/14] kbuild: allow compressors (gzip, bzip2,
	lzma) to take multiple inputs
Message-ID: <20090508204747.GA18041@uranus.ravnborg.org>
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-6-git-send-email-hpa@linux.intel.com>
	<20090508074234.GD12808@uranus.ravnborg.org>
	<4A0493B0.3090204@linux.intel.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A0493B0.3090204@linux.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, tglx@linutronix.de, vgoyal@redhat.com

On Fri, May 08, 2009 at 01:18:56PM -0700, H. Peter Anvin wrote:
> Sam Ravnborg wrote:
> >>diff --git a/scripts/bin_size b/scripts/bin_size
> >>index 43e1b36..55f2161 100644
> >>--- a/scripts/bin_size
> >>+++ b/scripts/bin_size
> >>@@ -1,10 +1,14 @@
> >> #!/bin/sh
> >> 
> >> if [ $# = 0 ] ; then
> >>-   echo Usage: $0 file
> >>+   echo Usage: $0 file...
> >> fi
> >> 
> >>-size_dec=`stat -c "%s" $1`
> >>+size_dec=0
> >>+for file; do
> >>+  fsize=`stat -c "%s" $file`
> >>+  size_dec=`expr $size_dec + $fsize`
> >>+done
> >> size_hex_echo_string=`printf "%08x" $size_dec |
> >>      sed 's/\(..\)\(..\)\(..\)\(..\)/\\\\x\4\\\\x\3\\\\x\2\\\\x\1/g'`
> >> /bin/echo -ne $size_hex_echo_string
> >
> >But I would rather have had this inside makefile.lib...
> >
> 
> It's messy enough as a shell script... it seems like baking it into 
> Makefile syntax would make it even worse.

I did a quick attempt to integrate it in the Makefile - not pretty.
So I dropped that idea.

It is mainly that we should not fill up scripts/ with small
undocumented scripts.

Could you add something like this in the top of the file:

# Find the sum of the size of all files specified and
# output the size as an escaped hex string.
#
# Sample:
# $ ls -l foo
# $ -rw-rw-r-- 1 xxx xxx 146 May  8 22:28 foo
# $ bin_size foo
# $ \\x92\\x00\\x00\\x00
# 146 equals 92 hex

	Sam

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
