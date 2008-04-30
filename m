Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JrKIv-0003u2-75
	for kexec@lists.infradead.org; Wed, 30 Apr 2008 21:57:33 +0000
Date: Wed, 30 Apr 2008 23:57:26 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Make extended crashkernel= syntax less confusing
Message-ID: <20080430235726.3f28b732@kopernikus.site>
In-Reply-To: <20080430112915.f56d8815.akpm@linux-foundation.org>
References: <a8d9dc7f83b9c34d9e0165503b323a7f32b00260.1209519344.git.michael@ellerman.id.au>
	<20080430112915.f56d8815.akpm@linux-foundation.org>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <michael@ellerman.id.au>, kexec@lists.infradead.org

* Andrew Morton <akpm@linux-foundation.org> [2008-04-30 11:29]:
>
> I'm a bit surprised to see the code being updated but not the
> documentation.  Were they out of sync before or are they out of sync after
> this patch or were they always in sync or what?

It was simply not specified. I propose the following patch to make it
clear:

----

[PATCH] Clarify inclusive/exclusive in crashkernel commandline in documentation


Reflect the changes from Michael Ellerman in crashkernel syntax that make the
end of the memory exclusive in the documentation. It was simply not specified
before.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 Documentation/kdump/kdump.txt |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -245,6 +245,8 @@ The syntax is:
     crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
     range=start-[end]
 
+    'start' is inclusive and 'end' is exclusive.
+
 For example:
 
     crashkernel=512M-2G:64M,2G-:128M
@@ -253,10 +255,11 @@ This would mean:
 
     1) if the RAM is smaller than 512M, then don't reserve anything
        (this is the "rescue" case)
-    2) if the RAM size is between 512M and 2G, then reserve 64M
+    2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
     3) if the RAM size is larger than 2G, then reserve 128M
 
 
+
 Boot into System Kernel
 =======================
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
