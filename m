Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pfepb.post.tele.dk ([195.41.46.236])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2XfZ-0000HP-2L
	for kexec@lists.infradead.org; Fri, 08 May 2009 21:31:55 +0000
Date: Fri, 8 May 2009 23:33:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 05/14] kbuild: allow compressors (gzip, bzip2,
	lzma) to take multiple inputs
Message-ID: <20090508213358.GA18712@uranus.ravnborg.org>
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-6-git-send-email-hpa@linux.intel.com>
	<20090508074234.GD12808@uranus.ravnborg.org>
	<4A0493B0.3090204@linux.intel.com>
	<20090508204747.GA18041@uranus.ravnborg.org>
	<4A049AF5.7090300@zytor.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A049AF5.7090300@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, "H. Peter Anvin" <hpa@linux.intel.com>, tglx@linutronix.de, vgoyal@redhat.com

On Fri, May 08, 2009 at 01:49:57PM -0700, H. Peter Anvin wrote:
> Sam Ravnborg wrote:
> >
> >I did a quick attempt to integrate it in the Makefile - not pretty.
> >So I dropped that idea.
> >
> >It is mainly that we should not fill up scripts/ with small
> >undocumented scripts.
> >
> >Could you add something like this in the top of the file:
> >
> ># Find the sum of the size of all files specified and
> ># output the size as an escaped hex string.
> >#
> ># Sample:
> ># $ ls -l foo
> ># $ -rw-rw-r-- 1 xxx xxx 146 May  8 22:28 foo
> ># $ bin_size foo
> ># $ \\x92\\x00\\x00\\x00
> ># 146 equals 92 hex
> >
> 
> OK, I see your point (especially since that's not what it does.)
> 
> To be honest, how ugly would it be to get a C program in here?  Doing 
> this in shell is horrid, and people tend to whine about Perl (which is 
> perfect for this kind of job.)

Lets just include it in the Makefile and be done with it.
I took our patch and ended up with this - untested - patch.

If you are OK with this you can add my:
Acked-by: Sam Ravnborg <sam@ravnborg.org>


I forgot to delete bin_size - it is no longer needed...

	Sam


diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index cba61ca..827ebf6 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -188,20 +188,34 @@ cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 # ---------------------------------------------------------------------------
 
 quiet_cmd_gzip = GZIP    $@
-cmd_gzip = gzip -f -9 < $< > $@
+cmd_gzip = (cat $(filter-out FORCE,$^) | gzip -f -9 > $@) || \
+	(rm -f $@ ; false)
 
 
 # Bzip2
 # ---------------------------------------------------------------------------
 
 # Bzip2 does not include size in file... so we have to fake that
-size_append=$(CONFIG_SHELL) $(srctree)/scripts/bin_size
+size_append = $(shell                                             \
+dec_size=0;                                                       \
+for F in $1; do                                                   \
+	fsize=$$(stat -c "%s" $$F);                               \
+	dec_size=$$(expr $$dec_size + $$fsize);                   \
+done;                                                             \
+hex=$$(printf "%08x" $$dec_size |                                 \
+sed 's/\(..\)\(..\)\(..\)\(..\)/\\\\x\4\\\\x\3\\\\x\2\\\\x\1/g'); \
+echo -ne $$hex                                                    \
+)
 
 quiet_cmd_bzip2 = BZIP2    $@
-cmd_bzip2 = (bzip2 -9 < $< && $(size_append) $<) > $@ || (rm -f $@ ; false)
+cmd_bzip2 = (cat $(filter-out FORCE,$^) | \
+	bzip2 -9 && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
+	(rm -f $@ ; false)
 
 # Lzma
 # ---------------------------------------------------------------------------
 
 quiet_cmd_lzma = LZMA    $@
-cmd_lzma = (lzma -9 -c $< && $(size_append) $<) >$@ || (rm -f $@ ; false)
+cmd_lzma = (cat $(filter-out FORCE,$^) | \
+	lzma -9 && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
+	(rm -f $@ ; false)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
